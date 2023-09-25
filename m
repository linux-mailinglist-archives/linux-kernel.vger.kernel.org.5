Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EF27AD900
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjIYNZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjIYNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:25:44 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07379109;
        Mon, 25 Sep 2023 06:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPBIHdWXkf5NcjumMO2h5H5qq/evhUS99xgIVS/cSzmrNalMqzXkwtmClQnO8NojJNwd6NByLAxc7TDLoGB6rXF5ezzWAcTyQu4lryEYSrM7UbYdekKo3DYAxwyZfyXhlPqDFBeQMr2B3eU0x1rvCxKK6ZZwAlovLiZ3VpmitYwCktuXHDqgHeYnSvfbREyebAvzrKVCY+W5ii3mNB1IPK620f9b4VJw7EQju93D5QvBLfHI+DMWjWrhfLCS6793CUqt8pXjgEtyGuEQlAu5debNObbDkgKmHIiQcPMYIwkMO6t1Cv3RnHH2G3QIDdrqJtG6Ql72KSHmbe8mwZ86LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xjCa6tKMKiA69jCD8NO10QS+q3XbvKykd1Ez6jAdpc=;
 b=KOEteKqGrdUuYtOJpieFcxEisDIMkozy9edb8v+DRu7MpDsFiOhvC+Q8FIXZJOuzNq4T/Of4+muoPKdg8g05PFXbJ2X+3NnJ+QncRLsY+bVypMRCehbwd0NHohn+MW8GVHQJoHQcRXqBqUqv5nLyqW4gkwnx/OzsB5OPjHLvpM8CwB11O0hn9PxexQp3xscwfj9wjz4zL8J5i+pQvS3lAtF8Fp7ZtMcGoiQeUYtOb+lg/9vI91zBctqrgWLOqkJmz2VGSil6jYPKdieCU/1qdD+j437q5pfqIxK73x65n9vrLHhXUUv/6db+qPP2C/dBa14pfe/7jCYptgJgjx6x4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xjCa6tKMKiA69jCD8NO10QS+q3XbvKykd1Ez6jAdpc=;
 b=pGAMCqFGlSXSzMh/UC0NkdDxdF7rTUErMETpAMduwpNc0IWacHah84BydnXsdxLrjmVojMZxNqS/2GbOd3QtIFE+PHG1GELGcWiwWoAV8C4BMeP+Z/CMLof3++44iz65X5Cl71is64pCwOTaYtO4xgHVijMsm1dFSXQ8QhiGOow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34; Mon, 25 Sep
 2023 13:25:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 13:25:34 +0000
Message-ID: <e556ae63-0539-4b34-b33f-5f5beb4183d1@amd.com>
Date:   Mon, 25 Sep 2023 08:25:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: s2idle stopped working with 6.6-rc on Thinkpad T14 G1 (AMD)
Content-Language: en-US
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <0d84fb59-4628-4c7f-ab1a-f58889ef2c9b@leemhuis.info>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0d84fb59-4628-4c7f-ab1a-f58889ef2c9b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:806:121::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 8592c461-bbdf-4163-63e2-08dbbdcae62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsGxeuO7CgJ+GcKRg2USyyJPNkD+LrWEvvDzJ04Ud6tSc06NsjighgUnUzXm+FKUtlnfUtF9o2vErpSuUkzN1ZU/euv4Z3DvV8Oqjq+yL1/Hb92zOoQXpu8OdeikQBjo9G9g4bCDaA7RZs/r0kuA4F3wxekPYNVSMToVmdL6Vr+lj8a78GzHzRh6kXoAgLOLPoelZeMeiF07jz3mzho30WVbOL9EOBfbVL/fVcOLVMhSfPvPG3p68Lcrij6cB6W07b+lz0PR1FufFz/aEyLINhql/Cb9F/1TLFo980qFWNkzo0SDDplLCjZzymEFyOKD8Y1DQWwKou0JfSzZeRrFB5gbyNgT60tKKRTR/z4rZD4PzorlHyAu3EA+z5YClasFni5pk9Vnmz3G13eL56yenmC+IqzCVfBTSHeTikhs2dci/Z5tfYfx5xDAyoxtzGL9xUwRXqP0EIzsjPl/u8nALwABTTUy4NeO4BBno5BGRxGeCDUuHVr3/hgxyDh4XtVqT1HlyPEnbTsmiQ5Bw5n8O7eIA3dZ+BN5HwNxGnehNhudad03PsmoSA6sv04fIU8HwGE9kMkPmkNHTcyGRfiT+OWzXVQhlqc7Ca8yJUwZjdSeknBWwrCN6BWhNLjNF6ecLq7aFHVTp6ux4ApQTee1CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(186009)(1800799009)(451199024)(86362001)(38100700002)(31696002)(36756003)(478600001)(2906002)(966005)(6916009)(6666004)(54906003)(66476007)(66946007)(66556008)(6512007)(2616005)(6486002)(4326008)(8936002)(8676002)(6506007)(5660300002)(44832011)(31686004)(316002)(41300700001)(83380400001)(53546011)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3JKVjZpZUtIZWQyd2l2TVNjM3ZCUXBHYU94MHR6aHI4UEpmOEJtWFdpK0NO?=
 =?utf-8?B?VUlUU09CaGF3WC84WS90Y3ZuVDgzdG5kVytxOVg2RzUxcW5tQXgybitCVHd0?=
 =?utf-8?B?dm5DOHJKVUozMjBsVnJicENWQkNpd0pZZWRNc1Q1M09tM2tTZGlhVzZ4dDh3?=
 =?utf-8?B?Ti9uVHViU1ZpWVc5RXFXSXhaeU9QaVExUi9QM28zU2FyakdpTFA3RzY2amR0?=
 =?utf-8?B?R0F6VXhsbm80UlJhRzNJZVp5QVJGVjBia21nTWFtaHMrc1pEWjFUY2FFdERX?=
 =?utf-8?B?eUZ4VlJyQWNHOFRBWmYvdmNjalVkSytSNldHMVc1dlQ4TlB4dWcrcGp5dkMw?=
 =?utf-8?B?WU9lZWVkTUVUelF3YS9JUmRDWVBCR0NwQ3dvMHROV3Y5SHFxT3pBNmN6QXdt?=
 =?utf-8?B?c3FxQmZ4TGZMaXFFK2VwMWdsam5QWDMxak11dFhoemc3Z29DT0ptWkdYbWU5?=
 =?utf-8?B?TG5jd0dKQTREY0V4RFJpbkx1MDN1SjRNK3RPREFsdEZXY09YZlZCb2JwQ2Z6?=
 =?utf-8?B?dVdLQlVhYlVJcjdaMkNBUXhqQWszajgrK1QvVzBzNUNXZWl6dDkvYkhMcG5K?=
 =?utf-8?B?RW10QkNWZjllL2NFa3lQdTBXS3FkdWtXckUvc3lFWVhGWnZXRjdzWUxPWStZ?=
 =?utf-8?B?N2R6RlBqUVlmN3hocHpjM3d3L1I2b3NWdTYxbEpmTVlOYmFCaEg5Nkxrd0Ey?=
 =?utf-8?B?ek1WNHJVN3oySkpDS1lhdU00NGhmSmdZVDlmc3BqeDVTckRUVk5ZSVYxSHd0?=
 =?utf-8?B?VFRSckFkZVJqOWFBVnpHN3FyMnJBRjhyODAvdUdVLzlrRWIwRkZncFdSWmFB?=
 =?utf-8?B?VTNYWW1BNVB4MGx1RlFGa01jOWVFeHZnc3VsSDFuNnBDVmZQUEU1a1ZXZExF?=
 =?utf-8?B?eUh2SEpRUXF1OEFxeUt4TEZTdVFnY3NLVTB0a1puRjJjOE13SmFwdnZtNGQz?=
 =?utf-8?B?R2xDMXVHSkZpZC83Q0dWam5xZ241S3RwQy84Y0dCc3F1MWhTTUo3UjI5KzV4?=
 =?utf-8?B?S1ZCZ0h5Tmt4QUdMMXBwZnNhL2d6OGE0UjBtZ3dZUlh2NFVZWml2THZuT05C?=
 =?utf-8?B?SnYrYTRvZ2liMWZhenlJUERwa05xOFVaRHVaZXozZE0yVVpxckZpU0NSVElI?=
 =?utf-8?B?M3UvODNRVG5EOVNZc0RFdGtnWWRNRkg3OFdhTUFNT2hTcHNGSVk1cXEybVFk?=
 =?utf-8?B?dHBBSkQzSzFPczVIQXRTczFmMmxoR0VtdFZYMmNhc0tSM1hxRTNXY1d3eXRy?=
 =?utf-8?B?UDNTN3VwWk1vUXB3aFM1bStKWUw5YmR3L1lucE55dXVENnR1c3lzTjhvVVBt?=
 =?utf-8?B?WGpBa0c1SURaallXRS9NajhUTzlkS2hZMDZjS0RUdTVKSVJ1d3pGMEpoUXU0?=
 =?utf-8?B?SFRJQzgwRVdVOTFCWXVxMjMvM3gxOFo5N1doMjRwYWNJWjZnOEloRjg2NjNx?=
 =?utf-8?B?dkZKYnhlZzV4eUdIbDNodWtPY1ZMVmlOTnNWbkt2UnN0bzRPaGVwY1FTcjBK?=
 =?utf-8?B?alE5RzRpemEralFVeHQxQXRwSG1mNzlqcUROMTZqakNwbFc2SUkvTTk5RnFo?=
 =?utf-8?B?NExFdUhXVkRxd0krWkdYazEvR2VtbVREM0s3d3hDVDNUamVxMkRaa1J0WXE2?=
 =?utf-8?B?TFdTc3RLeHIybWtGalN3VUtIYytiNEhSZVZHcnUvTVU0SG5KdzZFaXI1elhG?=
 =?utf-8?B?VlJXb2VLVER6YzBZQXpEL0hQNjBhQUQzSVB2d1JwdUxYSG1LY0dmNGovRVV6?=
 =?utf-8?B?UnFDbUo3a2hBQlJ6OTYwYUVvNnZWNUdZcHNEcXpybWl1WGF0MWJLZW82bWFH?=
 =?utf-8?B?ejg4QzllS0JzU2JHWjNuWFBzSW5Lb3lPOHlnV1ZBY3V6OUdNKzFkY25LZHVS?=
 =?utf-8?B?Zkw0WUtnakIxL0R3OE1lenBJTThDV1ZCa01IL3gxQkc0ZGtZM3BWTHF0RFFt?=
 =?utf-8?B?WGdYRGFHYjl2cC9YMHVUWTMxYTF2eEhCQnE3aEkzakYwRkhLazArdHR0amZZ?=
 =?utf-8?B?UDR3d1pSWit5dXU5TlRrN1pLYXFPcExFTWRZcTBuUTQ5Z2FiWTBINFU1QWJR?=
 =?utf-8?B?bUxMdHZKNkZXYTI0YUtDTHdadUQySWhZL214L2RSaHF4SzlKTHJCTDRsT2du?=
 =?utf-8?Q?14BYkpHUxnNdeyTaeUdlzxf0A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8592c461-bbdf-4163-63e2-08dbbdcae62a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 13:25:34.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzV/+KxOI5DKzxM/fWbLK1oM3MF8i28intNTBtkbOw4bjZktHU/w1rQzTl08DqmcT9MG8BNxHphRlSDKjijXhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/2023 05:55, Thorsten Leemhuis wrote:
> Hi Mario! Did you by chance hear anything about lock-ups on resume with
> mainline affecting AMD systems? I'm asking, as s2idle stopped working
> for me with 6.6-rc on my Thinkpad T14 G1 (AMD). 

You're the first report I've heard of this.  I've personally done s2idle 
on 6.6-rc1 + patch to fix the UCSI issue and 6.6-rc2 on a newer model 
(Lenovo Z13).

I haven't checked 6.6-rc3.

> I'm as of now not sure
> exactly when the problem started, as 6.6-rc1 didn't boot for me due to
> another regression fixed for -rc2. But 6.6-rc2 was affected and -rc3
> still is. Haven't found time for a bisection yet and will unlikely to be
> so in the next two or three days, that's why I thought "ask Mario, with
> a bit of luck he might be aware of a problem or even a fix".
> 

For any bisect steps that are failing to boot, I suggest you either 
compile without UCSI support (it shouldn't be critical) or apply

f26a679ed799 ("usb: typec: ucsi: Fix NULL pointer dereference")

> FWIW, I ran your amd_s2idle.py script, but the machine seems to lock up
> hard on resume, so I guess it's not much or help.
> 
> https://www.leemhuis.info/files/misc/s2idle_report-6.5.4-2023-09-25.txt
> https://www.leemhuis.info/files/misc/s2idle_report-6.6_rc3-2023-09-25.txt
> 

Yeah not too much useful stuff here unfortunately.  Can you check 
/var/lib/systemd/pstore to see if you got a traceback for whatever 
caused the problem?

> Dmesg for 6.6-rc3 (with a USB-C dock, but problem happens without it, too):
> https://www.leemhuis.info/files/misc/dmesg-6.6_rc3
> 
> Ciao, Thorsten
> 
> #regzbot introduced v6.5..v6.6-rc2

Being G1, can you try "amdgpu.mcbp=0" on kernel command line?

