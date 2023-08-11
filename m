Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D524B77918E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjHKOPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjHKOPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:15:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB4E65
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:15:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDHh7M003165;
        Fri, 11 Aug 2023 14:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dJ5CdnhENpEHjVFOtVqSlIhSKUEy3EJzoRa1KmfH4+E=;
 b=cxa5YLWBzBaOHEX50eivCYLgL0QmxaXAcds9PJqspEsj8ssogMrUzjMDweG3SatjoVWz
 x0eAAtS63/KLLAWnkqJblC3W8JoCEzKGup6C3QbIdEtpTmAYnDJgxDSOuSQs947tePrw
 7YFhWy7f93ud4qyXsmvqKLV3tLyjJm8K8f9JWskSz0Z0HxbtcScZhfzbTpr7GGUrWY/x
 VAbLaD6ajOWeRTHB00NiqnB/kQyw3Lg1tDod/hB5bVAfZiq0plTIX77ECKV2UTMu0kYU
 YUXi9nvzWaOhhVIoJC2p5hCD5Xyyh8NGqv19loNFD2MCayTRi5BNcspp+KLrIfSr1UGx 7w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y5h4bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 14:14:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BCe5KO009684;
        Fri, 11 Aug 2023 14:14:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvgdfnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 14:14:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HATWXFlw9m1r96efObgjdAh1wGKOesGLicRJMfXloPeR/Nbd/tXu9ZVfVXttrXugzsYjV4O52ouRgtD7KgGNUj4SMgMuyxMaa37W5aPjsbFt2RF6CIWUS3JkNgRcMS59stMmDwjy5fo3AJHwSs/f+CQSBaBzE/AFEI+w79BBKU7PJaHBGQb4HdOOp8CXsZp5RpWfZoty04TUPV/NmmguV465BdtbAW7h6FTGmRz2+4e2ecuwsyxs6q21U7ThGz1hS+Gb9/Izz2CmXkKJ02i+0foWpHcu0iotqAvGrjtKmUqrNaPDFmTcAK2WUi7CJNthX53M1mvDWlLIGqWGs4JXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJ5CdnhENpEHjVFOtVqSlIhSKUEy3EJzoRa1KmfH4+E=;
 b=UzLxdohWcGbIQRLvU4Aeu0pROx/iHUxa2iJzyPWzCUrcE9s6XQRevJxDuMVffvIYrwBEjkc8Zz6bsa4oqfK2TXzExajZHDU3CKy2+ontJwq7rZ1XEse2ksJl/1YXt9L2RhteVhOtGsczNDTJrRoEWKdXzfsuRgtTHAT07/6PdcJTEAkfoZzhGUQ538P3BH4c2soUNsw5NQm0ZLtLxiSU+shH9HsL0Cr1x+VSpbxSLSBGJmacS7vflgCtW0ysfoTdwZlh9VzxtfO4IGTdOBOkEGVUWVwFLGZ3fYseAX7ujsXPPKG6w6lxSK54MZEJ2HK85wxy4mKPhp1pFpeW0bK1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ5CdnhENpEHjVFOtVqSlIhSKUEy3EJzoRa1KmfH4+E=;
 b=CPGPt1oyNDHDZ2ONeYBiInx9sjhbzu8RmKI14A4IYFAN75u174PpqFWU4I/UysyahaPMcPuVWtqEVlFDXkP+gdTLHVJQNmD+vVZ925T6d7nVl/KI2+fl+ABFcbKoCC3RLIywRgTw50vg6UIv1CcHQ8aPotKedOxa8Bxy+TLzgII=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7785.namprd10.prod.outlook.com (2603:10b6:a03:56b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 14:14:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 14:14:19 +0000
Message-ID: <a190ba95-79d1-e9e2-1f62-97aa94a4be7b@oracle.com>
Date:   Fri, 11 Aug 2023 15:14:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RESEND PATCH 2/2] iommu/iova: allocate iova_rcache->depot
 dynamicly
Content-Language: en-US
To:     Zhang Zekun <zhangzekun11@huawei.com>, robin.murphy@arm.com,
        joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        baolu.lu@linux.intel.com, robh@kernel.org, nicolinc@nvidia.com,
        kevin.tian@intel.com
References: <20230811130246.42719-1-zhangzekun11@huawei.com>
 <20230811130246.42719-3-zhangzekun11@huawei.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230811130246.42719-3-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0008.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: ce85d8d0-c707-4ef9-5a1d-08db9a7540c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvK59aHAanU5O/MPycctjSlJ+7XriKmifU8ZaXqADCjwKo1Bltk5QN0OTSL/gQ5O+oOK/c4ZSODf1n5n/bC/CRRBt3dYBV02UF7AyhfrwbHldLnTPObi9tn3jfsHjEtkH68MLHIpkC//R69Tv5whFoOq8SDNH9L13OvDRp8giF/6evA7jkvN5QYfUbxCrv8k3DlAVx4SKZkJGWY7wxzo/uFB4nfaIsU7Mg0b3P329xgk6ROMavVOUjh4tO7IQ9ISUYbvUMwei+NRi7143GE9oczxbgj+kKxyP2ZRryRaHn6ZfmzRMrY+99hVVAIeffAqooTiVEjQZd0g4TKmsHXyd7qDM/POCowm1VFHioTVKEotOa8CPcUnpnuytFul7bp2Rwa/zThis9hrvZbXXG90JaCfPN12zK/Co5xgCfqW6k077fe0CIE/rfn+F84+kkUQ1I4rhZPhOYGxbl7LPDMTZhxsgixIq3SPDC5Xx71h21SVguEK5dpXdTnRpBL5s26HDCsiU7qHgIScBNY4SzeVTX06rnVTwMR3H8QzgXA6/xoPSjjO+Swdep9pjpeuIDaT3auYfXe1VhJWkSBsr75dSTtEDRwbi7aQznPsFY7Fvf1ultLz+XyGNVGty2DpeB482huY0qGcoefX1Nn/wHCHPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(1800799006)(186006)(6486002)(36916002)(2616005)(6666004)(36756003)(53546011)(6506007)(26005)(6512007)(31686004)(66946007)(316002)(38100700002)(4326008)(5660300002)(66556008)(66476007)(2906002)(83380400001)(31696002)(8936002)(41300700001)(478600001)(8676002)(7416002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MElTUFgySjQ0alVmQXFHVmRzM2JvZ0luUWxhYWVLQmYxU1lCQUQ1TkpGU0Fn?=
 =?utf-8?B?RmVUSGVWUmhsSE1UNTMvLzhXeXF0RlVpUWh1OFpHeE9xdjRMYWhsN05wNnV1?=
 =?utf-8?B?aVFjTEFiWUxMejVsaFZYckY5MmljL2pFQU95S0pIWXI3MVFWNm8rU0VIR1Z6?=
 =?utf-8?B?a2tRR3RaRm4wdzhaSHhycS8xRmVsRk44dmVXUFlCQ3orSnNnbjBBeXkyamEy?=
 =?utf-8?B?L0EzVDRTOVZ1MlFuVU84TmpCUVVlMUF5TFZEYkRDQW50cFIxMVZJWWhsSXdL?=
 =?utf-8?B?NnpraXJtWE9maXpUZmQ1N3V2eTg0aFlCNVhjT3A3Y1BaWHY4Mzd1d2w1QnVj?=
 =?utf-8?B?dW1oUGNlUHU5RitKVjhtanBWd3F6ZWhMbWM0NU15cDVxa1RHMzB6TVh0bnlE?=
 =?utf-8?B?cHdhN09QNzQ4a3NiNjVpM0grNzZaaHRXMHFhZ1FkQ3U0d1RGbThtUTNKTE9M?=
 =?utf-8?B?YlMzNTNNVGJjYVRaVDJpUUFWTUpsR0FQUG1ZQkZsVW80ME9GTDhwbXpGMXFn?=
 =?utf-8?B?bnNVYk5SWk1lTWljWGJPZHY5T2dqWkd4cVFjazYvUzJNTDVlTUpBMGdmK01F?=
 =?utf-8?B?OVZZdGtlUnBINXcrQmpOWkM5ZlBleksyZW9Wd3lteEtJdmZlWkt5TlZvYlJu?=
 =?utf-8?B?S3FuR3pxK2RLdEUxYXYxRitxdWVWV2ZXRjRNdW41SzNodHhYQlZJbnpqRDhz?=
 =?utf-8?B?ZTFhVjFSSlh0UExQNm45WW5IdVg0ck15VTdVVkdvZUlrQmd5anZaaUc2UUwx?=
 =?utf-8?B?TVkvUUNyRVBNNndTWU9iemlIM2VkWUVwWkE5RnNFZk9VWkdjcVJWWVVaaFh4?=
 =?utf-8?B?N2VZeHN2bFZBZURUOW5DWmQwME82bk5DN1J4YTFOZG9qeE9XWElGT3pFUktH?=
 =?utf-8?B?RVd1RUlxWHdlWFBWS3dPa3NPUkd5am55VkpUa2ZUWHA0Sy9leFdiMmlEV1V2?=
 =?utf-8?B?MWh4TUxaWVNWM05TYjkzdExiUmN1UTdKclNqV2dTN2FYczlPREU5cXNaSEVn?=
 =?utf-8?B?VXhJc3YzM2hqRmlRYVB0b28vdmxhN1lVU2ZNc09wYysvWHhSYi9yQzdqVGRH?=
 =?utf-8?B?OHEwaGx6VVhqSHlKYjc2a0FwdFBJc1JsM3AzNXFlN1R6K29KSG5vbXJwOVQ5?=
 =?utf-8?B?Sms2TXowdXd1QllvZG55bmRURXdsZGluQ3VCMjJFVmROVU40M1dGRUJqL3FB?=
 =?utf-8?B?bmNBOE82d1MxVUt2M2pGd29DNGxoK1FNZUhybTQ0Um5Ya01VQXRzRUdMM1FU?=
 =?utf-8?B?WGxCZC9XcUxYMlBLK1N6MjhtTzdYVWRvK3g0SFo4aEh5MHVTbzdWdUczUmZx?=
 =?utf-8?B?cmVLaFpSWFRmOVVSdG5vTGVuUlg4czFtemQ5NlJISnRFdWpTenZzeHo5aFpL?=
 =?utf-8?B?cVYremNqaGFtSVVCeVA0TGpsS3l1VTYxdHhTelY1K01PbG1RcDJmOFo5aTlP?=
 =?utf-8?B?MmtEUDhCVi9MYnJ6MnFVVkxwLzY2WUd2ZWJ1OEkrcXlvbVhoN3I2OFJNWXpW?=
 =?utf-8?B?dVdUSzhPMjhRdHY1UFBxbnZPbFoyUEpBWnNORm9DNnRMYXVpVXdGYXo4TFpi?=
 =?utf-8?B?RmxXM1hFTHJBVzNtbnl0NzIrOGJKVmk1SHhwTFRMdUFPWDlEZ1lFaUFOakIy?=
 =?utf-8?B?bXBQVDhrYXQyUFVqb1I4UzNKMGw1YUJ2aVFXazFoaVoxQW9mZUFSenpBNXg1?=
 =?utf-8?B?TjRZNVl6UVN4NTJJYWpRVnB3cWJrQkVrZU5RSTJ3NWFjTTVDcVprejhMWHY5?=
 =?utf-8?B?YlRMN25hUmdzdG80UzlKcG1SUGhvK2wwNG0xOC92Vmo4VjZ3MDh3RnVBU0Ur?=
 =?utf-8?B?Z2Z3cVIxc2dEeTlOanQyb3lmczhXTDB6MzlRcC9IZlNXMDhXaFBvTWk0Zm92?=
 =?utf-8?B?T1doZlBjY0NvM1AxU0JKWE95N3NONUtpeVB5QzV6SzdxYnJiWlZ0d3BRb2Fh?=
 =?utf-8?B?aVFwL2ZmSlpFVncyTDNBSXZES2I3enBjeFRjekNLUSttQUFOeEFWMkZIUVdW?=
 =?utf-8?B?T1BmUk1IZWI5eGlRL1oyWnBrVStLM0hGb0VwYUs5Yit0eTF1MUg2Z2RQV2Iv?=
 =?utf-8?B?VlIvTmZIMjM5NWExQUtzOUNoRTZkcTFiaU5uSEZuODB6TVRuT1gzZFZWcEps?=
 =?utf-8?Q?6DfdiLSK+ibr2cOFKt19BP7xr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TEF0ZktrSG5QMmIvdnFXWHc5akllYjFGenJzR1JUaG5BU3NBSmR1YXFhWkE5?=
 =?utf-8?B?UU5heSs3cDdBbWpKUUd0ZVVtZXZINktHdmlDMTduVHEvcGdEdDFwSkJBdWlI?=
 =?utf-8?B?RkJWQ3ErOUFadHR1TmZIbXRPZmtqdERWQUsrZ0prOGVTWFBhRnNjZXZ5b2J3?=
 =?utf-8?B?bTA5Z0RxWEFuaUJtb1N3cmhTQkxUNHdqNTRNMVVzM0p0T3BrN2JMNmd3Z3RW?=
 =?utf-8?B?bjVVcjM2VVpQaTZSbU4xNmZEZ3FGWCtQZ2ppaHYwR2FYd1RvV0IwdVc1RkJn?=
 =?utf-8?B?S211RmpXOEdBOFBVdHBPUnByaDFPaTVoL0tTMW14Tm9PcktaTHJBL1lIUE1T?=
 =?utf-8?B?cFpmdWZYc2NFY2xyNkJPblZZNU1yS2NuWDh3cll2eG50WTNjdGRMcWwwN01C?=
 =?utf-8?B?cTRTTXJlQlArVFZwdHk4YmZDdkZXVXhRbXAzd25nZ0lMUWVoZTdXOERCdnFV?=
 =?utf-8?B?dk16Y3FUa0xNQTV3SlAxT29jcUNNRlJPR1RvNG9BY0R1NE42R1FpdVI4UWJE?=
 =?utf-8?B?OHEwemNCOUZJQ3ZlUUVLN3Z6NWR1Um50ZDJqeHJMaTdJRjg1eTdWQ3R5WjVQ?=
 =?utf-8?B?R0FYTC93eXZWbG1FK0xvcG0yME9yTXBVQUNjTW9MeTlFUysvaUZsZEE2Sk9q?=
 =?utf-8?B?ZlJYOE1ZMEFCREsvYWZLU0haNVVuTHN6aDNCWG9BdzZ5ZkhLU0xZMVUwQVFV?=
 =?utf-8?B?ZWc3anN3Mmw2NVI5RCs0TG05Ulczc1JBYnQwbUZiekFzdmpUTFgzY3d2ZVlW?=
 =?utf-8?B?djB1YmxPTmNsNE8zTHlKTWlZSDhwNlVPSDVoREwyV3NOV203bTZQOExBT2Rr?=
 =?utf-8?B?d01IeThhWjVHZjBhYUVIVk9ON2pRLzQ5dkE2c3U1UzZCbEcvRWdTL1cwTkFE?=
 =?utf-8?B?bzN5dVplZ2F4Si9BMFpHeCtYSFNMeDlmUWdjdWo0VDV1cE5QTEpxTVd0SVV0?=
 =?utf-8?B?MUNtTGtNS1VwOS9LWjV0cm9qTE1uZy9BYTRiMkZpa0ROeGhXczdjUkxtckph?=
 =?utf-8?B?UlBYSWZmQmhPNWhEOVo4SjVuTVMyZzMvM2ZBelZPOGRSQUtNUWh3MUMwQmk4?=
 =?utf-8?B?c2JjaFdaVHdaNjVIcC9xN1MzUGttMWdnY0NISWEvVHJicTVmSVBOV0JVeS8w?=
 =?utf-8?B?TGMrb2NSdkt0OVhidHcxS0FrNjlicDg4cXUrQ3QrU0VHZmsrWXh5YmFneHNa?=
 =?utf-8?B?NkZJRm5pOUNCbjM4RE1YTnJjM2ZIQVF4aW4zM3hpQVB6Q0hjZmNLMXRGbzZY?=
 =?utf-8?B?alR0WFJPL1RvR1hGb3NvQTZYejZtaXZpaVZReG5iY2pqUDg1SGYrN25Oeiti?=
 =?utf-8?Q?SBSDExp/GHKmyeWfy7bBmhsSg8e1nWVLW1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce85d8d0-c707-4ef9-5a1d-08db9a7540c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 14:14:19.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7L/2OSfreavuzgBxEz93zrb13vt+AQbkgKETTxwDdPDz1uiEfL83NyHuYKSWyVq+E/qj7huGQOOC95uh0L+vwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110130
X-Proofpoint-ORIG-GUID: SonJWfvcUsjZ91md307q-UFAm_Ka0Mi1
X-Proofpoint-GUID: SonJWfvcUsjZ91md307q-UFAm_Ka0Mi1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 14:02, Zhang Zekun wrote:
> In fio test with 4k,read,and allowed cpus to 0-255, we observe a performance
> decrease of IOPS. The normal IOPS 

What do you mean by normal IOPS? Describe this "normal" scenario.

? can reach up to 1980k, but we can only
> get about 1600k.
> 
> abormal IOPS:
> Jobs: 12 (f=12): [R(12)][99.3%][r=6220MiB/s][r=1592k IOPS][eta 00m:12s]
> Jobs: 12 (f=12): [R(12)][99.4%][r=6215MiB/s][r=1591k IOPS][eta 00m:11s]
> Jobs: 12 (f=12): [R(12)][99.4%][r=6335MiB/s][r=1622k IOPS][eta 00m:10s]
> Jobs: 12 (f=12): [R(12)][99.5%][r=6194MiB/s][r=1586k IOPS][eta 00m:09s]
> Jobs: 12 (f=12): [R(12)][99.6%][r=6173MiB/s][r=1580k IOPS][eta 00m:08s]
> Jobs: 12 (f=12): [R(12)][99.6%][r=5984MiB/s][r=1532k IOPS][eta 00m:07s]
> Jobs: 12 (f=12): [R(12)][99.7%][r=6374MiB/s][r=1632k IOPS][eta 00m:06s]
> Jobs: 12 (f=12): [R(12)][99.7%][r=6343MiB/s][r=1624k IOPS][eta 00m:05s]
> 
> normal IOPS:
> Jobs: 12 (f=12): [R(12)][99.3%][r=7736MiB/s][r=1980k IOPS][eta 00m:12s]
> Jobs: 12 (f=12): [R(12)][99.4%][r=7744MiB/s][r=1982k IOPS][eta 00m:11s]
> Jobs: 12 (f=12): [R(12)][99.4%][r=7737MiB/s][r=1981k IOPS][eta 00m:10s]
> Jobs: 12 (f=12): [R(12)][99.5%][r=7735MiB/s][r=1980k IOPS][eta 00m:09s]
> Jobs: 12 (f=12): [R(12)][99.6%][r=7741MiB/s][r=1982k IOPS][eta 00m:08s]
> Jobs: 12 (f=12): [R(12)][99.6%][r=7740MiB/s][r=1982k IOPS][eta 00m:07s]
> Jobs: 12 (f=12): [R(12)][99.7%][r=7736MiB/s][r=1981k IOPS][eta 00m:06s]
> Jobs: 12 (f=12): [R(12)][99.7%][r=7736MiB/s][r=1980k IOPS][eta 00m:05s]
> 
> The current struct of iova_rcache will have iova_cpu_rcache for every
> cpu, and these iova_cpu_rcaches use a common buffer iova_rcache->depot to
> exchange iovas among iova_cpu_rcaches. A machine with 256 cpus will have
> 256 iova_cpu_rcaches and 1 iova_rcache->depot per iova_domain. However,
> the max size of iova_rcache->depot is fixed to MAX_GLOBAL_MAGS which equals
> to 32, and can't grow with the number of cpus, and this can cause problem
> in some condition.
> 
> Some drivers will only free iovas in their irq call back function. For
> the driver in this case it has 16 thread irqs to free iova, but these
> irq call back function will only free iovas on 16 certain cpus(cpu{0,16,
> 32...,240}). Thread irq which smp affinity is 0-15, will only free iova on
> cpu 0. However, the driver will alloc iova on all cpus(cpu{0-255}), cpus
> without free iova in local cpu_rcache need to get free iovas from
> iova_rcache->depot. The current size of iova_rcache->depot max size is 32,
> and it seems to be too small for 256 users (16 cpus will put iovas to
> iova_rcache->depot and 240 cpus will try to get iova from it). Set
> iova_rcache->depot grow with the num of possible cpus, and the decrease
> of IOPS disappear.

Doesn't it take a long time for all the depots to fill for you? From the 
description, this sounds like the hisilicon SAS controller which you are 
experimenting with and I found there that it took a long time for the 
depots to fill for high throughput testing.

Thanks,
John

> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>   drivers/iommu/iova.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 3c784a28e9ed..df37a4501e98 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -238,6 +238,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   
>   static struct kmem_cache *iova_cache;
>   static unsigned int iova_cache_users;
> +static unsigned int max_global_mags;
>   static DEFINE_MUTEX(iova_cache_mutex);
>   
>   static struct iova *alloc_iova_mem(void)
> @@ -625,7 +626,6 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>    * will be wasted.
>    */
>   #define IOVA_MAG_SIZE 127
> -#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
>   
>   struct iova_magazine {
>   	unsigned long size;
> @@ -641,7 +641,7 @@ struct iova_cpu_rcache {
>   struct iova_rcache {
>   	spinlock_t lock;
>   	unsigned long depot_size;
> -	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
> +	struct iova_magazine **depot;
>   	struct iova_cpu_rcache __percpu *cpu_rcaches;
>   };
>   
> @@ -722,6 +722,13 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>   	unsigned int cpu;
>   	int i, ret;
>   
> +	/*
> +	 * the size of max global mags should growth with the num of
> +	 * cpus
> +	 */
> +	if (!max_global_mags)
> +		max_global_mags = max_t(unsigned int, 32, num_possible_cpus());
> +
>   	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
>   				 sizeof(struct iova_rcache),
>   				 GFP_KERNEL);
> @@ -733,6 +740,12 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>   		struct iova_rcache *rcache;
>   
>   		rcache = &iovad->rcaches[i];
> +		rcache->depot = kcalloc(max_global_mags, sizeof(struct iova_magazine *),
> +					GFP_KERNEL);
> +		if (!rcache->depot) {
> +			ret = -ENOMEM;
> +			goto out_err;
> +		}
>   		spin_lock_init(&rcache->lock);
>   		rcache->depot_size = 0;
>   		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
> @@ -798,7 +811,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   
>   		if (new_mag) {
>   			spin_lock(&rcache->lock);
> -			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> +			if (rcache->depot_size < max_global_mags) {
>   				rcache->depot[rcache->depot_size++] =
>   						cpu_rcache->loaded;
>   			} else {
> @@ -903,8 +916,12 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   
>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>   		rcache = &iovad->rcaches[i];
> -		if (!rcache->cpu_rcaches)
> +		if (!rcache->depot)
> +			break;
> +		if (!rcache->cpu_rcaches) {
> +			kfree(rcache->depot);
>   			break;
> +		}
>   		for_each_possible_cpu(cpu) {
>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>   			if (!cpu_rcache->loaded)
> @@ -917,6 +934,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   		free_percpu(rcache->cpu_rcaches);
>   		for (j = 0; j < rcache->depot_size; ++j)
>   			iova_magazine_free(rcache->depot[j]);
> +		kfree(rcache->depot);
>   	}
>   
>   	kfree(iovad->rcaches);

