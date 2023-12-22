Return-Path: <linux-kernel+bounces-9709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1D81CA0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62061F240B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E532718056;
	Fri, 22 Dec 2023 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X3gr0tiT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6817728
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC452240003;
	Fri, 22 Dec 2023 12:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703248490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bq0Cc7KHVfln4arFsKeGt5O9gb4Np/925X2DinLuzzI=;
	b=X3gr0tiTDPm0nix/vXT1GCh6Ot7hAp7YQ2RZjpA2QK+NhhgJcTJ6YoXMIThcEFm6dtx5pD
	FrEPEmTpeB/xztiJTDtdrc5nQr4jBcm06tyA/SdL9QJJXeCMQBLTGJCM4X2Yd8MdVOVyvM
	dLVMDonEoTvo1TddsOaCC8XQ2mNThiKUgrnoUunvn8tYQYoShtPbiGs7nRfq/w4gCl7y5Z
	6cTPk7SZhyFQZsJ+iDYaICyLMeGX/KuCihyuLxP5qrt/3g36Rz+7Iks/t++A5z4m6YPDTv
	OPsucwuj53L7ZkClevva2b7gtATtb4AgbsmB8U5YEObm7FmEl44LoLQ3bn0AQA==
Date: Fri, 22 Dec 2023 13:34:48 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: soc <soc@kernel.org>, "Qiang Zhao" <qiang.zhao@nxp.com>, "Leo Li"
 <leoyang.li@nxp.com>, "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PowerQUICC QMC and TSA drivers updates for v6.8
Message-ID: <20231222133448.1413d78d@bootlin.com>
In-Reply-To: <a274ba17-6ab7-4169-a10c-22fcc9e74248@app.fastmail.com>
References: <20231212105514.273e8ab0@bootlin.com>
	<a274ba17-6ab7-4169-a10c-22fcc9e74248@app.fastmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Arnd,

On Fri, 22 Dec 2023 10:55:00 +0000
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Dec 12, 2023, at 09:55, Herve Codina wrote:
> > The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:
> >
> >   Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)
> >
> > are available in the Git repository at:
> >
> >   git@github.com:hcodina/linux.git tags/fsl_qmc_tsa_v6.8
> >
> > for you to fetch changes up to 7a2ee1576dcc6bbe017a8283fba237b05b13fd15:
> >  
> 
> This is not a valid git URL I can pull from. I have instead pulled from
> 
>   https://github.com/hcodina/linux.git tags/fsl_qmc_tsa_v6.8
> 
> which is what I think you meant. 

Yes, exactly.
Thanks a lot for having pulled the https url.

> 
> You should probably edit your .gitconfig file to add a section
> like (not sure about the exact syntax, you'll figure it out).
> 
> [url "https://github.com"]
>     insteadOf = git@github.com
> 
> 
> >  drivers/soc/fsl/qe/qmc.c      | 658 
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------  
> 
> This is an overly long line that you probably copied from a large
> terminal window. Just for readability, I recommend redirecting the
> 'git request-pull' output, e.g. into 'xclip' or 'cat', which will
> give it the appropriate line length for emails.
> 

Thanks you these feedback and tips.
I will be more careful in the future.

Hervé

