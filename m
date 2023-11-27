Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316A17F9D09
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjK0KCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjK0KB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:01:59 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E110101
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:02:06 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 8C6131A6D51;
        Mon, 27 Nov 2023 11:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1701079325;
        bh=ezz9eUC2caA+2Tdu14GIo+of2pGcK/lrliKHiFdso+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fO+VvxuN8Hc87mMNAmJ1SLGRNIT8mNfNtMdQujA6lKxhSPDmUNjsA7456rUF5hMdb
         SPLicYIzXe4E71HxY59PpcGpQtAinF3B0gXUjJtWJrdnKPX/D6vTT/jvfjt5HxCbef
         /Ny2i/+SecictrROp3kP+5mw3oqI+rlf3tnZXlrTVH/WSL/QIJmbvMbnk67KnIHEXj
         c2+U7LF1FZ/dpKAnU8Gd4BtUaj0NSqOxkI/sziKS5/eAsumAEZWyTCPWPRzqqJyhPr
         gSkwlCrUqH4qyAOLzF4A1NezGMJCzgjjzYAFp9F2sSy+IxJHZDDNJPYObJb0coNvdz
         DHi2I3U0sn8Mw==
Date:   Mon, 27 Nov 2023 11:02:04 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Robin Murphy <robin.murphy@arm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iommu/virtio: Enable IOMMU_CAP_DERRED_FLUSH
Message-ID: <ZWRpHGOwELiDRQIv@8bytes.org>
References: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 03:51:55PM +0100, Niklas Schnelle wrote:
> Niklas Schnelle (2):
>       iommu/virtio: Make use of ops->iotlb_sync_map
>       iommu/virtio: Add ops->flush_iotlb_all and enable deferred flush
> 
>  drivers/iommu/virtio-iommu.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

Applied, thanks.
