Return-Path: <linux-kernel+bounces-92464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24CF8720AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F75F1C24914
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801D585C7B;
	Tue,  5 Mar 2024 13:46:20 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408ED5915D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646380; cv=none; b=PU+/C8+TgQ5u3b2nyiHkpD8/gvQMSP8aD+ckE9RtDQhpDazBeMJaHMlFBHcBwu2ggYotJerJcCHwHpgU8V2cftdD81ILn3201Tgbbl/UAaqWGDYd9ahmMlGIT+RNJN+bXuVaLXBkYfBmGdIlg5kKG+Idb0s8Sx+cJ4g3/8v8Rpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646380; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMf8Fxi+wE4dSzsnyIZKnxFhbMJvoAtBZhsGLhcdioJNvOSGZjEGBJo4y/FxOmU/VIUKi/HJixqaCSxQpsa34IIY83Q+ZA+xRInDP/omLQYsQMaVq6S4YyefB0lbWeJlLeC/7I/H1Yio9wiGYA4YVINvV7WCgN4sTN6+wvYZkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A29768C7B; Tue,  5 Mar 2024 14:46:13 +0100 (CET)
Date: Tue, 5 Mar 2024 14:46:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	will@kernel.org, mhklinux@outlook.com, petr@tesarici.cz, hch@lst.de
Subject: Re: [PATCH] iommu/dma: Document min_align_mask assumption
Message-ID: <20240305134612.GA2063@lst.de>
References: <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

