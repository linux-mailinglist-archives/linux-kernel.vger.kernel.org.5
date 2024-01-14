Return-Path: <linux-kernel+bounces-25544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0402D82D228
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 23:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CC4B20F01
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 22:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBF6168DC;
	Sun, 14 Jan 2024 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H4KePbSn"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3D168C4;
	Sun, 14 Jan 2024 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D777D240005;
	Sun, 14 Jan 2024 22:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705269678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fLX61tzEOONDeqXZbwPqPkiVxXM5Uzlbz5ndGUIocoQ=;
	b=H4KePbSnAwwqEwgms60WfsfX/enwL/ZsFhU1TzKFat5y8jK7qS4WXBfKxlbVcri3MzXCuy
	I0EtI1mlv9wKpiogZwSca+Hd650+mPDn5SMoVQ9HNJntnQaPMRayrCiOwz2S2e4RUPDeMO
	sTHcx5yvTZ8OxiH/mWmzbSCXaz3xwmXrRvT5CIwQVBD/7SDeFe9XmWhaUoz3lKB2eVoamJ
	LNl7OsdnmOzqKbb5WN1hg/ZTc7KCJ9gJK0906uqwwSOrESNgXcNSet2CeTs48bt07CcGzB
	4Cfe0cqC2BKcbrvi1SEXx5bE+5Fr71LALq4Umf7dpAu9r8HG5rDkmTiayNED/A==
Date: Sun, 14 Jan 2024 23:01:17 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Cc: conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
	linux-i3c@lists.infradead.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH 1/1] i3c: master: fix kernel-doc check warning
Message-ID: <170526966419.132104.16421522756739565942.b4-ty@bootlin.com>
References: <20240109052548.2128133-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109052548.2128133-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Tue, 09 Jan 2024 00:25:48 -0500, Frank Li wrote:
> Fix warning found by
> 	'scripts/kernel-doc -v -none include/linux/i3c/master.h'
> 
> include/linux/i3c/master.h:457: warning: Function parameter or member 'enable_hotjoin' not described in 'i3c_master_controller_ops'
> include/linux/i3c/master.h:457: warning: Function parameter or member 'disable_hotjoin' not described in 'i3c_master_controller_ops'
> include/linux/i3c/master.h:499: warning: Function parameter or member 'hotjoin' not described in 'i3c_master_controller'
> 
> [...]

Applied, thanks!

[1/1] i3c: master: fix kernel-doc check warning
      commit: 34d946b723b53488ab39d8ac540ddf9db255317a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

