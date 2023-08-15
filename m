Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D7D77D392
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbjHOTtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbjHOTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:49:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4182219A4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:49:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FJjVQ8025637;
        Tue, 15 Aug 2023 19:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ODf8Jly5dzXxcniZoe8mlHabi/s4OL+/povukdt1+kc=;
 b=TN/8L5EqAT0iAWTRyRwEtMB3yyn1usCZFtQIRPY1pRKsb+wPtGO/Myk6Q5bDSWYHJTWb
 ywub7oVc3pL63pQkjMsBfmCgcy7rgOZR4H8qhBQ311/qGwF/2rjzlhBvhnRXttsari/H
 Q6pfFeOHccVFM76Y0Obq9lvFnvdi4ck+hob2IqX0c5XWLTTU44AcqqLM4n/gpcu5D8gV
 zYBq4BTDFNcR2LE/wfRd4Ln+FJ4sMwpR0BhyQlXVNwh8ZmbAQD7HWeQ6R9e9qtp3/cRl
 Aoz4ekk9PFOxE7tn1QGOTbOG7wCcxENHtIuOl0saHKSUNd0JlIiCUkGJpABm8FKarxNO BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfngsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 19:49:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FJTI57040720;
        Tue, 15 Aug 2023 19:49:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey70fwjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 19:49:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWua6GoJkpJtIYRKZBn4OxqqHVREGoeciaPBmtbG9PfERqG+UM98i1ZIJfV1sGwI+RpPyA2t0zhmbE0oplWHt93IrrVAzwNjP6szYKm1Ghk4BwgjNHP+/GUPPoWX61Uzgv/Obrh6LGNR/kJiZ50zDN+MtJZTAmcbBdzmhfFEco1DY0Sani2KtHeBo/wzu99y7tugMfpLbQVRb1+JW6NjfvjEbg3pUwTmdyD0bPi0MI/vv4ocdQkN8fwzIKqYEOe1wliHxhy5oxFxUWYAOpKFb1n9nmiJgr400c4H+6vkRhPD3x5qhtm94ByVBQjnHP0xLXsZW3yjQaoEy432Xh9gBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODf8Jly5dzXxcniZoe8mlHabi/s4OL+/povukdt1+kc=;
 b=kKUb+7oALPMAKTToicI24peHaVqVnrWDrlTnPY5HwFQkw72HhmJH4+2Q7bedzlzHW9IOZldiwkOGm5QaM/T37dnjlcxFVy34Urmok7bc4gxePw450NS8eFaro4h6+Zmxv8jJmez2nE7QC8Cj7ttpEQgqHqi0lzvFj2wuIz2Ae9eVRAb+IljiXUB3WEaKIWg9lm3fSfZwz8idAWNCxG9BFU2awkIoGl5awOl68G+r3LKuaDNyB2v/gU/JygTrjs7wDuvzL12UIDRHQeJ3vCDt5rm4ltEquZhJuOcdseBgcUw3sxOJ95cSd0DbQDHqVbQ2K85hh6gtDy4a4Jv1OxWKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODf8Jly5dzXxcniZoe8mlHabi/s4OL+/povukdt1+kc=;
 b=KHFv07CE7dWl3qsyCgRVd2Zca+0J2MaZUvU8e1mEmRqI/EM9vijFZTW+XiyFpiPb4A8JfNEsgaPgw0KoVOtlGz0CJkMAKHBpKDFY+8mEiQ6722CZCXv2KwlWXRmSE4qFOuAgQRgb+s5f0Fi1bA4ev4yTIRsvvAxHvJRFKmrID98=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB5310.namprd10.prod.outlook.com (2603:10b6:5:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 19:49:22 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 19:49:22 +0000
Message-ID: <ebc38dc4-ed43-6a1d-5368-ae75269e6b43@oracle.com>
Date:   Tue, 15 Aug 2023 12:49:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 1/4] vdpa: introduce .reset_map operation callback
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuGeXYo3s6Ytd-Nvp7EXU6td1NY6LrLcVgntprXJwBEhQ@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuGeXYo3s6Ytd-Nvp7EXU6td1NY6LrLcVgntprXJwBEhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0059.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::11) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB5310:EE_
X-MS-Office365-Filtering-Correlation-Id: d561346c-ec59-4a9e-5181-08db9dc8b8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DHTHhYOYRj/H9J+u+IfQPwqsziqtZguetpcrXl+a2oBXCVekgJx7if1bBkz+vvI+lb1Dw61QgtTwnov1P4jcwYM9HFu3gLQE7VanaDwf0bUy2CoaET3X8bX4MNDujY3LPkQTOQ+CSbe8uB9elDKfGQAWyWKJN3sO6FupWttq2TKHKdbaddznrtiwsLoDJJpc9Z5Q0VEXOcNOsMnn0LoePPMOWPwWHu4+byY09vYrt6pQOdfS4sawlrMvNzp11rd/CP5yyZqRtQciUphmOCrVoEeHujl4HWMrCwqmtbmuzInHoeVUbUXD1LcIHcUNubwmIBytTFtd4QGHpxy8r/rQwQqrDtdxHBb7/oesmcopLoX4j2BfqrS5abkef4cHwlB8Xe1pCPdFDv4IitbzxvADv1hkxccFAgas/potunbw2xzd24iZtsxdGs0ax3/Q5NrmlIm/bS7ndQgvUHIEyR+imS83ccaLyGiDoBvSFxf/6dugcY3J+sp+GB+a/XZfotDBDiTZ096enlH8BGqlXXCqkv+DdUQ02w6INLAnjkyeTcpncb+DXkvFfrp8PqeNZ0VFr/sut4SLIgiuUu+12QzruLJOOOySVHWkZ8GPiH+IUAhLZjbi4u3SRb66Su4cXhxX7RpEfXfDccic0u/7OcOSaMujgPNqpMaPBrM+25k71KwsDAXuHY5crNh+6isxZls
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(1800799009)(186009)(451199024)(41300700001)(316002)(8676002)(5660300002)(8936002)(6506007)(6512007)(6666004)(38100700002)(53546011)(478600001)(26005)(2616005)(6486002)(36916002)(31686004)(66476007)(66946007)(66556008)(4326008)(36756003)(2906002)(31696002)(86362001)(6916009)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJPRngzVkdpU09kazhITEV6b3d6dkFYb3lsREZKcTI3K3BvbjU4VXdrNHp3?=
 =?utf-8?B?L0taTFZldTl1NmMxalNyNkxzU2gxK1ovajNmWUxubWZ0bjkxR2dQYUxJb29y?=
 =?utf-8?B?d09qaG1uYlhjL3ZOL09VbDZXNFh1QjlmeTdIa1U4WnZ5alhmdFd5UkF6Mnha?=
 =?utf-8?B?M2JXZkNNTzBMSEYzcDhIeDRCdCtqeC9TbkdGc1JxdldNOTJ3VUErM2RQaG8z?=
 =?utf-8?B?dEdKN0NCcVpjTmIydTY0MHBiVFlQK3d4OHI0N2h2eFVsTmVwM3E3dWhPT1Rm?=
 =?utf-8?B?Nk5oT2JuRnhjdWFJaithb0U5dDRORVA2UGtlQXVla0d5alNuckc3c0pkY2JY?=
 =?utf-8?B?N0ZxYjdSSk1CM1RmTXZmdzE3SVVkMjRZRlhneHhOM2RGamtnaW01Q0ZaQzds?=
 =?utf-8?B?WFM2ZldvMko0WTFJTkZjVE5tVnhoWUE3a2J4cS9jMUlrVkV1SCtsVG9xaVU2?=
 =?utf-8?B?TWlTRW55S2RrU2hQbkpWZTF5c2lWMHZVRTB3Vkw0MlBFNGJ6ZkVuWmIrZlJV?=
 =?utf-8?B?NjZvRXA3c2ZndWdNVDBBMjFteUtWODdaWWRGMkhDc2dUS2hVNnVSVXVsWGxl?=
 =?utf-8?B?UHoxN0FmU1RFZmJJaEZPeHk4K1YvWWJSdUU3bHFxcFYvUW4yM1BSVnhndkt3?=
 =?utf-8?B?UVV3aE42c1d3L1lQMFJKNHQzdVdhMW41UHlBTjdhdTArMXpUa1VYR21CZWp0?=
 =?utf-8?B?QlpWVEZJZnZqbUVEaXlXeFZGa3Q3M1RwUkFkWWRKSW5xaEVWZVRZWUtXVXRD?=
 =?utf-8?B?SnlmWVBZUzFOcXZMc0FFd1VMQmJzYkx2dDNzZFZET3BDaEZRaW1JNENBeWJi?=
 =?utf-8?B?S000T3Noem9nYmpDZ3k2bHpMSFppZDcvcE95d1hjQ2JWdDlhbHpNditzTnY3?=
 =?utf-8?B?WFo2RmY1ZHI4Ynk1ZlRBLy9HMGVzTytZdUtDMHN5RTBpL0E1cmdkb3FoZEQy?=
 =?utf-8?B?ZTAxTnRpeWNGTTdodzJjaEdjOFV6NHRpTGxzSThXMTZjU3orNUIyYUd4QnU5?=
 =?utf-8?B?cjIrTENhQlZoeFlWTlZOZ0k5aFJpQjlWWFQ0V3RLRExrQ29DcE15bG5KUmZr?=
 =?utf-8?B?aFFWanRsaERaa0JheFg5SVo3bHZUSE12ZERHaWpMeXZGQmk3VWRlbFZXZkpB?=
 =?utf-8?B?eGc5bERvSzF1KzhFS3BtMFpzb05NaXJPa253WnEzZUt5QkcyZFV5MHBOdUFh?=
 =?utf-8?B?R1UzV2s2d29WSFVwZGhWSjFheHVMQWRQUis3OW9UWHZaY2w5Nk5veVB1U0VK?=
 =?utf-8?B?NmlEODI2c2trTEEzcVgwTlRPekpPeWdORHhacGpnb2J3VFVyRmFBcEhpSzBa?=
 =?utf-8?B?RFc1cXFwa1BDYldHb0RySWRBdFRRdzYvL0M2V2p4NnBQU0w1djhveXNCdXpF?=
 =?utf-8?B?a29ubmlxQlE0cDFjSkhIWUh6K2ptK250aUdOV0llSTUwUDBxWmhwN2pvWjhE?=
 =?utf-8?B?dTNRZnZCREdjQXhSUXdCRWFtSGQ3VGxwK0tEdThNWHc4bFdJaWhBVzBaSUM3?=
 =?utf-8?B?THlIOWpVNTBSNlc5djZDYWJwYUZTd28yWXZPNGxnU1dVWHBKbXhNMUZmNkxz?=
 =?utf-8?B?NFNySTkxZjVVQkVXWWNwK0U5Z1hpTUxEVGlTcTViUWtQUzVoOWhoRlBYTEFL?=
 =?utf-8?B?Z3JUSVZXMVhzazJ0bHZZMnVHVTRKdEdNWU1TaEgybmV2a3ZNenBNRzhRdWk2?=
 =?utf-8?B?bWJZb2NmRitVd0s4Z3A2UTd6eXM5ZHFNVnVnMXBMcmMwMUxSeHpja0NKNlFn?=
 =?utf-8?B?Q0hDWFl3TEVTOHRvTEhwcStDczdweDZvRk9Xci9DbUlnc1Bkek55R1lQckow?=
 =?utf-8?B?cjRBNlBwOGVjTmc3TGxRQ2xGdEVsTEV5aWhpQm1FN2ZhOXJraEhhNXQwaXQ3?=
 =?utf-8?B?bWZyMzIwNnA4Y1RpNUduQnZPR2lWVVJoVm5KUzdhaFdva3lzWVN4ci9sRlBv?=
 =?utf-8?B?TlRiUzdJb3FNRmVuRllmdDQwWVFUSmJyY3BuR1V0RGFLdHVEb0ZKWkppOXhq?=
 =?utf-8?B?OHNybVd1Vk5sMUpzMlFSMTBIRzV6cm8wMlpJZ25wNE5MWUlPZ2toMklzdUkw?=
 =?utf-8?B?WlpneDVyUVplOU1MNXBkRzZGOU5mbTB3aC9hcW1xTjYwVWFicGhmTjFqdGlE?=
 =?utf-8?Q?ZVyr9D30K49RIFcwrlPYdp0Ao?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aU9EcHNUMWlsaFRiQ3hUZ3FDN1U5SWdkNU5sVXlhc3NTSlJLYXY4ejVaNENF?=
 =?utf-8?B?WHdxVVVROVI3TnlyQStzSk1nbHNGSHJKeHFuc1FsMDY1d2VBcDlJOXduNnQ3?=
 =?utf-8?B?QTNDelp0bXZ1bmptSnpjOXgvTU1kejJoRFVRVHErRzhEblJsQW83b3QybGRB?=
 =?utf-8?B?Y05CckRYanlTL0xBTTQwc1hLWllWa0hUTG45ZHdXVHBBWEcyUWYxSGZYSWNs?=
 =?utf-8?B?bnpiaHRMV1VueEI2cndleE9hWmtXTXh6MjdTT1dQV2tWRHdsSkpzYkMrUStK?=
 =?utf-8?B?WE9lcDFxU29CU0lHWlV4Mk95VGNRQitxbW5lU0hHUGVKNHcvU0ZVeTZHZUMv?=
 =?utf-8?B?SnhZUWZmeWlubkQyWlZvUnhIVlpXTTVHOTJheDJQbUQ2RlBCZWRRMGo0UVBH?=
 =?utf-8?B?QUJkcnpZT1FuaG5NMEJRajZFU212ZTA1SzFlQWMwdVg2aklEb0c2QllTRzJP?=
 =?utf-8?B?S2hLcFJOOVdZUmZIUVZuVElmOGVCNWU3Qm4ySEUxVUovY1V4RCt4T1FacVBa?=
 =?utf-8?B?OUFwa0xDVmZncDZZUjhlRHVwc3BmZWI5OFRiOFVuQnBidC92ZFg1WVpYMUFQ?=
 =?utf-8?B?Ny9tb2VJUmRpY0ZUWEJ0S3NSTURBaEtyTFQ1QnBnYWpWSXY4cmw1aGNGeGRk?=
 =?utf-8?B?OCs0TnA4WVFRZEJtSyt4MFJ0S1dYWnYrOUVMbTYraGdybEI3VzBJSkVHWVdV?=
 =?utf-8?B?TGZ3QXoxelRReWJDbnhNZlNwcFpZbkZyTjEzSUlCOXZvNE1oVjFGYmZGaENo?=
 =?utf-8?B?Q2tqRHJVY2pFMzRpZExFMURWemhjVlUzSW9LWnp5MVlMRVhYaEZhVDhCRHYy?=
 =?utf-8?B?UkRGS3pldDFPOVJmMXNNaDVjeERTckduWTNrT2l0eDRGNlpNb0tTVGF5cDNm?=
 =?utf-8?B?Y29BR292V0NOVXVuU2FqNWVzNnZZSDg5M2lIWS8zM1ZuYlNoSTJjdHhNdld2?=
 =?utf-8?B?RzFpQ09OaEc4bjhka2Z3bVNBQi9EQ1ZVWVFIKzhSbDJEaEFNVjJtTG8zbzBa?=
 =?utf-8?B?dHkwTDBOUmtWbGkrSVRqSWp0emlSekhYc1ZiWGVYaC9GOU15YzB5Y2tBTzhK?=
 =?utf-8?B?cjN3dVg0VlVqM3RnMTFNclRWWmpjTW0yMlc1SU14QnVVdm1XdkQyQXJCWDNE?=
 =?utf-8?B?SnhiY3JPeHQxcXd0cTkvV3JrSytsbTZpVkRic2JMSUg1ZHBpdzNUK29jODhm?=
 =?utf-8?B?L1pvRVl1dGgzOFBwbU5tdXFWbmpuMERMcmFuUzBwOG9NUVZjbEJESE9tRWF6?=
 =?utf-8?Q?FFWgBImWdYguYuP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d561346c-ec59-4a9e-5181-08db9dc8b8a0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 19:49:22.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKPLrUIpY2kn13too6MUvDPjUDzl7URVOgJgEBeERe8AQBkF2pw6g1/bPlNT23F4neKcbuwYigZqrWaLSvtKsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150179
X-Proofpoint-ORIG-GUID: AzJ2Js5CUqKm4hDrsveYePNLp7NO-pAl
X-Proofpoint-GUID: AzJ2Js5CUqKm4hDrsveYePNLp7NO-pAl
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/2023 7:21 PM, Jason Wang wrote:
> On Tue, Aug 15, 2023 at 9:46 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   include/linux/vdpa.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index db1b0ea..3a3878d 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -314,6 +314,12 @@ struct vdpa_map_file {
>>    *                             @iova: iova to be unmapped
>>    *                             @size: size of the area
>>    *                             Returns integer: success (0) or error (< 0)
>> + * @reset_map:                 Reset device memory mapping (optional)
>> + *                             Needed for device that using device
>> + *                             specific DMA translation (on-chip IOMMU)
> This exposes the device internal to the upper layer which is not optimal.
Not sure what does it mean by "device internal", but this op callback 
just follows existing convention to describe what vdpa parent this API 
targets.

  * @set_map:                    Set device memory mapping (optional)
  *                              Needed for device that using device
  *                              specific DMA translation (on-chip IOMMU)
:
:
  * @dma_map:                    Map an area of PA to IOVA (optional)
  *                              Needed for device that using device
  *                              specific DMA translation (on-chip IOMMU)
  *                              and preferring incremental map.
:
:
  * @dma_unmap:                  Unmap an area of IOVA (optional but
  *                              must be implemented with dma_map)
  *                              Needed for device that using device
  *                              specific DMA translation (on-chip IOMMU)
  *                              and preferring incremental unmap.


> Btw, what's the difference between this and a simple
>
> set_map(NULL)?
I don't think parent drivers support this today - they can accept 
non-NULL iotlb containing empty map entry, but not a NULL iotlb. The 
behavior is undefined or it even causes panic when a NULL iotlb is 
passed in. Further this doesn't work with .dma_map parent drivers.

The reason why a new op is needed or better is because it allows 
userspace to tell apart different reset behavior from the older kernel 
(via the F_IOTLB_PERSIST feature bit in patch 4), while this behavior 
could vary between parent drivers.

Regards,
-Siwei

>
> Thanks
>
>> + *                             @vdev: vdpa device
>> + *                             @asid: address space identifier
>> + *                             Returns integer: success (0) or error (< 0)
>>    * @get_vq_dma_dev:            Get the dma device for a specific
>>    *                             virtqueue (optional)
>>    *                             @vdev: vdpa device
>> @@ -390,6 +396,7 @@ struct vdpa_config_ops {
>>                         u64 iova, u64 size, u64 pa, u32 perm, void *opaque);
>>          int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
>>                           u64 iova, u64 size);
>> +       int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
>>          int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
>>                                unsigned int asid);
>>          struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
>> --
>> 1.8.3.1
>>

