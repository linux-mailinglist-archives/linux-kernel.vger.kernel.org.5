Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A644A7B99F5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 04:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjJECdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 22:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjJECda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 22:33:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C740BF;
        Wed,  4 Oct 2023 19:33:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E2F4F3200A38;
        Wed,  4 Oct 2023 22:33:22 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 04 Oct 2023 22:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sunshowers.io;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1696473202; x=
        1696559602; bh=+ykVcDNQpe3Wayw5bVO9ujhoPPxQJYNJ3ME9TY3526o=; b=J
        ie7INwtkh/Kn5VcFPaJVbRyKHwAZDEzL6lJIni9ffwn7gsUhU1CCkXbIaD++eNYt
        oo5kQUrYyISzM46lFIZmSG+LNTeE/t+PPFiJ2XvOau+2BmNBMoFULHgEForJEXMS
        VM/cHrlOFkz+tsnMiwUpbFxbpSgfn1DofOi+SRWu8FuB4GhON9YBK3Ak/MXqBMap
        QjS35yzGrzIgkPOsue/tswqVZwZKxgPX0q/uxWDJkQ+4hAXKE+MuRC1gnXrINzNW
        xE0AgpxCzHb2kt767d32hcSVLYQyuWpyFR1hq6uOlTBDkHekeQVIALGEtETZvOnj
        BjSEQFQj1n+hzVcrScdFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696473202; x=1696559602; bh=+ykVcDNQpe3Wa
        yw5bVO9ujhoPPxQJYNJ3ME9TY3526o=; b=BcHmHvYoqYPiPUwhCM49Wz3tyYi5V
        50ekGepwKJDeZFReo+vcB3I9IchQY/gPoipRUe88SndGNMYIZfMmAU2zx300WRlt
        J4wW7+Af38alSfYEHcnxUwDeV+T3yzIob3cdfVbIL6PcxH9HGJn93yzepEm8lQ5n
        i9910HCTAXjBiL7nKmH6ZN+StF1RQHPx7OOs64F15FR3hYHys7hENYlRsq45h2HT
        7aHKzK+s5jLMUh/aMm6svet0J1KboqoOVx44OCI+7G/ezTL0GPVMOwskA94BLo/O
        LOkocMucMvci3oxBjoL7646FeURvBKSofSp/amtA7AflZGaMGjw//R4yA==
X-ME-Sender: <xms:ciAeZYa9s3V6HUObXyKvMoPo-N6655sjH3Suk9AqB9ho-UBeERPk8w>
    <xme:ciAeZTYyTM3eviCdaXHrfSWJmhYj51lT7U-FjIy4GWDQXP5Kf5DmJ37S7JLCLGaNM
    E4KcUPsBomhOy0TDfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeefgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomheptfgrihhn
    uceorhgrihhnsehsuhhnshhhohifvghrshdrihhoqeenucggtffrrghtthgvrhhnpeeuge
    euhfeijeegffetffekheejieejhfduieeftdeiveevgefhkeegvdfgkeetgfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrihhnsehsuhhnshhhohifvghrshdrihho
X-ME-Proxy: <xmx:ciAeZS89tvNoG4oumwHYJ_CcjDoVefPaJpoZx21XXQBvjdnXw0SdAw>
    <xmx:ciAeZSqzx-1SPFgnvwiRRmC3VuwzCD7Kc7XDEQ4GjehhGff588iqvw>
    <xmx:ciAeZTrJ-nsuePU6ottYcNalYyMTENEeBHxuQh76w966QbFpV4RLiQ>
    <xmx:ciAeZSUIlvaG9QXnYY73P8GiDEZ-osnm5JzEeITQVK2jfiFbfI_gOQ>
Feedback-ID: iaa1146ff:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E58C15A0092; Wed,  4 Oct 2023 22:33:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <190f5fc0-eee9-4f42-8ba0-4abfa315f533@app.fastmail.com>
In-Reply-To: <8734ypls3y.fsf@protonmail.com>
References: <20230917161802.39716-1-sergeantsagara@protonmail.com>
 <e0f33dd3-1a35-4c76-889f-a80e42da2ded@app.fastmail.com>
 <8734ypls3y.fsf@protonmail.com>
Date:   Wed, 04 Oct 2023 19:33:01 -0700
From:   Rain <rain@sunshowers.io>
To:     "Rahul Rameshbabu" <sergeantsagara@protonmail.com>
Cc:     "Jiri Kosina" <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        "Henrik Rydberg" <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: Add required quirk for Synaptics 0xcd7e device
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Oct 4, 2023, at 19:29, Rahul Rameshbabu wrote:
> On Wed, 04 Oct, 2023 12:01:27 -0700 "Rain" <rain@sunshowers.io> wrote:
>> On Sun, Sep 17, 2023, at 09:18, Rahul Rameshbabu wrote:
>>> Register the Synaptics device as a special multitouch device with certain
>>> quirks that may improve usability of the touchpad device.
>>>
>>> Reported-by: Rain <rain@sunshowers.io>
>>> Closes:
>>> https://lore.kernel.org/linux-input/2bbb8e1d-1793-4df1-810f-cb0137341ff4@app.fastmail.com/
>>> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
>>> ---
>>>
>>> Notes:
>>>     Theory:
>>>
>>>       I think the Synaptics device in the related email to the linux-input
>>>       mailing list requires certain quirks like MT_QUIRK_HOVERING to correctly
>>>       reconfigure the distance configuration for multitouch events. This might
>>>       explain why light touches were not registered originally when
>>>       MT_CLS_DEFAULT was used by default for the device. Would like to have
>>>       this patch tested before being merged. A Tested-by: git trailer can then
>>>       be appended.
>>>
>>>  drivers/hid/hid-multitouch.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>>> index 521b2ffb4244..8db4ae05febc 100644
>>> --- a/drivers/hid/hid-multitouch.c
>>> +++ b/drivers/hid/hid-multitouch.c
>>> @@ -2144,6 +2144,10 @@ static const struct hid_device_id mt_devices[] = {
>>>  			USB_DEVICE_ID_MTP_STM)},
>>>
>>>  	/* Synaptics devices */
>>> +	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
>>> +		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
>>> +			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
>>
>> Thanks for the patch! I haven't tested it yet but it looks promising.
>>
>> The vendor ID isn't USB_VENDOR_ID_SYNAPTICS (0x06cb),
>> however -- it's SYNA7DB5 (0x7db5) which I guess is an alternative vendor
>> ID for Synaptics. Would be worth fixing that.
>
> Hi Rain,
>
> I think you might be confusing the device name string with the vendor
> id, based on my interpretation of the output you shared.
>
>   [    2.034760] input: SYNA7DB5:00 06CB:CD7E Mouse as 
> /devices/platform/AMDI0010:00/i2c-0/i2c-SYNA7DB5:00/0018:06CB:CD7E.0001/input/input1
>   [    2.034865] input: SYNA7DB5:00 06CB:CD7E Touchpad as 
> /devices/platform/AMDI0010:00/i2c-0/i2c-SYNA7DB5:00/0018:06CB:CD7E.0001/input/input2
>
> The first column has a device name but what we are interested in is the
> second column, '06CB:CD7E'. 0x06CB is the vendor id and 0xCD7E is the
> device id. Hope that makes sense and let me know if you think this is
> off.

Ah, got it, thank you! I was definitely misreading what was going on and
was a bit thrown off by the "SYNA7DB5". Sorry about the confusion.

> In general for these types of issues, I think the right direction would
> be to make quirks loadable in userspace through HID-BPF where DEs or
> some systemd subsystem can help users load quirks needed for their HID
> devices rather than building a list of quirks in the driver. This is
> something I am interested in exploring.

That would definitely be very interesting.

Thanks again for the fix.
