Return-Path: <linux-kernel+bounces-116460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF886889F23
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE6F2C69C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7154D15EFD1;
	Mon, 25 Mar 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgXcy4Wb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFCE3C81F6;
	Mon, 25 Mar 2024 03:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711337839; cv=none; b=HTd63cuIlWc071IgFq7Veydxqjg0Wq21+nGQ6g/05bhZ9QGadsSA/4YOqlJZr1P80Hx8cuTLmMRz+XbHVTjsuhM3HhstyrGqHSPUtxZgKHySR6rkJDvrhU3CNtFhZk3ryL/gpVHcVmqlFVGciZaOOn9wcBXHsrbBGwSvCFIIYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711337839; c=relaxed/simple;
	bh=YDbgTqnH3ZuZ8lakJVvTchqikQuDSP9tFa66V0AUlmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9zz1lYA6iW/Se/nMQbrUBSxfIEzdol8ujReRJqWlfz6S0Hcrr6mcgJMekUQAEKNDkWC81WiBAPKsGkyHI9BQ+Y3Jpmh48KuMIbqPZhaj7JTYeykoO059L6omqK5exrbLjvBCvmqj6DfM9e1we0aFNSl9rDM6gIBnrTVuk1DlfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgXcy4Wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D5C433F1;
	Mon, 25 Mar 2024 03:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711337838;
	bh=YDbgTqnH3ZuZ8lakJVvTchqikQuDSP9tFa66V0AUlmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgXcy4Wb9aJjAn0Yru7/j3RpuPqYk/qYIAodfpTNbUkRtlf06kBmkpzTXk6fHZDdv
	 iMRk3adCHKDFpIEiwK4cxek7gFOl+vpVrAyefEhcw0iGcUMmwcV1AWfKd/UyR2Bz19
	 TyRN/52zovAhnr4x6/HGrF7eLgt/dP9ZapG5Eu2F3eLQWmEkDPezwrQuW5V1HBhqLS
	 Z579pSOgOGy04KaQ0bwpCWIOQ68B2K5ysnwWlnZi33KsQ76PujXKgx1VJJBA5VjzVm
	 zgtvzWXndKw7ps9XOlzw/uJO/IH3MI6Hcr0Pow7qxL5RKoPM1giOYd9h2pi9pVVlv/
	 WqDJlCNGFTkjQ==
Date: Sun, 24 Mar 2024 20:37:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5.15 032/317] f2fs: implement iomap operations
Message-ID: <20240325033717.GA37260@sol.localdomain>
References: <20240324233458.1352854-1-sashal@kernel.org>
 <20240324233458.1352854-33-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324233458.1352854-33-sashal@kernel.org>

On Sun, Mar 24, 2024 at 07:30:12PM -0400, Sasha Levin wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> [ Upstream commit 1517c1a7a4456f080fabc4ac9853930e4b880d14 ]
> 
> Implement 'struct iomap_ops' for f2fs, in preparation for making f2fs
> use iomap for direct I/O.
> 
> Note that this may be used for other things besides direct I/O in the
> future; however, for now I've only tested it for direct I/O.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Stable-dep-of: ec16b147a55b ("fs: Fix rw_hint validation")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Nacked-by: Eric Biggers <ebiggers@google.com>

No reason to backport this, and the f2fs mailing list wasn't even Cc'ed...

- Eric

