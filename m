Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44237EFCCB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 01:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjKRAxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 19:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjKRAxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 19:53:05 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D8AD7E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:52:58 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2802c41b716so2297512a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 16:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1700268778; x=1700873578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KbIt0RC8fwx+JBBK19uY6YIBtCeUq3tJXkgbuxVQjvo=;
        b=e4JtiuCI277J3joHRWVUIMTCQVVe+AeTzuLs+wtgzFyvhsdLmuP5HSM8h4/e1Fjy54
         YE/o9/m8qg8EMysKxKSZjhVmrHXpRYdCEOdM3VJcAvhGrAfFyI3RyMFF+t2NpH372egK
         2hsesW76ss/KktOOWSX1HQ+b5+IQ6yESt7BTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700268778; x=1700873578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbIt0RC8fwx+JBBK19uY6YIBtCeUq3tJXkgbuxVQjvo=;
        b=tivkMUujMrvvtnkrbHMiT/lImSXSjGb4C8Cl22tUkJXkj7QWWh7NNaTugPZlCJpyC7
         Bu7/fQoCZY6XR5D/nFAWPiHwNOnx0QmFQ8Kzm98CqeCSQi4zwPZK+XzbqqAlxaEfDNSX
         XTpLvjY+Lss7E/kpxmoNu86O+NGTk44+evaADFwAQ7yPsOTPDSUyaFgjgJtZJs+QlL+k
         VWY4bmcp4bGqnowWRfTLAv6PRp61e5Ey7JGAaE3whgD4JAH1OeZEJ1xmunozKCeSSpwn
         xcEroCuyXP0mXVPdc1Xj6sGrJFWMkHeY1X+R5Q+9PYVDkOqvi0gJA7mCKG4/cEj4gbES
         ycvw==
X-Gm-Message-State: AOJu0YyIoHlCnCEn+/57uT2V3EOgc2b7Q6iQfCd1IiC2GhUi2BVuq/H/
        XRwCTaeKe993SiwNCjMitxMRcA==
X-Google-Smtp-Source: AGHT+IGIkXYGN2lacDFlwicQRn/oQ5YpY77jSOvHRUnSKCFJXI6necgBdoFPjPospalwTJlRyp2uXA==
X-Received: by 2002:a17:90b:3851:b0:283:21d3:11eb with SMTP id nl17-20020a17090b385100b0028321d311ebmr1191273pjb.3.1700268778202;
        Fri, 17 Nov 2023 16:52:58 -0800 (PST)
Received: from a20e1fa70cf1 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a9bc100b0027d219d3ac6sm3734494pjw.47.2023.11.17.16.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 16:52:57 -0800 (PST)
Date:   Sat, 18 Nov 2023 00:52:50 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.6 000/603] 6.6.2-rc1 review
Message-ID: <ZVgK4g+uTiVQsbF5@a20e1fa70cf1>
References: <20231115191613.097702445@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 02:09:05PM -0500, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.2 release.
> There are 603 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.6.2-rc1 tested.

Run tested on:
- Intel Alder Lake x86_64 (nuc12 i7-1260P)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
- Allwinner H6
- NXP iMX6
- NXP iMX8
- Qualcomm Dragonboard
- Rockchip RK3288
- Rockchip RK3328
- Rockchip RK3399pro
- Samsung Exynos

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>
--
Rudi
