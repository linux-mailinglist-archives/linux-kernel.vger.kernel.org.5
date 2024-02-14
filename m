Return-Path: <linux-kernel+bounces-65077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C861C854783
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69AE7B26E23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFAC18B02;
	Wed, 14 Feb 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Nq5u5pgS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Co5CI5Wb"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D018027;
	Wed, 14 Feb 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907728; cv=none; b=WETmMnwp+Qcj7PVXdX1LZJ09jb2QkT7UfZ+Yu7YJ+YlsarAbwr4Haoczka0DDBe49u6fHIY9B5wGFpqYcTuCEby5MQ/XnosYd+GfP8DcB/YB7UBe2WxPhJHP9OPP1L6upN3waTNR1N82sFrmAGW0135D6pkHAnuFFdsZhdeMi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907728; c=relaxed/simple;
	bh=HOpVLzrkwrpaCaBOGts1En5J/94ABppLQek5BJX4AhA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UCwafJnMccTzO2CkJ4QIJ8I/hQtx36wMgon1VYoggZE/FE2Wv8fzx5AP2y5M8lZjZzdv+pW5FxfQxSoeXcSI710XP2//mvyxK10+KPzEK/XgIwzbqlMOI39bc3NENtFy2m6nyF7UZXYTZHRoys3naSnrv3FD9dv07JPUXRxqUrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Nq5u5pgS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Co5CI5Wb; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 94F583200922;
	Wed, 14 Feb 2024 05:48:45 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 05:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707907725; x=1707994125; bh=Gv8xUDfNBj
	Pjg5I7E95yOUAvwqbLQDclBoZX6xao6eM=; b=Nq5u5pgSom8OH60hq1TO3E+HA0
	BUCjxVQ6+I7qef/2NBMMRwnucMwMG53MgFy5nLtKWHKszZbyLnxXpAYQxzbwEkHB
	agQesBZKwWU6i8zY4agdN5ruGJEnt6HnIsCmwEBPBZLWlriNjH/Gj2vTex6ydO1Q
	VosvTScviDzZUH4XzTAC1hlW4hPizpf0XsDX3z9qE0/7pqUeuTsDmHcqtl94XEDi
	k2CmrDvmUNGuypQfOaDyQSdmXCU3FVAbbPeFzhUeD8pgqZihyqCLghn5Owevpj5y
	vlS7yq2LLDOjhYjwkAxRs9gEJ7n22avQNuE9jK40vqGNi0mF9g7uEJnA2tsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707907725; x=1707994125; bh=Gv8xUDfNBjPjg5I7E95yOUAvwqbL
	QDclBoZX6xao6eM=; b=Co5CI5WbaBOcbD1KZF8SRnZrx6JiUtx/k8adKwLIaFM+
	MvBMv4yoW+ispyB/y5hxvBDey3+8Ex3TTDx5OPIRyQpqyvHhnk09UBZbiMil/3b4
	lqey2f0oazZmAxIQi4N3Ls8xODeu85zoilyEIquKpvbWFBUOMm/c1ARH6jugIhkh
	iMgm2gMCiRsgiK+D7oEusf8TjcN30UzCHN2hl+xrDgR106dNMEr+DOdKiKoMBbF8
	aB573HgR8pn43F6gFdqCYJAi25rRzhEvcnO+GWouvVU6UdVMSFT6tuEn/TGhHbwI
	ADccQbLCYHL7YmS6wWEcBW6EMoZFMyUyflwsrjMm8Q==
X-ME-Sender: <xms:jJrMZS32twMt4Ggu8XtwrULRdriOJRbtCqHOHQ8u5sNKpAONBvxqPQ>
    <xme:jJrMZVFb8hvwHYO_DpOMDOjDD50L_fWLvCGenWJ4QwythyC7X2SgI2tcj6GbRhAWq
    eKDUc882WtIovaMu64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:jJrMZa7_RwgI3e_r-FzJTezqjml0aoH5KdKNHaj5rBVFF5UHefXHwQ>
    <xmx:jJrMZT2dqRM8p-1LEE2aXWYXL3FTwyDVkp4GvE9xhobIu_prYByNfw>
    <xmx:jJrMZVGF_Nhbpm5Yu21jt9OMO1w_1_pxtjmmnZPJunUtF1tN3sSj0A>
    <xmx:jZrMZZi_l-uMFoobfdjAEB2bgrsNeeXNv8nSI3dUzMvAihxEAa-SCQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 93894B6008F; Wed, 14 Feb 2024 05:48:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2027d488-a245-4492-bc17-27e17af575fd@app.fastmail.com>
In-Reply-To: <ZcyW8zn14iIbn45X@kekkonen.localdomain>
References: <20240213095555.454392-1-arnd@kernel.org>
 <24cbf7b2-a091-440e-92cc-5c9828d52260@xs4all.nl>
 <ZcyW8zn14iIbn45X@kekkonen.localdomain>
Date: Wed, 14 Feb 2024 11:48:24 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 "Hans Verkuil" <hverkuil-cisco@xs4all.nl>
Cc: "Arnd Bergmann" <arnd@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Mauro Carvalho Chehab" <mchehab@kernel.org>
Subject: Re: [PATCH] media: v4l: marvell: select CONFIG_V4L2_ASYNC where needed
Content-Type: text/plain

On Wed, Feb 14, 2024, at 11:33, Sakari Ailus wrote:
> Hi Hans, Arnd,
>
> On Wed, Feb 14, 2024 at 11:24:41AM +0100, Hans Verkuil wrote:
>> Arnd, Sakari,
>> 
>> Is this something that needs to go to v6.8? Or just v6.9?
>> 
>> Do we need a Fixes tag?
>
> The patch seems to be related to this:
> <URL:https://lore.kernel.org/oe-kbuild-all/202402130955.f6uxzdCA-lkp@intel.com/>.
>
> So most likely yes, and Cc: stable, too.

Ah, so lkp bisected it to that commit, which means it was
already broken in 6.5, but I'm fairly sure the bug is even
older then, as your commit seems to have only uncovered
an existing problem.

It was definitely working before ff3cc65cadb5 ("media: v4l: async,
fwnode: Improve module organisation") in linux-5.13, but it's not
clear if that is the culprit. It's probably safe to backport
to v5.15 and higher.

    Arnd

