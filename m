Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F880791307
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346653AbjIDIK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjIDIK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:10:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DFFCC4;
        Mon,  4 Sep 2023 01:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDQGuD4kzvxAl7Vdl2c60GJGL1oG6VF+InB2VkyqLj3FMrcaSENAUu45Xi96zPFowVN/TGnEAyZvXc1a5q3mlvjiq1ixU2yb93krhyfJDa7KZh4XnlzWooY3oZABRcYj3Jy7PalU84iPMB3TPMJb4zJgYW/ZnAtq4M6ywtSBR7yLKgHSbsyztfFXQ0NGNn1bvp4lzIerlSdQfMixjiBDt871iCbC9Lt9/S99z0yV8ijWNphD12w92b/WJgSd7migisYc7fZQFpvShYczwOabvoCpYvZxYqSPzoi6U+UuqLBRG9MUwqA3YbcozimDsce/ldYmfrDkU8G4V8yW0uJZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+T/ib+bX+o1ajFixYh4MKiJu0F9NdsSeI31h+Q93co=;
 b=NjcKn0lUvdA6qB8nuxR4nYKFRxzRwE1mODg1SXW9Bg2ubEKr0KaFis4yROLTFYRTvCHoO2Kcv2tsj8OqispDF57oyPAttKqAm6x+nh0zU2X/glwdePG8HdNPtjSnvKdHHByJP5xvGyzHIiC70OS9eKvtjceLg4GXGMBAOv0lG14E4/uAfORR5YrouFWspuA4H2NzKWnOK7BL4SExN1ShfJTrxaSCX0Q02BaHfdWomIjFRYweQDG1wtgYvCVhZbcGRb8TS3lal1UyMVKSxYAXWkdwD5gRGJqSLg8RIapAgLxVafydKgcwTRrO+38jK3Flmwds/GDlL/FPLcCx2t17yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+T/ib+bX+o1ajFixYh4MKiJu0F9NdsSeI31h+Q93co=;
 b=VVrtaVSOHIeKhFBQfhDsjLRTUZKhPBRAprnn6xP+jUC9749VwUIG0iQIei6RDTSdWSsu8sznzfz9qOukppkTvhk1VmNl6OFri3ZWel9wIhpVXWwUpUQhPMuxTnTwKA0IHhUk7mMyNSGEc1wr6XTBwlzc4ERYMXusU0HTVDgKom5A8y6+gSagqr5txAW6Bgjvy934na/w8/cHZazFtKB2GLaxKphPcYc9uVA+l6r5F/L7/HnA3yydL9MonGgzYc+LTH8UBOpkgt7kUVp692nsOoEd/agzS7MmtI70VZusnO5FfnJBV+EZvzOcuKTCr6TjQmxWSdKrX2QyYyUW5PEXyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TYZPR06MB5733.apcprd06.prod.outlook.com (2603:1096:400:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 08:10:23 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 08:10:23 +0000
Message-ID: <86605698-bc85-42b5-b7e9-2da547ec1d4f@vivo.com>
Date:   Mon, 4 Sep 2023 16:10:18 +0800
User-Agent: Mozilla Thunderbird
From:   Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH] block: export symbol blk_flush_plug
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "chao@kernel.org" <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20230904042243.820031-1-guochunhai@vivo.com>
 <ZPV15I09CTC/Dfww@infradead.org>
 <08d3c0a5-7f5d-4054-8bfb-7767aacd47c3@vivo.com>
 <ZPWImKGXZbz6HUJs@infradead.org>
In-Reply-To: <ZPWImKGXZbz6HUJs@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|TYZPR06MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4a2470-83b6-48f3-e66f-08dbad1e6337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sD5TnLajHY8uljCdkupfSUqhiis7ZZ2kIFYdc7bgER8R9MAMS4BElNMmXwo1grIuw0VRPp5i20ABFCK0isjazE1acJS8QcnNdKubj+KiwhqM0bnAn/W8zqWNDpGcuO0rIKPGlruc8zxRQRIoTZN/jXC3QFABx79gslXPtyjlYBqzRkLKAL457UmlUloi8qjdvFI0mCDigQ9RfyEjQDg63M09z2rPyu75Y8IN4wRVsPzO+26tphmDouA0qakVoG0WUZr2Bsm8rQAZHfyHWV34O/1Tf/O+NdSgSlseivhQz7kUQb9p49I5tncfrjASemjJE4ek+c+bjpa/HZjUTv+3kVyjRd7EFDR5mqB04KZX0TBarQ5g1Zj/C6PDKTM3RoNAF1UqiVI9gt/nwcoSOd9YS5gWFITmGJtG4/f7LTd4EDTA7MStJiXjcbsXZGAXagNV6+yyjzyBNFLUD7Qq+R9MQIJQjQtDVPnkSanpG7Af+qVCnOrWjYq100iLk8NUiiAyH9LD0fw/CD+DIhDFrKWqdakTRbdDYb+EVpPp41qI5fJnJ267u6D3/ZWdP62EkCB1asy2qdHpZsVEdauds9isyR20A7SZTo8L7Wf0V91ABoH3xzlrutvE2quEwjsdfIpO92OZ10t9SmFf/HKc5bSoQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39850400004)(376002)(186009)(1800799009)(451199024)(41300700001)(6486002)(6506007)(6666004)(478600001)(966005)(2616005)(26005)(6512007)(38100700002)(4744005)(2906002)(66946007)(54906003)(36756003)(66556008)(66476007)(6916009)(316002)(86362001)(31696002)(31686004)(5660300002)(8936002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGdWc1J6enpyRjBmZzRsSnJIQ3NhcmlMaCtqVUtIR1lpd05ibi9UNnNvbkhh?=
 =?utf-8?B?U2NXMVJ6T0MrbEpkQ0NrRGxOT0FyVXFiZ1VDclg5c2h6Z09NOU9jQm4rajFR?=
 =?utf-8?B?WTRRd09EREVycXZpdGZMeWViRmp6aXRJTGE4Y2FSaXhBdmlFY0hsdmlJcE5w?=
 =?utf-8?B?eS9DSjhBZGVvMDRSS21wR1NnWVd1K0JWeGVBbzdHYUhxc3B6T3BMZnRoemdy?=
 =?utf-8?B?NVJ0Wmo2d000T1piWTdEZ3FRL3Z0RHZrcVgwQ3lQdGpKNlhuZC82ZkJQUTA2?=
 =?utf-8?B?R0x0VEczYjNvc0J4Y09XU1VkWXB5ZElKa0x0VldQMUFrdUVRSS8rZ1VoL0NN?=
 =?utf-8?B?Y1BNd211Y0Z1SXlQWDkyK0VudWh4TkNhNnRMWGlqMmpSTFdnTE1TVDN0ZURI?=
 =?utf-8?B?Ym9WdWdQNEtZMURPS0l4cjliSFJkTTN0N1NmNE91eFo5WVYwZnYvN2sreVow?=
 =?utf-8?B?cDE5ME9sNFNrc1ZFYkV5VFh3QzFUb05ldWlhdklSUVZpQ0NHOWtSRlI1Nndu?=
 =?utf-8?B?M0FFQzFYNGxzUUJPSGlzQmp5ckJBK1Y1UUU4d3c0SU51WjB5WEZuWEU5M0RN?=
 =?utf-8?B?ZWZTbVJCSHFrTTBBSmdLU3JHN1FEOHV2cSt2c2RwSUhHLzhiQkRkN09nem5X?=
 =?utf-8?B?Yjl0WnI3OUVzT0tRQ0ZoSERjUXdCRXl3bEFXdkprcFlVMHJoVnlyTFBhNmtU?=
 =?utf-8?B?TmRWVnVEbGh1ODFiNzNRQkhwdFdJOGhDTFArUXMzNDduaThXdFJtb2ZPeXQ3?=
 =?utf-8?B?TDZhYWJxc0hDN2xwVWZxc1lFZXdjMkFzenRzRXB1ZS9tU0JtbGw5YjZmZDMx?=
 =?utf-8?B?amw2MllGa21uS0lVRFdHMmdQckRmZnRFT3kvWTZ0cHFncmZyZEE0UEZMRlNC?=
 =?utf-8?B?ci9UZ3cxZlBmSml1eDRPRUg4RUhJd3dyZjR5ellCRWJWL1J3Z3EvRm1RR0Nl?=
 =?utf-8?B?WFM5UnU3MTlpNFZnQWE1cElzSHVIcXkwd1pDMVpzdFp4b3NkdFM5RFk1OGVD?=
 =?utf-8?B?bG5KR1A1dngxNWtYRjN1b3RKMGF1NzN2SWM4MEdYcDc3TFJ1SndWUkxRNEVB?=
 =?utf-8?B?ZlFHWGk0YWYrNjVLNng2M0pidjZ0bWtGV09peGJOamtFTXovOXNHRjJiN1Js?=
 =?utf-8?B?Ky9YOVJsRXdZWmEzek5VdTF1c04rUDhSMEc1TTVrMldlNnhhTDNlOG5wYzJZ?=
 =?utf-8?B?SGxrZ3gveUJSVVBqUnAzdEJxUnZlU2pobGJkSlJaQ3NOTVlsZXFOKzVlWUNa?=
 =?utf-8?B?alVpa1ZMUmdJb0NsYUlqQlJrVDR5bjA5SE9ZTlJGVm1UOWpkQzhpdGpFL3BC?=
 =?utf-8?B?aVYxQldveEhEQTVRTmdqaDcxWFhnWWxMN2J6cGlEaDFCbGhwZ2wrdTV5RXJt?=
 =?utf-8?B?Z0RXSXFwZWdjT3RhbW1EMml5V1gybjQ3S0ZhSDdKdG95SVMwcHpaV0JEeHF3?=
 =?utf-8?B?Sm1HdjZXUnFyY2xZck1hSUliNVZyLzM3ckJhL09oK0RBWC9mbDQzRjZQeCt1?=
 =?utf-8?B?QlVQVGl0ZkxIQjlZNkppaWZ1MmtyV1NrQUpnSXlhNlBDY0xyaG1nV0hVOW41?=
 =?utf-8?B?c1k5YTZYNzEyKzdZSXZTMzlGVDgweHA1RGUrM29JclRnL0ZYT0VERDZlTTBy?=
 =?utf-8?B?U285VCthOWtmN0xDSnB4WStrRkhSU2pwaUhDeW5YZXFqUEFoS2dIVCtVdE16?=
 =?utf-8?B?eWZndEFjQU1OZTFXZlN0dVBWOVJMWlR2UFVNVndMMk5mL3g2L0tNWHpJWTZF?=
 =?utf-8?B?c3lJMDdtcmU5WmVmZ2tkMGUxcU1Fam5iRnJyUlk1eGJ2N3VaeTNsOUlndWU4?=
 =?utf-8?B?VFU4Qnd0M1l5aHJyV0ZQa1hSM1JDcWN5bkRNd3ZpOUoxYk9BczAvV2lGc2hP?=
 =?utf-8?B?UEJOZllCVCs4OHQ5WS9UWXdXY3dBc3RORGlvUzlqU08ydTc4UVVWaENDa1VU?=
 =?utf-8?B?c0JJbXVKRlRzNjFORXQ3N1E4WVlhME5kUXhKMGNwYk1zQUxUaUsrUTJ5SmND?=
 =?utf-8?B?VUlOR045QU04VVNMS28wTGY5ZWZGa2tDSXJiRytrUlV5aWRjcmU2MVBTcXJP?=
 =?utf-8?B?b0pneEYwZXJYNUU2RHlxbWVFa2ovRnVwUlNqUXNhU3ptY0R1dVJUTysyYkoz?=
 =?utf-8?Q?mPT1+TBgThvvjdHFdzHEk2L8J?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4a2470-83b6-48f3-e66f-08dbad1e6337
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 08:10:23.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Nl0Nd+ST/X3Zj7uUP6SmKUAQhsHO1yIsulMh5a3r9FoIymSIgCHPIrP5UqYq1Zexg8sYryYr1DDILnbZbfd0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/4 15:34, Christoph Hellwig 写道:
> [????????? hch@infradead.org ????????? https://aka.ms/LearnAboutSenderIdentification?????????????]
> 
> On Mon, Sep 04, 2023 at 03:24:10PM +0800, Chunhai Guo wrote:
>> Could you please detail why blk_flush_plug() can not be used by a file
>> system?
> 
> Can you detail why it is a good idea to use it?  Beause you nee to make
> the argument why something should be exported.

Hi Christoph,
Got it. This could be a topic too big to discuss here.
Thanks.



Hi Jaegeuk,
As per Christoph's suggestion, could you please assist with reverting 
the commit e1e9b8062c74 ("f2fs: replace blk_finish_plug() with 
blk_flush_plug()")?
Thanks.
