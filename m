Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823E87F9CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjK0J5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjK0J5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:57:05 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4004F0;
        Mon, 27 Nov 2023 01:57:10 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 2BC441A4799;
        Mon, 27 Nov 2023 10:57:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1701079029;
        bh=CHHOkEMTPlg6Xp1XqOEpVungIbDgk3x5eaYRFc6OMvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zz3X/iBiBVM3gKoGzcPRKsUrKzGKvDDxddIItBGIrI9aqPyU/yKP2kaAn5hQux0XS
         JrGbXWO93UFSecEJJPItKQCoLPlqLJKODxmzQq2CxV0v5EB+UMbDItB/LOuFI1M9ib
         z+Gi8Z2yssva5mirEt3Hj9QyfmvAxPMoPvl3swdWsmpi9h6A7qY3fXWvBIOVpb+HTX
         r95P85qXK0wfnz2uG+IFAsmHPCYNs/7j/sHzCAHsd8rv35jiZbiFp+3nYeQIcn670e
         bZm8zYouky0yAKTY4eTcWL+se5W9w03k9+hGmn+QElmPFJ6NYMKymmQztvlugfbQ6J
         fwBa0QYmVCNag==
Date:   Mon, 27 Nov 2023 10:57:08 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        lpieralisi@kernel.org, andre.draszik@linaro.org,
        quic_zhenhuah@quicinc.com
Subject: Re: [PATCH] iommu: Avoid more races around device probe
Message-ID: <ZWRn9G2Fzyibzn0X@8bytes.org>
References: <16f433658661d7cadfea51e7c65da95826112a2b.1700071477.git.robin.murphy@arm.com>
 <ZVZL9kZuVsb9VPnM@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVZL9kZuVsb9VPnM@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 01:05:58PM -0400, Jason Gunthorpe wrote:
> I'm fine with this as some hacky backport, but I don't want to see
> this cross-layer leakage left in the next merge window.
> 
> ie we should still do my other series on top of and reverting this.
> 
> I've poked at moving parts of it under probe and I think we can do
> substantial amounts in about two more series and a tidy a bunch of
> other stuff too.

Applied this for v6.7. Before I am going to apply any series on-top I
want to see you and Robin agree on a general direction for this moving
forward.

Regards,

	Joerg
