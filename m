Return-Path: <linux-kernel+bounces-65088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B685479D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D502818BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1F718E14;
	Wed, 14 Feb 2024 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FCL6lLsr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xcEyjkre"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B41865C;
	Wed, 14 Feb 2024 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908312; cv=none; b=Ir/bcn5u4o1Bam73wwDwp5yQCNBOeNj3okArgXc6zNrU8hE4C7bNZJNTigJzyweYlbdB4J1efZBMLDd0zi4lpa+IU+82YlQqBH2NyoTlycydM4UYIkBeJ51ceHoafgPQsEskRPBbRnNZaZWWH1US/GrktNc2hsU/r+wXElaRt30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908312; c=relaxed/simple;
	bh=9ph6dUkS7U/r75FEQ9yX83p6NaapiLxSH/UYmW/mt/M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dHEmHrRtFl/eAvwDzlFpZh0MgkuUFXsid3y8ZdUte0iTeB2uXpxOY+cj6WRLtJfLpQ79bzfitZ61GxDb0myNVboah/+Iqvh89yCCQ1rGRTDwmrxxuU8c1AhxsjAuT5DnnXM20e5M8aN73ct2J0IeqTU3p88CntU1BgTd0wFUrZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FCL6lLsr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xcEyjkre; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 02F3C18000A9;
	Wed, 14 Feb 2024 05:58:29 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 05:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707908309; x=1707994709; bh=p6zWfoJPCL
	RzjMHq/uE2mqd1NbpzAuDrz7QCHl51kS8=; b=FCL6lLsrnMkhUXSrRJxfP1PpSv
	04viHhjxw8ebRM5WzSf5wKk4ww1e/2jjldLp0lJfDGZ4OngdttaL2VTeXdaMlmIc
	h7hp1jmfbfYBRIWhe7elhyf2ygBSnvz4z856HiSJij2PlkDqHp9ONUpYuoBjcLdu
	eIe8foZx+bacsoO/ipMuFJz/w/nxfyOan2x2NJkUjIlavUyJSRLysPd0kdAVqWRW
	hNA86UPKUxZt84/4Ufq7RvEMZExo4diydegRzUyWL8N8z63tqNNG/RqY1y2cPsmL
	0kLNLeql9MQlCEqgRypWkHN/FWAOj0g3JIMn8pfsnLma+BoAZ+rOWVLY5M8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707908309; x=1707994709; bh=p6zWfoJPCLRzjMHq/uE2mqd1Nbpz
	AuDrz7QCHl51kS8=; b=xcEyjkre5pBLxpTRhU3yZ9Y5hW39U7s1BpyxIeqaHuDk
	0Vq0O/dCLPqMqg6DxI902MHzIFPTUWGVFI+y/U8cXaSDPn1eNX47T/eWa08yvvMt
	A8YzvR0tGOPAiVkLbZ8yQmAUgA5/v5ofbTml2jwgyavwIx+ZsGeOVfZpSzuFSamj
	TIYeG9AFLpPOphaSvEzfvIzyEcXkejkFAgjtrHqDbNcOKGM0HoIfwvlyekj5ypoY
	Iq1qwoQHdyP1LfK3RsHQM8JXNZeSUsec6DR6dIAL0mO62w2oMUqPnDc1K5WyXkoz
	U4qEzZhzZjG0ZJvxOZceyVTXPkrtfggI8KeqfHU2oA==
X-ME-Sender: <xms:1ZzMZVIqvrzcITYzRYeqbusnutuKZb1wElFgu2VgspQzdpuk3I5IlQ>
    <xme:1ZzMZRLNi54647A9mt8p2jC1EcBA6jK4m5mehA-fhVmRrsKEoG9En_ZQjfNLMcATS
    PzdVUPjkh4rI4QckIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:1ZzMZdvUvLshATq6De9SbVkosnM-GkTDkU1hVag8iUonbg5Jy8LMXw>
    <xmx:1ZzMZWbPav-uWAhI-mKkNLyI95LqkZ-I0O6qt1bmu-oRFfYxEWgz4A>
    <xmx:1ZzMZca2G5mWDPLAXSqXr4jsS78mfeCfzQV3VcTVJb0qGf8JF48jCA>
    <xmx:1ZzMZbwD3FPrIR2WUBG2z4AloARe47du-aCRmUqRW8PWSlCMbEClEFXHFCE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3887EB6008D; Wed, 14 Feb 2024 05:58:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7ec182c6-bd52-4433-bf06-dbc71f186184@app.fastmail.com>
In-Reply-To: <6067898e-eaac-4266-b4a3-388db9a918fa@xs4all.nl>
References: <20240213095555.454392-1-arnd@kernel.org>
 <24cbf7b2-a091-440e-92cc-5c9828d52260@xs4all.nl>
 <ZcyW8zn14iIbn45X@kekkonen.localdomain>
 <2027d488-a245-4492-bc17-27e17af575fd@app.fastmail.com>
 <6067898e-eaac-4266-b4a3-388db9a918fa@xs4all.nl>
Date: Wed, 14 Feb 2024 11:58:07 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Mauro Carvalho Chehab" <mchehab@kernel.org>
Subject: Re: [PATCH] media: v4l: marvell: select CONFIG_V4L2_ASYNC where needed
Content-Type: text/plain

On Wed, Feb 14, 2024, at 11:54, Hans Verkuil wrote:
> On 14/02/2024 11:48, Arnd Bergmann wrote:
>
>> It was definitely working before ff3cc65cadb5 ("media: v4l: async,
>> fwnode: Improve module organisation") in linux-5.13, but it's not
>> clear if that is the culprit. It's probably safe to backport
>> to v5.15 and higher.
>
>
> If it has been broken for so long, then should we bother with v6.8?
>
> I'm not saying we should, I just like to get your opinion on this.

I don't have a strong opinion either way, there is very little
risk and very little benefit in backporting.

If we apply it to 6.8 at all, I think it should also be in
v5.15+ LTS and vice versa, but only queuing it for 6.9 is
fine with me, too.

     Arnd

