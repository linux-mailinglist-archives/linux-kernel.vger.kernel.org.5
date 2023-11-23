Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6292E7F5640
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjKWCEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjKWCEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:04:15 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C5E1B3;
        Wed, 22 Nov 2023 18:04:21 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C7AA43200A2C;
        Wed, 22 Nov 2023 21:04:18 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Wed, 22 Nov 2023 21:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1700705058; x=1700791458; bh=vS
        hwBIiU1qk+sBYM8a4RM2atQ1b7lFgMjSeqpTAPbfs=; b=Rj+fMAEVfv6CXMwB7A
        B97pLsfITXQlTrUv8malOnHh0W9rP3pq/qZt5XmPoNtJowhPYmL2Uk0OFhQFz6If
        AUIlY/RX51yw+UHN/zUnuYD050npN6QIFgS2xASRDJH3OiRtRwUayLAR6wmj8lFu
        vO1kWefD2St5fkuC1vpBYieziwstLPwAWyPC03VgT2Ve8UxM8a4bqNkCiAa335En
        CyII1UX3M6wsvtHAz7QY4vCuuwu1ckB+pXJaIcM3XwotCssZkX/7xGZ8ya8Xt14i
        aDn7IPLHECuR5xfYXGebn5awAGshrye/NwaKzg9tyApRf9uyl2OzbFaYg8wi89/W
        mHpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700705058; x=1700791458; bh=vShwBIiU1qk+s
        BYM8a4RM2atQ1b7lFgMjSeqpTAPbfs=; b=GLJ8SRTmzD9i2PjqBH7GII1xljvWU
        hGcZdFbGj0LJ7c3ju+fHxLMVDf2HH8e45VyqSJ24jOsnDtSUH0euX63lSczX6cJc
        S9Y4kcAdiy+bfAltvsM6bFXOoEn277e5zmCTAIF+vwNDWX87ZiBKpL4PmCeClgZ4
        PDJ4d9nu2fVGFFlEeeBagQOXZtVDq3Wkc0QczMpgztNwm5WzY3u+Bc5t2nDCzxbj
        b+iP0V+yp67xZt1Un6OlitMmyud4LrUvfqlXjecptlGnxZha/PO6nPWS7E9p/Uph
        yUqj6ZbJuXFJVmCE7XFH4GN2R+Cwo6suF8qTFXi7oOeV1cchCFF4kH32A==
X-ME-Sender: <xms:IbNeZU0dO10cMzwoNo_yyQcxQJDzgi_yDveGZ2aRMYI1JEUkDKpSTg>
    <xme:IbNeZfHDcN-y3Db5Jt-J0DOBoIBAYtbwlnnaUbQDyziZpMyflV47umn32lQwiueJI
    Ts9b3ncOS7C4ciU3Qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehvddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:IbNeZc5LmgrAoTV5nraJhz1Rg-Gx-NorldAbmRtqWCIrD66K0k1gkQ>
    <xmx:IbNeZd3GmO5qWyDJ25_fkzlueY0KXqdqqej1J1vgNIfPVKIJDCuVGw>
    <xmx:IbNeZXH-tg9wBC-0uOdZ69mrgdC3dSveXfHPLwopC45LkB9zX7qxDA>
    <xmx:IrNeZbhRMuIghaouNWIvdkd93DLYZd3VodIHYDil1uFJZKBsHIT0jg>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 85559C6008B; Wed, 22 Nov 2023 21:04:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <7ff45ca3-cf28-4a7c-aedf-3dcb51129a3d@app.fastmail.com>
In-Reply-To: <20231122194453.GA497690@gmail.com>
References: <mpearson-lenovo@squebb.ca>
 <20231113165453.6335-1-mpearson-lenovo@squebb.ca>
 <20231122194453.GA497690@gmail.com>
Date:   Wed, 22 Nov 2023 21:03:57 -0500
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Breno Leitao" <leitao@debian.org>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: Add support for improved performance mode
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Breno,

Thanks for the review!

On Wed, Nov 22, 2023, at 2:44 PM, Breno Leitao wrote:
> On Mon, Nov 13, 2023 at 11:54:33AM -0500, Mark Pearson wrote:
>> @@ -10355,6 +10361,17 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>>  	if (err)
>>  		goto unlock;
>>  
>> +	/* Set TMS mode appropriately (enable for performance), if available */
>> +	if (dytc_ultraperf_cap) {
>> +		int cmd;
>> +
>> +		cmd = DYTC_SET_COMMAND(DYTC_FUNCTION_TMS, DYTC_NOMODE,
>> +				       profile == PLATFORM_PROFILE_PERFORMANCE);
>> +		err = dytc_command(cmd, &output);
>> +		if (err)
>> +			return err;
>
> Aren't you returning holding the 'dytc_mutex' mutex?
>
> From what I understand, in the first line of this function you get the lock,
> and release later, at the exit, so, returning without releasing the lock might
> be dangerous. Here is a summary of how I read this function with your change:
>
>
> 	mutex_lock_interruptible(&dytc_mutex);
> 	...
> 	err = dytc_command(cmd, &output);
> 	if (err)
> 		return err;
>
> unlock:
> 	mutex_unlock(&dytc_mutex);
> 	return err;
>
>
> I think "goto unlock" might solve it.

Yep - you're right. Good catch. 
Will fix in the next revision.

Thank you
Mark
