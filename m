Return-Path: <linux-kernel+bounces-164603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43F8B7FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2C61C20DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7B1190679;
	Tue, 30 Apr 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="snV3ggZQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jHuC3a8a"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0D23C9;
	Tue, 30 Apr 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502339; cv=none; b=TxAUFIeH8p3/Q8ypy+I1e/suS+czM7STuq5kYN3S2umH+bU+2ry8VYJ1lWgT7AnP7fB1vspMp/nmww22HMHKht919uPvzdKShnqeAu3WVm8vtRBp2aO21vfqvguBdKG7taV22uMYuhvOvFiYJJmsP5ndTH90xyW4SUesKJqoOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502339; c=relaxed/simple;
	bh=BUbM4t3oqiVAbDg956xtEKGQp/WUp0rlclFojITBMIo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=j/5dBzJfBlPR1PCzL/Jmm25E0advL4Z2RmxdA/TLfzOXZgqdfuDCrRmI3sO3ouzE6FX80ZOaflExFA4Brtx10qfL6Px0M8AfWaSKImBVPo0ZAsTQDhtIRjTZXJpLFgIbweThyoRjJLhiXNrVzlpfx/NAF5F7I9qAP0Ss02EBrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=snV3ggZQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jHuC3a8a; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 468D51140121;
	Tue, 30 Apr 2024 14:38:56 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 14:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1714502336;
	 x=1714588736; bh=htMlaiKAEHd46q3bkXM/XEl9g3l+/DJfYlU33y1M7ss=; b=
	snV3ggZQloW1SbwN3bhfuky5cnOO6iHOBI8EsE3rI0DNnntu/ls89gnidtY6Es7/
	VuuT2BmjhL8T3uGXW2n5Z7s/C+ELENV/G9gcNBJnxj/fLYnseStqsgWqXeRo0598
	E+3iciGKfJsea5+/o0xV+ZnF92qp7+l0FcInzma2R+SiMv7avksqNRHyTK5L9hkY
	dQdcOTLfCLADyKqP+KyD2gm+agmdq8gY1hw03U/5Efhqk+YJGtjNiXtYFGwhg8K4
	Rs8v7rp9vC73XgGE9pwIGS2MzE5f/redxnBppMRab0+eyJJfOxzaDI/LCLXeTA0C
	3DBej73GpqVNEwJfAvvuEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714502336; x=
	1714588736; bh=htMlaiKAEHd46q3bkXM/XEl9g3l+/DJfYlU33y1M7ss=; b=j
	HuC3a8a/6ww/EYErsO4yuPdTipO3S47yuIGQWUzmF7tTwXAkGPj5pL2u9aQNrcfP
	2RsmQLyTBwQOssBVB8X2xnoamzSTYcR0u25RDLsZBEN8Qxc20d5qdIUl/EPKVBQZ
	wNTJ/mdzp1XYGjxUiu0fei7vhcEPzM6tjpt1Xf/RAhgY4IL6kV13+awol7M8Oi8Q
	+gR5jwHcdnmNg16Ujy26Fimj83BkKpuAnwyJtndLGaqzACQWXxdxUh0XzNtFnTUM
	+RQZsWE9AdEDpRjtR2ftra9FgCOSZVaEBBLqjzcvZcGQ07xSz7nA1zlo/gk7Mluv
	2YOA5Dn2yb0P+No3odOBg==
X-ME-Sender: <xms:vzoxZqx97TamvUQat38YLjt5ibRpermvBvEGtfDwIhG8NzKML4LgJg>
    <xme:vzoxZmQmjQymypDdRWmgoaOjmqN_S4JkRqnl-YL68AJbmYQx8z-F7URhMfnvOFJL1
    4uu9221b3rxfGkhtTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    nfihnhguohhnucfurghntghhvgdfuceolhhsrghntghhvgeslhihnhguvghnohdrtggrqe
    enucggtffrrghtthgvrhhnpeehfefgveejieevvdekgfeftddugfetgfetueelieduffet
    ieelheetieevvdefkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:vzoxZsWIJzyqZkdw5Tukm_dcFCZ912YB2NB0BJMb6awlTELfqLAJGA>
    <xmx:vzoxZgimNVLLvjM_FlmD6VOlSbrVZLlx1yzUpwmStxDcXI_OPntCNg>
    <xmx:vzoxZsClpm8ObUznLdxtH200FFXuCC566w9qe9CFzSNmSBRQR0vgIQ>
    <xmx:vzoxZhKvxRBtLUIKdYZBUw1QgAaRENGPARaYyVCPp0SF2z53vEAXDg>
    <xmx:wDoxZstYoKPfNeQ5dUe2rWxCVP10ngzdJjQd7GoA5KUEMzvTj6GXUHhV>
Feedback-ID: i1719461a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C6ABAC60098; Tue, 30 Apr 2024 14:38:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-416-g2c1796742e-fm-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <992f3688-fff9-4970-a5f4-103fd868551d@app.fastmail.com>
In-Reply-To: <6075bdd1-324c-ced7-4424-826b50767afc@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240429164844.7544-2-lsanche@lyndeno.ca>
 <6075bdd1-324c-ced7-4424-826b50767afc@linux.intel.com>
Date: Tue, 30 Apr 2024 12:38:35 -0600
From: "Lyndon Sanche" <lsanche@lyndeno.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: mario.limonciello@amd.com, pali@kernel.org, W_Armin@gmx.de,
 srinivas.pandruvada@linux.intel.com, "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "Hans de Goede" <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3] platform/x86: dell-laptop: Implement platform_profile
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024, at 4:31 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 29 Apr 2024, Lyndon Sanche wrote:
>> + */
>> +
>> +#define DELL_ACC_GET_FIELD GENMASK(19, 16)
>> +#define DELL_ACC_SET_FIELD GENMASK(11, 8)
>> +#define DELL_THERMAL_SUPPORTED GENMASK(3, 0)
>
> Please align these with tabs.
>

Agreed.

>> +enum thermal_mode_bits {
>> +	DELL_BALANCED =3D BIT(0),
>> +	DELL_COOL_BOTTOM =3D BIT(1),
>> +	DELL_QUIET =3D BIT(2),
>> +	DELL_PERFORMANCE =3D BIT(3),
>
> You need #include <linux/bits.h> for BIT().
>

Agreed.

>> +	}
>> +}
>> +
>> +static int thermal_platform_profile_get(struct platform_profile_hand=
ler *pprof,
>> +					enum platform_profile_option *profile)
>> +{
>> +	int ret =3D thermal_get_mode();
>> +
>> +	if (ret < 0)
>
> I think I already mentioned about this, change to:
>
> 	int ret;
>
> 	ret =3D thermal_get_mode();
> 	if (ret < 0)
>

I missed this.

>> +		return ret;
>> +
>> +	switch (ret) {
>> +	case DELL_BALANCED:
>> +		*profile =3D PLATFORM_PROFILE_BALANCED;
>> +		break;
>> +	case DELL_PERFORMANCE:
>> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
>> +		break;
>> +	case DELL_COOL_BOTTOM:
>> +		*profile =3D PLATFORM_PROFILE_COOL;
>> +		break;
>> +	case DELL_QUIET:
>> +		*profile =3D PLATFORM_PROFILE_QUIET;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int thermal_init(void)
>> +{
>> +	int ret;
>> +	int supported_modes;
>> +
>> +	ret =3D thermal_get_supported_modes(&supported_modes);
>> +	if (ret || !supported_modes)
>> +		return 0;
>
> I think you should propagate the error code differently from nothing=20
> supported:
>
> 	if (ret < 0)
> 		return ret;
> 	if (!supported_modes)
> 		return 0;
>

Agreed.

Thank you for your feedback.

Lyndon

