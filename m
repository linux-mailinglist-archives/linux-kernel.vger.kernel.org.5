Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15577DADB5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjJ2Shg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2She (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:37:34 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A08DBA;
        Sun, 29 Oct 2023 11:37:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0E5CA3200926;
        Sun, 29 Oct 2023 14:37:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 29 Oct 2023 14:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698604647; x=1698691047; bh=g+C4anPIqrq6/eg620vtM+R75wvlyb5iHu6
        nAfe1o+0=; b=TL2AUyoRk3GGGIdODDHwnW5feSjKYugvEZmitWHFH0QiZAmvyOx
        6oMwTma8snXx9blQtNRzaZ7GxzRCyr9NZEB9NDhxp4Kb4S08iUV1hKFfcvh86xgV
        iV1WCOFek8MRZVavOemgi8yAhcMJQ5gM49c/wOnBXCZvf+V1K3MMAFLextBwsTzb
        bj36c/0AT3flbfaqtmhhbCjcKG2W7uWDINwmGwXO1cx1Hjl+rPWsqxfGY8mErMxu
        0lDlm3EDEz+KAeOhgF5uDAi+dvRpAjSkjkfp+1pZo1B47aU23XVG/Yay+WWua0T/
        OcS22Kx6HV8vvjU9MZxYsmf7zfboWqIpqNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698604647; x=1698691047; bh=g+C4anPIqrq6/eg620vtM+R75wvlyb5iHu6
        nAfe1o+0=; b=Kk/ld9HHMSnYytItJfmWFYIUTboLDA5D/mupL99RBMkhLQO2Yph
        TaQCf8bs7nN+hke1J7mZ8MxRmCYdzHJNUd/TYIyk2cOZ4DeKwBZVktaNmXwJSgaL
        k5kNFPMYV4M5cEoT9CDqq03+7LXCuFKYXGCsefM6pBf9CkBeZgaF6+nIEBKd2x1J
        p0HfRBmn4SN0Iq2BCdYIe9IWE/eZ2PbxfgeVO1kjBDl1Jd4VJb19EjbePXcwhj5f
        /9ajsJo8OIADzM9LnxUOA7O+EyuWUlWU3qthIdAkfqPfk1pCHqq8V+h8iAkjTvFw
        cZkkBR6jcGMelW5LavSSOLE4t8kdBI60GXQ==
X-ME-Sender: <xms:ZqY-ZTt6Y0Qgib5w5UQJ6KQCVgDMb6OcuQJTQRh4Q9ofPyz7g_N56w>
    <xme:ZqY-ZUcphp6kG1MSZp3dhp6-Hr252Q3MAci9FXWdH_N1F8eLATBk-Oad9QB0nZPBV
    7AawWsfz7EGYmzZKQ>
X-ME-Received: <xmr:ZqY-ZWy1CZ9nQBT3V6ACftl7CgSoPEKJ47JYkEH83iPWQ8iwYEQor5M4USMtZ253n13qKNhP0-ae-osQjM1Wg_5MRHu6DvvT5VCOeqcmGvyMnNPi_ouVWj7-LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfhffvvehfufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefhhfeggeduheeihedtkedutdegleduudelhfekheekvdetudev
    ieejudfhveejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ZqY-ZSOzlJzTSm2hv6dyWoq41JQY5nro6ApbStqiqfYjYrBdhvmXAQ>
    <xmx:ZqY-ZT98yf6awAfBJ8tzN6xK_ia5iuvoNppViOBkjtQlOeZ22yXEkw>
    <xmx:ZqY-ZSUdZS4F1n0E4-RlQ29vwM-fUmCwdllXo_Zgkj71KbjtopiJ5Q>
    <xmx:Z6Y-ZekqQpvr7MHWEMkg5lmz9MBv-sPrNk-hNBGfpovwT8OEQUVvXg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 14:37:26 -0400 (EDT)
Message-ID: <f5468eac-96ec-e8c9-bcc1-9ec219bf3352@sholland.org>
Date:   Sun, 29 Oct 2023 13:37:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
From:   Samuel Holland <samuel@sholland.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20221231235541.13568-1-samuel@sholland.org>
 <20221231235541.13568-3-samuel@sholland.org>
 <20230316133422.GM9667@google.com>
 <a1adbe50-3400-fd10-1856-8c1d0ed82276@sholland.org>
Subject: Re: [RESEND PATCH v7 2/5] leds: sun50i-a100: New driver for the A100
 LED controller
In-Reply-To: <a1adbe50-3400-fd10-1856-8c1d0ed82276@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 10/17/23 19:38, Samuel Holland wrote:
> On 3/16/23 08:34, Lee Jones wrote:
>> On Sat, 31 Dec 2022, Samuel Holland wrote:
>>> +	for_each_available_child_of_node(np, child) {
>>> +		struct sun50i_a100_ledc_led *led;
>>> +		struct led_classdev *cdev;
>>> +		u32 addr, color;
>>> +
>>> +		ret = of_property_read_u32(child, "reg", &addr);
>>> +		if (ret || addr >= count) {
>>> +			dev_err(dev, "LED 'reg' values must be from 0 to %d\n",
>>
>> Doesn't sounds like an address.
> 
> The one-wire protocol involves the first LED responding to the first 24
> bits of the transfer, then forwarding the rest to the next LED. The
> address is the ordinal position in the chain. So I don't think there is
> any reason to have gaps in the addresses--the LEDs would still have to
> physically be there, but you would not be able to control them. That
> said, the driver doesn't need to enforce this, so I can remove the check.

There's actually a reason for the driver enforcing that LED addresses
are contiguous. Removing this check decouples the largest address from
the number of LED class devices. Unfortunately, there's a register field
(LEDC_RESET_TIMING_CTRL_REG_LED_NUM) that must be set to the largest
address for transfers to work correctly.

This means the driver would need to iterate through the child nodes in
two passes inside the probe function: first to find the largest reg
value, and second to actually register the LED class devices.

Since I don't think having gaps in the addresses is a realistic use
case, I'd like to keep this restriction for now (with a comment). We
could always pay the complexity cost later if someone really does want
to relax this check.

Regards,
Samuel

