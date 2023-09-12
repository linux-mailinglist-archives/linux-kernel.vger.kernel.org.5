Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4823879DC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbjILXDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237978AbjILXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:03:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2093.outbound.protection.outlook.com [40.107.220.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C0E1730;
        Tue, 12 Sep 2023 16:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elbS3tvM1OPMxORrVsWSacXWBzk/2s0RwkpYpyFi48XDYobNWDGyeLjp9HnMguwn5hvXeVXOx79NVzqD3tesXoWUGTaT/3c6bPFLJHPy+Yhjic5l1YGt7D2+e0ttDh0DIxjsDF+kZviNuu0vFG7Q0K1eIAzAC+wV9r+aIck6IfDoTyhJjChrQyei1hppSf654R9n1esGUrfEOIF/aJFVHcUKGCO3bWF97I8/LiYrpYDV78GObaEjatekr+dB/gXvI3x3kv7usSrI+gP1TcGoJHUJSzhmMNassbDi9K+2tR7cQuPFh3zrpj4Xq4AdqZT60v2POQ0ioZlzmQImr0TOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAitSeQGvbuf+HrTf9hE/ELjNYbu1vPGpfZVJNvfNfc=;
 b=V4nFG0+3oikAOUFonN4m96hcYZ92NlN7j4D1oLxycDkuiucdvw2zAi8VDwCY8vR1jn5oJtIQVEGYpVURSUg8raguTvUzCvTB1hmnzUfqvke2rJbDMdCf+VyfoRBMDxUiviPz59S4j4o1e75sqb1QT97Ti5a210SIUd353aVcGEcCiDIXWM68mPhpwFfSQkmDYyv0nxJpouLB5U60JESur5Xr4rH1b6LT5Je/1rpIB8QSB1alSVmOJQBarAEASVN5/1UThfjlOvHiQmfxqi80n6aWtN8md6m9N4RSUCgUyecM7cSecoLtesJ63I8T6cZED1+Z0yPa0wwOaQxW8kpwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAitSeQGvbuf+HrTf9hE/ELjNYbu1vPGpfZVJNvfNfc=;
 b=edUlFH8XOTQtmftnnLRjPybcy/ArNWZ9CXFY2PRyH73ZpFQBdwnhNsx+jo9QxU4GBkJguRNbdH/Y7ldjwkaal8Pep3DzVqBQkwVSVdGtiLi4KOMx2n8XW6aRXoITUAk0V2+Ogy9K3+mVmdaG19ni+t6yWSXrOJ/l+uZwVg3fsJg=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by IA1PR11MB7367.namprd11.prod.outlook.com (2603:10b6:208:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 12 Sep
 2023 23:03:14 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 23:03:14 +0000
From:   Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To:     "reiserfs-devel@vger.kernel.org" <reiserfs-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: kernel BUG in do_journal_end
Thread-Topic: kernel BUG in do_journal_end
Thread-Index: AQHZ4dDtD7lBkaxOYUOluJn3mK5A6g==
Date:   Tue, 12 Sep 2023 23:03:14 +0000
Message-ID: <BL0PR11MB310674FAB1189B6D9CB0B50DE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|IA1PR11MB7367:EE_
x-ms-office365-filtering-correlation-id: 7a4ef4d3-7d32-4bcb-b819-08dbb3e471c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1cFhXGxTCoeuDXMtNMLwgJ9HL7zELEh/kFKKh4yAuYH7q9G0J+yCT4oPuMQyxqfmGNdV+lkKgNAL0drhc7xNaMf/DbkJmbPeqRpPNJsKE8++RAt0MakYsJxxa4Ik9HP6hxWfMAwVEdiMk3fHUBmg57ZrxNwCOfSTxqzHQhRJw2hv8unj7OXWs2yiHub+LvfSq01zhZiZT1WenotJ/XTL/+zP7ImAeGMh2UTMO8AfJx48eH3cOYidy+Ub06/Hf/pA6NV7GCm1klI4NFD9scz/rKM0mNOZfuWny/SxP02bkuWo6dVP49mhiCLn34GuO+A21JmdYjObUk5Z/9zgiUzVIu+O6VYx0cLLZhlbyamCO5AoepRcTaMUP3GAUE6+pT6gDJL0nSAiPHAfRgHRlxMBBMAFN1X3GYJweKAhHeXDa+McS2ohckS78JGiOCHs1cbQyNLSGxygUnP0zXklcrMtP0w3paB/iHJLA2/PBvjhxYACJwuXt1HCUKg6qjcpNsgI5AK2LVQWWJQf0IYWx1OLGq1XjmnErwxpEgfHW4ZeEso25ewKQR4ATSZKvizE9gy5gzIdxm+9BWGI6aVv8aoy3qxSERvqCmmaO605dtYofW/fw0PAZRY8Xmvhso07P6s/ZvQtD5hfvv+svozZ46EIwluywugERWDGNjskxbAgO38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(71200400001)(9686003)(33656002)(6506007)(7696005)(45080400002)(41300700001)(83380400001)(66556008)(786003)(966005)(64756008)(66476007)(316002)(4326008)(54906003)(66446008)(66946007)(52536014)(8676002)(2906002)(110136005)(8936002)(75432002)(38070700005)(55016003)(86362001)(38100700002)(26005)(478600001)(5660300002)(122000001)(76116006)(5930299018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X2kM7Ie316bJ1Gz0JpHC126/vEakwS7Dc5eIqrGOgUVKyV3rGvO52OtWC8?=
 =?iso-8859-1?Q?BXJVOC4b1ILYU+vBhwhgjUFFkULCu6/dzcXNa2UaPTvPJFpaSLv0dkCGEZ?=
 =?iso-8859-1?Q?OKxIi6H/esUispJoQ2KJGcorCkzAdKSlUzXtpJrFFH02lWkYoJcBF6ODEH?=
 =?iso-8859-1?Q?16YBff6Bc+rvhFVpYZiKM5jSJh+CNi01bTUp8J6a5o+YwmfDvtwrEIMW8T?=
 =?iso-8859-1?Q?CchQV3i/9dMZ72YHyfNGQULP22JXkrtwNi6ItOW/Wcjk+HW6M0javxdH2G?=
 =?iso-8859-1?Q?9z+BPEL2Fy9o7/3qQFIY/MOOe8e7UDhUpQwwDeYbFeg1thlvLIKME557FA?=
 =?iso-8859-1?Q?XNMQk+xAORmO1TSi7VkMNwfWxkB7FGc1NvygbIrT86nb/YYgX9PLFLAczk?=
 =?iso-8859-1?Q?wUfgdetfQ664PIuodSvCRpQfDsbJuKYp59rCy7TJQq3kSZ94Jgg2dIGU7u?=
 =?iso-8859-1?Q?u4bmEIuXV83o8FaL3YG0d2g8i7l5asDzElbZ2hY2Vu+AcxSCb/2p4cwFZ2?=
 =?iso-8859-1?Q?o+kf5JFWPpDwRB2gTlVC/XPgCFGr/QoVBvri2DI3BYm6A1NxAHG9Nszf6P?=
 =?iso-8859-1?Q?XdX/nVWg51WnhjdBtNBvcW10uN4SpzfZlPzxS1i2L7nbCTX9tQzFxcTBc/?=
 =?iso-8859-1?Q?fp2XNFj5SjmoUZO4KCf59tNGeiJTPx2eW8ZvTBP4U+IEQRIKGKezJNIj8B?=
 =?iso-8859-1?Q?dpi8D5CYXd4Jw9CGai7XNL5XvA72oYf1MWOYShW04P5OKmvcZFrChsr7Ua?=
 =?iso-8859-1?Q?bWWn8xJELx002wDxyoWOsLlqwrr95efVL7M9rCRlbJoIPt/Ys8amEeeiaC?=
 =?iso-8859-1?Q?dxJcJri5n1kSBBHpJD67V/AzE13MAqNjNRUmRR6aWA0WurqTGqhQ3wDxI5?=
 =?iso-8859-1?Q?8n89V8x4xHpeGbMR0gb8wL4KY5zWbLtafMHq6ozGBWUEnrY3oNt6j8Epul?=
 =?iso-8859-1?Q?1y1vGc44vYecIlFCWxsbWyJs7SE18Sn37AWl5nAJ+sMyuG/LPWmdEDbh+A?=
 =?iso-8859-1?Q?ACW/KGpit/gknjAm6vMJdCzvtfRePHAGbOc95x+N0evAXuyyheCoCpIigs?=
 =?iso-8859-1?Q?q5SJSlq5M+EjCJS+zF/VCWOm05iqmj/vybDnoLYBMapSDAJyvc9oBZOYJ9?=
 =?iso-8859-1?Q?LmYJI8c9nZlDWy2jUiWa8pU4yX12yPXi69ePpaLEBgObivGwAh7VgA/576?=
 =?iso-8859-1?Q?s+XEXtDqAeuWK9jSmBcCXpeSiw5NHp8KJAATpWY08IPkabrWlFgEoyo1MV?=
 =?iso-8859-1?Q?uD8lkxAxbDroeufhbLk3ofrwk/a4/Ce8MxHD+gEv0Rrj66BlKOCSBblZfj?=
 =?iso-8859-1?Q?+l6KovbTDj9hRJXcArNJYAgC1LIyhqCujjADhyAl3JhPoquwSHsJMd3oNR?=
 =?iso-8859-1?Q?JPjECKv6ETHtfC31vdgUj0/LwSU1rFsTySu4CH2SWY1Vw6zWnP7IM8KN67?=
 =?iso-8859-1?Q?PW187Hns8Fh2vOsAitmcPAJaGjWsVQxh5Rn2DNO1WpgPElqnXiBH0ju4IL?=
 =?iso-8859-1?Q?Dz2Pr3L+eKIYjVPBc32OnYvF9NVYCa7lClzSEKE6+5IvtHp9HxQq843+/Y?=
 =?iso-8859-1?Q?1KgLU07VccAi7uk9Uy0nvxTvU6x4NVv6RnkeXcpy+v5ogkVkAdMd1pQual?=
 =?iso-8859-1?Q?7KMgkyMeSuROY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4ef4d3-7d32-4bcb-b819-08dbb3e471c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 23:03:14.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VD33MQIRnCVsjS4+pTg3xuiEnBQtFoSIGazAXxHz7ZS/0OQO+ZuOuH+tS28gyu4koEQSZOeCW8oXu/+XXJFVWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7367
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
Kernel Branch: 6.3.0-next-20230426=0A=
Kernel Config: https://drive.google.com/file/d/1-RlEeQ2ltqar6W2DptSUYYmrZzB=
jjcQI/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/1xezJdfFWY-Q0Djh6x5LQqNq-9c_ru8=
c5/view?usp=3Dsharing=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
------------[ cut here ]------------=0A=
kernel BUG at fs/reiserfs/prints.c:390!=0A=
invalid opcode: 0000 [#1] PREEMPT SMP KASAN=0A=
CPU: 1 PID: 7350 Comm: syz-executor.2 Not tainted 6.3.0-next-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:__reiserfs_panic+0xf7/0x150 fs/reiserfs/prints.c:390=0A=
Code: 68 ff 4d 89 e8 4c 89 f1 4c 89 e2 48 8d b3 a8 06 00 00 49 c7 c1 60 5f =
92 90 48 c7 c7 00 55 e1 89 e8 0e 51 4d ff e8 89 ff 68 ff <0f> 0b 49 c7 c6 a=
0 53 e1 89 4d 89 f4 eb c5 e8 76 ff 68 ff 4d 85 e4=0A=
RSP: 0018:ffffc9000f1ffa00 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: ffff8880ad15a000 RCX: 0000000000000000=0A=
RDX: ffff88810cfd9dc0 RSI: ffffffff821888a7 RDI: 0000000000000005=0A=
RBP: ffffc9000f1ffad0 R08: 0000000000000005 R09: 0000000000000000=0A=
R10: 0000000080000000 R11: 00000000014aed60 R12: ffffffff89e1bee0=0A=
R13: ffffffff89e1c700 R14: ffffffff89e15360 R15: 0000000000007b1a=0A=
FS:  0000555557345980(0000) GS:ffff888119c80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 000055555734edc8 CR3: 000000005f30a000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 do_journal_end+0x3f22/0x4ad0 fs/reiserfs/journal.c:4149=0A=
 reiserfs_sync_fs+0xfc/0x130 fs/reiserfs/super.c:78=0A=
 sync_filesystem fs/sync.c:56 [inline]=0A=
 sync_filesystem+0x109/0x290 fs/sync.c:30=0A=
 generic_shutdown_super+0x74/0x480 fs/super.c:473=0A=
 kill_block_super+0xa1/0x100 fs/super.c:1407=0A=
 deactivate_locked_super+0x98/0x160 fs/super.c:331=0A=
 deactivate_super+0xb1/0xd0 fs/super.c:362=0A=
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177=0A=
 task_work_run+0x168/0x260 kernel/task_work.c:179=0A=
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]=0A=
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]=0A=
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204=0A=
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]=0A=
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297=0A=
 do_syscall_64+0x46/0x80 arch/x86/entry/common.c:86=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7fdd95e9173b=0A=
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3 0f 1e fa 31 f6 e9 05 =
00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007ffcbd482888 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6=0A=
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fdd95e9173b=0A=
RDX: 00007fdd95e28c20 RSI: 000000000000000a RDI: 00007ffcbd482950=0A=
RBP: 00007ffcbd482950 R08: 00007fdd95efb54e R09: 00007ffcbd482710=0A=
R10: 00000000fffffffb R11: 0000000000000246 R12: 00007fdd95efb527=0A=
R13: 00007ffcbd4839f0 R14: 0000555557346d90 R15: 0000000000000032=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:__reiserfs_panic+0xf7/0x150 fs/reiserfs/prints.c:390=0A=
Code: 68 ff 4d 89 e8 4c 89 f1 4c 89 e2 48 8d b3 a8 06 00 00 49 c7 c1 60 5f =
92 90 48 c7 c7 00 55 e1 89 e8 0e 51 4d ff e8 89 ff 68 ff <0f> 0b 49 c7 c6 a=
0 53 e1 89 4d 89 f4 eb c5 e8 76 ff 68 ff 4d 85 e4=0A=
RSP: 0018:ffffc9000f1ffa00 EFLAGS: 00010293=0A=
RAX: 0000000000000000 RBX: ffff8880ad15a000 RCX: 0000000000000000=0A=
RDX: ffff88810cfd9dc0 RSI: ffffffff821888a7 RDI: 0000000000000005=0A=
RBP: ffffc9000f1ffad0 R08: 0000000000000005 R09: 0000000000000000=0A=
R10: 0000000080000000 R11: 00000000014aed60 R12: ffffffff89e1bee0=0A=
R13: ffffffff89e1c700 R14: ffffffff89e15360 R15: 0000000000007b1a=0A=
FS:  0000555557345980(0000) GS:ffff888119c80000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 00007fe5d85c0000 CR3: 000000005f30a000 CR4: 0000000000350ee0=0A=
