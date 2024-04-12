Return-Path: <linux-kernel+bounces-142467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305148A2BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903FDB25A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A7F537E6;
	Fri, 12 Apr 2024 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="VKiHt3wv"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31865339D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916415; cv=none; b=ex2ZdYCR/MUFRKkVH0dHUJVTYaOYtB8i5MmLfbFrfJNwl3eBKhQjkT+Lh/X5cLbl+TE7vQs6o8kX6yR2UIDXllRkoKr3Jc9FKGBqUStsiZjxkARoH0juWERCsThl1uV4RVB0kgUT2sXpEhMEPocjmdaBihcegCHriB1xji3TUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916415; c=relaxed/simple;
	bh=rFJXMLQKoZvovqpOjObobPacPdR63TMJNgor5cU6a2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJiftC8j94iLCBMlGbGZSCMkq65JPJ3wqgM2wnZhvpMnLhwAj6vIMp2N3aKyeGLuv9nO9upMx6Rt1L76P6k5f5Gs+cH2gryvKAxEmt08BmK6ZhHzRbc8mCRcQ7wahTzxrjZaFUCzcuT1eQGJCw8LqHmwwnbG77dpnmbhye9tDbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=VKiHt3wv; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0E2D7281A38;
	Fri, 12 Apr 2024 12:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1712916413;
	bh=rFJXMLQKoZvovqpOjObobPacPdR63TMJNgor5cU6a2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKiHt3wvwt/1NCxMQpzfZ+wsSajQJyvIlG3Qm6PcbMmal1QjPWv9fjPFhI9TtPCYZ
	 0V7/2z0MTCMvG7CB0xUmfUXr32wZBpkRfYlYtRE0rcDxYyDwQVt+jOEBcrxvtTPsKf
	 QhBkCar7G70zgdaWjGYoBdc3PCnjoLKNF4b8dFUpdqGYe0V7LySBxWGnvFqUG0TIMM
	 8KjCdY/gOFcEn5hXF+uoTDtmilU6fpBLWyT1xY53DVekvmW7Q1HmqSmGoH78qNPD8f
	 iGm55t7pVC5Tt8vBAp3M80JR2JhTjbJPyomTl3rAtbFGJfo1//U8R83YM+TYFIe3JP
	 VLUZJJ5gZSV/g==
Date: Fri, 12 Apr 2024 12:06:51 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Xuchun Shang <xuchun.shang@linux.alibaba.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v6.9-rc3
Message-ID: <ZhkHuyUAkWwEOFmB@8bytes.org>
References: <20240411030744.273460-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411030744.273460-1-baolu.lu@linux.intel.com>

On Thu, Apr 11, 2024 at 11:07:41AM +0800, Lu Baolu wrote:
> - Local memory for PRQ page allocation;
> - Fix WARN_ON in iommu probe path;
> - Fix wrong use of pasid config.

Applied, thanks.

