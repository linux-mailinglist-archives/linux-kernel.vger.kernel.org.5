Return-Path: <linux-kernel+bounces-136844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E5289D8E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDD62891BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78E12B14A;
	Tue,  9 Apr 2024 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GGOz4e/a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dbh4t+k9"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0AD80043
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664628; cv=none; b=szcdUEwMwiqNzZJtdBHrsPF2ztnvJPkrGhNqCZ73ysbf0Cb3JxB8RSaI0lWdg99H1eRZH1ObWrH649YPOBdq7IKRFXfT+cBYT2mlHbHWSce7y8zLDJeJ4NwDi2uNb60AIPzKHe1FPfisfZOxaYi0J7YePVGWJXu+jAJ7im0J4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664628; c=relaxed/simple;
	bh=erbXGW/M+Xty1hL53Fqvc1ZYzG/XyCgMySLPieBW+Oc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=edaqd1JTS93l8bs1kw2fMCYR1kbiN56chNo/EqANeOZa20eF9tnFf84+qGjbk/uBXLqpspzJgDwdwbZAP0NxuFsZ1Iy+4IUUhsjmvfMsnjC9uNt4lJuCOE8N6+OduEv1sUSbVe8eltLy3624o8eSm1+RvfwuNZOIgNW8SflPm3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GGOz4e/a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dbh4t+k9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 395711140127;
	Tue,  9 Apr 2024 08:10:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Apr 2024 08:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712664625; x=1712751025; bh=qvSByVXAml
	qSRB1qXvqxYiPsRO3paO5Ak4eUImaHcGA=; b=GGOz4e/aj9fUgh5mglF0Fmg5tN
	o/B7jGJhrDPLWUC2I7NJkMXmL8QCsKop63UQFcLu8jyReA4JoG0iRykjKKGSdVHs
	rUd7HxiIVVkiaeuyKmd5HoolEcC1zcRBdee4ZECzpUznvUpGxq1p8pILHL1O6Ny6
	bJKUoc9rmhm3mBotFkO14IwPOyQj2fUW+4p6DpTofqUD1x/vgwTr7LDK9Z/U6wRN
	dEYCsHBIkL7OQuGlt7CjbPcoCmYQh3fhyS8z4O4gGA2InVTLpNaH+qKLx9B+S4/M
	D4ucRAwfo0X5IWKOwwvBy0gV4Vj+sCIxODS27lduaqH+ITxcPq/daNJ6k3Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712664625; x=1712751025; bh=qvSByVXAmlqSRB1qXvqxYiPsRO3p
	aO5Ak4eUImaHcGA=; b=Dbh4t+k9oFNObAaahIuj5bOEg6TykwD2Y4ac+vOQWeI/
	tJl6njgdom09iOyG3XK/uG/egadkmbCbl87TBXwiy5eYKtS260TJKcWZEIQDZWut
	zGAmOgTKdoxOg8gM3S2C+VT9B2hB3oEh3q1gvfWafgseoc8D7gC+ImfyEG+TBhUU
	tQcSIbQFMnyd2khI4n92Nt5Ut8/gIRAPqDwu7pixumvqF1sYk2u8shU9b8h2r+wB
	he/v4wRaW4DL0x8Li8JWttIKHHjtBh9OPKxqjAVteKw6KKMty9cdObVAh33KPYVy
	1OO0ytXYWZKLb+Iod6yk95BmgAA1U+FBJbYm/jmJhA==
X-ME-Sender: <xms:MDAVZq7tt02H3a72SuRNkahZFwHL2iNTDegkFqw8i80xO8GmPRjOFA>
    <xme:MDAVZj6jOJ_2BvJI7qSb4jLuKl3v5lh7K1Qi9qzMuDF6nfDo08cyOYWnll3lptwm-
    FnxZDyKHF3YVbMnj5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehtddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:MDAVZpeNT-a6JVsz19EUcydKRVodKopV9UMcJopwLfdFKUspSexkdA>
    <xmx:MDAVZnJfLEcefnVxVmOVXxo0RygB3I-g_mcEfiJRHipMp9YyFd7s6Q>
    <xmx:MDAVZuLTAEHHxF7Ka7IR2iXfO57aZkd8eHePw9TzcGid-mxcTsRqvg>
    <xmx:MDAVZozf9TwoFQyZzRDxoetk_DKy_eNWXOFcWyrerduDqeVJPKZYHQ>
    <xmx:MTAVZq0qbrokf1avFRVkjAhkyw8beUYq15HnCvIWwPxFPvviPWEMwlhk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CFD7CB6008D; Tue,  9 Apr 2024 08:10:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d373379-5a6e-4b9c-af53-f8ab54dd4680@app.fastmail.com>
In-Reply-To: <20240409120605.4138472-2-Pascal.FONTAIN@bachmann.info>
References: <20240409120605.4138472-1-Pascal.FONTAIN@bachmann.info>
 <20240409120605.4138472-2-Pascal.FONTAIN@bachmann.info>
Date: Tue, 09 Apr 2024 14:10:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Pascal FONTAIN" <Pascal.FONTAIN@bachmann.info>,
 linux-kernel@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Andrew Davis" <afd@ti.com>
Subject: Re: [PATCH v3 1/2] misc: sram: Move probe of sram subsystem
Content-Type: text/plain

On Tue, Apr 9, 2024, at 14:06, Pascal FONTAIN wrote:
> From: Pascal Fontain <pascal.fontain@bachmann.info>
>
> The sram subsystem might use the dma-buf subsystem which only gets
> initialized in subsys_initcall phase. Because of this we move the sram
> initcall into the device phase.
>
> Signed-off-by: Pascal Fontain <pascal.fontain@bachmann.info>

This does not look safe unless you check all users of the sram
driver to ensure they are not needed early and they can handle
deferred probing.

      Arnd

