Return-Path: <linux-kernel+bounces-15287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F288229B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844391C23103
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB98182B3;
	Wed,  3 Jan 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="lJR7nafK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D93182A8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D12421C1E7B;
	Wed,  3 Jan 2024 09:38:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1704271100;
	bh=ctd4MjkCM4xOiGBT1Tv2nhcVi8muD8i8UPtmMaoXT0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJR7nafKj9Tp80SYD/oBXxTTIN6Rv5/kMW9zxQc0s5Mq4CIh3kk7uGDwDn6S+zA2p
	 MAnpRLbdEYeaqlwOAbZyr+paFwAOhXvrVWLrqN2U/ncxjosym9aj8uDflUcibnLYrg
	 YwcD0001U8IF0/YQ7VSDTaAw1M6hHRqLsU9wlQLwdHXi/SQLGv2QDoxeKEwfw9tqKM
	 UizVHRVS8scTHwRDYFXWD7cxdkl8G3mycSfFevwxvw2M3Acr9b38iulT/m/iSsrGO1
	 +xlA/n6lVBdQK0ZuJaOqyK8bZg6aL1whsmSTP1968wwhWHxNesA6FIyttb4rEiyjV9
	 63WeVGhNJhOvQ==
Date: Wed, 3 Jan 2024 09:38:19 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ido Schimmel <idosch@idosch.org>, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhangzekun11@huawei.com, john.g.garry@oracle.com,
	dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZZUc-7mU9gx5wVuW@8bytes.org>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
 <ZZO6NV-Kq-ktnyo5@shredder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZO6NV-Kq-ktnyo5@shredder>

On Tue, Jan 02, 2024 at 09:24:37AM +0200, Ido Schimmel wrote:
> FYI, we didn't see the leaks since reverting these two patches whereas
> before we saw them almost everyday, so I'm quite sure they introduced
> the leaks.

Robin, can you have a look please?

Thanks,

	Joerg

