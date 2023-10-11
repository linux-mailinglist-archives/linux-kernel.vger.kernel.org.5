Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976067C5F79
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjJKVwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjJKVwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:52:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE7B6;
        Wed, 11 Oct 2023 14:52:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53b8f8c6b1fso636736a12.0;
        Wed, 11 Oct 2023 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697061121; x=1697665921; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGWAGi9aMCPyuKeoJaWLmL66Fz2iEdlNcFmwJ40bl5A=;
        b=ehSEptr096Rhb1gyrHcfBZyV3OQ8VFxomxpUqMHv8UAHu5j68hXyjAWf6HbM5R+Ztl
         AxUhr+qnmI9vtYnOHD58HZBvYRcgoujkhbjum0vAWJHAybklDkMqvVF9DqOAar/kbF8a
         V5SI+VQ4q34qoYHbu7sZP9WsqyALLJj3wes58Ll4siNdDLvPGq9JFwfbhgniSWjzPgN5
         q0nYi8Su7nGk/Ve2uY689LVxNHbXIv4+SDqipTwWBE6XiLIW67VIawm0O7IXh1xwXT6N
         teGJ8UIjRPedAj959GNT0RIQUjvMnOiiPPAEcMwTFZj6mBqQAcWObq0SFPkiNFECCNk1
         SehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061121; x=1697665921;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGWAGi9aMCPyuKeoJaWLmL66Fz2iEdlNcFmwJ40bl5A=;
        b=SnWkrixnKYF6nA7U+PO7VZKhgv0ElZbkiRJTUfGRuWF8pZl39r0fOjAIb4dgUHHRhc
         geQV1lnVk7qMJMHmOSh4bCqaJD/FTu7+LtfvQ3epEkEXFWjc1N5NwcjrJusUgyj4s3mw
         fIz+z2dzrLtWGt+FH0dYT0foT4+6poBSYG+/3pq+hB5hR1R0b2A2ApuG+HpJQMBpYLOD
         62swZkh52BIX80eGVeDZj3tDjohLs9uBSx0rMsLP3ZUcZI33zVB7AMLAW9U0TrQpSM8S
         bSS0ksWBX7mJrA/a8Yabe6+lSDeNuDEAnOc1L9K3doD5OnymLlMSu5merwqAFSi0j7Aj
         cZtw==
X-Gm-Message-State: AOJu0Yw6g8HrkbM+zfe0De4M75EHZTu0Hby20roNV6gQHjocMwxKjxCA
        GjQ9abSxU7He9B8+hF/cMlY=
X-Google-Smtp-Source: AGHT+IHzPJnBdOAuLleYma3VV+2TfQ4keMK3bhCuRcQNi5bPwAPsmhyQc0Ajn85f19/pczj64Mrsbg==
X-Received: by 2002:a05:6402:22d4:b0:53d:bc68:632e with SMTP id dm20-20020a05640222d400b0053dbc68632emr2933667edb.4.1697061120717;
        Wed, 11 Oct 2023 14:52:00 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fd10-20020a056402388a00b0053db0df6970sm1763333edb.54.2023.10.11.14.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:52:00 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:51:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: chipidea: Fix DMA overwrite for Tegra
Message-ID: <ZScY_uXsxamjnfPC@orome.fritz.box>
References: <cover.1695934946.git.mirq-linux@rere.qmqm.pl>
 <ef8466b834c1726f5404c95c3e192e90460146f8.1695934946.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sglXe+Dqwf9Z+IJZ"
Content-Disposition: inline
In-Reply-To: <ef8466b834c1726f5404c95c3e192e90460146f8.1695934946.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sglXe+Dqwf9Z+IJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 11:06:03PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Tegra USB controllers seem to issue DMA in full 32-bit words only and thus
> may overwrite unevenly-sized buffers.  One such occurrence is detected by
> SLUB when receiving a reply to a 1-byte buffer (below).  Fix this by
> allocating a bounce buffer also for buffers with sizes not a multiple of =
4.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> BUG kmalloc-64 (Tainted: G    B             ): kmalloc Redzone overwritten
> -------------------------------------------------------------------------=
----
>=20
> 0x8555cd02-0x8555cd03 @offset=3D3330. First byte 0x0 instead of 0xcc
> Allocated in usb_get_status+0x2b/0xac age=3D1 cpu=3D3 pid=3D41
>  __kmem_cache_alloc_node+0x12f/0x1e4
>  __kmalloc+0x33/0x8c
>  usb_get_status+0x2b/0xac
>  hub_probe+0x5e9/0xcec
>  usb_probe_interface+0xbf/0x21c
>  really_probe+0xa5/0x2c4
>  __driver_probe_device+0x75/0x174
>  driver_probe_device+0x31/0x94
>  __device_attach_driver+0x65/0xc0
>  bus_for_each_drv+0x4b/0x74
>  __device_attach+0x69/0x120
>  bus_probe_device+0x65/0x6c
>  device_add+0x48b/0x5f8
>  usb_set_configuration+0x37b/0x6b4
>  usb_generic_driver_probe+0x37/0x68
>  usb_probe_device+0x35/0xb4
> Slab 0xbf622b80 objects=3D21 used=3D18 fp=3D0x8555cdc0 flags=3D0x800(slab=
|zone=3D0)
> Object 0x8555cd00 @offset=3D3328 fp=3D0x00000000
>=20
> Redzone  8555ccc0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  .....=
=2E..........
> Redzone  8555ccd0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  .....=
=2E..........
> Redzone  8555cce0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  .....=
=2E..........
> Redzone  8555ccf0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  .....=
=2E..........
> Object   8555cd00: 01 00 00 00 cc cc cc cc cc cc cc cc cc cc cc cc  .....=
=2E..........
> Object   8555cd10: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  .....=
=2E..........
> Object   8555cd20: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  .....=
=2E..........
> Object   8555cd30: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  .....=
=2E..........
> Redzone  8555cd40: cc cc cc cc                                      ....
> Padding  8555cd74: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a              ZZZZZ=
ZZZZZZZ
> CPU: 3 PID: 41 Comm: kworker/3:1 Tainted: G    B              6.6.0-rc1mq=
-00118-g59786f827ea1 #1115
> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> Workqueue: usb_hub_wq hub_event
> [<8010ca28>] (unwind_backtrace) from [<801090a5>] (show_stack+0x11/0x14)
> [<801090a5>] (show_stack) from [<805da2fb>] (dump_stack_lvl+0x4d/0x7c)
> [<805da2fb>] (dump_stack_lvl) from [<8026464f>] (check_bytes_and_report+0=
xb3/0xe4)
> [<8026464f>] (check_bytes_and_report) from [<802648e1>] (check_object+0x2=
61/0x290)
> [<802648e1>] (check_object) from [<802671b1>] (free_to_partial_list+0x105=
/0x3f8)
> [<802671b1>] (free_to_partial_list) from [<80268613>] (__kmem_cache_free+=
0x103/0x128)
> [<80268613>] (__kmem_cache_free) from [<80425a67>] (usb_get_status+0x73/0=
xac)
> [<80425a67>] (usb_get_status) from [<80421b31>] (hub_probe+0x5e9/0xcec)
> [<80421b31>] (hub_probe) from [<80428bbb>] (usb_probe_interface+0xbf/0x21=
c)
> [<80428bbb>] (usb_probe_interface) from [<803ee13d>] (really_probe+0xa5/0=
x2c4)
> [<803ee13d>] (really_probe) from [<803ee3d1>] (__driver_probe_device+0x75=
/0x174)
> [<803ee3d1>] (__driver_probe_device) from [<803ee501>] (driver_probe_devi=
ce+0x31/0x94)
> usb 1-1: device descriptor read/8, error -71
>=20
> Fixes: fc53d5279094 ("usb: chipidea: tegra: Support host mode")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/usb/chipidea/host.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--sglXe+Dqwf9Z+IJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUnGPsACgkQ3SOs138+
s6GYow//R+s/b6fhumEI29E9pNwezoNjdeR5ahN/rQjsuIIn+tvrXNqWlBJLKMsi
S3EJoX4Pu4imyiQeMaaqnPRFrS4nIH7TybPo3HU5OucvQd1Gm6GaPPfZrGTu2eBr
UsCyEYa6jDoYZ5LX9wCW/HXFAYqTBFQ4kzZ0BD0uiaBK7+0I7hw1wpvwKV9BxJnq
q6AbB3cR0zJ0hJxiaDay0ucuDUNBfeepxFaS/R5hLA2xMNT7r4PR5/OIWduwEcki
LzEG5gE68lmeGDcggHN7SQBtVnjCeVP1fx1P6lj0u8EBuoGvnNA1tKMwPZz2tOdV
QPYJvlQCFS79K+MxwKwsFJMfPLeeOogsR2W3ck3qLGV4uqBsB3gBSk0u9jBQWMYN
+w2E76xiBgizpGsqeai2lzh0ue0nCbfq6DvvHuJRtxM8FPRyH211DcRml2momKAD
PNNkp/j8PSs+lKncw3Wxxn4gFzwjvZLAPHY39sRVQalwwtSO19vFzwgB42EJF9iL
Cf9jFeopUYzZsXRqpnkfgCtiES/JHcHsddf5SA/uLRCJJ2u6e4pHjVAnQj7B9qKo
B2PvhtoDhXfDY4xHGurprHMfIKDVnso/sYfmVMzZRMfC35oRG0ManiqU4cg2PZtB
XllVU7SBcN7gNxwK/toSgbZLdoHiXG4Bn9e2fegjPaqBQjrmZmc=
=oFX6
-----END PGP SIGNATURE-----

--sglXe+Dqwf9Z+IJZ--
