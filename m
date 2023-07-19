Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3060F758CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 06:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGSE7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 00:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGSE67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:58:59 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5429C1BF2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:58:57 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-345a76c3a2eso29482375ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1689742736; x=1692334736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xx/nlFjtu4ARcPKwXdYmnkb99UM/dQKiVgI7KMRPIGM=;
        b=VQaYGcC5+WLtUiJAamvCvUXI9h0WDtf6H6gPpm7L4TXt2YDHaPeg7SDQCxXAQbapnG
         5OWlkvmOlZISqLIn2WmroOJdMHvOPMrIQhrfqqySiwNhqzeHV9t6UE1DcUx6Afyx4uLw
         nsDXqp5hLQXwosWTWmykXon17uRtDXf5Mt0UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689742736; x=1692334736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx/nlFjtu4ARcPKwXdYmnkb99UM/dQKiVgI7KMRPIGM=;
        b=bqtAdqZFTZhuC+WXZOEB+GPcAqAaPNa836x/OZMkvFWWweE+i/4coV8rA/jqKoHXS4
         NXgt60n0mjkcGNrEqCXfgWqBOBWcB8fX9r56c3oD1ZTK+nqOgy/yWQpRpJAMb0HRWZ0m
         jMuioebRR2mroRLyBWVy2VgiEHia20tYxfpXr3/hx8VDu0ERnPg+4QC61yc/a3dl3bla
         6KYjhwTjAwstrKhn+BeCzXk79aimcS6LpoO/ooazb8ZdLkAdI/t7i/QKDg1OIiYgKpj2
         HDuR6jzpttZlDLHRrRvjo67wqgzQHkBCIFwrgLHWzFhvcv1KN4UpZDFRqIgEYeEL2b6B
         ki3w==
X-Gm-Message-State: ABy/qLb7cPaP0I818TK9o0yk3XRUilNGrSWxxfceOHfAw8dfNweGDPrr
        QYpCXz+CV2WF5PMjOdpTctRFDw==
X-Google-Smtp-Source: APBJJlH2mIKMnmpMa5BwTtRfkel54/muJVaPz4sXZLak232jtyoBEh3mzEjcxLrSHDpjK6NTMIfmJw==
X-Received: by 2002:a05:6e02:219b:b0:346:7741:3ea9 with SMTP id j27-20020a056e02219b00b0034677413ea9mr5170367ila.3.1689742736583;
        Tue, 18 Jul 2023 21:58:56 -0700 (PDT)
Received: from a443afd6f3a9 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001b9dfa8d884sm2759468pld.226.2023.07.18.21.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 21:58:55 -0700 (PDT)
Date:   Wed, 19 Jul 2023 04:58:48 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/801] 6.4.4-rc3 review
Message-ID: <ZLdtiMeTL7ZSD7nW@a443afd6f3a9>
References: <20230717201608.814406187@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717201608.814406187@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:34:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 801 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 20:14:44 +0000.
> Anything received after that time might be too late.

Hi Greg,

6.4.4-rc3 tested.

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
