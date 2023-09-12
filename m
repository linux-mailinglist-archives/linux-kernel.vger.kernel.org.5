Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E04779CEE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjILKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjILKvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:51:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B816B9;
        Tue, 12 Sep 2023 03:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE53GSdOdgj425Q/dvnR/gW04N+RiXICDA2vt/5iX6Kt3xRAom2jFbtzVyMN/sivRwsjqd/n6H2+KG/g8sAtSf1fhcWgNyZwuA6EdSbLQoH3PnFVjvgnG0L8/yJUh5Vu7WT2fHwJ0IvUYaGM+ArP7uN5nDNVRx8ei2jM1GyNvsDOXtj2dlNp30e+ewX9XfkFcJ2U6YtBiQIwg5gdzQ1pR+VXicq/NDkidPCqE6zK+8IZpFEFIizaGczp/7V7pIAfj1Rl+ttIECRnZL94DMo0allz8b9WCZFDtVVKekFZj/LuIHX5GCm7c9kv5DxBkdYZBvGyqPu+Y5SSrOi4z6I7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFfNI+c1ue8SoHKCGlhaHH8byIC/xGTaklNqsI9lNLE=;
 b=Onk8XhA4tXVGWdaQKBlCc5/wMXOYQps/ZUu3H4Q/KFuJtNEB1GwuACuV74fq/HYUNAWsGHeKDng53lXjKI9Tmpl+6FJq61f3vC5w5jS4u7E0LSLLfoPOkkl/NzcS+cDMjXjO7gszyioir0D4+F5UoYZRu4+fe0jQdlP6gKvWqUyg+gbhKcb7qsxxVrlKZd2khem5ZCSsrn47jm3yWAWQhC47yyr0rgKABj+VJ0D8Jo0iTuVZ5GEMtG6OZacvLcyqyJTkcXGeG4KT0PwFejXl0t3sTZFm3CGwjPOfNTiHR6rjMlls/iCmO9/iPqJVKHE9ZmBubTeq7yLNXYSQ8Oe+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFfNI+c1ue8SoHKCGlhaHH8byIC/xGTaklNqsI9lNLE=;
 b=XQJDGBZrafUIehsLnkZogAuISKPqcAwu1X8OUkCgBGc2VU597rkzD4xivemc0FmzZmO4T1eRzTG+My4+kbbNiHWEDDhbN0te+cwi4kWbBcl+5BqZnxUo5dKqoA40t4/ANNpwjuRXiM5n3c59c/n0GC6wc4FfW33Qt7EHhHY3qbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PA4PR04MB7503.eurprd04.prod.outlook.com (2603:10a6:102:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 10:51:45 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 10:51:45 +0000
Message-ID: <dc402d33-88b1-e828-e6a5-2de060fbcdca@nxp.com>
Date:   Tue, 12 Sep 2023 13:51:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
References: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
 <20230911224452.15739-3-iuliana.prodan@oss.nxp.com>
 <67de5706-d966-dd71-85c3-c95bc1b72733@linaro.org>
 <c0b32f41-46b4-81ad-9718-5f0856e42cb1@nxp.com>
 <32287c0a-e3c1-e474-3c90-913fe2c79879@linaro.org>
 <fe47a94e-6788-a5ee-e8ee-ca58e4fa62d6@nxp.com>
 <af1959ce-d817-2a9e-9c28-fed8c608a3df@linaro.org>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <af1959ce-d817-2a9e-9c28-fed8c608a3df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::6) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PA4PR04MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: e550fe26-4c13-4119-f9e2-08dbb37e41ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21MhZNSM69QF7+MbC75P1aIqAjT8bGI2mi0csA2C+/bof8sZnXYIClGsXfuTUH5ED/tYlGKGXCyEpcN3M9/CFfYrA1zGm7rFnTYV6IKJrzkOJp6HENcino3TpUz0kLR1rkl6eBENzjnrmvJrKA6ByioU0DRrKqGADlT7MO5+oHeXQdXlhCOyjzN8+9UPj63K125hJkR+yqPiYeu3Lc8jyC6aQb3Mmpasmn0icLwJeMUvo9VJLY90RilMdvsy8HH5b72h7lULqE/lmhO4T9USR6bYMVkHFcm+18HlihKfrMwcehwXDTaTzAwLe0JKvItqy9ZkCj8eTLVopQXBwRA+bykY7PuNotwHoXmQ6mjtETCjKRTkDy0O3+UrQ9Y1D4bGgIsAZ6Nj9zqX54qSdQW9+LyEcv9Ga4hQcXjlQzExX0eqHiXjb+ZQ3Kf16do0H2CixZ1eUFtQ9GO9ODPRpF0AZ1rKMflibp7d0UYhc8Wkg8ad3Kr0Pq0W0hW+aV68562/Uzm0AoCzFFU8OMMcc6rPzFSF71hgahrAd8pDhJwBwRUmQ35bsbeYf7zbPsrUbgARCk3izJ9ayAixXqiueBMPTTN3/H+7BswVLoDl+Bia3eSfedw+tiQujUDEA1RCiV7Et+TwXcgItnSFg2vQf7Ln0BLFB3aFLpDv/KauODUSg6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(186009)(451199024)(1800799009)(54906003)(6916009)(66946007)(316002)(66556008)(41300700001)(66476007)(478600001)(38100700002)(7416002)(4744005)(36756003)(86362001)(31696002)(2906002)(44832011)(5660300002)(4326008)(8676002)(8936002)(26005)(2616005)(83380400001)(31686004)(6506007)(6486002)(53546011)(6512007)(6666004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW5tMmNzQ1Q2ckF5dWd5dWFRb0JlTWsyVWZSbGl4L0FlbnV2RllBTWpHK2Q5?=
 =?utf-8?B?MzZtTWdHcE54ZlJwT2xLeXZDbVlBTjFKYXJUVnlWNlkwODRCYzJkaXJQdDdW?=
 =?utf-8?B?QXQyeXhEU09iT3pPVmxGM0t5cU1JZDJDblRVM293NzRkK1N0WUxvQTBMTHEr?=
 =?utf-8?B?ZkdoVm9taE5sZ0VKZExpTTExS3FZRmRZRE12QThxcHBIZXRkY1FzQkNlbytl?=
 =?utf-8?B?cTVybFdOR2dyeUVWbXU1Rm1RR2JzcitrTGloWE5vb1l5Z1VLcDM1VTl2V0Ja?=
 =?utf-8?B?eHgwaUNwUmJBQXFCOXcrUTd0VXRLM1lxYUpxWnRvMjRuSEc4TW44dGZxV3RJ?=
 =?utf-8?B?dFkrVWZwU1ZKcTdPUFdCS0pOUDB0Z1FHWWJQSkozN2tzdVMyd2tDTDVrSy83?=
 =?utf-8?B?bDNKVTg4bGxpbU5HKzRWSlcxYTRoZ1F3NXJJRGVrcGJzVmIzQnpxSDYxRXU4?=
 =?utf-8?B?emZEN2hlZGNhV0tQRTNMQm9PalN6Wmt6Q0EwWjVVN1U3L3REeVQ3OWtVcnFa?=
 =?utf-8?B?eGk3QTE3LzZVUkNab1dpckVxMmdrdWtKYVFKREFyK01oTkp1aW5GM2lDZFJR?=
 =?utf-8?B?cXpaRFc0Q0JXR0FhWE9VdW9HeG1qMVFDOXRpWDhvVjVCU0xGZUFiSXRXSENq?=
 =?utf-8?B?bEkzdTZYZkpWZkhLRHhCd0ZtdFB5WHhsejlaSWZJQVA0QXlmdVpuVTZJNmY5?=
 =?utf-8?B?RlNUdVUyR3lwWDE5SFo3amxBV3ZZTXJKRDBnL0pZS2ZuUDBHVUFlMXlTSG5N?=
 =?utf-8?B?UkdJZDdUak5lKzBQeXdiM0JRelZIZ25McnN1dVFSZklDNmptQmkyOHViWVZU?=
 =?utf-8?B?NU5QZGNGSkY0cHlWL1RIeXorZURvVStFai9udFdqamx4SGZQN2RHMTdsWS83?=
 =?utf-8?B?bEVIU1AzSmwyVitBTG1KNnRwVldycUl2WlRZN09SaXJDZVFpYkl2QWQ2ZGZK?=
 =?utf-8?B?U0Zxek9KeURtSGVDZk9nTEF1WHBPOVQwbEROMU5uSjN0N1RNcUhpS1lRSm9E?=
 =?utf-8?B?bXA2Nk5qY3VvODh0cW05Y3ltbzg0UmRPN2ozdnpjNmEraEsvbU51Z1FONDhD?=
 =?utf-8?B?S05XYWI3c0hiQk5oa0EvVENCc3BZVnFDUzVZdWJubXMxRHY2S28rWHFROXVv?=
 =?utf-8?B?TVFpL3cwU2crRkliWk1IZGpNN1M1aStGQnZ3RmNZQXFlcURpbTBucCtXSkRX?=
 =?utf-8?B?M3preEJha2Fya1dJQUNpenp6WFpLUW14djhhUkRwVFlUZHkvMGNaNGNva0Mv?=
 =?utf-8?B?RndBK2paYzBybjd3bThEYWU1REl5ZmZuQ1VVQ0VTUFIyNkhlaWtWWDM3SFVW?=
 =?utf-8?B?VjJlRmx4WnVqQ1JlVTA1L3J0KytiNnV5dDRCTWNFNVpMNmlJV0FpNHYzZWFH?=
 =?utf-8?B?cUVoQXhJMUNNRHVqdUtXQkovUFROdDVmR2xiQmYvaVFkYVJKSHRLb0x1Vldn?=
 =?utf-8?B?SFBHOUxrazFKZ0toNis1Z3dka0V4RGtnL0xHbkVVMlVTWnZVYVlOL3RSaWNZ?=
 =?utf-8?B?NVB5YWVqaEJGalZGdXlPUERDWTBZbWwrM2NKaVY2RXdTZjMzTlBENWJNbVdm?=
 =?utf-8?B?UUdyeVhvVGhHQTh4U1J6SDRkZFIxdmhublVLUzM1SWtFODFGNHJGeFgvSzVu?=
 =?utf-8?B?MWFCY2Noek5Ma01jeGFSZkJaaDBPNDFGTUNyOTdsWm9sK2ZYSEE1VzNHY2ZG?=
 =?utf-8?B?WU1oN0J1cm9KZjE5ZEZCOEYwam5EVzRDR1NEZGF2SHhPbTBVbG9EangyNk4r?=
 =?utf-8?B?ajdwd1ErWityam9JcWRRcW85c0E0eTNXdXJkaGxRNXFGTjBVOVlyb3ExZVhZ?=
 =?utf-8?B?QnYrblQ1WE82Y3VpQ0JwNjhsbWlTYURxYWk2R2htSEIvNFpuelg2b3ltVFFD?=
 =?utf-8?B?WFFlMDNxZUZPeFVXRmlJU1ZleXBkM0d5NFpaeTF5R1pnNkMvdU4xMVZhZDRN?=
 =?utf-8?B?UWMxYnFtUkNDajY2c0hWYTdSNHBBUGVKMGxBWWpZblFLMUVsNmZ4am9LNit4?=
 =?utf-8?B?ZW54SHk5ZXdneXl0c2thSExxNXFPUmpTakRNNlBwMmxhRGEwTXlIMDhrYTJQ?=
 =?utf-8?B?VUJYMmdoRW5wZllRYWRYVnUyb29EejZyYXN1TWRZWmNDMDMwdjgyYnpPbWFr?=
 =?utf-8?B?TkV2WGtOdVFhUWI4TVpRY1ZtMGd2a292aWZlYk5xY3R2RXlzUld2SHFESFdM?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e550fe26-4c13-4119-f9e2-08dbb37e41ea
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:51:45.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpqFvQuU4JXlyOUshXCv+GddbgQKPX28xuSmvUrbr8y1pLXq2XiiZPH9Y22mlzZWd9Gh0ZXjLGPRyQe76nMRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7503
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 12:36 PM, Krzysztof Kozlowski wrote:
> On 12/09/2023 10:49, Iuliana Prodan wrote:
>>>> Should I test this on other tree(s)?
>>> You test the patch on the tree you send it. What is the point to test it
>>> on some old code, cherry-pick with bugs and then send?
>>>
>>> If you have cross-tree dependencies between subsystem, isn't linux-next
>>> for this?
>> TBH, I don't know, that's why I asked.
>>
>> For sure one patch is for remoteproc.
>> For the other, I don't know who will pick it, but I'll tested on
>> linux-next, as you suggested.
> MAINTAINERS file (and get_maintainers.pl) will tell you. Specifically,
> this does not look really related to remoteproc patch, so it should not
> be together in one patchset.

Hi Mathieu,

I need to send a v2 - to fix the dtsi missing bracket on patch 2.
So, should I keep the 2 patches together or send them separately?

Thanks,
Iulia



