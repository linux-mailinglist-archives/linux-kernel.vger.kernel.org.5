Return-Path: <linux-kernel+bounces-78634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11926861629
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ADA3B22ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC91083A0F;
	Fri, 23 Feb 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="WaU261KS"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361682D79
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703084; cv=none; b=JQJKn1yz7bPm0c9mCuZ+P8m6lG2QdjcQcm06AbtBoThMEqaxjB2tLzopX9SQEZv284RMZIB9KsdvPj76fpv1j8WESI6yw9iaQ7+uIh1ISpGT8mjvKv0HD5ZTeXBWexe4iWy9ZN2eUGTlYBKl4XOBS7FCxlICIOXwjQnJq50Qh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703084; c=relaxed/simple;
	bh=WUiTuKfqiqfQmxmzthiloCu0Nc0w+6TSox5GyIwSMlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI5zBCAW9GDZ+rzJHUfm+B95zpTwxZFcl92TaRpqckdEKy8Z9nLVg5KI0ku+KMcLUs7loR29KRHyiDqKVJ5TPEf82DtoMpwYmDrh177US2ne8Ug6tqpBU0yG9AN1gBmev3KuAnB5NQARReXtMG9JN/p5nhTWbOA+Z2uP1w33FaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=WaU261KS; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DDB241C1163;
	Fri, 23 Feb 2024 16:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1708703075;
	bh=WUiTuKfqiqfQmxmzthiloCu0Nc0w+6TSox5GyIwSMlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaU261KSzf7o9zJybj2DU+Ix/YL7QlSQ650KSZqn3RkXGRY5ZTbXccNQbaECfEx9G
	 HkSNdLM5XlPTi8SG5kPkCmrsMwm3Mk82vVsB6y4DvQ6MONfw37b0x2ZUtoCmVWc85d
	 MHR9I/1S6YAtmcgVzpeb5JcDFK2NN+/MP57ZMRv9UoMWqWmUvEKhisCnv/UOBo1CGc
	 f2SxpX9z1Gr7cOXti1MnJZUpqajgFAljsmOk8ofF9m2ZGUx1wbWOCx0clxzVDbGsxK
	 6py57/lUS/D6+rr7sZC9fvbqr4uYnLue9UrXSYVW9mwLiPKvb+NxYyS3KmJhX5sURi
	 1lczYDlxfQ87A==
Date: Fri, 23 Feb 2024 16:44:33 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 6.8-rc
Message-ID: <Zdi9YcGDlXskO_hO@8bytes.org>
References: <20240223115043.GA10608@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223115043.GA10608@willie-the-truck>

On Fri, Feb 23, 2024 at 11:50:43AM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

Pulled, thanks Will.

