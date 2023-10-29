Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF67F7DAA66
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 02:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJ2Bsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 21:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2Bsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 21:48:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110A1CF;
        Sat, 28 Oct 2023 18:48:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b9af7d41d2so2983220b3a.0;
        Sat, 28 Oct 2023 18:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698544128; x=1699148928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=auatwq7IukONekRjkD8fy/r6M5PY6yplZ8A6BcVgrik=;
        b=ilFFzRS8lobmPuaqxFB1v1cBnI057yV9nPSFL+1fonF7IwA7LIiflwDg2EBF+sE4Ju
         TJYVaLsM9KlqgsvXkD4jRqMZ92Wq02MwjIjEDyH3HksQqdjHwa98uKXodM3xPcsi7O6e
         CRgJZRff2rvF9Dg66DRgmJexzzlKYXOyn37aY3cTnZuuuEJHtHppbPXISANxJ5RO8fsF
         aDPErIYL5662Vxws0wQlj5Tsx2FdsQSMgCsgj/OUo85N0+4if8QMYIvp3tMby8orgqdE
         76QJ6LQ5yb2ruf7pqZF+sNKKVGydNaecUpMMqIduDWXXl0I7L2g/IW0TsWiwknD/0AJd
         WJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698544128; x=1699148928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auatwq7IukONekRjkD8fy/r6M5PY6yplZ8A6BcVgrik=;
        b=NP4dzvBTe9qLX56rHMgdSRlSISCpStWPv5QknAuov4c67UJqNxuiwORexicUN11aOf
         9eWYWbTxUYHf7c2QBo8dpX/ghbJtb103W3WnT6N+9Ro9x89kZCeUkL6MvoKXeeBfgDES
         w9zvzfXuaz1S7j2ouHcCeyCHe6kn2QYTCs6YVJEkbwVqMN9KUdrKfWJo7csjP5t8fxL7
         0xWYelWjU/JQRvpKbQggYRsZyZ8vOJZTrfqf5OZYeYSfwqQYP7pw+4Sl1ji9fcKRaIdC
         rTkbHISMLyJQtpx6AIK6lTP640rfuUGwe7wuGtmpHY/7p1UGkwmQeoEVvJizNUJ1OI2P
         Lx6g==
X-Gm-Message-State: AOJu0YyXrQ2gdyQvlOi7+C+fGz5Yf9zSwayGOvKRHnKt9rxtbdhn3vMS
        qD1lCbmC8fHldQyRTe/Nqpg=
X-Google-Smtp-Source: AGHT+IEmW7h54d/bTZdjJ6PyNgjOmZfb752KgVjw8p6echz5SgbZih3/FuM6WBOgDx4mD+Ik3rg9eA==
X-Received: by 2002:a17:902:e5cf:b0:1cc:3c6c:ce23 with SMTP id u15-20020a170902e5cf00b001cc3c6cce23mr879901plf.42.1698544128240;
        Sat, 28 Oct 2023 18:48:48 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001b8baa83639sm3759894plx.200.2023.10.28.18.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 18:48:47 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 98A0E8047BCA; Sun, 29 Oct 2023 08:48:43 +0700 (WIB)
Date:   Sun, 29 Oct 2023 08:48:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        Linux x86 Platform Drivers 
        <platform-driver-x86@vger.kernel.org>,
        Linux LEDs <linux-leds@vger.kernel.org>
Cc:     Tim Crawford <tcrawford@system76.com>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Johannes =?utf-8?Q?Pen=C3=9Fel?= <johannes.penssel@gmail.com>
Subject: Re: Fwd: sysfs: cannot create duplicate filename
 .../system76_acpi::kbd_backlight/color
Message-ID: <ZT25-gUmLl8MPk93@debian.me>
References: <b5646db3-acff-45aa-baef-df3f660486fb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l1HHIbidedQ4JpqX"
Content-Disposition: inline
In-Reply-To: <b5646db3-acff-45aa-baef-df3f660486fb@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l1HHIbidedQ4JpqX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 02:55:06PM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> > Loading the system76-acpi kernel module fails on linux 6.6-rc7. This do=
es not seem to be an issue with system76-acpi itself, because reverting com=
mit #5d36931f0fe51665c04f56c027613d22e6a03411, which is the only change mad=
e to this driver across the 6.6 development cycle, does not fix the issue. =
On 6.5.8, everything works fine. My hardware is a Clevo-based Alder Lake la=
ptop running coreboot, roughly similar to the System76 Darter Pro 8.
> >=20
> > backtrace:
> > [  266.399036] sysfs: cannot create duplicate filename '/devices/LNXSYS=
TM:00/LNXSYBUS:00/17761776:00/leds/system76_acpi::kbd_backlight/color'
> > [  266.399045] CPU: 1 PID: 2896 Comm: modprobe Not tainted 6.6.0-rc7 #1
> > [  266.399050] Hardware name: Notebook NS5x_NS7xPU/NS5x_NS7xPU, BIOS Da=
sharo (coreboot+UEFI) v1.6.0 03/30/2023
> > [  266.399053] Call Trace:
> > [  266.399057]  <TASK>
> > [  266.399063]  dump_stack_lvl+0x36/0x50
> > [  266.399080]  sysfs_warn_dup+0x5a/0x70
> > [  266.399088]  sysfs_add_file_mode_ns+0x11a/0x130
> > [  266.399094]  internal_create_group+0x125/0x3b0
> > [  266.399101]  internal_create_groups+0x42/0xa0
> > [  266.399107]  device_add+0x5b1/0x8a0
> > [  266.399113]  ? kstrdup+0x4c/0x70
> > [  266.399119]  device_create_groups_vargs+0xce/0xf0
> > [  266.399124]  device_create_with_groups+0x4b/0x70
> > [  266.399129]  led_classdev_register_ext+0x1d2/0x470 [led_class]
> > [  266.399149]  ? devm_led_classdev_register_ext+0x3a/0x90 [led_class]
> > [  266.399162]  devm_led_classdev_register_ext+0x50/0x90 [led_class]
> > [  266.399173]  system76_add+0x18b/0x460 [system76_acpi]
> > [  266.399186]  acpi_device_probe+0x47/0x130
> > [  266.399193]  really_probe+0x19b/0x3e0
> > [  266.399199]  ? __pfx___driver_attach+0x10/0x10
> > [  266.399205]  __driver_probe_device+0x78/0x160
> > [  266.399211]  driver_probe_device+0x1f/0x90
> > [  266.399217]  __driver_attach+0xd2/0x1c0
> > [  266.399222]  bus_for_each_dev+0x85/0xd0
> > [  266.399227]  bus_add_driver+0x116/0x220
> > [  266.399233]  driver_register+0x59/0x100
> > [  266.399242]  ? __pfx_system76_driver_init+0x10/0x10 [system76_acpi]
> > [  266.399252]  do_one_initcall+0x5a/0x300
> > [  266.399260]  do_init_module+0x60/0x240
> > [  266.399267]  init_module_from_file+0x86/0xc0
> > [  266.399275]  __x64_sys_finit_module+0x18a/0x350
> > [  266.399282]  do_syscall_64+0x5d/0x90
> > [  266.399289]  ? syscall_exit_to_user_mode+0x26/0x40
> > [  266.399295]  ? do_syscall_64+0x6c/0x90
> > [  266.399300]  ? do_syscall_64+0x6c/0x90
> > [  266.399305]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [  266.399314] RIP: 0033:0x7f5c11b38d7d
> > [  266.399360] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa=
 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7b d0 0b 00 f7 d8 64 89 01 48
> > [  266.399364] RSP: 002b:00007ffe30e15b88 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000139
> > [  266.399370] RAX: ffffffffffffffda RBX: 000055a8d48d6c10 RCX: 00007f5=
c11b38d7d
> > [  266.399372] RDX: 0000000000000000 RSI: 000055a8d3077d8b RDI: 0000000=
000000003
> > [  266.399375] RBP: 000055a8d3077d8b R08: 00007f5c11bf6b00 R09: 00007ff=
e30e15bd0
> > [  266.399376] R10: 0000000000000050 R11: 0000000000000246 R12: 0000000=
000040000
> > [  266.399378] R13: 000055a8d48d6c90 R14: 000055a8d48d6390 R15: 000055a=
8d48d7090
> > [  266.399382]  </TASK>
> > [  266.399410] System76 ACPI Driver: probe of 17761776:00 failed with e=
rror -17
>=20
> See Bugzilla for the full thread and attached dmesg output.
>=20
> Anyway, I'm adding this regression to regzbot:
>=20
> #regzbot introduced: v6.5..v6.6-rc7 https://bugzilla.kernel.org/show_bug.=
cgi?id=3D218045
>=20

The reporter had narrowed down the culprit. He said on Bugzilla:

> The culprit seems to be commit c7d80059b086c4986cd994a1973ec7a5d75f8eea, =
which introduces a new 'color' attribute for led sysfs class devices. The p=
roblem is that the system76-acpi platform driver tries to create the exact =
same sysfs attribute itself for the system76_acpi::kbd_backlight device, le=
ading to the conflict. For testing purposes, I've just rebuilt the kernel w=
ith the system76-apci color attribute renamed to kb_color, and that fixes t=
he issue.

Jean-Jacques Hiblot, would you like to take a look on this regression,
since you authored the culprit?

Anyway, telling regzbot:

#regzbot introduced: c7d80059b086c4

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--l1HHIbidedQ4JpqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZT259QAKCRD2uYlJVVFO
o1aLAQCTcxJzAz7z6gQE5PYbKcSC6KTszCtvXejFOdoLJXcb6wEAiDFpigyZ7u4l
WkPd9Z5tgzenEgsZPGAbF5PNFtKr+wk=
=pa9Q
-----END PGP SIGNATURE-----

--l1HHIbidedQ4JpqX--
