Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F23751231
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjGLVIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGLVIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:08:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79601FC9;
        Wed, 12 Jul 2023 14:08:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b734aea34aso30278391fa.0;
        Wed, 12 Jul 2023 14:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689196099; x=1691788099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7VmEnG6n725fJkd0qAnlTdoqGgfdoAIZuq7+SB+8sU=;
        b=M8mol2Lv6sY5bFLvh5txpc6kzW9h5cjZMpW+zbZ0elmv9JF20O3DK4eU/Jtl9xOWmG
         /eOj9dgygrEQNPNu4WzIW1mnZbzcnGOgaoaA9cwutCCfYZxryaNC6NmeYsYaJMgmuDkz
         x5ZjkhV7CEx2c0dj7YQg6+Q/qarmV/z1Ds54NLiEro6zSX9gmHX6ayODVxmcd7MLoKD8
         7tYt7KUb2EqKpA+oliUBRdcXVk7omvMFhgmR1J1qKCiiOn5WHeDBemDieUWwl0TT3iz/
         Q4xjBX2O1JkTz7AZImSVA/6MdCKAM6VAh6qDKY5JT2s4+a101xIHXuIzWggcvyiB8bM9
         IfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689196099; x=1691788099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7VmEnG6n725fJkd0qAnlTdoqGgfdoAIZuq7+SB+8sU=;
        b=LdSvTrYFtICtB8DBeOrKlE1mOEzoms8FEl/qHt4yvr4Mu0GdfsLCNFsJv7TntDeQyo
         uz0nQEByB9yuIYG/ADmbr/MOUcmb6A4jJ4wo6QUvM0mT1o7Rt8LjfJ8y5xayR7l4RoOh
         XTu+QIJClKzJDVAFc6Vt7s6g6jLB2ELQbHwqJTyh6i67IXisCntLAFvEMyeU24KUCK9+
         UoWYxeNgihWKRXOGk5PQUv7uQfGITlnHgmEj3+XCGtuO4KUUD5wVoDmNKxguRNV99hTl
         j0keMfX8uq1yMSGJxWXCyDQjenesK9FfH1eiEc5Vr55pOpwiZ0F+hboNLCmWcMXDi3Tg
         MpPg==
X-Gm-Message-State: ABy/qLbKbY5bVJd0duk546vmIWIS8GOgJmnLeWtH6BVZ08mYhVqmXCiI
        uSl0Nl90QWwi0tjy2CT19RifG8xpWCGQrdXS2sw=
X-Google-Smtp-Source: APBJJlEeQzqJuJ8mplHj6wvyuCsNEQ/tqE3AXYexUXtC86joXcnnRt9yPLNI2rXOfRo86TQ5pk8EJIZt/q9J1Lma3Bg=
X-Received: by 2002:a05:651c:120c:b0:2b7:ada:cb25 with SMTP id
 i12-20020a05651c120c00b002b70adacb25mr15640276lja.31.1689196098832; Wed, 12
 Jul 2023 14:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230711175743.20606-1-rgammans@gammascience.co.uk>
In-Reply-To: <20230711175743.20606-1-rgammans@gammascience.co.uk>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 12 Jul 2023 14:08:06 -0700
Message-ID: <CABBYNZ+=d28pi8sqnngDGNSuPTyEF1s8XYOzWFSkpTHGQKeinA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add support for another MediaTek 7922 VID/PID
To:     Roger Gammans <rgammans@gammascience.co.uk>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On Tue, Jul 11, 2023 at 10:58=E2=80=AFAM Roger Gammans
<rgammans@gammascience.co.uk> wrote:
>
> This one is found on the Dell Inspiron 2-in-1 7435
>
> Signed-off-by: Roger Gammans <rgammans@gammascience.co.uk>
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2a8e2bb038f5..bda50d84c886 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -622,6 +622,9 @@ static const struct usb_device_id blacklist_table[] =
=3D {
>         { USB_DEVICE(0x0489, 0xe0e4), .driver_info =3D BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H |
>                                                      BTUSB_VALID_LE_STATE=
S },
> +       { USB_DEVICE(0x0489, 0xe0f1), .driver_info =3D BTUSB_MEDIATEK |
> +                                                    BTUSB_WIDEBAND_SPEEC=
H |
> +                                                    BTUSB_VALID_LE_STATE=
S },
>         { USB_DEVICE(0x0489, 0xe0f2), .driver_info =3D BTUSB_MEDIATEK |
>                                                      BTUSB_WIDEBAND_SPEEC=
H |
>                                                      BTUSB_VALID_LE_STATE=
S },
> --
> 2.39.2

Please add the information from /sys/kernel/debug/usb/devices.

--=20
Luiz Augusto von Dentz
