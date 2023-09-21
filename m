Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0CD7A9FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjIUU1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjIUU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:26 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61428D9FC;
        Thu, 21 Sep 2023 10:43:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id CB4A13200903;
        Thu, 21 Sep 2023 13:43:58 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Thu, 21 Sep 2023 13:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695318238; x=1695404638; bh=iz
        rp+cJi2u747koHaPS9Jf/GEMu7z4u0VpmdINLgVsQ=; b=GtC/oMMoJ9bdksDxAW
        427oN83lEq5BwJXiXE/03wjPNfk1rIpF1y3pSoE/d9tImirddwxtspxpOx6En4zC
        iaFQPRV10lLFUuIQgKmGRee0KXzSHpRwirEeUeMKwIFNxsEr6+l8ww1z/YlpSG+v
        rkZU9KyyC9NOk/PO7SPxfRPmFHjKHUpUI50ryYegAL2RRwgLp2Davymxby19+FjA
        z3YRSm6IjGyP+awWBLJfLNwMhWLusw36MmgL6qSLXrWHeZd3RjmLX14QlJVhwUva
        HZuG5aXiPriP3UIApOCTJhH7EnoRNP3bGWw++OVZxVX3yaX87xV3i2SgsXrAsWB2
        MCNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695318238; x=1695404638; bh=izrp+cJi2u747
        koHaPS9Jf/GEMu7z4u0VpmdINLgVsQ=; b=oE56bQtbb8z8D5sUxAdtiKTRxFh/y
        I9BZc7b+wu8t4w3pBEkP6tnwrV+YCGVbFcBJwYsVA81hBQ0awGBSIR4bBmlIqram
        nTA5jdOpdRGscoPvwdUMzLs5E3yEHgiyBnuijCEOI9sTV5qDPQM8VbfaFAWY+p5/
        65osX/9ue6+APKAgZdXhGtXkl8Vck/sStgxevFjr51Vn8R1mX8owa0M3amvtoCQJ
        JVu4DfYNEJsJ3zUsEjCvk2u84oTleYAY5B7N5SHuDRnqWnMdUtokCLuTzzoE0mjH
        eUOaCptoD8VvHE7cO/s6qPgnIbB6gIk+MWonL2NoDZWyj91MW7u9emVQw==
X-ME-Sender: <xms:3oAMZecod5Qd1jfev0nd8gHjOhrMf2dKo7fow0A7DuxtbKVDBa1kLw>
    <xme:3oAMZYMQZpS-ahYnRgYoORZDYykctWaCmjxIT3m8wfuUKViAOoo-Y6ghtaX1RzTZO
    1B1arlvg3zxDOJqr0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepieeufeejieevteduvdekteefledtveffvedu
    hefffeejudefvdeijeegudegkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:3oAMZfgRb6xWGD5KOSKKdiev3KUXjnlUqOUrnC1MH60dtfjVyVpQuA>
    <xmx:3oAMZb_i8hpQ24IuENtzyrA8kmj-1pufwd-MYJSkoY2WBCbs8AlUUw>
    <xmx:3oAMZavpeZf0PF8clWZ5yPjosz2hcT4FxJVoIeVoRhqcB0vDV36fxg>
    <xmx:3oAMZT5hWvbr9yZd_LPEB20AvnLxtuTfZz2qTBCC9lqMMK21NyYt9Q>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EF390C6008B; Thu, 21 Sep 2023 13:43:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <a94579f0-8d4a-48c5-9ecb-1fc5de7a6849@app.fastmail.com>
In-Reply-To: <e29cd141-0f38-e806-51cb-bc82c451b9c4@redhat.com>
References: <mpearson-lenovo@squebb.ca>
 <20230919141530.4805-1-mpearson-lenovo@squebb.ca>
 <e29cd141-0f38-e806-51cb-bc82c451b9c4@redhat.com>
Date:   Thu, 21 Sep 2023 13:43:36 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>
Cc:     "markgross@kernel.org" <markgross@kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: think-lmi: Add bulk save feature
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Sep 21, 2023, at 12:38 PM, Hans de Goede wrote:
> Hi Mark,
>
> On 9/19/23 16:15, Mark Pearson wrote:
>> On Lenovo platforms there is a limitation in the number of times an
>> attribute can be saved. This is an architectural limitation and it limits
>> the number of attributes that can be modified to 48.
>> A solution for this is instead of the attribute being saved after every
>> modification allow a user to bulk set the attributes and then trigger a
>> final save. This allows unlimited attributes.
>> 
>> This patch introduces a save_settings attribute that can be configured to
>> either single or bulk mode by the user.
>> Single mode is the default but customers who want to avoid the 48
>> attribute limit can enable bulk mode.
>> 
>> Displaying the save_settings attribute will display the enabled mode.
>> 
>> When in bulk mode writing 'save' to the save_settings attribute will
>> trigger a save. Once this has been done a reboot is required before more
>> attributes can be modified.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> Changes in v2:
>>  - Correct kernel version in documentation
>>  - Updated to sysfs_emit
>>  - Clean up code in save_settings_store as recommended
>>  - Use correct comment formatting
>
> Thank you for the new version, but next time when a patch has
> already been merged please send any fixes as a follow-up /
> separate patch with just the fixes.
>
> I've replaced the original patch with this one now doing
> a forced push to both my review-hans and the for-next
> branch.
>
Oh - my apologies, I didn't think of that. Thanks for cleaning up for me.
Mark
