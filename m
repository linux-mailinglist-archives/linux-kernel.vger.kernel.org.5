Return-Path: <linux-kernel+bounces-163069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D408B648B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834801C21421
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEBB1836E2;
	Mon, 29 Apr 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="XYM871hr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bb2KdSON"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859882D90;
	Mon, 29 Apr 2024 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425954; cv=none; b=DkK6cKRUJa8jO3tBb38OUWdjEqV9jf0rKK2JUi87JuhUfzmC5nAeg7AUreuP+Bb238snZittk/dJeUKczo9+cT63gj795kCIPLcBu0CXj39bofHLIuPxTuE7vyLWUK6UzC3XHpQkur6AZtU3nCNTI2SgskKIDFwin2lWdWgDLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425954; c=relaxed/simple;
	bh=dQBRubZsYQuMnytLZJwJqxHoVwRnluEMpe2562DEkrA=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgKdQBeVuuKcVZ0Pw0NwhducfJjEHXVksE61UxrA/FKxzdDsUNnvwt9zTRUab/YyWL3K8OR7YK8OJ7FeDSnVgr+0k3KxBzJTsXTWiSYQh2y8noK1NOZEJBl5i/qb8W+cnoIuXcMzHP26GyRwT3AR+v7LKHm4rrXERAqE/3uu9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=XYM871hr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bb2KdSON; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 94D9B180017B;
	Mon, 29 Apr 2024 17:25:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Apr 2024 17:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714425951; x=1714512351; bh=gS3ckrq8vt
	l0jimEpRPVb4E0YJmt16m/9Kirg4P9Ces=; b=XYM871hrI/Ql5AeQdoCidhC2+3
	cvFPplvPY7ZnOeDztmgc9r3N1a7XX7fDq/KnlC5XfekG97zol8K5mFT4NVGUj7mk
	FPnfdGxW9jEn3sUHzP2QpxQWkFEpAROHWkv7lIS4Y3IW3MYO4wVsVkIqacPbR14a
	onh1Ck/6iGB2WLSKl3URtsHPoJETq9nbqpkhAu5QVMmQX982uLMvfGHgOpEUKzWC
	wPTeFOEerZA72zszTCS3qcGJuSrnYpXH7uumd1sl2EBcto5PEIYF+gKlILFx0oOq
	g21uWKCJf4Wnr92KzeNMPT37tBcpHqjUDLKmQrMvwklk0VO6Hud3H2Gw1g9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714425951; x=1714512351; bh=gS3ckrq8vtl0jimEpRPVb4E0YJmt
	16m/9Kirg4P9Ces=; b=Bb2KdSONS9lRPwk8A8DfMxLIXfpZGO0AwOy/o/BwO+SI
	c9bo7VJ6/sQ5O/iONReLza5k3MGWbn8W4FvCxwFm+EfzvP9wZzuT1DBMTvfLmkan
	rZHaOpCUOxUXsbEtl5DSm6QVcBEpDwcHnGm8rnqJ08HuYGmK8oS1bBgqTaClh6qs
	o6CrfdENFHU0Y9w8piHgVnLC/S2mxfnRfxAJ6Zkw25+NaBSYVGTF7n+9LwpflSuA
	imfRpQ9KSuhuup5Qmxb9ImgRVKdho4TnaorQO1QvdbJCzcPEWdPx4kOvnGHU6h4s
	uXj/4OIePHVeB5L5+MMHLQgAV+G6686sl2PvYiNDoQ==
X-ME-Sender: <xms:XhAwZgSF6FSITLbCxnbmSwyFXheVGyI7kC4w-5H343aGKLSVXK6g4g>
    <xme:XhAwZtxWKG4kMGxqZQpeA00TdjffqnVPZUHjF9o7MmeWHKIAE2I2DjXpywOvfTtio
    4dZgZjxnQ2ODOITzlw>
X-ME-Received: <xmr:XhAwZt37Zvf5kQJMMtTLrXZyaKL9Zksv4IBkU_6PybBaH55QH-7z2sdxjLtGTqVjZJdYsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnhihn
    ughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslhihnhguvghnohdrtggrqeenucggtf
    frrghtthgvrhhnpeejffeukeegieejhfdvudegtdekfeevveetgffhveefueffgfdvveel
    ieduhfdtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:XhAwZkA3wfe1HhSaV_i1rBWuVx3uDk29oRa6UPy-oKa5l5DQHYgkeQ>
    <xmx:XhAwZpjKK8BtgFbJ67Oz0DVSrGO4ksguyKzjOa6BhZUgixpGSNbteQ>
    <xmx:XhAwZgpvsD9Z3IZzjLSn4TfLQdfshYVc8KaHee_xHMjTIcCAoy4yUQ>
    <xmx:XhAwZsjUtx22kzwBv-ciDhMN1dw3pGWQvh_U9NImmj67MU_DyUW2HQ>
    <xmx:XxAwZuYy-n83ldxjQoJXEEL_6TDuLZvYNAvmG95XS5vPTCqFeNYonFj7>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 17:25:44 -0400 (EDT)
Date: Mon, 29 Apr 2024 15:25:34 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH v3] platform/x86: dell-laptop: Implement platform_profile
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: pali@kernel.org, W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Message-Id: <MI3QCS.72BHE7ZBD8ZE3@lyndeno.ca>
In-Reply-To: <bcd4fc9f-8900-46bc-9577-d95fa67adc25@amd.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	<20240429164844.7544-2-lsanche@lyndeno.ca>
	<5cbb8981-5e24-4dce-a78f-1cabc29f08e3@amd.com>
	<bcd4fc9f-8900-46bc-9577-d95fa67adc25@amd.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Mon, Apr 29 2024 at 12:51:31 PM -05:00:00, Mario Limonciello 
<mario.limonciello@amd.com> wrote:
> On 4/29/2024 12:45, Mario Limonciello wrote:
>> On 4/29/2024 11:48, Lyndon Sanche wrote:
>>>   #define CLASS_KBD_BACKLIGHT 4
>>>   #define SELECT_KBD_BACKLIGHT 11
>>> +#define SELECT_THERMAL_MANAGEMENT 19
> 
> I think you should insert this into dell-smbios-base.c under 
> call_blacklist.  This will prevent userspace from fighting with the 
> kernel on the same data when this code goes in.

Good idea, I have been using smbios-thermal-ctl for checking the state 
when testing. I will include this in the patch, then smbios-thermal-ctl 
cannot interfere.

Thanks,

Lyndon



