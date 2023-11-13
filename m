Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C9D7EA702
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKMXbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMXbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:31:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B2F8F;
        Mon, 13 Nov 2023 15:31:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2800f7c8125so4640053a91.1;
        Mon, 13 Nov 2023 15:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699918263; x=1700523063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kDZ1cIdWgAZuXI5ozto7uEtbIC72lCm4PFb4eXmL6CE=;
        b=fa1oxU7jZs5RgBytDCxGvCGAamOXa2hhU8qkOGYLLa7Ticp3RCsfwNS8YW/o5EG20d
         iDX5iITAEaCbo1khFWWR67k+at0P8VMNHDDnsw5FMiLXVy+F/TSYPJihwS/V7wkNZpjk
         tsAgMvtSnMYUpeoM/LxI0p89BhebTyEUb8wwbrUwHduPeEfsIybWv1SJq0LjI0SKJRLb
         6UmmFAHlI+Cf7Tvm23591nxs3Gqm1BNohgtx0XUWn5ED6ROGN8bcLBvoI2cVm6GBmX8v
         hSbc83loeAKO8W+J/nNZey1m6YwaQ77DOdo6Oho2PiLF1ettcmav9yi9GmLBtNpGKxgV
         wTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699918263; x=1700523063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDZ1cIdWgAZuXI5ozto7uEtbIC72lCm4PFb4eXmL6CE=;
        b=C4+9+FOmbRLHM58MqQJkOCCwnULj4hEkrnOE8aJ9JovjjX6esh/k6NDMnmRKP7Q7Ga
         xh5X/aVKfSz7gBHLBp2WJlazKj272xAvkNbzVeDYrEWI/14dI2r3QT9EH05vwiS2AwYC
         OIcjRPH2Nonq+EHUpHhCuKcGXwUdwLBppsPDgBLLl3NDDfz0/TCuRiTpvqSSs0h/6qyT
         KDJTDAwoJfCf0fgAoX8okabXBzxRV4Fyy66M+Nn/4x9H/PdPIqlQtMCidHlGwpN9FVBM
         WSYNXFg+C6SxgwLCu8zstZKxsJk/n42mNEri9iMzPUsgKWLZw5He3a5Slaf5YZ8GBB55
         GDhA==
X-Gm-Message-State: AOJu0YyYzWnFUee8gNi3wodPPr0OqYb74J41Gt42XECLqnOG2vwIkpHa
        pGi9cUMAdSnTSl43mhzubjQ=
X-Google-Smtp-Source: AGHT+IHxx+SJCVs7SPPaBNARSsTIQL2a78Bq6VjpoYvEXoFTIZ8zIJb8O8RxQL5Rcvn7Bfimz39oGg==
X-Received: by 2002:a17:90b:180f:b0:280:4af4:1a41 with SMTP id lw15-20020a17090b180f00b002804af41a41mr1507089pjb.15.1699918263286;
        Mon, 13 Nov 2023 15:31:03 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902694900b001cc0e3a29a8sm4529918plt.89.2023.11.13.15.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:31:02 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 8131A101BF818; Tue, 14 Nov 2023 06:31:00 +0700 (WIB)
Date:   Tue, 14 Nov 2023 06:31:00 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Aditya Garg <gargaditya08@live.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Asahi Linux Mailing List <asahi@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip
 starting from kernel 6.5
Message-ID: <ZVKxtD2Mt_eVyttJ@archie.me>
References: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6D6G11eLM7jDJgCQ"
Content-Disposition: inline
In-Reply-To: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6D6G11eLM7jDJgCQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 08:57:35PM +0000, Aditya Garg wrote:
> Starting from kernel 6.5, a regression in the kernel is causing Bluetooth=
 to not work on T2 Macs with BCM4377 chip.
>=20
> Journalctl of kernel 6.4.8 which has Bluetooth working is given here: htt=
ps://pastebin.com/u9U3kbFJ
>=20
> Journalctl of kernel 6.5.2, which has Bluetooth broken is given here: htt=
ps://pastebin.com/aVHNFMRs
>=20
> Also, the bug hasn=E2=80=99t been fixed even in 6.6.1, as reported by use=
rs.

Can you bisect this regression please?

>=20
> Some relevant bits imo:
>=20
>     =E2=80=A2 Sep 19 21:24:36 RudyUbuMbp kernel: hci_bcm4377 0000:73:00.1=
: can't disable ASPM; OS doesn't have ASPM control
>=20
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: Call Trace:
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: <TASK>
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: dump_stack_lvl+0x48/0x70
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: dump_stack+0x10/0x20
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: __ubsan_handle_shift_out=
_of_bounds+0x156/0x310
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: ? ttwu_do_activate+0x80/=
0x290
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: ? raw_spin_rq_unlock+0x1=
0/0x40
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: ? try_to_wake_up+0x292/0=
x6c0
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: ? sched_slice+0x76/0x140
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: ? reweight_entity+0x15c/=
0x170
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: __reg_op.cold+0x14/0x38
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: bitmap_release_region+0x=
e/0x20
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: bcm4377_handle_ack+0x8c/=
0x130 [hci_bcm4377]
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: bcm4377_poll_completion_=
ring+0x196/0x330 [hci_bcm4377]
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: ? rcu_gp_kthread_wake+0x=
57/0x90
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: bcm4377_irq+0x77/0x140 [=
hci_bcm4377]
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: __handle_irq_event_percp=
u+0x4c/0x1b0
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: handle_irq_event+0x39/0x=
80
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: handle_edge_irq+0x8c/0x2=
50
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: __common_interrupt+0x4f/=
0x110
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: common_interrupt+0x45/0x=
b0
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: asm_common_interrupt+0x2=
7/0x40
>     =E2=80=A2 Nov 14 01:29:28 RudyUbuMbp kernel: RIP: 0033:0x7f17b5fd8bca

Anyway, thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: v6.4..v6.5

--=20
An old man doll... just what I always wanted! - Clara

--6D6G11eLM7jDJgCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVKxsQAKCRD2uYlJVVFO
o7pdAQCnfRXRPTO65yNiy5w0iigPO8iwskixInYi/GKY5Njt/wD/Zkgd2bApc+JF
H8fRsVcs7KNkBGy8IHSdCWeFO/IWLw4=
=vFNS
-----END PGP SIGNATURE-----

--6D6G11eLM7jDJgCQ--
