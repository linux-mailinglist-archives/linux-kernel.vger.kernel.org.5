Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4157F9E10
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjK0LAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjK0LAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:00:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CCD12F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:00:38 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-285afc7d53aso1013070a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1701082838; x=1701687638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmt2hlpJeJU9hnh5GTsTezQO+y0eDA0IJjENIi6FxVw=;
        b=NR9+Ky7qGj/ZUHbaiblM2wYGtYrKVSpf0XFX+hPQayV3/QC2er3CW0/zK4Br1u0Dzb
         WU+e2n5WOJBG+NbWHtZI0gMecgcyep6fR91RqSN4KMZlnYLgNaTrug1c/q8eCQDmybmW
         S55BPtIPfB3leRilQ6ZPjex85M0qxkFVQ1g8SYYE2n56XmUufNbsuWakWOWRJD9HVoRx
         1vG/yrJl6AnHafbWk/2aHsevTF4kSZtMKyflWExFK4slNe+9VV8orUmVZO9H132p12FQ
         jeu6au/l3tnnkmhQUgdKN2l93LOOL5HUtA5hXABfYsHnGvL2Aiy5V1csipnddm3BM6On
         nW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701082838; x=1701687638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmt2hlpJeJU9hnh5GTsTezQO+y0eDA0IJjENIi6FxVw=;
        b=gbHR9gO4MpHAA20jOn00Yc9vvqldG04S4x8RKCeSuc8qxUiUIbip9NhU2OmCk0A+eN
         ZXs5yauQAz07i40J8sq/SyKTfJKVC4ZssNYkueZGgKe6LCmGrCa3ZX+KIBcO9QV4pWRG
         tVvJd/vOSllbiAP2txyyJEPSJCI7vmKeigNSrlSCcbzZSPLci9MeVy4r3BSK7ajdLFK8
         3tAJ4hZvhvM2DwebzB4Xpvk0TApxsdHmbKF+z+AfXKPG2eigfOw17EqooRuz5VigfEHv
         L4UmpAllcYrLuQfDxSrAYOC5hNJ/giOnt1gLLHsqmbxVFTgsz9LOSGXqEe7P6CXRC7bJ
         BN/A==
X-Gm-Message-State: AOJu0YzKZdLWCW8dp5NRyeRCFV/tBjo9v+dvR+Cpi45Oq3ZGEfOgv5hR
        sIbMExVCtrAfG8TbVBsLX9DJcK3NOfCcTY76Ue+uqg==
X-Google-Smtp-Source: AGHT+IHsdtBGvlYv4OiZ3uPa02d1XAJd97bFDgH/OzG+X8+tTIgs9DaNMw/VYEXl8nRn0KWY/ueQrTyUkogFrTpuTbI=
X-Received: by 2002:a17:90a:e7cf:b0:280:cc2b:d5be with SMTP id
 kb15-20020a17090ae7cf00b00280cc2bd5bemr9756711pjb.15.1701082837063; Mon, 27
 Nov 2023 03:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20231126154418.032283745@linuxfoundation.org>
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Mon, 27 Nov 2023 20:00:26 +0900
Message-ID: <CAKL4bV71Bc_2zfi=WSrgse-S_M7qvb0M9pV=U7CofNu4-WjiZg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
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

On Mon, Nov 27, 2023 at 12:46=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.3-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.3-rc4 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
