Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213C0800B8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378963AbjLANPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378947AbjLANPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:15:01 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A856210E2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:15:06 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfc3f50504so4322845ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1701436506; x=1702041306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gvg9SzsVyrg1+cSkW8ZTDbtaOZGy4u7v+r+pXKw+7Dc=;
        b=IjcCfwzZxvQlK5LOPODZESjQvSi3CpAJh9O1qB+ZfEs85CNEsnI1FYmDyruZ3qyzfk
         o7447Y94YiZyDAscf2iAQXR2+4qmANUTzgpT43cxBEJ+QreWI7HDvNxJ7IB0gUR4j0XK
         GcgOj4NZxfHybZeYmPvbFZExY2KTbB2NnDdKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436506; x=1702041306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvg9SzsVyrg1+cSkW8ZTDbtaOZGy4u7v+r+pXKw+7Dc=;
        b=nHi3uYUmzJ7XKwLUvjdDWsD0YfVlF8OKefh0eENsHDn+sZLpbKfwZLrY6hY6PMxxVX
         D/YdQQQnOjDWxfOzwwXlzryO0+8QiJ+/T4tVo+ek4QIrlKJuTGLWVlxBtWPbsRfaFJtE
         KAIeXt6lL5qPmsRmlbGcfefk9SCLKgrRazXkbj4fzWZzPxe1/sXg2vDa4L6sJ2/mu7Ze
         NlcWy/GUBhGb8IE+J3+ZaJ5xoARmeMGSBANbMryqBLKrmsJws3H+gRKo0VhjL2GGI/We
         o9xsHKQgLthaorC16QBpx7WW3DyHd9Lvc5LiQT14CSYbGa1igpyUZDPdms3xLgc0hy0Z
         Ecrw==
X-Gm-Message-State: AOJu0Yzj/3h7QkSfcrcdMO+BlCoXEkEIYds5Y7aFm+jNNjyi6gTneWSq
        L7JvEYyLxgrcUqj0VlVkBVxeMw==
X-Google-Smtp-Source: AGHT+IGkj80lTOlpVv7cLv0ty3QcpEA/UEzBSdkHRwLlyy2C0DVPD4e+YQqHJcf5zZY1pKqlA911HQ==
X-Received: by 2002:a17:902:aa02:b0:1cf:fe32:634a with SMTP id be2-20020a170902aa0200b001cffe32634amr11199468plb.43.1701436506057;
        Fri, 01 Dec 2023 05:15:06 -0800 (PST)
Received: from 8bdb44144243 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b001cf59ad964asm1575312plb.140.2023.12.01.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:15:05 -0800 (PST)
Date:   Fri, 1 Dec 2023 13:14:55 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
Message-ID: <ZWncT50EfYHdJS0x@8bdb44144243>
References: <20231130162140.298098091@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:20:47PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.6.4-rc1 tested.

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
