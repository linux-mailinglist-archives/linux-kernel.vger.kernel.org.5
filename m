Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE817F3B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjKVBnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVBnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:43:50 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F3210C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:43:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsFpoZEpxYg28kiYQaxAD+Z7NZPpt3PeDgDwwJaOMGLXIJevcCd9Gq/5EFF9gmC+lITNxQkHOCkGKjI0oNmcBltAPhnBgvnQAdJTT9TiDYVfVnaByeQpTAkgwbM0pR+C3Zbb+AEj+wbsoF/bBTJqGckjysOHvXiYOcYeX+KRVCuIL7oSc0nMt8GynEZbzBC0wGLY6bDixd5Z1kASn0ew3j6djPA5+oxInrN5LVxHgqRqmFvutlOT2hbKrS0pcMQs+i3BLpp+lZmlMyQzvcC570VKTx9iEEv9epBorQiDaJaBV9o0VXsffOXPqF4uVzOkolqa2MiqGgNgcNrHvehqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INMmnmrRdMtGREo56zW2Pmu/j3jMTzrV4aCGECv5IH8=;
 b=EwnPUvhpTohlcucHL/55FNBAPBoAnqhLNlUtNZxEcdLC28SzLi+tMlZewjRezO6Ct6k9YRVyJ9OkWQgDvCev97Ef0Pt8XAf9/KlSrw87ZxAj521P5r9kDHEtMJegfycrdVZr5MHWzqcTuITlnayHlF7iyWpFcxTUp5oXcJPa1f4wjlRpBHJD0Xuqbp3SNjIDUd45QzcfDRmbTZ7Nxc8Dq7vPPYxwfQTG8jPvW0/1KkUFxLwI9xK78A+FaYAF7GmYeJb0HRLHNIytKcxIiDTYmgQg7gC6xdkP5oLxm8lGgqAcYxMN/KYNjmZaO73g1d5ciPpgHJB/xZsDEPVx2c49Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INMmnmrRdMtGREo56zW2Pmu/j3jMTzrV4aCGECv5IH8=;
 b=X0w08Z4wWHN/8MUfQ0e9fHwoLcuVyS5zH/ADFGy/ajUn0KaPRlX1zt73VGgDNTdpkgXR0qdLNGoH9m2VIhxCVrP0aV4rhTgAPjTQ3/gk/l63QhboaiuhuAH/g75sp2PhVUDDh9mEOkKBYA5rEXBJxgiYaiD+LX3Her2SZlYgKu1bcKrBjN27WOC1+tsklxLqMzFAE1l9JJXj+N8y8EJ1Sh0ggza1wjQD4LcSyjHJNWH8menZQujN+rqdD5b63DE3/D0ws28lGoye0hGO58bo88ogN/goxPLGCeqCEZJwAUzsuJJkkPKxLScjmfVIjccwmH9S1zVArehJtdk6G1qm1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB5294.apcprd06.prod.outlook.com (2603:1096:101:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 01:43:42 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 01:43:42 +0000
Message-ID: <dbab7bb0-e40b-4642-9fe0-c1cbb7263f1c@vivo.com>
Date:   Wed, 22 Nov 2023 09:43:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: ALLOC_HIGHATOMIC flag allocation issue
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
References: <20231121075129.1530-1-justinjiang@vivo.com>
 <ZVzTThaEgDcbvtM9@casper.infradead.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZVzTThaEgDcbvtM9@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e45ea3-3b10-4269-d147-08dbeafc7513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4sbuZzAg4irFCakldSIbJNicfDhmpRtsvKK1/UpC8cO1wdk7ZaT0N88R10xWRjvnTLuL33yTnECK3w95dCyjewcnFLcwEBZmeOzsWmhak1UAEgGl3s9tQ2RwlpMDP5/Rp0bc1muSGAz5b6eAmfZTCUtyt6tco/3z2B6sfL14mb4qatTZ91plEI0meZPncBhzsj6Eaexc81I2zmf72c7oPGSGFQzbnmAlrE3UHDJtRYpCyiwfz/oRYI8fAf1zcUFjddaW4dEr2DTT6AIEGpHLN7m9Qq1zyPEajfYtZP4VsSgAh91lu9KT5kF0k/ICeCEU01L3+VTxx+cvYDZ+omQ5beHQFoBd9e+e+PU793t7tOEmppQJp6jZUAqrY0H6mlZJEuejpPeaH1MlilgYKnVMmU4TzX9AZoTjIJjubiMf70WPPlS1BXX+ZRtH83ZYOFTInItzRnv6wZ7mxPBdkiZtjrx5QPb5taWpibbUBZhlREozhVayqwJ9S/WvKmxFOEVvz6TbHPlwct+3Ap1fXbQTB8x7Zq587McONl1FXdGDpKifzGgYAD4hDGCrU7q6jCKnsIKV6zKdT4nloJ5FPASRmio4KsBcIs7N0OrEszLmnRSFaixrvtok5a/Zs7iSXIP4/wqQj1KNAT2gSn+veEEqSe8HHG0p6bVktDrY+OBSq6CGxc0gvcS9eRufXfcfhYLkzjl7TjeYozLRDn8x3OmkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(66556008)(6916009)(54906003)(66946007)(66476007)(2616005)(36756003)(6666004)(6506007)(26005)(107886003)(6486002)(478600001)(6512007)(38100700002)(31696002)(83380400001)(38350700005)(86362001)(52116002)(2906002)(31686004)(4744005)(5660300002)(8936002)(4326008)(8676002)(41300700001)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzg5UnVMOFZMRWdRaDFkU2dCMTJqUW5lcVp6MUVzQk0vL2FtQUU5MFF2aS96?=
 =?utf-8?B?bEZwY0c2ZS9pMnhEWG5BSit6Q0oxdGRXSGIrQlVFaWwrYm0vWHh4aWtJK003?=
 =?utf-8?B?S0MrTnpDWGFOaHd1eFN1cHBZeHMyWXRiSi9yVHd5S1kvOFlZYXVHd1AwZ2FI?=
 =?utf-8?B?R3ZDOEswTDBvazhHK1ZHTzZkQVl6NmI0WURWNDVvT2hOb2h2cm9CeU5vMjFj?=
 =?utf-8?B?UmRrVVZERU0zSTRYcmFNMHM3SnM3eTVkcVR2N2ZoZ1U3NG14blVJam5LMG1M?=
 =?utf-8?B?OXIwUWZuSDVvUTArN1pyWmQ4QUVYZTZib1YxNzk0cjdSN3FNdDB3SkUxR3g5?=
 =?utf-8?B?c0ZnNkVMSjZoNXpYYjdOcjFlUFpnMHBqOE4rdGNFNVA3blhlZ2xuUklRSXQw?=
 =?utf-8?B?d2FuS2cyTUppdTNpUUdVaGRmcURnVEpacWVxZ0hRSFNvTlV6QzV5anNTZzlU?=
 =?utf-8?B?ZFJpTWgxTm5pb2Z1aStIQTJyTHFZalNjekhyMU1PcVRVWitJQ2kzdXNhMG0y?=
 =?utf-8?B?ZnlINHI0bUxOREVaNXcvT1dTUWEySTVad1grYUFJY2J6ODBvSnNVaXVIL0hr?=
 =?utf-8?B?dkh3dUxJTERsUEREVUhHRlJCOWdmOXlzMjQzNmxWUVY1dHB3ZGRZc3YrMWNS?=
 =?utf-8?B?ZzZNSGNGVytqNVZUdlBzV245UjJMa2wvTWtGenUzMnBFMmhHdDBkb1ZWUDdu?=
 =?utf-8?B?U2ZoN2lwMWx6SXVrL0h6a1pob09hQjQyZGdWcDRycHVwWEdub08ycWpXUnpy?=
 =?utf-8?B?aURNVWExT0c1QmdMdjRJcTBUakdhKyt2cW40QldiNmpuTmg5Q3ArcXBPOGZh?=
 =?utf-8?B?aERMNnU2SERXbWw0R3p0ekxhdk12dUduTTJ2UUxLcHpHNVFKVUhvRUpPOVYy?=
 =?utf-8?B?MmFwY040azlvRjBnRDNvZTFNN1JUQkpVai9qL2NyaGI4NE9IaEhGZys5K254?=
 =?utf-8?B?N2t5dEJzdE54VW0wWExyekZOR2FqSnhvalkwU2YwMnREUXZHajI4SVBnaTZ4?=
 =?utf-8?B?NmNFZDRnRkJURHNIU2ZVNTZuYVI5eGlURGtoSmVpbThQd0dURzROd2x0Y0Q4?=
 =?utf-8?B?eE85ejVxMjBpTEhFOFR6RlZ4b2ZPK0VoTmlXU05jYlNzRmxmTXdJM21CQlpU?=
 =?utf-8?B?d05tNEMvanNPNHo0aU1EZUlIK1V4MDJGNmtVTWFRWDRUMUZRT05jSmRjdFZr?=
 =?utf-8?B?SmRzMDA3OEFOM2lqaUZTb0hhQjFwL3huK211bndoRnV6REoxbUJIUm5kLzVQ?=
 =?utf-8?B?WXNZTTJhMElYWFdNMzBmeXpOQ3ViWVFrOWdmd0RlWmpRZ2JJQ0FCMlpCa2xj?=
 =?utf-8?B?N0MvVUhObmVNaWdTYUdHb2t5TlNsc3dYQ29VcklManVvaUx3eFpkMUFqcW9Q?=
 =?utf-8?B?QkpKdTcrZXdCdDltbTFxOGk1QU9EOG5WeUtXT1VSNlFNSGxIaFZHYnFESDUv?=
 =?utf-8?B?RnlvcWtEdndDeWNUakxnNHRHYk1Ca2dLZWkyVy84M2FPMkNPdUQvclVveE9w?=
 =?utf-8?B?UkVxZmZPQ1JLL2t4RVZYcjRaM2ZDMTJKTlU5N05FQ1NOS3lzdUdjZEJ1Rjlo?=
 =?utf-8?B?OVNLSnBxTk91Z3JoamZITEtVSnY0UEhSVlprT0VMNWk5eHJpWEZWWU8xZjQ5?=
 =?utf-8?B?dGRmWDdzUnpMNVIrSDlkbDNWcXBlUGd3eGZMRkpNZWJERU16VFplK25lS3lC?=
 =?utf-8?B?RXlpSm94UTBYZGNDL2NHUy9FRUdvSktuVVVPcittOFd3cnRXK0oyNHRvQUc5?=
 =?utf-8?B?RjhXT1p4a2xWYWZ4NHJOTnBEdzNpbmx2aGRFdjBZVGY2NjJyUHFSTzJLRHN2?=
 =?utf-8?B?eG9pV1ZpMzM0dUM4TlBrVDdOeFNmUzgzaDNGNjlLOFR2REk5UU14b2JxMStN?=
 =?utf-8?B?MGhvelgzQm9abzk1TW52a3VVOHFNMFAyZlIxUkFRMGMyUlF6ZXVwVGptUWhn?=
 =?utf-8?B?RnRDcEMyU01sSFRtVGVmd2N1bHZmWklCUzVZd1pkM1JOV0M0WG1GRmFPQ1Q2?=
 =?utf-8?B?cHVIODdWUnNlY01NZWh6V2dMZG15K3FEM2FQamdkd085R0t2cmYvRytIN25u?=
 =?utf-8?B?M1VSNlc3d25NVS9JUnl3TmVkbjRuaDBwN3NtUGJjK3hoWE4vTzhYMTlpbCtu?=
 =?utf-8?Q?btuXeWOA/8nJO0fQuND3Uofu7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e45ea3-3b10-4269-d147-08dbeafc7513
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 01:43:42.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfG8OlUaZNKQNmmpfG1fGqHgXNI4RtksRxKS0Z2CTlexowxviJx4zBi1czojQBSp+Y9pRy6zOd7jNppj0U8eoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/21 23:57, Matthew Wilcox 写道:
> On Tue, Nov 21, 2023 at 03:51:29PM +0800, Zhiguo Jiang wrote:
>> Update comments and modify variable highatomic_allocation to highatomic.
> You sent the patch relative to your last patch again.
> You have to send the patch relative to Linus' tree or Andrew's tree.
Why command "git pull --rebase=merges " can't get latest code?
I have update in patch v3.
Thanks


