Return-Path: <linux-kernel+bounces-7081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EE381A165
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543FC1F22F11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462993D973;
	Wed, 20 Dec 2023 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kD+dXsn4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923F3D965;
	Wed, 20 Dec 2023 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW7oR+eSZRsaywiL6weI5e8JszUgHktxxazEyouTpv1YTZk8e/y+QHZ7Sg5v354WsxCsNSpzXzUQbt5M3o2qkVRNzuPFH6H8BtF50f11f14Pl+ZOsHa3+ypLzBvg/cIjvlLBvdUy0T0JNNa0vBVdrapDhxD5pGpW8jT6wI5VHsUdN7GTD9WQ/dr+NUlBwxsc8g7SyXLXt9xKpuaJVXEPJei9UptZNfojJM459ReCMQFjgTGl3lZPDzjDxxmFSb86bRXMdU32sjfJWyqZyGlITkjlDAWHWagOZl04utNTUKdW6doqe4fypjCPHie7pJcO5UeWPXD6TTZu5x1uGJUseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o5u4erlbtD1oJo31ccWQpehNYktImz7PS/BLa49oG8=;
 b=nwaisgwb8ktz2hfQvOm3z/+/siAz731t/tRM8c9Sq2YAA1nvg6PDjUl64McOPhqmtLiiXFMumeVJsmTIKSH0bkEowr7p86M521KUCvnzOPHQ4hDErtzySv+6rbj3ePNTLEA04ZVXAdcjqZEpwixZcFm3vJ35iR7Ty/P6fN7GUbozi8UOomoibB0nFZywXqwI3qHLYFNlNqg4TKjbUkd0PDZYm89WhE3oZVNZeeB0ZzH4aMx7VUSFGtUV1qxJYkmAQqJ9/Q7jV7AeX68X4gCIar1R0mekse8JMyVqPpXJQBAjQTZsGseEs1o29apj3Tx9VlxEBrWWKFFojwpJAMvjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o5u4erlbtD1oJo31ccWQpehNYktImz7PS/BLa49oG8=;
 b=kD+dXsn4FdzSStx2Gg+Dd+fEioVTZw0IMOYqfcZt/qLJbc2/p5uO5ALX8dC9Zds4kI1TupIoroZz6vVRCJbHQV14KgR6HoBwpLe+PkT+Plq79M7xLyAK0mrEg3R2xlpVcKQmf4wwFw92+fwrsJ6hFc3pmIPgy8RngjGImjr3Gm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 14:47:22 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 14:47:22 +0000
Message-ID: <d491221f-1911-432f-9afb-45c4ac5287b4@amd.com>
Date: Wed, 20 Dec 2023 08:47:19 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RESEND PATCH v3 1/2] remoteproc: Make rproc_get_by_phandle()
 work for clusters
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ben Levinsky <ben.levinsky@amd.com>
References: <20231014231548.637303-1-tanmay.shah@amd.com>
 <20231014231548.637303-2-tanmay.shah@amd.com>
 <dznmvir337tb455usswkrvovf34urgyejkrt7rduscbepd2wg3@7atos56utizw>
 <CANLsYky+6=tvAHE408pGg_=YTUM4eH6ovwn--h2iuaNMGwRF+Q@mail.gmail.com>
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <CANLsYky+6=tvAHE408pGg_=YTUM4eH6ovwn--h2iuaNMGwRF+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:806:a7::10) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a22002b-653c-4543-46b6-08dc016a9277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jTVrdF/DDAX07JKv+N03jyPhfxlLfeQOBul/PaFHdTgon2Kq/jX/hyN61dk2SxXFo0vZXQfLG0pEucsHLBd+UlpjQAoZzKUmmg66JdqfrECAdUZojaf1tRp4yu6P05cbahsvj7zORoN78Tnr/aovpC0Bhnhri23j0JycD9M4WUuuUeUIkCRky9sOQdJTFFDCeTxePHc9I1YwRjH2/LtxOLPW8ZcnvQODqvs3t80Vr7AM/BGd2hzCFTmoFokEOBY4fRDT5cWImCdm5PJL/pc7dD2aTKmlCTACKW8XUApPu6b9S9yB/4uhdNXWh8I7Ns58nVK+6NuPBOuOtkds4kRCGz+KinB3vqaMDfjPINsplXdpRPEW08NpqWEMtbjSTrsS40klkTm7Ku3oesGMGL+7IPSifT7GXoWPJ08juLhPr8EhHlk0orzozTPTJ81qR+Wwky75xsNKXfK8bL+UKzFXMUX5/WvGt3kFT4ImxZDHHgU/hF/eyaiQ7mZ12uJKIjIDudgLfPuux+EqZipTPjjH8aFajRAW6tHhDpZr4zwowaDwbr/UNqfEagvnSOYWH90sFniBGLjuAEd1lt1Pb1pmC0GdgK5C7CI7/zsLlY7FU24FURNCeUF5QGFUixGPPJNfN4D/boK31MtEPh/8vyjovQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6512007)(38100700002)(53546011)(26005)(6506007)(41300700001)(86362001)(31696002)(36756003)(83380400001)(2616005)(5660300002)(2906002)(8936002)(8676002)(4326008)(31686004)(316002)(66946007)(66556008)(66476007)(110136005)(478600001)(6486002)(6666004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tmw2N04vcThuQ00wN0k4WmtRa1FtVDlUVFlCR1dDaklXN3FYZkMxTkFqTjUr?=
 =?utf-8?B?UDFQd0ZjZHY2SmdmUTFKVitOTXZPQ1V4TGVmejlyaFIxdldaa1pxc1FVRFBi?=
 =?utf-8?B?ci9UZ1pYM3I1RlpoVU83N3NTbkQ5MncvUzFSYU1NbnJ4RmlvMHhyQzFYdFlQ?=
 =?utf-8?B?SFhCS0xvQkJoekhlMWZrV3VoRDVNMklyS0VDT0NZUXBjOHZJeDJsc2Z1WDdS?=
 =?utf-8?B?YjVFMFpjWEZHdzV0R2tKejFBa0syOXRSZ0JRL2FyZWFCZ21wdERXWW0vWUJq?=
 =?utf-8?B?dXI4OFpkWnAxaTE4UmtTRzhtSFRJd3EzTEtwcjZjYlhzU0xkRDFzN2NZYkJR?=
 =?utf-8?B?OEp5QzlrV1NNMHFKbllLMWQzSnBxNU4vR0hnZTVwUUVpQm5aTVZTU04yMVRq?=
 =?utf-8?B?Qkg0SVRZMHAzY2ZrRm8xekkxRHpwL0RaemxnRnNNeDNkYU9DSmJHZUx5RjBX?=
 =?utf-8?B?anYyeHBKeUUzTTNXbDJTRnBlWmFHSXQycHlLbHJHakFMc1daV0oxVGNISmpJ?=
 =?utf-8?B?eWFXaEFxVDJ4U3RnRlRnd29JVllDcEFvK3RLUXRSMlFkMEFuQjNzcW04T2Rx?=
 =?utf-8?B?cFhOc09rbHlZY1MxUFdBNmtJeWtKWnBuWkV6NGNhdzNpaFpZRTRRV09XbGpO?=
 =?utf-8?B?cFFrTU8xblJ3UXdHNFRjZFNLMHQxcHd0VkNRMFFHK1B2Qk50SW5OVjdlUUNq?=
 =?utf-8?B?QXR2eTFTakJua3VKT0F1YnRHUnN5c0JZTHlqK09WTENkaHFSSUllTzBCdFh2?=
 =?utf-8?B?bWxZNVMzcDkvaFFnbi82N2N1Ty92T0NGb09TMTc1L2dtL09NUVRFM2R4TUxz?=
 =?utf-8?B?K2ltQ1FaWUFHQVBzaHd0ajVhbkUzWHExRlFGcHZMeFNFQkxTWlA2NmZuMDRN?=
 =?utf-8?B?QW1PQXhRUmF6YlBkMzlCby8xVzN6VG5PVFhQR1pHTTcyYmpkVEVHaGllcGlP?=
 =?utf-8?B?cm03Vk1HbmpqL3Vwa0s0bEhxcUI1bXMydVdNZnpQaHhTZjBjN2hwRHphRHNC?=
 =?utf-8?B?VSs2R1d1dzBlNjB3eHFKd3VQVk53NGVrbEM1NitGek81N1A5NW9tbENDNHVK?=
 =?utf-8?B?OGF5Ujg0SGsveU9IU0wrbU5IZENaSlQvZTZzZy95L1ZOTUdHQjlqVnBWbElL?=
 =?utf-8?B?ZDVIeFp1UTFpZE1lQ2w3ODVXb0ZXdk81Zm5kYVd1aGdnV0ZJQ01TNDQ2MzB3?=
 =?utf-8?B?d2pxdHFTRjY1OWJFTmRUMVlDREpOM1NtaHhiU1FYaEtqOUVPY0tJUFVtcE1F?=
 =?utf-8?B?WHdBOTRPaVJLUllTWGhaZ1drazN1b3J5K1BpRjN6WWZOdk5xU3pBbVY4ejNz?=
 =?utf-8?B?RGREVFpIZmlmYlJnM3pwQjRjNFhaNHpwcUg5T3Fsd2hyTnpRSDJyK25oTnJ5?=
 =?utf-8?B?cVE5dm9LTmtkN0FqaDhaaXMxOVBmaEVWdWJMTUZhcUlSY0lxQWxJMjl3VTFl?=
 =?utf-8?B?NWdISGRIWVFUUzJpbU5JSlpOUnQyS0dPM0xHMHBCeWRIZVpSTFVNVVVzYk1G?=
 =?utf-8?B?N3U1bWI4Rk80aHh6T2VGeU81L0VCVDkvdmYwbmpMV00vOVR0cUNEWktsb3o3?=
 =?utf-8?B?YStOd1kxb05oand5dXIxbGlCK3Nld0F2K1cyQ1BlMGl0dGM2T3gzZm0ya21O?=
 =?utf-8?B?MG1yOEllRDQ1V0xZV2JZVGFHVXc2QzJiSG9wYjdmK29EQTZ3aDRjZmJSVmJW?=
 =?utf-8?B?MHBNeFdzTVgydHU1VzBNajY4Y0EwS0lyUHJ5UzRWSi95am9VbktpaUhyTWlx?=
 =?utf-8?B?dzcrZSt1ZmxqcFdvTEF3TVY5dDgvZ3JNcjJhaUxWemJUMkFOSjdjalNFZ05I?=
 =?utf-8?B?eG8zNU5tMU1wSzlKLzNPNVRlRmlDYTVIZzFiU3RmeEhnckRCN05pM2g0UFRy?=
 =?utf-8?B?bEF0OXhNYW41a1RyU0MyNklOVDVGMjNhOHJpT1JkU29lRFNhNlI4eSttd3Ni?=
 =?utf-8?B?SHVaa3pGanp1WE9PSHdHTEhnUTlxeis2K0FaSDVuOG5oaXc5elZEQ1lGM2pj?=
 =?utf-8?B?aWM3dTBYK3NUWVlpRDVlYURrNTI5bHp3VEVpU1hucVBSZGJacGpDZFB2ai9C?=
 =?utf-8?B?UlZURkcvMkJoVDhhbFFpV0FRRUZJTmJyVkU3TjkraU9YV2FrSGt3Z3JJRVMv?=
 =?utf-8?Q?kTXL97D4PLxHUeC6dPG0TWyIy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a22002b-653c-4543-46b6-08dc016a9277
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:47:21.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tThrs685bAt45oWK1dpWGqOsYvOoOe+riGXHoc+ZOruodDJw5U6J+I8n4jzq/rEl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194


On 11/14/23 10:23 AM, Mathieu Poirier wrote:
> On Tue, 14 Nov 2023 at 08:22, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Sat, Oct 14, 2023 at 04:15:47PM -0700, Tanmay Shah wrote:
> > > From: Mathieu Poirier <mathieu.poirier@linaro.org>
> > >
> > > Multi-cluster remoteproc designs typically have the following DT
> > > declaration:
> > >
> > >       remoteproc_cluster {
> > >               compatible = "soc,remoteproc-cluster";
> > >
> > >                 core0: core0 {
> > >                       compatible = "soc,remoteproc-core"
> > >                         memory-region;
> > >                         sram;
> > >                 };
> > >
> > >                 core1: core1 {
> > >                       compatible = "soc,remoteproc-core"
> > >                         memory-region;
> > >                         sram;
> > >                 }
> > >         };
> > >
> > > A driver exists for the cluster rather than the individual cores
> > > themselves so that operation mode and HW specific configurations
> > > applicable to the cluster can be made.
> > >
> > > Because the driver exists at the cluster level and not the individual
> > > core level, function rproc_get_by_phandle() fails to return the
> > > remoteproc associated with the phandled it is called for.
> > >
> > > This patch enhances rproc_get_by_phandle() by looking for the cluster's
> > > driver when the driver for the immediate remoteproc's parent is not
> > > found.
> > >
> > > Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Tested-by: Ben Levinsky <ben.levinsky@amd.com>
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
> > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index 695cce218e8c..3a8191803885 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -33,6 +33,7 @@
> > >  #include <linux/idr.h>
> > >  #include <linux/elf.h>
> > >  #include <linux/crc32.h>
> > > +#include <linux/of_platform.h>
> > >  #include <linux/of_reserved_mem.h>
> > >  #include <linux/virtio_ids.h>
> > >  #include <linux/virtio_ring.h>
> > > @@ -2111,7 +2112,9 @@ EXPORT_SYMBOL(rproc_detach);
> > >  #ifdef CONFIG_OF
> > >  struct rproc *rproc_get_by_phandle(phandle phandle)
> > >  {
> > > +     struct platform_device *cluster_pdev;
> > >       struct rproc *rproc = NULL, *r;
> > > +     struct device_driver *driver;
> > >       struct device_node *np;
> > >
> > >       np = of_find_node_by_phandle(phandle);
> > > @@ -2122,7 +2125,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> > >       list_for_each_entry_rcu(r, &rproc_list, node) {
> > >               if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
> > >                       /* prevent underlying implementation from being removed */
> > > -                     if (!try_module_get(r->dev.parent->driver->owner)) {
> > > +
> > > +                     /*
> > > +                      * If the remoteproc's parent has a driver, the
> > > +                      * remoteproc is not part of a cluster and we can use
> > > +                      * that driver.
> > > +                      */
> > > +                     driver = r->dev.parent->driver;
> > > +
> > > +                     /*
> > > +                      * If the remoteproc's parent does not have a driver,
> > > +                      * look for the driver associated with the cluster.
> > > +                      */
> > > +                     if (!driver) {
> > > +                             cluster_pdev = of_find_device_by_node(np->parent);
> >
> > Both the Ti and Xilinx drivers are using of_platform_populate(), so
> > their r->dev.parent should have a parent reference to the cluster
> > device.
> >
>
> So you are proposing to get the cluster's driver using something like
> r->dev.parent->parent->driver?
>
> I will have to verify the parent/child relationship is set up properly
> through the of_platform_populate().  If it is, following the pointer
> trail is an equally valid approach and I will respin this set.


Hi Mathieu,

I addressed Bjorn's comments and verified on ZynqMP hardware that it's working.

Let me know if you would like to see v4 with suggested changes.


Thanks,

Tanmay

> > Unless I'm reading the code wrong, I think we should follow that
> > pointer, rather than taking the detour in the DeviceTree data.
> >
> > Regards,
> > Bjorn
> >
> > > +                             if (!cluster_pdev) {
> > > +                                     dev_err(&r->dev, "can't get parent\n");
> > > +                                     break;
> > > +                             }
> > > +
> > > +                             driver = cluster_pdev->dev.driver;
> > > +                             put_device(&cluster_pdev->dev);
> > > +                     }
> > > +
> > > +                     if (!try_module_get(driver->owner)) {
> > >                               dev_err(&r->dev, "can't get owner\n");
> > >                               break;
> > >                       }
> > > --
> > > 2.25.1
> > >

