Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB0477780E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjHJMSG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Aug 2023 08:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjHJMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:18:03 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DE0E54;
        Thu, 10 Aug 2023 05:18:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52B9BE0007;
        Thu, 10 Aug 2023 12:17:59 +0000 (UTC)
Message-ID: <735d00afbc1a7fd2ede19cda76bcdc2bcc7d8212.camel@hadess.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for Logitech MX
 Anywhere 3 mouse
From:   Bastien Nocera <hadess@hadess.net>
To:     Maxim Mikityanskiy <maxtram95@gmail.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 10 Aug 2023 14:17:57 +0200
In-Reply-To: <20230809113832.123667-1-maxtram95@gmail.com>
References: <20230809113832.123667-1-maxtram95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-09 at 14:38 +0300, Maxim Mikityanskiy wrote:
> Add Logitech MX Anywhere 3 connected over Bluetooth to the device
> table
> to get hidpi scroll supported. USB connection over the Unifying
> receiver
> is already supported by the wildcard entry LDJ_DEVICE(HID_ANY_ID).
> 
> Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>

LGTM, thanks

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
>  drivers/hid/hid-logitech-hidpp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 129b01be488d..61d68c96581a 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4647,6 +4647,8 @@ static const struct hid_device_id
> hidpp_devices[] = {
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a) },
>         { /* MX Master 3 mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
> +       { /* MX Anywhere 3 mouse over Bluetooth */
> +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb025) },
>         { /* MX Master 3S mouse over Bluetooth */
>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
>         {}

