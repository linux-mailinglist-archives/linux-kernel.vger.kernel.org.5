Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD527FB4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344278AbjK1Iye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjK1Iyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:54:32 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183B3E4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:54:38 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cb4d366248so4383042b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1701161677; x=1701766477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lEAT4IE+5TgDTGRd46y46TF/1k7v9CaLegPFey+I88=;
        b=cenDLV1U5hQL5ZNdo6tbK71SvJsFMgFfRJ2dwDHo3YuSVSfYQLc5kSEgIk55suVYVu
         kwp+hHc2RWEoHim+TMBqgWr8KlaFSG0yReJsSXcH836+qXgbFBiBCXshpExrrlGsYGXE
         Vhi4NGs82Z3KnlXe5ld3Rns9k+VlgzMHkqdkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161677; x=1701766477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lEAT4IE+5TgDTGRd46y46TF/1k7v9CaLegPFey+I88=;
        b=ai32f87A+I6QmnxMUcedMvbiaFtq/5L3uGpKjQaxjf5rfpJ6Y4xPBnHCphs3N5sJ0+
         ovRs3jrDB5SsJjXFzu2/HB399PT4fuL4j1yrG5ZCeR14rJXoNHHNv7QWnuVBU2LXHsb9
         TZc4MP5ZRNJLo2MXrnm6Q7pc6BDvnto4ck0cDR9QRz+syT6ibinvGuJd12t3jyf7Flz0
         VDiK7iToH627yne3uS4cTHfCRkYtlivSx4NRT3N6NNs3ksrv47pZQzvIF86ezJV610kq
         K76uHlFZyWnPhMQ1wjPHhjAFWkCD2AtyvMlYl06wmZTJFGbcqivE6bRJR5cXXqcmENrn
         pYUg==
X-Gm-Message-State: AOJu0Yw5T5XA3m4+62q5guhgOvcgjd/owbAq1YNagxDxbo5ye6GXmI8O
        ixoAHNrb0l0BGA47qxyBzL4Hgw==
X-Google-Smtp-Source: AGHT+IF/gklNETPClvaFFsJJAdl1ueNFy4xOPR3Sk46cb9O3ud98cElsa/5CMYbsEFz1SuE1IoxsJw==
X-Received: by 2002:a05:6a00:f8a:b0:690:d620:7801 with SMTP id ct10-20020a056a000f8a00b00690d6207801mr13935663pfb.11.1701161677532;
        Tue, 28 Nov 2023 00:54:37 -0800 (PST)
Received: from 179c313f1339 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b006926e3dc2besm8331807pfn.108.2023.11.28.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:54:37 -0800 (PST)
Date:   Tue, 28 Nov 2023 08:54:27 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
Message-ID: <ZWWqw7BVP5NfY/k1@179c313f1339>
References: <20231126154418.032283745@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 03:46:18PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.6.3-rc4 tested.

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
