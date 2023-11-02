Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1D17DF0E6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347222AbjKBLIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347250AbjKBLIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:08:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29DE188;
        Thu,  2 Nov 2023 04:08:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A282pMj003032;
        Thu, 2 Nov 2023 11:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Z5bNaKET80DQTBg0HW6YrSj7iMcxGA3OQ3lmw2xKBag=;
 b=ewgiX7Mp7T0ZCwgOJamW+o5eV/6Alfi/mGuAvEE3cUenY7XrgEcfC9nQkAr8LOMrgtSF
 n6ffvpzWNi6FFaQcXoov9isFp9aRru1Lygrvp2SbjOjsNc116Qes6GtNsrzAtSSK8VvN
 19G6VZHBLctAx028/8VGDkAa2zvUIo4plP8xxpBWdYKMEABfGJh2M1YLWge5Nj5aSin3
 lujlM3+SVOzIG6VCQe0X3hOejP5zmYC1aS8uLEIjbryTA9fl65ilbq4FbAvi1R4z1lO/
 oAG6swGTUAY7RdnBGScRaX3gSLfXSH+XzT6lvEz0C6I34RdPFB3l1VkfMLqFioQaRe/b ZQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtshx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:07:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A29ewF5038141;
        Thu, 2 Nov 2023 11:07:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rremhwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 11:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTF2O/vDRUiYa58xZAh9g7/NOwr7TW6cJK/3GVxxpN9K/DWtrRGTK/BWShBQZ52yv4XDKo4M7SwOjCuc07KV7SnSIZgpYFkhvbBBwc0zpAn85y8BJadZAWG+P/BsUM1/4o25LLzTlAiv691GSC7QqiDU/J0tahEC3iDjC+Ofhc1SFPlUhqYiy+0ItT/4qLIw5MRtXjXRo/SxBsCFW92HiMTGBbI+ihvBR6QtlSS33wW/plNlRiLRTmhDKagGmC5hQU16LwBizHD4uWvhxSPUZ7RftVE7DIip/s6Ng5shkKNrDw+GrH1h7qj8OCraWFCtAQih7EhLYfwk9D0SL9viVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5bNaKET80DQTBg0HW6YrSj7iMcxGA3OQ3lmw2xKBag=;
 b=Udjumc0v+obSvfiO90XnUUfzJoGUS5kPgCRHCMROtQxL3DzHbBqYfyKeOxp7ESgm8vK0fRUZ5+xxba5z6m0cyHfn1jYrgaT2aa1n5vP+wVTfuRllDCLEFub1dIsFcaOoRMAh1M0iuFxlmjoRYN/J2+YDkuMuZyRiBM8UAyxOMOy3O5tckG0tIa+Ytclyxgux6pfScPtc4npIvcV0IiZpg4A08AHrzSoWRZon9SO8EMRv+lXRdxXk1zklNd6Jbd5BJHoPUdXp6WFrKlBrd+CQiEFjFOX1S3lyYSMOCQxJAkO7q35WJsbFgP7efAtZQFkOqCv+9KoyQSz2gcIEu++25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5bNaKET80DQTBg0HW6YrSj7iMcxGA3OQ3lmw2xKBag=;
 b=itlU9yghR0VjBjwNpFavK7/HJXI5IJQPENtStK6oVzmot4NJUuAuQ9rowraKleYhV6QinizCcF3NO/VQQEeSe/lI9Z4cDyImLoophrSxtrmb/X50W3cQgzAFtgW9MpgOdIuAhPGjXvx3a5JQ6gG4RP0AdAU8vqVc7OhHbPqwQ3A=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH2PR10MB4135.namprd10.prod.outlook.com (2603:10b6:610:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 11:07:27 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a39e:b72:a65a:a518%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 11:07:26 +0000
Content-Type: multipart/mixed; boundary="------------CiZgA0yNOnKi5UD4MRnHMeSd"
Message-ID: <378b0571-a89b-43a2-8921-3f23afa0f254@oracle.com>
Date:   Thu, 2 Nov 2023 12:07:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: translations: add translations links when they
 exist
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     alexs@kernel.org, carlos.bilbao@amd.com, corbet@lwn.net,
        federico.vaga@vaga.pv.it, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, siyanteng@loongson.cn,
        src.res.211@gmail.com, Jani Nikula <jani.nikula@linux.intel.com>
References: <20231028162931.261843-1-vegard.nossum@oracle.com>
 <0e003343-3c64-4fee-a56f-987a4ef6e336@gmail.com>
Content-Language: en-US
From:   Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <0e003343-3c64-4fee-a56f-987a4ef6e336@gmail.com>
X-ClientProxiedBy: PR1P264CA0107.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::20) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CH2PR10MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: a04af504-baae-4a1f-960c-08dbdb93e5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQpY5VcVHP4bKZtpD8D1PrAPC9G585WiyNMyy9K4IugJ8ONhzoB42HxfR/RyEuU8yC+GNwjKYDCgMnJ78AenpBHxkPzWb8ggHwqJUJ42MiKlHnjVV9yV6eJSwUxu0wSu8safcBG2nA3rdFSEZbYD7l8elw3sU6Y5rEKsommEmqLW1C/aWDQSnCSuEZZcfWmT/08dp4+oDYwq4KHJtxRE94bGh0pgfi4JysbVHdRoCmAcG2M7ToXTyJt7nC9Yxo4Qn+UslVWOme1Hyq539vIAGlv/6+cCNduMf9F0JJMhxGG3LheGHtOISGDoYdwIn8l2aSSAh0C8tOyL06brnUiFB8tXQ0xKnKd9n8Nik2IcCS+INlntTZZg72vJeYgbtpviquWOXAijXd+F9DPb3FMGdFqnhYkyiB+hh2p7ssqo40uo1wXjyW1IyHfeDJcjQgEJWj9sJFnnvgQzNQNAkt3jDtmYHkqLhYcUWySMLkkhW4/V6fWNMVg50Pfn8zNsaxAHb0r9Yf+MtUBUThNMsVaX7wjl6ygGZh7e9/QqNMTDgwh7L954MTaonW6fGd2OF9klueoDkGfCyZZAwWy2EOR+ZoRql2zk6sKnqqcEryGvADOlZHieHKtbfiiPKLuMQrSvGHzAKCmS3ojMBB+FUeeJRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(33964004)(53546011)(6666004)(6506007)(6512007)(2616005)(6486002)(478600001)(83380400001)(66556008)(26005)(5660300002)(235185007)(7416002)(41300700001)(2906002)(66476007)(44832011)(316002)(6916009)(8676002)(4326008)(8936002)(66946007)(36756003)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXQ2Z09WUllLOWZkRW42MXdIQkdqMUF0bEpmWHRJSXl0ZjlxL01mQU1PYnVj?=
 =?utf-8?B?WGlHK3NiQkM0dWRyTSsrNkp4eE1MMlEram9WSGNwMnZBS1FwUEp0aHpRMk9N?=
 =?utf-8?B?L2t1MURmbFhheUZxRWMwTTZLVXRKM0llV3E3anZHU0MvNzlWZWxxQitzZjA1?=
 =?utf-8?B?bEFFeSsyNklkTVNSZFRHTkFTbytmZFVPeEJOYlJVcGlQNFVKVUJ0UkdNa1h5?=
 =?utf-8?B?d3ZMM2NJV3VJYWRSZmFYaG9qUWxsN1UxREVvNlU3bDFNcmpGSERyS2szNnA3?=
 =?utf-8?B?TnA5RXJ1bXA0ZVg4M2VOSy8vTU5IVFhwNnk0WlFnOUNMc3RJaDNHTVN0T1lq?=
 =?utf-8?B?dS9pc1A2Njh6UjZwYmJUdUMralh6bmd4Wkl3amRWUDJUcVFoWTR3bU9uVTRM?=
 =?utf-8?B?NHZqb0haNHVIUDA5SmhlQ1hNZkxSMmprMFg1eHJqam9ndXIrbHpWb0FMQXYr?=
 =?utf-8?B?dUdKYlNHWTZFMmVyenlTV0tzMmtXNGttRFU3ME5oWUw3UFNGTkNkVnA3MmQ5?=
 =?utf-8?B?VlB2UVo4dWpPT01xRTZ0VFZKanh4c0RtcFV6MFY0Tm9PYzBYQnVoTzRkTEVU?=
 =?utf-8?B?Q1Z0d3QwdTl6aVdJTFkzQW1MTks1UDNyZmw3RVhHMW9ZRXFGR3NIbm5naWtu?=
 =?utf-8?B?Z1dMUllxL242TzJUSnZybkRzdVdUMFRWNUJ5cWtoRmZYSDFaU0w5cmhjRThC?=
 =?utf-8?B?KzRTSjFlRlgySjlsTXhsbm1teEpBaGoxQzJHWStKQVppMXpxenBaanV5WmV6?=
 =?utf-8?B?M1JQT3lZWlQ0S1NzT3dJSnJqbnZLdkdUSVlGcjlUU1ZSTE9YenNURzgrU1N1?=
 =?utf-8?B?clgxTUtDc1Y0RjlXYWMxZy8yVEtLd3UzZW1EWEw5L0FCVGJUeDRXNlQwUmhu?=
 =?utf-8?B?SnJVekZkVVZvN2NZb3NmcmJqQTJPeTRIRlZDSnp4d256VDZKNENvc09HZU8x?=
 =?utf-8?B?cGE0eTdmaDFIeFdYbG5JWGdWYjZTYzI1Z3VDeGN0akdidHlpYzFSRU5GODE1?=
 =?utf-8?B?VW9oa0RsMGRBSjNKd3ZTSWRIRTRLeWlOQjRsNGozNHhxRlBCRVh0MzF3L3Ra?=
 =?utf-8?B?a0EyOE5Jd1lUZG1MSDZEZ1VDNVprRzREa3Vybis5UFMvY3N2cnpTNGU0Sk5M?=
 =?utf-8?B?cFR0eFgzWFpxUFZ6SGNvUnNtQ2t1WHQvUEI3c3pLTi83cGhpcjBTRnBWWVFt?=
 =?utf-8?B?NkFIZUs5V0lNYUV0UjJ1aS9WY2QxdjFPK05rODZqZkJMTmNyWVBKTUQ4SGx3?=
 =?utf-8?B?ZUwrRTZidmRERDI1b0NzQVhyWFhOb3A0M1BDcmlWQ2t6RkRiRVhhVmtpb2h5?=
 =?utf-8?B?TWVSR0wrOWlKSzArbXpZOWFiMHdwWHhyQjJuRTgzV3I0WU5xNm1UQ2VrMTZz?=
 =?utf-8?B?TDVmMk8wK1BJRlFGUE4rdnllT3ZRejdzQnl0OW1IVkVzMFErNGFRTVYrYmYz?=
 =?utf-8?B?WTFCR2VWaTNCVnY4cEhKZHd1V3JJRnNYaUdOdG8zSmkwUjlFY0p3cjB5a3Y4?=
 =?utf-8?B?OHA1T2hvVUZWVmRaRCsrRjVkSGsrNHo0R0tkeFhuSHI3L0ZCdUpUbVBoQ2RK?=
 =?utf-8?B?S2F5OFd0MW1pSENHNFFTa25YTHRVWXo1TGZXZWUxdUVCSmNpZzYrWkVJOXFO?=
 =?utf-8?B?ODd5OURSclpTeUxBY2R2MDhUa0hsRTRVQzZHWXlueHp3YTg5Tk96UThycTZE?=
 =?utf-8?B?RE01encrQytUOTVuVHdwQXJxM3J4Ly85ZFZLRVFweDdZdWxURm1jdXQzWkdL?=
 =?utf-8?B?alRoVGR1V2FwUVhXbVNiSTBFalJodnMzQWc3RGphTEZleDZtN3pWcEVPOTJV?=
 =?utf-8?B?N1F4cDhVTVR5aW1rY2JmcUplSWFLZXJqeWRmd01BSWJqdnplMnFBeXBTNC9C?=
 =?utf-8?B?T0RXdUNCWGZleHovOHlobHhEV1VRaWsxS1dqK2NLWklsdk4rc04ycFNHZk54?=
 =?utf-8?B?Z3hnVjI5N2NGMEVFUi9XcDRJRDhLVndCWjRiK3VUOWtCM3YyVjJidWVuS05x?=
 =?utf-8?B?R0RhQmpTZXJUWStiaTdtdUkyczI0ZzFGRmJJMzJzV1FJOGtDVDltWk5pcWVQ?=
 =?utf-8?B?UFZqak1iY0cvRkl2RlV5YXplSU9vTmhVSXZ5bXRMZUptMkF5aUhtUEJldWZG?=
 =?utf-8?Q?afi0JbxLBX+/MNaNGxBGjbcy/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dGw1cTJxbkhMVHBFVUk3d1BsdmhFcXlrNmNEVDZWNFk0Q3VRVWhqVmhrOG5Q?=
 =?utf-8?B?aVRFVFhlWG0xb0dKUXgyTE80cUU0dVB6dkdGREZxNVI0b2RxUHhLdVNQMnE0?=
 =?utf-8?B?L0lzOCtNWllmYnJvQjViQXpHLzFlUG9oR0d3bWdQbjZIZG8rdllRWWhBci8r?=
 =?utf-8?B?cmRtb3lzTEdoWDlTWEFYVTJvVWJEMStjaHl4dlNaRGpoNHN1R2IzREw5T1NO?=
 =?utf-8?B?Tm9CZEtWQmNjbStjQ09rZzFZYzltWmtWNER1WkRueGxiME5JRzFJMWJjb3R6?=
 =?utf-8?B?Rm9hR0lsOGJTejE3OXNUSVpWalY2WlJiM1N3YTV0T1NGNGphWlZhK2hvWERh?=
 =?utf-8?B?M1Q2Ykp2RVFVTG5kcEhBMzZXTmhEODQwa2IzSUVEQWNLVUdZTVRjQytpOWIr?=
 =?utf-8?B?cXB6N3Q5bnl0R0thbkJ1MFBZempKV0lDVnc3aWs0UUZ4dHBERlFrOXJmYlNW?=
 =?utf-8?B?VXFpL0pwcnJXN3Z1ZGNVcVlGRmZhaDIza3VRbDVLM3h5YVViZkU4T0NkZ3BC?=
 =?utf-8?B?V0ZzUEZ5b2N6UlhnZVlPZ0M3WDMxdWhCbWVkUndqVlN4ZHZWdWhtOS9vcUZB?=
 =?utf-8?B?UnJxNjIycDFZREtqT0tSOVF4ajdlbzlMc05RVzRpbHpITjJIVU1jdEN0dVAr?=
 =?utf-8?B?RHVWWHZtRGN0NkptMUVMbE1odlc2RjRkck5UUjdVV1ZTR09yZUplbHJCbWht?=
 =?utf-8?B?UUU5TTFxbDE0M0FTdU1ZMy9YREpqNG84ek9uVTQ4NFQ3OVR1dEx1YXVpTlVZ?=
 =?utf-8?B?QXljUTBRV2xWTTFVd0RrWmxDZ0VlczRkZGUvTUNNZnMxV2NlV2dvdG1JdXJt?=
 =?utf-8?B?ZmtCZnBHeHI0WW9iNnliK1pySUowb1RhTlhXMlJOU2ltQ0F5VWJRbHh5TU92?=
 =?utf-8?B?RWdiU3V6cU9VVCtQaG4zSFRPaXlXc2RqQm1XRmFocXNHSVFTazIxOXlrRGhW?=
 =?utf-8?B?SUN2bmtvYmt0Rmo0OW91bWNHR2xLTDhwWDRRWGVSdElqQUxxK2d0aFJyQkQr?=
 =?utf-8?B?YXp2bXZhblpidGQxc3VZVnh5aWJmeUorK0ZvRzA0VGpGZWlkSVZPQjdUSDND?=
 =?utf-8?B?YUNvU3ZmMVczRlQ0Y0pyU0FySFFmRkpRTDM4VkFnS2U4M1E0VlFqSytZeDlT?=
 =?utf-8?B?NSs0M0FXdVZ2OERoeVVRWGRweDBUbnhkanNsYXNKTk1kOUdLUHB2RVlOR00r?=
 =?utf-8?B?RTlZQm1uelNJVFVCS2pORzN2ZU1uOWdOK1I5b1h5dVlWSEZOVW94U0VveHZq?=
 =?utf-8?B?N1dkUmpVUXVNS3djMFNuYTMwTUZZNWdNZEMxSHB3OHMweGI4Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04af504-baae-4a1f-960c-08dbdb93e5d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:07:26.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OEg0MhFVqXO8YXJ7QameLtzgNaIADthi2oDLUSO2QDs2iawL30Wj2M6ZLeTwngDFvbVtl9R3irXh2p51MSJ/6t2RYQE+FekBYakSL3aJ9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=912 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020088
X-Proofpoint-ORIG-GUID: dK5pS_CLEYH3RCwtEguJS5GDYQJx5R41
X-Proofpoint-GUID: dK5pS_CLEYH3RCwtEguJS5GDYQJx5R41
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------CiZgA0yNOnKi5UD4MRnHMeSd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 01/11/2023 15:56, Akira Yokosawa wrote:
> It looks like this introduces hysteresis in successive runs of
> "make htmldocs" and "make latexdocs".
> 
> Steps to reproduce
> 
>    1. Run "make cleandocs"
> 
>    2. Run "make htmldocs"
> 
>    3. Run "make latexdocs"
> 
> This aborts with the message (under Sphinx 7.2.6):
> 
>    Extension error (translations):
>    Handler <function process_languages at 0x7f122f343420> for event 'doctree-resolved' threw an exception (exception: 'LaTeXBuilder' object has no attribute 'templates')
>    make[2]: *** [Documentation/Makefile:128: latexdocs] Error 2
>    make[1]: *** [/linux/Makefile:1695: latexdocs] Error 2
>    make: *** [Makefile:234: __sub-make] Error 2
>    Command exited with non-zero status 2
> 
> If I run "make latexdocs" in step 2 and "make htmldocs" in step 3,
> both runs complete successfully, but html pages don't have the
> expected links to other translations.
> 
> All I can do is to report the symptoms.
> Vegard, can you look into them?

Thanks for testing this out and reporting!

I think we can fix this by moving the "is this html output?" check from
the TranslationsTransform into the 'doctree-resolved' handler (which, as
far as I can tell, runs after the doctree has been serialized to disk
but before output is generated).

I've attached an incremental patch, does that seem to work for you? I
test both (clean/html/latex + clean/latex/html) and it seemed to work here.

I had a look at using a custom "visit" callback that would just render
the HTML in place instead of manipulating the doctree, but it also
doesn't feel right as then you need to specify callbacks for every
output writer; there doesn't seem to be a way to ignore the node by
default. Maybe I should ask on the Sphinx/docutils mailing lists what
the "proper" way to do this would be.

Thanks again!


Vegard
--------------CiZgA0yNOnKi5UD4MRnHMeSd
Content-Type: text/x-patch; charset=UTF-8; name="latexdocs-fix.patch"
Content-Disposition: attachment; filename="latexdocs-fix.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vc3BoaW54L3RyYW5zbGF0aW9ucy5weSBiL0RvY3Vt
ZW50YXRpb24vc3BoaW54L3RyYW5zbGF0aW9ucy5weQppbmRleCA1ZjI4NjZhMTI1MzMuLjk5YTcz
MDc1Njk3YSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9zcGhpbngvdHJhbnNsYXRpb25zLnB5
CisrKyBiL0RvY3VtZW50YXRpb24vc3BoaW54L3RyYW5zbGF0aW9ucy5weQpAQCAtMzYsOSArMzYs
NiBAQCBjbGFzcyBUcmFuc2xhdGlvbnNUcmFuc2Zvcm0oVHJhbnNmb3JtKToKIAogICAgIGRlZiBh
cHBseShzZWxmKToKICAgICAgICAgYXBwID0gc2VsZi5kb2N1bWVudC5zZXR0aW5ncy5lbnYuYXBw
Ci0gICAgICAgIGlmIGFwcC5idWlsZGVyLmZvcm1hdCBub3QgaW4gWydodG1sJ106Ci0gICAgICAg
ICAgICByZXR1cm4KLQogICAgICAgICBkb2NuYW1lID0gc2VsZi5kb2N1bWVudC5zZXR0aW5ncy5l
bnYuZG9jbmFtZQogCiAgICAgICAgIHRoaXNfbGFuZ19jb2RlID0gTm9uZQpAQCAtNzAsNiArNjcs
MTAgQEAgY2xhc3MgVHJhbnNsYXRpb25zVHJhbnNmb3JtKFRyYW5zZm9ybSk6CiAKIGRlZiBwcm9j
ZXNzX2xhbmd1YWdlcyhhcHAsIGRvY3RyZWUsIGRvY25hbWUpOgogICAgIGZvciBub2RlIGluIGRv
Y3RyZWUudHJhdmVyc2UoTGFuZ3VhZ2VzTm9kZSk6CisgICAgICAgIGlmIGFwcC5idWlsZGVyLmZv
cm1hdCBub3QgaW4gWydodG1sJ106CisgICAgICAgICAgICBub2RlLnBhcmVudC5yZW1vdmUobm9k
ZSkKKyAgICAgICAgICAgIGNvbnRpbnVlCisKICAgICAgICAgbGFuZ3VhZ2VzID0gW10KIAogICAg
ICAgICAjIEl0ZXJhdGUgb3ZlciB0aGUgY2hpbGQgbm9kZXM7IGFueSByZXNvbHZlZCBsaW5rcyB3
aWxsIGhhdmUK

--------------CiZgA0yNOnKi5UD4MRnHMeSd--
