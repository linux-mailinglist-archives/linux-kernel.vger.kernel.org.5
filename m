Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C70783334
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjHUT7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjHUT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:59:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEBB12F;
        Mon, 21 Aug 2023 12:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzeYhX7qqm9z93VGqIraruL23oHQIz/7a7KKD+wkNf0NzRUm+mIAFUKgNPmmw2rZ80ZEAYdayW2TBl/4tpsBWyT0K9IWXZ4dJmRzz/Q00MXz7bAM3UJIO5I7nCw7ggQBeMq7odIcMs0r1NvXPBy/LhOHlUT95g7Z093vv4qOUirLAARswGmXdP0GSKu1OKfihREghrcptpBwrr7ZFaSxstAJ8SAzImeCcil1Y5N491e97+eZ26+95Lvc1jAR+Vb9IK880QRtQOJntRkhI9fevYjUGLecswuHSkCq0EYX60smvHK/jiUpx0aI+7s4PcEOEcVbBIIQ0pJJHrgoEex/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qugu/aIvPzeqY+ai5CXcWGjdaUsNwUzb5I5BKAsYmoI=;
 b=LP+6gH8abY+hviM91vQaPD/tsUh4rihGj9Zd94pN5h7L/yUqhTU+VzkaLitmg9MoQVoPN0Hdh45zeIZB0Y7DXLHtk7OsKxbo0HrkH4jKqr7PGJh0LNS5tjjcYHxvX0h416wV2nBsr9YkxSG3gpezj6jq1rrKwdzAveaFcEhtrD5mSRSg34tz72ioPVBvDRHoNy15EtBhIA34WHG8MSL0XNdmCxM3L6bcgauVXzeo38em91XXqSRuZpgrXcB5bEsr9SH61M0JZ40K5NUkDER4ymPLnHsXhd3ebIsGWmlwIpp56NMiJNCFOJ0DY3KaB51JEF0gdv7S/d5C/iJXWjKVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qugu/aIvPzeqY+ai5CXcWGjdaUsNwUzb5I5BKAsYmoI=;
 b=FUWoiis5GfZIqVaijgkfxQVY59OwnAm2DnA03hwdVXXa7zIZ2ay2f3y1Wtw99AVzxkaQi2ooqs43eRgD4A6iaf8EO/bmXBmIWWVq2kppg+Ugy1uS6pCrUekd1YsZpoblEvilLXeepuIa1hIJulZRGDId2X3Qs4a1xV0WByRGt3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 19:59:30 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::f778:1f57:e0e5:2e3b]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::f778:1f57:e0e5:2e3b%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 19:59:30 +0000
Message-ID: <5a771d52-2ae1-4d00-9291-a94b3f8c1d25@amd.com>
Date:   Mon, 21 Aug 2023 14:59:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: remoteproc: add Tightly Coupled Memory
 (TCM) bindings
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     Rob Herring <robh@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
References: <1689964908-22371-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20230724161632.GA3686365-robh@kernel.org>
 <MN0PR12MB5953E72D7950581A8FB5AD82B711A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <ZOOltyWikpxc/hII@p14s>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZOOltyWikpxc/hII@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: dc072793-ee48-4318-1f3f-08dba28121cf
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBsGaOnnZ+E1GY92Ff7ovQunzhtoRHfaZt1Y0cEmJKG0s/Ax9FbjATsOZaZaKv52ocaQjbaCFpMLPTjIzY4GoXMjKZ4VGbKd0SJow9oudwGLiSjDit2hBB1TIscU7VSFiiajYGr5Xj+8/+Wnyxxk1ciuOZaa0fuEoXJ7XO6UFMFmfUg5wUDDMb2VqpCEU7WbYRIH/o2F+t/9fMIAkm6s0XuCBaIylBZUz/l5zCP4yuAM/7c2AQuZCBVRzocFZBuwlQY2dVS9nNAGMt6RbeH9u4wOMXT87GK0XUkwz2woJ5T/jYGct5ri2+NLeHQ3Ejc8Yb4l4sb7QXrMoLBvboJXstwJ4RenXjoFvRnr8sMihmbhLLryUwq6BgLMe0EndhOzZGQFlHYgo0e+VMQ/s+4nMSmvpDNsf420YqumODbKzRVwHX3xjKsQUsWWKPhr3MBjPhrd8qMEDkZ+Ey+jF7Ep5booHjtIqKV5dVgNMQjZbIWQza68ThcB3Hi3WiBiLQjmK6PVgxUHuZd2uMzaHFHVARXx2DM1072SIlqhWz3nYTD+42fOrF+WUCzaNSPcv2CV+nbR48Bfy3QoqnlW0WgbKnyC3A7sYlD562Tib2meAtMJL2Rx5EYPTQZSL8PysTmbo9ZYkrcuzRaoPQrgUmtEgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(54906003)(6636002)(66476007)(66556008)(316002)(66946007)(6512007)(110136005)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(86362001)(31686004)(31696002)(44832011)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2lWRUkrSitOZnRMN2wzUXVDMGd4S0ptb2wzQXpCOWJ5WXYwV05Jb241amRI?=
 =?utf-8?B?ZmhjUVkvN2ZvaXBPN01QL3FIYW5QTHFIeW9rMU1ONWtMY29jZ0d4aEorVDN0?=
 =?utf-8?B?aXcvRkZzYmlnc3dZM0grZFJVakwzdDBnSElXWFo0M01wNWJXKzZNeVB1d1hn?=
 =?utf-8?B?UGF1OVhzWWdLZUY1aGs5dnBFY2hSTTd5VXowZU45RGE2MTZyQ3RVOTFuM3Ri?=
 =?utf-8?B?eGlNVG5JZUY4aFdWa2xhSzZuOHpQSzI1NEdZcWxQallpZ01OTG9neDdpRGNq?=
 =?utf-8?B?VHk1RE1IYXNJemJsemNEb0JwL1J4ZFRzWDZIbVdCM1NDOUkxMFNVRjhtOGRB?=
 =?utf-8?B?N1dxUDB6cGpRRTdPd09QZjExZTc0NXRZK1NiZFhlUUhCd1RTY1ZyMWhnUG1s?=
 =?utf-8?B?UkdXamlWdE1NRzdXWFdSa0hMRFJ3alBLc3d5NlBhTE5ZeSs0UVAxdkFRYndK?=
 =?utf-8?B?MjNzVHY5b0ptdXRWSU9PUjJmNUZwUW1rUWxMaWxTb2RYWU9pOEJLMzNaL0Jw?=
 =?utf-8?B?b3V6eVdyRmZodFBVNGNmZTdQNnVONkcwOFVMVUJyMTVEcGRNQkFEUnlFQnYr?=
 =?utf-8?B?TkpQN3U1SVlpRDlWOWRqd0d0b1ZCbW15K3hRb0NBMW1oTUlhd0dQdFdBTVAz?=
 =?utf-8?B?cWkzb3VYZ2lEenRoRXJXaHNKUEM2cE5yem9wY0ZJVFE1Wlk0M0pCVGx2QUFl?=
 =?utf-8?B?bmgxN2JmeHM3ME5Ebkk5SmpBUC9XMFFmWFZwUUpqbUJNWlduYjcwZ0VKUXhS?=
 =?utf-8?B?VGM5TXpKdXYvREcyZFhlbVY3R2ZRS0lvNGw0S2lkYWlJSnhsNEZpbVdBbmp0?=
 =?utf-8?B?Rjc4SEluTmlaRjhUSktJeUdBNnJheWxoMThTd2VYY2tkaGZKenJvek5DL0Jn?=
 =?utf-8?B?d2ZqNHExNVB5TTJoa3ZXNy9TTHZGQktKeXIrR3I5RCtacnU2eWtRc01PUXpT?=
 =?utf-8?B?UkRpTWFFdmlVK1JNMkJBSG40ZWlMOWhGVnVJV2R3T1ZXcmNNSmQ5QkxpYUNu?=
 =?utf-8?B?WCtsRElZemc3dERFTFhVR3pBNUx1Mms3d0tnTWNrSlZNbTAwSkR1MkVIc3Vj?=
 =?utf-8?B?K1djRitTVTFxVnorMVIzOWhiTEFuMm1oNlFCUmJuN3F1SXZXNm9VNzUvMFNm?=
 =?utf-8?B?dVFQSmlDdHdTQVFWTzRTSTlDd09xeXdNZTZ6WDdqS0NHTnlTSkUzNmVZQ0JO?=
 =?utf-8?B?TUdUTnJjYUUxQ04zanlUQ2NkRmtpV3cvRkJQMlFCeFNhTlptYWRhTThZN3Z2?=
 =?utf-8?B?SXpQeXhoRlFyd1pXaHkvc1NxRVpaa1dQdnRUSmxJL2FkR25MUm81ckZlREdy?=
 =?utf-8?B?UWVuL05xdTlpNzAxSGxJZVFRVHowL0hwOGJzelVjVS9QcFVhcWtwT1V4MVRi?=
 =?utf-8?B?VUkrOVNhTm9rcjB4SW5QZjIyVGZoU2xjaHZqOWwxV3pkQTJ2anE0RTRxRHdG?=
 =?utf-8?B?Z0hmd29UN29EaXNuaS9Sa1ZuRk4xYmxZYTk0dGVEak9CRjJVajQ3dFpqbWlH?=
 =?utf-8?B?d2JHeEE2WWNQaFhMS09kNFphTUdRRlZrK0JjWktuRUpjT0NpcUxqdEk2aGNv?=
 =?utf-8?B?NGhJZWRyWWxYVW90em5BdnNyditQSTFSUy9hRFFLUFM2WDVrRis1TUtPVHRQ?=
 =?utf-8?B?SFJNaHNncGE1SW9wTitzMmJtandOUTN5MXpkT3pUaHFPQXlZV2VGRDFNYmtD?=
 =?utf-8?B?d3JOZW1tK2pmTFp3MWpZQ01UcHV0WkRtZTl2d1NKbGs4dVQ4VDA3bUxnSUta?=
 =?utf-8?B?RmJ3UkZNb1JUN3BMZUJHaTJ0bEVIM2ZDaWtsbnV3U0YxVFo0eC9nTGt5N0tj?=
 =?utf-8?B?eTR6WVE0N3QvcC9vay9yVGlFTVZzM1dLd2U4RXQ0alBWMm13MU1KWWtUWnQr?=
 =?utf-8?B?ME5CeEkrNFBHdU5vbFVWdnBvSnhJU1ZoTzBoRmR2Z0F2bXNrZStMVGo2Tlo5?=
 =?utf-8?B?NWZNNWZFMmljbzlNSE5SZWVqbkQwazJCMWxOSXlUNXZxRU5EV2E1cFRKcFV3?=
 =?utf-8?B?WWgxaHArSUFvUThvbmFsR1hSU2FUbUhJVlFHa0lPUlRJT1NRUUJybjA0SllZ?=
 =?utf-8?B?VFVxQmc4Q252UG9YZzFNQVZTWWY3UWNPZlZWNlJWMWEza2g4NDRpZHo2eDJP?=
 =?utf-8?Q?lM3texTYOXEWMmMe+Fm0nIBwS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc072793-ee48-4318-1f3f-08dba28121cf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:59:30.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtzJ67NtRrnA5bbNS9ZC9fcAlJFxaMf7ZQFgg+8AmK/MFhdoDh14rDK5FtY4DLzx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/21/23 12:58 PM, Mathieu Poirier wrote:
> On Sat, Aug 12, 2023 at 12:57:39PM +0000, Pandey, Radhey Shyam wrote:
> > > -----Original Message-----
> > > From: Rob Herring <robh@kernel.org>
> > > Sent: Monday, July 24, 2023 9:47 PM
> > > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> > > Cc: andersson@kernel.org; mathieu.poirier@linaro.org;
> > > krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; Simek, Michal
> > > <michal.simek@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>; Shah,
> > > Tanmay <tanmay.shah@amd.com>; linux-remoteproc@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > > kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> > > Subject: Re: [PATCH v3] dt-bindings: remoteproc: add Tightly Coupled
> > > Memory (TCM) bindings
> > > 
> > > On Sat, Jul 22, 2023 at 12:11:48AM +0530, Radhey Shyam Pandey wrote:
> > > > Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> > > > UltraScale+ platform. It will help in defining TCM in device-tree
> > > > and make it's access platform agnostic and data-driven.
> > > 
> > > From the subject, it sounds like this is a binding for all of remoteproc for
> > > TCMs.
> > > 
> > > Otherwise,
> > > 
> > > Acked-by: Rob Herring <robh@kernel.org>
> > 
> > Thanks for the review. Just checking if this patch will be taken through
> > devicetree or remoteproc tree?
>
>
> Please send the driver changes and I'll pickup everything at once.

Thanks Mathieu,

I will create driver changes and send them after testing.

Tanmay


> Thanks,
> Mathieu
