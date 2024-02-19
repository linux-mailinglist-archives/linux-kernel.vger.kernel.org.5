Return-Path: <linux-kernel+bounces-71567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF37785A728
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6360281723
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B9338393;
	Mon, 19 Feb 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="gk9BtmfL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oi7xwq5E"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159A2C1AD;
	Mon, 19 Feb 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355674; cv=none; b=l/N4/J038hTNupyOY9oJOIJjGC36M8qJNdc2QEK10utbg+7JK8NHklHmqH4RG/EgVzdAO7vdWVY6ngRVptHPpgYmd5eyX9jwQZfEPZIuSTIowX7gmHwJWFhhDh6ZBg2ysM8H8BP7Nrdcg3ScM9ThoKEHzksHG04PWRU9U4t1CQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355674; c=relaxed/simple;
	bh=5MVJrTp+bNza9ZMAQf7AGBb6UwjGk8bOxNP0jEjDp8c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=fqCnWulLCXpqvyD5SKLrjuFa5WoRJ+MqojsVWHG8fpJMF/UvWbSyc620c+YVyAgTSqCpCTkX5ZHdWuJ5J8csTikFz1Yh9l1ikjTmEpw2XQ7z6aNKci7cgPmv+hmSZH9AOaU7lJKFMO72zjG/iMrwUjfRicRxDFEQ+xkU0bKpI5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=gk9BtmfL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oi7xwq5E; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id CD78E5C00BF;
	Mon, 19 Feb 2024 10:14:30 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Mon, 19 Feb 2024 10:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1708355670; x=1708442070; bh=T1Y+CtE1cF
	4upI7SQ3B2wjaUi/0ZYHr3yApmOLdpaRU=; b=gk9BtmfL+tPZq6aPjNQaI9mfe5
	cmcDgnj54IuAcvNANj6ytwqd2q3rlp3SePviOn7bny9z5toTtqiCrUDoq0LgVjfA
	fFEcfci4Sev/9uO18PgZDxVKhClMgab/6zu7Iq57I7ToffsQ99B99W+rwVJ6bW90
	FQHnFPyUUpzGIAAjIrBAQJoICGnRDag8+7DLrLAUZf4ZBKTuIAdj01xcBFCS2G09
	wrmQSUzn3aHgVMIoiiGySVkEQnQnckWdxBfna0GqwycWfgXt+7QlhlviZtNZJu9b
	3VaVo4Ts+neKKkMIUHi7rmkTUlRcbQ1rJGQurAmVhnUUBprFmbSl7FS/vDyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708355670; x=1708442070; bh=T1Y+CtE1cF4upI7SQ3B2wjaUi/0Z
	YHr3yApmOLdpaRU=; b=oi7xwq5Ex897J9GPcpa5sFsjXypOr99CyPbCKtMWcfrH
	b9dKXDnUjoJBGZyCEoJg688vj/Ps4VCigPOep3tu5vprjBkLEMzBJ7AepJnRDrdA
	ojtkk6BgrgcO5AT6QOyZi+UkYdXZM6hFrtNVlELakg4JbYXVfbnOVMxEzl47pqiH
	Ah6H7uvlkVcGTgwmbRZAhZGZC13vixKSjldebZkk/B5/R7ij/LevIHK5ezz6iXUb
	0pN9HWqO0CQ5/6ZkACINIkLz9WQNuhnhfpOMnD3zSxcqViq2DJSlh/50LcPjGX62
	p+6hWCAmmd9XkzLufybv3psjc1vGU+RSD1sFQklDBw==
X-ME-Sender: <xms:VnDTZRHTrusEQTUSWF9ekj1pBQKYiVY8RXEGJiApJ_xOiZaVQSE_zA>
    <xme:VnDTZWVAswQUHjcQ_zFppl0MPyrVdH_G_uY3LLt1oMzsZbDSpoSxzf3Z2mr3rGDxY
    7Dl5hFhUJ_gEI2JCZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdforghr
    khcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrd
    gtrgeqnecuggftrfgrthhtvghrnhepieeufeejieevteduvdekteefledtveffveduheff
    feejudefvdeijeegudegkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:VnDTZTKBqfYV4rMb0Kvm-lDKyUK5sYu58cdsT056ajmg1PIk9M4jKQ>
    <xmx:VnDTZXFaOgukaX9Eetq4h4SAl4VUot-4kOMDZv2CE2pFttVDWbA6Nw>
    <xmx:VnDTZXXMic8kG4uGR2V8r99zPzw7VK0tne3cKQHc6_4vMkd85-Xxzw>
    <xmx:VnDTZefiXQ1SXCpTyhX44i0kwfJggbCTtZmnuk4aTeNz0yW0ftrVMQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 81F94C60098; Mon, 19 Feb 2024 10:14:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b37b5e6f-c719-4ff2-b16d-96716e681ca9@app.fastmail.com>
In-Reply-To: <20240217022311.113879-1-mario.limonciello@amd.com>
References: <20240217022311.113879-1-mario.limonciello@amd.com>
Date: Mon, 19 Feb 2024 10:13:54 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Hans de Goede" <hdegoede@redhat.com>
Cc: 
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Only update profile if successfully
 converted
Content-Type: text/plain

Hi Mario

On Fri, Feb 16, 2024, at 9:23 PM, Mario Limonciello wrote:
> Randomly a Lenovo Z13 will trigger a kernel warning traceback from this
> condition:
>
> ```
> if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
> ```
>
> This happens because thinkpad-acpi always assumes that
> convert_dytc_to_profile() successfully updated the profile. On the
> contrary a condition can occur that when dytc_profile_refresh() is called
> the profile doesn't get updated as there is a -EOPNOTSUPP branch.
>
> Catch this situation and avoid updating the profile. Also log this into
> dynamic debugging in case any other modes should be added in the future.
>
> Fixes: c3bfcd4c6762 ("platform/x86: thinkpad_acpi: Add platform profile 
> support")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> BTW - This isn't new.  I've been seeing this a long time, but I just 
> finally
> got annoyed enough by it to find the code that triggered the sequence.

I've never seen this on my systems - is there anything in particular that can be used to reproduce the issue? I'll follow up with the FW team as setting the profile shouldn't (to my knowledge) fail. Agreed it should be handled if it does fail though.

>
>  drivers/platform/x86/thinkpad_acpi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c 
> b/drivers/platform/x86/thinkpad_acpi.c
> index c4895e9bc714..5ecd9d33250d 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10308,6 +10308,7 @@ static int convert_dytc_to_profile(int 
> funcmode, int dytcmode,
>  		return 0;
>  	default:
>  		/* Unknown function */
> +		pr_debug("unknown function 0x%x\n", funcmode);
>  		return -EOPNOTSUPP;
>  	}
>  	return 0;
> @@ -10493,8 +10494,8 @@ static void dytc_profile_refresh(void)
>  		return;
> 
>  	perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
> -	convert_dytc_to_profile(funcmode, perfmode, &profile);
> -	if (profile != dytc_current_profile) {
> +	err = convert_dytc_to_profile(funcmode, perfmode, &profile);
> +	if (!err && profile != dytc_current_profile) {
>  		dytc_current_profile = profile;
>  		platform_profile_notify();
>  	}
> -- 
> 2.34.1

Looks good to me. Thank you!
Reviewed-by Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

