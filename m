Return-Path: <linux-kernel+bounces-72393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA985B2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F78287B50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675285822C;
	Tue, 20 Feb 2024 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iUfmMCA0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NlV5M4I4"
Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25DD58AA5;
	Tue, 20 Feb 2024 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409651; cv=none; b=aQMe4Cx9bImLr2s6DFIfCDyBYdXWOJUjDgtm0q6VqPkkysN5fZ8DUZ9y9EFDKT3AY2G9b2QxD1ctkSmXizSXQBQjjQ2MWTuEoT0Fj2tacJuoocwhQ4WPDFyuA2+MwjmJGlq81RH9TRfJBj6clsqL/6N/6TbHqezC9h0RbBXguaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409651; c=relaxed/simple;
	bh=9QaTb3W0w4bGWAukdvy+gvN2aMKys7fz3fEGGQsPfLs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=nGmBHeSDs/kEupdrhnlKrZe0UgYldhx/qRqglqnO5rU7y6Ipg0ZWLDinaGFxvWCz422vah9C97BzS80Mjb9zcgGrdmOOtR3exaIdMLzQybqAyMXSUmnotX5j33864T+mASA60vcF5wn0wOxtF/R8Ny4hRetfh5bgI4py/OVkmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iUfmMCA0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NlV5M4I4; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id B86121C000C4;
	Tue, 20 Feb 2024 01:14:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 01:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708409641; x=1708496041; bh=FR12cbn/Bw
	gn5gyCYRS7QW9MUfXrVmuXbXYZ5NgDFiU=; b=iUfmMCA0l+S9XS8ZCE3JSAJiHD
	7SZgx17jnMGeNS4Qn4Bh4gd8pFegjJxexNUUd/fGhXCei36EG39bWKIy+eMO4+os
	89EHqaqbkGCCxA+idbdHUDqvL9s0ZxGK5SDtFOCvJHkT3qDP5I9Zgy4K2AFsckbE
	QkEvMKgyWWXrTIkL6RtyL9HVEgBS11i+kFs5DJq1KiGYyXOpBveTEvdPc4zHVucJ
	ayioOtLcIPF8hnwfsjeZRL8LwaDVVa8OMA3mngmoh7DXzulkWBJYH6oB1AW2JRHn
	wMgmJwLmgTZrykHN152jU13ZuZivEbA2JJX7ouQjG2J4qDIpK/qDMj0cBqzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708409641; x=1708496041; bh=FR12cbn/Bwgn5gyCYRS7QW9MUfXr
	VmuXbXYZ5NgDFiU=; b=NlV5M4I46gmAcM8OkvJh0T9UBr9xXoojaTv5C4F8MZzp
	gGJJgUqLxI5d+vkCf08cXyH5uN0gUfZz7gu5kBAOEJMqooSvigoC8m5d0Ry9SEoi
	PoDVbTIMsf42D8NskWrvz5N7Q7WgNeiCJeKp4Mu65GOstH8nKh7cZA9j4t6VttNr
	R9j5tHDNfkucT5ucX6DOHTirxlYrJq693DWS4BZ8f6cE2um0nxL8McImpZifdPzK
	Rsxa8tnVi9lGACwunAmXamoYxs5Uz1NnUVMx38cY2uiO2r1k/wg6LoI1rE4+oJBk
	BvtRCyykdCBvb24OrzOqRdRW1n8Ula2g+Stovryl6w==
X-ME-Sender: <xms:KEPUZQ4h1pptoJSSwrsa51FWPRYypngH8oXftawpJPNWvnA7BWkiKQ>
    <xme:KEPUZR7DvDPCeJJhxyWP6VNf3PKpYJ0TlNa7j26c-gJQs9ZbEUX7tuXiah2GsIonb
    M3cqpQHiMkGvPUSOBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:KEPUZfdftHkxNDHRDtFgYN4zrSaLrL5CvAnMjJtnWWmOyXy7n_DCQw>
    <xmx:KEPUZVIynM4yRy-J4mkFtLnzN9nuQSDBoN1mBShtCY_3G8mbDIqDlw>
    <xmx:KEPUZULdkglAnySCiawSO2s3tPUQvhpfNSevewZ6SBVy1_kV0L6n8g>
    <xmx:KUPUZV5HQnFTi9HW5NvUQCPvEQ-cIKOHSB2fHBhdyuPPOIMXyK6V7t12JtY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 311FFB6008D; Tue, 20 Feb 2024 01:14:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <412c0a42-4c19-48dd-aa4e-de39b6ec3099@app.fastmail.com>
In-Reply-To: <465d1076-163c-4933-a9b5-e4e8736f5748@amd.com>
References: <20240219093900.644574-1-arnd@kernel.org>
 <465d1076-163c-4933-a9b5-e4e8736f5748@amd.com>
Date: Tue, 20 Feb 2024 07:13:39 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vijendar Mukunda" <vijendar.mukunda@amd.com>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
 "Liam Girdwood" <lgirdwood@gmail.com>,
 "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
 "Bard Liao" <yung-chuan.liao@linux.intel.com>,
 "Ranjani Sridharan" <ranjani.sridharan@linux.intel.com>,
 "Daniel Baluta" <daniel.baluta@nxp.com>, "Mark Brown" <broonie@kernel.org>
Cc: "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
 "Venkata Prasad Potturu" <venkataprasad.potturu@amd.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: amd: fix soundwire dependencies
Content-Type: text/plain

On Tue, Feb 20, 2024, at 06:57, Mukunda,Vijendar wrote:
> On 19/02/24 15:08, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>

>> In normal configs, they should all either be built-in or all loadable
>> modules anyway, so this simplification does not limit any real usecases.
>
> Tested this patch. SOUNWIRE_AMD flag is not selected by default causing
> AMD SOF driver for ACP 6.3 platform is build without enabling SoundWire.

Yes, that is what I described. But as SOUNWIRE_AMD is a user visible
symbol, there is no problem in expecting users to enable it when they
have this hardware, and distros just enable all the drivers anyway.

    Arnd

