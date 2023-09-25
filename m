Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D297AD493
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjIYJeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjIYJe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:34:29 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE765C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:34:22 -0700 (PDT)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 2EB521A21D7;
        Mon, 25 Sep 2023 11:34:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1695634461;
        bh=9EMyY5icWOUKHmM/HD5jhz25I/xMaeIP7LGCoBAqU8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JW1bTEQAtzolhcJGyMSk1JJnGTGMWrJX4VGRLsq5dTl1tsTR03PS7GztOG4tbEzOW
         Pw0SmIVNYwNPPGr9T55Kp4Oaep6qXraD5GyxV2tDLNsQGL0urE7VQrGLjJM7Ap4nC/
         UNmMZfEtSzxJ5sviUkTnlUGb8TN7B1efPJ7SlPzQg59WRj5cy5DawrWDm5QLp9OOGG
         g7Dz3mX9dGtXKBgLwUSI0aBSdAnFLIin0giZHumTz4HI0MdfW0B9tEy1mJaRuz/URj
         zDKlPht2f0us41XvDllABOdgN/Gr8EF2iDMZzJtmDIZNFEHVVCpqqcl/L+0sdtoEJy
         O6CN1E8E/RP4Q==
Date:   Mon, 25 Sep 2023 11:34:19 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Laura Nao <laura.nao@collabora.com>
Subject: Re: [PATCH] iommu/mediatek: Fix share pgtable for iova over 4GB
Message-ID: <ZRFUGxCJZdExznBz@8bytes.org>
References: <20230819081443.8333-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819081443.8333-1-yong.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 04:14:43PM +0800, Yong Wu wrote:
> Fixes: cf69ef46dbd9 ("iommu/mediatek: Fix two IOMMU share pagetable issue")
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Closes: https://lore.kernel.org/linux-iommu/20230818154156.314742-1-laura.nao@collabora.com/
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Base on next-20230818.
> ---

Applied for v6.6, thanks.
