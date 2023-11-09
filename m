Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7403A7E6ACF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjKIMro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIMrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:47:42 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A297210A;
        Thu,  9 Nov 2023 04:47:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jzn3OYzHublv1mosoW7bmFmMQD0+GREN1ZTSD+gT4D3WrQov4cm1gws3KV0Elr6VF8dgiW9aOYPok4UPvZe8SjP2p2KFprVmRoc0ws21Xi7vd7ryT8W3T8Z0fwk8h/PBcyH6P5VnFk73NAjAqOjVTOKyoD4ajf+UazPtD/nFETTO25rtr45dnXRbMkfcb4TnJ5Id97vNX5uIAxDF4YIOqYxz1qF7yTS42MpO/HfUZKD9YXN+RWYCWtwEJCRjQrCUGz4uEftyW7lt0WsOneOZa0d90mSrJshRwOc+gq+5vMXkCaiqyBt/GlLspyGVgQB4d676Z5f2AaWNtIVpbM9VkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2qvhMisKQ/SzjA1rIee9hfQhVbTPmgEPfnGs2pVZP0=;
 b=LmPtGXneZLZwIqGGVtT4P1L2ahRZAEN74txpjMZC0Ls70LtjT0xiuq2aEZRcZKkPwBu++Mk2WGui7ZHJW4JbjN7t9WQLVcPDPDirK+99TF9BcMUIWfRDkeyId4YP2P7R+xjblp0kkNJ8KW6hcI3lOpCpiKiE3SfbeIFcO9zQVshscrv/RrlhnQOoZhOKVFpUq1i50w7H08Ci2ecg8188OiwurdHiQaCdHGCBfI7z22v7TitusSmfH7BK0zoBncA/RNCS0zZVH3iVCTkdnNxfB2jEx/3AMUo7RV0vZ+S5Fbmf24kowKWGg0FHcaOYNAa4sGfOsCAfM6bnY5B7Loa2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KULeuven.onmicrosoft.com; s=selector2-KULeuven-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2qvhMisKQ/SzjA1rIee9hfQhVbTPmgEPfnGs2pVZP0=;
 b=Z8hAKtpc+Y3JbUHb49xhqs79aV3cnUJGHvlj10CS4wbS5VYt/J0gZAdPz688bVn3GI2t95bq663Eq+KcQVJOCNyPr8ciCQ1MFn3aixDFKOXCa6ggQ7Fn+LLFIxwevWreMBzzfz3Sh0AImnEtbXWitxFoyAjNY6QSsQ+iUbmggsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kuleuven.be;
Received: from DB4PR08MB9334.eurprd08.prod.outlook.com (2603:10a6:10:3f5::20)
 by VI1PR08MB10104.eurprd08.prod.outlook.com (2603:10a6:800:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 12:47:36 +0000
Received: from DB4PR08MB9334.eurprd08.prod.outlook.com
 ([fe80::5891:9155:ec39:7e34]) by DB4PR08MB9334.eurprd08.prod.outlook.com
 ([fe80::5891:9155:ec39:7e34%6]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 12:47:36 +0000
Message-ID: <d7876a33-abb5-4988-bcd4-54bdf6e674a7@kuleuven.be>
Date:   Thu, 9 Nov 2023 13:47:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] selftests/sgx: Fix compilation errors
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
 <119aaa2820be5dc58144e74574cfaa7777f79604.camel@intel.com>
 <f2726c67-87f7-409a-9ac2-e845249348cc@cs.kuleuven.be>
 <7e729488e2f841f384b719d0509a4f78f491d477.camel@kernel.org>
 <be63771f-080e-4832-955e-13f5b06b2010@kuleuven.be>
 <CWG522A78YHD.37CO0T9F3FVXB@suppilovahvero>
 <55d6aa33-4ffd-4a0c-a449-63b136f5a1a9@kuleuven.be>
 <4163a276-895b-418d-aab3-5f4d8da69230@intel.com>
From:   Jo Van Bulck <jo.vanbulck@kuleuven.be>
In-Reply-To: <4163a276-895b-418d-aab3-5f4d8da69230@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::8) To DB4PR08MB9334.eurprd08.prod.outlook.com
 (2603:10a6:10:3f5::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB9334:EE_|VI1PR08MB10104:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ca0306-0633-4b15-6a13-08dbe1220cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXSBT9qJx9de0PJLgKhuJRfZ4MMN4520UX/ygXHELz7tWO35GAFMAF818ZRSiavQ3+zcuM1M82qxrt5ihLiqL3z11JTYkBjlmZ24CUqdEnU7WiAyqLOfEd2lEDnKQNC7XLhPuISnN3FIMhXj9vyUy+/NXkv0tclG/TdYeKeyTiy+d214rwhkoyzuvkOYcYZPe0Rl/YwlZUrXbqjZRJkEcfhkYpC59Br1iaMJkDZdxg3O69At1Vs5V+dRd0ISl2ZLAtcFRC7qYR1v39m+LzVyxQNJJtNGyR0u5uJbFpCb1mx1S9Hs5a6//4Vw+lMzOwMQuDUa/71XCLYn5Y//21zMBx0Rdtu11BpLJZ/90kTQZQWv3rF9lzK1NGVm0V4ez0RXAlno3GvX0Cj/dfUfAr5Qc+FB0s04ATjjsA6IQGzto3covBxspCEph2s8RLYHcPlIB1/qq7JN9sBcMmLAa4RWOi7zWH2js8ERr3vaEi4zf0SYy6ivRk13/l7dBZ26qRgsbcHDn6alhHNwVzeU+yHRl1+ng+Q7M9reTiVL9X0TOh/RfIpGyDyIf4pf9z+bNqyDxNvSL0A3A2ekHKHM21Ev/YgztcqLksEw47e3NytATC8V54Xfy3g1ihMOLm97YtNpHFwCePA2ygc8pScdxzifMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB9334.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66556008)(2906002)(31686004)(4744005)(41300700001)(8676002)(8936002)(5660300002)(786003)(316002)(66476007)(66946007)(110136005)(31696002)(36756003)(966005)(478600001)(53546011)(6512007)(6486002)(2616005)(6506007)(86362001)(6666004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXZYWklKbWFuc2hrZ2ZlTU1rYW92emJvQmVXeko4V1locXRRRHBJSFZkcHhH?=
 =?utf-8?B?dnlLUW53dm9SaTdZMkJ0WmY1NzlUNkNCZTZZekNwSmo5T2dKeENVRDF0bFZP?=
 =?utf-8?B?bFJvYmg3b0FPL216V1ZxVC96enNLSVVBWU41Tmk3T24wN0h5amUxeXBBSVhp?=
 =?utf-8?B?ZldycEpNVWVRTmg5eUlzUGl1ZUo5VUNFM1A4T3lLYXVCemV2NXc4WTIzVDFG?=
 =?utf-8?B?R0tQM1EzeVhFWUpzdExJdkxRdG03VkN6bE9rYm5PYmtmWnlLSndQZnZZOWQ2?=
 =?utf-8?B?RnM4Rklxei90blpmRVJJQ3lzQ25yRFJsRVNlbWR5eWdDYVFzeWNWMDZ6ZjhX?=
 =?utf-8?B?Uzl5MERZQ0p1K2ZDcEorVHViMk4yU3lQek1OU0NMSVVsK3o2WmpEWllrRDR5?=
 =?utf-8?B?QzRTRlhwQXFrNjdrcGJoeDAwZ3d0aUVHZ1Vqb1hzMkdTUEtzKzNaSDRMeEI2?=
 =?utf-8?B?dlljMDlVY3RhNkZ2NHRtbFpBNzdoZU84dWhwVVdrYTV5T2V6cGhzcWNKbHVy?=
 =?utf-8?B?QmZOSVJHc2R3NkRKZnJtQThMVTB6K2MyN2lTeXZJTHJaczJtbFkvYkFhaEJo?=
 =?utf-8?B?UDJMTlVWT0tvbWVJaTZpamJ0cGJnc0l5SEk3MitqZURodE4xTjMwdmViMkZm?=
 =?utf-8?B?dmxubklqWTZxVG0rUlRTNk9mN1JBUDNHdjBKeXZtN1hOZXhIRFdoMUtxbVEv?=
 =?utf-8?B?L2JGQXJLUVhKMlZQeGxPdlJvVCtOQ21iVE84My94MEtsNnNoYTRyV01JclBt?=
 =?utf-8?B?ckI5MU1SMkpDNW95amxXa1FVRkszMGFnUm9DaEYrUko1NUZpRUdGckloQnVs?=
 =?utf-8?B?SDdTT2QyZnd4bkxmeDZmMW41TDZLK0VoZkNwWmFNMkNpTlRyd1ZaSzVYQTN2?=
 =?utf-8?B?Nm41VHdxY1E3bitlUk1iSVpxYUJiQ1NHL25FcFBXdlJZalNMS1M1UCsrWGpI?=
 =?utf-8?B?Um9zVE5rRmkwcjNTcEtWTzJIeCtGODB6OXVuRWtmcGNKeFRaclp6QjlqWHA1?=
 =?utf-8?B?TnpiT05DUHA5NTBadVNXK1g0WWJmQkozWkh0MFRVR005RWlqRTk4bnlWRHdS?=
 =?utf-8?B?NXpFKzZHV2RlODJlLzFpOFFZQVNLMlJCWnpwYXdteGtNaDF1UFJtWUtvRjFa?=
 =?utf-8?B?UFJGQThuVlB6TzBwY0lCakcvYTNwVlEwNG9YTVRQVnRHUWI4WjVFaXR4T0g1?=
 =?utf-8?B?QVMvcDlCeWoyS2k1bENieGxwUzJKT3V5MjNqd1p5Mk9iU1lSMjUxbVFUdjU0?=
 =?utf-8?B?VWJJWDA4b1N0TkhNa0JoZW0wbVlyQ2tzR1ZUOExIUWk4bUZIN1lCQ0hyOExX?=
 =?utf-8?B?UWtjc1p1eU9Ya3NQWkxiYVFLNlVLckdraU0zcUUyREFsSnNrcDl5dkJCK2dR?=
 =?utf-8?B?dUppUTNsSmQ0SXU0NUdnTkdGdUpPeExVWFFVbmpYcjlONXZEU0h6UEFlZGhh?=
 =?utf-8?B?K0QwQ1RaenlGMW9HU2YwVTFQaG9sMkQ0MU4vWWZBc085L3h5T1ZvTlFBTyt6?=
 =?utf-8?B?Q2p6d2xRd2VWaUtpNHZoYXhKdjM0MU51cEpreloyeXJWeURaLzNXK3J2MVFz?=
 =?utf-8?B?NElOYWxUQnhZWHFHTDlxTTh3RFgzd1IwMjh4cFRjSGR2a0NpWklka2Mzck1r?=
 =?utf-8?B?dzJHZWJ4WXF1bk9rVUdOUnFHcFJybExDQTlKaGovRVNGUS8wYk5GczdiRENi?=
 =?utf-8?B?OVI2MU1tWWYwb2dFNVJxMUZCYmpkOUE0VWt4SVYrc3JUb1grRHBpcE04RUt0?=
 =?utf-8?B?NFlNbDdJTURpWFZqYU9EcER5UVdMRnhsbHllN2c2TmczdFlLUjc2L0ZyNGIr?=
 =?utf-8?B?dktaV3lMYlczTkRzeXBCUGlqOXJPajB2alplVGdtK20zU3ZxN2VSN3dubDBE?=
 =?utf-8?B?aUp5OXFXTWtTanpGd0RDTVloOVgvTnlSYmRCRFZlSDVqNk9sbnUvb0dlZ3c2?=
 =?utf-8?B?OHVwdC9YQVRpMzloQXRueGQ0anhWRFhYWGh3cVlDM1E3UFREQ3JhaEd3eUdZ?=
 =?utf-8?B?MTRWRkR3WUFVT0d0THBHc1l6eWpLNm1ockVPaEc1WVNoaFhqWGtJMGZkeFQ0?=
 =?utf-8?B?R3RPSGIwY2dSY2l2U3FZRXlFeHN4MGk4c0pHNFhkMHpLUFN3K0hhdXg5QU5l?=
 =?utf-8?B?Wlh2WE9SbmtjUEJNSk5tTngrK3lWQ3h4cWdSOXcrQVlFdkJmcy9iSkg0VktN?=
 =?utf-8?Q?6XprPI5inucyG2/AwhtV8mHgV1JNKYROJVKf9GOg7Vu0?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ca0306-0633-4b15-6a13-08dbe1220cb1
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB9334.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:47:36.3410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7drZ4+TbdyeWF9vTGe6IAoT1BWdPK1Nh1maJUx7wLyjoZVj4z8Vh+2Bl/AW+ytHIBaVDgdp4jQgDjMtj09/Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.23 21:46, Dave Hansen wrote:
> Yes, you've missed something.  For your reading pleasure:
> 
> https://www.kernel.org/doc/html/latest/process/2.Process.html?highlight=merge%20window
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

My bad, thank you for pointing out the links!

> I honestly didn't even think about applying this until Jarkko said
> something on 23rd.  By that point, it was far too late for it to get
> sorted out for 6.7.  So, that puts it in the next merge window.
> Specifically:
> 
> 	The release candidate -rc1 is the starting point for new
> 	patches to be applied which are targeted for the next merge
> 	window.
> 
> So wait for the next -rc1, and you'll hopefully see your series get merged.

I see, makes sense!

Best,
Jo
