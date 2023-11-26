Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560337F9650
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjKZXKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZXKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:10:35 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C00DFB;
        Sun, 26 Nov 2023 15:10:41 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9361E3200A5C;
        Sun, 26 Nov 2023 18:10:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 26 Nov 2023 18:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1701040240; x=1701126640; bh=cP
        /OkNDOpdHrLMx5wzD4ZGMR+6u2K3gz78/e5rWmNaM=; b=DqF2C3oOHIbZc+n3LK
        P/88Dt/JLZKZft++G+FJH7mAXHF0q62kLhnO3xkrJIclgI7R0E3G4EeKUCTz8ugQ
        gdcLl+UciBWd02VuK+ckxPJeNEAWGg7LzkHjxfbNzln03IZvdieZyY4tttolz9rY
        9qT2YiTjh8I9p7wfocRzB7pZ0e/sDsfqPOoi1AfBOINAteERtvemdwsAQ94+ZTgz
        8eMpnQm5EUQ8+XCzeaLFTO7MjGKi0c7+L+2zZBZ7s+sVKvJMs5QhbDRkOZSg/Lso
        UKLFZ01MYLbvTuuZzdkzTtoPdj4y/9NZ9I4ffyXsC98uSuT4U7WCSpYm2ry+ES5E
        1vIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701040240; x=1701126640; bh=cP/OkNDOpdHrL
        Mx5wzD4ZGMR+6u2K3gz78/e5rWmNaM=; b=eFv0i+/ukXKX+3ARZAE5kfBv3YoYP
        VAMOKQbAXcQq2lK9Ulvjsrtxo8VlMRVXb0C/UKqP+7xnG7L+dxkj+lU18F8BWuzz
        IT4Gn85io2EEUQHGbyZxkxyGe2ZSO87E1UarS7QmFwy4QXbDW4787tT6ps4a2jml
        QpCAycxLYqfljsn1MLs5kqs/4uDx3XPGlZ3rpxlBT74qAQpmDbTX9Chjbp+gJPdJ
        pIDGa9mZ79QOpnpvL7DRC0gbFZqHvd6qVDm/+E+yC2KL4B0387hdAui9Ma+tcHRg
        mqcPrT0OvsgJU/aA1kfFP3o+94K0GVg23XA4drW8fRXhSh05KXQ8eaUYg==
X-ME-Sender: <xms:b9BjZfW5OzAT6I3uorNyt9kqz7bzxY7vQ4rRjJ0rcbuNcDE7vgZvpQ>
    <xme:b9BjZXlnUl5ECz9X1PveLxLlJsCzBKSu2-9gnXM55BQZDW3o4ofU8K-MulCwGDyk-
    L4YvbE9XKtqTs-gYxE>
X-ME-Received: <xmr:b9BjZbYc-XogpqWMzBwWOuk_fsTuJ6dgJ0Ms4Qjj1fOwxZrcTaHqeh1SGK6YyzNbRA8IAtoc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeitddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvfevkfgjfhfogggtsehttd
    ertdertddvnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghs
    rdguvghvqeenucggtffrrghtthgvrhhnpedvueejgefgteeuueeigefggfdvjeeiueejue
    euudevleejhfeiudfhjeevleeikeenucffohhmrghinhepfhhrvggvuggvshhkthhophdr
    ohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:b9BjZaUpiLz4giqoksTFVaCERqNjBrc6_vwYwfXevAu2FPi-FMtspQ>
    <xmx:b9BjZZm9w1GpySUTjYDaECmM17EV1iDBxDLf8AB_j291u3rLHXmzDw>
    <xmx:b9BjZXfMoaQcMZznBDccScCVXzCjIaeE6LyibNiNqtLcWqp7srXGrQ>
    <xmx:cNBjZeyE5Ufm0YhmVKe67Tn--2FR8lzNhAOFc9nvZWSKgZf24-eiAg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Nov 2023 18:10:35 -0500 (EST)
Date:   Mon, 27 Nov 2023 12:10:21 +1300
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 0/1] platform/x86: asus-wmi: disable USB0 hub on ROG
 Ally before suspend
To:     hdegoede@redhat.com
Cc:     ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <917R4S.AJGL9DYX1IZ@ljones.dev>
In-Reply-To: <20231126230521.125708-1-luke@ljones.dev>
References: <20231126230521.125708-1-luke@ljones.dev>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Nov 27 2023 at 12:05:20 PM +13:00:00, Luke D. Jones 
<luke@ljones.dev> wrote:
> This is a fix for the ROG Ally not being able to use the N-Key device 
> after a suspend/resume cycle.
> 
> The root of the issue is that ASUS changed the MCU firmware to 
> dfisconnect the USB0 hub when the
> screen is switched off during the s2idle suspend path. I tried many 
> many different tactics to try
> and get this s2idle part to work but it seems there are races between 
> this and other subsystems.
> 
> What has so far been reliable and consistent is a manual call to the 
> CSEE method that is called in
> ACPI by the Microsoft DSM screen off path followed by a short sleep 
> in asus-wmi. The PM prepare
> hook looks to be the earliest possible place. A sleep that is too 
> long ends up with USB subsystem
> registering a disconnect, and thus on resume the device paths change. 
> Too short and it is unreliable.
> 
> Some discussion regarding this mess is at 
> https://gitlab.freedesktop.org/drm/amd/-/issues/2719#note_2181402
> 
> Changelog:
> - v2:
>   - Emit dev_err(), but don't return error codes
>   - Add check for MCU power save mode being enabled and disable if 
> active
>   - General cleanup and rename some vars/funcs
> - v1: 
> https://lore.kernel.org/all/20231124082749.23353-1-luke@ljones.dev/
> 
> Luke D. Jones (1):
>   platform/x86: asus-wmi: disable USB0 hub on ROG Ally before suspend
> 
>  drivers/platform/x86/asus-wmi.c            | 50 
> ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  3 ++
>  2 files changed, 53 insertions(+)
> 
> --
> 2.43.0
> 

Hans I omitted your review tag as I made more changes than requested.


