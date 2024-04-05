Return-Path: <linux-kernel+bounces-133406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA2689A34F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C2B2827B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8542172BA4;
	Fri,  5 Apr 2024 17:11:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE9017167A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337060; cv=none; b=CBLG7G7N6PVbbVX4NoYVQtM0bFmMiX1LqD9q4VtyDR/zRJnytBQf4a4XAod7bSi5fuplwv6bmhfPkqSu62F2BcNwyRlv5xgmQoNP2vp9IiMUdiNqWJPf01PjY+htQbc+aRyibqvK8QRZp0XgRi10x3dqTRvGRVj6RJTKl4cJzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337060; c=relaxed/simple;
	bh=k9AUnheYHDZKaKIvTDFwV69cRi4PYIH7IBWxMOsDcjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioKmAeTrNpNHSQlV1xF+8OeVMoqgBfqVNBlT2X46/axnFvo8xTp1OBpyi5vAG5MHou/ZvBXYaeEQgy2aQqd/UOByimZMn8FpjzKMwW93VKEVkgSpYxTmPQRVnS2gxOqE2f8l1g4AE+JFy3IgeNONgD9Lzl5wVkQuTuOlXhDl/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD8DC433C7;
	Fri,  5 Apr 2024 17:10:56 +0000 (UTC)
Date: Fri, 5 Apr 2024 18:10:54 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, akpm@linux-foundation.org, maz@kernel.org,
	oliver.upton@linux.dev, ryan.roberts@arm.com, apopple@nvidia.com,
	rananta@google.com, mark.rutland@arm.com, v-songbaohua@oppo.com,
	yangyicong@hisilicon.com, shahuang@redhat.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH v3 2/3] arm64: tlb: Improve __TLBI_VADDR_RANGE()
Message-ID: <ZhAwnohowDjIUzby@arm.com>
References: <20240405035852.1532010-1-gshan@redhat.com>
 <20240405035852.1532010-3-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405035852.1532010-3-gshan@redhat.com>

On Fri, Apr 05, 2024 at 01:58:51PM +1000, Gavin Shan wrote:
> The macro returns the operand of TLBI RANGE instruction. A mask needs
> to be applied to each individual field upon producing the operand, to
> avoid the adjacent fields can interfere with each other when invalid
> arguments have been provided. The code looks more tidy at least with
> a mask and FIELD_PREP().
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

