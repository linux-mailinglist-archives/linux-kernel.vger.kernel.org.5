Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6F5810A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378594AbjLMGbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjLMGa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:30:59 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2137.outbound.protection.outlook.com [40.107.117.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFB1DB;
        Tue, 12 Dec 2023 22:31:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUWVKpI8+0DkBKrBFzoQ4vOcDvlIM961SxsNFzMA6xRfAoAFRJuTN3J9APIpZMGL+7HMKHqHvTFK4et/lEabOWt7BUejAXn0CiC4UmKcvYKhOJF6CKFOP8n4Ak5gMcCoYb9NmUUin18AKn6ncOTFUKLMnEpNAiyDkEDr7LLnDSdsn4r052ke0DS0Yb+FR9Q5UORgYnC1o3mnbamGC18xERRrJ7L2/sI6CNRzeXN3vgJwqTcG0K3mlJy00Ru4CpdHvmHXeDeLxWCFPPbIeuuLaxg+RNewktmOlAqYm7YeLUUNMWxEr+XncEcKCkFNwHjh9tPozAmHjrkpJDAeGsnYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GCoNET/avIqWbOa3eBzxDwWI2etPtPUrgzcodj4r1E=;
 b=klWxDpJqb9ar1dTj+mrSitTA6aA1QM5O5Wn09aUvsrFeGXHGJms54W1Pw2B2aykz69nJuMNRNuI2QXLgDMx6jnB1ELSQ+lr34mqTwNzV/MBq/0nleAoUHvPKM/36b2NYqsFLqAC9SC1Gx6F1iCGinDH3RNOuxc64XVmpWAM5rrePxn8w5k2hp+1Ms6IQ1Czb/b/SP8AS5AOW/Epo5TimmNcxjyWuepGxAOX0TXmQ7NDLIdAI4Arr40JJOa5lOrZMzlZgf0VSh7BESyX2l6i/7AN9bNU3YCNwxSKk+57Mi2Yir585zQ2x81fQQAxrOGnfMvnNrmZRor+dCSJrqOUOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GCoNET/avIqWbOa3eBzxDwWI2etPtPUrgzcodj4r1E=;
 b=ZVRCCwDi55X102v9f0/OJtLo5EdEVPniS93fans0Zl2rbeW04DO6cSUUq6avvN0eG+rJNB/OvO2W8SMzkxbyWmhzhWTtoB2Vgx+n4KzHE6ztbBH+3dsuPqE8VRLthKPks+FWjNmVxXnw+Mkhz5rDp119ExXuR03iJS0Eoqx4He1HpJSnWwsZNvi1wywyBv3MRmXYWOBSRPJWScY7wTDugdEpf9PMp6o/ohbmB1aaoEyMC4BYfOXhiISc3RIyHc1V1osC0/GnJo0PwhNNMM1aekGxrOAON/uw1HvsVK5K5k5+Pz/vcbAPv59Omhp+YWb8zCR1icCzLjDbfpXap0HREg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by SEYPR06MB6184.apcprd06.prod.outlook.com (2603:1096:101:c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:30:58 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 06:30:58 +0000
Message-ID: <471060ec-2fa7-4a5c-8e8d-8b2082c77bda@vivo.com>
Date:   Wed, 13 Dec 2023 14:30:26 +0800
User-Agent: Mozilla Thunderbird
From:   Bixuan Cui <cuibixuan@vivo.com>
Subject: Re: [PATCH -next 2/2] mm: vmscan: add new event to trace shrink lru
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        opensource.kernel@vivo.com
References: <20231212032640.6968-1-cuibixuan@vivo.com>
 <20231212032640.6968-3-cuibixuan@vivo.com>
 <20231212190326.899a71c20ecfb143b84e93a6@linux-foundation.org>
In-Reply-To: <20231212190326.899a71c20ecfb143b84e93a6@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To TYZPR06MB4045.apcprd06.prod.outlook.com
 (2603:1096:400:21::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|SEYPR06MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: e3158577-b0d8-48cf-ad47-08dbfba51171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzlcXvXPV2n//uy8dGveY9TpGIz3QHeGp8rMR3ypR88o3IyFRxwSFL9SVAShaUzfnJSE+4b60AFelMII+9RnKJ0a/qPOcfOU0BKA0u4lq/zI6tChv1/aPp4HjjMqSDYMda+9JQo/G52fuHaox9azoUdYJtY0dc0mLpZhnDkiEJ/0PxDhLxrXuXhB+GlDrGQOwA3Y49VMSuPCvPeUHUaTSI+WgEtqjnDHHA2nV5/zaL3nSHyIDq+ztKHQwsENQDPmbYIQ7psDlEjsFHMkKEocOhFbq/ZkZVZWCXgk5z0u+7Ejz3+jtlaZrkP3mBxS+DySig5rguFu4IYkD/GAeqmCgUIjtx4kNmWsKfFfWuXgF7iFy8Xo3w1V6iboLEgWdCdxk38xiEaFUEva327Dz4oIhA7BA8PB3OG6H2lSB5ncIgzRu0JijXQCbfAIDhPppV/ZDZJLAKHksY7whgY2Bl/0Qsuvfw5Br6fjyAx2jcv/CU5jiWQnxi/jKftRKyj89Iwv26+s/sToUGHjfjKmbaQ6gvF3W/0s3N1X0POO7nFdlNmF6ZbLPMErPrre/J5DvcCZS77Wi6nmfNM4M2VlV7VXYS1LMx6RJ0vBVmdqDDoDSSh5LyMLK9oRz8d8D1lUYzsxCFSrwLiANrCbW0Vp1BV9fmcyxaPFoSu6GAjUqmxpbYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6666004)(52116002)(478600001)(6486002)(6512007)(2616005)(107886003)(6506007)(41300700001)(4326008)(8936002)(8676002)(38100700002)(5660300002)(31686004)(4744005)(36756003)(2906002)(66476007)(6916009)(66556008)(31696002)(66946007)(86362001)(38350700005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajV3THRIYU13S0puZGFRTVpvRHlnU2o3enVKQ284TUw5S05XTjE5RlBHWFln?=
 =?utf-8?B?ckNCeWRsSTVuMnlEd2lPSkxhWEpGeTZtZS8wblc0bno3Q1I2N1pGSEFNbU1D?=
 =?utf-8?B?aWlJWm41V0swTWZGY1Q1Zlc1S0pmSDR6N2xkZ3doRGlWNld1V1ZISTZPaUg0?=
 =?utf-8?B?M0hwSmxTYkIzUmJJWlBxUEdjUW1SRkdZNnZJdTVzYkE4MFJCbTB6Z3RIUTd4?=
 =?utf-8?B?RDBXMXdQRksrb09hdE42RWtiY3F2aGxSN0dZQm9XM3IydXNleTNscEQxQWdD?=
 =?utf-8?B?dGk3Z05BR0dCYURtZXUrelFMSFZ1V1NFbU9NSm54bHB1aGZzNmtCTW0zUlhn?=
 =?utf-8?B?MFVzdDhibDRjZ3ArMDJMY2VESTBmdFlZdkxJYnA0SGluYlUyWFlqUm9GV09L?=
 =?utf-8?B?MklYUmpqdm12Z0paRkEyakg2V2RpRGp1Q3FRNTBSRFhRdlNZUk5keTEvRGdB?=
 =?utf-8?B?MmR3VG9BSGlZS1JUV0RFRitHbWJkYWcvVHQzR0NyZWtTbUhMbHZMRno0Vk16?=
 =?utf-8?B?VWo0T3hSZHVkcTlqQmJhcyt2WXJFZDBYcjJqOENkVGF3RVhwcEdDOW1NYXp4?=
 =?utf-8?B?VHR4ZnNQZXF5cU5JVDNaVnNRcFZiUkZQK05hbUNWMFlrczhvdjJrN0FOL2Z2?=
 =?utf-8?B?TmVuVVQ5NWdhUzl1aHFYajVPcW8vVkQ2a2tMdjFyc05uY2tWaTc3Ty9PYXVo?=
 =?utf-8?B?aGt6OXJtYnBYak1vb1pWY1ByMGZnQjZxSWxMMU1qcEtLaG9KWDc2cWtNVjEx?=
 =?utf-8?B?cnlMNDVVcXQ0RUtoaUowS0tWR2ZwYkRESk1hRDlLOEZTZU1KbDYxcUxFQnZi?=
 =?utf-8?B?blB5OFhpVi9Dalo1L1dTNlVzek53SnBTOHZZRnYwTFFGQzA0RW9pSTc4VE5t?=
 =?utf-8?B?dmlKeW5NbkpoVHpSTjBnWWo2RVIrZkxkRm51TTZEVFJUMnVJeFBBV2huWjdt?=
 =?utf-8?B?Y0ZLL01DNGdVcFhOL2dGMUlEV21zZ3hHelk3azJBNHlFVnVBSkZ6S3hxbEZz?=
 =?utf-8?B?M1k5dCtzOCs5azhiUFk3NC92QnRkcUdTenA5K2pKTHVTNTZOU3QxQVV4K2lu?=
 =?utf-8?B?c01ETG1ObERLTVdWc210WitqYmlBVitxd1BtVDNsWFJxNGQwaWNMRk4raUdJ?=
 =?utf-8?B?VnRpMEhaeWc2WDdIbGhPQTJ2cVF5WHB4WE1RZWFMbkVITXZGNmMyQzc4RU1K?=
 =?utf-8?B?MmpEL1g2R2hrOFJDa281dFNiRysrYVJRaEVHTEJsSm1icUNOM2NkbEl5NTVh?=
 =?utf-8?B?dWVjTk42UlgwU0NmTGlTVWpWelNSYXZ1SXNGYTdqQk15Wmt5VHd6RlhmdEJ0?=
 =?utf-8?B?YzBCczdtamJPb1ZlcnAzQWd0dXE5QzlWZGViMTA3NDRwb2xVQ1ZMZWo1VU5P?=
 =?utf-8?B?S2haaFhFYzNhaElmS1R3Mk16TUcwSUVzSlhDTFNQU0VvcER0VHFVQzVTYmlV?=
 =?utf-8?B?aGJuWk9hd0VVOXVqeWZlZDIwd2hjaE5wemJoSzdQcWc1RVVkR2t1b3Ewem9M?=
 =?utf-8?B?UThUcHpLZFliMC9wOVdxN05OSkRGK0JUUnhUbW16ZE9WWEtuelQweWhLQWhv?=
 =?utf-8?B?MldSdTI5bkZhUGhXMFFwb2JvYXBHR3hvRmRwaWRRdVNiS1Z3QWdpRDM4OHQ4?=
 =?utf-8?B?blFqeTRuMmVCa2l6QlBXd3A0RG03TVVMT2EzcVUvWFJDUC80MENJc1VuWUR5?=
 =?utf-8?B?d2NDelNMQ0ZBdEVobERsb3dnNjdRV3IvL0FhYTQwcVhkTWVLVDhjSjJxV0tj?=
 =?utf-8?B?L1g5Mk54RTdTNFNkMU1iSFNCSTVzYkdKakFJRzZVSHlOMFV3alFQQkRES0ho?=
 =?utf-8?B?clZ6WUcrVXZVWTJmMmkyNnZoZWFaVjNuSUFEYzNSeFI5d2Z2aytseFJwUWJa?=
 =?utf-8?B?dkZZR0lhTURzbWVjRkNjZjBranNPMGt4V2pKQXdIOXhwNHY4cEVTbUVSUmNG?=
 =?utf-8?B?dk0vUkMwbUVoUmtJekRzRnk0R2JQWCtVMDY2ZzJhZEZsQkloSE93VVFMUFg4?=
 =?utf-8?B?WHZiK1J3RzZ2TG5NSDJnd2E4TlJUV0gyL2YzOUpyMEQ5UWNTTjJ0Tjg1V21v?=
 =?utf-8?B?andzdGVDaTBBWWFlbkx5dVNZeThOT0FGbTAvWkUwaHJndXQzTnl5b3Rlb2Fl?=
 =?utf-8?Q?vU/7yy4VD7NxGH9pky/OPE6Me?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3158577-b0d8-48cf-ad47-08dbfba51171
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:30:58.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHVI+3QhEogYVl52wgoW4MU2AHKWfhZpgrx54XzEZKC3gtwe67A0HenvkUv6RcrL0LHSD7+IZqZ4bwIRwCrm9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/12/13 11:03, Andrew Morton 写道:
>> -TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
>> +TRACE_EVENT(mm_vmscan_lru_shrink_inactive_start,
> Current kernels have a call to trace_mm_vmscan_lru_shrink_inactive() in
> evict_folios(), so this renaming broke the build.
Sorry, I did not enable CONFIG_LRU_GEN when compiling and testing.
I will double check my patches.

Thanks
Bixuan Cui
