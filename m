Return-Path: <linux-kernel+bounces-142700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88B8A2F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40DFB21173
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E595FB85;
	Fri, 12 Apr 2024 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="jgplKWKh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EBzziB8K"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC0F50275;
	Fri, 12 Apr 2024 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927724; cv=none; b=tzHayyJxGlPr+gUSYT85iHH9H1bfQumsB7gpuDisQHW4CuIvwjYHJNsObYjFVbsr39J1l00UeSjyHaL7Xq/bGaxtt930A3sPsnuiZzAjE6+fpdTL18Pvke814l3riNdHjZXdTRPaflRJoDPnvO7StLIHT52QLmSCzm+VIwoe5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927724; c=relaxed/simple;
	bh=G/CAnWQVwJlZsevuXGcKmZ4k1MkuHfrJSDBRwH53I+Y=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=YLFVEe9fLYwLd/mNJKwykz5NVhqqCRX1BhjSQ64DAAyIwEPXuKaNKneBLdIrtzh2bG40K4vvd5OmSfHZ4rsTSUtoSVenanBoKeZtz4Ky94/SeuX02ra05zI4PpjLpGPW+dFU1iwOwK34iJIIAImEsGzpZWoDmZO9XcT4HsZMZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=jgplKWKh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EBzziB8K; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3FCBC114020A;
	Fri, 12 Apr 2024 09:15:21 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Fri, 12 Apr 2024 09:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1712927721;
	 x=1713014121; bh=LMMkhZtU6SPcb8ZErUBvL/c9FjjlKWtrP/A62oroo+s=; b=
	jgplKWKhdFXOZLeHGMQv/uyAD0nKdEYvAoMI93sYnRBODmkGuCyTG2YJM9DLq50E
	xMzxxXY4xHo380HZnNGFwKJe2Z3olWm9DEgUI3ftFoV62BQP3c8FMZDcZqsOmGfg
	T1igQTnbbH1cnTNiYFMoY8WS0Xgwl+c/9hiVdcfIpnjYKfcIa+yWXJ5MHEfUYSmf
	Cz2B/Mqfvj3th0QpULrKBmcFPTTmyP+sN9B5lgECvg4L37U6nhipm1NKBSHENAHF
	AG4MwMsim2SR1lZFJ3gBU45q3idjeyghdUA+g/vSBhkZEZ2L4RSuCTYFqBgFDfRC
	0qo25ljbSgYOKiW0l0a9aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712927721; x=
	1713014121; bh=LMMkhZtU6SPcb8ZErUBvL/c9FjjlKWtrP/A62oroo+s=; b=E
	BzziB8K+t2FKdMlLBBXjYMHmV3ziNIXULMALO/kfhc0iWBHvH6mzdGaSeZ5f8Oww
	AQrfGJowwXy4cd7IaBiQv0SyuPAkie8F46nnQFEIHoK8xd6FSnRiCQPCVDeBD+sS
	wqD9BCg8vCsJuvBrsF8sY6+6d39mb5hxCXjs8Q8BqRDIfc67ZrLM+33cXinAlsf9
	YBYCDV5wuD8bC8GGGUyN/JhTBaQpr2x1QB23Eep6A50ROCKfX4XbiqqijausCfgx
	hZQCkivDNeY2lk/3U8XgXN4RAVEyoFFBkaIFuIe3BuwCM26zOcDLjiMyPTclL7Gl
	K1UQUUaO6mSYI9m3DBBAQ==
X-ME-Sender: <xms:6TMZZtTlQ4L4L4Xax8G9l2MryE1CHyGkx_iEpLLNTlwqg7_bqT-Lew>
    <xme:6TMZZmxvy3ZMXf4o6mC4fCS62OkpI0P2gOwEsjHVRcUpmSapPMrGkm1xeLnJjaCPm
    zcCbjekhKkmQbuXGeE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeffueevudduhefgudehtdevgeeftdehuefhleet
    jeetvdevfefhveeuhfehgeeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:6TMZZi3RqbGydlfUeHKVs4AZa7GjAokaw17c8AMCI-XIlnCF308QXw>
    <xmx:6TMZZlDqm1ePRG0OT7nYGG7ayNG8zLgranGOpiwGBhMXUm5xZ50tEA>
    <xmx:6TMZZmho6v9VM0cHKsRDQCBC3BoH1UN7MrCO3eWAh--2cWRdhO69Cw>
    <xmx:6TMZZpqAYoFPB7wPSGmhDAZqDgu3ZJk6i2qab0SlD6KblKHeQqrEeQ>
    <xmx:6TMZZucIUG3fFAmiWovWuUexFW2dgeGZCzrZVWpQhq_YYxY9MqsC1pIG>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D94CFC60097; Fri, 12 Apr 2024 09:15:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <212159e6-66b5-45d3-bce8-d6fde43370fe@app.fastmail.com>
In-Reply-To: <20240412130903.2836-1-ilpo.jarvinen@linux.intel.com>
References: <20240412130903.2836-1-ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Apr 2024 09:15:02 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Mark Pearson" <markpearson@lenovo.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] platform/x86: think-lmi: Convert container_of() macros to
 static inline
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks Ilpo,

On Fri, Apr 12, 2024, at 9:09 AM, Ilpo J=C3=A4rvinen wrote:
> The macros to_tlmi_pwd_setting() and to_tlmi_attr_setting() are fragile
> because they expect the variable name to be 'kobj', otherwise the build
> will fail because container_of()'s 3rd parameter (member) is taken from
> the parameter given to the macro.
>
> While at it, move them into a more logical place.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/platform/x86/think-lmi.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c=20
> b/drivers/platform/x86/think-lmi.c
> index 9345316b45db..0f2264bb7577 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -175,9 +175,6 @@ MODULE_PARM_DESC(debug_support, "Enable debug=20
> command support");
>  #define TLMI_SMP_PWD BIT(6) /* System Management */
>  #define TLMI_CERT    BIT(7) /* Certificate Based */
>=20
> -#define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct=20
> tlmi_pwd_setting, kobj)
> -#define to_tlmi_attr_setting(kobj)  container_of(kobj, struct=20
> tlmi_attr_setting, kobj)
> -
>  static const struct tlmi_err_codes tlmi_errs[] =3D {
>  	{"Success", 0},
>  	{"Not Supported", -EOPNOTSUPP},
> @@ -198,6 +195,16 @@ static struct think_lmi tlmi_priv;
>  static const struct class *fw_attr_class;
>  static DEFINE_MUTEX(tlmi_mutex);
>=20
> +static inline struct tlmi_pwd_setting *to_tlmi_pwd_setting(struct=20
> kobject *kobj)
> +{
> +	return container_of(kobj, struct tlmi_pwd_setting, kobj);
> +}
> +
> +static inline struct tlmi_attr_setting *to_tlmi_attr_setting(struct=20
> kobject *kobj)
> +{
> +	return container_of(kobj, struct tlmi_attr_setting, kobj);
> +}
> +
>  /* Convert BIOS WMI error string to suitable error code */
>  static int tlmi_errstr_to_err(const char *errstr)
>  {
> --=20
> 2.39.2

Looks good to me. Let me know if you want this tested on Lenovo HW and I=
'll do a build with this in - but it looks very uncontroversial :)

Reviewed-by Mark Pearson <mpearson-lenovo@squebbb.ca>

