Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6757873E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbjHXPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241587AbjHXPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:19:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98BE19B0;
        Thu, 24 Aug 2023 08:18:58 -0700 (PDT)
Received: from [IPV6:2a01:cb08:8af8:5b00:626e:5b8f:fa0f:ad38] (2a01cb088af85b00626e5b8ffa0fad38.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:8af8:5b00:626e:5b8f:fa0f:ad38])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: jmassot)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 59CF36607270;
        Thu, 24 Aug 2023 16:18:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692890337;
        bh=Ul74XMy1SyVeArYJCdntXaMeCncqGiEeALPF+UlEJtk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A4XVZ9SvbP27+3dwLEbeSy5Yk2OZcV/funIKpXargd5NQwyBhQ5loyUkwXoS44WVp
         ZYYTrcnPuB+mTLcDeGC6ilqcxxaWWPLgXDF3uXbB0MlsTTWfFYQoOijgXisIBL6/5j
         EcIaUu7gGj2gWpkNFa3SdQqq7ZoWCoQfp2eH1soZLdgttpYO9huaRxgQ7copX2Ln+w
         5MRiwx9q0ZbjTOJTiA8FjOCPtWBUIsCBpUpyuw4S2gkbjDmzfPOrdEyUGDvUKmX8Uj
         fMjLRBiiLbkA+RUK4+A/TbxyXXxh8NXX1ruzMvEEV5BtacbDnswIbvPMt1rzhO6eYg
         L2u8f+XLm4mpA==
Message-ID: <261a603b-576a-9066-828a-34e893394ecf@collabora.com>
Date:   Thu, 24 Aug 2023 17:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 00/13] CSI2RX support on J721E and AM62
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com, a-bhatia1@ti.com,
        Martyn Welch <martyn.welch@collabora.com>
References: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
From:   Julien Massot <julien.massot@collabora.com>
In-Reply-To: <20230811-upstream_csi-v9-0-8943f7a68a81@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jai,

On 8/11/23 12:47, Jai Luthra wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> Hi,
> 
> This series adds support for CSI2 capture on J721E. It includes some
> fixes to the Cadence CSI2RX driver, and adds the TI CSI2RX wrapper driver.
> 
> This is the v9 of the below v8 series,
> https://lore.kernel.org/r/20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com
> 
> Testing logs: https://gist.github.com/jailuthra/eaeb3af3c65b67e1bc0d5db28180131d
> 
> J721E CSI2RX driver can also be extended to support multi-stream
> capture, filtering different CSI Virtual Channels (VC) or Data Types
> (DT) to different DMA channels. A WIP series based on v7 is available
> for reference at https://github.com/jailuthra/linux/commits/csi_multi_wip
> 
> I will rebase the multi-stream patches on the current series (v9) and
> post them as RFC in the coming weeks.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---

Thanks for your patches, I can confirm that the previous issue 
(repeating frames) that I saw on the v7 version is gone.

Tested-by: Julien Massot <julien.massot@collabora.com>

Regards,
Julien
