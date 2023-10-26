Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081BE7D8449
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbjJZOMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjJZOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:12:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391761A2;
        Thu, 26 Oct 2023 07:12:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso1566325b3a.1;
        Thu, 26 Oct 2023 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698329553; x=1698934353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yP3n7AI9Qh0Yfbsih2sjuZQuFfxckmyiS/LbfLTkIcc=;
        b=GxbPfg3JTEZOg1p4HDOtospiMBRtFxhO6KAaN3A0t4KwRggG470ev8x7NuFL4+euMM
         DgDCnjmwt102h3SAs3//Bcel5kHmLEHrb0FEoC/+aFCmCt71wh9qyuvfajl238zYr7r7
         wZBjtUplezcjOMQxlr07bNDKhWYlDNaO/aorBVmLX7uIimnk4JEBGadZvzEd2wLQQtAV
         W80XCtbKfHhF8jls8RLGog7HlYaCFsxvbc6ERWf4c67LVdkC+nkElONZU+LoXM8DwOmP
         /jFFaskHIAe8R559O0PI5MfdJ3oafAIfv1F8WVJOPfGkeVo7XfuIhuvurfIKJBwYmkUJ
         Tsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698329553; x=1698934353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP3n7AI9Qh0Yfbsih2sjuZQuFfxckmyiS/LbfLTkIcc=;
        b=TeFGCmkTHnfKlcyqQU3PzmFtxBvE8R2bbwXhYsyK1RVlhHmsA3hMUuFR4lq2Js8GDQ
         96pTFZktJ+S08XmLAlp0P46IA+4Q8yceGifXcZD+FeLersKpRVwHZtRdNUYY9tZr1Oaj
         U1HS33CxQtLl44XIbe0c+TuOFBHMvWLKGL3OgOqc/Eq+2KG0e0BSDNZoW27l+gHaDRtc
         W3gzHZsnraJl0I0FS7NznaxZOTecCByAr9Qt7P8w4LKfwdCiguOpe/R5oJMsKphQQo6W
         eD/IOIv5OJR+PMK3nYfAqlmhK9wOo1wwXuUzLfNg8qbNbpOIhjbgQXuYtSohDDbqnDLL
         MIqw==
X-Gm-Message-State: AOJu0Yyzj9Kamsi2v1Yje2LXSuQSaEuyffwE7HQ5MbzXdEbfsNz8MpNY
        GaJAd+mcSkCR+TXaa5Fh/H7jSbE30/0=
X-Google-Smtp-Source: AGHT+IEwihHQAHftXfgyvDtCXfRreGMIBkAgGlOIMHge6W8tJ6nebLu85h4c4GclDT1lxP1TYIlVHg==
X-Received: by 2002:a05:6a20:3cac:b0:17b:65ec:776c with SMTP id b44-20020a056a203cac00b0017b65ec776cmr3393192pzj.20.1698329553458;
        Thu, 26 Oct 2023 07:12:33 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p7-20020aa79e87000000b006b2e07a6235sm11149856pfq.136.2023.10.26.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:12:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CA0B78F4211C; Thu, 26 Oct 2023 21:12:30 +0700 (WIB)
Date:   Thu, 26 Oct 2023 21:12:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux SCSI <linux-scsi@vger.kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        Nikolaos Barkas <nickosbarkas@gmail.com>
Subject: Re: Fwd: Marvell 88SE6320 SAS controller (mvsas) cannot survive ACPI
 S3 or ACPI S4
Message-ID: <ZTpzzi-l6kEWnrzb@debian.me>
References: <7e8fab39-8cdd-4527-8c4f-b18dd79cee14@gmail.com>
 <4bec6c99-68aa-ddfb-9c22-ba62f66e5901@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="49r+na6rsr85JO8L"
Content-Disposition: inline
In-Reply-To: <4bec6c99-68aa-ddfb-9c22-ba62f66e5901@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--49r+na6rsr85JO8L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 05:56:03PM +0900, Damien Le Moal wrote:
> On 2023/10/26 17:25, Bagas Sanjaya wrote:
> > Hi,
> >=20
> > I notice a bug report on Bugzilla [1]. Quoting from it:
>=20
> [...]
>=20
> >> [  437.249448] PM: suspend entry (deep)
> >> [  437.255308] Filesystems sync: 0.005 seconds
> >> [  437.255570] Freezing user space processes
> >> [  437.257093] Freezing user space processes completed (elapsed 0.001 =
seconds)
> >> [  437.257097] OOM killer disabled.
> >> [  437.257098] Freezing remaining freezable tasks
> >> [  437.258226] Freezing remaining freezable tasks completed (elapsed 0=
=2E001 seconds)
> >> [  437.258281] printk: Suspending console(s) (use no_console_suspend t=
o debug)
> >> [  437.291778] sd 0:0:0:0: [sdb] Synchronizing SCSI cache
> >> [  437.291825] sd 0:0:1:0: [sdc] Synchronizing SCSI cache
> >> [  437.292083] sd 0:0:0:0: [sdb] Stopping disk
> >> [  437.292083] sd 0:0:1:0: [sdc] Stopping disk
> >> [  438.363660] sd 1:0:0:0: [sda] Synchronizing SCSI cache
> >> [  438.363760] sd 1:0:0:0: [sda] Stopping disk
>=20
> Given this message, this does not look like the latest kernel.
>=20
> >> [  589.081341] drivers/scsi/mvsas/mv_sas.c 1304:mvs_I_T_nexus_reset fo=
r device[1]:rc=3D 0
> >> [  610.481270] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >> [  610.481280] rcu: 	11-...0: (0 ticks this GP) idle=3D4f84/1/0x400000=
0000000000 softirq=3D19873/19873 fqs=3D1159
> >> [  610.481292] 	(detected by 5, t=3D5252 jiffies, g=3D53581, q=3D31630=
 ncpus=3D12)
> >> [  610.481299] Sending NMI from CPU 5 to CPUs 11:
> >> [  610.481309] NMI backtrace for cpu 11
> >> [  610.481312] CPU: 11 PID: 3152 Comm: kworker/u32:59 Tainted: G      =
    I        6.1.57-vanilla #14
> >> [  610.481318] Hardware name: System manufacturer System Product Name/=
P6T WS PRO, BIOS 1205    09/24/2010
> >> [  610.481321] Workqueue: events_unbound async_run_entry_fn
> >> [  610.481329] RIP: 0010:mvs_int_rx+0x81/0x150 [mvsas]
> >> [  610.481346] Code: 00 00 44 39 75 70 74 47 48 8b 45 60 45 89 e6 41 8=
1 e6 ff 03 00 00 41 8d 56 01 8b 1c 90 49 89 d4 41 89 df 41 81 e7 00 00 08 0=
0 <f7> c3 00 00 01 00 74 58 31 d2 89 de 48 89 ef e8 0b f9 ff ff 45 85
> >> [  610.481350] RSP: 0018:ffffb61f06acbb60 EFLAGS: 00000046
> >> [  610.481354] RAX: ffff9a7cc2658000 RBX: 0000000000010000 RCX: 000000=
0000000000
> >> [  610.481358] RDX: 000000000000026e RSI: 0000000000010000 RDI: ffff9a=
7ce2660000
> >> [  610.481361] RBP: ffff9a7ce2660000 R08: ffff9a7ce2660f00 R09: ffff9a=
7ce2660000
> >> [  610.481364] R10: ffff9a7ce26600c8 R11: ffffffff884d4300 R12: 000000=
000000026e
> >> [  610.481367] R13: 0000000000000000 R14: 000000000000026d R15: 000000=
0000000000
> >> [  610.481371] FS:  0000000000000000(0000) GS:ffff9a7df7cc0000(0000) k=
nlGS:0000000000000000
> >> [  610.481375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [  610.481378] CR2: 0000563633425300 CR3: 0000000077210006 CR4: 000000=
00000206e0
> >> [  610.481382] Call Trace:
> >> [  610.481385]  <NMI>
> >> [  610.481389]  ? nmi_cpu_backtrace.cold+0x1b/0x76
> >> [  610.481398]  ? nmi_cpu_backtrace_handler+0xd/0x20
> >> [  610.481403]  ? nmi_handle+0x5d/0x120
> >> [  610.481410]  ? mvs_int_rx+0x81/0x150 [mvsas]
> >> [  610.481423]  ? default_do_nmi+0x69/0x170
> >> [  610.481428]  ? exc_nmi+0x13c/0x170
> >> [  610.481432]  ? end_repeat_nmi+0x16/0x67
> >> [  610.481443]  ? mvs_int_rx+0x81/0x150 [mvsas]
> >> [  610.481457]  ? mvs_int_rx+0x81/0x150 [mvsas]
> >> [  610.481470]  ? mvs_int_rx+0x81/0x150 [mvsas]
> >> [  610.481483]  </NMI>
> >> [  610.481484]  <TASK>
> >> [  610.481487]  mvs_do_release_task+0x3f/0x90 [mvsas]
> >> [  610.481501]  mvs_release_task+0x13e/0x1a0 [mvsas]
> >> [  610.481516]  mvs_I_T_nexus_reset+0xb2/0xd0 [mvsas]
> >> [  610.481530]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> >> [  610.481552]  sas_ata_hard_reset+0x48/0x80 [libsas]
> >> [  610.481575]  ata_eh_reset+0x2e5/0x1090 [libata]
> >> [  610.481631]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> >> [  610.481652]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> >> [  610.481676]  ata_eh_recover+0x2e6/0xe00 [libata]
> >> [  610.481728]  ? __wake_up_klogd.part.0+0x56/0x80
> >> [  610.481735]  ? vprintk_emit+0x207/0x290
> >> [  610.481739]  ? smp_ata_check_ready_type+0xb0/0xb0 [libsas]
> >> [  610.481760]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> >> [  610.481783]  ? smp_ata_check_ready_type+0xb0/0xb0 [libsas]
> >> [  610.481804]  ? sas_ata_wait_after_reset+0x80/0x80 [libsas]
> >> [  610.481824]  ata_do_eh+0x75/0xf0 [libata]
> >> [  610.481876]  ? del_timer_sync+0x6f/0xb0
> >> [  610.481884]  ata_scsi_port_error_handler+0x3a8/0x800 [libata]
> >> [  610.481938]  async_sas_ata_eh+0x44/0x7f [libsas]
> >> [  610.481960]  async_run_entry_fn+0x30/0x130
> >> [  610.481966]  process_one_work+0x1c7/0x380
> >> [  610.481974]  worker_thread+0x4d/0x380
> >> [  610.481981]  ? rescuer_thread+0x3a0/0x3a0
> >> [  610.481987]  kthread+0xe9/0x110
> >> [  610.481992]  ? kthread_complete_and_exit+0x20/0x20
> >> [  610.481999]  ret_from_fork+0x22/0x30
> >> [  610.482009]  </TASK>
> >> [  665.286198] NMI watchdog: Watchdog detected hard LOCKUP on cpu 11
> Could be due to the libata deadlock without the recent suspend/resume fix=
es. Or
> this is yet another adapter that was not tested for suspend/resume. mpt3s=
as
> crashes the machine 100% of the time as well. I had no time to dig into t=
hat issue.
>=20

The reporter on Bugzilla [1] said:

> Hello again,
> 6.6rc7 was unable to resume disks from s3 as expected.
> Basically mvsas does not resume the attached devices at all.
> The suspend/resume logic was never implemented and nothing happens on res=
ume.

It looks like mvsas driver doesn't have S3/S4 logic at all, right?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218030#add_comment

--=20
An old man doll... just what I always wanted! - Clara

--49r+na6rsr85JO8L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTpzygAKCRD2uYlJVVFO
o3lgAQCO2I06dp3tSCfgyPMSkhPCKYLGwbw1EMz4SsJQrBHG5gD/XjTeHqkdFhA2
Av6UF46D9/8gD1PcrEO0lJ6DLUwcEAk=
=FVPY
-----END PGP SIGNATURE-----

--49r+na6rsr85JO8L--
