Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C299F7E32D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 03:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjKGCMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 21:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKGCMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 21:12:19 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EBB11F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 18:12:14 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so3064112a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 18:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1699323134; x=1699927934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yl+i+/Zm12KSu2JEDO2OvhxPRMv4CU9Hn46hRXkuPys=;
        b=koN5DtF5NedRqabFprBecBiWQi8a3HCtB6MO5TQ7VjpU8KID8c78jUg1fl+tgNCUmL
         /kNmRuPdzXWkbYYuQTA3tY9uHmX3+NUWNSxLTpDXlfvpjglOmR+y61Q1ZKUIo0sL8LWh
         +mbP5pPs0qWrR1wE88WvnuH7xXApEQxSpXWlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699323134; x=1699927934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yl+i+/Zm12KSu2JEDO2OvhxPRMv4CU9Hn46hRXkuPys=;
        b=aCDX67lUzyEVxT68TxXW4olXrOHVXeol9Uzw+UkdP622srheS2xL3BOP+buOdhycrt
         ZCQqoErtm6R8LHpHUrYGtENrv1NY3mYlhYq3wtWDDF/yTwj4JUiLjaqE3meeeDtO/e9s
         mEVjINBHyrwGbzrRb+FOt5smb7um1UOphYcnh72J76kepcF0CxdZh6tW/WEoqy1pfog1
         GJZUgHIegRDjn16KkRLV1uWBSsdgq8F9LNXpJ19K3jW7mE6VdJFIf1sKp9Ct1LLaCy2k
         a4hELhp3HyXTq6oydpfSSSf3K/O59bC73DIZYd8ZU04Get1uGlGu5kXg8FzuSdCBw6Oj
         l6qw==
X-Gm-Message-State: AOJu0Yz1L/Hn5lHcLXqkHRE0e+oZDSSVFP5Ufm7YhBKyfIrJtpw67lSS
        roXhmg10Gi6bWmY1GdxNTSzuPw==
X-Google-Smtp-Source: AGHT+IEdmPnG/wOAxpAHwbWAT0HofcxKZAgNSheVQUDbL7y4zHPyjkjZVLx/p0kiTC3AAF8uElMg3A==
X-Received: by 2002:a05:6a20:1595:b0:17b:3822:e5ea with SMTP id h21-20020a056a20159500b0017b3822e5eamr31125121pzj.19.1699323134100;
        Mon, 06 Nov 2023 18:12:14 -0800 (PST)
Received: from 8a2541e20aa7 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id u22-20020a056a00159600b00687fcb1e609sm6123026pfk.116.2023.11.06.18.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 18:12:13 -0800 (PST)
Date:   Tue, 7 Nov 2023 02:12:05 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.6 00/30] 6.6.1-rc1 review
Message-ID: <ZUmc9RaUwJhBXI+y@8a2541e20aa7>
References: <20231106130257.903265688@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:03:18PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.6.1-rc1 tested.

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
