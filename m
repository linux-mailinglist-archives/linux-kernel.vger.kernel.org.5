Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624917E0D2A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjKDBji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 21:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKDBjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 21:39:37 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC6D42
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 18:39:34 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49d6bd360f8so1124377e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 18:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699061974; x=1699666774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbsOnSulgetONYUA0TZPEC+3loDt5yYTbkufBTSNzqk=;
        b=XoXbHCaprI7q7kF9Nt2eyUAGZ+bokCZzl8ceFZr+ImBa2NODdue+wxmGkqlPbQyV+V
         G+9HM6eSXhW4A+jyn7tLhjBicyrN+VK0eDjlc8ACAE1Y0wx4QYr2gb/ZQrAHCZSX1GwS
         dtyq2ofOWU8lk8jOaVsCgwoB1lrlzykcUfeliTujTxoFMX1gzt9dZGtydRIhACZRJOwO
         y9BwYPd0pYr+ZBoTghstRMeQjHVToAm4X7gtIlUqRsvDWJQ288sE3HYCBYAJzkG9llOk
         piD2rQueyLYM/knEWLBvlhTm0iphmAtBhR7FIyRGplIEGYR3aKtCLPXe/uTjHNmpTU5T
         kXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699061974; x=1699666774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbsOnSulgetONYUA0TZPEC+3loDt5yYTbkufBTSNzqk=;
        b=plXloAXTW/5+cJ/FVVNGtuAErGHAbZUJleFOD73dfs0Wy7GERH7K/DAMlNBmDITOwd
         nx8y9pWfRA8cxp89ZM1jBHnmHncitYRX+7F1L9MsAcRA61fIAqJglCF2O6c8TaX1rAWM
         zz19uPSz3+D+atLhda1nHg+jLhYDY4CeDjeLsBSL/cahm0v0slmpqpTkKGR2jtAhjTBW
         lb9zKBuwSwgg/GrXkXmI+Fn0KJbLhq0B5wI2HTvq4mJkUYJrbcG4mo47pab469VYMj4I
         22dNKBvYXmw7xJI5d07XqNcFw7tPavDOteD11GHxlPZ6ynIglRA6vmR+wM1KpjlhZNnr
         vcfw==
X-Gm-Message-State: AOJu0YzUKGOd8qRrEeA1NoMQuE3QgCEFE1ep+rmPbCj61AcD8SyF/ffF
        iuMg/LXoqlAZZIfH7XPTbK97LI+u/GN3aQwldvM=
X-Google-Smtp-Source: AGHT+IGrOQIenWqS3lJ0yK2pTL+C4jWLtnYliuD+u3xW1XaxRpQ4sGe1oLeMXsOjXe6+57sL21lhSiB7mfq2tymaJWY=
X-Received: by 2002:a1f:2f81:0:b0:49a:a3ee:d280 with SMTP id
 v123-20020a1f2f81000000b0049aa3eed280mr20678842vkv.16.1699061973694; Fri, 03
 Nov 2023 18:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-10-lb@semihalf.com>
In-Reply-To: <20231103131011.1316396-10-lb@semihalf.com>
From:   jim.cromie@gmail.com
Date:   Fri, 3 Nov 2023 19:39:07 -0600
Message-ID: <CAJfuBxyvX41CCb27LWMDxZrQ5wwhuw36F_VmXyB3F9q7r1Kt2A@mail.gmail.com>
Subject: Re: [PATCH v1 09/12] dyndbg: add trace destination field to _ddebug
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.co=
m> wrote:
>
> Add trace destination field (trace_dst) to the _ddebug structure.
> The trace destination field is used to determine output of debug
> logs when +T is set. Setting trace_dst value to 0 (default) enables
> output to prdbg and devdbg trace events. Setting trace_dst value to
> a value in range of [1..255] enables output to trace instance.


should we do some expectation setting here ?
255 is something of a promise to more than tom,dick,harry.
16-64 is more suggestive of a limited resource,
might encourage more judicious use.

will look further later
