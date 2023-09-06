Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923E87934CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbjIFFVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjIFFVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:21:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8917DCF0;
        Tue,  5 Sep 2023 22:21:11 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3864YRGU031190;
        Wed, 6 Sep 2023 05:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+xZe4cM5vtgAywBk1ifH+QbZHdZ/9shuhWAC7R+zxIE=;
 b=q2l0LK6YvlONVdgncqVK1cvjpivk3wmk2lGGj9tre99VdmRqRJjg0gjyuWEn/J51rsNM
 MpV4TUAyxqD+sAd9eCVzcp2f1uRRpkyZbpCeqYwYQ3MtHRY9L27k0Y3sDxywzP/JcOS/
 wxkw14mz5u+I9FvatkndOeUSy0s4kxK0K+GcR4onUZdcohGf8lqq6iJdLLZhTvDq5EPd
 4SJmQh67WODUUAC+OaQ/3HNHDKetU9HimVh4rx222pWfBkPi9kNL/i/k3lWt0yng4xjC
 zWX8/Xvz9lTcQo015gwkVhjfL/ugbTaj1j79pxSRgeJcIPcQbRDhN3bHeB0nst4dSBRI 3Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxjgv03mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 05:20:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3863AOao010518;
        Wed, 6 Sep 2023 05:20:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugbyq6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 05:20:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9FETTrQGAbq/hKHl02xEvWuvEDj4urUesiPOjw5/Z/6rcUn5NdBVbaDXcNubFMeDs26UiMyR+AyBUTD2BbpkUHa7OlWHX3sMdRWtkBLN26tXWYkVTUz5ujqXci9Ro3E9Bk8YptS5SmMFNxYZ/2xmkGLux8ooa3w5vbUDXMt8hnX6Ok8VSlO71f6BOyOQYM+QVvqJ23R5mv8FU7IMjJ1eSWVCgMxXRBsNNhlQS+3MoE3/9q1Ut1Xl1aSRLc+YB0Q6wfgxQxtvBczxH5lydod0dW6Hadx5gbE3X8geVvAnfJ2/LRJVTcvz+G+jXYzb+XsU3uV1KT2kymG1rlseg0Ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xZe4cM5vtgAywBk1ifH+QbZHdZ/9shuhWAC7R+zxIE=;
 b=FW3DrymuozUmZ+F8lcwbYAHMg/a133WH/ftIyDW06rmgOTpyaE6whjp+nDyKCAhwjDm6llOftuB6wXpo0AlWV3ywwaHmAhHu8dmaA1UaJn4d8XAc5YBfBRuEws8uxr3CEkLy7CGOt3T/0KEmfMsIGU+2t9XlKL0Kj53eYPrqQ+aW3Ym+NY21JGxbfBpdkOo5MeinwsE3rM7eQvz5/kHxAHb+AehA7R4xFPiPg78KuwwbT9DTqUrbyK6JMFTq9H7LULNkxyic/EFe7suqpJlc9xdc9ERkULyPlSpToX1ahIqoJxkPi7IfwP/QH8DMkm82d+jmSIZRCYzznp2m2O1+zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xZe4cM5vtgAywBk1ifH+QbZHdZ/9shuhWAC7R+zxIE=;
 b=koM4XqRsv/rwrTOnKlgjcW9b8eWIMmVEbmC6HSY407xrMknMq/MLH4pw63ZsqdCi0RGNlP/mN1C0zf7oCvQO4/uI3ta/Xj/i2qCJQ0AmjFTmVw+a1lw4DtYQdyBpNxf9LdiIrkBEiZdjmYwYVGwY+15roD2W7erbkYmao5HFsfQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB4584.namprd10.prod.outlook.com (2603:10b6:510:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 05:20:34 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 05:20:33 +0000
Message-ID: <23570002-f651-007b-0274-4594994f8789@oracle.com>
Date:   Wed, 6 Sep 2023 10:50:21 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 00/28] 5.15.131-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20230904182945.178705038@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0052.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::13) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: 480c83bf-0d76-41ac-b011-08dbae98fec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnF/YyzYpBpawFwBtaOhzfXOh2+apkMLWbKDdl9Fmz0DPiFySr7gdCv0XPlWpsp1dffrgmAcpppXySAvQoWxvDtkQu+vSsngsBSvgVC8O9/Jh34/fF5MsXTnGmBPDNznFjvymX4rZd1TfpeC4Zw/ZQMw2FjDfF0ZZcxw1YDiyP48HcjUWERw3fX/WwR0LwFcuxPScESWCgbq04LuaUBCo9fFwBMsNrL0UgMzj2kj42voYfarLslFjYB/tvytzWtpgJWDsPjg10CweE4siWXSidHwHl/1R0OEhqhXHoz8UEx19KjYZ1oRX6QGPw0jAbD9fhsfJSTHQRVcqRGSO14VrzjfSzyg6wxyUn7TXam66rCkNGSaK7nLkN5bSAWvy5O7FsaQAEzW0xsHC6qw5Q7byP5IWAdVac1doZzrz6LgilHJjJcYdlOppNorhWP9PO217+GHLatPNqz3AZnB6jNDa90yhkvoH5Lx9VZkafais0KiP7QFA7osAwotokVzo2hWTjPdFz39OVUgCgcn3s4txHgopGYsRWRUq1TjZAANFAegPex1452GhV2KHu25ranmomhk9hyFqBwbEF/HP7+9qh2kJ39CDQ3bKLDG38uRXIexKjg1317jOZRTh9AqCQvXGBS1P2lAj1QsmbniT0tr9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(186009)(1800799009)(451199024)(5660300002)(41300700001)(966005)(316002)(66476007)(66946007)(66556008)(54906003)(31686004)(8676002)(8936002)(4326008)(7416002)(2906002)(4744005)(38100700002)(26005)(31696002)(2616005)(86362001)(36756003)(107886003)(478600001)(53546011)(6506007)(6486002)(6666004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWlYSHdsUy9zSnlxQjlmakVHdGxHaiswTTlqRi82ZzdlRnBxVU9kUy9zT0N3?=
 =?utf-8?B?QnE2alh1Qm5pcW94S0IxY3lGdWtVM2oveUo3aFc5TjYwK3Ixd0xuVzk4d0ht?=
 =?utf-8?B?dXJpNlpFck9FUWtobkxZWTFwRzFrNGd1ZWtQb1Q0RTdNZ0s2a0F5eTlYaWJS?=
 =?utf-8?B?S1RaTStwVGpKWnFicW5KSDFGQm1hNjBISjBSTHJtUTQyem9tb0pleG40b1pZ?=
 =?utf-8?B?QzlralgzVk1UUEl5bnIwa1ljT1NxMlE0WHFreWlKblJnSzhKcU1MWkZMUDdx?=
 =?utf-8?B?Zk5MeGpDSFRqU1RqbnlBNmttK3JRalNCaVBPTExSUkxlVFJaZmpYbjhzeEhz?=
 =?utf-8?B?eDlwQThRZU9BTjB6bjZ5dTlUb1FqLzVkM1VOMDVYbDRabHZlVUNvZmZySStm?=
 =?utf-8?B?MnRjSWZrdU5nMmxBWkRwNEhza241WHZZMWpXNm5aYk9zQjVSZ3hYT3V6MFhQ?=
 =?utf-8?B?bWl2NWJZQ0hwT3VPVVkvMnJMOWx2b3lsSnp0MmxMSXl6ZjdTaFhYZ09Ma1RX?=
 =?utf-8?B?Y08wZjZveDZLWTFlTE41elFOY1RkZU1rckJzb0VFT1dRWHRKSFc1S3VzSlli?=
 =?utf-8?B?ejZVcWRFcTRDbTEvbGxTZllFSGlIQmlZYUNwZVhsTkN6Y3F0ck5ybGxNSVV6?=
 =?utf-8?B?aENRTkpmblhxa2lSK25yV1M1c2tzMVZTWnRQYllLZlN2ekxFNSsrVjNsSXlH?=
 =?utf-8?B?UGZ5WUdDUk9JelBnaXJCL0ZVV1BmQ1VxVHhjN2ZVZWgwZXZQRmRJbi9qWFRi?=
 =?utf-8?B?UTB0ZUNGeWw3bmtkei9ZVjRxNDA1c09odXhpTDM2NXNweUdhQjJDMERRbGc0?=
 =?utf-8?B?TjhzL055RE1CN3lpak9BMG1tK0tvMFZRYVY1bk1NYmNKaU1aemlDU3F2UTdR?=
 =?utf-8?B?cGVMaDAvQmRNdWF0NVlCRXpQTnpUSzBWQWtwVkRSMFBXdUdTK203K29GMUJS?=
 =?utf-8?B?dmIvYzVsMjV6UjZKbjNxV1B0amxOZUxmQjd2SXVFci92UDVBQk9sZk5iaTMr?=
 =?utf-8?B?OThjdFAweHFPVlFyVlptU0RHeGVqV0kyRnhqV0l5Z3RPREJxV25WcXJvem9I?=
 =?utf-8?B?bHkzWnpKRjRRaWJSUy9SbGN5aEoyU1h4OFpoQ25SYUpmWTFXclgzVi9jVmlN?=
 =?utf-8?B?c1krYXZyblpDV2ZrVVJxZkNYa090dVlwWUl1NHR3emNuMHAzMXc3V253aURD?=
 =?utf-8?B?dG1WOC9neC91ZjV2YXdZakR1U1lNbjV0V1ZxRUU0eENTWStOY0U1RzdqeTNG?=
 =?utf-8?B?bkxqcko5SG1Ic0xTa0JXZ0xUK2RIVlp4K0pDdEpQcWdHdzRsTEhEaVdzVEZv?=
 =?utf-8?B?MFk1V1psSEpISXl4ZUwrVHJSeEpSdGxFakJ1bXpQVkFzdTJiVTBPeXQ1OG1O?=
 =?utf-8?B?dDYrdm5WZjlxU0phWCtxU2FnSnd3aFF5QktlSnBVNGQ4amFteGJwa0Y0OFlk?=
 =?utf-8?B?NjFIYno3UGFuUG1lSmFPaUU2QlNLYnlkUEdVRk55ZndxM3NYMEtJZTVrd0M4?=
 =?utf-8?B?VGx0bDlhWXBpaUF4MU9kZTF6V3llekp5UFhiYkZMRVlZVVlSekpGc2xrejVk?=
 =?utf-8?B?eWQ4S1RnQVVoOUZRQUhhY0dUMVp3eEJSZmEwSUZnMWhMdnF3QnVLejluSy9L?=
 =?utf-8?B?M2s5YUtVZ0pvVlRiVnBYNGlJL09NSnBWSGwzenI1SkVlS1N5andZbGhkMGxK?=
 =?utf-8?B?QXVmQ2twQWl5QndxeE5zMlNNNFRmbEJQL1FSL2pqd0M5K3JsYTBLRzA4Tmc5?=
 =?utf-8?B?YXB6b0g3bnRrYzZIQXQ0YnJhdTZvVTIzV1dPL3VIKzYwY2R3eFliMkw2bVFQ?=
 =?utf-8?B?VGtFWk1sU2VHWkJTektDOTNoYy9ldytoNm1TaWsyZkhCWUVIRld3elZwcTBl?=
 =?utf-8?B?eEVpRkhKbldTaEZzM0xEMUVvUUNtRitBaFVyL3loNzh3TitZengwZXBleksx?=
 =?utf-8?B?UVZHOU1SVjc5dmFGMnF6ZGMrUVdXaWxKeng0U0h4L1BmYWFuK0p6UXR4NFdR?=
 =?utf-8?B?UXJhTERRY3FHcjZQc3ZNdWN5Z2k0TmJXeGhlN2FST3k5aVR5NWVpcTFNMnpN?=
 =?utf-8?B?OFNHdXp5WGh3YkhVQitLaCtYSUNOTUczSjlTL1dsZWZnRGp5bTVUMFlVekVu?=
 =?utf-8?B?YWNpQmVpK2VZcHEyQXFYMzYxOC9HcmlkY2RhSm43c2hWcXlzK1FLNlJCQkVq?=
 =?utf-8?Q?CSB92z6MUBFPspxHOERJjUo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z1NFL2x3c1lwK0JVTlgxS1hNM3ljTExMVDkyWTdxODQ5MHVlRXJrOTYrRzlL?=
 =?utf-8?B?N0JGZzlKNlcvemhwNWc5V2dkOERyVjIyN3hPRTg0aW5hbmVjb3dwYmk1UXBG?=
 =?utf-8?B?enowaFpHTkM5aGVyeEFaYkhNRmRBN09jRUdHcGNBaU1LT2pUU1hld1gvWXJZ?=
 =?utf-8?B?Ny9wamFLZHZmck5iUFRPK2l4QjUwZWcvTVYrMUlXVWtaWVZFSnVQSU8vdW05?=
 =?utf-8?B?ZUlrZ3lGVG5VQ2c3YzNDNEJPb0FWektlalV4WSsweGl1ZnNHZWtEWHVzY29s?=
 =?utf-8?B?L1duY2l2M3Q3dEozYklGNVdqQm15QnZjQWlWL2I2akNXakhNamNhRS9PMGg2?=
 =?utf-8?B?bnNqNUZEQUxpMDJ3ZXBwMk4zSXM4eVFKZHdueE5vcUh4SUcwUHdrYXp2M3Na?=
 =?utf-8?B?RlJrc0JQSmdtVHROWWlVVjB0bk1nemp6MGd6Z1VNeXFxQWJtU04xNDA2SzB6?=
 =?utf-8?B?WXdSUjNqNEZ0eTB5ZjhoSlluazB0MWd1ekI1M2hqVGl4M2NaK3FyTTl2bUFL?=
 =?utf-8?B?NEsvYUhiWkphVXZiclgreThoRjNPTGFvS2tUOHhjbGFHdys0SDBSYWRiTHhQ?=
 =?utf-8?B?ZVFUZFhQSjlVdmlmbmh1aTl1bjlLZ2FwNFpoWFUxUU9JVFBLWW9iTzFoanl1?=
 =?utf-8?B?RlJEdGJkNmI0eFphV3lHTmlRQzBpY1djWDhXM1F2ZlVWeU52T1Jvamp2SkZq?=
 =?utf-8?B?L2pkV2VVa29JWk0xOWc3UE5sNDlHcW9abS9GOGM1YW44MjhsK2kwdU1hS29v?=
 =?utf-8?B?cmFZcTZwVkVwbHNoTGhVdWpTK05obWRYNTBseGJzeFJRSG52K2l3eDk3Z0E2?=
 =?utf-8?B?S1A3MzhETnZBRTRKNjAySE93SnN3TDVhQThXdWsyUzlPQzZjdUdiNWJPaE01?=
 =?utf-8?B?REl2aGF2M21hQmN1NEJLM01PT0pKYjNrb1o4R3ArTUQ1cDJYQy9tN3FzMHg0?=
 =?utf-8?B?aXJvY3NPNE5YWTY0TTRrUXRNQkpUY0o5RGthTEJ4S2s0c05xdmo2MHNWb2JT?=
 =?utf-8?B?VmExSWVSTGtjeTZuQ2xTT1RHWG4yN1ZOVDVXWDNOaFZBa3BBTlp4K1BCTjBa?=
 =?utf-8?B?QTdvaU00OFlZaE5wcU0rZmJRdW4vemh6cTR3WmNHbGdnVDVoOHEyVkFKYVE1?=
 =?utf-8?B?MzVrdDUxaHBiRXFRd1J0SGJLODZxdys4VzF5V2sycnQvQkdjb1hyL2JmK3Vw?=
 =?utf-8?B?V2RSZWVZWXRFck1KNHdZR3hmcGZMVEZ3eXJPYXorcUZHSFQ1MU4vZFcvbmo0?=
 =?utf-8?B?djltNDBFTjdTZ3JwNWYzRE9ZZ09GdWxqWEJWNWplVXBCcTcrNC9hdERUU3dK?=
 =?utf-8?B?VDJpdkVCMUxYRVY3ZU4wVE52QjNUNm5qdlhzSGVURUJjWFdSaHRQZ3ZYdWxp?=
 =?utf-8?B?RTY1NGhZYitabG5ybTRCR1dYTzZWRVdZMjJpd1NjM1orRGxxaTQyRnhZUCtS?=
 =?utf-8?B?VVJrNEtjc2ZMQ1dQTG5SQ1dQOXkvZm5yL3FncXc4Z3JvOVFYcGVjSTdjQWU2?=
 =?utf-8?B?Q3VHd3ZzcnE4aXp2d29lYTJqeFpjQ1VJVkIwUGRvV1NOZk55Smc5RzJQcmJo?=
 =?utf-8?Q?eSRRKlTBVJ9o5dAZiC1yUoGLri8PFLyukbDhzUC/jlWqCh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480c83bf-0d76-41ac-b011-08dbae98fec9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 05:20:33.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94VLh2a9/FbTQgVatA+dfGVJ2AP1b7GKEM3RTb5+1Ec7ZOP6Ar65EXHsDaAc3qfTM/ZgGTR8SJ9qmXTl1vG67w1dX9wE8PCmzODIpZHY1AVBa8zPNlus4niXlzFmezhF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060048
X-Proofpoint-GUID: nkxTNZavgLw_JkI6gK_JpnQXqyjeC26Z
X-Proofpoint-ORIG-GUID: nkxTNZavgLw_JkI6gK_JpnQXqyjeC26Z
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 05/09/23 12:00 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.131 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.131-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -----
