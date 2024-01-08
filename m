Return-Path: <linux-kernel+bounces-19018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDCC8266CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210B5281876
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 00:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E2413AE2;
	Mon,  8 Jan 2024 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="InKDCFCd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4513AE0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 00:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6741C20002;
	Mon,  8 Jan 2024 00:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704672232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrHSH0eBV/yRBGOnl9cN6vf6Ib5osHNihp0lRtyo+HU=;
	b=InKDCFCdLHP7zcYLiZKNK7vIMJQrbXbixcsK5HBv6UAdYNQ3PChiJRzZthCJm+JCTT1SV0
	CjTrODtDGbZrjU7jTrYFpqxA8NQ3hbNWVEpUNAAI/9fTBbBcg80IHYZaXQtF0kCC9mgaT2
	k5tQyL4svjQvhWRB9wjqhdU3rMuM2Ax4qEsOswHh+DAs1HQNEY+2cnZAw2eJuDu1mMhLEl
	5AGBmz5CkUDcbhyg91DA/+yO49bG/7b0GPPve0DhiA2V9euSqpG79QYDLJuGM07+33fXBw
	l1MgSex9+BXnmrzorGjs2y/BvF+jN7eGvoTpdSueS8wKAvabBJpFcRcaSckIWQ==
Date: Mon, 8 Jan 2024 01:03:50 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: miquel.raynal@bootlin.com, Frank Li <Frank.Li@nxp.com>
Cc: Frank.li@nxp.com, conor.culhane@silvaco.com, imx@lists.linux.dev,
	joe@perches.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, zbigniew.lukwinski@linux.intel.com
Subject: Re: (subset) [v5 resend 0/6] i3c: master: some improvment for i3c
 master
Message-ID: <170467220283.558820.13886846242749418731.b4-ty@bootlin.com>
References: <20231201222532.2431484-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201222532.2431484-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Fri, 01 Dec 2023 17:25:26 -0500, Frank Li wrote:
> There are three major improvement
> 
> 1. Add actual size in i3c_transfer because i3c allow target early termiate
> transfer.
> 2. Add API for i3c_dev_gettstatus_format1 for i3c comand GET_STATUS.
> 3. svc master support hotjoin
> 
> [...]

Applied, thanks!

[1/6] i3c: master: add enable(disable) hot join in sys entry
      commit: 317bacf960a4879af22d12175f47d284930b3273
[2/6] i3c: master: svc: add hot join support
      commit: 05b26c31a4859af9e75b7de77458e99358364fe1
[3/6] i3c: add actual_len in i3c_priv_xfer
      commit: e5e3df06ac98d15cfb10bb5c12356709365e91b2
[4/6] i3c: master: svc: rename read_len as actual_len
      commit: 6fb61734a74eaa307a5b6a0bee770e736d8acf89
[5/6] i3c: master: svc: return actual transfer data len
      commit: 6d1a19d34e2cc07ca9cdad8892da94e716e9d15f

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

