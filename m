Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99AA805436
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbjLEMdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjLEMdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:33:12 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31FF122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:33:18 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c66988c2eeso1944100a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1701779598; x=1702384398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEIoNxF1mrTxn6HSnGvsWW6Lj8x4H49yQ7QLKLr4Log=;
        b=n/nzRJckdKzlKLz/Fw+PdIfoF06D1XCEHqNVlNawTXFb75xThQuXafG5lpRRLxMlUG
         TuWlgcqYm/sl52dTrkkVYu0002PF2po1hlmgKo+LC7aDQjXiJ1mq35GJk91ZgFqVJFN/
         zoo5HvPfhZsSzod5irg/qF7GNK343GibjTOFQvSArQ4bvhvghW79sVSl5hgJDLhy2FIx
         mLmJR/uLmaMIg0lENyeGTkulrGqBAJRUJzVgT7Tg4byfFjcWV5C41I0FvhJHqbNWEHn/
         zIHCrJmqZu/gigDy09ZiNFcSidr3iJvfZwrLlMSrr+ouIlHllRmNe9v5CLERO8yoojxU
         GJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701779598; x=1702384398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEIoNxF1mrTxn6HSnGvsWW6Lj8x4H49yQ7QLKLr4Log=;
        b=E44wxIFDBK4Gp0fpuSIflHFwlUr4Y5E1nAjeq8GvgbW0oMUbzThJO8OLTc7BE+ZK/7
         pFYYRrUUr0eiVvzQCjlwTvmWxD2SXEX0QmUNMjUoT373TdXk65e1OVHh813SfP1feeqV
         5gxxX/3lcJrTHNp00TyHt+mBMcHz3sitxHsV6LBNF7hvH0eDqZEqiZID/3E3hQRjrEsP
         KB9KVKKF5fV4v91LyogfStoA2Kd3sf/c+OJJC70PUnZ6EJzKYBCMBGgSNafnhaYSMRDi
         nfIg7yBL9olMYqwW9hpmVcsTSBI6wu+GALLmVaEJz4EUHAtmMVjq+jz7BMZnPdow6qPj
         o1HA==
X-Gm-Message-State: AOJu0YxTZQSLCrc4kFfXgaWPCr0d94QHnAXEiK4V+15ETqPpRFiZioZr
        NoqdsmE3CmUbnE9n+5WzFaLd9xWhuiLRwUL294P9VQ==
X-Google-Smtp-Source: AGHT+IFmxCGot2OM6nlx0JyueWaxvb9J9j2G+CNFzUEiV92bxkdPmAFtiCPtGPO2TgeTJq20Tc7gU4GzYbn/pv7Fc7o=
X-Received: by 2002:a17:90b:3ec5:b0:286:6cc0:62a2 with SMTP id
 rm5-20020a17090b3ec500b002866cc062a2mr1346799pjb.33.1701779598021; Tue, 05
 Dec 2023 04:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20231205031535.163661217@linuxfoundation.org>
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 5 Dec 2023 21:33:06 +0900
Message-ID: <CAKL4bV4WEwo8bnVJcvAQEOx4yF5kcDtm_apaX6gwtRHPgM6J1Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Tue, Dec 5, 2023 at 12:21=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
