Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279F079DC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjILXCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjILXCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:02:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2100.outbound.protection.outlook.com [40.107.237.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78502189;
        Tue, 12 Sep 2023 16:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdTFlkROadiRk+irpLDx3oMpReRWiuy0jO4TKTTK5fBwPwoJNEz76SlCLuZauoD2tuduCAVLtn2AvwtRbDgwJypR56gpSA2IOKHJAUMdZjjeSqiLFjDJHa+nAokEIjBrLRg0LjC2YlWkKeeuC+gmCfjun5i2JDGYWiKpOyltOmP19m4NbZsaysNygrEb4FrIj5z9VjXHaez0ZInqTi/QK6eyCAJbtHC/OZ3wJQeDO1fpKj6XxDi2HKjr5J4ZgPh4OqjpvNvA7O5JWlc3MIKyWOismEh3x6bBVV/ZJAXSqqnM1uXmJo1x6fAGeHQa/th8MhPAxFvuy39xJcsqPwgwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pis3+gxdcsBGcv08cPk60CbSNrRQB9ePtNCCbM/yaXo=;
 b=etqvm+Dli3c2AYFzE1ZIPyTw/oONjAVdqGIm2u7fWOh4LoVYmgskzfJKBHbf/CTZYfZDiVdA9O/LmvKgosXkHo6z6k0b8iZy6wsPaTcZUEDpmOlsIsAJcRw5ICH2+xmCXKrisgT4nVHM3GLDudU4paUL91GkVEryq0lnunT13NpfumWS17bp7LF2OiTXQHu5+/tWhHsOdUnLFGB6j/2WGF6AW4FqqCtyqYmpspP50dloDZbs6gmHH6mLmYpTzJbDua7nJ5uLK/NN8vLlN8ApqKPFZUYbf9ErF4K+o1oamp5Us8eZpoloKfMY48H3y28R0YTHBU1OkQXjIpNaTTO7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pis3+gxdcsBGcv08cPk60CbSNrRQB9ePtNCCbM/yaXo=;
 b=pWFUMDLtjZ0yc94jVutry7v3jjST7GMlH9GymaawtFWUGgCEcSrFewBjSfhBak2Lgpv8IK8wv09iXwRnvAfR8DAZ2P1udslY+p81A8Ka+ggrVxSfdYtnmkabxhfPpeeynWVVqBquFqz+TYbSr7fH9EID6Fx0oY4Xr/HjK3l8aBA=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 23:02:30 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 23:02:29 +0000
From:   Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: KASAN: slab-use-after-free Read in hci_conn_hash_flush
Thread-Topic: KASAN: slab-use-after-free Read in hci_conn_hash_flush
Thread-Index: AQHZ4cwTx5V9KwihlEKuTOYkI+Rs1Q==
Date:   Tue, 12 Sep 2023 23:02:29 +0000
Message-ID: <BL0PR11MB3106630748E9A97C1E32A14EE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|DS0PR11MB7531:EE_
x-ms-office365-filtering-correlation-id: 35cb1cbb-2adc-4f95-18f5-08dbb3e45729
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RvvIP12PqJSqxt+AouVkJVsJomZSXJBnN08GelUnzvmmjAhORtsl3WXkpknkQmTqOm5xbs47qh8Gb8XZRmt1oxLg9as1yJ0NhheiMGoAJAuhjOJ7ugU5/UfnZ5oheFIYei5e+CdraLlRUqzKTfcpKI/xjIx56r6Njtj5oK9DlUDZYXeZ1/TyToEIegK1cm3QeaIiB4nyI891Lpb5g0I7r3cQgcvmJK1MjkAXF3tYsOpa4CpyVHH1W8wiw851yBE5tclTXXqCtoabz9gZYsyi3VSC5CZeesigplmMgRnPz1kddgeJBwlTd/V/zW5tlqgQvCbnHZZWG2Hzn/8tpICbnhUQglE73h1lSaw4hP87VjaxbqDq4j13iZ4fNeWj9e+MXLzSxpvqfndZ+kND2eUengiS/TDW8lYrMLsHL1anKmotaHoW47XaMUk6FapuN6IM7/vHuDfVNO6uzxP/vuqLGan9W9NMj1+PUBfavFgBoRD5zjaRTKmrYZCXNPeDHnNlbXJ0JYBNC8tEHZEbjKDLuTS4OYL8GulytC8C8SMvl4lydAXBbj7SMtpMuGLT2VdB+hXH2+UdmsD7DJYhkRM1fKRnrZ7CgahSBJQaWgnmqS/YT5TkLvIUB9oQ1oC0fI3PsNcH07+4/wRzKxIAqJec30Y53uiHFXhKX/Hks4pnPhfDf9mwH1SFofwbZ/pyf+GQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(346002)(366004)(376002)(1800799009)(451199024)(186009)(921005)(122000001)(5930299018)(6506007)(7696005)(71200400001)(33656002)(75432002)(38070700005)(55016003)(38100700002)(478600001)(83380400001)(26005)(45080400002)(52536014)(86362001)(2906002)(9686003)(41300700001)(64756008)(966005)(76116006)(8936002)(8676002)(5660300002)(4326008)(110136005)(54906003)(786003)(7416002)(66946007)(66446008)(316002)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FdRXJneFC5UlEJ8mVFtAzvb6TL/8RwmDzJ9zKKKqABbXVtnvX6YAYw8j8T?=
 =?iso-8859-1?Q?KnK24nxhXuxjh8d6KWMIiUdMYR+yWKbmBgBGkASFVGdkrjQa+e0pWC/ug1?=
 =?iso-8859-1?Q?j+kS4kIviPt/52Af962SKsnbSIVU6tBq2QmJUAvb8CKcE69KBbWUxHsKuw?=
 =?iso-8859-1?Q?0pngqYxqmJrHZuYU+0mxcOvY5V9LqGkISo3KTFtvMTGF6gjw5tBxGZVaOO?=
 =?iso-8859-1?Q?HxusWRBTagz150LyV2liszF9LYQI+u8KOe3QvZCrHkcssKeH90L8dn0wg3?=
 =?iso-8859-1?Q?dOZP+u40ltkfNEQbfua0LoXp7Rx5tpqmwZWW2jCuX3+suVZ2+mhG0XV8h0?=
 =?iso-8859-1?Q?GXC8inwsTmQZ6ihGowVaZrypm1P7H+WMCwp8Y6qciPe3v4BDSIoh3c5Dxy?=
 =?iso-8859-1?Q?uheAQyCGLzAtBTYe5Jfpi9hfu4HNRWnO+BqhuF/idNPdYY1j1g7+WhsZpQ?=
 =?iso-8859-1?Q?kqd93ImfpiQXTERzUvoDJEG428lrMWZ1PvLrDfzr2JOIA/hOXKTWGG7hi3?=
 =?iso-8859-1?Q?nIqRybpAVLlyLLCMLtkBhYNTyykxGVHfrgQmx/KikaUI1qOEMp6xtG00+Y?=
 =?iso-8859-1?Q?6g03uAhn+devfC9wVF5zo8ez3elekeBpSe+mqPpGNt5f2MeZ68g2Y0jR8G?=
 =?iso-8859-1?Q?t2F+FJzh3lyJjARKLD0kxjjqPXVpoxcTQOHJAuzE+6KLtydLX2GkXeSRt1?=
 =?iso-8859-1?Q?LaWDx3jDraV6Or+WO5lSaRt4ySZnf504eO7/AnZICLSfdwmLMuT1+gz6MA?=
 =?iso-8859-1?Q?Q6fo7zxUq5bU4mwPEEjTSeaw4gPsRQ6poBbWWNWJyg4y0CYmDLnMOqcXLF?=
 =?iso-8859-1?Q?mKjsY4ospVl7qxtNx1BNg5vM/3SmR7VWFDZdqxzgMTGEhetUi8C/wixrPL?=
 =?iso-8859-1?Q?XYkeXX0A1EdHI0GF6HqZAuiGVmdvLlssL76eFbIf14Y1NG5GCTzVEgLZd2?=
 =?iso-8859-1?Q?3unhFNIfNuVK0WFZrIMd+CQnogdaD9jlMZxJn8ijfDAmIfkWd4sdljJhDM?=
 =?iso-8859-1?Q?yqOiyMkEfPITRcq625QKhERF8+HADVohc93u4KHLZs4QHn625Yv+DGqC3s?=
 =?iso-8859-1?Q?78Rb+194Ns8u+Z26h8lyrbLDX8vBMJAndJh+ZPWA/mPEdNY2R5l6SK4+zI?=
 =?iso-8859-1?Q?bC2M2Vh8TAXBHF9vk/8rTtovOFh0EZxHL4DxiDc609yOm8/v+4O6/HHn/w?=
 =?iso-8859-1?Q?0b73jycxxsKD1++ZS0x5dbtmo0Oycqu1K26XVMBHSJVc5hLuqZ1t3iOQnJ?=
 =?iso-8859-1?Q?I7vr2AC2TCKMvFcs0SoY+xGXQC7n6RgJZhyuaRVwDIChQNUpFTNmm7ZXJZ?=
 =?iso-8859-1?Q?YRkgGGWIMz021V/xRHdHGbLDb71/FCetucdhH71XLBmGRkpDk9f3wcN0uL?=
 =?iso-8859-1?Q?SbQzR2Q0VR+v25pdBPargzjCVQSR1xepahRUHtpInuMfHHA9/y8E0VMhnr?=
 =?iso-8859-1?Q?tIlNc7fpPbpXRtm3rJozodVR90f3PDkcccvmUUu3hJMfpXRocwlENajguK?=
 =?iso-8859-1?Q?RsVeS7NPWJRXZw19DZxSie6Vf6Qk5zt3Cr/hnEXZfhBGhRgvQusCS5ytVK?=
 =?iso-8859-1?Q?p1r/TUngMZw6vTK5DFQ4a/vAdliQfnN87Y2zumMUISrd8NJrJZL/0Eq28q?=
 =?iso-8859-1?Q?gQ38bsF2GGdGk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cb1cbb-2adc-4f95-18f5-08dbb3e45729
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 23:02:29.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9HLBVleMVeiHLvNAfNUnfZ4Y2iNr2pAN0DBYrIh1Id/p9BSx46q6IJgXw860Da9/GjErueRXKZ/BhqqRw15YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
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
Kernel Config: https://drive.google.com/file/d/19nzVDVMtaTo8fv7RMtXDGYQzeRn=
Npp-r/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/1vzoYO_aW6XQqR6NAaJqvacOcJy9J6R=
-0/view?usp=3Dsharing=0A=
=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
BUG: KASAN: slab-use-after-free in hci_conn_hash_flush+0x1fa/0x230=0A=
Read of size 8 at addr ffff8880780da000 by task syz-executor.7/5990=0A=
=0A=
CPU: 3 PID: 5990 Comm: syz-executor.7 Not tainted 6.3.0-next-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
Call Trace:=0A=
 <TASK>=0A=
 dump_stack_lvl+0x178/0x260=0A=
 print_report+0xc1/0x5e0=0A=
 kasan_report+0xc0/0xf0=0A=
 hci_conn_hash_flush+0x1fa/0x230=0A=
 hci_dev_close_sync+0x5c2/0x1060=0A=
 hci_unregister_dev+0x1ce/0x4a0=0A=
 vhci_release+0x80/0xf0=0A=
 __fput+0x27c/0xa90=0A=
 task_work_run+0x168/0x260=0A=
 do_exit+0xbd9/0x2b20=0A=
 do_group_exit+0xd4/0x2a0=0A=
 __x64_sys_exit_group+0x3e/0x50=0A=
 do_syscall_64+0x39/0x80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7ff463e8edcd=0A=
Code: Unable to access opcode bytes at 0x7ff463e8eda3.=0A=
RSP: 002b:00007ffde1873c18 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7=0A=
RAX: ffffffffffffffda RBX: 00007ffde1874480 RCX: 00007ff463e8edcd=0A=
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000043=0A=
RBP: 0000000000000003 R08: 0000000000000026 R09: 00007ffde1874480=0A=
R10: 0000000000000026 R11: 0000000000000202 R12: 0000000000000000=0A=
R13: 00007ff463eeba70 R14: 0000000000000002 R15: 00007ffde18744c0=0A=
 </TASK>=0A=
=0A=
Allocated by task 24391:=0A=
 kasan_save_stack+0x22/0x40=0A=
 kasan_set_track+0x25/0x30=0A=
 __kasan_kmalloc+0x7c/0x90=0A=
 hci_conn_add+0xa5/0x1570=0A=
 hci_connect_sco+0x3e4/0xf50=0A=
 sco_sock_connect+0x2c0/0x9c0=0A=
 __sys_connect_file+0x153/0x1a0=0A=
 __sys_connect+0x165/0x1a0=0A=
 __x64_sys_connect+0x72/0xb0=0A=
 do_syscall_64+0x39/0x80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
=0A=
Freed by task 5990:=0A=
 kasan_save_stack+0x22/0x40=0A=
 kasan_set_track+0x25/0x30=0A=
 kasan_save_free_info+0x2b/0x40=0A=
 ____kasan_slab_free+0x120/0x180=0A=
 __kmem_cache_free+0xcf/0x280=0A=
 device_release+0xa3/0x240=0A=
 kobject_put+0x175/0x270=0A=
 put_device+0x1f/0x30=0A=
 hci_conn_del+0x2df/0x860=0A=
 hci_conn_unlink+0x25b/0x3e0=0A=
 hci_conn_unlink+0x2ef/0x3e0=0A=
 hci_conn_hash_flush+0x18d/0x230=0A=
 hci_dev_close_sync+0x5c2/0x1060=0A=
 hci_unregister_dev+0x1ce/0x4a0=0A=
 vhci_release+0x80/0xf0=0A=
 __fput+0x27c/0xa90=0A=
 task_work_run+0x168/0x260=0A=
 do_exit+0xbd9/0x2b20=0A=
 do_group_exit+0xd4/0x2a0=0A=
 __x64_sys_exit_group+0x3e/0x50=0A=
 do_syscall_64+0x39/0x80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
=0A=
Last potentially related work creation:=0A=
 kasan_save_stack+0x22/0x40=0A=
 __kasan_record_aux_stack+0x60/0x70=0A=
 insert_work+0x48/0x360=0A=
 __queue_work+0x5bc/0xfe0=0A=
 __queue_delayed_work+0x1c8/0x270=0A=
 queue_delayed_work_on+0x162/0x1c0=0A=
 sco_chan_del+0x1db/0x430=0A=
 __sco_sock_close+0x11f/0x640=0A=
 sco_sock_release+0x9f/0x2d0=0A=
 __sock_release+0xcd/0x290=0A=
 sock_close+0x1c/0x20=0A=
 __fput+0x27c/0xa90=0A=
 task_work_run+0x168/0x260=0A=
 get_signal+0x1cb/0x2460=0A=
 arch_do_signal_or_restart+0x79/0x5a0=0A=
 exit_to_user_mode_prepare+0x128/0x1e0=0A=
 syscall_exit_to_user_mode+0x1a/0x40=0A=
 do_syscall_64+0x46/0x80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
=0A=
The buggy address belongs to the object at ffff8880780da000=0A=
 which belongs to the cache kmalloc-4k of size 4096=0A=
The buggy address is located 0 bytes inside of=0A=
 freed 4096-byte region [ffff8880780da000, ffff8880780db000)=0A=
=0A=
The buggy address belongs to the physical page:=0A=
page:00000000fca63b13 refcount:1 mapcount:0 mapping:0000000000000000 index:=
0x0 pfn:0x780da=0A=
head:00000000fca63b13 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:=
0=0A=
flags: 0xfffe0000010200(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x3fff)=0A=
page_type: 0x1()=0A=
raw: 00fffe0000010200 ffff888100040900 ffffea000438c110 ffffea0001323210=0A=
raw: 0000000000000000 ffff8880780da000 0000000100000001 0000000000000000=0A=
page dumped because: kasan: bad access detected=0A=
=0A=
Memory state around the buggy address:=0A=
 ffff8880780d9f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=0A=
 ffff8880780d9f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=0A=
>ffff8880780da000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
                   ^=0A=
 ffff8880780da080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
 ffff8880780da100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
general protection fault, probably for non-canonical address 0xe0b5dc4c8000=
02ec: 0000 [#1] PREEMPT SMP KASAN=0A=
KASAN: maybe wild-memory-access in range [0x05af026400001760-0x05af02640000=
1767]=0A=
CPU: 3 PID: 5990 Comm: syz-executor.7 Tainted: G    B              6.3.0-ne=
xt-20230426 #1=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:__list_del_entry_valid+0x91/0x1b0=0A=
Code: de 48 39 c2 0f 84 80 00 00 00 48 b8 22 01 00 00 00 00 ad de 48 39 c1 =
74 7f 48 b8 00 00 00 00 00 fc ff df 48 89 cf 48 c1 ef 03 <80> 3c 07 00 0f 8=
5 e7 00 00 00 4c 8b 01 49 39 f0 75 6d 48 8d 7a 08=0A=
RSP: 0018:ffffc9000d81fae0 EFLAGS: 00010213=0A=
RAX: dffffc0000000000 RBX: ffff8880780da000 RCX: 05af026400001766=0A=
RDX: ffff888046d06800 RSI: ffff8880780da000 RDI: 00b5e04c800002ec=0A=
RBP: ffff8880780da260 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: ffffffff88e0008b R12: ffff8880780da008=0A=
R13: ffff8880780da260 R14: dffffc0000000000 R15: ffff88805f51c000=0A=
FS:  0000000000000000(0000) GS:ffff88811a180000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 000055d74eb5c6a0 CR3: 000000010e5b2000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 hci_conn_cleanup+0x15d/0x7e0=0A=
 hci_conn_del+0x2df/0x860=0A=
 hci_conn_hash_flush+0x195/0x230=0A=
 hci_dev_close_sync+0x5c2/0x1060=0A=
 hci_unregister_dev+0x1ce/0x4a0=0A=
 vhci_release+0x80/0xf0=0A=
 __fput+0x27c/0xa90=0A=
 task_work_run+0x168/0x260=0A=
 do_exit+0xbd9/0x2b20=0A=
 do_group_exit+0xd4/0x2a0=0A=
 __x64_sys_exit_group+0x3e/0x50=0A=
 do_syscall_64+0x39/0x80=0A=
 entry_SYSCALL_64_after_hwframe+0x63/0xcd=0A=
RIP: 0033:0x7ff463e8edcd=0A=
Code: Unable to access opcode bytes at 0x7ff463e8eda3.=0A=
RSP: 002b:00007ffde1873c18 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7=0A=
RAX: ffffffffffffffda RBX: 00007ffde1874480 RCX: 00007ff463e8edcd=0A=
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000043=0A=
RBP: 0000000000000003 R08: 0000000000000026 R09: 00007ffde1874480=0A=
R10: 0000000000000026 R11: 0000000000000202 R12: 0000000000000000=0A=
R13: 00007ff463eeba70 R14: 0000000000000002 R15: 00007ffde18744c0=0A=
 </TASK>=0A=
Modules linked in:=0A=
---[ end trace 0000000000000000 ]---=0A=
RIP: 0010:__list_del_entry_valid+0x91/0x1b0=0A=
Code: de 48 39 c2 0f 84 80 00 00 00 48 b8 22 01 00 00 00 00 ad de 48 39 c1 =
74 7f 48 b8 00 00 00 00 00 fc ff df 48 89 cf 48 c1 ef 03 <80> 3c 07 00 0f 8=
5 e7 00 00 00 4c 8b 01 49 39 f0 75 6d 48 8d 7a 08=0A=
RSP: 0018:ffffc9000d81fae0 EFLAGS: 00010213=0A=
RAX: dffffc0000000000 RBX: ffff8880780da000 RCX: 05af026400001766=0A=
RDX: ffff888046d06800 RSI: ffff8880780da000 RDI: 00b5e04c800002ec=0A=
RBP: ffff8880780da260 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: ffffffff88e0008b R12: ffff8880780da008=0A=
R13: ffff8880780da260 R14: dffffc0000000000 R15: ffff88805f51c000=0A=
FS:  0000000000000000(0000) GS:ffff88811a180000(0000) knlGS:000000000000000=
0=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
CR2: 000055d74eb5c6a0 CR3: 000000010e5b2000 CR4: 0000000000350ee0=0A=
----------------=0A=
Code disassembly (best guess), 1 bytes skipped:=0A=
   0:   48 39 c2                cmp    %rax,%rdx=0A=
   3:   0f 84 80 00 00 00       je     0x89=0A=
   9:   48 b8 22 01 00 00 00    movabs $0xdead000000000122,%rax=0A=
  10:   00 ad de=0A=
  13:   48 39 c1                cmp    %rax,%rcx=0A=
  16:   74 7f                   je     0x97=0A=
  18:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax=0A=
  1f:   fc ff df=0A=
  22:   48 89 cf                mov    %rcx,%rdi=0A=
  25:   48 c1 ef 03             shr    $0x3,%rdi=0A=
* 29:   80 3c 07 00             cmpb   $0x0,(%rdi,%rax,1) <-- trapping inst=
ruction=0A=
  2d:   0f 85 e7 00 00 00       jne    0x11a=0A=
  33:   4c 8b 01                mov    (%rcx),%r8=0A=
  36:   49 39 f0                cmp    %rsi,%r8=0A=
  39:   75 6d                   jne    0xa8=0A=
  3b:   48 8d 7a 08             lea    0x8(%rdx),%rdi=0A=
