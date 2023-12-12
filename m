Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E503F80E348
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjLLEQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLEQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:16:51 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B2494
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:16:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMCXOxlDvrY5Q2cClBRn2KBd7jePnQc91LPJYJ31hUOcN6Co5eCPHWrv00Mg8px0Pk4j3UiUMAywU8kQffjD8GLp2clSFGfT9EFQfXnzC7ZJEe7nWXr3hEJYU1Ycaqy6DsQ4RYkaeucZ4G4CCoQEXriW2C4jjSoSsCbksIdHuXdYTZoeUds6ptCD/9ULgExkra7aGv6cBPAHqVG/2yrvHWYDEwAJd9cMTKMTwVjujSTfA4eN73CP+UKPme1jMa5lTxMH8AX523KNo479x4xU6iyNKAR3VpegEMXZ0uP09KOqUaFh6i5NX6x3OMM6elJFcWYV10Fuw6inCdM3qqELdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSx/caDIKIetKnAn9wrCN1MxHhGPtA1xn45pUXB/dLA=;
 b=LVmmpOc+bnJZQA5/va7jAHaw6lAhsz4RuWYP1XRMQduS4zzioeQrs7Bkzp6NkrnqRFOpv6f9e7vDilcZ747GKd0IaQNTG/CNsQYP9Fm6nTlsUNt271KJuS0aGSJyeT9QAbPbEBFHbxqvji07igvzeNysOKtJf9wEwCk3LwqxcTOFtYARuRdALkyeDVHIdvs5Q632LQXw6GvROr0ao8KzFAPwB6JV087yk3QeH5NjfySmpldj9XiPxqyYFT9r44F9VvkLFOXY0NPH2nahz2AdL19x1+Q0BddZoNea8M6MVtbfZu4FramoLjQE/noKPpSvcffTvxfrsGIaF3Dg3gilAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSx/caDIKIetKnAn9wrCN1MxHhGPtA1xn45pUXB/dLA=;
 b=t4Mys5ilNgNtuY1G6zEqxAP+p8sCf6FRpanvDaFEtIY7986tuSE5X5xs9iFyakN+BHhCeFdCRsui1oBC9a9jbCve8PBSV0Xp4t3qaZ04CaZo2uZdLmuXw7YpElWSw0n3EA1+AhQ0ElfEpAVTghOFWAy3Pb15UNBYgUY2Ni6LJiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 04:16:53 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc%3]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 04:16:53 +0000
Message-ID: <56792f6a-d407-e431-dde2-0d1ebddbd897@amd.com>
Date:   Tue, 12 Dec 2023 09:46:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] x86/nmi: Rate limit unknown NMI messages
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Guilherme Amadio <amadio@gentoo.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20231209015211.357983-1-namhyung@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20231209015211.357983-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a9e012-011f-4d0c-1687-08dbfac92b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBTdjZTTNHfT/z5tByA2CppJVpRm+7ikwrMa8cprdr8/QrBzpOOeaQeScqGiH3xnz5iOEEfdODpM3ZfhCBzoSOILALlAQ6And65s54yQHf/kDk5kiMWuZ+o9F9i/NrOe00IXYzON2too6rDoO0iVytkBYchI3LVvV/setHS88P3lauRF8YFp8Bf39HHtFev6pE03Z/CJwtY24jLBzHXhocIK+F7oZfo2YtpfoEWQ8D97MM09r3bt66BCP1v8O1Mpvou4Z98v6IVQmZzPq4covv8/7KTjjV4jsEQP2qU1esNGxMYbMp/Sd4UNtJ7YSxEwRN/jcYEmVlb7Yom9QwYGMKryR7fTwrXPiYLECMFFXPtr1nIfgQ80blaRTyYddrOLA+NRUyPRor0s7/Q7eX501TyfyS9MxgtxfyW+nQaBWs0DijGzow4Mwo3yoPox1QHUQgOLxFYC1Z2MOyqEUUL0CQTJz+UM9Hy6/K70hvrKemUH9bCLnParB24HZh7GZ33BjIoCr5idXCXdvQCm9I8jdmfFUboEJryZr+kBkMjNb5lYWg8IcXmLAiMwAfxh4jBG16BGRPk7i0MQiNMIEo6IS80Td9hQZgBlvWDXK13eHWpQwvgwEGpG1csP+MDkE9I0s/+Hin+gcLYI8+xUpl6Rag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(31686004)(4744005)(2906002)(44832011)(4326008)(6512007)(6506007)(6666004)(8676002)(8936002)(5660300002)(15650500001)(7416002)(316002)(36756003)(6486002)(110136005)(66946007)(2616005)(26005)(478600001)(66556008)(54906003)(66476007)(86362001)(31696002)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmVBdW40S3k3NVpKeE9pUEQvYjViR3pzTlRzdWQ3ekhmRUMwUS9PcWRPY3J2?=
 =?utf-8?B?YmRoU0ptdWt5TCswRGtqNnNnTWNHVHBFVmNNcVd0U292SUZuNkFpaTlFbUho?=
 =?utf-8?B?S25nMWNIZWRJYTlSOC9KNlBaRnZtV0hjTnVsbk8wQXdmT1VNWlNxV1dkMThZ?=
 =?utf-8?B?MnZRVWxRTm16OFdUR2o1UWoxQ1BXUVJQL0RtOEZxK3prNFI4azVRN1RnemNr?=
 =?utf-8?B?bnJ5Um1QVEJWSFA0TjluRWVCWDM0WXNaeTVVUXhDUUtmbHB6NmthVEZRY0ti?=
 =?utf-8?B?NlpQY2dSWndRWStscVhZeW5zU2I1cUpkaUtOcGo1ek93UVRZTHk2WFZCSEph?=
 =?utf-8?B?NndWcTVpZkF1bUFqL0lCUnk4MG1Ib0pXL3NQNnk2aGZ1SG1hd0xVOFp5bERM?=
 =?utf-8?B?cENtVlBGajZGS29EVlFiQWowNGVOcm1GemsvcTQwUWxDRkN2aUNoVzlZY3ZS?=
 =?utf-8?B?TnhGd1dHVGdta0l1bmpWVmpmejI0SlFOZ3JiY3l2R21leHBib3ZidGdrUXl3?=
 =?utf-8?B?ay85aUZrK052a0JGd3QzV0VYZ243MGU1TGFjVVRYVzFWWXhBUEk0TFZHTEM1?=
 =?utf-8?B?U2xxWUozaU1FVXNiREprQ3Y5UGcyQ29FdUc3MDhtTWdhOGtTc1NLN29xZ3pw?=
 =?utf-8?B?R0dPK1JucU45NkFtS3A2eFNsS2laSkFRaGEyMW52aXpZOTZrZStkRDdrQ3kw?=
 =?utf-8?B?YXFKWFNnUm5KclhodjRON1Jqd3crRjJmcHpvQitpbS85Y3JlY2JpdlU4YWRu?=
 =?utf-8?B?eGNubzN0S0pVZmxUdTJKQjNtM1BIbmhjYW0yNTJqdVJteEorNStUcDRmUEhP?=
 =?utf-8?B?bUl6RjBVUHQ1SFRrc1BIM0pNZy8wRFFUV2dXTmtHR3M0ZEg4UkU3c0NCMDE5?=
 =?utf-8?B?NEFCWUhzeTBpeTd4ZndoYnVFcFE1d0x1UUdVZ2dlSjRORGg1YmRIZUpTL2ZL?=
 =?utf-8?B?aHB4YzMzK1ZHYnRBL2w3VXpNSFFjOWh1RTY4S1RsUWVmWlNqYzI3UmFoUk1E?=
 =?utf-8?B?Sm1keCt0QmpLZFBPR1oybFVOZlcwNlRUK2Q5Y1FZVGRsK2M4c2YrUjVZTFlF?=
 =?utf-8?B?Tm9QR2I3NkVabVFmSWxkQzJLdXBxdVF0UU9BbHp1b0N0d1JtN0tmNzhOTVhL?=
 =?utf-8?B?RjlMTWFWeUhhL1piVTh1bHdROEVUaGx5YmRseERXbXMvb295V0NkK0QvakJB?=
 =?utf-8?B?UW1Zc3diaEdJY251dWJyYno4d045R09KMDgyU3B3c2xVN2N4QUsxVkpweDg0?=
 =?utf-8?B?UGtRcm53MmhEcjJ1bW43VWVNUGdnNE1udEVXWGU3ZkFQd3VTV1pHQzhVelA0?=
 =?utf-8?B?ZVppTTJYek5NQUhOUDNQQzBRRXBMRGxpakZCVnpicmIvVVVFSUZhVmovODNU?=
 =?utf-8?B?bWw5RlU3TTZWb2sxTnJ1NUFiclJ2YmR0dUpHWHZCNkJSdDRZVUEwRXFOUXRO?=
 =?utf-8?B?SWw3RXFnTFFSa09qSU5mRHc4VFNnb1RBOXM1SVY3MDdzbWhQdDBqMWtyRGc2?=
 =?utf-8?B?QVhMcUtQMHUyckRNQlFFQTlYYm9HZzZqTVliMGx6MGsraWxPbmZlRzJVc3RV?=
 =?utf-8?B?blcxbUlYa0lrM250bHlVQWI3NmdXU0wyQW1JWDVwejRYeW5ZUUxyNkh0TU5M?=
 =?utf-8?B?SHlCbFdYS2hBcllZc1QxSlB0NnVrdUorU2NMLzZwbDcxRWY0dFlJempjOXBT?=
 =?utf-8?B?cUtKWnJJMWh5M25VdUdPblB0cTU1TWRwL2xDOWdrSnU2VTN0Z1NjOEdFbm1x?=
 =?utf-8?B?dlR5a3dsajdyNitVYXhDVk1CcWdRV1p2cW5mU2JxblVZdGtjNGdMa0dJR0sr?=
 =?utf-8?B?Mm9FWEd4WDEyV1c1OGs4V05Qb0RsMUIxMk9RT3A2UVN2T25wRlY5NDhBUVFi?=
 =?utf-8?B?R0JzSzU3T3RkMzlHalZ5Sm52bXJRYldGRjZvMWNkOEFKRkRMRHNPVUxrMVFk?=
 =?utf-8?B?Q3NPc2hXV3dsV0diSkJqSDdFYjNKMkJkcFdHMjJBR2RPTDRiTzQva0hFU2dX?=
 =?utf-8?B?b0ZTczJ1cjk1NU1QZ1BuY2hXRmx3SVpZTUg3blZYWDVnTHNQQlE1N3U1RXBK?=
 =?utf-8?B?bnk2VWN3Yys3U0o0UGpHL3E2eTVyRE5vbmROYmpjTEpEZzFrLzNQTXhjV2RZ?=
 =?utf-8?Q?kNv4L/+8Q7aX+FWY/p53YHBRu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a9e012-011f-4d0c-1687-08dbfac92b97
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 04:16:53.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eVt9iRl3oMOgcM4yaaiCyfc0gg/c7jmj+0DBcEq+288mlyweCNAoi3/2MeKzkuc4lU+DO1ftQOyaZ+ODGE02w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On some AMD machines, unknown NMI messages were printed on the console
> continuously when using perf command with IBS.  It was reported that it
> can slow down the kernel.  Let's ratelimit the unknown NMI messages.

Continuously repeating of the same message is useless. So,

Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
