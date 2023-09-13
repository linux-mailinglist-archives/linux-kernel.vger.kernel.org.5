Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1866379E8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbjIMNQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbjIMNQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:16:49 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC31BCD;
        Wed, 13 Sep 2023 06:16:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 913AC320094A;
        Wed, 13 Sep 2023 09:16:42 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Wed, 13 Sep 2023 09:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694611002; x=1694697402; bh=8A
        9HL+stgfNKGFGMeLF2z4Plw8VkJpZaGt91Sh1mq1Y=; b=rh3pCqE8iPqjbrl5b5
        vMFeTPEo5TbVPSk2kni3WdudfWZ6iYsk+1Z/9p5MiHTmzTacekEb8SYfwhcT/Cqk
        6J6xnucx73ZGnB8AsO3QpjIVXoX2JesWuO08DD9GK+QUuQ+N8Q5ERDExv2knBahS
        A8ILM+Z4mR5+UCu+XaR0fTICklw/Nwblj5D10yoSXKakbks5412sr4/a4tnl3d+7
        qCgIZni6AMK40PS85ZndzuhLb7zNIgkMbJIMtuA5YaPe/I0UKHE03JqG2/n5klLr
        ZlvwBAjYy1anUe5MP/uAKN031DVjBfv9izuyTpIveZCfSAOP7GN4CTDicmhN9iU+
        NKJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694611002; x=1694697402; bh=8A9HL+stgfNKG
        FGMeLF2z4Plw8VkJpZaGt91Sh1mq1Y=; b=Tw9onljhdYlLXnn3gGroxpKpxpiyR
        YYPMWG/WIM+brcigakvQQq2f4RxCebCqhJoXz3krBnbK2Iuf5fVcbzRzDfZ+hkw2
        V64VeRojYjZkgnNNnf7WSxwwZweHWdfT/yrVsBvsPz1ztweJvIVmGyXfOjeFedbR
        W/mDWTy/G8JKLmeq/25EgDNGeSUAMsk5CiOiCWwNMSRzHJHtIwCIOS7efbXRstjF
        I/TCB9msQjYj+YgRltk119k+Yi5CGG7iS1ltN2nA9rQLVDId/WhktGUYfx3EvxCe
        8blrO2A5zu6f2aob9CR7k5SOaaT9jCOlfsn/3ZYCNOeAInLClMpwl61dA==
X-ME-Sender: <xms:ObYBZSg8Etq8HeNBYEoFiL7U52ZWuqXzVZH-91mb-P19j5EyAntYLw>
    <xme:ObYBZTCppagdvpC-zIY0op1CaNjRB4q5u6YocEFZoz6x1Yt5fiGHAVcWCTZFCNgB_
    JclkgtFqVCofyUx9hs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:ObYBZaGBKjQBTL6OQrfLYv2-bybspqpzFvNVbq3JkPIA65MM8usqfQ>
    <xmx:ObYBZbRD38lBHBqQxs6Nq1iAxbSiStrpptW63S_Y9BF_xxglDOXTqw>
    <xmx:ObYBZfxPF0mN8YY8DuGu8tTrHqwVO2-qF6EcsD8USDYBasxpwmn-oA>
    <xmx:OrYBZf_tEFqjyEdHJFQonJXc_vbQ5ViWqFH3MQ1kXcI0dUAFSFTJYQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7A90BC6008B; Wed, 13 Sep 2023 09:16:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <28b5d008-c1b6-4be7-aabe-419d9a158492@app.fastmail.com>
In-Reply-To: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
References: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
Date:   Wed, 13 Sep 2023 09:15:36 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc:     "Mark Pearson" <markpearson@lenovo.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Subject: Re: [PATCH v1 1/2] platform/x86: think-lmi: Replace kstrdup() + strreplace()
 with kstrdup_and_replace()
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, at 5:27 AM, Andy Shevchenko wrote:
> Replace open coded functionalify of kstrdup_and_replace() with a call.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/think-lmi.c | 43 +++++++++++---------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 79346881cadb..94a3c7a74bc4 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -15,7 +15,7 @@
>  #include <linux/errno.h>
>  #include <linux/fs.h>
>  #include <linux/mutex.h>
> -#include <linux/string.h>
> +#include <linux/string_helpers.h>
>  #include <linux/types.h>
>  #include <linux/dmi.h>
>  #include <linux/wmi.h>
> @@ -432,13 +432,11 @@ static ssize_t new_password_store(struct kobject *kobj,
>  	if (!tlmi_priv.can_set_bios_password)
>  		return -EOPNOTSUPP;
> 
> -	new_pwd = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present, setting password won't work if it 
> is present */
> +	new_pwd = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_pwd)
>  		return -ENOMEM;
> 
> -	/* Strip out CR if one is present, setting password won't work if it 
> is present */
> -	strip_cr(new_pwd);
> -
>  	/* Use lock in case multiple WMI operations needed */
>  	mutex_lock(&tlmi_mutex);
> 
> @@ -709,13 +707,11 @@ static ssize_t cert_to_password_store(struct 
> kobject *kobj,
>  	if (!setting->signature || !setting->signature[0])
>  		return -EACCES;
> 
> -	passwd = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	passwd = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!passwd)
>  		return -ENOMEM;
> 
> -	/* Strip out CR if one is present */
> -	strip_cr(passwd);
> -
>  	/* Format: 'Password,Signature' */
>  	auth_str = kasprintf(GFP_KERNEL, "%s,%s", passwd, setting->signature);
>  	if (!auth_str) {
> @@ -765,11 +761,10 @@ static ssize_t certificate_store(struct kobject *kobj,
>  		return ret ?: count;
>  	}
> 
> -	new_cert = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	new_cert = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_cert)
>  		return -ENOMEM;
> -	/* Strip out CR if one is present */
> -	strip_cr(new_cert);
> 
>  	if (setting->cert_installed) {
>  		/* Certificate is installed so this is an update */
> @@ -817,13 +812,11 @@ static ssize_t signature_store(struct kobject *kobj,
>  	if (!tlmi_priv.certificate_support)
>  		return -EOPNOTSUPP;
> 
> -	new_signature = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	new_signature = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_signature)
>  		return -ENOMEM;
> 
> -	/* Strip out CR if one is present */
> -	strip_cr(new_signature);
> -
>  	/* Free any previous signature */
>  	kfree(setting->signature);
>  	setting->signature = new_signature;
> @@ -846,13 +839,11 @@ static ssize_t save_signature_store(struct kobject *kobj,
>  	if (!tlmi_priv.certificate_support)
>  		return -EOPNOTSUPP;
> 
> -	new_signature = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	new_signature = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_signature)
>  		return -ENOMEM;
> 
> -	/* Strip out CR if one is present */
> -	strip_cr(new_signature);
> -
>  	/* Free any previous signature */
>  	kfree(setting->save_signature);
>  	setting->save_signature = new_signature;
> @@ -985,13 +976,11 @@ static ssize_t current_value_store(struct kobject *kobj,
>  	if (!tlmi_priv.can_set_bios_settings)
>  		return -EOPNOTSUPP;
> 
> -	new_setting = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	new_setting = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_setting)
>  		return -ENOMEM;
> 
> -	/* Strip out CR if one is present */
> -	strip_cr(new_setting);
> -
>  	/* Use lock in case multiple WMI operations needed */
>  	mutex_lock(&tlmi_mutex);
> 
> @@ -1163,13 +1152,11 @@ static ssize_t debug_cmd_store(struct kobject 
> *kobj, struct kobj_attribute *attr
>  	if (!tlmi_priv.can_debug_cmd)
>  		return -EOPNOTSUPP;
> 
> -	new_setting = kstrdup(buf, GFP_KERNEL);
> +	/* Strip out CR if one is present */
> +	new_setting = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
>  	if (!new_setting)
>  		return -ENOMEM;
> 
> -	/* Strip out CR if one is present */
> -	strip_cr(new_setting);
> -
>  	if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>  		auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
>  				tlmi_priv.pwd_admin->password,
> -- 
> 2.40.0.1.gaa8946217a0b

Thanks Andy - didn't know about that function and it looks like a great clean-up.
I'll aim to test this out on some systems, but it looks good to me

Mark

