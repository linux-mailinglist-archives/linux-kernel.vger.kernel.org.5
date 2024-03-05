Return-Path: <linux-kernel+bounces-92919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972B687281E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26A4B2B2CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D3288DB;
	Tue,  5 Mar 2024 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="wTcVlK+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oXUzkWLO"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18565A796;
	Tue,  5 Mar 2024 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668707; cv=none; b=WcAiU/TkIk0wmokuPu7PLr7jATBVBzzbchbnERf3OwZ6eUVQXAUgMW97khux3tEhE5buOazsS+yAWHXgaqVID0dc+v1yLUAIXphW9Ie3kwbBhcAjQ17li1kdSmjFGVKKWca6CQzE3zDMeRAXL+KJWE+dJQ0tcWennWZx0rvwsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668707; c=relaxed/simple;
	bh=eQLO8DF1kv6WfXsDwrMNOAtzyg8YsilIefEhAZZoC+k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=CQY0yZhNusHu9HYbX8UWHnst0+bbZ5m3O/2Jf7NtKaQpU350oinA1/3oKQzglBQWZYme90NzkBZsNgHTEn8wVcoJj2KbCX/+uIdcPpFYZ07lR7Lh2GvxZXAgJhIJVVXk2vHh7lgksW5BfJyrYDE+ynNdqaUbpIr8RyrqPkLpTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=wTcVlK+g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oXUzkWLO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B407D114019C;
	Tue,  5 Mar 2024 14:58:22 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Tue, 05 Mar 2024 14:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1709668702; x=1709755102; bh=jqQczWPa8T
	/gRaAla0AC5dW+jYjjTWOB+VZ7VK/lLK8=; b=wTcVlK+gW+JsMDRx0iEb2xWF5l
	4Qp32Pwz+Fam014GaW+o14CajLsJpO392b7QJrxfmRcypn9mO6mK9aLZT6vixeRN
	+vdgfSg4SZaAV93j5y+FScus/ZGNdsTkrs/yZygHO+gkB4534I1DLam/eWfpqgZL
	QVLRb1r7PM3KuD6N0FXkR+iIaIY0wJeH5zB9OTWWtXULFKHJbxGYInkHcvj0uG14
	YmWtkCai0atplufd/Np7b5TkxrSl94d1YdpfK6OjCbtA4PVveXTgh2CZdYYuv2j0
	0mlJoBozfbACZGHTG4w5Lvzhcc66gg1cBZG/vRzOiZOVH8cd3C2eoo6yTlwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709668702; x=1709755102; bh=jqQczWPa8T/gRaAla0AC5dW+jYjj
	TWOB+VZ7VK/lLK8=; b=oXUzkWLOsUWXGfKuL8TzWqEE8oUMFxI3lTpUOiSMDHv+
	7UeCI3hp+tWYyHSGeO0afClRET0p76JQKIwKFyvyFsZnHGVLZZ6aHFl4ewuEuARt
	Hmm8GZGORgmKrccsh8uTmfGD02ckWCuqDQb8tVHs/XPb4pfXlZwU5m6zxwTOe2wV
	z25z/wesLm+r2fxT+OTWscuEdQyLGtei3zntSFlEId7NS3Ta3YbJ3NDjrM2OdPHq
	eXKSFmCfgpy+21WV9xECOvupkjVfP5HgJWkWA7YNpsKm6aY6QnSEX842XbC3/uk0
	KODgVq8kxHXxyJUh/O/tnr/LQGu/d0hQlLYGNfeXZg==
X-ME-Sender: <xms:XnnnZTYwCdgIT7BToTLPO9pDaDGK7HaNV85Pu1PV3YQCLWcLtUw-HQ>
    <xme:XnnnZSYn-MreMakt0ns-BDWerpwutACr0pNMOrBsKhaivAO7WBnMf0T14t23nWoGI
    wP29c18i5uHolMR63U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:XnnnZV8nPWHVQheT3T2lEz0FkULOgExQOalma3CfBUvdka5NwvgHdg>
    <xmx:XnnnZZqJ4ErX2lfSGZ1T-EwD70-A0U2LwVvXM4ffjzGRHC7ai7XOew>
    <xmx:XnnnZeq2dj_mc1oB9Ssit8hf10mDTUPWbDZIxwAIOgTp5KHhgzkt7w>
    <xmx:XnnnZd1E8_psoJFR639DhXbnWpjy85C1k9P-GG-KEOPUql0YQfIfMA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2AF6BC60098; Tue,  5 Mar 2024 14:58:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <798593af-f64d-4378-bacb-ea0c2323dc51@app.fastmail.com>
In-Reply-To: <20240305-class_cleanup-platform-v1-1-9085c97b9355@marliere.net>
References: <20240305-class_cleanup-platform-v1-1-9085c97b9355@marliere.net>
Date: Tue, 05 Mar 2024 14:58:24 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 "Prasanth Ksr" <prasanth.ksr@dell.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Jorge Lopez" <jorge.lopez2@hp.com>, "Mark Pearson" <markpearson@lenovo.com>
Cc: Dell.Client.Kernel@dell.com,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Greg KH" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] platform/x86: make fw_attr_class constant
Content-Type: text/plain

Hi

On Tue, Mar 5, 2024, at 1:55 PM, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the fw_attr_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 2 +-
>  drivers/platform/x86/firmware_attributes_class.c   | 4 ++--
>  drivers/platform/x86/firmware_attributes_class.h   | 2 +-
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c       | 2 +-
>  drivers/platform/x86/think-lmi.c                   | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c 
> b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> index b929b4f82420..9def7983d7d6 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -25,7 +25,7 @@ struct wmi_sysman_priv wmi_priv = {
>  /* reset bios to defaults */
>  static const char * const reset_types[] = {"builtinsafe", 
> "lastknowngood", "factory", "custom"};
>  static int reset_option = -1;
> -static struct class *fw_attr_class;
> +static const struct class *fw_attr_class;
> 
> 
>  /**
> diff --git a/drivers/platform/x86/firmware_attributes_class.c 
> b/drivers/platform/x86/firmware_attributes_class.c
> index fafe8eaf6e3e..dd8240009565 100644
> --- a/drivers/platform/x86/firmware_attributes_class.c
> +++ b/drivers/platform/x86/firmware_attributes_class.c
> @@ -10,11 +10,11 @@
>  static DEFINE_MUTEX(fw_attr_lock);
>  static int fw_attr_inuse;
> 
> -static struct class firmware_attributes_class = {
> +static const struct class firmware_attributes_class = {
>  	.name = "firmware-attributes",
>  };
> 
> -int fw_attributes_class_get(struct class **fw_attr_class)
> +int fw_attributes_class_get(const struct class **fw_attr_class)
>  {
>  	int err;
> 
> diff --git a/drivers/platform/x86/firmware_attributes_class.h 
> b/drivers/platform/x86/firmware_attributes_class.h
> index 486485cb1f54..363c75f1ac1b 100644
> --- a/drivers/platform/x86/firmware_attributes_class.h
> +++ b/drivers/platform/x86/firmware_attributes_class.h
> @@ -5,7 +5,7 @@
>  #ifndef FW_ATTR_CLASS_H
>  #define FW_ATTR_CLASS_H
> 
> -int fw_attributes_class_get(struct class **fw_attr_class);
> +int fw_attributes_class_get(const struct class **fw_attr_class);
>  int fw_attributes_class_put(void);
> 
>  #endif /* FW_ATTR_CLASS_H */
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c 
> b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> index 8c9f4f3227fc..2dc50152158a 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -24,7 +24,7 @@ struct bioscfg_priv bioscfg_drv = {
>  	.mutex = __MUTEX_INITIALIZER(bioscfg_drv.mutex),
>  };
> 
> -static struct class *fw_attr_class;
> +static const struct class *fw_attr_class;
> 
>  ssize_t display_name_language_code_show(struct kobject *kobj,
>  					struct kobj_attribute *attr,
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 3a396b763c49..9eeef356e308 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -195,7 +195,7 @@ static const char * const level_options[] = {
>  	[TLMI_LEVEL_MASTER] = "master",
>  };
>  static struct think_lmi tlmi_priv;
> -static struct class *fw_attr_class;
> +static const struct class *fw_attr_class;
>  static DEFINE_MUTEX(tlmi_mutex);
> 
>  /* Convert BIOS WMI error string to suitable error code */
>
> ---
> base-commit: 36c45cfc5cb3762b60707be2667c13d9a2562b34
> change-id: 20240305-class_cleanup-platform-8010ec550021
>
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>

Looks good to me!
Reviewed-by Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

