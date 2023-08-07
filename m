Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0372E772B19
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjHGQg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHGQgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:36:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168801BDC;
        Mon,  7 Aug 2023 09:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jayp3fiAih8Bq6svx8gvMT1X/F5aF/HslpiwEDImkSyl/vX8gPKWzZ6HUgpUoe2sB6UXONhyWGR3z6aXZuuv4dl2cUQ/8FPOKjZDock9dk40bWGAHbDiWS1MBfDZTrIcbGkW8n3vdAbSHkOX7nhXVWYHukimLg/tIS/SX22ufvYxU5kIVnmGMhTgOerdu+2xVETjHOmSv4pJlgwE/Lt0JdA4eDVBYfqN9djNa7Wpl3jZOvVQfrqaxW9xhRjWqnv08TmxQHACCCGEt76fZ2WnQWH49l8iJsTjUxMlXS6xJdKEE7U6vQbcyEslSQlyhhK84WsxKHdcSBCw2p2nWRX0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3cIzk9HM4lnkLLBMruHzfSO/FP+GzN9JroxpYrJVEU=;
 b=ciJFlPiAXevyeFsqreqpB4DOBkv0lhnW7id24YdLxQSG96preBxXp4We4As18gbQ1A6HdUXZ2K40+xBWs8XeTeAjBXU86shvF0hBnBXHHFN3LgO4bB526Vq5g/Ls1R9N4n24YOTbOgCZScnAuIBh5yFOjrY/mv9tHKqD1dPOlVd+ZIo8n0b0ffx6uN4nvbzzVIgyPsh1zOG8YokMSVdPD4524TAx7oj5SAfDoWJOse0Ol/wFOM5Aowa8zqODPQjw2a9aWQ9nD0ZVdLGIVfHvoxNVhpnNbF6Slr/Soz2B7ml7IfVVJPXNaVxAvSgUJ0Yz0fkgNyT0eJotSToDDp15ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3cIzk9HM4lnkLLBMruHzfSO/FP+GzN9JroxpYrJVEU=;
 b=kkZPLegeDjx+oPM5QUakldjaBELEdw4vKJjceVTwo96bzQ15jqMk5jyDijHG9GHME68CcRaRrc3vQ1L1sOUBHVhNEh0OyX8EMv2RAm7mW6A7vOaQUJ2DNoi4oWwSYInLxUo0hTGViJEJHsdg7emJGU9Km4FVPdngnPFDhkowRtc6zunzNGEiC26k0ms48V/w9Hy5v7E5BP3VeHmBOwZdq8r0tAIzdP6X0UshcDlA8Fh5B6Ej81U4CApYddk9TEnCbDQ5Z597mpmNXFvfBdLFXJh3cGNfFoWIAHzPJRvMV8LAvTTb9SUgDKJUgU5CrKc+yN/d9KX6EdFoa7QPkzyg+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 16:36:25 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::bd1:3314:4416:227f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::bd1:3314:4416:227f%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:36:29 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH 1/3] HID: nvidia-shield: Remove led_classdev_unregister in thunderstrike_create
Date:   Mon,  7 Aug 2023 09:36:18 -0700
Message-Id: <20230807163620.16855-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 896cc682-63eb-4eae-f3f6-08db97647327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnAaaAXUdJ+m9//xMfKTU4qBYkntaz7HCS9L2NsUpI/qYeWUrJBGF4iGvt/lu/MXYj8MYTuT7XLHLSMngZ5dcjkzgy8I/AocfbTo/SsBOKjdSi0TpzEp5NueCL2ukTCk0N2KG4VSHV9mN9OQE6oa4FLC0dNIes98VqiG+3x4Fumh2i9qLitqgPyhF1Zdbou+Eu52XlN/s7ZI7WPTPoSpZHBNDs7uej9s3B1wlnePLKH5+68Zt0/SnQVjbk6gZmo06W7PNq50zTXiOF9aRV2CmukVFEaEN+3VpHMcdWABH95lakb16gOfHMJAn0JAc3lyoef3kAvrFxwF5tbTTPo9YLktei7W1382zPW7tkVwiH9ocEW7Lqi/J/ddu//IIOxwtZMpNkYPdTbhxjGH5zY/kzzkAay8IydfDhLldPdKi7fd97nX/5heaHYBmdMrogyt1m1doL4DBFzfeKI1hcmJEb38EXHuUDDDRhrXQnqJEiEZhTmI6YTTQt2CVQVfnzfP/4HiH890+IIJxA4jjIclS79JLfwpzqgVWUKDm0gG4zczkn2rBOrr4Z9nSX+SrbKb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(186006)(1800799003)(451199021)(4326008)(316002)(66476007)(66556008)(66946007)(38100700002)(36756003)(6666004)(6512007)(45080400002)(6486002)(107886003)(2616005)(83380400001)(1076003)(26005)(6506007)(2906002)(86362001)(478600001)(110136005)(8676002)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9w4+PMspmBjdQEyvGSm0t61XfoVc5EOKENvQZj7WNXVoJl7+Pjny/fgnvCHz?=
 =?us-ascii?Q?nciSUYMcBsTeKcIjpwyVAV+WNT4NNoLDKF7wZynhsXn3O8RPHyIu4yeqFTcI?=
 =?us-ascii?Q?J8bNpcjWr2LCwuxYcDNvhuCvyeOC2qqz9oxEWe2OyPfKkUpKF8L7AfYNe9fZ?=
 =?us-ascii?Q?wfKlmUDUK7nngAe5hPFaCf3KoXKvq0EUEQU45jRJPobkepfWDHlC/nyCfzPN?=
 =?us-ascii?Q?GIIZQH0U2olbIgzhklTAw3v/i0tCgeM/VPKRDOASNSu6y2rykw5+aNxksvyh?=
 =?us-ascii?Q?H0VJio0EeBDBuhoUBSRXOxx0qfl3wvDWFDNFW36yZ+iFEmPYULK+O5j7T7wU?=
 =?us-ascii?Q?iTbjZvEvt+zNxHmvg1tzIf63B17tnmwIUNlekIr4vErleJ85m0t7/qb+f0FX?=
 =?us-ascii?Q?TkdPXO4u46uuFgLA6RDnnsGpvUUA4QKt+eIxqy54We7SnDmKp6vz0AY8chAl?=
 =?us-ascii?Q?Cjq6+MtZvcfHwDpYN2VABU6DuV/FgUCc7vpbauc8rMM3TKV/YD6MGOVJcmYj?=
 =?us-ascii?Q?opE6Vi71zlMStjY6Qks607YPxJcS0Ad0Pwna7p5TLUxtZDrKCA5T/Yx0WlDP?=
 =?us-ascii?Q?YKLu7psnx9LtWE0pUgr1U8WCJFjwfcRpIGRealBqQpf2JCURa+jEkrS3SDEv?=
 =?us-ascii?Q?1V5hF5MXLDTEnT1eHO/e1GW1SvetN0LZ9AbIK5taPXpJ7nNEHB0aQ1i/8VmP?=
 =?us-ascii?Q?yT5OJMxN4JgXo4DPT+Z5pCNCJKH321YKOCzb0+YsHWnLkDoHJve+s/0dcGvG?=
 =?us-ascii?Q?zYPu7WBdt4xpsqzQLXTOdWjBB/6N7x7AtpIgKzfPRu5FcDq1rTeqV0MAt7vp?=
 =?us-ascii?Q?Je8ELRM6/vyWR0IWukK03yimADVYUtPrIkIc+bkJclQJkfN9lnbIzHh6BJoe?=
 =?us-ascii?Q?bl9NVYgcTKkE07rk+G/lOXbs+aRtAudBcWCfqUFx0szYXZ/Fjb2ZSxpK+fQM?=
 =?us-ascii?Q?qpcsfr+3Y51g6a7k9Zc/x33IFHx8Nk2afsj4vxGWoljkGFTj+mQL2muTyZmm?=
 =?us-ascii?Q?tz/1TfzZnQt+F36MjtZqVGmqBhoeqTvgPahJ1qVtx9350aRGky2fiImS9Qnz?=
 =?us-ascii?Q?4BMd4qr9zbr8KwugP4HZiCnBeEYiqSeSZczbHMXzTQwodHTv473LkAfaFBWg?=
 =?us-ascii?Q?OdF1tjmbKpQOMpJSyaquuy1ShPX2kqBUqmDY+frmKTtGF4DcKGNPm11prCW2?=
 =?us-ascii?Q?rPptHGbkMJwftE7Zf2odMw+4sqrfDP8sMqsJ/LzjCxcYSgbnkDgZekOojMPj?=
 =?us-ascii?Q?zpKj7toZGyliMJwW2c4cAa8WNaQ52ALT8ZSWs15Tlhod8TLjNHju12rEHaYq?=
 =?us-ascii?Q?eDY295/VCFUeSkMNdrdWCcQtq88zrwBWW9oeaZzUzYXmEZDE7FI2HikjFxhz?=
 =?us-ascii?Q?5XnVeBAYoFglK8y5Cfx13/NVh9p9G8UaGsafEafT0P0qCGkoBPXJOQ2YynG1?=
 =?us-ascii?Q?fxIDulTW/76pQFpO1TXvDjFSD32ujOBfsCaJ+7MRKHf4tFzOFFDe2UtvwIb7?=
 =?us-ascii?Q?rKqRXg0cxnavbPaUdQamr3rygP8zxomWylNBaSnW4Y1sqXuk2mM6Vx5Z2uM6?=
 =?us-ascii?Q?2bpDu1lroZZ7xku+FdjwkNQ/DLiCY8PDv+0QqEvVRWsYT8b3pXZ35ZdHgp5H?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896cc682-63eb-4eae-f3f6-08db97647327
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:36:28.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmZBwpyWBp2sXofi8N7wPOoxsv/U0raNrRhc55qcxqgWfqBLrUY+KkgQJYu53DaT+WpBjNp2foOQrC5thdq+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid calling thunderstrike_led_set_brightness from thunderstrike_create
when led_classdev_unregister is called. led_classdev_unregister was called
from thunderstrike_create in the error path. Calling
thunderstrike_led_set_brightness in this situation is unsafe.

Fixes: f88af60e74a5 ("HID: nvidia-shield: Support LED functionality for Thu=
nderstrike")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---

Notes:
    Discussion:
=20=20=20=20
    An alternative approach that could be used here is setting the
    LED_RETAIN_AT_SHUTDOWN flag. To me, this felt like a less appropriate
    solution since in other contexts in the driver, calling
    led_classdev_unregister where it then tries to set the led to the LED_O=
FF
    state is safe.
=20=20=20=20
    Example backtrace of problem when led_classdev_unregister is called from
    thunderstrike_create.
=20=20=20=20
        [  +0.000061] thermal_sys: Thermal zone name (thunderstrike_0_batte=
ry) too long, should be under 20 chars
        [  +0.000096] shield 0005:0955:7214.001B: Failed to register Thunde=
rstrike battery device
        [  +0.000001] shield 0005:0955:7214.001B: Failed to create Thunders=
trike power supply instance
        [  +0.000024] shield 0005:0955:7214.001B: Failed to create SHIELD d=
evice
        [  +0.000003] shield: probe of 0005:0955:7214.001B failed with erro=
r -22
        [  +0.121671] BUG: unable to handle page fault for address: 0000000=
46474e550
        [  +0.000009] #PF: supervisor read access in kernel mode
        [  +0.000003] #PF: error_code(0x0000) - not-present page
        [  +0.000003] PGD 0 P4D 0
        [  +0.000005] Oops: 0000 [#1] PREEMPT SMP NOPTI
        [  +0.000004] CPU: 14 PID: 36436 Comm: kworker/14:3 Tainted: P     =
      O       6.4.7 #1-NixOS
        [  +0.000005] Hardware name: Dell Inc. Precision 5760/0WP4FK, BIOS =
1.16.1 11/22/2022
        [  +0.000002] Workqueue: events thunderstrike_hostcmd_req_work_hand=
ler [hid_nvidia_shield]
        [  +0.000017] RIP: 0010:thunderstrike_hostcmd_req_work_handler+0x1b=
3/0x390 [hid_nvidia_shield]
        [  +0.000010] Code: 09 00 00 00 41 b8 01 00 00 00 48 c7 45 08 00 00=
 00 00 48 c7 45 17 00 00 00 00 66 41 89 04 24 48 8b 53 98 48 8b bb 90 fd ff=
 ff <0f> b6 32 e8 b5 5e 99 fa 85 c0 0f 88 9d 01 00 00 0f b7 05 cc 05 02
        [  +0.000003] RSP: 0018:ffffa43e8f66fe78 EFLAGS: 00010207
        [  +0.000004] RAX: 0000000000000704 RBX: ffff93edf8498a98 RCX: 0000=
000000000021
        [  +0.000003] RDX: 000000046474e550 RSI: 0000000000000206 RDI: 0000=
0000000002d8
        [  +0.000003] RBP: ffff93eca5485e6a R08: 0000000000000001 R09: 0000=
000000000009
        [  +0.000002] R10: 0000000000000001 R11: 0000000000000000 R12: ffff=
93eca5485e68
        [  +0.000002] R13: 0000000000000000 R14: ffff93eca8c34540 R15: ffff=
93edf8498aa0
        [  +0.000003] FS:  0000000000000000(0000) GS:ffff93f3ef780000(0000)=
 knlGS:0000000000000000
        [  +0.000002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
        [  +0.000003] CR2: 000000046474e550 CR3: 000000027d820003 CR4: 0000=
000000f70ee0
        [  +0.000003] PKRU: 55555554
        [  +0.000001] Call Trace:
        [  +0.000004]  <TASK>
        [  +0.000005]  ? __die+0x23/0x70
        [  +0.000009]  ? page_fault_oops+0x17d/0x4b0
        [  +0.000005]  ? lock_timer_base+0x61/0x80
        [  +0.000005]  ? exc_page_fault+0x6d/0x150
        [  +0.000008]  ? asm_exc_page_fault+0x26/0x30
        [  +0.000012]  ? thunderstrike_hostcmd_req_work_handler+0x1b3/0x390=
 [hid_nvidia_shield]
        [  +0.000008]  ? thunderstrike_hostcmd_req_work_handler+0x13b/0x390=
 [hid_nvidia_shield]
        [  +0.000009]  process_one_work+0x1c5/0x3c0
        [  +0.000005]  worker_thread+0x51/0x390
        [  +0.000004]  ? __pfx_worker_thread+0x10/0x10
        [  +0.000003]  kthread+0xe5/0x120
        [  +0.000005]  ? __pfx_kthread+0x10/0x10
        [  +0.000004]  ret_from_fork+0x29/0x50
        [  +0.000008]  </TASK>
        [  +0.000002] Modules linked in: hid_nvidia_shield(O) hidp rfcomm s=
nd_seq_dummy snd_hrtimer snd_seq nf_conntrack_netlink xfrm_user xfrm_algo x=
t_addrtype ccm cmac algif_hash algif_skcipher af_alg xt_CHECKSUM xt_MASQUER=
ADE af_packet ipt_REJECT nf_reject_ipv4 nft_chain_nat bnep msr xt_conntrack=
 ip6t_rpfilter ipt_rpfilter xt_pkttype xt_LOG nf_log_syslog xt_tcpudp nft_c=
ompat nf_tables nfnetlink sch_fq_codel hid_sensor_custom_intel_hinge hid_se=
nsor_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf hid_sen=
sor_iio_common industrialio hid_sensor_custom hid_sensor_hub intel_ishtp_hi=
d snd_ctl_led snd_soc_sof_sdw hid_multitouch snd_soc_intel_hda_dsp_common s=
nd_sof_probes snd_soc_intel_sof_maxim_common snd_soc_rt711 snd_soc_rt715 sn=
d_soc_rt1308_sdw regmap_sdw snd_soc_dmic snd_sof_pci_intel_tgl snd_sof_inte=
l_hda_common snd_soc_hdac_hda soundwire_intel soundwire_cadence snd_sof_int=
el_hda_mlink snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_s=
of_utils snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi
        [  +0.000074]  soundwire_generic_allocation soundwire_bus snd_soc_c=
ore snd_hda_codec_hdmi snd_compress ac97_bus snd_pcm_dmaengine iwlmvm mac80=
211 dell_rbtn ptp pps_core libarc4 i2c_designware_platform i2c_designware_c=
ore cmdlinepart x86_pkg_temp_thermal intel_powerclamp ee1004 spi_nor iTCO_w=
dt mei_hdcp mei_wdt intel_pmc_bxt mei_pxp watchdog mtd r8153_ecm nls_iso885=
9_1 snd_hda_intel cdc_ether nls_cp437 coretemp pmt_telemetry snd_intel_dspc=
fg usbnet vfat intel_rapl_msr dell_laptop snd_intel_sdw_acpi crc32_pclmul p=
mt_class ledtrig_audio fat polyval_clmulni iwlwifi snd_usb_audio btusb dell=
_wmi polyval_generic snd_hda_codec btrtl gf128mul uvcvideo ghash_clmulni_in=
tel hci_uart btbcm processor_thermal_device_pci_legacy snd_usbmidi_lib nvid=
ia_drm(PO) snd_hda_core btintel videobuf2_vmalloc processor_thermal_device =
uvc btqca dell_smbios snd_rawmidi intel_lpss_pci ucsi_acpi btmtk processor_=
thermal_rfim rapl videobuf2_memops videobuf2_v4l2 dell_wmi_sysman typec_ucs=
i dcdbas snd_hwdep intel_cstate nvidia_uvm(PO) snd_seq_device
        [  +0.000085]  cfg80211 bluetooth psmouse intel_uncore videodev del=
l_wmi_ddv firmware_attributes_class dell_wmi_descriptor nvidia_modeset(PO) =
intel_ish_ipc intel_lpss wmi_bmof processor_thermal_mbox snd_pcm idma64 typ=
ec r8152 i2c_i801 intel_ishtp tpm_crb videobuf2_common processor_thermal_ra=
pl mei_me spi_intel_pci tiny_power_button spi_intel intel_rapl_common i2c_s=
mbus ecdh_generic mc mei snd_timer 8250_pci int3403_thermal mii virt_dma rf=
kill intel_vsec snd ecc int3400_thermal i2c_hid_acpi intel_hid mousedev evd=
ev tpm_tis soundcore intel_soc_dts_iosf tpm_tis_core roles battery button i=
2c_hid crc16 joydev int340x_thermal_zone intel_pmc_core acpi_thermal_rel pi=
nctrl_tigerlake mac_hid acpi_pad sparse_keymap serio_raw acpi_tad ac nvidia=
(PO) ctr loop cpufreq_powersave xt_nat nf_nat nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 br_netfilter veth tun tap macvlan bridge stp llc kvm_intel kv=
m fuse irqbypass deflate efi_pstore configfs efivarfs dmi_sysfs ip_tables x=
_tables autofs4 dm_crypt cbc encrypted_keys trusted asn1_encoder tee
        [  +0.000100]  tpm rng_core hid_generic usbhid hid xhci_pci rtsx_pc=
i_sdmmc xhci_pci_renesas xhci_hcd mmc_core input_leds led_class nvme thunde=
rbolt usbcore atkbd libps2 nvme_core vivaldi_fmap sha512_ssse3 sha512_gener=
ic aesni_intel rtsx_pci libaes t10_pi crypto_simd cryptd crc64_rocksoft crc=
64 crc_t10dif crct10dif_generic mfd_core usb_common crct10dif_pclmul crct10=
dif_common i8042 rtc_cmos serio btrfs blake2b_generic xor libcrc32c crc32c_=
generic crc32c_intel raid6_pq i915 i2c_algo_bit drm_buddy cec intel_gtt vid=
eo wmi drm_display_helper drm_kms_helper syscopyarea sysfillrect sysimgblt =
ttm agpgart drm i2c_core backlight dm_snapshot dm_bufio dm_mod dax [last un=
loaded: hid_nvidia_shield(O)]
        [  +0.000075] CR2: 000000046474e550
        [  +0.000004] ---[ end trace 0000000000000000 ]---

 drivers/hid/hid-nvidia-shield.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shiel=
d.c
index a928ad2be62d..4e183650c447 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -513,21 +513,22 @@ static struct shield_device *thunderstrike_create(str=
uct hid_device *hdev)
=20
 	hid_set_drvdata(hdev, shield_dev);
=20
+	ts->haptics_dev =3D shield_haptics_create(shield_dev, thunderstrike_play_=
effect);
+	if (IS_ERR(ts->haptics_dev))
+		return ERR_CAST(ts->haptics_dev);
+
 	ret =3D thunderstrike_led_create(ts);
 	if (ret) {
 		hid_err(hdev, "Failed to create Thunderstrike LED instance\n");
-		return ERR_PTR(ret);
-	}
-
-	ts->haptics_dev =3D shield_haptics_create(shield_dev, thunderstrike_play_=
effect);
-	if (IS_ERR(ts->haptics_dev))
 		goto err;
+	}
=20
 	hid_info(hdev, "Registered Thunderstrike controller\n");
 	return shield_dev;
=20
 err:
-	led_classdev_unregister(&ts->led_dev);
+	if (ts->haptics_dev)
+		input_unregister_device(ts->haptics_dev);
 	return ERR_CAST(ts->haptics_dev);
 }
=20
--=20
2.40.1

