Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B507B1A72
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjI1LSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjI1LRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:17:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117E7199A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:14:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c434c33ec0so98350555ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695899655; x=1696504455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUmedfGkG2TY7Lh9P2Omh+cv1nzvwjxWv1QptIYG8Y4=;
        b=Lx0oWB1ot8ExwXxc/QEAZUnUzswGkaUZHDndeW6qVifuBE/wPFTQOaXCm8Z8xo65QQ
         mzh1GiPvowr1KSo8U4ucUhT0VOQCPnEM8M2pdGLeQBYfDFY7Xkb6MB/yIloCVUAUfGeR
         CYgBuX5c8eDko9t99SdbNSGn9V0Lt5UjlafA2cXTOLKnDXUfCAtMhpKt9eMXHZ2jIiWH
         HbYj68KhZdtubtSV3kLDTVbzWxscmD8i6fm27V48jCGSFZVkX2sGZYVqZ3DaVya3Moni
         Ns31c8J3asEtDawn2HSm5zJ1mvIBYCilxJ6pfc80DSyQtyf/APh3YO1qNpS/1heNAGEZ
         OGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695899655; x=1696504455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUmedfGkG2TY7Lh9P2Omh+cv1nzvwjxWv1QptIYG8Y4=;
        b=KLNcqAPtDHPT4mffugDEa8A5I04aOKrTfgDL2nwNEmE0cMgKLoCXMGhnUDTb0gcifh
         L0tuNHIl5KCcnFIJ7ocUFr9uySTjzwaAGfY5WLWwpVV7tvjdlfiTJuZcosjn/CuWdC/y
         eHoZlzj1R1oXUNV7rRMAnaGTnKLGsUeR6ZUGN+YWsyDJl7PcwhRRwsEuKk4GXyEwFlK/
         bRRQuLj66EHJAYu48QtwLA+FJlaNvhyOZ6rri3nSUZGlFM7vpJXYAJui+IWasxKKUBAd
         8gpbTaUfxhMBOSWF3u7rhezYkEyZsqBd43NRjbzUphSIRCu8Y01o++9D8TJsaIR4CoR/
         cvJw==
X-Gm-Message-State: AOJu0YxMcmVfN1JPkgT8VIw2ElvemlU8bHF6bm68J1IJik4A5cGWH0WX
        DOfy9kcsBROEUfXjUF11V67RrepuZXHJFg==
X-Google-Smtp-Source: AGHT+IGCMFc25SvXYPxAQ2LYAB8zxytedQkTLnphm7KwFcebGJDdm4mt8h0w3mlCH53zuTEDFGtB/w==
X-Received: by 2002:a17:902:720a:b0:1c5:f4c7:b4e4 with SMTP id ba10-20020a170902720a00b001c5f4c7b4e4mr726388plb.39.1695899655265;
        Thu, 28 Sep 2023 04:14:15 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902e9c600b001a5260a6e6csm2205995plk.206.2023.09.28.04.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 04:14:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E1D95822201F; Thu, 28 Sep 2023 18:14:11 +0700 (WIB)
Date:   Thu, 28 Sep 2023 18:14:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux regression tracking (Thorsten Leemhuis) 
        <regressions@leemhuis.info>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: what to do on magically fixed case? (was Fwd: Kernel 6.6-rc1 fails
 to reboot or shutdown Ryzen 5825U)
Message-ID: <ZRVgAzNLhk90nAwX@debian.me>
References: <2bc62c07-2195-e378-c057-f28e8d4a6034@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7gEfWuyLi5+Wpy2/"
Content-Disposition: inline
In-Reply-To: <2bc62c07-2195-e378-c057-f28e8d4a6034@gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7gEfWuyLi5+Wpy2/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[addressing to Thorsten]

On Thu, Sep 14, 2023 at 02:03:00PM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> > The Kernel stalls at boot very long with a drm-amdgpu message, but fail=
s to restart or shutdown with secure boot enabled or not. Magic key works t=
o exit. Nothing wrong in the Kernel 6.5 cycle.
>=20
> Later, the reporter (Cc'ed) described the regression:
>=20
> > Let me be clearer, it does not shutdown at all: magic key for shut down=
 has no effect (o or b). The keyboard is dead. Plus, $ shutdown -r now hang=
s too. Restart works when using Alt+PrtSc+b. Same when booting stalls for l=
ong.
> >=20
> > We started bisecting with 20230903 daily kernel, the bug was there. 6.6=
-rc1 has been removed. Take good note that next boot log after shutdown may=
 or may not be the same log. Plus, booting requires now and then magic key =
to restart, because the Kernel hangs.  In this case, we must click enter tw=
ice + Esc to boot in desktop.=20
> >=20
> > It booted ok after a cold shutdown with enter twice and ESC ounce + bac=
kspace.=20
> > ...
> > In all cases, tpm and secure boot are enabled. If secure boot is disabl=
ed, when we shut down, magic key works to restart.
>=20
> He then pasted journalctl excerpt at the point where the hang occured:
>=20
> > This where it stalls for restart. Shut down hangs at the Lenovo image:
> >=20
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE=
 1, CU per SH 8, active_cu_number 8
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx uses V=
M inv eng 0 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx_low us=
es VM inv eng 1 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring gfx_high u=
ses VM inv eng 4 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0=
 uses VM inv eng 5 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0=
 uses VM inv eng 6 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0=
 uses VM inv eng 7 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0=
 uses VM inv eng 8 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1=
 uses VM inv eng 9 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1=
 uses VM inv eng 10 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1=
 uses VM inv eng 11 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1=
 uses VM inv eng 12 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring kiq_0.2.1.=
0 uses VM inv eng 13 on hub 0
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses=
 VM inv eng 0 on hub 8
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_dec us=
es VM inv eng 1 on hub 8
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 u=
ses VM inv eng 4 on hub 8
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 u=
ses VM inv eng 5 on hub 8
> > Sep 13 21:43:08 mm kernel: amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec u=
ses VM inv eng 6 on hub 8
> > Sep 13 21:43:08 mm kernel: [drm] Initialized amdgpu 3.54.0 20150101 for=
 0000:04:00.0 on minor 0
> > Sep 13 21:43:08 mm kernel: fbcon: amdgpudrmfb (fb0) is primary device
> > Sep 13 21:43:08 mm kernel: [drm] DSC precompute is not needed.
>=20
> See Bugzilla for the full thread and links to complete journalctl log.
>=20
> Anyway, I'm adding this regression to regzbot:
>=20
> #regzbot introduced: v6.5..v6.6 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D217905
> #regzbot title: shutdown/reboot hang on Ryzen 5825U (stuck on amdgpu init=
ialization)
>=20

Hi Thorsten,

On Bugzilla, the reporter said that this regression was fixed in linux-next
tree without specifying the exact commit that do it. He also did not bisect
as I asked, nor even culprit commit range. Should I mark this regression as=
=20
fixed?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--7gEfWuyLi5+Wpy2/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRVgAwAKCRD2uYlJVVFO
ow4TAP46+9xAR+7G8EIOHRc2lwwECfkTXIficxRJWJtQ87Zi8wEAxwyjUi+V2fba
NQvMKQOvYJ1M0GrnqqFMLPP42ERJ8AU=
=JZNK
-----END PGP SIGNATURE-----

--7gEfWuyLi5+Wpy2/--
