Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B6B763AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjGZPQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjGZPQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:16:25 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E083C2F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:16:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BDCA85C00C5;
        Wed, 26 Jul 2023 11:15:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 26 Jul 2023 11:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1690384553; x=
        1690470953; bh=m8+X5rABFhzKDpm1BfhOQA/g8LVHcIMKbshsuIWm/to=; b=U
        YAVWoQ+gvaANdY6SRLHF2a4jmn1BKR2Xdw01sciV3XoYcTAvpZtU3F7vIl4Att94
        LMuVkL5/Kbey+i09zio/NrMZK5IOPZ7Gl0JEVFJJ/dFveIitUNWS8QVmItaJWSs1
        wq+l0ZcvUBJLIMwAdShXjiFjEAooTziIiHry9GGGwjUY9xzbOBESvM7Wkz4YRjP8
        s8OagDlEmubgoXH0yKU66A6F2i+8uZCP3VCbOyvhdVCxb9Rq4FZXm53S3xtbO6C/
        y1MpsTkXbLTpF8Js3FHvyc3NJJBDCnft4Gztg/zE7MBuZ8ANX+vz7IcJ/bH9KGdu
        eQUGzOLzTJfNPPEtWlgvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690384553; x=1690470953; bh=m8+X5rABFhzKD
        pm1BfhOQA/g8LVHcIMKbshsuIWm/to=; b=IC0cxEhdQ2/ClQQ6XHBZFX6lrTJxR
        oVr1uptOhykyajNmFCwMi9YBAtpIy/5xuxrwVGJKB9NMrqBDaNO/ddAU+juSOn+b
        7hxIfMkR+2bHPUVGFiEZlCXpWk5teQtJWzHoKzhEobl6H+utyOAjbT7LoFuoWdHP
        4SMVQOX0uhv1Lgx81iLIoaPOQjtq4gnSkFA8U0hmNGkGyFSd9KB+2I5OWK6gme99
        ew6Aly3abPp3YfXfSlOkWqek1Qcc5SzfsEcekEYR72+zCXXf9Io697Ni+CG/QBNM
        uaXUHGMYWqTyLgBFsSrbnI0tLffLVxGwnGa4tO8tNeyWsh2igkxeZk9bg==
X-ME-Sender: <xms:qDjBZEwCjMgYyHySe1YisVf0j7C4Px-qLFzLS__3tzMoo4Oz6uGKuw>
    <xme:qDjBZIRes3t4QzFthbE2wuPMVLKBKmqP-XycClvO2oVw5jMbk0BOKY7XHfw0oP30L
    RGh3dYDwYHLcCYzF54>
X-ME-Received: <xmr:qDjBZGUuWmNDiCP6udvl8dExIwFKBJ_3ePLDdXdetrLW_Nn2rRa9BQkCMbpHlIDxHj2tCoJVEurcOUf54XZUAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpeffrghvihgu
    ucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrhdrtghomheqnecuggftrfgrth
    htvghrnhepffeivddtkeegveehhfduiedtuedvtdfgffettdeuleffffektefgtdejveeu
    vdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    gvsegurghvihgurhgvrghvvghrrdgtohhm
X-ME-Proxy: <xmx:qDjBZCjrE_M_AWHHGTluarG9qGTpIm042kodiHiZ-VqFYsFkevIwJQ>
    <xmx:qDjBZGDU5Bk2aRrOp3lj0jfeAjjnhD_I0TfHu6c2XK_bd6t8IzXF2Q>
    <xmx:qDjBZDJJoyYOidTtUrq5-R6l4kqiW4phQ-x5xKN1Bi-KQJpSC5Mfuw>
    <xmx:qTjBZJ9gD2BzEltrD-aIplRZF4Tgt1CoczITJLqEgJNAdutHUL5pUA>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 11:15:51 -0400 (EDT)
References: <20230722180925.1408885-1-hugo@hugovil.com>
User-agent: mu4e 1.10.4; emacs 28.2
From:   David Reaver <me@davidreaver.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] auxdisplay: hd44780: move cursor home after clear
 display command
Date:   Wed, 26 Jul 2023 08:12:41 -0700
In-reply-to: <20230722180925.1408885-1-hugo@hugovil.com>
Message-ID: <867cqm900q.fsf@davidreaver.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hugo Villeneuve <hugo@hugovil.com> writes:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> The DISPLAY_CLEAR command on the NewHaven NHD-0220DZW-AG5 display
> does NOT change the DDRAM address to 00h (home position) like the
> standard Hitachi HD44780 controller. As a consequence, the starting
> position of the initial string LCD_INIT_TEXT is not guaranteed to be
> at 0,0 depending on where the cursor was before the DISPLAY_CLEAR
> command.
>
> Extract of DISPLAY_CLEAR command from datasheets of:
>
>     Hitachi HD44780:
>         ... It then sets DDRAM address 0 into the address counter...
>
>     NewHaven NHD-0220DZW-AG5 datasheet:
> 	... This instruction does not change the DDRAM Address
>
> Move the cursor home after sending DISPLAY_CLEAR command to support
> non-standard LCDs.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/auxdisplay/hd44780_common.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
> index 3934c2eebf33..7cbf375b0fa5 100644
> --- a/drivers/auxdisplay/hd44780_common.c
> +++ b/drivers/auxdisplay/hd44780_common.c
> @@ -82,7 +82,15 @@ int hd44780_common_clear_display(struct charlcd *lcd)
>  	hdc->write_cmd(hdc, LCD_CMD_DISPLAY_CLEAR);
>  	/* datasheet says to wait 1,64 milliseconds */
>  	long_sleep(2);
> -	return 0;
> +
> +	/*
> +	 * The Hitachi HD44780 controller (and compatible ones) reset the DDRAM
> +	 * address when executing the DISPLAY_CLEAR command, thus the
> +	 * following call is not required. However, other controllers do not
> +	 * (e.g. NewHaven NHD-0220DZW-AG5), thus move the cursor to home
> +	 * unconditionally to support both.
> +	 */
> +	return hd44780_common_home(lcd);
>  }
>  EXPORT_SYMBOL_GPL(hd44780_common_clear_display);
>
>
> base-commit: d192f5382581d972c4ae1b4d72e0b59b34cadeb9

I tested this on a 16x2 HD44780 on my BeagleBone Black with:

    $ printf '\f' > /dev/lcd
    $ printf 'Hello\nWorld!\n' > /dev/lcd
    $ printf '\x1b[LR' > /dev/lcd
    $ printf '\x1b[LR' > /dev/lcd
    $ printf '\x1b[LR' > /dev/lcd
    $ printf '\f' > /dev/lcd
    $ printf 'Goodbye\nWorld!\n' > /dev/lcd

As expected, "Goodbye World!" was correctly placed left-aligned on the
display, split over both lines.

Tested-by: David Reaver <me@davidreaver.com>
