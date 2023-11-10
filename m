Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1F7E82FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346388AbjKJTkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjKJTjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:39:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C917E2508F;
        Fri, 10 Nov 2023 01:46:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRpovgU9nxgmuQ0AeVptsu1xYdMnzOlrW2S2S3lg7DaKe+ECLG4gqs/8oiWrZbv9U8Pp6xvj4wOYZCwd782gyWlTE2TrJKcYvhr3yHdsMLVF2Lh27l130HduRmacGBSl6Z0fnPiTuhqXT/FCJ+ai/kR3rOdNNPtSiBeNfBZLIE3R+px/3m86pGOi4Jv6x0OPQSC3FEppUIgZQ4gy+v2rsU9HHYDvCukbxwykvpEbYR51OQlA8cYMPkCCqSIiIeZcn+V/EWK0Zalk1TUcxPUKMRSBVwNYRgFWTUxDXR9NxaIo2xBhVLjHT/R36wDhT6O/ir8QzKDkoi6uWO0UiBiiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tu69UdR1l4uAzcW1HKByJdIrDMQCaDkxBQ5nInXxSZY=;
 b=l8+43dg74KVCNB/pms9olP2JUmcdnJ4zCE5VvYwI3p6/DXnGP+A3/VVejCpLh1FJtkVJfF1MDu/AG9RlsTfPxsWamVr6Db8KuKwxKV6GliMBcBXHckQC6i3II+gSzjNYV/zCIoj60K0uglQFmDkOvdCU8MhzRMn4VDreJgAASyYvXcFQdxvJdX0xHAqD+31znN0JKLpNhzP3eibg8ptm4tL6tusp5jVFeNlcoI4zapp82qUX61IXBX7yIOEeg0/A/yiAf299XuFEd9Fu+Dk9G4jQkJ+Jo2BfJaHvJHtVv/lXwyEwUfSe8J3ApmCgESgaanwbx3hDjauqYRfW1tB/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu69UdR1l4uAzcW1HKByJdIrDMQCaDkxBQ5nInXxSZY=;
 b=FQY6adheShZA2Dfz9ww4DGAcqAEx5jPTyQ7Ae+txm1m2MrQ70f7OH291QYO1TyYvr/3wI9dOKGNQALSBjQW8HEDFJS0fD++EX6Fo2pn78GcjQlu8wde1Gq9UCSaZv5CMvyd0waDRJHeviHur/+xwZHApbwL3nSKmDthSJKc3f8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 09:46:22 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ffab:2acc:cf5:1616]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ffab:2acc:cf5:1616%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 09:46:21 +0000
Message-ID: <f42bf6b7-75b8-124b-c79e-ad7a9b706990@amd.com>
Date:   Fri, 10 Nov 2023 15:16:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] perf tool AMD: Use non-precise cycles as default
 event on certain Zen2 processors
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     acme@kernel.org, kim.phillips@amd.com, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, changbin.du@huawei.com,
        yangjihong1@huawei.com, zwisler@chromium.org,
        wangming01@loongson.cn, chenhuacai@kernel.org,
        kprateek.nayak@amd.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20231107083331.901-1-ravi.bangoria@amd.com>
 <CAM9d7cgs9Wk0OFoea4jOote-drHjvCimJyt7GWdO2Giw=d7Jog@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cgs9Wk0OFoea4jOote-drHjvCimJyt7GWdO2Giw=d7Jog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c8ad9a-72ae-4301-0a42-08dbe1d1e4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBAVU0ykVV2A0dCWzkiTa1+YN6qKG+OoW9Th3mPgvUV70dn2D4PU7jOkthsUqgyy6f7ShXGRWDyUYaiIfO2GIEn9r32NiLcrTJRWL1jBX3V6ClUrfR3xE4YmNPO0Y5T3bslbAUzbQNCfffcJdpbnYja5Ixe2xdxMcUqFo9RNbpa3jcLXQh7WmH2eqA0giesdkOgXg1YZ9JzvX43SqKzPDRbxy6NWJv0e2K8ejycWJwDAN6ZL656d1POHi0oZ+d9IHnZ09LuIPjm/8cDECDb61oaLftgZS9oDguvkU61GWeA/1hU1IjVrBLP4QCJv6rOtNvPK671DPfzDGK+ZIJRpw91F1v9zSploh+rqWuq8Gku7I5dIQoTX9okZMooTggNoDe6Q6FFeKD4QHaQLsZfBfb9lcYuh+k3iOMGdiqF5H5/Jpi7Q9rjMA+lOJzyJcKly/M7OdGDaVkhf/ZNvGC4fD62V+vMzduoC0biK1Qw0dltCUvbdAl1pY6rXvAmHI9HF0KHkUJaQT9uSHwAwac8kGJzCgnYqTLnxAjMATzRuiJARLcFnfj0G9UO+uBJsm3UIGDQb7dDihkCIvzSrV78ReOjhY+ZX+LCtKbtnxMQJ8InFajg47Ri8xmYzaELJE5+eLR2vW8EwxVT8pzpPOPJ45FltgXuGeTURzHSZ/Tz9WxYMQmizNb1kgSCKH0lMzPoh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(1800799009)(186009)(316002)(2616005)(26005)(83380400001)(66946007)(6666004)(6506007)(478600001)(6512007)(66556008)(2906002)(8676002)(8936002)(36756003)(66476007)(38100700002)(5660300002)(4326008)(41300700001)(31696002)(6486002)(4744005)(44832011)(7416002)(86362001)(6916009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXlldTN4VWVESmVEelhlNjhjaUhIaXNtckhibW1XZ2xwK2RCc3hGNHR0b2Jz?=
 =?utf-8?B?RE0xUEo4Tms4RXlNZS9nb0FhOU9wbmFuTG9sUWkxdzhTRkNyNm5DMWt6K3h4?=
 =?utf-8?B?NGpYMExGUUxpcHJnTGhwVzgyVVlYc3AxN3JLRVdRQnBFekNKNzJHa2lTcUZa?=
 =?utf-8?B?czQreHhvQ2RBTjEwRytwRFFrSVJsSFAyS0JNaHkvMWhLcm9Ma0JrQmtkN1do?=
 =?utf-8?B?ak1lNWMxZlRBVGNOVVpGaWE3ZmliNm0rNkQ1S1BDUEFLTWpQbnduVGcwWUpB?=
 =?utf-8?B?a3p5SXpaTndKSlJTOW80blZob0RmVnYyZC9PSVlVa0Ywcmt5UXlQZGRpQXpF?=
 =?utf-8?B?WnJ0eHMxdGxFRzJ6ckwwZ0hndHBQNlppMFZPYW53VlpseHNEZ3AyN0RzTnNk?=
 =?utf-8?B?Tk5XSGdIeW14Z1hzMW9SeEFzZXNQRHdjNzIyT3RuQ3V6M0dTYVdrZEIrYmdv?=
 =?utf-8?B?MjlHdjVoeFN5UkUxMnpTUjdheG56dTFHam1wcHA5cEF5SDFXOXZQT0M2bk9q?=
 =?utf-8?B?ME5NUitEQlNSS1crVUloSGd1WUcwb1BEYnlvN1JYQmF1Unl5QlZHOGFOOEVE?=
 =?utf-8?B?dGFpZm1BeXh5VGJhYzNmRGZBWU5PcjdBODZyOW5xbHFWMER4VU0xdi9jTWEy?=
 =?utf-8?B?alpKUUI5V3Q0c2NhanBiWFFkNVE1citQWHM3MmY3QmJnQjNTQ0Z6cmhGSGE2?=
 =?utf-8?B?dUphR254NnJKaFpna2loRTM0eFJVSHJyN0Zhd0NrNXpvb21hWmc0SlRYM3Zl?=
 =?utf-8?B?aktlTFBRdDlsY3MzYUR6dWVFMTFKeVgwSUZsMFJ3c1N5a05RZjN6VVZDS1Nq?=
 =?utf-8?B?LzVmclJTcEZab1RIc1l5M1RxcThsV2xMWGpZeng5dlNZSm5Wd2lSNnFUU2U1?=
 =?utf-8?B?bTZiZ0lIVDFnLzJxZHhDQVdpTFo5N0M0c0I2YnM0OTJMbFlxYVJSZ3RkV1hw?=
 =?utf-8?B?ZExtVUtQMXRKYTNnRXpadkNnOGl1OW5sMzlJL3BDVHg5a214MWhlT0dHMDZn?=
 =?utf-8?B?SnNJZTdRZnZFdmNzQlI1T29wbnJRbVorYnFPNUVMT2tFMmNGb0w3djVoYzFh?=
 =?utf-8?B?VW0vVXltZWUyZXJsSjRFbGRwR1IrTEtQWkhmN25HRkV2a1M3NXoxWXI5UGph?=
 =?utf-8?B?dVR4RGRJQktTQmh0aVZleDVhR0hSeEZSSnhWc1NqNHhYSjZ3K0dyYlEydzVl?=
 =?utf-8?B?SU1OeWZhVjhGeGlYU3ljSzdUK0tDZ2ZWUlNOSEFoK3ExNUJnWEdIMHp3Sk1U?=
 =?utf-8?B?WVUxeE1Ha0VNK051eWVoZjR3WEpHZE9IU2JOSkJFK2E4WldpOE9IVWQxamEv?=
 =?utf-8?B?NWtZYUV0WVB3Q1JUQWhVNjNJQmhtNXMrNUJ3K1R6SitYUVBUNzVWNVl4REla?=
 =?utf-8?B?YURocWxkeko2NGUyeUhFTXpNeHY5RytoWkUxblJjdU5HcWwyNGxvc2RPS1lp?=
 =?utf-8?B?N0Y4dzUvQUlodGw4ZEl0ZXZXQ0k0WHFZSlBqSDdzeXJVSXhNNDkzcVdzS2kr?=
 =?utf-8?B?aGRzMzE5UEYyTDhveEp4RFFBRHZTYUNEOHAyQVVPMGJSNnB2L083Tmp3OVJK?=
 =?utf-8?B?eEV1c1dvUVJWZENXYWxQeWxLd1FZSlFwb2FvaWw4YXU3ejNEZEVjemVUenZ3?=
 =?utf-8?B?ZUoraUwxV0JWdHpnU1FjcU02NFNNaC9EYWJEZXNHWWFMWnMzejhRZG9aUkpu?=
 =?utf-8?B?LzZHKytrd01laElTOTZ1d2ZSNng0bTV6WlhFT013Q3JjNGRHQXBWV3NvMGhD?=
 =?utf-8?B?VytzMlpaOUE0OVBBNi90V0tkVGlNOWJDaWhwQS9LUkhiT2dmM1pvMldlalc3?=
 =?utf-8?B?d0VjSVlITlU3V3E4MllsYlllSy9NaWlzQlNkREp5K1hWcHN6bmdTUVMyTC9k?=
 =?utf-8?B?ekgvdGpsSCtFNGxSQjM0eWdvQXl6WE05VkxiNmtSa0p1U3Z4K2dja3lIUU9J?=
 =?utf-8?B?RWh1K1dOa2EwRklaM2RGa3FwamhWYnA5b3V4N1c1dGM0eXBaZWJyVzdNUVVa?=
 =?utf-8?B?Ny9JR3IyemtXTWZnVDk0YkNKU0JSN1FZNjRHOHRncVF4dDZwUlU3WjVTNlhH?=
 =?utf-8?B?amNjUUhtbStveE9yeStGRERoMlJieGlFWkhxRHRMSWt0WVg5UHYxc05EWnc4?=
 =?utf-8?Q?vNQTLIZcm+FepWmeo+POvY7sW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c8ad9a-72ae-4301-0a42-08dbe1d1e4c3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 09:46:20.8976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+1pOcTH/XI2ZBvrnAseBXoaIHszFrJK0QlroKqi8ZdaH2dlcSFhoA34Xsn8agwmpbWROdqTgz44QkKuwntT4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

>> By default, Perf uses precise cycles event when no explicit event is
>> specified by user. Precise cycles event is forwarded to ibs_op// pmu
>> on AMD. However, IBS has hw issue on certain Zen2 processors where
>> it might raise NMI without sample_valid bit set, which causes Unknown
>> NMI warnings. (Erratum #1215: IBS (Instruction Based Sampling) Counter
>> Valid Value May be Incorrect After Exit From Core C6 (CC6) State.) So,
>> use non-precise cycles as default event on affected processors.
> 
> It seems like a kernel issue, do we have a kernel patch not to forward
> precise cycles or instructions events to IBS on the affected CPUs?

I'm not sure how it's a kernel issue. User can use ibs_op// pmu directly
and might hit the hw bug.

Thanks,
Ravi
