Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C93803A58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbjLDQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344692AbjLDQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:34:15 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B940B9A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:34:21 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a959e3afaso23430186d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701707661; x=1702312461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2UEYYeWMDPMbmq1ryBMrDNxgGNwHML35Ik4c8wQg7Y=;
        b=Va2UhHP7bXEWOb2vqCq0bTrNUd6ask6hBfZ8BDEOm0GxD1CkghYSvg7XSODidoE86R
         UFT8vOwtywQD0SjglsxwglC+9O2Jh2A+kAQkErvN0yhHcrPrPFhjgnqFOPOsLzSJlMzD
         8wKjPXUdyICF4LPIlr92RWm81jVK086gcg51jrcVAGmr7RKmCW7J3NT5ZRmbasqHyFtr
         vAeuhZ89Qbrw/BNQxl526kXHejVqeDqgb9N7AV7koxr+x/SmpF1NAl188CKSVWBJEvEM
         OyoV7/b0Ip6cEhcBlfbVw7I4u1L7hk9KbDGxGoYI/I44G/sxkb3j6BU+wvUhIbhmqJHS
         Zlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707661; x=1702312461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2UEYYeWMDPMbmq1ryBMrDNxgGNwHML35Ik4c8wQg7Y=;
        b=CLULz6A7qiTcD2atVqsrDlkqMSJ4HoLvq0d8ei8nStpFURt03QzqrVPER6vrybgWRf
         fKuWUFiB6o2dlUsHzNPkoT9IL7rGVH4WojRzeRXO7tBeIHwqDda0TIZ+VhFcMtoq1Gu+
         bX119hnI4WgjiNAsunNWUET24UDY0kFtvmt9BdadDovsb/T6KqMYKUvfpR+AQodAsUtP
         X64b2strCarx5yUybQlsCp3pUSbtqBjW8IeqH2dAIah9w4REVsDf7xr1f95PYyKtXBAv
         8ikYFbF0uo1gT87glMOwm2IV6Wrd0359bCpGo3sSeN+r3H7NUAQfLdT61K/iaPPVCO/7
         3QhQ==
X-Gm-Message-State: AOJu0Ywo5dPOdjLsOmMsz/cncUu9lMV8I3M6qcYpJMWXKRT/ITDFZLHE
        Ap8o0FDRzLZavcPyF2xVrgv7+v4+vKOaWniableBFnUgwAPyjx89
X-Google-Smtp-Source: AGHT+IHFlH4v9sd7JZSQX9UbKS8wUOElz0PMTMcq2C3eQ/tIYF+Rc4A+NNzPoP+tlg9PZSVhAIi85YVehTx2Ctd2CnI=
X-Received: by 2002:a05:6214:e62:b0:679:e320:e5bf with SMTP id
 jz2-20020a0562140e6200b00679e320e5bfmr5025682qvb.34.1701707660887; Mon, 04
 Dec 2023 08:34:20 -0800 (PST)
MIME-Version: 1.0
References: <bfba8d2c-646d-4d62-9f71-8e388e70f782@soulik.info>
In-Reply-To: <bfba8d2c-646d-4d62-9f71-8e388e70f782@soulik.info>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 4 Dec 2023 17:34:10 +0100
Message-ID: <CAHUa44FEkdtA+4AuoQnNEnObKzcUX3qkFD8iV8Z_pGJ7ZPWw2A@mail.gmail.com>
Subject: Re: optee: os: toolchains would include linux target macros likes __linux__
To:     Randy Li <ayaka@soulik.info>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org
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

Hi Randy,

On Mon, Dec 4, 2023 at 2:39=E2=80=AFPM Randy Li <ayaka@soulik.info> wrote:
>
> Hello
>
> I wonder why Optee OS would use a linux target toolchains but not a bare
> metal target(none os)?

I guess it started with that we didn't want to download both one Linux
and one bare metal toolchain. We need both AArch32 and AArch64
versions so it doubles up.

>
> gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux=
-gnu-gcc
> -dM -E - < /dev/null|grep linux
> #define __linux 1
> #define __gnu_linux__ 1
> #define linux 1
> #define __linux__ 1
>
> That makes hard to share a header files between Linux kernel and Optee.
> We like to pass some structure in SHM, but optee don't have all those
> Linux types likes <linux/types.h>.

Surely you can define a .h file in a way that you can include it in
both environments. We try to stick to ISO C.

>
> If optee didn't choose the toolchains for the Linux, we could easily
> decide which part would use for Client Agent(Linux kernel) side or TEE
> OS side.
>
> Why we don't use bare metal toolchains ?

Feel free to do so.

Cheers,
Jens
