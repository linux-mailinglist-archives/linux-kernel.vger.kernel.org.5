Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8349793A68
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjIFKw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjIFKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:52:28 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382C9E6A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:52:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68bec3a9bdbso2100839b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1693997544; x=1694602344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25AzewrCxhn5VAJTnf4NrbRvqDvucF8KzATEUTz04rk=;
        b=FtSj0QcanaCkbfVFWHD1hBkH3CIRU9sGYIZTeDTC2ApxyQOMDGQvZWAvTZ96xZrg27
         sXlPgBcVraDh8MVQv49BehtnKK/OSB8bEMIgv3jhbRnp7sI0AcetLboMabWUOgry1UXR
         Y5Hx1frr7BeOnBawbLXqyxirRHP7GP17vgihk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693997544; x=1694602344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25AzewrCxhn5VAJTnf4NrbRvqDvucF8KzATEUTz04rk=;
        b=ExDBLKECU5adcfElKRfru2TLyS3ehZt1K0ZRvo3AfkGz7DEMGRifwanxu1pE6rMHTo
         v3GCepNTW1sc2VuxS488KWNA5EJ/pPViqHjJbq4RYHBFFpCNGpUG155GhHdW1d4Gki4l
         R15trkPOKC+QAwcbK+G2SRvSEB5JLuixj6AE1o/kK5imPW3waxc6aHNyabX3Exe+/p2R
         2GYOyh9MJTWPUTJrPRYMwEu0e72c07i6aQJry1l3L1k+vdulPCnUhLafKBPUGxX8zFE8
         rXng8DnHXXvBOw5Cf+xmWxmI3HbtiGa7A/60dgfFilMso1ebqqn47BsSqLxn5Qiweb2v
         ZePA==
X-Gm-Message-State: AOJu0Yxff+vjA37X8ZPwO2H8JKhm3Pwhpf4o1K5xDi0DYSahce/0C7Ic
        xsMlENskhoLOrc5U36B+YL6K2wXw0A7RUk8m1j2+7IMn
X-Google-Smtp-Source: AGHT+IE/L4KsJkWscRV8gObXAFvrgi3HthktxCW0Ao5WvP3mNZLeiR941VTd+lXO2Lk2HtEScIqD3A==
X-Received: by 2002:a05:6a20:a108:b0:14c:6404:7c5e with SMTP id q8-20020a056a20a10800b0014c64047c5emr16905385pzk.24.1693997543604;
        Wed, 06 Sep 2023 03:52:23 -0700 (PDT)
Received: from 9e79d0ab4c28 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id fm19-20020a056a002f9300b0068c1ac1784csm10587729pfb.59.2023.09.06.03.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:52:22 -0700 (PDT)
Date:   Wed, 6 Sep 2023 10:52:15 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 00/34] 6.5.2-rc1 review
Message-ID: <ZPhZ31KW+q9AuEl+@9e79d0ab4c28>
References: <20230904182948.594404081@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 07:29:47PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.5.2-rc1 tested.

Run tested on:
- Allwinner H6 (Tanix TX6)
- Intel Alder Lake x86_64 (nuc12 i7-1260P)

In addition - build tested for:
- Allwinner A64
- Allwinner H3
- Allwinner H5
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
