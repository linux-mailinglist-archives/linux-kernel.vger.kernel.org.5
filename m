Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB977852D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjHWIic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbjHWIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:35:19 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02137E61
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:33:51 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a7d4030621so3267578b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1692779630; x=1693384430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEZYfNdGHFuQCHIcJhT93OXA67O5vCx3m+so5jDRSw8=;
        b=TX2c+wqJRobv3j0e8RREST8SX+xfS9+g9IPUwp5Tb9/6GCZm276gPJvJzmB1JK+bZF
         kdZ4ls/SlGmn7vNsbyE83FuTGc18TSSpyn4rcI7Tc/CDBRtumJAz+XdAeQzDqn1x4/6b
         SajoPnEu6byuT/ffJRrVcaXMhKPwpGdYc8cbg6Qi1vNyjXtW3fZXDp2IZKmCXdxzKbku
         VQp6qNaeFcoyOAaifKGsl+QguDauT/8IoQM+bKUJ8oo6nfvTNc5OLDv84St1JKEkK5uF
         mYxNfs8rsYHwWdgqCTNSXTr6O0zDFsIo2elGH+rzDvyhQ6FK4tRLYqhlV3VFFawVN0NP
         7tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692779630; x=1693384430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEZYfNdGHFuQCHIcJhT93OXA67O5vCx3m+so5jDRSw8=;
        b=kXmsZBtPk25eZ6TgUfZCUEKjrwcY+6FFDcvT4JzXLbfN7sFSVuEKK4KWK3ri0mwHe7
         rz4xfwEP4nwT/BDjM9vXnE4Pd3swsaDlZTVvWW7sz0Kx57CreKpRl6OMZ4UB6MYY/+Rs
         0z2VQbF8XzOmQIehuk0wlzlAAJg4zfLE4rnmw/Ysk2IojE8RBTHhUIcqJQqNkRNXxt7W
         oQNIwyuYTLonIEB6XEypxGiOTIjKUj1uPMOJWmiuI/ohuNWyffG/eFhS0hapKXU2LEj8
         Ht2Oqu65itY/NUyfke/IFusji+5FD5i9XZv1mm+wF4pxVFtoh5qgtAzrQs3C3xyKKtuR
         jxXg==
X-Gm-Message-State: AOJu0Yx36t4ZBsqcEcmVGAzqncoUWYTkWH6LUREJH6TYu4L9lwfN9gyC
        1WP9WZgey2/n/GaciG/KIhcykNX8IIMFSavgw9whs7dc
X-Google-Smtp-Source: AGHT+IF0UyIh+LqSwepkJczmlYtiwIfzGgiqpqohQ2UzK1qL8TCrr4cSHiZm6Q5GPKaJT9vdlPYyqg==
X-Received: by 2002:a05:6808:1447:b0:3a8:443b:d87b with SMTP id x7-20020a056808144700b003a8443bd87bmr14299773oiv.34.1692779630304;
        Wed, 23 Aug 2023 01:33:50 -0700 (PDT)
Received: from [192.168.137.2] ([149.199.80.128])
        by smtp.gmail.com with ESMTPSA id q13-20020a62e10d000000b00686236718d8sm8950179pfh.41.2023.08.23.01.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 01:33:49 -0700 (PDT)
Message-ID: <85367a42-0dd4-edba-db42-47475b158c8d@monstr.eu>
Date:   Wed, 23 Aug 2023 10:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] microblaze: Make virt_to_pfn() a static inline
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230808-virt-to-phys-microblaze-v1-1-e6df710fe0a1@linaro.org>
 <CACRpkdYG1hhotoUj0o6+o=rFBfgrhKn9QjC2BywZdEmaoOwD-g@mail.gmail.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <CACRpkdYG1hhotoUj0o6+o=rFBfgrhKn9QjC2BywZdEmaoOwD-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/23 10:07, Linus Walleij wrote:
> On Tue, Aug 8, 2023 at 10:40 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> +static inline const void *pfn_to_virt(unsigned long pfn)
> 
> I think maybe I should not have put const there. It means the
> pointer shouldn't be modified and I think there is code that
> does that, or cast to some other pointer which is not const:ed
> and then use things like ++ on the resulting type.
> 
> If you run into compile warnings you can just delete the const,
> or I can send a follow-up patch.

Thanks for letting me knoe.

I compiled it by my default toolchain and didn't see any issue.
It should be tmr in linux-next and more bots will run over it.
But if you want to fix it please send the follow up patch on the top of this one 
and I will take it.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
