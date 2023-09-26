Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54317AED8E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjIZNBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjIZNBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:01:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FAA120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:01:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso7439056b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695733287; x=1696338087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fsWwDoEOK4hAw1RCGaHeyr9yqhL0IEyrUhbGj+7/iI8=;
        b=R9W/DyarHLeAiNjEkufYus151q2KFsgQmCdfy+I880Y0xgRGB3fsEu5ecaZAtIABAv
         IUn4qyZqIFKgu6QvGBk1ihMrY+ycaFdD0x9XBvpNMxkxVszh1Icw55SOQ4GI+oPT1/fi
         33fvlTJ/MoECSpLZjGpDoGNLfm50PocQkgXYosQOqrIelJgpAvYNAjigntu3Oxs4h08J
         EEBLgtRglP+VVTTMGJhFsC+hKuHaBEkShr2f4tqYN2BkhKfTBqIF4VBNuINWZFwpwDix
         XCZbGMsOoA0m4ersvN+OaruRLV1BKQ3dxZIu/nEY01YCQcJy+w7CO9CX+X3Q+zmJLrNt
         sV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695733287; x=1696338087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsWwDoEOK4hAw1RCGaHeyr9yqhL0IEyrUhbGj+7/iI8=;
        b=MmL9N5wo6PhyMIPgk/mv64g5fqabEDMxdTQfn3d+uS3AqWzZjrYsUtOPTRJDmSrxn6
         z4PC3hMZuGnqbgtI6JnSlRIM05BwftXifHbIcjf/O8DrfHN12eONnIlrQoBkKF75vQt9
         wBq523YF0e1MW8JaqoyJlyuUbCRgZBViJThwOvPD/Rhh3z7xHJm4FtLwcXJI+x+TFruz
         DNnV63L/Klny0NuMpvyV+j65Ue43gIuC3THdSDQ7xIlRZqJ56VbV8qqAWV633q6GTQyV
         zv6zQlC0hNB/xdDYoz3+0x0Ft6fyMfZ7ueKBX3ndv2RANCM2Ie3sgnOehDlFvGI9QKjE
         tBKQ==
X-Gm-Message-State: AOJu0Yy1aHtfviKEuyrVtNDOiQvK05T5uWicWqM2QMdZglgD1cbmucH4
        MVGiCgsA1/E4HAoiZy2TQKQ=
X-Google-Smtp-Source: AGHT+IFpAKKyu0e5+QquYPdBacUCd2WglwVBN4louTG5oQHFc8+OqA9ejkNsqnf1tEHH0SvfP3nRDA==
X-Received: by 2002:a05:6a20:9756:b0:154:d3ac:2050 with SMTP id hs22-20020a056a20975600b00154d3ac2050mr9527275pzc.33.1695733287195;
        Tue, 26 Sep 2023 06:01:27 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7900d000000b006877a2e6285sm9855981pfo.128.2023.09.26.06.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 06:01:26 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E8EFE8206CE1; Tue, 26 Sep 2023 20:01:22 +0700 (WIB)
Date:   Tue, 26 Sep 2023 20:01:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Sid Boyce <sboyce@blueyonder.co.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ALSA <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: Ryzen 9 7950x sound module does not not build
Message-ID: <ZRLWIkyngsasQbQ7@debian.me>
References: <213f93b5-bffe-479f-a111-f8a7e44cd293@blueyonder.co.uk>
 <61821f15-78e2-4594-8f39-545ecaa97000@infradead.org>
 <5903832d-7d27-4847-b161-48b9f7e92ee6@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FrAjWSJL6KxdySBL"
Content-Disposition: inline
In-Reply-To: <5903832d-7d27-4847-b161-48b9f7e92ee6@blueyonder.co.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FrAjWSJL6KxdySBL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[also Cc'ing alsa ML and related maintainers]

On Tue, Sep 26, 2023 at 01:23:13PM +0100, Sid Boyce wrote:
> I've since rebooted and did a modprobe. No idea why it isn't automatically
> loaded.
>=20
> #modinfo snd-rpl-pci-acp6x
> filename: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/usr/lib/modules/6.6.0-rc3-=
vanilla/kernel/sound/soc/amd/rpl/snd-rpl-pci-acp6x.ko.gz
> license: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPL v2
> description: =C2=A0=C2=A0=C2=A0AMD ACP RPL PCI driver
> srcversion: =C2=A0=C2=A0=C2=A0=C2=A00F909BC61165681426ECEEB
> alias: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci:v0000102=
2d000015E2sv*sd*bc04sc80i00*
> depends:
> retpoline: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Y
> intree: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Y
> name: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0snd_rpl=
_pci_acp6x
> vermagic: =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A06.6.0-rc3-vanilla SMP preem=
pt mod_unload modversions
>=20
> # modprobe snd-rpl-pci-acp6x
>=20
> #lsmod|grep snd
> snd_rpl_pci_acp6x =C2=A0=C2=A0=C2=A0=C2=A0=C2=A016384 =C2=A00
> snd_seq_dummy =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A012288=
 =C2=A00
> snd_hrtimer =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A012288 =C2=A01
> snd_seq =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0131072 =C2=A07 snd_seq_dummy
> snd_hda_codec_realtek =C2=A0=C2=A0192512 =C2=A01
> snd_hda_codec_hdmi =C2=A0=C2=A0=C2=A0=C2=A094208 =C2=A01
> snd_hda_codec_generic =C2=A0=C2=A0110592 =C2=A01 snd_hda_codec_realtek
> snd_hda_intel =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A065536=
 =C2=A02
> snd_usb_audio =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0458752 =C2=
=A02
> snd_intel_dspcfg =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A040960 =C2=A01 snd_hd=
a_intel
> snd_intel_sdw_acpi =C2=A0=C2=A0=C2=A0=C2=A016384 =C2=A01 snd_intel_dspcfg
> snd_hda_codec =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0233472 =C2=
=A04
> snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec_real=
tek
>=20
> snd_usbmidi_lib =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A049152 =C2=A01 s=
nd_usb_audio
> snd_hda_core =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0147456=
 =C2=A05 snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_cod=
ec,snd_hda_codec_realtek
>=20
> snd_ump =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A036864 =C2=A01 snd_usb_audio
> snd_rawmidi =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A057344 =C2=A02 snd_usbmidi_lib,snd_ump
> snd_seq_device =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A016384 =C2=
=A03 snd_seq,snd_ump,snd_rawmidi
> mc =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A094208 =C2=A01 snd_usb_au=
dio
> snd_hwdep =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A020480 =C2=A02 snd_usb_audio,snd_hda_codec
> snd_pcm =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0225280 =C2=A06
> snd_hda_codec_hdmi,snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_hda_core
> snd_timer =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A053248 =C2=A03 snd_seq,snd_hrtimer,snd_pcm
> ledtrig_audio =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A012288=
 =C2=A02 snd_hda_codec_generic,asus_wmi
> snd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0163840 =C2=A023 snd_hda_codec_generi=
c,snd_seq,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_usb=
_audio,snd_usbmidi_lib,snd_hda_codec,snd_hda_codec_realtek,snd_timer,snd_um=
p,snd_pcm,snd_rawmidi
>=20
> soundcore =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A016384 =C2=A01 snd
> usbcore =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0446464 =C2=A06
> xhci_hcd,snd_usb_audio,usbhid,snd_usbmidi_lib,btusb,xhci_pci
>=20

Any errors on dmesg when loading snd-rpl-pci-acp6x module?

--=20
An old man doll... just what I always wanted! - Clara

--FrAjWSJL6KxdySBL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRLWHQAKCRD2uYlJVVFO
o+KxAP9FbaZ3F2Bulu1dy6/JGeNXATu+DFHlrFdov0TfHgMdxAEArv3dpUxz26KP
MJ/Z3kC+XMbYJAmkuv7jPFgaOxPOyAE=
=jqov
-----END PGP SIGNATURE-----

--FrAjWSJL6KxdySBL--
