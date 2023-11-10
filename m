Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0797E802A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjKJSHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjKJSEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:04:51 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF139CF7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:52:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so3390791a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699627927; x=1700232727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iULbtmAoZzZGFHJxbVd5BQQ7kVAPJ0KhBFo9xBA4PlY=;
        b=dxECcAlP1sPOYpcKapM/O/coLBBgoMUf/7SNpYX3uDGqWfowePWMREjGYlfWs1KBqR
         YJGZn57in0EsiLSLVJ7Hq3H4A8plB0Gil7me4dBVuixSBULs86+I/UwNf2Ik+/9GSkFs
         u7bM0wMpfzV0KzipRYZRKBzX79QV8tluzMHLo/RaGIWejufucVuJ61LTurmq1Gahxcq+
         cKwgGjivLthVKR9LPU3MyBq3LelaVuDVJj5HmKBNxa4urTPYOfKjzAZLQ/1wzZhuqL0c
         iXjqLyJ4Xi8E3Pn+LW9xIbRyxwSrBpLdCEA8KvYZujD3RpChGIIA9qP509C+5ZrgYR9w
         /wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627927; x=1700232727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iULbtmAoZzZGFHJxbVd5BQQ7kVAPJ0KhBFo9xBA4PlY=;
        b=eusBxmU4BsN4hNO3pvl8b8lQ4qbxBrl5pZ6+7l3eQwE9L0VqRsISYnFn0ggU9Dia0a
         XtLYoG1sC06xb7YyGucuVKnmxxZiefSdvtA2ZyTF+LyZ0cbGGC0BYctbQnrWQzFFoSEP
         luGCC46/+a0Ba+RyVAGULB1cLhvf2ih3dCHK1Xv0c5V+Ts78zSx9Fi/1ChUgs/QZBGk6
         4jnplXM3iruRSe9NZOob3vTU4EeWUVMf4kyBCHTa3n90ofUXhaZcPuOFvNj68KykdN7s
         lftNS+82IwQ19s4jucT3AvKZHzvlePBLgVe5Lhh4xQ/cWHB9N03PPQS/kgR9NzFw0+dh
         Wokg==
X-Gm-Message-State: AOJu0YxRhYVNQNAxXOXueGbYFdrMvn1pw0l4C1tlvYZMQ6664FqAjuZh
        eOR2GSAS13npTc2UlGlEN/y94hWpHsWWBMk+vnAX
X-Google-Smtp-Source: AGHT+IF9G07wU6oQwSIBZJtTxTejhodItxPYJ4Cy7mlO8IlOZoNrwyNEq49nEpyTbvHWqvID56FHuc+SK1sKIR8oQoc=
X-Received: by 2002:a50:9ee2:0:b0:540:9be9:a849 with SMTP id
 a89-20020a509ee2000000b005409be9a849mr7639133edf.1.1699627926953; Fri, 10 Nov
 2023 06:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-10-lb@semihalf.com>
 <CAJfuBxyvX41CCb27LWMDxZrQ5wwhuw36F_VmXyB3F9q7r1Kt2A@mail.gmail.com>
In-Reply-To: <CAJfuBxyvX41CCb27LWMDxZrQ5wwhuw36F_VmXyB3F9q7r1Kt2A@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Fri, 10 Nov 2023 15:51:55 +0100
Message-ID: <CAK8ByeKCcmd7-8Lsv5jQB-Po5UYeFRD-jB0e08BNBNUJ01UhNA@mail.gmail.com>
Subject: Re: [PATCH v1 09/12] dyndbg: add trace destination field to _ddebug
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 4 lis 2023 o 02:39 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.=
com> wrote:
> >
> > Add trace destination field (trace_dst) to the _ddebug structure.
> > The trace destination field is used to determine output of debug
> > logs when +T is set. Setting trace_dst value to 0 (default) enables
> > output to prdbg and devdbg trace events. Setting trace_dst value to
> > a value in range of [1..255] enables output to trace instance.
>
>
> should we do some expectation setting here ?
> 255 is something of a promise to more than tom,dick,harry.
> 16-64 is more suggestive of a limited resource,
> might encourage more judicious use.
>

How about making it configurable in kernel Kconfig with default value
set to 16 or 32 ?

> will look further later
