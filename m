Return-Path: <linux-kernel+bounces-583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7DE81433F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034501F229A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D07111A9;
	Fri, 15 Dec 2023 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="A4gInUKe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024312E4E;
	Fri, 15 Dec 2023 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 121431A230B;
	Fri, 15 Dec 2023 09:07:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702627632;
	bh=DoLMZzXbG/nWSjrpA3fB74d7qoBKCRr4ZyF52F0eyOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A4gInUKeDrLKf9Y9tGxAqDzDUok/NETBtA5ZDULDobcM2JfCceidpXN+T8+RPivxC
	 dNiTqxRozUciZ1RqVxu5ylyUp5nMkCXD5J8fpudZGEYIWbC/MhxmcTmELSSJDn38hO
	 ZX19amG6Inl0vqpkCbx+24iEbyWlkq+UrxBSNIjTHVDFm0VrDQfEVWPDEpCuxqqlAE
	 DyE9oQE/7IetE179DH8ni/Y+DtrO24AeJklIJaq8+2f7UDDBhH/N73/7BRawyzW099
	 E8acfqEfhl4mXr2bGWjJJIdnX4DVDRz1K2545et/jltidEFKPDW8MEnHCiGQtTzIH4
	 XJPUGmDNS0uOg==
Date: Fri, 15 Dec 2023 09:07:10 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH] iommu/sva: Fix memory leak in iommu_sva_bind_device()
Message-ID: <ZXwJLi9EnfdLVAHA@8bytes.org>
References: <20231213111450.2487861-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213111450.2487861-1-harshit.m.mogalapalli@oracle.com>

On Wed, Dec 13, 2023 at 03:14:50AM -0800, Harshit Mogalapalli wrote:
>  drivers/iommu/iommu-sva.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

