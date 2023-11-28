Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F97FB13B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjK1FbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjK1FbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:31:16 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D11E6;
        Mon, 27 Nov 2023 21:31:23 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b20a48522fso4073685b3a.1;
        Mon, 27 Nov 2023 21:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701149483; x=1701754283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEPi9c7ppkLgBeiuzKlkFix1rYtohwubig6Zzx1D7yA=;
        b=le8QwU0jCDY9ZG8m19L67XVIZKrDXN9fQ84HljH7vOr4IqtzYe1Yksg3pY6zeTVGI8
         T6O1R+2/4mUObwgGo1vTrDWY0diQ9ecKmi2IOHGctPkIFQCjbVy29GVapssYOll5eozF
         bPVNO0hh1P3Gh5w7EfXg6uTYYz/4JcJUwLwVwpLBmEUYGHUrr0oa78FNTxBaOP2K/kVh
         X2MygYRlOCAauQ3ziWKI2T4M9mHwMzDtUKlafPlUCchZHg+QY9lpyuvRr7vy118MO8qF
         HRHPqzoKdf1uFTB6PKl0PrTxOQq7xrgni/7T/+NXGBIWCYUDyQUN510YNrCETwoN5rvO
         fHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701149483; x=1701754283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEPi9c7ppkLgBeiuzKlkFix1rYtohwubig6Zzx1D7yA=;
        b=JSvqB77eFKeuTfDTcDKklnpmkb1vsmSjbw1mSHbRN12cMcS0/MKH1NbDzCCZtMklVD
         ATixskBk+Vh6f4PCBAaY99KJr7WGX8zwfNxITElIrbLuBsN+FIHwPtcjTYhUHWlebIkj
         NXy9WNtKXgkVPdtdrBshRGDguTImiG75saqZHxiVs4J3T6FsoO6zLYRId7IQ4tk0e3Uq
         HISR3Eglh/zDFBZBBAenBkAd3NgQeN73XgKoyrnxVNSsk9bo1cf1CS/vyLTKFAQK7BSA
         CkkLq90+E3mzEZWV6AXXGKHAqSN4BBfIju4TeZEsRpnv+fhSZKoXixw5aiYKYU0lq6xh
         ssZA==
X-Gm-Message-State: AOJu0YxGAmZTGhgACfZoNfYluiOyJmV73Ej2LgmbsOoCWGPemDaf7Ztx
        mBT70rUAYrryjz+EiHxIIMQ=
X-Google-Smtp-Source: AGHT+IGlXC8UReAEZX2Q21EENrre/8ig09+Y/pOPN2cMuhsa5digs3NrGSN7fY2BDBGQ+2jchBphmQ==
X-Received: by 2002:a05:6a20:1445:b0:18c:5c04:5564 with SMTP id a5-20020a056a20144500b0018c5c045564mr8897440pzi.60.1701149482790;
        Mon, 27 Nov 2023 21:31:22 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001cfde3ee4e8sm1655108plx.125.2023.11.27.21.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 21:31:22 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 024731143686A; Tue, 28 Nov 2023 12:31:19 +0700 (WIB)
Date:   Tue, 28 Nov 2023 12:31:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Genes Lists <lists@sapience.com>, tglx@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gregory.greenman@intel.com, kvalo@kernel.org,
        Linux Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Regressions <regressions@lists.linux.dev>
Subject: Re: crash with 6.7 rc2 and rc3
Message-ID: <ZWV7JworMrjHJHsO@archie.me>
References: <c46a6462-8263-455c-a6ea-1860020f5fab@sapience.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sEcx6aMYousCg2QL"
Content-Disposition: inline
In-Reply-To: <c46a6462-8263-455c-a6ea-1860020f5fab@sapience.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sEcx6aMYousCg2QL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 03:55:37PM -0500, Genes Lists wrote:
>=20
> lenovo laptop boots fine under 6.7rc1 and older including 6.6.2 stable.
> but not for 6.7 rc2 or rc3.
>=20
> It has a intel 7260 (rev 3) wireless and :
>=20
> cpu family	: 6
> model		: 60
> model name	: Intel(R) Core(TM) i7-4800MQ CPU @ 2.70GHz
> stepping	: 3
> microcode	: 0x28
>=20
>=20
> As of 6.7 rc2 / rc3 it crashes towards the end of boot bringing up servic=
es
> -  some parts of crash scrolled off the screen so I apologize if this
> (manually transcribed) trace didn't catch the first part.
>=20
> I did a git bisect between rc1 and rc2 but was unable to reproduce the cr=
ash
> for some reason. (I did not do make clean between each bisects).
>=20
> During the bisect it booted every time, but networking was not functional
> for any of the bisects.
>=20
> Hope it's okay to report even though git bisect didn't get anywhere.
>=20
> Gene
>=20
> This is the what I got from screen :
>=20
> CS: 0010 DS: 000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f30cf49ba38 CR3: 000000025b620004 CR4: 00000000001706f0
> Call Trace:
>  <IRQ>
>  ? die_addr+0x36/0x90
>  ? exc_general_protection+0x1c5/0x430
>  ? asm_exc_gemeral_protection+0x26/0x30
>  ? iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
>  ? __kmem_cache_alloc_node+0x1d5/0x2b0
>  ? iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
>  ? iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
>  __kmalloc_node_track_caller+0x51/0x160
>  kmemdup+0x20/0x50
>  iwl_phy_db_set_section+0xd6/0x1f0 [iwlwifi]
>  iwl_wait_phy_db_entry+0x2f/0x40 [iwlmvm]
>  iwl_notification_wait+0xb0/0xf0 [iwlwifi]
>  iwl_mvm_rx_common+0x8e/0x320 [iwlwifi]
>  iwl_pcie_napi_poll+0x2d/0x150 [iwlwifi]
>  __napi_poll+0x2b/0x1c0
>  net_rx_action+0x2b4/0x320
>  __do_softirq+0xff/0x339
>  net_rx_action+0x2b4/0x320
>  __do_softirq.part.0+0x88/0xa0
> </IRQ>
> <TASK>
> __local_bh_enable_ip+0x91/0xa0
> iwl_pcie_irq_handler+0x58d/0xc40 [iwlwifi]
> ? __pfx_irq_thread_fn+0x10/0x10
> irq_thread_fn+0x23/0x60
> irq_thread+0xfe/0x60
> ? __pfx_irq_thread_dtor+0x10/0x10
> ? __pfx_irq_thread+0x10/0x10
> kthread+0xfa/0x130
> ? pff_kthread+0x10/0x10
> ret_from_fork+0x34/0x50
> ? __pfx_kthread+0x10/0x10
> ret_from_fork_asm+0x1b/0x30

Do you have any full system logs that can be attached?

Anyway, thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: v6.7-rc1..v6.7-rc2

--=20
An old man doll... just what I always wanted! - Clara

--sEcx6aMYousCg2QL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWV7IgAKCRD2uYlJVVFO
o02/AQDz9zBxC7l3PA7XiPWORmbSKTBUjAJWCjZ4HQCsGtw9ZgEA7Zige0E/cGXL
q1/LpBIwpT3tfL752nITIl7B/mcKdwg=
=C092
-----END PGP SIGNATURE-----

--sEcx6aMYousCg2QL--
