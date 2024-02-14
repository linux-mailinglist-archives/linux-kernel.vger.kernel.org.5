Return-Path: <linux-kernel+bounces-65059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A553854741
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0ED1C22130
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CFA18027;
	Wed, 14 Feb 2024 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bLjuLiUe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndd8+Bfc"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38CC611A;
	Wed, 14 Feb 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907098; cv=none; b=TVM6tCN3DcY1ND5klY7nmF4p+gSPCFdEx+Zwft7hn2BnZbzwSUlIoB//bpk0MjC0hrsL7HiwttdEvgrxxu4l6Fp+LkvLKYcOF2lGvW9NnZVTKutEw+Xjfo2V+h1DmKuu6+XL3zmj0NM1BvFedwbzjFLz2PduvT+UwBewqCy7Sgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907098; c=relaxed/simple;
	bh=v5CFtEaWyN8p5OJ7qhiRN25Xg0hRyL/byYYg7V2/FY0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=aICJKx7MHcFwfYijsbzU4NXcJyH+jaJFtfcz12w4KcxWmyPHIXBp7XnVJPJh/M0GxLoMGqu9wWDychMPMyGFKx9kwcuIHWF5FQsjTWsHl9CkuvDfgoQTz49b7PZkvtgVVa0azpRS7OS6rAsB5Tu9ozMRrUm9nm4yqSD7xAIfv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bLjuLiUe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ndd8+Bfc; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 31B471C00070;
	Wed, 14 Feb 2024 05:38:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 05:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707907094; x=1707993494; bh=hsAwWJXbZP
	PI/cnP33KCPKaERFMiR+GhoK31+f3s78A=; b=bLjuLiUeHArSfkef+Wd6hi4JSZ
	uzR/mr6mPiImtzU92m7boaR/S3qb8gazw5An9VYAP8GSPqTUisgIzs40In7MwtDR
	ioQPgLuAx8ExbNosqTg1/qCSxPh3k+ZZ2HOiPLsPQPqLdBIRkq3V7B5JR82Q5F+Z
	VO8KHyZyXT8B07WvHD0ID6lErwdSko+r8Gb85RuZbKf1/+n6yJdoGs7oBVO6pyY/
	PB+OD/NHMqBfEUOKuj3bbsRnJS9peCWzy90Sf770RA0VCFRS+2BWEux1puit2dyX
	rxyD2k8UNtLSc730s3y2D67FrBqehIwshr7THNZ2sp3sY/hRj7n+UKnELqYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707907094; x=1707993494; bh=hsAwWJXbZPPI/cnP33KCPKaERFMi
	R+GhoK31+f3s78A=; b=ndd8+BfctchXQ/AjAbk8pLKgxqHR4DZNOjdlkQTKhqxy
	xUq8wdRBBYh8L08eAw2NCp2gXdsHG/jpDtgOCCLu2luOzZue3eM4dJ2S2hVrtkdE
	B2hy1MNG7qNtwazBReU02j9HR9CIgy9Y173IWOvDzwUCt4Zb/xAY8Q09oSV1yuTE
	SHRD3lw4Gm2tkrz1rOYgbRK7UD9ViYsc9+naIlphsqa1n3ENpY2/oMw5KSuAAgu7
	lV8efUY+PDxRYZJjt2EzQzqsTy0EugOdMHnGiRmV+xkMyPkqIP1qCURb0nraFFNI
	JJimtZtmAz0yEx0FjaRumCvAQepFyInmuyNSshIAQw==
X-ME-Sender: <xms:FpjMZX9nsMfUEhw23aFDNY6xqqF4U-TDgIpzPzniQIDQ6xZlTYXJbw>
    <xme:FpjMZTtHIla148Ndnxzf0szn95jFQLSpj8-aLhJ4aYbb081wPnq82v3pkV91pekJs
    ohMwMlHCf79Av0-DDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:FpjMZVCuW0SbRLGhEKESMu7pqkLSLc01Tit5nY405FrCJUaOimdZbA>
    <xmx:FpjMZTeESNBnx_kTCNm1IGs5894e2nN4U4IF5CnjaJ39M-7HrONstw>
    <xmx:FpjMZcN5oaaGAdL53lB5sswES1k3g1WR4RekmyACIdVQPDdNxbDIiA>
    <xmx:FpjMZdECtm7lFqNpDxD1lmPpnTZF0zwCpIfrsFRhUieXUYCHDQVINOAJQvc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 64771B6008D; Wed, 14 Feb 2024 05:38:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <08ac32ef-610d-479d-a3fd-a3c3b8c4c697@app.fastmail.com>
In-Reply-To: <170790025305.3179441.138152315558305278.kvalo@kernel.org>
References: <20240213100912.459018-1-arnd@kernel.org>
 <170790025305.3179441.138152315558305278.kvalo@kernel.org>
Date: Wed, 14 Feb 2024 11:37:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kalle Valo" <kvalo@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Jeff Johnson" <quic_jjohnson@quicinc.com>,
 "Karthikeyan Periyasamy" <quic_periyasa@quicinc.com>,
 "Aloka Dixit" <quic_alokad@quicinc.com>, "Wen Gong" <quic_wgong@quicinc.com>,
 "Muna Sinada" <quic_msinada@quicinc.com>,
 "Aditya Kumar Singh" <quic_adisi@quicinc.com>, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: sanitize ath12k_mac_allocate() return code
Content-Type: text/plain

On Wed, Feb 14, 2024, at 09:44, Kalle Valo wrote:
> Arnd Bergmann <arnd@kernel.org> wrote:
>
>> The return code has no initializer:
>> 
>> drivers/net/wireless/ath/ath12k/mac.c:8006:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>> 
>> Make it return -ENOMEM for allocation failures and remove the unused
>> variable instead.
>> 
>> Fixes: 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211 hw")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>
> Nathan already fixed this:
>
> https://git.kernel.org/kvalo/ath/c/04edb5dc68f4
>
> Patch set to Rejected.

Ok, sounds good. Nathan's patch looks fine to me, but
I see it's not in linux-next yet as of today.

     Arnd

