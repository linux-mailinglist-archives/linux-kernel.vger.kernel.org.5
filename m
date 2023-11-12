Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808F77E8FA8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 12:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjKLLSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 06:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKLLSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 06:18:44 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77732D61;
        Sun, 12 Nov 2023 03:18:40 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2e330033fso2174255b6e.3;
        Sun, 12 Nov 2023 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699787920; x=1700392720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv8ACPVZgV0Pxa5en7zdw7RbJitiG8y+EBffkQkWb7Y=;
        b=I8ad2Oh1bnWbpzIpr6NVCoCUdGv8bfQeOjOwDjE5mnN64CVdQeXTkG55nL7GccspR6
         +Ldg3cdeunx2CFad5WAz22M4lwB9+3Az12yWWlILK+XAgv7rDetNanS5TKBT+dIC3t2+
         YHx1mwf9/q3QnFVqbIJGPtGiaUwYTTH7P1PHhYAa+gdrovxtT+fxV6cBoCtT18nICZu5
         IAtxyBxsJUL5yYWtYil1L6O5K4AKpYgquo6ZtzSkIWUiaKgpaQLjyzIaS/kEboOOz1v7
         O71tUuZISWReO2NE7w/90CB5ha2Md/CJe9a2iPCNc6y7fDJ6Z2ukxT9MvVTUpeOKEKBH
         doIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699787920; x=1700392720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv8ACPVZgV0Pxa5en7zdw7RbJitiG8y+EBffkQkWb7Y=;
        b=T2dxrBMIYA03hok4UoCtW49j9A9aYODNwOExipDca4D6ej67rGGOQOEjACFNhh6KE5
         cQVaCrth2qW911TUw7zyyZqAzLtLm1XGqSOiyvUgHTLzBzFWkbeIq8idK453TA/fZo3/
         bG6ZEu2f3fVUGd1cDJQV2lLguYM9YSi3O272OssTdH1fdLU9JtXDggtIP/gTTLvoyC6g
         RziAImv1qeAHq6ZaGQtT8Mo3VtiEz3hGEHHwEQI6Ic+dZDLeaEDSorHfb5dyISVZBBeC
         i6EbPwNJ0Y8IIrlWG1V5asj9un9XMjq8pwpZryz/abTXWDDLUXE94yh5NdDHHEajEX+J
         wBqg==
X-Gm-Message-State: AOJu0YwqszlfQM/MNngdHIBU9xCwLtzmpbhSzWm2HaYvAoV+sK8x7o93
        x2dtbvdEtEzrCtj5Zc9reV6CpVmc2zSWbw==
X-Google-Smtp-Source: AGHT+IEPRPJW1QI/XCdMbL9xm1cmv0fOQqW/MYQ3+/W+n5yRUspIQECqB+RdWxnOXUpmRx22hLWDXg==
X-Received: by 2002:a05:6808:164e:b0:3ab:5592:4704 with SMTP id az14-20020a056808164e00b003ab55924704mr5213025oib.2.1699787919776;
        Sun, 12 Nov 2023 03:18:39 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q23-20020a62e117000000b006c0328b2440sm2390072pfh.150.2023.11.12.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 03:18:38 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id B81D310299770; Sun, 12 Nov 2023 18:18:34 +0700 (WIB)
Date:   Sun, 12 Nov 2023 18:18:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= 
        <pinkflames.linux@gmail.com>,
        Fabio Comolli <fabio.comolli@gmail.com>
Cc:     Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: Fwd: iwlmvm: Linux 6.7 pre-rc1 prints stack trace of
 iwl_op_mode_mvm_start; caused by commit b6e3d1ba4fcf
Message-ID: <ZVC0iq1FS02FjeTX@archie.me>
References: <2fa930bb-54dd-4942-a88d-05a47c8e9731@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2PfOC9ZO3kyEIA4"
Content-Disposition: inline
In-Reply-To: <2fa930bb-54dd-4942-a88d-05a47c8e9731@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w2PfOC9ZO3kyEIA4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nikl=C4=81vs and Fabio,

On Fri, Nov 03, 2023 at 08:13:39PM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> > When testing the branch that will become Linux 6.7-rc1, ever since comm=
it b6e3d1ba4fcf02176846d03a930203d8133c0aaf I have observed the following a=
bbreviated kernel stack trace (please see attachments for the full trace):
> >=20
> > ```
> > [    6.733281]  ? __warn+0xc3/0x1d0
> > [    6.733284]  ? iwl_op_mode_mvm_start+0x9c4/0x9d0 [iwlmvm]
> > [    6.733299]  ? report_bug+0x167/0x220
> > [    6.733301]  ? handle_bug+0x3d/0x90
> > [    6.733304]  ? exc_invalid_op+0x1a/0x60
> > [    6.733306]  ? asm_exc_invalid_op+0x1a/0x20
> > [    6.733309]  ? iwl_op_mode_mvm_start+0x9c4/0x9d0 [iwlmvm]
> > [    6.733325]  _iwl_op_mode_start+0x66/0xe0 [iwlwifi]
> > [    6.733338]  iwl_opmode_register+0x87/0xd0 [iwlwifi]
> > [    6.733350]  ? __cfi_init_module+0x10/0x10 [iwlmvm]
> > [    6.733364]  init_module+0x22/0xff0 [iwlmvm]
> > [    6.733378]  ? __cfi_init_module+0x10/0x10 [iwlmvm]
> > [    6.733392]  do_one_initcall+0x129/0x380
> > [    6.733395]  ? idr_alloc_cyclic+0x148/0x1e0
> > [    6.733397]  ? security_kernfs_init_security+0x41/0x80
> > [    6.733399]  ? __kernfs_new_node+0x1be/0x250
> > [    6.733401]  ? preempt_count_add+0x55/0xb0
> > [    6.733404]  ? up_write+0x4a/0xe0
> > [    6.733406]  ? preempt_count_add+0x55/0xb0
> > [    6.733408]  ? sysvec_call_function+0xa4/0xb0
> > [    6.733410]  ? asm_sysvec_call_function+0x1a/0x20
> > [    6.733411]  ? free_unref_page_prepare+0xf3/0x410
> > [    6.733413]  ? preempt_count_add+0x62/0xb0
> > [    6.733415]  ? _raw_spin_trylock+0x19/0x60
> > [    6.733417]  ? _raw_spin_unlock+0x11/0x30
> > [    6.733419]  ? __kmem_cache_free+0x29a/0x3c0
> > [    6.733421]  ? vfree+0xd2/0x150
> > [    6.733422]  ? slab_post_alloc_hook+0x76/0x3d0
> > [    6.733425]  ? do_init_module+0x3f/0x230
> > [    6.733427]  ? __kmem_cache_alloc_node+0x1fe/0x2f0
> > [    6.733430]  do_init_module+0x7a/0x230
> > [    6.733432]  __se_sys_init_module+0x1a0/0x220
> > [    6.733435]  do_syscall_64+0x7a/0x100
> > [    6.733438]  ? syscall_exit_to_user_mode+0x2d/0x1d0
> > [    6.733440]  ? do_syscall_64+0x89/0x100
> > [    6.733442]  ? do_user_addr_fault+0x4e7/0x680
> > [    6.733444]  ? exc_page_fault+0x61/0x150
> > [    6.733446]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > ```
> >=20
> > I did try reverting the offending commit but the result did not compile=
 and I did not want to dig deeper to identify any subsequent commits what w=
ould need reverting to fix compilation.
> >=20
> > If it's relevant, I'm building the kernel with Clang 17.0.4 toolchain b=
y setting the LLVM=3D1 variable. CFI is enabled but I'm not sure if it's ac=
tually functional.
>=20
> See Bugzilla for the full thread.
>=20
> Anyway, I'm adding this regression to regzbot:
>=20
> #regzbot introduced: b6e3d1ba4fcf02 https://bugzilla.kernel.org/show_bug.=
cgi?id=3D218095
> #regzbot title: new iwlwifi firmware statistics API triggers stack trace
>=20

Emmanuel had sent a proposed fix at [1]. Please test.

Thanks.

[1]: https://lore.kernel.org/regressions/20231112100944.21177-1-emmanuel.gr=
umbach@intel.com/

--=20
An old man doll... just what I always wanted! - Clara

--w2PfOC9ZO3kyEIA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVC0igAKCRD2uYlJVVFO
o8GvAQCgaaMgHyMNOGRExrMf9mhXIKx0v160v/eAArXomvKctgD+PlXLMd1ClK5P
yWIoOBL7x8/x0kWSMUWrhMPTm8UU4wg=
=9xij
-----END PGP SIGNATURE-----

--w2PfOC9ZO3kyEIA4--
