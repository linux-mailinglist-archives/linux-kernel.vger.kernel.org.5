Return-Path: <linux-kernel+bounces-164155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2D8B79F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B20AB21358
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402A31836EE;
	Tue, 30 Apr 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DiVmsIEn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X69BSx4N"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA41836E8;
	Tue, 30 Apr 2024 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487463; cv=none; b=UTtoCAU5EzhzxEcHI1ihL1Uz/jIxQrcwyd7MohuFch4X2B/yGWAg1UIsS0XkQiqgjEu31WMAPPhQHxlYxiVqXswBwrauQzbE3OSvksGkLP3Jzh3BUBN9yOvNAM/hZGS080022BkgYDvJr/q2nUizl1tmjffTlOMb8y5LFVTALtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487463; c=relaxed/simple;
	bh=6zYoaw+dgG3Bu9DdBmF+t1atFZ+VM7VFTnbJ1A42nnI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=KgekjbplNsTxMQQ7fatIobfwGXp0LMiKkQbuch/XCP1zcoqIpkgix/URUVXeXJwQdedstiIbnfFRLhnZpoDJyPoB1jFtDVyBoZitJlQrRUFolssiXMBBHeRDVpaQYllYLn/h4/SMQpMGuFdh2IUAR2vj8704J9Wp+g9HrLL00qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DiVmsIEn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X69BSx4N; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 680F2180017E;
	Tue, 30 Apr 2024 10:30:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 10:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714487457; x=1714573857; bh=JcfQhI0Wws
	uSGe/INWfe6PfQ7Tf+kyGI91zAGGmpZBQ=; b=DiVmsIEnmgmwAwDHc+SjO2CRUb
	Tfy4slCC9D2xsDE2rved+525uP6obJ2gZ+G5WD0wPHYuEeZi6PXP3r5+5reaXWtq
	E63+F/cF+Ezp7EGKT4cxfL0XBksuzR69x7NxAhf0l4k82lgwRKBzpwoKgpRgR9Gu
	r7qaENdzj5nVEu4qrIAorvbmsk28WcbLdx2veMMs6FywWl+7ysoy8JYxoLeeUDhE
	+MqIsoFrGThnZ+GsC06fo5e/rKJfVX1O8uz961z0rS7bUqRRFF9h7F9+Ck0xJz0O
	FvDNB7UxZWQ7M4NfkD+wlS3HvSQLZp9mDWG829hStYz645ipl3QU2HSBYKDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714487457; x=1714573857; bh=JcfQhI0WwsuSGe/INWfe6PfQ7Tf+
	kyGI91zAGGmpZBQ=; b=X69BSx4N3WpZm8NluzBuS7rxAhLCzgRJZXJ/j4lnHCjm
	87xIVYofta72ZERvrO+4tE6XfSjinLYo6qSCbfaDXxt8eObWjBzHkKN0+y6p20kS
	axmXOxqtzm+30onx4giOolIz95x6zYG3eapPAcrnLXTn+xAcz9n1r/4gzSU5Cc3c
	jBHbFxU1yS7NgjNJ+BLbA5Yy5oVWwtpXNANeooKcBAArlxGnFNxfthTpShpDesGZ
	UqGCeAH162kZnrI91j+mMn2hkhhd+8mPk8fWX9CpoRm/qlkYzo4/Vj2SRX3h9VZ+
	aPf99XaxDBSwXYZ1bGelyEM9iM4LqpiU0N1wFPaVLg==
X-ME-Sender: <xms:oQAxZisTvI-i6JMT3FNNbk9l0tm1RcHOoPEsQGzQNe_eZmVhwthPIA>
    <xme:oQAxZnfn5mkOQu8kQEhNSCVhwJJgztApWbCeNpO3CYwq-OQBri0iX54lFb2hOINzR
    ig3mzpEhAx_FkiGaqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:oQAxZtzPWRadQLIvw4FDz3PvuL0iv94FY79yaK0Xiy9rcCZqAFNdow>
    <xmx:oQAxZtOUsOCN7iPiZyiAxeBQQdZt3SASfH6mLiq_s1Xk-wt57UPmHg>
    <xmx:oQAxZi-0rLmSvlrKzqAM9S-EWZ6-g4jiEuZyDsnAm5bss4vU-05_rw>
    <xmx:oQAxZlWOpZZha1gh8epZsNrepJIurAcL2hY0sxmlsLGS-hduRf0GxQ>
    <xmx:oQAxZtdkFLYlpDvOtK-MNJ1bZ_cTd9v_pOTU2-BxdVxMn_zOYQWNdcgk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6800EB6008D; Tue, 30 Apr 2024 10:30:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-416-g2c1796742e-fm-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <99ef1ba3-155f-47e8-b1a4-e46cb056cbfd@app.fastmail.com>
In-Reply-To: <20240430141609.2244416-1-hca@linux.ibm.com>
References: 
 <CA+G9fYuP7S+a89Ep5g5_Ad69EMwRkJ8nM+MMTzbEcP+6H2oMXQ@mail.gmail.com>
 <20240430141609.2244416-1-hca@linux.ibm.com>
Date: Tue, 30 Apr 2024 16:30:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 "open list" <linux-kernel@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>, imx@lists.linux.dev,
 "Abel Vesa" <abelvesa@kernel.org>, "Abel Vesa" <abel.vesa@linaro.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc: "Shengjiu Wang" <shengjiu.wang@nxp.com>,
 "Shawn Guo" <shawnguo@kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>, "Peng Fan" <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: imx: imx8mp: Add missing CONFIG_PM ifdefs
Content-Type: text/plain

On Tue, Apr 30, 2024, at 16:16, Heiko Carstens wrote:
> Add missing CONFIG_PM ifdefs to fix this allmodconfig compile error:
>
> drivers/clk/imx/clk-imx8mp-audiomix.c:356:12: error:
> 'clk_imx8mp_audiomix_runtime_suspend' defined but not used
> [-Werror=unused-function]
>   356 | static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: 
> https://lore.kernel.org/r/CA+G9fYuP7S+a89Ep5g5_Ad69EMwRkJ8nM+MMTzbEcP+6H2oMXQ@mail.gmail.com
> Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for 
> power saving")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Thanks for your patch. I see the bug as well, but
I think a better fix is to replace the deprecated
SET_RUNTIME_PM_OPS() and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()
with the modern variants, RUNTIME_PM_OPS() and
RUNTIME_PM_OPS().

      Arnd

