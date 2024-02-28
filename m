Return-Path: <linux-kernel+bounces-85669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9777786B8F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531B42877EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B727415D5DE;
	Wed, 28 Feb 2024 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="AEhHW8sJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DHNOCstp"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67E97443E;
	Wed, 28 Feb 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151582; cv=none; b=i5MfrEbQP7xlav4WCYeNmnp4GHr24pfXWVZosi4fi71YYxOljrQNqNZbRQtHNd5agxT4ZUFZOgNk+uLD/9WZDocoVdN854O2knp4hzh7otvw91F1PF7EhmRy3Otm4vaOPwVnDR1nWzBsHD/Emz9BAiReJoa6qRCAT26sJx7PDtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151582; c=relaxed/simple;
	bh=/9L3DBtbXtiqRZ4uR4tPFzGS3wIV0RaN22OwhuvbyNc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=So2jShHJl9lnMBkKHMhAaO2H+6NVap/BlD7bjzIoGijIfwKUF98wSVjn8T89HZpGDGlhAziDFsXfdyQwXHPtQ9isinBGFCUgWewRs4UZvL+1BDnmjWQ6HyPPDI4o4Osy/3bDZWXqFnWuCMfmwv4hK90PGW2OCt9JCoshOWdnvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=AEhHW8sJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DHNOCstp; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A75E15C01B4;
	Wed, 28 Feb 2024 15:19:38 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Wed, 28 Feb 2024 15:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709151578; x=1709237978; bh=SI1WZrdEHb
	GY7yRHKfhJa7GjrhCFBsUpnVyqS36ad9Y=; b=AEhHW8sJZLY7jmKGeOm+msqebc
	lYo1RTshosJNRv23KKaivXoSSJELzND7Xe9ZhrmUmFKNOsIay6GSptTou0VtM1To
	2DfmcbkeyR1fTVF+GU31OE82EoQFTLcyv6H0ZDcikEKKNyAW/S60SYS9GDhkcYUq
	2M3ZBghSZMxXsRBq0O9J2eMDhuUtKlTvdPykvbk+8RBoLJjsxtj9hTMyMDh13PIG
	/U4FGXlnpsTVYFWrF6NvED9zm88QF1n7fwr0tcBlvhJMWv30K52lY6dmCUe22Slr
	hVu5RMxzXd2vQMX4vqEDvcbpE2Jz3FoE/zhVeSeGgRmbm/EJw9P5Ag7uFmfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709151578; x=1709237978; bh=SI1WZrdEHbGY7yRHKfhJa7GjrhCF
	BsUpnVyqS36ad9Y=; b=DHNOCstpxVPTF60f+6+mhdgpeN7IL/YRJw/ln91/BqUL
	0gnMyo2DQmV3OEqirmDu2ZeRToBfvdAbJNvZ3s7Vo6llaBGhBmnr6m3P+bLp0nM1
	TScMN1kvVQC0aodz94ehrAEBC1PisqSS32q1q3WXIQrYzf4pEb2zpG5W/lOUsAh5
	MdiI6YiTMOHjThusY1figxF1TsJ4IwDzOKrgC0AmVKKa/E/yZKBbeiB/R3swMfDn
	Yrx96V08DdPX8OnzrWSap2BIRuWaUFt6dd1YYDoszWesLlPePJTBXCTlGBTrBd6F
	enW93WFbwdcAy3RRTpyTke7waRsIfpM9oUWMcLBpQw==
X-ME-Sender: <xms:WZXfZdnlr0raNfJoGqqGkL2Eho7ESRQXb_DxuUhOyQk-B6NObJxaig>
    <xme:WZXfZY3vZy-guV9VL-cP73RtZmNywA2ryMI1qUXX-mdi_H89pt3bsN5vd9yok96_S
    n-14AoBPFM-gqCYyw0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeejgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:WZXfZToF1qMiKJY_LeDdcSs3rKNpAeAaUrT99Wpvk3t9r3PCzit4dg>
    <xmx:WZXfZdnBLW0vaS24DtFT7LGsAWgUDwFZPfLCvlici7VHv4ASU62ZXg>
    <xmx:WZXfZb1D9LZ7N0M1StnC3HfZbfPB05hywaMpyWqchvxrgMzpFNV6dA>
    <xmx:WpXfZcz1w7rZzULs2RS2wU9hN_jykhXYmWVaaBQO3fnFDiNK_qKa8A>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 948D2C60097; Wed, 28 Feb 2024 15:19:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-182-gaab6630818-fm-20240222.002-gaab66308
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fdda6515-3b13-4727-9304-c740c77003ec@app.fastmail.com>
In-Reply-To: <d6d0806e-5b5d-474c-affa-d43d88785275@redhat.com>
References: <20240228150149.4799-1-vishnuocv@gmail.com>
 <d6d0806e-5b5d-474c-affa-d43d88785275@redhat.com>
Date: Wed, 28 Feb 2024 15:19:50 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Hans de Goede" <hdegoede@redhat.com>,
 "Vishnu Sankar" <vishnuocv@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: 
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Vishnu Sankar" <vsankar@lenovo.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add more ThinkPads with non-standard
 reg address for fan
Content-Type: text/plain

Hi Hans,

On Wed, Feb 28, 2024, at 11:09 AM, Hans de Goede wrote:
> Hi,
>
> On 2/28/24 16:01, Vishnu Sankar wrote:
>> Add more ThinkPads with non-standard register addresses to read fan values.
>> 
>> ThinkPads added are L13 Yoga Gen1, X13 Yoga Gen1, L380, L390, 11e Gen5 GL,
>> 11e Gen5 GL-R, 11e Gen5 KL-Y.
>> 
>> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
>
> Thanks, I have no objection against this patch:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> But this feels like it will become a game of whack-a-mole.
>
> Mark can you reach out to the ThinkPad firmware team and
> figure out if there is some supported way to automatically detect
> this ?
>
These are all older platforms and we're not expecting to see this on any newer platforms...if it shows up it's because they messed up (there is a spec and they're supposed to follow it).
Vishnu did review with the FW team which platforms had used this implementation, and we believe the list below to be complete.

Vishnu, please correct me if you've heard otherwise.

As a note, I did review this during an internal review, before Vishnu pushed it, so I'll add:

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

