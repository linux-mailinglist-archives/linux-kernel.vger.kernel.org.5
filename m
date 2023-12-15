Return-Path: <linux-kernel+bounces-581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82681433B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE7C1C21591
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF814111AC;
	Fri, 15 Dec 2023 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kX6Xr/82"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5D210A30;
	Fri, 15 Dec 2023 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4F7AB1A230B;
	Fri, 15 Dec 2023 09:04:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702627493;
	bh=OEc02SFKyf0odkc4ajBNDpPdVcH6NRl4SOvhSR6cgYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kX6Xr/82aVOXzjWE7WPTvlnwdtaALlR3lsRl2YBvjIaADja8Qs2keokoS9PRfl5e2
	 t6hfsoT6Yryb7TvAR6oZcsJVMKkVsbiSImJsezfrEZQkbfMDMtA5XxdEuNREi81L1H
	 vshCvTonthhUS7pAo2qj8m4ohl5T/ZhpYSJPPi+Y3Tv0YbXoheeQZl36A8HdMuH1c3
	 wzT3B40PzC53B2RTljiWCGskMXtFJZJpE9laKiO6eDHFnX/wTMXtZvNpXxvVTffusk
	 nW73GlL54ncrGMIBMA9Ll4apTnFtF+tRCa1sYSqpOCW8DUrSAZKpGL7Prf+KDX6Apx
	 lfMy5gBKY5axg==
Date: Fri, 15 Dec 2023 09:04:52 +0100
From: Joerg Roedel <joro@8bytes.org>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Tom Murphy <murphyt7@tcd.ie>, Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	kernel-team@android.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/dma: Trace bounce buffer usage when mapping
 buffers
Message-ID: <ZXwIpBoKpg3vVQvt@8bytes.org>
References: <20231208234141.2356157-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208234141.2356157-1-isaacmanjarres@google.com>

On Fri, Dec 08, 2023 at 03:41:40PM -0800, Isaac J. Manjarres wrote:
>  drivers/iommu/dma-iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

