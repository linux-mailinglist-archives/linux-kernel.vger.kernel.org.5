Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761F67DD5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjJaSQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376445AbjJaQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:59:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12223586;
        Tue, 31 Oct 2023 09:58:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF60C433CB;
        Tue, 31 Oct 2023 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698771534;
        bh=eHaWx3XBjxR9WQzWxiMP+9mylnGCpepEBx6eV8SqLTg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=tbFH75zD0wSBts/IWcd7KAkpwmPD/hEQnoc5NXDyB/MjbJOXo5zrD3rmL4Ahncdif
         eIcVReQjnW56tvzKCj85nLvxrNiT9ITtCdsvtCj1YudM8P44AfW+wvbLx8E31lmZHI
         K/ww8YDAqnM3vJiXT/vgsJzNFj79dFkzqAoYMfpE+ltqvSCZw1qaolePHpVpT95iG2
         NbrJ2KNE6yns9TZ7LnwRpmxMej2DZpXykM7mPrVmrFqIGUz96j4Yz5YZWKftWTDlzN
         UERaMt14CsLUi6zGA3QCHip/+scFSK+oAlNODnBrIxuF35OLgDNT3n009Zh6v3iT5c
         UU8ageBtEuPjQ==
Message-ID: <ea5bf4b6-af77-46cd-89db-d7a79a117dc1@kernel.org>
Date:   Tue, 31 Oct 2023 17:58:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: exynos-mixer 14450000.mixer: [drm:exynos_drm_register_dma]
 *ERROR* Device 14450000.mixer lacks support for IOMMU
Content-Language: en-US
To:     Mario Marietto <marietto2008@gmail.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
References: <CA+1FSiiPqYuycAa8rLFzKVDzvJC3BQBwRW7E0Ki4CXEFwhRASA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CA+1FSiiPqYuycAa8rLFzKVDzvJC3BQBwRW7E0Ki4CXEFwhRASA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 01:04, Mario Marietto wrote:
> Hello,
> 
> We are a team of linux enthusiasts who are trying to boot Xen on a
> Samsung XE303C12 Chromebook aka "snow"
> following the suggestions in the slide show presentation here:
> 
> https://www.slideshare.net/xen_com_mgr/xpds16-porting-xen-on-arm-to-a-new-soc-julien-grall-arm
> 
> This device uses an exynos5250 SOC dual core 1.7 GHz with 2 MB RAM, it is
> a Samsung armv7 chip with virtualization extensions.
> 
> In particular, we have it working fairly well both on the bare metal with
> a recent 6.1.59 Linux LTS kernel and also with a recent 5.4.257 LTS

Oh, these are old... Although there should be no noticeable changes
against v6.1.

v5.4 is not recent. It is four years old!

> kernel with KVM, the older LTS kernel version is used to test KVM because
> support for KVM on arm v7 was removed from Linux around kernel version
> 5.7. So we know we have the hypervisor mode enabled because we were able
> to use it with KVM.
> 
> For Xen, we are using the latest Debian build of Xen 4.17 for the Debian
> armhf architecture:

...

> 
> In this case,the kernel is able to use the exynos-drm kernel to start
> the fb0 device. But with Xen we get this error with exynos-drm:
> 
> devuan-bunsen kernel: [drm] Exynos DRM: using 14400000.fimd device for
> DMA mapping operations
> devuan-bunsen kernel: exynos-drm exynos-drm: bound 14400000.fimd (ops
> 0xc0d96354)
> devuan-bunsen kernel: exynos-mixer 14450000.mixer:
> [drm:exynos_drm_register_dma] *ERROR* Device 14450000.mixer lacks
> support for IOMMU

Hi Mario,

I don't test DRM on my Exynos boards, so my knowledge is limited, but
isn't this the answer?

> devuan-bunsen kernel: exynos-drm exynos-drm: failed to bind
> 14450000.mixer (ops 0xc0d97554): -22
> devuan-bunsen kernel: exynos-drm exynos-drm: adev bind failed: -22
> devuan-bunsen kernel: exynos-dp: probe of 145b0000.dp-controller
> failed with error -22

And that's the final confirmation that display did not probe successfully.

> 
> 
> Any ideas why booting the same Linux kernel that results in a working
> X.org display on the bare metal instead as dom0 on Xen would cause the
> display to remain dark, but most other basic functions would work, such
> as network, disk, and USB ? thanks.

BTW, it's usually good to Cc the maintainer as well, not only the
mailing list :). scripts/get_maintainer.pl will tell you the maintainers
of Exynos and Exynos DRM.

Best regards,
Krzysztof

