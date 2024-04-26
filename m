Return-Path: <linux-kernel+bounces-159391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D6F8B2E14
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C304F1F231A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC82EBB;
	Fri, 26 Apr 2024 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="w1klMiVW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQpLYFUo"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0393380;
	Fri, 26 Apr 2024 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091935; cv=none; b=Dmvwr2TOKBpXdKP85b2ix7jhM6blIY5cz3BwWzvr/rrRPlgIjwSxeWj7Syx7KgrgqIoLEAjPUJUSAQ0K65Z4zQXLpBgoB6AejkTuFUuW67WnGFRKrL779yr7du2y9L4UgNjflmKHuu0qNq42h0ghtVQdI3T1FYxjtrWl4Kxf8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091935; c=relaxed/simple;
	bh=6WuPT3KnvxGNm98XUMHDHiNGK0DhGNVKYQ+PLvFq/yQ=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjxa338e3vX7BBjmjD6TODnGpn+VHuZry5NtsXZL9Qt9miyDz/mIDI7ksWs6FVRfQzwomQSnTs/hUIaQktM+GouK9xxllQAaaVAIlFLUoMD6a0ZJeGHg55yvLbtRPi9GUGJCQsEKI1y7bScRRlJmB7hBYVl74ut3t3wm+KHtc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=w1klMiVW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQpLYFUo; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BBB0511400AC;
	Thu, 25 Apr 2024 20:38:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 25 Apr 2024 20:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714091932; x=1714178332; bh=10h3WB31EW
	lToZuGsEXjKLakOkE9Sz0sCjPh3rFbWmM=; b=w1klMiVWVrX4eCOwm9pQK5q0/M
	FEIVMi47yYcnYbZJbBsT6jNruszgOcy2LkfPGsQb1ACc7BgDkkuZ3P99LpyU5RAO
	ta6HcaAsk7VF3VjYg147leKHctvFR7NOLCNPYKeez/83eQNusPXB4aRNoM33eNT+
	49p0gI56r8D69+/C9eCzGGxD8a2pY0Myv/5pvRS50ODj6ZsUBgxbXskFfa2EXSR0
	H2FmVxQ022GdJ6RivNLtmhh+vsdJtXHXQq7CDiJNYbZfKVId7kuJ7yoBbKdap/sv
	Rc0v/ruN7U8wMJMYiO2QIUvdz9vcUM5WDv0wjcBCLnAZtCJThMF9jiAnF6iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714091932; x=1714178332; bh=10h3WB31EWlToZuGsEXjKLakOkE9
	Sz0sCjPh3rFbWmM=; b=GQpLYFUo488rTkT/y2UZd+bb/8og0e4c90hV3p6dedP6
	9wel9WqEndOaPvacGc19ZbkL0tsORWF8OnhLP6glQRaN9BfkzsV/VkaGSdteVnV0
	Ztq1oeN4HqkUNl3NNwLA/ABAN9CfjvLIF3ScmRQlDrMCTHe55GjDGHjrrpaFF8cV
	HaVdFODdq0bmum2x2eI6FvB043GY2rbiLGoYtgPPEgAnfqoF7IiU/T4kH+0L7xXc
	5qI4xCc//t7v/piJMEzHaOPPS4SUgI/uUF5C8a8MQirCu2KFupFk818AvXSGlzU7
	Q51KTkSu0S6moHFal9RZ3myDQvGk5YzYjASuzYeOGA==
X-ME-Sender: <xms:m_cqZoaeAEPInh34e1HKVIDCqpttV7ogSYpvjRJ_XplN4MpN1wvZrw>
    <xme:m_cqZjb_LbWgf3raeURYc_oLiigMc0OaHRr2-jvwIqx8VDzgVRqz9GRpOGG7yrUi1
    mI0jnRrcpASDO29vp0>
X-ME-Received: <xmr:m_cqZi-GCIkEeTdupPExjBLqSTWsauBNCQkeGR2XIA1pisA-tNCl6MSAKC3B-qy0JIv09jo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelkedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfihnhgu
    ohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqnecuggftrf
    grthhtvghrnhepjeffueekgeeijefhvddugedtkeefveevtefghfevfeeufffgvdevleei
    udfhtddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:m_cqZirIZrtdfcQINAinoZpMzlVB4ju7UR4fGYx7-0JE8hglE_AJew>
    <xmx:m_cqZjq6lFFwGnsWYjeahuGeePcmtAAC22q37jgL2M6Bk_JkcJEoBg>
    <xmx:m_cqZgQDAtaYQ8JZ6HeP0MydSBAynC9AjDuAFoLT5Sy7VOJI3_Jvfg>
    <xmx:m_cqZjpy3p8Uxq--3RNF550U4Lvjh7ibS62cwl8Lv7BGfHq18TjtuA>
    <xmx:nPcqZm1HxvIzvhbXy2chEWST5x8o0SISFip2OMgnI_Shsq6IGRsWPSRZ>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 20:38:46 -0400 (EDT)
Date: Thu, 25 Apr 2024 18:38:35 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Matthew Garrett
	<mjg59@srcf.ucam.org>, Pali =?iso-8859-1?b?Um9o4XI=?= <pali@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?iso-8859-1?q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Message-Id: <BSXICS.THI25R7A1N202@lyndeno.ca>
In-Reply-To: <3cf80056-e62d-4be1-9716-4c843ae2f88c@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	<a6009bed-aa34-4a3f-91f5-23937e915132@amd.com>
	<24c7a9ea-7755-4270-a338-4701c8e262e2@app.fastmail.com>
	<ae6a5b66-86e9-44cd-8484-1d218e7bc72c@amd.com>
	<3cf80056-e62d-4be1-9716-4c843ae2f88c@linux.intel.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Thu, Apr 25 2024 at 02:51:42 PM -07:00:00, Srinivas Pandruvada 
<srinivas.pandruvada@linux.intel.com> wrote:
> 
> On 4/25/24 13:28, Mario Limonciello wrote:
>> Yeah it's not say it's a "new" conflict, it would just become a lot 
>> more prevalent since software like GNOME and KDE use 
>> power-profiles-daemon to manipulate the new power profile you're 
>> exporting from the driver.
>> 
>> If there really is no conflict, then great!
>> If there is a conflict then I was just wondering if there needs to 
>> be an easy way to turn on/off the profile support when thermald is 
>> in use.
> 
> This shouldn't be in conflict as this should be directly changing 
> some settings in BIOS. BIOS should send some notification, if it 
> wants some changes in thermal tables used by thermald.
> 
> 
> Thanks,
> 
> Srinivas
> 

If we do not think there is a conflict I can leave it without a toggle.

Lyndon




