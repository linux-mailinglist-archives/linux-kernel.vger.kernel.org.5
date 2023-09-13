Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C52C79E8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbjIMNRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbjIMNRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:17:40 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAE619B4;
        Wed, 13 Sep 2023 06:17:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id AD7C23200960;
        Wed, 13 Sep 2023 09:17:35 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Wed, 13 Sep 2023 09:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694611055; x=1694697455; bh=Wf
        4mOedLuFzgt+orK7feQF8ml3FkBn9opSNWlL/YSoE=; b=QoUaChKkBapjwsOC5f
        jzsx9CRXvwWnDYcStMmt5/2AHNcLsmw97bJwFHbVv1ZGHAJp2qi/XdL5yr6lQJ7d
        1cdanEHJ79wvfeXN08pqUbyuBFZsb45unwiSOfnx6mxEo0Id3Xm1zz68QIdC7Y2V
        Xap6WBPZIaNY6J7zV1Pz3gJeUTf+b+3kvpgc2c6Z6Sh4iKV3rYpzV73UJpq4MBA5
        IMDJdJbueV3yuRicMg2j7YQFaV/lqXgnlxl2djGDpRIQaU7juz+8NppxzRYmKIUG
        RDntuRfpHG7pTb/4W6tMxnDK9ImB/5WIVnIfwrLUqIDx54WyH6fHXXxCS1cGY1G/
        Sohg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694611055; x=1694697455; bh=Wf4mOedLuFzgt
        +orK7feQF8ml3FkBn9opSNWlL/YSoE=; b=YIG3n+6R2FxqS/2Ha9ZPmTYx9Fyv+
        Mov8VCSL5Jn8HZs1RE2We9ueyCfHNy19jD4gHkFBItfzDm7CHEzA6OEis77ad1tY
        HFXaB5gdv4IanjPbKXPcqjsnJzGy0NgUL9RUXrWSnq6MYj6D8JCiFewCGPTiTVnW
        GvlIYHUXy1mRmPv4O7vu3TuMbWN8qLCLKwgx94TXpqZqLPUKoaycdZ8u8bp+RJPC
        z28OSaDRGWFrX95Egl/z7qErDX5uS55LPd4YroEtc1q61xROOkLy5rlcXYm0d7W5
        xpLgfvZ6HrYN4uxKCJJD+Btich2BBHWR42gYU3QoY38H12JJyY4pzSnLA==
X-ME-Sender: <xms:brYBZSYAnxB5XHqQzoMSI2JLADfkR6KnMbbX3VlzsHdCGHfufgu9dQ>
    <xme:brYBZVZQ00xeos5QuparfN3jDX5ItX9wvXxeHNTQZU4TV_iX3gtoKO-QH74WsUqXs
    JRQcs1IjWz5GhFpgM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:brYBZc_QzirxpQSQG0xnQE5rpctsh7duiAYhiK6HG53uA9aYfPrpXA>
    <xmx:brYBZUpOYE9F3m3s1CfVphQECCGstyRoeu4wjYmT_UpKCjAVmK-6KA>
    <xmx:brYBZdqV0-YwYawGS_ygkCjuZDRKNnC-G3NWnycE8S256tyvZ5ye0A>
    <xmx:b7YBZUXM7L6Zmj-O0e8ALvLxauXSowakl0D3NVnxT6Usyp3b0zM29A>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BB020C6008B; Wed, 13 Sep 2023 09:17:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <35e188a5-de18-4b32-98d3-e4f460c23c1f@app.fastmail.com>
In-Reply-To: <20230913092701.440959-2-andriy.shevchenko@linux.intel.com>
References: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
 <20230913092701.440959-2-andriy.shevchenko@linux.intel.com>
Date:   Wed, 13 Sep 2023 09:17:14 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc:     "Mark Pearson" <markpearson@lenovo.com>,
        "markgross@kernel.org" <markgross@kernel.org>
Subject: Re: [PATCH v1 2/2] platform/x86: think-lmi: Use strreplace() to replace a
 character by nul
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, at 5:27 AM, Andy Shevchenko wrote:
> We can replace
> 	p = strchrnul(str, '$OLD');
> 	*p = '\0';
> with
> 	strreplace(str, '$OLD', '\0');
> that does the compatible modification without a need of the temporary variable.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/think-lmi.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 94a3c7a74bc4..2f20fafe7f55 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -198,14 +198,6 @@ static struct think_lmi tlmi_priv;
>  static struct class *fw_attr_class;
>  static DEFINE_MUTEX(tlmi_mutex);
> 
> -/* ------ Utility functions ------------*/
> -/* Strip out CR if one is present */
> -static void strip_cr(char *str)
> -{
> -	char *p = strchrnul(str, '\n');
> -	*p = '\0';
> -}
> -
>  /* Convert BIOS WMI error string to suitable error code */
>  static int tlmi_errstr_to_err(const char *errstr)
>  {
> @@ -411,7 +403,7 @@ static ssize_t current_password_store(struct kobject *kobj,
> 
>  	strscpy(setting->password, buf, setting->maxlen);
>  	/* Strip out CR if one is present, setting password won't work if it 
> is present */
> -	strip_cr(setting->password);
> +	strreplace(setting->password, '\n', '\0');
>  	return count;
>  }
> 
> @@ -921,7 +913,7 @@ static ssize_t display_name_show(struct kobject 
> *kobj, struct kobj_attribute *at
>  static ssize_t current_value_show(struct kobject *kobj, struct 
> kobj_attribute *attr, char *buf)
>  {
>  	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
> -	char *item, *value, *p;
> +	char *item, *value;
>  	int ret;
> 
>  	ret = tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID);
> @@ -934,8 +926,7 @@ static ssize_t current_value_show(struct kobject 
> *kobj, struct kobj_attribute *a
>  		ret = -EINVAL;
>  	else {
>  		/* On Workstations remove the Options part after the value */
> -		p = strchrnul(value, ';');
> -		*p = '\0';
> +		strreplace(value, ';', '\0');
>  		ret = sysfs_emit(buf, "%s\n", value + 1);
>  	}
>  	kfree(item);
> @@ -1418,7 +1409,6 @@ static int tlmi_analyze(void)
>  	for (i = 0; i < TLMI_SETTINGS_COUNT; ++i) {
>  		struct tlmi_attr_setting *setting;
>  		char *item = NULL;
> -		char *p;
> 
>  		tlmi_priv.setting[i] = NULL;
>  		ret = tlmi_setting(i, &item, LENOVO_BIOS_SETTING_GUID);
> @@ -1435,8 +1425,7 @@ static int tlmi_analyze(void)
>  		strreplace(item, '/', '\\');
> 
>  		/* Remove the value part */
> -		p = strchrnul(item, ',');
> -		*p = '\0';
> +		strreplace(item, ',', '\0');
> 
>  		/* Create a setting entry */
>  		setting = kzalloc(sizeof(*setting), GFP_KERNEL);
> -- 
> 2.40.0.1.gaa8946217a0b

Looks good to me. Will aim to test and confirm on some systems.
Thanks for the cleanup!

Mark
