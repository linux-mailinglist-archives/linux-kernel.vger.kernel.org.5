Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE38B7F4BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbjKVQES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjKVQEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:04:15 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B030D40
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:04:11 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so638436666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700669049; x=1701273849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck7nqrrJ5TqG0Izy74ih+BVldypg70Z5fbe63hdzuKg=;
        b=Y91dtkQUhjjfRBmCsOuz6gZMJQ0VFZwKxMTWLM3uy1G09NDOVmTEMr427nzegpm5tL
         Y9E265826Bhdrk4SNb7R1VOhW4CgdmKG/k4ihOHf7T32frd5XcKcZyaOXohBtIPJHEya
         uUg2r5tkm8c/RYUTj2cCQJrtV3nqFVPdnpODk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669049; x=1701273849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ck7nqrrJ5TqG0Izy74ih+BVldypg70Z5fbe63hdzuKg=;
        b=oscAyHlvG6/hEVE/c9ouj9oCjeUxiiaUC6ptjLZKpSaXTdupTVPdkfigymIEBOmzaR
         ceu3fdZtHiHkE4nKQlOTPTp6Ytf/mqIc+PkWKRz1r1PenZkM2oLojEAyOsGWjLqMKsgp
         UObRxk8hjAwRwwrvFN9HOl3Wy3h7NhVMVJggyEn4hqq2RqBhTfWVizUBVhJO7xtW6uUR
         MagdDSepspnxj1+Fa+p1D2lNFheOFPl52SYADq44pgeHjFm1o4hIotZrs0C3EtneJoWs
         su/1nCEI7YZOxfrI2b47c7JYJaC8GaSPKk2aqeS0hTr7Hf8z3cFng8WoqJU1Chjsspsl
         G4EQ==
X-Gm-Message-State: AOJu0Yyyki/wbktSiqP+QDX7z/pRSXFCef56xhoKM3VX7wsGw4Ygu/RS
        PC1GSglZJ90OANRzLKuhWVdg/45CS3fOWRhB9GIlg6QA
X-Google-Smtp-Source: AGHT+IE6932Cdf6DSJqgwWZUrBHNdIgrMTwDrtRUUhgz1UdPVJiShL8tzET4Z4XF13RpQ9/ToYLhcQ==
X-Received: by 2002:a17:906:105c:b0:a04:182c:9ea with SMTP id j28-20020a170906105c00b00a04182c09eamr1813958ejj.52.1700669049202;
        Wed, 22 Nov 2023 08:04:09 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id ca3-20020a170906a3c300b009fc42f37970sm4934133ejb.171.2023.11.22.08.04.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:04:08 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so17774a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:04:08 -0800 (PST)
X-Received: by 2002:a05:6402:3815:b0:544:466b:3b20 with SMTP id
 es21-20020a056402381500b00544466b3b20mr129282edb.5.1700669048191; Wed, 22 Nov
 2023 08:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20231122100212.94327-1-lizhe.67@bytedance.com>
In-Reply-To: <20231122100212.94327-1-lizhe.67@bytedance.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Nov 2023 08:03:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vb12_OKY5Vu1ZWTG6+innP5PkEnHFRPrwj2kOKnHCmag@mail.gmail.com>
Message-ID: <CAD=FV=Vb12_OKY5Vu1ZWTG6+innP5PkEnHFRPrwj2kOKnHCmag@mail.gmail.com>
Subject: Re: [PATCH v2] softlockup: serialized softlockup's log
To:     lizhe.67@bytedance.com
Cc:     akpm@linux-foundation.org, pmladek@suse.com,
        lecopzer.chen@mediatek.com, kernelfans@gmail.com,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 22, 2023 at 2:02=E2=80=AFAM <lizhe.67@bytedance.com> wrote:
>
> From: Li Zhe <lizhe.67@bytedance.com>
>
> If multiple CPUs trigger softlockup at the same time with
> 'softlockup_all_cpu_backtrace=3D0', the softlockup's logs will appear
> staggeredly in dmesg, which will affect the viewing of the logs for
> developer. Since the code path for outputting softlockup logs is not
> a kernel hotspot and the performance requirements for the code are
> not strict, locks are used to serialize the softlockup log output to
> improve the readability of the logs.
>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
> Changelogs:
>
> v1->v2:
> - define the lock outside the scope of function
> - add precondition 'softlockup_all_cpu_backtrace=3D0' in commit message
>
>  kernel/watchdog.c | 4 ++++
>  1 file changed, 4 insertions(+)

This seems like a useful improvement to me and the code looks good.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
