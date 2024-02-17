Return-Path: <linux-kernel+bounces-70045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1B85923C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC0228362B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083167E597;
	Sat, 17 Feb 2024 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ye5BlsKB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMOXv2el"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5361C282;
	Sat, 17 Feb 2024 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200146; cv=none; b=SK9AD0PmBpbLPhaEmzHQlb3XKfgle1Zm+b1CschcTtwkYJvJ3D0KnPTr4HMvDJdRuX5c+7hGS1hDAjLGydRLy9R1ua8Ba3m0ACgRE6Y7yyA0XACHHwU2KGf7B/Ng6LkSX4n4MnHEQiye/Fymngvx7s5ap2lt58DKaTMFmiPYo3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200146; c=relaxed/simple;
	bh=7MOz0MScJRu+tSbU72jT7a6ptOpNL3TAgXB8d49JokU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=b2jLmw1mf5Utdn/+6Up0yHpBMkEZNZ33fzpNaZoJWCj9AiFaZ2sLXYKwB41lSCuXSXySTuODS/UYu5figavp4rx3+gS4mIegsenx81LTtrsxsTaQGoynFkDed4XI3x3mBELowDfAs8MkfdFNcx8VP3xiEX6DX5abLMlJH7sO71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ye5BlsKB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hMOXv2el; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7563D11400B7;
	Sat, 17 Feb 2024 15:02:22 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 17 Feb 2024 15:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708200142; x=1708286542; bh=1+SYOhK00Z
	m93ip2u19mSc/B1jEApIvrcfSGbkUvudY=; b=ye5BlsKB/iNlGmZiGSlHNwHg9h
	UyAonqhZ+Qc8sd9zrCLR9Mq4wqCkBB3lCgSI1m9fiiq4Vru45acoh5bcB3aDkolz
	qgRkFkQGaEapy60f0lFTCLEcCnQt8s5BbUffMKOMYobjeXeNB08PgjJvQK0l7HRF
	jcpuWFfCVaBjE0tcBniKHy6m6aXRyNnwmc//+dx9z6YXjL23Lz+G5W15PeNRYn9S
	hNZnbHAeKR34lyMokOX2F7zlhzeS0PAh6+OrbasiAr2FvtxKcXSv4yb8/46Qjgx0
	gGBF5UQQ5u5FbHXmBUIvvf8gtine8vSzjc/2EzMlYhbzKQO+KfkoXTaQ+raQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708200142; x=1708286542; bh=1+SYOhK00Zm93ip2u19mSc/B1jEA
	pIvrcfSGbkUvudY=; b=hMOXv2elUcq6Pp3ihr74CwnBA63mkvBW9e0VNP3XXN5i
	VQhDudxvDD8/sYa0Kbz6JywUMpcE7jFRjK0OmCQhr14Zq1qqYv/c+6rcNucH9OWE
	va25oe7jYxJbHdZ1vrDIRFej5uDf+WiO0blk4485giynpyy6jMcskwJzWNigLUg3
	5PsJUd67v92kAP+wdbz1D82KOHVnWwcOwueRkloluWWnvuvlCZbngWLWtO5kNqWd
	Rec+bvCgme99QAAug4zwYkA2NVzyolUcvL69jh0qIOS3NoB0DSmaOAXqmxRDoZ69
	qlCUGiSbbaDRjEob3YQogZbOY9fUk+Va6b4Hm+Ld/w==
X-ME-Sender: <xms:zhDRZX5kIycYmLyvjNh51F0MiNckyHsGpKjRXLUlhPyB9mAf_2miVw>
    <xme:zhDRZc4ZeaZ9IrxYfwoKs7vgd9lvXwSDyfTGkxtIvDxOeLz2JpwPfoH1rN2zHxDbh
    2DkloZOC1lJEAHOwi8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:zhDRZedoBxQXphd2NBQvlTKcZNqt4FL18EwWc1uMXP9g6yxyIv53zA>
    <xmx:zhDRZYKgPns7bJNnJBUHrnsdy44jSSzttQqE4J4DKgmfy4Ly-d0wtg>
    <xmx:zhDRZbLn-q2z6xWC6SwIAK0_k16XFIEfOgnjxRBiamL2xTXggA1jMQ>
    <xmx:zhDRZYEzMS2kV3OyIyHDCb6ZRulzVRtEPP_8iDOcK7zrS1O_Xw4Ylw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 38AF0B6008F; Sat, 17 Feb 2024 15:02:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9fd866a5-ea3e-4896-803d-27b4aa08c0df@app.fastmail.com>
In-Reply-To: <20240217192042.GA372205@darkstar.musicnaut.iki.fi>
References: <20240217192042.GA372205@darkstar.musicnaut.iki.fi>
Date: Sat, 17 Feb 2024 21:01:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Aaro Koskinen" <aaro.koskinen@iki.fi>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: omap_udc: fix USB gadget regression on Palm TE
Content-Type: text/plain

On Sat, Feb 17, 2024, at 20:20, Aaro Koskinen wrote:
> When upgrading from 6.1 LTS to 6.6 LTS, I noticed the ethernet gadget
> stopped working on Palm TE.
>
> Commit 8825acd7cc8a ("ARM: omap1: remove dead code") deleted Palm TE from
> machine_without_vbus_sense(), although the board is still used. Fix that.
>
> Fixes: 8825acd7cc8a ("ARM: omap1: remove dead code")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Sorry about that, I must have used the wrong regex while
searching for these while removing a lot of the other
palm variants.

     Arnd

