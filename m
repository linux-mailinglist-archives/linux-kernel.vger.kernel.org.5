Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCE797DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbjIGVVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjIGVVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:21:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20723.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::723])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8575F1BDC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnLBKuEjs1lXi2y4KyH+KWxdgwL0PTHyNskG2d8UxjvAytsL3/31fmC/T67CKt0anN9yXH6BaUuPZZ0ClIBlEcaCCEn7u1Dj8jAUVtUJiv5k3kuS+dvmV3xywiFozw5JQEudyZPrKg0+OTOqtqO+86snc+qq+TJsGLUjNH6nfPoBEp9xZ8Oudoio6KTQHDBZJ3XDfiYa05gHE7Htv/OjgkPnj9u/DL7bujPS+WMjGPTZ7Ej2OT5Rk0QWHAkea0RUjNhaNiZG3VW8Kd+3TGUIpgTX2vNfV7+33juxozVczm/ehb5xj8sgUyNFSS3Ms1eyBXta8nfhSL3zNWfXyAUf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiScLKDwYOs8LTOZLk+0Q6kEvdyI9mG56NI4YEi1doQ=;
 b=Ye0kZHkjMTcAHwGRDjJcdTBcdYOiPjp7rJcA7wQ06Q8vtAba2hCQ90pHkUC7C70EvEH//PISYxsf3VMi/Ll8gU5lRFULvKHQ9WLLUVF67EvKxQhaqrysI465ie7CwXoElTQ8JAojv0SnpLcldWVlSFTbqIWe6bMbLT3FZ8ui4LicxeaPLxElodndsma86rl53K44YkXtSsXOspNQM3cb2aXDjsfjhSRSoTH2QdZwKf+L3EyeeU4drkSARRZSkVoWr7JjVM5vziaEPmwMZ5KTsUv0n0BL/b0MFwn/1sxFPTKuozOgg1zHXZ+e12bwvnw0ijTEC3ny+F4E+q1NrsR9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiScLKDwYOs8LTOZLk+0Q6kEvdyI9mG56NI4YEi1doQ=;
 b=aqh8zgskdnMeZWszx4k+Swfvx2gZUQj+/7Y5YpfrBtnpvnYnzhREnJZ9EoMKo/dULvxDcwmI2YKulFglxyAe5+xtyDGcXxVJbyLgGeCjejkoM546omdZHbCkhQJi7b3LeDKAhkb7FWuYadWOYoqIvX83GJkUPgTW1d9twddyRro=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 21:21:02 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::c89f:4b16:5fd5:11bb]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::c89f:4b16:5fd5:11bb%7]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 21:21:01 +0000
From:   Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: WARNING in vma_merge
Thread-Topic: WARNING in vma_merge
Thread-Index: AQHZ4coQUBVDrMMgIka4rIJ+gR5RMA==
Date:   Thu, 7 Sep 2023 21:21:01 +0000
Message-ID: <BL0PR11MB3106699B27BB7C5FA07198BFE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|LV8PR11MB8558:EE_
x-ms-office365-filtering-correlation-id: 12ec1385-b19b-4e16-448f-08dbafe85663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgR6nf7s/dVjdvS6MhK2VTHfUt2rlZZDn1IXLZ4BqvDLdFCE85Ke6TrRbPEjv+C1bEsofAketO5gcvwJascLry5XdymY2nnXMPNwfvnt5RrRmVPCF3evdsR5ivapXzhcz1jTiuUysXc41VVfn9GMu/ASLRSyu2G9ggF/2A3CZfbSITRWJepyqbwMd4uXjhNqQWPjibrJILHsCeRWKS+OnFWJaUPYSJKY3z7S+jp9ckp4pshPYTWko2GHF9aw8C9NrsaIxCLgzPmiwXbGP1jIiA1iopiRMwDkpTXr12bQqz1TGqGSk8EYVpuKclv05RkUdAOgaNM6+e4izMLBdAlWYc+AaYrjYU7+B/1DEG5uMck33W37dcED3T+uFTf9Bo8GR6BmON0Yv7/uMRLdJSAdHSqm5PsnIGvR3dwgfNZAXId5JgKv7NMD80JvvSYwWYmFukC2SDXudMC6DtnUygSytMD7pQw7oOFW8ThBFJrmnLm+8rboZ3/uz8v4NPpAQV2NN+GRtegUHAe/Ca4utzAs3nEkKHFXC6vykwyb5Vme27BDPwmnKM0Whcq4p0B27Qa+PphxoPAZ8jZXhrksyDHteHtWjV+7CcoyVunNtzD/o/GYwrgMjnrsHLuhOpOtPCM/Fk+BeymOf/ItqxkyLPpSOl8tQrwmN2wLpOqwuKVgQpNnMZSmEZ/oIALCHVEGrfCdSz0elzfVs6UXyJ/PcaWHMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199024)(186009)(1800799009)(91956017)(76116006)(66556008)(66946007)(66446008)(66476007)(64756008)(4326008)(5930299018)(5660300002)(52536014)(7116003)(316002)(786003)(54906003)(7696005)(8676002)(41300700001)(8936002)(75432002)(9686003)(6506007)(83380400001)(110136005)(26005)(71200400001)(55016003)(966005)(45080400002)(478600001)(2906002)(86362001)(33656002)(38070700005)(38100700002)(122000001)(58493002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LawUEraf25poCrHwm3Eb664lyXdAqu4ROG/Rf5E/Ne/F63tlsNTl2q40tm?=
 =?iso-8859-1?Q?XFfTxlL6M8gzUzqNoL7+7lcpVetNcGJ3oHIBIKlDlmfDhEqx/+IVqK/doB?=
 =?iso-8859-1?Q?J2ek2/YM4zfjOc1F+IB20UjCMz7B9e7Z2Mzk8IuphCRxcx6ZR8ugJno6/8?=
 =?iso-8859-1?Q?vtrhMPvUiYJsX5GLO14EGoQ7cqHv0PgDYIqFUpfxsSK0GgeC19MaDK4AO1?=
 =?iso-8859-1?Q?Vo76PiKBizqup2NrS2PkB5usCmNkqs8UdAI4Zjdth8roGuw8BqVHSrWK5E?=
 =?iso-8859-1?Q?y4/bfH6WBrQabLOzGkKkzK5cb3aYFBgmKRWklsu/+xs7hvrWLEH97CJOgE?=
 =?iso-8859-1?Q?3uXeB45EcbhtuTljKzB1ugAO3Q5U1xyfTplRAVtuRx4mwY88K2xSKaPPsM?=
 =?iso-8859-1?Q?Xe10S4THTGcSL/Oa1wLMB1XHBLoYwYJYOCayu00k+r1QGRhqXxNrkNMxQF?=
 =?iso-8859-1?Q?9xVjZeolj5Ejh+f4Yr0IsCclq0JLa8SSpqI6uC6xTvHYChU72tpUgJ0pis?=
 =?iso-8859-1?Q?AcFV4GNlB5e/UaTAVZ3xiT8KcLIFxzoG5KnFS+bPFPf2IG9rpDQHdjGxA+?=
 =?iso-8859-1?Q?WhIXAf4yr0qpTGUJ5ngB2I/b10zA9ASXX9kfMfXBU9kDvMWRlFhtMDwa1I?=
 =?iso-8859-1?Q?pmQHzBYn5QEPKSwJi/Gk7kizMlh+jeNknIHQW7ZJ3MXR4bX0281njktHyH?=
 =?iso-8859-1?Q?6pZoyWmzWxrqptphPdTnQZop5xkDV3/WjVDa7ZzhMYhPQsHHA5csGE/E3z?=
 =?iso-8859-1?Q?K+BV6aQVHmLXWPB2DiSAw6TpvPTpLTUbnM2XnMELyJuskvIRt7UdkIDmYQ?=
 =?iso-8859-1?Q?la7AHbDC+5ig0peTZmKQ5vuYNojTjbuQ5chjYRdqi60lG0S8BYCRhEdMJt?=
 =?iso-8859-1?Q?KX0hKoWWLbmFaYGMNkE7DoGHjrT56NChcLwP92fQB2nJkS72MD0E0hnePR?=
 =?iso-8859-1?Q?Y2SpoYHgfPruAIULIcIya/RPlzmvYXMlyziIwtJ3a/hTyryA/Fqxfa7THc?=
 =?iso-8859-1?Q?atprOgdTPQ+DcptZIukWo0Geu63cdOM5PxSge8HKeobaYKHb/0I8N2BxJz?=
 =?iso-8859-1?Q?TjhWf9sZ+YTYkAZJfMZ3uR+c0wXVY4O9O+aTZIp5J8ZEV+ZXX5TypRsROo?=
 =?iso-8859-1?Q?ermwL/8LXdc+zptrnuPqSUlwZDOH92VZU7mdGoRVBvm9FknX/1rbMzUQxN?=
 =?iso-8859-1?Q?xgPRH8IcelpyUNUAGZu7wyNDXnbh74jxnKnAg9X+9O+oEAcmOPijG+bPI3?=
 =?iso-8859-1?Q?oVyFTeYMZqCHM7GNOOouWNF+Sju3VnqMe0gdMHIJmXRYK4GkKlEJg2Yr8l?=
 =?iso-8859-1?Q?P95AyehBJp3HbIdU6eTNzWLyoWz2845IOdZNYVAmPzk7vFw3cFHJv5PYXq?=
 =?iso-8859-1?Q?q44ZxrM5XOvItRSEcRDXmDMD0WDfflOocEf6tosC3lmVlxXI7sFLv5WMXC?=
 =?iso-8859-1?Q?MCm1UqgYFrofmZuXSAJQjWL4XkGGzsm9LZOjY1w9DX25sU00JAdpu+jhwR?=
 =?iso-8859-1?Q?GNeMMwQbgCwGyTKj4cp4cw8qlIw41YFFcWmn+Kzmnsj4+opecvoeL/wUYj?=
 =?iso-8859-1?Q?NuEgrvATlwxXNOqgpewUaQVg30lnzGl2K4bendNDkm28lp+k1yXgSNOyyQ?=
 =?iso-8859-1?Q?qWUrlrB+/8h5s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ec1385-b19b-4e16-448f-08dbafe85663
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 21:21:01.9600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +XSDJiww9rYHszmo4QjYrzXJe0V+5EbGWhf7rSImuxuSZuGWaxuNbQxhMoWdZ35kQvappPlcJrZiznDyUDh39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8558
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, dear maintainers,=0A=
=0A=
We found a bug using a modified kernel configuration file used by syzbot.=
=0A=
=0A=
We enhanced the coverage of the configuration file using our tool, klocaliz=
er.=0A=
=0A=
Kernel Branch: 6.3.0-next-20230505=0A=
Kernel Config: https://drive.google.com/file/d/1pJaf39GNF64KX1Ac_sCfA89x13-=
IEGbB/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/12qTKfwYWDB2U3vCJoCIQYZSkmNxgmC=
Wa/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
------------[ cut here ]------------=0A=
WARNING: CPU: 2 PID: 20500 at mm/mmap.c:965 vma_merge+0x35a/0x1a30 mm/mmap.=
c:965=0A=
Modules linked in:=0A=
CPU: 2 PID: 20500 Comm: syz-executor.7 Not tainted 6.3.0-next-20230505 #1=
=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:vma_merge+0x35a/0x1a30 mm/mmap.c:965=0A=
Code: 8b 45 00 48 89 de 48 89 c7 48 89 85 08 ff ff ff e8 cb e1 bd ff 48 8b =
85 08 ff ff ff 48 39 d8 0f 84 05 0d 00 00 e8 46 e7 bd ff <0f> 0b e8 3f e7 b=
d ff 4c 89 fe 48 89 df e8 a4 e1 bd ff 4c 39 fb 0f=0A=
RSP: 0018:ffff88804c517af8 EFLAGS: 00010212=0A=
RAX: 00000000000001d4 RBX: 0000000020ffe000 RCX: ffffc9000eea2000=0A=
RDX: 0000000000040000 RSI: ffffffff81cfd44a RDI: ffffffff81cfd435=0A=
RBP: ffff88804c517c20 R08: 0000000000000006 R09: 0000000020000000=0A=
R10: 0000000020ffe000 R11: 0000000000000001 R12: ffff88807d091dd0=0A=
R13: ffff88807d091ec8 R14: 0000000000000000 R15: 0000000021000000=0A=
FS:  00007f2389746700(0000) GS:ffff888119f00000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 0000000020000000 CR3: 000000004ae38000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 userfaultfd_register fs/userfaultfd.c:1485 [inline]=0A=
 userfaultfd_ioctl+0x3915/0x4280 fs/userfaultfd.c:2050=0A=
 vfs_ioctl fs/ioctl.c:51 [inline]=0A=
 __do_sys_ioctl fs/ioctl.c:870 [inline]=0A=
 __se_sys_ioctl fs/ioctl.c:856 [inline]=0A=
 __x64_sys_ioctl+0x1b0/0x220 fs/ioctl.c:856=0A=
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]=0A=
 do_syscall_64+0x3f/0x90 arch/x86/entry/common.c:80=0A=
 entry_SYSCALL_64_after_hwframe+0x72/0xdc=0A=
RIP: 0033:0x7f238868edcd=0A=
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007f2389745bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010=0A=
RAX: ffffffffffffffda RBX: 00007f23887bbf80 RCX: 00007f238868edcd=0A=
RDX: 0000000020000040 RSI: 00000000c020aa00 RDI: 0000000000000003=0A=
RBP: 00007f23886fc59c R08: 0000000000000000 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000=0A=
R13: 00007fffc9301f7f R14: 00007fffc9302120 R15: 00007f2389745d80=0A=
netlink: 9764 bytes leftover after parsing attributes in process `syz-execu=
tor.0'.=0A=
 </TASK>=0A=
irq event stamp: 603=0A=
hardirqs last  enabled at (613): [<ffffffff816ff504>] __up_console_sem+0xf4=
/0x180 kernel/printk/printk.c:347=0A=
hardirqs last disabled at (624): [<ffffffff816ff4e9>] __up_console_sem+0xd9=
/0x180 kernel/printk/printk.c:345=0A=
softirqs last  enabled at (436): [<ffffffff8154f646>] invoke_softirq kernel=
/softirq.c:445 [inline]=0A=
softirqs last  enabled at (436): [<ffffffff8154f646>] __irq_exit_rcu+0x196/=
0x230 kernel/softirq.c:650=0A=
softirqs last disabled at (431): [<ffffffff8154f646>] invoke_softirq kernel=
/softirq.c:445 [inline]=0A=
softirqs last disabled at (431): [<ffffffff8154f646>] __irq_exit_rcu+0x196/=
0x230 kernel/softirq.c:650=0A=
---[ end trace 0000000000000000 ]---=0A=
EXT4-fs (loop5): bad geometry: first data block 4294967180 is beyond end of=
 filesystem (512)=0A=
netlink: 9764 bytes leftover after parsing attributes in process `syz-execu=
tor.0'.=0A=
