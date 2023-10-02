Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623327B4BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjJBHAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbjJBG77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:59:59 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1175A4;
        Sun,  1 Oct 2023 23:59:55 -0700 (PDT)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id ECDA51A2626;
        Mon,  2 Oct 2023 08:59:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1696229994;
        bh=AIFVwF7V2yCwhyWe75DvT7fYSBhwm/fBmqB8nOMomrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpnLCwzk2x1keRMkLPeYurvT7r9OO8YOJ6/7Vx/qRYBDxYBtaFczM0bl0X3CwM+Z8
         JjZ2S2KL1yCjIcyOYKVBFX3TnYJH3DgXndhq33RdOr06+/f4P6g8ed5YusHJpPxKBf
         /cC8uVfAa/rk6Wr3PPtDNHTnxEpzpMy8C+fcOb8G29mwxCh4jTTbUwvHTKVDKKREHN
         XKS42S0qW6PWzXZYxLGalC73IDOoglQpj2vweIfb/B9jDLMPy04LKeueQ7Vtaof2m0
         /U/pjbpVoAN9ULRqOfwjMT62szxrFLqy3anLaW4GIZc388p9f5N34fWI0GM1KG2Gfs
         vlKBpUHgqfWmA==
Date:   Mon, 2 Oct 2023 08:59:52 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v13 0/6] iommu/dma: s390 DMA API conversion and optimized
 IOTLB flushing
Message-ID: <ZRpqaJEQLRDp5b1L@8bytes.org>
References: <20230928-dma_iommu-v13-0-9e5fc4dacc36@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928-dma_iommu-v13-0-9e5fc4dacc36@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 04:31:34PM +0200, Niklas Schnelle wrote:
> Niklas Schnelle (6):
>       iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM return
>       s390/pci: prepare is_passed_through() for dma-iommu
>       s390/pci: Use dma-iommu layer
>       iommu/s390: Disable deferred flush for ISM devices
>       iommu/dma: Allow a single FQ in addition to per-CPU FQs
>       iommu/dma: Use a large flush queue and timeout for shadow_on_flush

Applied, thanks Niklas.
