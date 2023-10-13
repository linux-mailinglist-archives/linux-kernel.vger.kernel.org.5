Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899757C854F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjJMMGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjJMMGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:06:06 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2107.outbound.protection.outlook.com [40.107.114.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F3BD6;
        Fri, 13 Oct 2023 05:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkpIzmhyuMhjy6rlj8GW9KaDajviopbJpiSHQL/U7lyThE43kd4skudpMsIvxENzSMgqQn6H+Cs0Q6q0Inf/tOAG5B50jB1BqBz87MV4RE8HxzElDRP3YueeFfMIMQoUzYcZ0pbfWxtma5WwV7n58c0BR9lBpF/uFL+TS7yLMUCWwagBwzgmHA4aBaPTYEuq175J3TJhpTecZmQT4hSEBn9U7iTAnhQUTN386yFgLJbg3l8Gk9qSxbb7hpv6+b6yn+/SOwTYbFlyXB6ESwkXdDGB13JpC25VZ0wVdpsSMhYFWaHQZLu8XbR9xQ8FVHEQGUcVahGG4D2DNuloFo1HIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejrs8jylAJqBfnpW0hEqW2gxslFv2Y1aTmpuXU3k3mE=;
 b=OZ8P/IkEpbC92B0j1P0KgsCXaS+cXfbuB1MM5xIUyffPmihGPvWPwvMdNP+GObJFVEwPE63qfBbl+aos2VMmqjpErR5wjDswyhsnETFAU6FFJHBtfvlCHz7taJK+c1/79S+PuQnK/2jR1rBZitytdZu0S56VEAm5bb3CmYyk/8gJGgM/X4jt/4mfxWLAWw3ljNz8QNTxJcozDS9Dt6n0mfmrr4VQ48ChlsTz+OF9LDif7EJpm3VBAHYZ3u0mR08a6J6zw8zetdD+gdTkkuefvgX2zuJHXMZjawyenMu5eLVN2ZyWnlXtPvazOdpqlF7Nlo/DZ8GSo9hDpidFWTZMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejrs8jylAJqBfnpW0hEqW2gxslFv2Y1aTmpuXU3k3mE=;
 b=KQ5Y8LP3Nh0utFf8mDsRK21HxvgsNk7QYOShNbodXSknzWVqfUM7+oImTBbasUF9hMO0bkIJdlWU3lMapCc51wVG5ZHUA+TIhj9jtOgnuzIOzdRg4sfksSr0bgZk6Wja4oceiZ6c5zBWsm+Q14TNwFsQSZugeLjevCtJ0s3D5Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:de::5) by
 TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.17; Fri, 13 Oct 2023 12:05:59 +0000
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc]) by TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc%7]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 12:05:59 +0000
Date:   Fri, 13 Oct 2023 20:05:52 +0800
From:   Hongren Zheng <i@zenithal.me>
To:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH -next] usb/usbip: fix wrong data added to platform device
Message-ID: <ZSkyoFkBKPavk6Jg@Sun>
References: <ZSkhWa5wmAGsAdCK@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkhWa5wmAGsAdCK@Sun>
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: BYAPR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::48) To TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:de::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP286MB1406:EE_|TYWP286MB2601:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a781a3d-b16f-4a7c-b951-08dbcbe4c376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnK/nPxTJJ5+zzn18A1nsOEzsuW5EUFxt3utj5hckiQ6C+8XqBNf+Tevrj8mjQT8OURFE0nyG6wrYOsgEVqG6MuEVmsTuRhVmVQvdPy74CcJk09hZ07nvh2qVdbgVlcJ6X/1hLLEhguvfEIv+CtCujNAL2HroXMIyTNS78c6aj5U9mDhdiXBn24ACpMI0RTMcQWdDTFI1NPB+a2Xf7OHdz8uk6eW88ZqOcaaMd9Kl4zofuZtoUS3ZNVMOkFPyxehHpWzlrppkNqmVgjPl1TtoN+2O7Tb2A4GDeUfrzyHdeLrChL9+Kjyc0SJfxWg/ii+MW9Dn/VzTrFzqZBMPdZKiuS4ivO1X7tpgmOPlLDrjD5d+SN0lwZbr7v0heEcvSBiPIQJQSpLy5DLzXb3GrtPsiBJGA5UEYz0AfYkVeBCwJP+L6wczNJ+cw8H31a5S7h/Gh4yh3rrNkslTFCxSBT0RGPNLEGvZq10AtGhP5vlqa7/4pTfgsK+HRwK+/ss9FpOjr0QlNixftLqMe+Y5UbnMUR6k5ymviyeUdrFuhKz12X2J+sro5U8KtbadTSTilvad3NLuzUipgfR3N0Z/en3eFSlgEzYO8dZho6lNFFRVyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(346002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66476007)(786003)(66556008)(316002)(66946007)(41320700001)(83380400001)(110136005)(4326008)(5660300002)(478600001)(6506007)(6666004)(86362001)(8676002)(6486002)(966005)(8936002)(2906002)(38100700002)(9686003)(6512007)(33716001)(41300700001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zNK6bJDgXLTC/r9uPL3B0T9Zqjw2cQleTYkxZsGmyt/BKeJzYPX7wYeh+XNC?=
 =?us-ascii?Q?EYC3c0KdFZC+MHkzJO332RW6cpishrZ5s8IpXeocGTEDuA6MVTc/n8Ykw7pq?=
 =?us-ascii?Q?xWvvxepTV3lflNyLozqUa3MgZFga7GDSHpmcuxzXHR2jMWV8RXdVXTSPqlgd?=
 =?us-ascii?Q?qawMxfS3LXVEalPVXnP6uX3avp5vFzBCsAiM4yRNXvV2rLWQepnawWXV2e/q?=
 =?us-ascii?Q?UvzPXI9TmldKFH9ED9pOpGVxzs6MYAppqlFKTOJPZT7gAU5Li78HyPGzTLja?=
 =?us-ascii?Q?JqXL0IBSJO4oano1fOxs1uhpq6Y2fePpQI3buVuK6yOKc1K+36oNfLg4jXO9?=
 =?us-ascii?Q?sjDWeyPg4pPJON7EJITqH7JSz9L2sUxHO+lFEp/bmuTPtgIJEsMHVk+Wgbne?=
 =?us-ascii?Q?MM+80L3N0a+clWABkvNdjZcaCrmjHVpR+DnoudJVn5EGzxU6NtoJ81L3ScXD?=
 =?us-ascii?Q?nm5Iaz6uRwHfHxdrJmDFtVtrE6FSjoR/nsbV3OobXGrnNhp6b9jpuxER3WCc?=
 =?us-ascii?Q?GYkjsdjXDkkPQ7ENyOlbQ4M8sa0oGU8v7D+9gn0OUMwFd2N6zn0AfTE7SPoK?=
 =?us-ascii?Q?m344iQLLdOJnQmKEwrv7wSGaEXXur26vYwVEhw3zvffL9VvWl97wTfvGoPsR?=
 =?us-ascii?Q?C0G+lP3cH+wze222lQuBgJlEfw5epkvfx5NWrDu95rNi8VXi3CgPm63n4K5V?=
 =?us-ascii?Q?7bWHO8p6YfYIkFKEMXGBFQkMgWshmAn5JYMDWqJg7u0ixL6TKUSWSps1vqLx?=
 =?us-ascii?Q?ueLyBdTsjs8tFrhGaezwxLg/RhTWx4RKFBw6fc5kmWFEnj6vOoG52e68yOBA?=
 =?us-ascii?Q?QKUeb329C4To5/bikZ78pcFUEcUDiI4aYWChsrBPgclewJSo+1Y5Ev7K7/CN?=
 =?us-ascii?Q?5IG9sT7kduhwyf9WNuPZjcnZ+DnyM3++rdydtfyCUEbo5JZV9AedeCUcZFrM?=
 =?us-ascii?Q?eodKWw/mInWtgrcGKsKwXfvOO/6w3ZWkg3mVg4eJGYtqG1rHfBw3GfkdlP3q?=
 =?us-ascii?Q?B4Q2fTcop7DrpxanpBZarrg4+Haatja/vTQcqjB6wzo8cPpskHheRjup8WJO?=
 =?us-ascii?Q?V2ikN7Vxdb649gy0tv/ImE8SeinvZMwjZkOK1xSzgd0rqarMaFB3lxzmTLvd?=
 =?us-ascii?Q?atwkm9XPgwLfn3Ciu+nMcQUkqhzMmM61xjToTnPPvV/a4ON5yrx+lfZnRWEy?=
 =?us-ascii?Q?mJjFLYtpjoZiRzniISvysI4kEaAtT16nzwd7PVw4HL5jrRt3OLTpYqwLH7s1?=
 =?us-ascii?Q?W4wKu/zdw38SHfXGZAKpF+pP9tIIM2WfZB8nCgZpSdyCmuLO41/th+tRXhBl?=
 =?us-ascii?Q?Pn8x0dNscGMAup04oGhoBHgW1mWi5x8eNwiB3aLP0PplnXvgrXqEICnXvi3V?=
 =?us-ascii?Q?ITajRU2Ow/mzAPEx6BqwbLyd5T54g4lUqvqTy3ID21+BSeao4wHW0bfstTl8?=
 =?us-ascii?Q?hb0A+mL0tvd/8UT5xHS3E6phtVtUZrk440otownyIGAcbTlkLHj8UMFmviCV?=
 =?us-ascii?Q?XSgU7gBQxBVxeWFGiaf0cJ8eQZRLsez84KfIHxtlDJV7Veqe7yw8zj4bHmrZ?=
 =?us-ascii?Q?97JeoIQruizSZB14VePlp9fpwNIZkVMBpQmToBrK?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a781a3d-b16f-4a7c-b951-08dbcbe4c376
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 12:05:59.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxHkdybgvKDKwQ1QwJhX3BdZSkFDUA56DojRJWzMmjrcztt8fgDkiD+eIwL35Fjp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2601
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 06:52:09PM +0800, Hongren Zheng wrote:
> .data of platform_device_info will be copied into .platform_data of
> struct device via platform_device_add_data.
> 
> However, vhcis[i] contains a spinlock, is dynamically allocated and
> used by other code, so it is not meant to be copied. The workaround
> was to use void *vhci as an agent, but it was removed in the commit
> suggested below.
> 
> This patch adds back the workaround and changes the way of using
> platform_data accordingly.
> 
> Reported-by: syzbot+e0dbc33630a092ccf033@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-usb/00000000000029242706077f3145@google.com/
> Reported-by: syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-usb/0000000000007634c1060793197c@google.com/
> Fixes: b8aaf639b403 ("usbip: Use platform_device_register_full()")
> Signed-off-by: Hongren Zheng <i@zenithal.me>
> ---

Tested-by: syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/0000000000007ac87d0607979b6b@google.com/
