Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E647A2FE9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbjIPMPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIPMPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:15:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74948CEB;
        Sat, 16 Sep 2023 05:15:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-69042d398b1so1633113b3a.0;
        Sat, 16 Sep 2023 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694866502; x=1695471302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1t3Hu2NlVXsk58k7VRC9awkwVf6POWMPotKsVrYh9ZA=;
        b=DS3oDiRGcreDbHLA0nFwxlYW0uzQZi50/kej9gzOXqFVKPKknCliObztcQJ9h6y6BZ
         Z0PGbvBF8BuS3JcrRPThibBTEbCi7yCXStIg5uBYwd7xzprHBZZJPr8rFuKgwmGtCK2T
         jfLzFR3uRAWFrY95nKJIeAiZTOW/TF6SiKppQ5iN1hsUvY+bjrdA15kSvM812VO9Hdm9
         ZwGvkRsuHMy8c6id2Q/4j92vfQq3IjGl1j4aWaXFAISePToSiGTwl5/4pTZSkooLbwBa
         5JAVV5ghr2Bcyuc1Gt6WsRvhxEAoJDFRSgYhXa8WRN+y8D1Fv+z+H4BLGRBggV/Alzuf
         1d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694866502; x=1695471302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t3Hu2NlVXsk58k7VRC9awkwVf6POWMPotKsVrYh9ZA=;
        b=A1/L/KkHD3wmGyCzPBC5R5dbuq824jmpwMslCBaMUV3/To01IixCPY2Rv40YuBvCsS
         bEnm8ur5BDGTztnuIAHzNapXMKv5uqDXsgNyJDxXIw2qrX8jAg5U84ZJfcqdc3LMBaP/
         VMFvyM6hKvYolYuizDKqA67NRDLH2xB5c4s3P7PrJVwpO4TeE2dC5uesFr5FjzTVTaMh
         QKs+8AG1I4G89VOCCtOVH/2I3lDXua8fb2VXsdl+wu5C4sBCOet43lwtDUTzsDLGxNNw
         TAI8bZHX6KWmuGYjjhqdo6wPAVxxwzgSBa27NiK5dqzYaRqCXnE1VfoXaCt+EScau4a9
         8d7w==
X-Gm-Message-State: AOJu0Yx0085i+Nigilzaqp0J9HZi8pk2HOdfK/EEqJVRO+oLxHMs3peH
        LKHPy2bq+6THjFfcIlmF+Jo=
X-Google-Smtp-Source: AGHT+IHWpEKQuMsgpmDDzc8xAXIBaf029YhKC4CG4uKR2rPwxHN9LtWMcJE+cTTWpqHWeh+tR3KQFA==
X-Received: by 2002:a05:6a00:15c5:b0:68c:49e4:bd71 with SMTP id o5-20020a056a0015c500b0068c49e4bd71mr5571390pfu.34.1694866502230;
        Sat, 16 Sep 2023 05:15:02 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id j20-20020a62b614000000b0068bc6a75848sm4406720pff.156.2023.09.16.05.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 05:15:01 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 45A4481C8E58; Sat, 16 Sep 2023 19:14:58 +0700 (WIB)
Date:   Sat, 16 Sep 2023 19:14:57 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Louis-Marie <rauline.lm@protonmail.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        Antonio Napolitano <anton@polit.no>,
        Douglas Anderson <dianders@chromium.org>,
        Andrew Gaul <gaul@gaul.org>,
        =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
        Jean-Francois Le Fillatre <jflf_kernel@gmx.com>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        Nicolas Dumazet <ndumazet@google.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Hannu Hartikainen <hannu@hrtk.in>,
        =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>
Subject: Re: Lenovo Hybrid Dock MAC passtrough patch
Message-ID: <ZQWcQTQahx-QEGDl@debian.me>
References: <guK8MKcjWbPsZ1LuRVYxFf7WfsWa025shmVj7iq289LHf59N6i6OlkD0N9KhICJzbMfFW2aXYbguZ1NtZNn6PlA_-JvF3k7uJtG89THdZ6w=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OfTnmoJtB1ynC3bV"
Content-Disposition: inline
In-Reply-To: <guK8MKcjWbPsZ1LuRVYxFf7WfsWa025shmVj7iq289LHf59N6i6OlkD0N9KhICJzbMfFW2aXYbguZ1NtZNn6PlA_-JvF3k7uJtG89THdZ6w=@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OfTnmoJtB1ynC3bV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2023 at 11:41:49AM +0000, Louis-Marie wrote:
> Hi,
> I would like to submit a patch for enabling mac passtrough for the Lenovo=
 Hybrid Dock.
> Tested with Fedora 6.4.12.
>=20
>=20
>=20
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.cindex 0c13d=
9950cd8..02e6404bf6ea 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -781,6 +781,7 @@ enum rtl8152_flags {
> =C2=A0#define DEVICE_ID_THINKPAD_USB_C_DONGLE =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00x720c
> =C2=A0#define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2 =C2=A0 =C2=A0 0xa387
> =C2=A0#define DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3 =C2=A0 =C2=A0 0x3062
> +#define DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK =C2=A0 =C2=A0 =C2=A0 0xa359
>=20
> =C2=A0struct tally_counter {
> =C2=A0 =C2=A0 __le64 =C2=A0tx_packets;
> @@ -9583,6 +9584,7 @@ static bool rtl8152_supports_lenovo_macpassthru(str=
uct usb_device *udev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 case DEVICE_ID_THINKPAD_THUNDERBOLT3_DOCK_GEN=
2:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN2:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 case DEVICE_ID_THINKPAD_USB_C_DOCK_GEN3:
> + =C2=A0 =C2=A0 =C2=A0 case DEVICE_ID_THINKPAD_HYBRID_USB_C_DOCK:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 case DEVICE_ID_THINKPAD_USB_C_DONGLE:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> @@ -9832,6 +9834,7 @@ static const struct usb_device_id rtl8152_table[] =
=3D {
> =C2=A0 =C2=A0 { USB_DEVICE(VENDOR_ID_LENOVO, =C2=A00x7214) },
> =C2=A0 =C2=A0 { USB_DEVICE(VENDOR_ID_LENOVO, =C2=A00x721e) },
> =C2=A0 =C2=A0 { USB_DEVICE(VENDOR_ID_LENOVO, =C2=A00xa387) },
> + =C2=A0 { USB_DEVICE(VENDOR_ID_LENOVO, =C2=A00xa359) },
> =C2=A0 =C2=A0 { USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041) },
> =C2=A0 =C2=A0 { USB_DEVICE(VENDOR_ID_NVIDIA, =C2=A00x09ff) },
> =C2=A0 =C2=A0 { USB_DEVICE(VENDOR_ID_TPLINK, =C2=A00x0601) },
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 15e9bd180a1d..ad98c8ffbc69 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -470,6 +470,9 @@ static const struct usb_device_id usb_quirk_list[] =
=3D {
> =C2=A0 =C2=A0 /* Lenovo ThinkPad USB-C Dock Gen2 Ethernet (RTL8153 GigE) =
*/
> =C2=A0 =C2=A0 { USB_DEVICE(0x17ef, 0xa387), .driver_info =3D USB_QUIRK_NO=
_LPM },
>=20
> + =C2=A0 /* Lenovo ThinkPad Hydrid USB-C Dock */
> + =C2=A0 { USB_DEVICE(0x17ef, 0xa359), .driver_info =3D USB_QUIRK_NO_LPM =
},
> +
> =C2=A0 =C2=A0 /* BUILDWIN Photo Frame */
> =C2=A0 =C2=A0 { USB_DEVICE(0x1908, 0x1315), .driver_info =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 USB_QUIRK_HONOR_BNUMINTERFACES =
},
>=20
> Signed-off-by: Louis-Marie Rauline <rauline.lm@protonmail.com>
>=20

Can you send above suggestion as formal patch instead? See
Documentation/process/submitting-patches.rst for how to properly submit
patches. And also, use git-send-email(1) when sending them so that patch
corruption (like tabs converting to spaces and line wrapping as in above
diff) doesn't occur.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--OfTnmoJtB1ynC3bV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQWcPQAKCRD2uYlJVVFO
o/u6AP9cLVGluMyFIUFqW+ia7vUD0EjgYMoxOm7zjRV1fgMrGgEAmmMhnk3BbOTT
qXMf8rc686SvEWjuGWj1DsJAlmWAMgU=
=mQv0
-----END PGP SIGNATURE-----

--OfTnmoJtB1ynC3bV--
