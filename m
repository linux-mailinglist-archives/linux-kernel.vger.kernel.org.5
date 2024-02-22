Return-Path: <linux-kernel+bounces-76018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211CD85F1FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92A41F21745
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777C11799E;
	Thu, 22 Feb 2024 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="YKOOmbR6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zn2sSetz"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A117981;
	Thu, 22 Feb 2024 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587743; cv=none; b=sR+IRUiTjMuHWBxd9OvKPchcwDF6xh3Xmm5/HK9Fo6GB4K5dCLC5ocHnC6/xmLORQ/MHhz1PiGYgDLuj5rYjluAIoEIyT5gghNQzKLYn9HkSt2nZokGH3YuhWyfzrP4lnhSUbgWrIWs/+9TivCvdRC5mVMj746KALnu+8ROWst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587743; c=relaxed/simple;
	bh=Xguh7gJE8+/xCqN+YxKpw03ScTFDH4OCm0WbfXtcxvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBkjNoa9HVzwxKuzgXt1v7DCN8RYwGiXs6+taOjG4u4C9EJ1IWhk/nGTP6oz8RKVwhZ4chk9iRYVU6fkdj5eeMS5QAOkalrhBXR6IepT2vkGB2J9WroKKWQB1uEmy5gJiDctROTvkFPieav8NWo4ucE/7s/DmiO9/iKGFscAIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=YKOOmbR6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zn2sSetz; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 68FD45C0095;
	Thu, 22 Feb 2024 02:42:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 22 Feb 2024 02:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708587740; x=1708674140; bh=i+RFLxxDEQ
	TI7kHrG6pXNkuGHMjzU1LQympDsEkg4RI=; b=YKOOmbR62D4yF/y+ASvulONKI/
	1OyBTtcriqd8yWvEGkMIvIpfaA++UP7UzCabe2YkZznwqn/Iq1jXkL1AhHz6kDM3
	/mh90m5gIiHi7M81+tNA+jTALHcMuNMrgjX/ZuGzjqgxBJfGMxFXc8Q03tvpwPAW
	LkEcxpcnrP54DrcrYoni6aaDPTLOs/n2i1MY+L+FATXQkejO0oCPgMnotKJh7w9/
	8cn5IdhO9lrV99LNTGWg37+zC2elMPixPUC1OSqNCSoqORsIYPsJF3KF/cxMft4h
	Qm+MCkA+VdfvKhCAyHlCyySbqIJarxKy/YKFZGBTmbneO3fqrYCojljCFxng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708587740; x=1708674140; bh=i+RFLxxDEQTI7kHrG6pXNkuGHMjz
	U1LQympDsEkg4RI=; b=Zn2sSetzcecT2wpg7QdFds4f2YfaobJy7edDGCTPSLzl
	bhgreq1P8lgLNIWAUOWzQOA4ncp+wDWOPpeHd1WK10alIC82kbOatOMDdcwMidDd
	elbFppqjLPSmd4jbL4ZW1uVzaZoQ0B+EYBHf7FysXXJG49Jlw+tHS8WAn3/3x9HX
	33Sab9WuHY4KVlesj820rMDigUZSYtgRPZW7WnCz1ztSMKK3NpxOGS7rno+Lna/5
	UG++qS+lUmj0OfWjnlV2Eyc8kCtmT9ATNikmBodXsHrrOrbjI+LBgCEtKvxcxS41
	5dFcJUbrmz62PDUOkhNLRNW5cN+hnlRjHaCDZt62QQ==
X-ME-Sender: <xms:2_rWZZM3qbWW3fpYmYPCRN9ZgS85ETFeiOx_ORu8RmAibCu94VeU5A>
    <xme:2_rWZb_XdF7y9tP0jT4yCy1ZG-LINyp-sdeoRVMK1g50e4Sk0JUFyC9hyz4W2_qVx
    EJCUuo1MKgWIA>
X-ME-Received: <xmr:2_rWZYTOCa-iQXoz0B8k3AfCjThkS96Fx77-8CnXXPX7mGPim1gXIZ83jSkKTk8ryqxnLkfegOz0VwHhX5CU7LVsdsl1DPnMWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:2_rWZVvySnU60PdNpA1pIWF_NF169pR4AbbHfdCpbXNgZQrXgL9p0g>
    <xmx:2_rWZRe3ztjaK32MhI26_N374AC_aKAt6Cny0YXCpzK-szCRYFafWA>
    <xmx:2_rWZR07nUSrqg4sFItiyWpSVVjze6ScSGcGovmMlFYPtHDuCPhpOw>
    <xmx:3PrWZU91pIFOnfkJ3UfXie44-PzOSp2IhSsYJe5-nDITW2dqyUBa5g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 02:42:19 -0500 (EST)
Date: Thu, 22 Feb 2024 08:42:17 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the regulator tree
Message-ID: <2024022212-uninjured-hunter-88d5@gregkh>
References: <20240222153826.3f7eba10@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222153826.3f7eba10@canb.auug.org.au>

On Thu, Feb 22, 2024 at 03:38:26PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> 
> between commits:
> 
>   ec29a4d9b7c7 ("dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM6150 compatible")
>   b9262cc1b988 ("regulator: dt-bindings: qcom,usb-vbus-regulator: add support for PM4125")
> 
> from the regulator tree and commit:
> 
>   ef6035d2f1f4 ("dt-bindings: regulator: qcom,usb-vbus-regulator: add support for PMI632")
> 
> from the usb tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> index 8afb40c67af3,66dcd5ce03e6..000000000000
> --- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
> @@@ -24,8 -24,7 +24,9 @@@ properties
>             - qcom,pm8150b-vbus-reg
>         - items:
>             - enum:
>  +              - qcom,pm4125-vbus-reg
>  +              - qcom,pm6150-vbus-reg
> +               - qcom,pmi632-vbus-reg
>             - const: qcom,pm8150b-vbus-reg
>   
>     reg:


Looks good, thanks!

