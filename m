Return-Path: <linux-kernel+bounces-59109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D3684F152
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BE8284D95
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E165BC4;
	Fri,  9 Feb 2024 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="2chkslmh"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E78657C1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467066; cv=none; b=Acq7+esbVUY91aOkbfOCFxiUJfQ8KL20IurAiy2NDxw0wuZm4TRiq40L91KFPkdhh0nb3Km60rRJzTO7zS2/SRZujcbuCKuT43MtpRYFYF6vzjL45mmAHYWJbVhxkHuGBb3m/gJLagBQAQlXDBVwkRBT8U8OV3tx0l51Q/CK75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467066; c=relaxed/simple;
	bh=xtdmOYF0bU9RGJxwGiKy4e1B8mhXINzdurimXYBIN+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR7Ue1tA0xmHrBfNttD8ucJwSkTLjw7uvGJj6PtBsXeEW5oC4gfIWd2SMNoimY0z4m4hvun4QYp3uD1lJLdr6O//3rNXIpSlc6SNwuMqQ3ikeWerOcca0resUe970//oX6qFIW8iiy5eAYD0WKMx6HdLmHwT9D2PzIzDdpA4nUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=2chkslmh; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1BADF1C1888;
	Fri,  9 Feb 2024 09:24:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1707467058;
	bh=xtdmOYF0bU9RGJxwGiKy4e1B8mhXINzdurimXYBIN+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2chkslmhKuM9mMT7WCQzUWaQ/3n6LF6jIGM8K05goCYfEYJhdPIJGtmQzD1nwLXHk
	 drHbIjJwshbBP+PwV2/YJ5n6vUb1pCaCcXrCbNCIgyV1f2E98YVXm6yCxn4B+2gxXp
	 GCn5ff3V+CPEr3B0ujFksLArGL6JTCmcF01uNBrkeg9g6mPlvvgJL2JwowjdzcKOh4
	 PQLKtdySkMWAwRzD1LwqlCTeAgJGNwUCWB8YKct373kJlLKQFndin7zSPCBeKJWPe3
	 7DzPvDaXrOO5mEYrqe97dduwM8eKOkWhGFpnUOC7O/bp0tRXnLWLHpXkpoNhRdhMow
	 3mDl9PDR74maw==
Date: Fri, 9 Feb 2024 09:24:16 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: suravee.suthikulpanit@amd.com, Vasant.Hegde@amd.com, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Mark interrupt as managed
Message-ID: <ZcXhMNZDOHstOP5k@8bytes.org>
References: <20240122233400.1802-1-mario.limonciello@amd.com>
 <de66890b-a42c-4d8b-8079-fcfff0007aeb@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de66890b-a42c-4d8b-8079-fcfff0007aeb@amd.com>

Hi Mario,

On Mon, Feb 05, 2024 at 10:31:47AM -0600, Mario Limonciello wrote:
> Friendly ping on reviewing this patch.

Thanks for the patch. Since this is a fix the patch should contain a
Fixes: tag. Also a review from Suravee and/or Vasant would be great.

Thanks,

	Joerg


