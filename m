Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A597CA0CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjJPHiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjJPHh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:37:57 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22673101;
        Mon, 16 Oct 2023 00:37:56 -0700 (PDT)
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id A42BF1A45BC;
        Mon, 16 Oct 2023 09:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1697441874;
        bh=iFDKFS21j+PdzHEuBrJScpzUlh6ZN6wATcDa0c2Kovo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tb5eKP64ylz8V5E5bq3xJiABsjlgXYyijqKJnfE1NvMYLDD2BhZvoSIuDjDi5Rg2u
         uFcPmKn/3wNO2ld4If1K0I1YN+GKmSu1SGFjUqmQ/h5CAM12O48d5GPVSmAFpMqBh7
         VpcXxFgLWSt85q/RN7/fLtJ/nxKglm4rfXlq3Uy/erZ2NwbHPjwDQZVE8knNCzNEte
         hZ5hBVg+8E4uV3hYW1hUlX4Anvb/VzF2YMKsnyYTUAMVwi1d8ENgWItb2QNerFkCTk
         Dc2/l8DA4YIC5G28+VEgn9/rl7d8sSE+w0X7+TgsFeXwx8W6w+yvmXstzrWn6+2bOx
         Mn+FUAH8n8S4A==
Date:   Mon, 16 Oct 2023 09:37:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
Message-ID: <ZSzoUVQINYrYSv8k@8bytes.org>
References: <ZSRFW0yDlDo8+at3@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRFW0yDlDo8+at3@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:24:27PM -0600, Gustavo A. R. Silva wrote:
>  drivers/iommu/virtio-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

