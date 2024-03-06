Return-Path: <linux-kernel+bounces-94276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C85873C63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FCB28921E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4C2135403;
	Wed,  6 Mar 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="dF6vfCRU"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CB2F9EB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743006; cv=none; b=dXigZNOLU6KnL9FQJzT02tzwfig1dEcHviQwq4izrDDjposGRW6tySpJ/iq46E36tNPMP4Fkr9Ai+bywqIOqTmJ0ZQtoMCv9xkwj+jVJuV9glKQz4IzrvXLa/b2wG1WHr4YKckOSPwt6PDhnFpSaYYb1vfk86h5R7ReyoT6vcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743006; c=relaxed/simple;
	bh=uNs651aYfXthLucycqDSNA+UNBNufajmvLOm9VYTfw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe2MF3xFaFY+IEBEK882GLQxJYtYa5bf1jQ6I8rDVF/bG/c8/Wn0pwEPu2YVEU7/K/bRKRu+eQ0hR50HFMffjgVbt+PimH2oyIoNaMiZo+829iR2Ljflv5AOwU1HDxvW+y9eXE1Kce48aLEpw4yk508xsFmHgB3UQ4/N7PX0pWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=dF6vfCRU; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 981171C84EE;
	Wed,  6 Mar 2024 17:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1709742997;
	bh=uNs651aYfXthLucycqDSNA+UNBNufajmvLOm9VYTfw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dF6vfCRUbNw55VeWhQRctC5vpxlGUb3vtCRJYVYEl1tUFDCsfvwDfoPYXBDNBtO8O
	 bQMWSWobe1qFDff0x/ptaa4wHMr+5pJEVXecQSix36OdDsfT/4EJWR9N3rTlv4p09h
	 fcqsS5fQG3A1EN9H3KMnG5JnxCiTZNUD4K9fMc+N2HkIe0cdnyON2ZT9QCdoMTHxCL
	 TJ7+RMovioIjeLGzgDBhgnVlumeKVUYVKTeDrShlygfiWh/WeBLfwgkXwSNFqfKiEI
	 o0wFIS/6iRGsHTCt7RWB9mNsSq9+fflSiU7QJA7DEWIClXsoz0gNBIruuuzBhRubw/
	 izriPxxUK0SPQ==
Date: Wed, 6 Mar 2024 17:36:35 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Eric Badger <ebadger@purestorage.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] [PULL REQUEST] iommu/vt-d: Fixes for iommu next
Message-ID: <Zeibk_Ko_JK9hXT2@8bytes.org>
References: <20240305122121.211482-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305122121.211482-1-baolu.lu@linux.intel.com>

On Tue, Mar 05, 2024 at 08:21:13PM +0800, Lu Baolu wrote:
> The following fixes have been queued for iommu next:
> 
>  - Fix hard lockup on hotplug of an ATS-capable device
>  - Fix NULL domain pointer dereference on device release

Applied, thanks Baolu.

