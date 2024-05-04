Return-Path: <linux-kernel+bounces-168480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59F58BB907
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 03:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314B41F23860
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12C17F8;
	Sat,  4 May 2024 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="auHFa091";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OlubhLYk"
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62AA38;
	Sat,  4 May 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714784410; cv=none; b=XkupvgOMaklWw9temrv7AApC9KYfaV+FDR+ujwZn8FWcCvKgCUo1KAHrI+pONZtEh7xH9eWe+tLPXAe9gUdRunXqhhG8XTMmQan60Ihxhz92Sv/i+udzXh3RsIpJyoORiHf8cRBWzSF+08c8ZzAL6vIOkq4Xn9EH8EcW7IYWxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714784410; c=relaxed/simple;
	bh=e55VjuJ/jgCJygCBnWw0Cl8E5balwJmlAUVFvWW1wo0=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+5Cujmnpl2llrW/YqgHkAko3I33cC8maBxKLsAWku329IQYC/eE0yF6z9jXjmEyUhEKYwGZW7NnuofwzRcdg8ypu+AGI1DUWw8x29bV3uQ0lNvmYlAtAUBRx4L6/HIMLuBp0KizYynKdmhsdDXEV6COfR74/QBhGEO+qOgGIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=auHFa091; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OlubhLYk; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id E0ADF1800114;
	Fri,  3 May 2024 21:00:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 03 May 2024 21:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714784406; x=1714870806; bh=ZW3WeXNrA3
	Tgdn8rt+jXpKLBS86K+0HL1UjmI70+lcg=; b=auHFa091g2UNTX2EYm6ypvmbU3
	yWM6mip3Bwp+BnahqAZAuDfoIrdLCaw2caP9ExsYfIuUDc1CDDwroQBJnWasttl7
	pg2DiLv8I4MsaIxnYXwF3FuUOMfCfVFpCxHyeSjrsJYVgGrBOvw1SVGA0CNvfQUL
	hVZ6Dl+VQB7Ylg/lWiEtJuFpWTdfpHD57osEFSLgI2OmHPAktYhyGeVdQFa29t9Y
	SUiRtlFJJThGJIzfMc8RlqXiVMDpz7A5Mr1vOgFw29KSHgQqz8allNex0CZYitCa
	So9gOh02tBzvczgw8s84WBUo454dmtfl+18ljY+E0lq4IZbj8ZogbtkS6AiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714784406; x=1714870806; bh=ZW3WeXNrA3Tgdn8rt+jXpKLBS86K
	+0HL1UjmI70+lcg=; b=OlubhLYkSvdSZLRn/gKwUf19Njqy6zywJmHfiYkk9eqX
	fgHw1TV/fEuf/lT5jg5CuFTvDTrRkbc2roNSLFOkUyD3uWTWahdBfqjWZlnO4Zng
	nyl/pNLCN+XnoKgmyE5ITNZ+bNJwhvt1hZWVUqH4R3e/LbFRv5CiUeiTDnfjht2Y
	qNSvLOAhjZvjSiG/65U9mJiNg7K0BBF7HOLgDmI2vI8662U4egt2E3vGVmO1QsE1
	GgbkTWnS5cQgBphAexyfM2l8IskqeMVlwbfhyC4ctmK9SfP/XW2hRVu14H+j5J66
	OkKnRxuQRCBA7ShszC3GQevfelAlWbasscGTQz2I+w==
X-ME-Sender: <xms:lYg1ZrCv9GWJpnC2YxUTVJpOSh_D3dx1ipcHfXR_mfhL5Z81127fZA>
    <xme:lYg1ZhgKPR1jkD9kUDSSp5wByMNyjYz3QQTfaBfI_GRIOjsoojw3E1lSd9nWbiEv0
    -vN1xjbUugHtxoy4dA>
X-ME-Received: <xmr:lYg1Zmk0j1-UwqUWU97SUcz1X9htlcdd3-ByO2y2Gf-o08lDZMr0JpTU1GHxvxrg9xg->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfihnhgu
    ohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqnecuggftrf
    grthhtvghrnhepjeffueekgeeijefhvddugedtkeefveevtefghfevfeeufffgvdevleei
    udfhtddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:lYg1ZtwSv_xgnX1E4fqcLfijgUvSSrs8RhhZzKjhMP5PBeo5zNWS6w>
    <xmx:lYg1ZgR0YK9bydRATh88M0kXIU_MRksNr6Pii9BSoej4HyOI5EgJZg>
    <xmx:lYg1Zgaa40AWq8xxAy1T3GiONLrw4kMm74agwtPLZhOYKR_7-KR0PQ>
    <xmx:lYg1ZhSKb8HpoUdt67veDZOVFL9FjLFf_kh9cWvPfyMbLgLnuLtyVA>
    <xmx:log1ZsoVVxjAZVvi7NN-CA6r_XGPClHBo74nPYLMAbCw8VNfww_pICj->
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 21:00:00 -0400 (EDT)
Date: Fri, 03 May 2024 18:59:52 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
To: Armin Wolf <W_Armin@gmx.de>
Cc: mario.limonciello@amd.com, pali@kernel.org,
	srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	lkp@intel.com, Hans de Goede <hdegoede@redhat.com>, Matthew Garrett
	<mjg59@srcf.ucam.org>, Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit
	<hkallweit1@gmail.com>, Vegard Nossum <vegard.nossum@oracle.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Message-Id: <S3SXCS.2L4SMU4H4WJF2@lyndeno.ca>
In-Reply-To: <91e3282c-8271-4c95-a57f-88cca4ba88b5@gmx.de>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	<20240501215829.4991-2-lsanche@lyndeno.ca>
	<91e3282c-8271-4c95-a57f-88cca4ba88b5@gmx.de>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Fri, May 3 2024 at 11:19:07 PM +02:00:00, Armin Wolf 
<W_Armin@gmx.de> wrote:
> Am 01.05.24 um 23:58 schrieb Lyndon Sanche:
>> +static int thermal_init(void)
>> +{
>> +	int ret;
>> +	int supported_modes;
>> +
>> +	/* If thermal modes not supported, exit without error */
>> +	ret = thermal_get_supported_modes(&supported_modes);
>> +	if (ret < 0)
>> +		return ret;
> 
> Hi,
> 
> some older models might not support the USTT commands, which would 
> prevent dell-laptop
> from loading on such machines.
> Since dell-smbios-base already knows which commands are supported 
> (stored in da_supported_commands),
> maybe you can add a function for checking if a certain class of 
> commands is supported and
> skip thermal_init() if the USTT commands are not supported.
> 
> Thanks,
> Armin Wolf

This is a good idea, I will have a look at dell-smbios-base to see 
exactly how I can check for support. If support is not available, 
thermal_init will skip or return 0 (depending on where I put the check).

Thanks,

Lyndon



