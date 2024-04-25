Return-Path: <linux-kernel+bounces-159128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3D8B29BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11709284BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D50015665E;
	Thu, 25 Apr 2024 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="O265K69a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V1CJjvDu"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E15155A5F;
	Thu, 25 Apr 2024 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076711; cv=none; b=Pjn3mgBvGYCKoV+C8XrQ3OUXxZgktZc5Sj1OlfU72ekrO2RP1fEPbnvy5gzCZGqOYBX7y+vShCGdBZbg4yxE8oxeYzl7wvzJyuuLtj9iaTLmL6eemgRQbjLUdNpfOpOzvGD915lMsjI99h7RkAagwO24m0AH8axZHGDTk248kCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076711; c=relaxed/simple;
	bh=3qL5bQrHVoSLNO5S53wuqeASLy3WpgTiTwwMc/VF3vQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Leu2Tv/YQfOk3q8IM1D0GE7TS1qAyYkx9J4AZ06pfhhjgrJo62D5JZPOcFBos9soPKPGrmSBY99P5LB3GMUmUgpBgctF/6MCcjdy7Z2YHM+N8v0ek1uBBfGKTFPK9Scvdu0b7gQX6UQIFrqcRVsvJGlnDZW/U2uaO2uL0xjKu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=O265K69a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V1CJjvDu; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 3ECEF1C0011F;
	Thu, 25 Apr 2024 16:25:07 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Thu, 25 Apr 2024 16:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714076706; x=1714163106; bh=269Snn4epN
	C/bOip1qAeWtLnjpiwa6nS6ACNbG7tbn0=; b=O265K69a7IOpOvrfHmK2iEz/Up
	DATfSwkLFOxqnOZP+TWjZuxwqUhZl0WwnDUMidEnviGtZUfmT2W+MI27YgPcGmJc
	fYT757kKU0RWzUagRn4aYHzQXLvBEo+IZMV2AQk6CxwYNzk0yJh3Isad0h0FbsZi
	yFPKDsS6de+ZgIBiJrnl8vAJLmdFvtouZC0K4Bxoa+7apANB5d1Ts+ZKp9NOpaMx
	bKllKG3D56Uta2Sz3xtid+VcOg9683+Xwm9OdoIjgjmIv1Ovjo2ggy5fJ+K87GBm
	H76sSZQZkODL0yGe7tphjq/oydRnQQDGkF2cthY1JOJCOtLi6glEDJLpyrlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714076706; x=1714163106; bh=269Snn4epNC/bOip1qAeWtLnjpiw
	a6nS6ACNbG7tbn0=; b=V1CJjvDu08XGU55v6o2eiGTzXK50t+B21aUX0brtl2gN
	eENBIZTMNSxdulBaodoJhfCIHcPA2JeVD4mUnDQCBTqElsXd0sIDtMKE4WmlOjSg
	ATwFt2+qxnN5rzWuUKSWaEXJCViiEuINtTW5PTQ2x2HnyjQOCXO/XUu3O1Fxzk3A
	hVk8gk/fSIFjIWGjAzCEphVfwBfdngZ+M4CY0NHYMSH27hfCaO7IP5SvgKg1bFSb
	EFRgTpzF1e18LQDaUpSO2PkjECCyUAhCMXm5Xl99lCguwecuYG+xjhXSEC/UpTw8
	oDCwE4XsyiL/qfmRRFoqyFN6R14irVciK8Bs/0D+GQ==
X-ME-Sender: <xms:IrwqZoUjwFsChgYY351w4kE9-5kxLCOjy1y5OduAU9blm1QfNQsNjw>
    <xme:IrwqZsm5Sg0N6vwp0fD0CUUhDpQhejdvxv2kugubjZPzxtGC_YMTauV_DvJsnfgPz
    kV-a4r1kHgqCEr0uSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfn
    hihnughonhcuufgrnhgthhgvfdcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqne
    cuggftrfgrthhtvghrnhepfeekieeggedvuedtjeelffetgeelgeeludffjefhkedvudeh
    gefffeehtefftdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:IrwqZsYIaFZFxEUTQ2njp13fWKT9tG4QHkapailAGiZcKXbXH-jH3Q>
    <xmx:IrwqZnUMmVG3HDsctkbI4VYTVj7J35HGmcgwCS9H68ungTYwLolUAg>
    <xmx:IrwqZikwe23XfTYW7h-mdP8BZ4Vi_DO6RuUTelpXLKIos3QUl2HghQ>
    <xmx:IrwqZsfzar9UcR1-L6w2_0AHICU2oxxcyMqfWrm5K_pCApzDZdSZ_w>
    <xmx:IrwqZs6u4jHdzgEtE5RZSUWWW6w7W5xxSUasiK9JwdUr8ENK1MjmhYRQ>
Feedback-ID: i1719461a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 37434C60097; Thu, 25 Apr 2024 16:25:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <24c7a9ea-7755-4270-a338-4701c8e262e2@app.fastmail.com>
In-Reply-To: <a6009bed-aa34-4a3f-91f5-23937e915132@amd.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <a6009bed-aa34-4a3f-91f5-23937e915132@amd.com>
Date: Thu, 25 Apr 2024 14:24:45 -0600
From: "Lyndon Sanche" <lsanche@lyndeno.ca>
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: "Matthew Garrett" <mjg59@srcf.ucam.org>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com,
 "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
Content-Type: text/plain

On Thu, Apr 25, 2024, at 2:07 PM, Mario Limonciello wrote:
> + Srinivas
>
> On 4/25/2024 12:27, Lyndon Sanche wrote:
>> Some Dell laptops support configuration of preset
>> fan modes through smbios tables.
>> 
>> If the platform supports these fan modes, set up
>> platform_profile to change these modes. If not
>> supported, skip enabling platform_profile.
>> 
>> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
>> ---
>
> When you developed this was it using a Dell Intel or Dell AMD system?
>
> If it was an Intel system, did you test it with thermald installed and 
> active?
>
> I'm wondering how all this stuff jives with the stuff that thermald 
> does.  I don't know if they fight for any of the same "resources".

Thank you for your response.

I did my development and testing on a Dell Intel system. Specifically the XPS 15 9560 with i7-7700HQ.

I do have thermald running, though I admit I am not really aware of what exactly it does, besides being related to thermals in some way.

I normally set the thermal mode with Dell's smbios-thermal-ctl program. I am not too sure all the values that the bios configures on it's own depending on the provided mode, so I am not sure if thermald conflicts. But my understanding is that would be out of scope of this driver, since we are only telling the bios what we want at a high level.

Lyndon

