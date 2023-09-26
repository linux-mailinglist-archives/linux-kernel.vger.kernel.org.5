Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFF7AEDC0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjIZNK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjIZNKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:10:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E392101
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doU5FOW6/0C2zJjxh4rCzODfENgIVC/XcEM6F8VmRwymp3n7f4Z9mtQ/213HZ0cQbGtnMtjWF//fpA8xyDNaoRWK0j55y++jgReeaH4pNhtExj7W//AzqTBaqYpB6hVPwbfGJRedcqUYB2QtZG7jrTmX6jf9nldEFvUpD+wTHi0aOkW8lh19VziPhUm1eqY0tQy4fbYZn/9S3/GP1kC4oh1T11B8oXruDqqWreOD9WQEMc9dyTb97je9g5uezlwwCnJuI9cle+DpK0hENQxSQR/6E4Xr8jyRCC8nOtqAXYJHd/+hV6mgaTIORalzPHwsPSD+V4+Jfjn4l7CBADyAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QlnEnsKacvobnsDeAgw6At/DmH73nHuGp5gxtZAQpE=;
 b=BjItKItajpB0drC8oU3jBs511m7CEaa4Kuodkeh29v2AhYEXyBFh6sUovrHAoSZii9Qjoh4+0/Seh8JjwTKJPLVphN4Moh752BrhxN7U7Pcb+tmL+cedwhsPrrQFFMDWSMBGTyJN5WOymr3idA/Ga+nfXW+IRLeSOmJB3e77yfOMUyDMiw4kS81iJdlmxWAY1N+ZIdeX94A61CNgnSyG/fle2xMvHj2c8hWGhdWY2OOklVI4DlfF3S7bX3Llbet/iXe4eIuJtCrPnlZNTcx1J/XN57Faloc1X4g5wB+l1HFmHx9614bj+Ozv+40kj7f1pBLqeUZAwV44tR/AyQh0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QlnEnsKacvobnsDeAgw6At/DmH73nHuGp5gxtZAQpE=;
 b=qW2WWpkiUkntfDdHjruZtRi5/xIKQwOZmRyhvbLfHFdUdBikRoG0m9AdrCDsVGzPlufwQc52DdHKQGzOf/gUGK4fuQG5jgkvo/Wh+W7cMmCUTWFBQ5OtQ6JmAlWRF3HJqToVrX+C6iA8Ppbms21Q4SxBVsc8FhnPCuUoa87n3ho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 13:10:46 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 13:10:46 +0000
Message-ID: <74b29e02-5a18-fe86-4e51-e021ec7e4c53@amd.com>
Date:   Tue, 26 Sep 2023 18:40:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
Content-Language: en-US
To:     tglx@linutronix.de, maz@kernel.org
Cc:     gregkh@linuxfoundation.org, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
References: <20230911135259.14046-1-nipun.gupta@amd.com>
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20230911135259.14046-1-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::9) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: a5955eaa-756d-469c-5a17-08dbbe91fe96
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06IviWmX96j+iS42rgkUCxR8f65X3C1Qrz/kd4Hxjn4NNpQ7WkETlLKmUKO9M3gtPPD3V6+Z6s0V4RH7EcUuX3ijQLTB/eyjNcH1UTtJj+MrcI7WMOQBSCn07NeBum5TOHalkLf/pBD8hOtK52S9YAz+Qk91U6yaNzna/BcrFi+cs8zVhG2ncGpicZkjfe5/eW0nRGGyvZZWzBkTRZaC9ROsafWzRRKBuqM8dDkZqw5sxaQvOTAyPUNCkL8xPwClBUulY51zEgpBTY1kgPyjR2y+gNiEKnqOmDArEyvYdI4z3KhRJSEHkkj4XD5KvcGj+PPKgdN7Wx8AGE6ofz1nfRWE5cECTWJ5tULevAx4nVJ4Ecy+1QQpXyzu19b1dzcLrBt5rRWSTBUjZ06jgXjdfy0ZgN2H5yfVLFO8cOSMohZVvc8e2BsE9Dq/rZ6wH3Kc2cVal8Zc1bJLPEp+W3MzQFk5H/scYjqGDvC2BbvdhYZoILK3/pDFuDDyk+cxSrJuCSchIHBG7BgwUfFumUQNU2AUE8p2GS/ss+MpG67rbzjEt0uJH1viI8Zf4tK0J1gZoT4myTiPhRLu3Z1trkDInbyfLij9pKZ8kezxahrd9YRu8DH/7wxEapKxES79X3rV+2kQnLO9oC/BzVKFm4xJjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(26005)(86362001)(31696002)(2616005)(36756003)(2906002)(66556008)(66946007)(316002)(41300700001)(38100700002)(66476007)(478600001)(53546011)(6512007)(6506007)(6666004)(4326008)(8936002)(8676002)(6486002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEpzNmxhL01qWGZzQk9XQ1paeWgyZDU3dWI1VjN0bFBWRHJPYUloY2FHeHN6?=
 =?utf-8?B?Y0Nsb3FMWVJpRDMvcHUxeUZ1NllrcEZ5V1BwMkd5MXVpMHhxVzRzbzErVDRP?=
 =?utf-8?B?MVZWSXVUN24xVUViR2dWVU5TS2VIeWN2NFRiMlFWbXdWU0tqU0RxWnNlSkJH?=
 =?utf-8?B?RFYxWmR0eHNlUWtLTkFkd2lqblV2QXc5a2o0ZTJOdTJDWnBuTkhMY3hFM0FU?=
 =?utf-8?B?LzhMRkM2K1FYaDhIVWNYSUFxL2UrQmJ1OVl2d2taNHFMdUdIdDU1NEdacVFz?=
 =?utf-8?B?eU5VQklJV1hqcFJ1czBaYTMyZmxKeFBqTHl3NGt1OTlUT0lsSnF2dVdTU2dP?=
 =?utf-8?B?b1ZvZncvbndZdVFmSzhBL2R4SENka296QWw0WXZSTGs0WXAwQVlCUDZPZmtq?=
 =?utf-8?B?YjRIVUhXNU5jTEV1ZVdEeTBpWEFVaTdxTThyaGk1NWJoMk5jU1dWZnNXWXRQ?=
 =?utf-8?B?dmNBK1NHVmJJM1NNak1ZdjlrcURqRGp3N3I4QjM3cFRrVkpyeVJBOVc1Nmpq?=
 =?utf-8?B?VXBZZFVLYXVjY1pxK0pjSDV0VVdVZjAzRW1mL3NoQWpta3Vzbk43cU95V09x?=
 =?utf-8?B?Ni9VYjZzZUc4dHRBWjViZm8vbW5QU1lGRVUrdjdKSjhDZTZiWUtZRjN1aGcr?=
 =?utf-8?B?cXdXck5mcjJlbUdrMnY0a2lVN3dGUGREWEZuRG9FZE05SDU2MldHV0JVV0dE?=
 =?utf-8?B?ejRzZmQ0OUNGcUhxVXI4NFBHUGY2d3l5ZlBzcENvdFRUTmdBTk96RFFYc0V5?=
 =?utf-8?B?dHZyUmVFUEJmUzU4WEZYWEhna280VTFmZFhJbmQxRGVLYThNYSsyMzFmaUg2?=
 =?utf-8?B?NzhZbGhDUDI0WDVmdUo4MEF4WVk3cy95eU5LUzRKSlc0NmtJejg2SkR3YkRi?=
 =?utf-8?B?L3hrYWxmV2p0ZFUwN0Y2NDlqVFk5Ulp6QkM1cS81OU5RWlM4VW1hV2FGczNy?=
 =?utf-8?B?bytkaDNVSjRKVWQ2b0FqSktHa3g3clI1aWlFVFRrTDZwbGIxL09DOGxLb242?=
 =?utf-8?B?SVFPaitmZkUvSCtxdE93bThob21IWUo4cDBoRjc1RVpnK3ZIanpaYUI4a2dn?=
 =?utf-8?B?MG9WOXJzOGpMeU5jTlZTSkxLOVlLUWdCYldBY2s2ZDNlVnVqMzJYVW8vL1F4?=
 =?utf-8?B?YzVvMDVQeE9XQ090OUpqTnFRdk1sR1RNTGc1a2VoczlYQjM5bHp5eUFKNk41?=
 =?utf-8?B?V1FNQml3bEVzMG1XU2NoSExqUExlQW5kU0tMTis0anNzUXQzSXAwcG5Ca0tk?=
 =?utf-8?B?bWxXY01iQU84N3dNa2FvaXZEUUw1cWNKTk10SDBnaTI0OVNPUENpS3k2RFRm?=
 =?utf-8?B?dnpOQWpCNm92a3pTY1RVZTh4SUpQRlkxaTdJbEFRNGoxdDJ4VkRmSm1EZnVu?=
 =?utf-8?B?VDMrZy91TlpOeUNLY2lOZm05L2NZRjQ2aU8vM1duUFdCUk1nOHUyZ2t3dmFF?=
 =?utf-8?B?aVFGWGlkU1pNT0ZYVTd1QS9ZcXZVMG0rR09uMGtjb3NHV1o3bTY1ZDFWT1Br?=
 =?utf-8?B?QkVrY1YwYlYza04vSS9wUUVvZjF6WEVHTkNnTW92eU5wZS9GVGd5QmNPK2NO?=
 =?utf-8?B?aUcwQm45bEZSNUpJZ3VERjFlTHJHOHVDeVpvODl1bU5ua0tnUUM2Rm4vcGdK?=
 =?utf-8?B?T2R2dHlqemtWaVlyaUpSbUpMQThVUUVFU2xrZjMwS2U3QXJPL2pUMzcwb1Ni?=
 =?utf-8?B?Q2JVclNQS0pOTHF0K0JsSlR1WTlGcThLWkJXS09YR2VqaDVKdjVQOTJoZVNG?=
 =?utf-8?B?R3B2dnlOL2pRVkcxL080RUlrVFFwSEd5b0tHSXhyekExelkwWEZ6T0NIaTFl?=
 =?utf-8?B?dzR2cjQ2bHoyT0xya2RSeDB5Z2ZzdldEWWhmem1PbU9kaWxqQmVSWXRBamRW?=
 =?utf-8?B?SmxHN2dZNHNSelNLOEd3eW5wR0NNK0pVODJDNmg2RWZrSEx1ZXVmUzBsb2xF?=
 =?utf-8?B?dW8yOHJPTVQzbk5ic2h6Y1phc21wNW5uNWVMdmIrWS95UFRiclZlSDByLzBs?=
 =?utf-8?B?QVYzVkNGNi9uS1J1QWJEeHY1VWl6QTZQZ3ZiVVladFVPT0NkY1BnTGF6QjRy?=
 =?utf-8?B?MnA0ZHJQaGQ1bVJRMXFjc0ViaHEwZmY5UGFhU0g3d1NseWxnZ2kyN0YzNFdP?=
 =?utf-8?Q?oyTKUtaH32dtOIsx51cSLm9IC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5955eaa-756d-469c-5a17-08dbbe91fe96
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 13:10:45.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ta6oc0Ga5tzE5ikyeBXErcxW+zRxnMKBVg+S0A3F3b69dbRwLxjhTf7SI4oygW16
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas/Marc,

On 9/11/2023 7:22 PM, Nipun Gupta wrote:
> Add CDX-MSI domain per CDX controller with gic-its domain as
> a parent, to support MSI for CDX devices. CDX devices allocate
> MSIs from the CDX domain. Also, introduce APIs to alloc and free
> IRQs for CDX domain.
> 
> In CDX subsystem firmware is a controller for all devices and
> their configuration. CDX bus controller sends all the write_msi_msg
> commands to firmware running on RPU and the firmware interfaces with
> actual devices to pass this information to devices
> 
> Since, CDX controller is the only way to communicate with the Firmware
> for MSI write info, CDX domain per controller required in contrast to
> having a CDX domain per device.
> 
> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
> 
> Changes v3->v4:
> - Rebased on Linux 6.6-rc1

Can you please help in reviewing and making progress on this patch?

Thanks,
Nipun
