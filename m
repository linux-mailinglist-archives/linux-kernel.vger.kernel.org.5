Return-Path: <linux-kernel+bounces-30380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7D831DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5861F22053
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235772C6B1;
	Thu, 18 Jan 2024 16:58:15 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECF2C843
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597094; cv=none; b=K324WUKNXonOHjqk3nC4DrzjlGhkm0YJV3VQKzZFci2rDn+neYySSj9irmx7LYNWZDqB70UbsSoa8HViCb8SqDUb6n4rrOHUmKpBVxLS0yb+j/C+MuFZrzfiCv6pIceWWftiE9ZS1HIgKL3LGiUgi7YsteTZo6g+W6ZgUXO48Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597094; c=relaxed/simple;
	bh=QYRlUkW/XpdCNFGIHDOmI1vkPXM8L2eljOqXfzrzFsQ=;
	h=Received:From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=ITf5OqdzVZVFQB0mdYbU09l7s2gbBZxJsEYvoAMijhkVoqsTEjveN/hbAl1cvkathoBK1nSp8pDCndUnGKqzfDom4Q9UsOjCXrwo0l7y9wdR+5G9p9a2CvWBGMyO0EN33df/K0GoY65CeGjZymSfUqoHjbigfZ1N9Oq0UB1qa2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-108.elisa-laajakaista.fi [88.113.24.108])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id c2b5c193-b622-11ee-b972-005056bdfda7;
	Thu, 18 Jan 2024 18:58:11 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Thu, 18 Jan 2024 18:58:10 +0200
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] Add cs42l43 PC focused SoundWire CODEC
Message-ID: <ZalYooJxj7Ba0sYU@surfacebook.localdomain>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>

Fri, Aug 04, 2023 at 11:45:56AM +0100, Charles Keepax kirjoitti:
> This patch chain adds support for the Cirrus Logic cs42l43 PC focused
> SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
> branch.
> 
> This series is mostly just a resend keeping pace with the kernel under
> it, except for a minor fixup in the ASoC stuff.


Sorry for the late review, nevertheless, I was alerted by the pin control code
probe function that does something custom with devlinks. This is a red flag,
please find time to fix that.

The rest of the review (since the code is in upstream) is probably good to have
via follow up cleanups.

-- 
With Best Regards,
Andy Shevchenko



