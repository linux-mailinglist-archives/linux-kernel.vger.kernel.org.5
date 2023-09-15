Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C3B7A2546
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjIOSCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjIOSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:02:37 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A156E69
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:02:32 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3aca1543608so1597394b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694800951; x=1695405751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kReLlOpbjXtB6mBGpHGtzlOr1ohS4HF7Y/gf2MYN7pQ=;
        b=Ebk9KhPkE8KeKb1zthzI6SQRuW9/TJ8Ku4wLMddSu1jmnEjLUYBPM48lSO+a1iujp1
         5jmJhioIkEVPJlW1ssEU4NZGu+SVma5yflgYVaxUcPGpLmxwfNYXf0Wfyb/hkJ33KlWv
         OhyNGIcf+pq4hM51PhqlZsRayvzIc8GPNxejTvwfTOvg6UjgT0rF7iWmMdJv+UwQTnAd
         ZecRtd4enoFXQYJEnyhV1yTPvwyyl0sSWTtPzW+UW8JrbcUcFlbqE9/IQC+w7krnARa2
         jzYexftIDk8nKTv/N2Qv9qZI4Kp0MZh9lBTYlyB9ZROC+vOBmsTyVMmYYLz8EaT/NC0m
         dR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694800951; x=1695405751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kReLlOpbjXtB6mBGpHGtzlOr1ohS4HF7Y/gf2MYN7pQ=;
        b=ZRSroyC0GTJDoyFHGqZk5xRwuNxuzcmh68jhKC6VMyX5XyNcOIH7I66BaVABwXnjvq
         xIetnOV/V6bJo4r4pWZIZpCa2szTFksrd6zCVGZNLG7AuLaH5gzXBkW1vlSlpya3wVnU
         xol8aKbbT4oYUta8ZLnFwG+2D2y7mgsjpAc/x8TR2DebVnhY9s/bIfbB9tc7/RHpw3lE
         aoynQZ52iOembu6nYTWpBvz3SYDAf9oYPUAjI6Ng0MlnRJ0ILm9cmHyugkQo52NVov5Y
         iaDprPCRnyoRbWYfBZSCbH+jwvsITHDG3h9WWZ0tJ9hR4wssrdBux3BVa071+x+Pvmsu
         kQqw==
X-Gm-Message-State: AOJu0Yx40KiAoEEZTSRMOx5edzQ5bDZ/BDYxdBrtaJVaXX9zxLWIzwu3
        0hW3UrYwSfd4kTv1NRgs5PZ74+7GKhmUFJuzeR69v9GVqLY=
X-Google-Smtp-Source: AGHT+IH0uBgeBSM8lL6ryyd8G+J9lB7n7bkO4cvph6pJxBMI9hdyojq4wlmuUOC6OFzgk8wJci/63Ae2vYvkjoW6ZeU=
X-Received: by 2002:aca:d11:0:b0:3a9:c2d6:41e7 with SMTP id
 17-20020aca0d11000000b003a9c2d641e7mr2442267oin.54.1694800951243; Fri, 15 Sep
 2023 11:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230915154856.1896062-1-lb@semihalf.com>
In-Reply-To: <20230915154856.1896062-1-lb@semihalf.com>
From:   jim.cromie@gmail.com
Date:   Fri, 15 Sep 2023 12:02:04 -0600
Message-ID: <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 9:49=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> Add support for selection of dynamic debug logs destination.
> When enabled it allows to configure destination of each callsite
> individually. The option adds a framework (described by struct
> ddebug_dst_ops) which provides flexible means to add a new destination
> for debug logs. On top of the framework support for trace instance as
> destination is added. By default destination of debug logs is syslog.
> Syslog can be set explicitly by using dst keyword or is selected by
> default when dst keyword is omitted, for example:

A while back,
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
proposed these patches:
      https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurc=
h@axis.com/

his approach adds a single flag, +x or (my pref) +T
which sends the pr_debug to tracefs, independent of +p.
Steve Rostedt offered feedback on one of the versions,
and one could read that as provisional acceptance.

Ive worked his patchset since, it is here:
https://github.com/jimc/linux/tree/dd-trc-11
(it has some unrelated bits too)

but it sits atop another patchset:
https://lore.kernel.org/lkml/20230911230838.14461-1-jim.cromie@gmail.com/
or for git remote add
https://github.com/jimc/linux/tree/dd-fix-5i


syslog and/or tracefs seems sufficient, do you have a 3rd destination ?

thanks
