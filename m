Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447A0792AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbjIEQpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354404AbjIELZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:25:22 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040771AB;
        Tue,  5 Sep 2023 04:25:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 726695C00D8;
        Tue,  5 Sep 2023 07:25:13 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Tue, 05 Sep 2023 07:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1693913113; x=1693999513; bh=iK
        kb5+b+KXkjFLw1xousdHJCRRtavTcHf98vMADhkF8=; b=ASNPImhWEn/bW87Wnc
        OTVXbGnApRSAVSjkFhTME1nE5LGGJiJD1sI8IuGPrdOrkxNiiG5GLL1UzTtJmHIb
        3dUb3wwfxLlmT9SwTWuBPjkiLorJkDA7wfYTIlKV6hhJHiKSczg/e7BTJdoWKv1N
        gD9S36YyHuNNhzELPoxrJZdSKibNsoQ1jZaTMSou5oH4Q1JMCPhGWii/vgCPs2fO
        VLrTDsRCv2zGxbRj72TPgL5KJosg8wOWR9efMZgDwm7TG9sucxAJWDrM5JbRY2gR
        ISebRh00wvS4KZ+5w+JMWsk5JVJx4a9WoKmq2ZshgShtY6FVRFsZuxrczHUXjmoi
        eC9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693913113; x=1693999513; bh=iKkb5+b+KXkjF
        Lw1xousdHJCRRtavTcHf98vMADhkF8=; b=e3ZqrM5gEruFyQ8gKXPUcCpgiU645
        ZUTMBArz3upuHV2+vG+9RlA7SiA2qz+UyWU2LXh6ujI1miFhTxVgU+fvhsj7gyA7
        qisPKVtF7srWgCou4ZldWgn1JkxpQCOvPQf1nBQIMX0A2Kkra7q3AXoub0mIhjr+
        eNx13sXx0K7Ug8GuioZkMlsSanWy9JQ/5LSae0JGpnYKqVtO4gFqdHeTB3TJVFL0
        +J+Z+P3XHjwlfEirLdL85xaI+/rOqXvhppIr4uRkfESAPqG5rZyd0/IiKwXRCpRG
        oD1vUlld8VVlYbj4v6KSDVQSjb/HPgZZHZAmTeHzSqp86sMl9TOfl302A==
X-ME-Sender: <xms:GRD3ZCflNgSXMyeIqun75wzG0-FL8mTDCoB3vskI1fiHNAse86z1DQ>
    <xme:GRD3ZMO3Kneg00wkx6thAHEPVQhP2v60myd3XAUJAS-GcD1B4yTj6GFTPq-zNLxC6
    Upz62TxGRP1xttJcH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehuddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:GRD3ZDjIbZc7CblkWqG-ttsMXc0mBSDj3xoPl5Fsejw4cyrcqZv1iQ>
    <xmx:GRD3ZP_7I4TCyAHcSRHMNgdpC1Kr6OK8UEmAKl1r033GTxYMFAfvsg>
    <xmx:GRD3ZOspEUX7HWN7pSlyUroA7HYHUKFPdofb1Q_CcmBMfwQuim2dOg>
    <xmx:GRD3ZDXoWEoIrAJFD0pP8KUqYpktgCdZkmr6PlTO3ABO_3JDdkeNig>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0D908C6008B; Tue,  5 Sep 2023 07:25:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <8ca1d0f1-4064-4804-aa0a-d8633e0e6361@app.fastmail.com>
In-Reply-To: <59d1b822-e8e1-9373-1942-0f376abb02b8@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230829131523.17369-1-mpearson-lenovo@squebb.ca>
 <59d1b822-e8e1-9373-1942-0f376abb02b8@redhat.com>
Date:   Tue, 05 Sep 2023 07:24:33 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: think-lmi: Add bulk save feature
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Hans,

On Tue, Sep 5, 2023, at 7:17 AM, Hans de Goede wrote:
> Hi Mark,
>
> On 8/29/23 15:15, Mark Pearson wrote:
<snip>
>> +
>> +	/* Check if user is trying to change the save mode */
>> +	if (!strncmp(buf, "bulk", 4) || !strncmp(buf, "single", 6)) {
>> +		tlmi_priv.save_mode = strncmp(buf, "bulk", 4) ? TLMI_SAVE_SINGLE : TLMI_SAVE_BULK;
>> +		return count;
>> +	}
>> +	if (strncmp(buf, "save", 4))
>> +		return -EINVAL;
>
> Things look good up to this point, but I'm not happy
> with the string parsing here. Using strncmp to avoid
> a possible '\n' means that writing
> "bulk extra special with onions" will also match "bulk".
>
> Instead I suggest the following (better names
> for the enum are welcome):
>
> 	enum { save_single, save_bulk, save_save };
>
> 	const char * const save_strings[] = {
> 		[save_single] = "single",
> 		[save_bulk] = "bulk",
> 		[save_save] = "save",
> 	};
>
> 	int ret = 0;
> 	int cmd;
>
> 	cmd = sysfs_match_string(save_strings, buf);
> 	if (cmd < 0)
> 		return cmd;
>
> 	mutex_lock(&tlmi_mutex);
>
> 	switch (cmd) {
> 	case save_single:
> 		tlmi_priv.save_mode = TLMI_SAVE_SINGLE;
> 		goto out;
> 	case save_bulk:
> 		tlmi_priv.save_mode = TLMI_SAVE_BULK;
> 		goto out;
> 	case save_save:
> 		break; /* Continue with saving settings */
> 	}
>
> 	/* The user is triggering a save - if supported */
> 	if (!tlmi_priv.can_set_bios_settings ||
> 	    tlmi_priv.save_mode == TLMI_SAVE_SINGLE)
> 		return -EOPNOTSUPP;
>
> 	...
>
> This lets sysfs_match_string() do the string parsing work
> for us, getting rid of having to do this ourselves.
>
Agreed - this is much better. Thanks for the suggestion and I'll make the change.

> Notice I have also moved the mutex_lock() up, so that
> it is also done for updating the save_mode since we
> don't want that the change halfway through a possibly
> racing current_value_store() call.
>
Ack

Mark
