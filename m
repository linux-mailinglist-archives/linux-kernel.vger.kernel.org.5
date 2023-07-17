Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A07756DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGQT5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGQT4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:56:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202211988;
        Mon, 17 Jul 2023 12:56:34 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b8392076c9so59257711fa.1;
        Mon, 17 Jul 2023 12:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689623790; x=1692215790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rszA/sUQP4638eSLYjafY6lZFlI8AksGb/kh6alFFEA=;
        b=aeTY9kvK+dYQYxXtsdHaO8b+QJ4j80pzphbMsecW7Tiz57oAypIW1g0cn/MYZaNhc/
         6pOxM+uQ3GyHxugdGUgVMZo8LKxz1LHtRLoEKFpE+lXfrrIdr6OY78r4npXJ5nKgn5aS
         RuFMSekA155UqlThXveJO4vE3AN5HALGvKfd/ErZSQkH1SIcuQyCXpiktEg0hkvttBZd
         z6KeMZvZJVAf8wgq/Mjj1tQ1KNhvDN+f/tWydNt3msgU4fF/RLmnWn4wx2TkqRUgG5qd
         At/HdEyh8eGV1AoGhm5YQpZGjpDba/3xv+C9koKheJ7J+7oCtvy8RRxCl5/HfNhbhb3J
         VmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689623790; x=1692215790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rszA/sUQP4638eSLYjafY6lZFlI8AksGb/kh6alFFEA=;
        b=VRvlSeSItXIQkveGgyNCpD0NHP36EKeLGlpsg9xeHdp5WBBzVGxxmPx8LKXbZkxj78
         FY4tpS/OeA/V5vdwDITBz/oDaUl5Cz6ncFTB08pjyy3BDx2ZXRMj9wCdLde5hGID8oyD
         yDhrKmdFKGKObnm3N7/kNl/kHJVroM5C3EBDKKjMoz9+kGAKTWYKvRnRrJ+f5HSRaRa5
         hoMPjdtppQXga/yDIA3MznM7jWF/UE+OIUxsDUDUR719yQAsewl6IfHf5yQ/nKpgCyas
         chulR8wMLbl1c7hn4dKHRweXO50y+UDqbydL6SzcR3iJjs5MjOA7p9r4XBNuuft2BMwy
         tlhg==
X-Gm-Message-State: ABy/qLbPnTCO9AVJCE83mrfWOf3be+U4rVMBxdnuINBK/bDqYjX4yYh8
        eeq6DNIGJQu2HeZmD7wsGvFsJ/GYN0neqsT8XgI=
X-Google-Smtp-Source: APBJJlGzVztlKsF5BOtsKT2Uy4ah+nrOJEhBigkGA3OqTOPCYzou0U07BvCdy+sdP6K5E5Nxea0glBZlUfvMNDnlRJw=
X-Received: by 2002:a2e:8356:0:b0:2b6:d084:e589 with SMTP id
 l22-20020a2e8356000000b002b6d084e589mr8329844ljh.47.1689623789694; Mon, 17
 Jul 2023 12:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <ZLSwfv2pQ5uH6bja@bud-laptop>
In-Reply-To: <ZLSwfv2pQ5uH6bja@bud-laptop>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Jul 2023 12:56:17 -0700
Message-ID: <CABBYNZLvqcO9Bnbr-mFa23yPvKbePSeRk7s9xr5Vfred9hhUTw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add VID/PID 0489/e102 for MediaTek MT7922
To:     Wes Miser <buddwm@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wes,

On Sun, Jul 16, 2023 at 8:07=E2=80=AFPM Wes Miser <buddwm@gmail.com> wrote:
>
> Tested on Acer Swift Edge 16 Notebook
>
> Signed-off-by: Wes Miser <buddwm@gmail.com>
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5ec4ad0a5c86..95f43d48f383 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -628,6 +628,9 @@ static const struct usb_device_id blacklist_table[] =
=3D {
>         { USB_DEVICE(0x0489, 0xe0f2), .driver_info =3D BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H |
>                                                      BTUSB_VALID_LE_STATE=
S },
> +       { USB_DEVICE(0x0489, 0xe102), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H |
> +                                                    BTUSB_VALID_LE_STATE=
S },
>
>         /* Additional Realtek 8723AE Bluetooth devices */
>         { USB_DEVICE(0x0930, 0x021d), .driver_info =3D BTUSB_REALTEK },
> --
> 2.41.0

Please include the information from /sys/kernel/debug/usb/devices

--=20
Luiz Augusto von Dentz
