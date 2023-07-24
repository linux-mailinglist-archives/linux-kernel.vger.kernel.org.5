Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6476A75FCBB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjGXQ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGXQ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:56:36 -0400
Received: from h8.fbrelay.privateemail.com (h8.fbrelay.privateemail.com [162.0.218.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968D210F4;
        Mon, 24 Jul 2023 09:56:10 -0700 (PDT)
Received: from MTA-14-4.privateemail.com (unknown [198.54.122.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 8EBD4613A0;
        Mon, 24 Jul 2023 12:56:08 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
        by mta-14.privateemail.com (Postfix) with ESMTP id 66BCE1800233;
        Mon, 24 Jul 2023 12:56:06 -0400 (EDT)
Received: from [192.168.2.177] (bras-base-toroon4332w-grc-03-76-66-148-229.dsl.bell.ca [76.66.148.229])
        by mta-14.privateemail.com (Postfix) with ESMTPA id 3D21A1800542;
        Mon, 24 Jul 2023 12:56:00 -0400 (EDT)
Date:   Mon, 24 Jul 2023 12:55:53 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH] HID: logitech-hidpp: add support for the Logitech G Pro X
 mouse
To:     linux-kernel@vger.kernel.org
Cc:     Filipe =?iso-8859-1?b?TGHtbnM=?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Message-Id: <5D8BYR.57BKDP2Y14951@effective-light.com>
In-Reply-To: <20230724163032.15226-1-someguy@effective-light.com>
References: <20230724163032.15226-1-someguy@effective-light.com>
X-Mailer: geary/44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jul 24 2023 at 12:30:32 PM -04:00:00, Hamza Mahfooz 
<someguy@effective-light.com> wrote:
> The Logitech G Pro X mouse uses the HID++ protocol and supports 
> battery
> reporting. So, add it to the list of supported devices.
> 
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>

Actually on further inspection there is already a series that address
this issue (i.e.
https://lore.kernel.org/r/20230716182320.85483-1-mavchatz@protonmail.com/),
so please ignore this patch.

> ---
>  drivers/hid/hid-logitech-hidpp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c 
> b/drivers/hid/hid-logitech-hidpp.c
> index 129b01be488d..34fc4f7b254a 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4620,6 +4620,8 @@ static const struct hid_device_id 
> hidpp_devices[] = {
>  		.driver_data = HIDPP_QUIRK_CLASS_G920 | 
> HIDPP_QUIRK_FORCE_OUTPUT_REPORTS },
>  	{ /* Logitech G Pro Gaming Mouse over USB */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
> +	{ /* Logitech G Pro X Superlight Gaming Mouse over USB */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC094) },
> 
>  	{ /* G935 Gaming Headset */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0x0a87),
> --
> 2.41.0
> 


