Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24153793BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbjIFLtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbjIFLth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:49:37 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2104.outbound.protection.outlook.com [40.107.24.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F5C10F9;
        Wed,  6 Sep 2023 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvXUmKl9cTJIPiwXoVOxThkoKtq/H4YAET9BFd/JmCc=;
 b=X9GTyZ9XZfWHx1EMYU0Gr9oRMHCEi9SHnSwXmJPLsP49iKY8eBXLJC1LhBhllUHcmeqifiDOeRnB8yyBqtmJTh6SVUI+QFvJe4A+DarYk2gnSobmI9213ZwrC9ty0g7elEa++8y3s5KaVuJeaiILGWZdGa7eaVuzm/Sutnq5TNc=
Received: from AS9PR06CA0109.eurprd06.prod.outlook.com (2603:10a6:20b:465::33)
 by ZR1P278MB1087.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:59::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 11:49:24 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:465:cafe::21) by AS9PR06CA0109.outlook.office365.com
 (2603:10a6:20b:465::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 11:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 11:49:24 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4Rggdb4cZmzxpD;
        Wed,  6 Sep 2023 13:49:23 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2107.outbound.protection.outlook.com [104.47.22.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Wed,  6 Sep 2023 13:49:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVIUI0QylMqDiPPf2jwEFamQ6lCHT8ullD7jpAr1NaoRaK0l+GQYuD71g2wlT3mPdzIezhrq85NY0vlcru4xv3XKser1U61qU8PHlBJE7U/iGpWHrMsKfD4W5hKVHsbq/a/9SUYHSHFQu3E6sQVJCRCsfNvZmu3Uft2nRkMkVAvup+YkUJ1CEC3L2OyBr/R5/DycIJjYZgvd+f41TlAsVqfk1frycKhGOrthrx7IeXcUeoRn6U+FkArWEZt0Jm2Hmu4q7iHC+7hYRwDNVCYhw6GpCNpFasAvMmEphrifKpMTM3RQPmVOxOydQdp7yvHajJGmS3l0elhVCwOhagEb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvXUmKl9cTJIPiwXoVOxThkoKtq/H4YAET9BFd/JmCc=;
 b=NGpQRbYcrGnIlZHwVb/BuU023zu0UB4YXJ014Uh8FVuTTchQYUuq9Dm5uImvnLwDbiOrKXWiR7ccS2/xzcC7r2wbP9IZtfnyFwpjp3X5JJwGaGqvR28icAVGpvy/nnZAc9cEbk+OE7oZWK7wemdf4WZWzrw+uQoopv7+Qqsj4cal1mCJPrSIckbzIbjg576oDvqwX1SOP0b462JWU6MloRA6TeMY5ZB1VQ7cnWyoNbJ470vwng+kZLCuuv4YxZZVtjtGiS/M6+cZkic9wuMo1n8iKIAO4mB7SJofqXiSePOiB9Pg9TdKItLSTIiuFOSYG+KQqPUqY55OSLGU0P7QUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvXUmKl9cTJIPiwXoVOxThkoKtq/H4YAET9BFd/JmCc=;
 b=X9GTyZ9XZfWHx1EMYU0Gr9oRMHCEi9SHnSwXmJPLsP49iKY8eBXLJC1LhBhllUHcmeqifiDOeRnB8yyBqtmJTh6SVUI+QFvJe4A+DarYk2gnSobmI9213ZwrC9ty0g7elEa++8y3s5KaVuJeaiILGWZdGa7eaVuzm/Sutnq5TNc=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0774.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:49:20 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a222:6d25:1fdb:a800]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a222:6d25:1fdb:a800%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:49:20 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH v3 0/2] mcb: Fix crash mcb-core module is removed
Thread-Topic: [PATCH v3 0/2] mcb: Fix crash mcb-core module is removed
Thread-Index: AQHZ4LgswjxXaDstvEmBia0J2Wepmg==
Date:   Wed, 6 Sep 2023 11:49:20 +0000
Message-ID: <20230906114901.63174-1-JoseJavier.Rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0774:EE_|AMS0EPF000001A9:EE_|ZR1P278MB1087:EE_
X-MS-Office365-Filtering-Correlation-Id: 895c0d40-ab76-4eb0-bf3f-08dbaecf50f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: HmHQ4OmdwIe7qa/BRd7jjAJWJZ4stWcfDwUX03bBg+eWdGbG0lZl+tBSS56Av9rWULMbCnAL982bAP/CMHY7Q00DURyIKdZS8cmP7iuFVfdaKyWZK3aqRpysrmZ+VRN+iTcHA/3z2imp5hIBrC270tQyT2cyPTk9kN+V2uDE7+fpvgy0HvvzIaVEKihSOgXCUuFHb8bI+BB3LwWO8xZxaDcbNafJgglz6nfVoaJf/GkL7Ksak17KZ7+8YsS/B5j8eW0YDm1MPrEd3L/WE6toi0Ui0zgk/p15Mnlbc8dStUQpVAJ2advvMhQXGUzeSDzTInFITh3iHspbIzCY5nQvUBRWbUowjH/fRmbNOzTJKIo91wJ+bQt7t17sL0Y9KH9tm68qx0TRiu/Tbs7QMYDUrFie5SGFC///d3EEmMNm78IYA203wSy6bATPRXl6XQ/VfouOnlUAReP46OHIMTyE5zooAMSKUbABLVY60wg2X9w21HnO4F5ZVm+A3qOli/928Oe2PiJxtUDED1DEL3tjwxXj5EV4lhX/RDy/65gCHwwAhKMOp1vhDCpzhKXvVCMWPp9kod7Q9LWcztZnOPyuobu9b2n5SEfyFN559f2pXcOcXpdSL+D69wkDUghp3c+z
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(396003)(346002)(366004)(451199024)(186009)(1800799009)(71200400001)(6506007)(6486002)(107886003)(478600001)(45080400002)(83380400001)(2906002)(1076003)(26005)(66556008)(64756008)(54906003)(66446008)(41300700001)(66476007)(2616005)(316002)(91956017)(110136005)(8676002)(5660300002)(4326008)(8936002)(76116006)(38100700002)(36756003)(6512007)(122000001)(38070700005)(86362001)(66946007);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0774
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4a8efeec-2dbc-4f34-948e-08dbaecf4ec5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6j411ppHcBkzGnkdAl+MMeNw9eBLTc4ls0yhAdD1OTLNeQIW5jIS+oq5cImkDUry/G8j2KmcYDu/xg4v9IblsDI58Z1edy9R13dhZx7x1fWzsMztoJVpB3qd2HQJgW0NtDqz/R11lcd7JK7LDKG9VDghJSNKok8GGdWQhErtlZUnzRMtaLScvJfJPrbohKZfFsaEkAxU2kiiEr86QUdr1rZiSa7+U5huH1/yBH2oL5jyEzNWvqjzk4ILV0Ol/+EVHoQhfNviuKpBQC1YdkV1l6OIY/40KXEj4gliQyGdTZlTFO0DIpMAmCctNP9kDox3L7qHqxSL5O4QGDJxfVwjRmUM7Yoss5rJ7wJ7D7fM+IQqfyS7uVnkKMcVdw7rcferb7xlB/7s6A78w0Ubfnrb0lokPNjGGXFQPF6RqT29vo8qviE6q2wulOcIeLy9DXBO3EQp2EZBS2fxfhp8hhIp7HWP3n02RGiQTySNDAA7SFFhjnUULRwQf2DBZ4NPoq4sGU7H9NWAadF07/PEg2xglq197miiFHwFXYsEKPbB014AHvTlfq0d0EkUjhKDmlfNYTURIg5aJZjHRpnuQstcgStxSJM838Lh0OWH46wy6InUG0ZvcRUFD8LYqXT6GPiLzj/LmmXF/C8Tvmnl/ceSB951hQPTR6HGebUIs6nzwaGSkjqfFUiqMg8dve2wQWDQbtbUyfeq1Ib0RpuPUuXYBQ==
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230031)(396003)(346002)(39850400004)(376002)(136003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(1076003)(8676002)(316002)(110136005)(45080400002)(54906003)(70206006)(4326008)(107886003)(2616005)(70586007)(8936002)(82740400003)(40480700001)(356005)(6486002)(81166007)(6506007)(41300700001)(6512007)(336012)(26005)(5660300002)(478600001)(2906002)(83380400001)(36860700001)(47076005)(86362001)(36756003);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:49:24.0681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895c0d40-ab76-4eb0-bf3f-08dbaecf50f6
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating a new mcb_bus the bus_type is added to the mcb_bus itself,
causing an issue when calling mcb_bus_add_devices(). This function is not
only called for each mcb_device under the mcb_bus but for the bus itself.

The crash happens when the mcb_core module is removed, getting
the following error:

[  286.691693] ------------[ cut here ]------------
[  286.691695] ida_free called for id=3D1 which is not allocated.
[  286.691714] WARNING: CPU: 0 PID: 1719 at lib/idr.c:523 ida_free+0xe0/0x1=
40
[  286.691715] Modules linked in: snd_hda_codec_hdmi amd64_edac_mod snd_hda=
_intel edac_mce_amd snd_intel_dspcfg kvm_amd snd_hda_codec amdgpu nls_iso88=
59_1 ccp snd_hda_core snd_hwdep amd_iommu_v2 kvm snd_pcm gpu_sched crct10di=
f_pclmul crc32_pclmul snd_seq_midi snd_seq_midi_event ghash_clmulni_intel t=
tm snd_rawmidi aesni_intel snd_seq binfmt_misc crypto_simd cryptd glue_help=
er drm_kms_helper snd_seq_device snd_timer drm snd k10temp fb_sys_fops sysc=
opyarea sysfillrect sysimgblt snd_rn_pci_acp3x mcb_pci(-) snd_pci_acp3x sou=
ndcore altera_cvp fpga_mgr mcb spi_nor mtd 8250_dw mac_hid sch_fq_codel par=
port_pc ppdev lp parport ip_tables x_tables autofs4 mmc_block nvme ahci i2c=
_piix4 libahci i2c_amd_mp2_pci igb nvme_core i2c_algo_bit dca video sdhci_a=
cpi sdhci [last unloaded: 8250_men_mcb]
[  286.691752] CPU: 0 PID: 1719 Comm: modprobe Not tainted 5.4.702+ #11
[  286.691753] Hardware name: MEN F027/n/a, BIOS 1.03 04/20/2021
[  286.691756] RIP: 0010:ida_free+0xe0/0x140
[  286.691759] Code: a8 31 f6 e8 12 f7 00 00 eb 4b 4c 0f a3 28 72 21 48 8b =
7d a8 4c 89 f6 e8 8e ad 02 00 89 de 48 c7 c7 e8 02 83 b5 e8 b0 7a 5d ff <0f=
> 0b e9 67 ff ff ff 4c 0f b3 28 48 8d 7d a8 31 f6 e8 da e0 00 00
[  286.691761] RSP: 0018:ffff9a56c38f7bd8 EFLAGS: 00010282
[  286.691763] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000=
00006
[  286.691764] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8d881fa=
1c8c0
[  286.691765] RBP: ffff9a56c38f7c30 R08: 0000000000000487 R09: 00000000000=
00004
[  286.691766] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000=
00001
[  286.691767] R13: 0000000000000001 R14: 0000000000000202 R15: 00000000000=
00001
[  286.691769] FS:  00007fb78e303540(0000) GS:ffff8d881fa00000(0000) knlGS:=
0000000000000000
[  286.691770] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  286.691771] CR2: 00007ffe92b2ce98 CR3: 000000079fd9c000 CR4: 00000000003=
406f0
[  286.691772] Call Trace:
[  286.691781]  mcb_free_bus+0x2b/0x40 [mcb]
[  286.691785]  device_release+0x2c/0x80
[  286.691787]  kobject_put+0xb9/0x1d0
[  286.691790]  put_device+0x13/0x20

As mcb_bus_add_devices() is called for the mcb_bus itself, the function
tries to cast the incorrectly passed struct mcb_bus to mcb_device. Both
structs have the same layout:

struct mcb_bus {
        struct device dev;
        struct device *carrier;
        int bus_nr;
...
};

struct mcb_device {
        struct device dev;
        struct mcb_bus *bus;
        bool is_added;
...
};

This incorrect casting is causing a wrong behaviour in
mcb_bus_add_devices() where the member bus_nr is casted to is_added,
meaning that when bus_nr is "0", the function continues and sets bus_nr
to "1" (is_added =3D true)

If we have 2 buses (one for each F215 board), the function ida_alloc()
will give the value "0" and "1" to each bus respectively, but as both
buses are included themselves in the devices' lists, after the call to
mcb_bus_add_devices(), the buses will have the value "1" and "1". For
this reason, when the mcb-core module is removed, the error raises as
the ida resource with value "1" is being released twice, leaking
the ida resource with value "0".

changes for V3:
* remove the need for a cast that breaks bus_nr member of mcb_bus struct
* style fix for function pointer mcb_free_bus

This patch is based on linux-next (next-20230906)

Jorge Sanjuan Garcia (2):
  mcb: remove is_added flag from mcb_device struct
  mcb: use short version for function pointer for mcb_free_bus

 drivers/mcb/mcb-core.c  | 12 ++++--------
 drivers/mcb/mcb-parse.c |  2 --
 include/linux/mcb.h     |  1 -
 3 files changed, 4 insertions(+), 11 deletions(-)

--=20
2.34.1
