Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D7A75A15C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjGSWHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjGSWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:06:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D2C1FE8;
        Wed, 19 Jul 2023 15:06:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOiRE025954;
        Wed, 19 Jul 2023 22:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=I0DvYO3AIUNdvfCMma4Vb1SFOKdrCdqHtKuaHNwq9mU=;
 b=0jAH41B5JMo1+vE2KkQLIAmQrFLgh86lU2FMBaBsC1lXQUjo8tA4iqpXr+BX17LR+2LW
 WZfkS0Iaa+b9QYzSguQTnBxzlGkmdJezD6o8B+oyImqJKTIB50SOA0UxB7I4dJMtbjCE
 jd0D1tfFgQ3J6n+2yRLFE8RJ04x9PgTwyX6kcuZ0mL/tHWf+mhSmaoS4feQ+VEIxXm/k
 Yu1d/4rtfdwArN2YHSbK0lAVzCaDy6wOx0nNpxIuIyBVQhSgSQ2zcvq8Ok/WM1022TM8
 tXIk3AJZiltbLIQZQIWL3dsgHvsY2l9AtrO27WJDW9C4PJ4NVM2UEw/PH5FG4Bc9t4Mo ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run770k5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 22:06:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JKnJDG023806;
        Wed, 19 Jul 2023 22:06:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7uhwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 22:06:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVtquQBHp7cjDnwbTOewUr049oIgVTM/rwbig9t0nMVwNU9ar9aywGXwtZaPJYiLCFm1MsotwS6ZwSEMkPSZ6AOAJz5XkbrqbleEoeXuAH6n7K0WEZeTxu7Dhu1ZhJ/DI3Rz7/bUipavl1vjYRZJk9rJMOCwbRcwv9eRFHheT4dDwCKMSieBVVw6akhlvXFbcZj53PAi7XWDdAkMXrOsd8FBJLFHXuUBvuIpt4U69lqFsFTA63aU9UsntlP8DEMJuICcscUzVyymtgoxBUQ/zs0jmNxaO1tsy64I5oMRmSrS9XB0NonCPleJpos/e+OjsH0sTKJ6KdcPnv48DJLkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0DvYO3AIUNdvfCMma4Vb1SFOKdrCdqHtKuaHNwq9mU=;
 b=lB2MDL127KMewvbt0dCBlgzxSLhnbfGCUD0Y+fiCLefgepoPSjqr6QXbYac3o1/TeUNiIkdOZmp/+kmPaUMbKerf2JL55JC1l+tE3odKmpR029JBlkg6QmfsJ7frRXFmv9W1TUWpRfk1bkefg6rvH1qhsqYyW7jo0w3HuZnTdpw+ZMfvaiFMzGaI/BMJFeSrVQDk1p+/6I9ukvxpSAkaS8rsHoQoq+AWr5KRHzILkjXtZZh9qKGZSAsvR9XI34reszNYcdqKRYceuQrl1XNBjc4PuVIClZR6Q8m7dLi0UhOzv1ICI4JulgWYd6/5NQx4n2+mWPt1t6T5xlZ4DS8djA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0DvYO3AIUNdvfCMma4Vb1SFOKdrCdqHtKuaHNwq9mU=;
 b=RQHFFzB26FqZykPDrYvgCysG1WOgMpHuy+pAVgC+LRCBfBRRPwLOF3nrILWbYwRDX5J21D3JcmUXr2C1QBtf4bpdxavL/Cru0B/4hxvO7bARBtXxWi6kYR4r9Bzg1cdTs2/dTsJ87VgHM27iQEW4I46WW7j7xDjrBDRbFvQdib8=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CY5PR10MB6071.namprd10.prod.outlook.com (2603:10b6:930:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 22:06:24 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1ad9:6eeb:6c8d:27d3]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1ad9:6eeb:6c8d:27d3%6]) with mapi id 15.20.6565.028; Wed, 19 Jul 2023
 22:06:24 +0000
Message-ID: <79bbb44c-f3b1-5c5c-1ad4-bcaab0069666@oracle.com>
Date:   Wed, 19 Jul 2023 17:06:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] dedupe smb unicode files
Content-Language: en-US
To:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        Steve French <smfrench@gmail.com>
Cc:     linkinjeon@kernel.org, tom@talpey.com, shaggy@kernel.org,
        linux-cifs@vger.kernel.org, krisman@collabora.com,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20230628232417.120844-1-linux@treblig.org>
 <ZK80mu/YbHLEABAB@gallifrey>
 <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
 <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
 <ZLhchajZaWEVM6D7@gallifrey>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <ZLhchajZaWEVM6D7@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:610:60::36) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CY5PR10MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: b5827e34-a402-4ad8-691e-08db88a46426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MViLzsIRUTi5oJ4zNG4DlCZ51eOgE8fbDL3AiIBvmGeYR/bjsxpaDdKOQIqxZwxWfjhSxxl8UvaGS+hQGHapkWEtMwPNtkFGNElz+Mud22yuJRK3Iy/4rrQRM2Jmdew6DBcD6s8/gdzSRhojOk0ZdPYMpGi8V7I97O9rABGTPY5f3aD5r4WgzeAX9bW59HbaaxZGrZsuC5z8JSZp7aDpMdHhCbFQuY//DSwLY2F874va3WV/gQea4ykjvqdNcGXSqdcXmRZTpmZ2rusCufNqrpN50uG1+iOduBtVpXaF0oYtov/aFhnBq4bHVwm0qnipTgZzsQjLQhv0cqNwNLzv0dlHSuoPzzV5nryjEeWKL2o8sibMmxLwGKvR9Jiyraazdbaidyua/8H22cCFUdAy+uki2yxCr0ww583YCa5pOtWddPc6ZyT0OLWBPxtzQoq2nr1S285EL/zbu3JbLE9cOAKzAuFIekhPi/dPL11jaOWyld7RS6gYvgEPGBJGFoBzfbDWrvPpDR2UFW5Nzq7oXrC4Trk3+AOOk578m+uZx+3yQS8jODFl13Gz603eWD51wP5Xg2FvgoDFm81q7Rc+HgI2FhyBAPmxvWMkyK5ZoBjDSn31SrvFuKSjH9u7zKRjqi9A6MY2mxZac8AVlSC9dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(66556008)(66476007)(110136005)(86362001)(186003)(66946007)(4326008)(44832011)(966005)(478600001)(41300700001)(316002)(6512007)(6666004)(31686004)(6486002)(8676002)(8936002)(26005)(5660300002)(36756003)(2906002)(31696002)(53546011)(83380400001)(2616005)(6506007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjJSV3k3SHVBTitEbWxFTXo3KzlNaUNtYkFHSzc1Z2FCZktSZWsrZWpPMUs5?=
 =?utf-8?B?MzBYd3JTSUpzbUMrMzArb29LUGgyb2d2cFlMVTF4VXJHWHAyM3JKZjhGOVh0?=
 =?utf-8?B?NHZQZ1NDYWYrSjJkWGpDS2FhVzBqSFdDM1gwdEluUEhKMXd6TGtaaWdLazVP?=
 =?utf-8?B?REZDb2F4WllRbEYwS1ArU3cvRmFVcUJkUEhqbDMwbElJdFF2RXIxSlJpTEVB?=
 =?utf-8?B?eTlhTStnTmFjbG1FdWtYa1drZ0E3RDJoS09tVXdKTjVDcjh2QnJaY1VYNU1Y?=
 =?utf-8?B?MTJONHk5bU0yYnVNZERvTUpRWkhMd3A4TTJDcW55RlBpVFRGL0RCc1JtVkJt?=
 =?utf-8?B?dm1lUXBLWDlsZi8zem1McWhSSHBjS3Ftb0crSGhkblZPemgraTd2L29pWGJt?=
 =?utf-8?B?VGV1RzhUZmFHaVRNRzJYZjJrZjlJSlB3MEZDdVRkdDdFRXAwNFp6cURJUGN6?=
 =?utf-8?B?WDh3M1luWGVkYlN0NG5tY0FBb3dCRHRlZjRKa3R0SHFqSUUxdHNFWjJGTmJR?=
 =?utf-8?B?NlJWR0Zybk5YWUtuZDNQeUdNN0lJNWI0cG5JWDRBT0tHYUtKSTNEa1AzNWVv?=
 =?utf-8?B?UlJaNS95Zlc2SEpLMHpXTlRjM1FaaTFacmcwRjZXdnNpL2k4MlR5cGczR1hx?=
 =?utf-8?B?bGRaSTdreXF0b3VpUWVWdkVmVGtMb0lVa3N3Rzd4dDAvVGEwcDhielVNSjlw?=
 =?utf-8?B?SWtUQlJabzdSVnUrdTl1TUNwNFhmZEZxaFFUeXdBWW9qTDFreUFBU2t2K0c3?=
 =?utf-8?B?NXdSblR3WDR0ZmlGRFFHOHhnandaeVBLaGJQYUtwcDZ4Q0QwYXExeUZLMUJG?=
 =?utf-8?B?ZWhwQTJyU2lDb2lBMG1vNzd4UUVGcWlhTHVEZlg5NFptTHEzTUUrUGl1c2hN?=
 =?utf-8?B?aFFkVEdJTEVwcmcyUnRNSWFQSk4yUVdhcU5vTmZVbmY2dk5RZU1Fa1VWakRM?=
 =?utf-8?B?ZCt2ZEcxaFRQQjhFUnByYXVzbkgxV2FIUlZLS25RRVg2aVdOTGxNbEhRc2Vv?=
 =?utf-8?B?T0M2WFp2QTNFd1JVTFFhMEdVWUdFN2ZoMytQYTZVc0RIK3dncXB6bnNJbVZ1?=
 =?utf-8?B?YTBOM0YxOWNMdFR3S2pYTldPcXRpSk9ROXVCbnYrRk5PQzQ3alc5NGVTV2VE?=
 =?utf-8?B?Qi9oclJuVVFmSlZSUVo4bi9EWmpqeFI4YmpDTjBSMW40WW4vWFdYWFJKR0l2?=
 =?utf-8?B?Qkh1ODhIdWpaalBTWjBNZ3U3RVM1RkhBNHB5N3RpUnUxK3EvMGxEZkk5Yng3?=
 =?utf-8?B?WFE1WERTL0hadFhWd3RSaExSK21pVU85UGs5UTN6T0R2dTVRRkNsQ1JPSzdr?=
 =?utf-8?B?ZWI3cm9VWFN4VURuNkJMK1h5d3pnNlI3UzdZbk4rdG5aWXpSOEZvOW05WkRS?=
 =?utf-8?B?ZW9JT1lzS0RNY1hnUzlEMlM2a0o0Ky9hTkZ1UlFxdS9lcmVWVzBITk15bENk?=
 =?utf-8?B?RzBpWVkzYWRlOWVoSm1kOGlSTFRKanZGd2dBc2RZdjJSVmJibWhLSjB5N2xC?=
 =?utf-8?B?aXYyZ3dJNzRUT0M5WElTMk1xTktnSzRDTUhnL3lKbWUwVkx4N05uZkF1bXZY?=
 =?utf-8?B?RXljSElKMDNHWUdnSUttajdqaVUzcjVyeUhPYzN0K1dtSUMrS1BZU2R4WXhQ?=
 =?utf-8?B?Y3VjMmtNazFka2RWanNaWHEwTFFaSWM4V28wa3dDNm00QnJBSER1emhyWlVG?=
 =?utf-8?B?bTlmOVZmRHVPdlRGbjhSUmNvajFwUEg5ODVIN1U5MnV6d3RUL1BaQVNzamlO?=
 =?utf-8?B?SXlEQzhNYzJLSUhNbzE3Z1FxUGRxZUcvMFRPNmx0REhyV2lIdGNnSTRaMkF6?=
 =?utf-8?B?SEJ6OTYxUTQ3UlhuZCtwbzh3MCtBM3d0RUphaEx3UDlnRkVOTnRwQzU1dlRK?=
 =?utf-8?B?VStxb0FaRjVyaU1rY0VBODdQSnVqUXh6VmQ2ZVlmSHNLZXdDQi9aY1V4aUp2?=
 =?utf-8?B?SVRZbUM0UjEvNVRraUtXbXJWTmtCamtpZGtJb2gzejlncHgzOEZPbGl3M05a?=
 =?utf-8?B?K09BeDc0ZTVnb3VzdFBBeTZQRWJ3S2pMY3RvbVllZ1dySlYvUXp4R1pzMGs3?=
 =?utf-8?B?S1JqcUlwcEJhTmpEOC90Q1BRMkcyaVh0NjFEdGNyVjVMMlpMeUd1M0R4K2NK?=
 =?utf-8?B?b2h5cDh6cTA4a2puQVdRT1pwY3plN1hnNWpvV2htZzBHYmN4V2lsa3I5QlhR?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bWUxcU5GdnphN0tBMldXWlJUOFlFMmxNNXhqbXVsTXk0MWJpbVpyalZnMElE?=
 =?utf-8?B?TUNnc2h1UHd5dXdSblVzdG5qRTdLNnJ2TThIRVEzQjZrbjZEYjBEZlRqd0pB?=
 =?utf-8?B?bVl0alRXN2FXSGF5OWlRU2xQMjhROTRaaGhaOXQ2RXF2RW1QNUg2RndCVlVV?=
 =?utf-8?B?QUdwNDBwbFdhbzc1WXJoMXNaRTNFclBvS2RldHdzdFJLOE1RdXhZd1FPaDdz?=
 =?utf-8?B?aWFKV0NmZGtFbThOOTY3dGVKT1VzUVFiUEN1djdMUXkyRmxMZVdIQS9MaGM4?=
 =?utf-8?B?K1o2dTY1bEJJalVHSW05UUsycnZ2WkxjWTB6SXppUFpsSW5XUVcvTXZycVlw?=
 =?utf-8?B?elpGZHJBV0tjNXhIVWJ1di9YdW1mOTA5d0FBdFoxS1B3YVoxbFRScDlLQktH?=
 =?utf-8?B?dkk1UHdTeUwwZXV3eTBiSHNKbzM2MDlVUVJtTVY5aStpTGpaU3JvSkxzZUll?=
 =?utf-8?B?TGRwUi9DRDQ1R0cxMEliN0dFdTZSZHVXeUJZb0VaY253OGRrQURLYklpQk1n?=
 =?utf-8?B?WUlvQXBhM2pCR05tSndpZDFPeXVWZUQ3ZWFPT2VNUW5VOGdiYjQ4cjU3TUZZ?=
 =?utf-8?B?V3Y5UU1GdVArdTE3UG9rajFkNDY4SW5WU1dON2owMjFTVWpXQVJhSDB2eFJQ?=
 =?utf-8?B?RmNnamFoNjZ6UDkwVmZEMmIxQ1l1WHVQMDVhQnplK3hpRXdOUzRIeVR2cWZH?=
 =?utf-8?B?NkwyZjl6a3k3WXhZZC8vUU1TQm11SHA4RmxZTngrRUp0TlVKQy94S0t1NURX?=
 =?utf-8?B?MVVQcEZOY3R2NnJITkwzcmlzUThjaVZHb0JJZkhzaEw0WnRPSFZmMVd4bjQz?=
 =?utf-8?B?SWpFMm8yekx5MnJ5SEJPWU1hc29uOFNCVjZhZGFQTkJYNTkyQXlObm5DQ1I0?=
 =?utf-8?B?WkpDMGlGNzEybGNxcHRScUE3L2xWV0piODd1QTY2bUdMU2d1Nlg1VW5WbkZ0?=
 =?utf-8?B?cWFibEp1V1FhTHpaSjNJMml2bUxPdGNhNWJPY0wvZG9SaVJxT2dhb2dEQytM?=
 =?utf-8?B?WlZvWWJDWnRJRFh6aVVqOXA3VkpzRlBtZ3d2UWt4aXB2SG9QdE0zWlIzVmVI?=
 =?utf-8?B?SWtOZDFzSGxBVzFmRHQyQkFLTVB6UjNLQ2ZnMktkbE90UU8yUU9oS3VFSXdw?=
 =?utf-8?B?aXZJU2FyaThYWWNXKzNTU2lsRUYrOHNUV1RPem4xbS9ZeENsYWFpaGZPNUVx?=
 =?utf-8?B?MnJ5VWJBZUoyNWJCSC9NQ1dTa0d2dEhLTWxsRHBTZ3dxMHhlTzdTNVNMMjFN?=
 =?utf-8?B?VmJBUHpUdlFsWFF5WTR4dFBabm5Ya3NCMFlEU0lmcnNTWWIxWkdFVklndVJN?=
 =?utf-8?Q?HtFNMdmQurNi8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5827e34-a402-4ad8-691e-08db88a46426
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 22:06:24.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hae41QiRAmE/4QS8OJGU+1zTHxMaVKQv1hucQlmnL92FNCF1nhYcQ1E9SFZaIp5Jvl6DkyaPyy+KVNI2NMqygSfDrzroZxrMuFW6MRPBJfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190199
X-Proofpoint-GUID: plAYbgTfIOPGOb4wvEOGgyqjqWqr6z_D
X-Proofpoint-ORIG-GUID: plAYbgTfIOPGOb4wvEOGgyqjqWqr6z_D
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

On 7/19/23 4:58PM, Dr. David Alan Gilbert wrote:
> * Steve French (smfrench@gmail.com) wrote:
>> The related question is which tree to send it from, if no problems
>> reported (presumably mine since it mostly affect cifs.ko and ksmbd.ko,
>> and because there hasn't been activity in fs/nls for years)
> 
> That was my hope, given that ~half of the patches are directly on that
> code, and it's the only very active tree this touches as far as I can
> tell.
> 
>> On Wed, Jul 19, 2023 at 12:56 PM Steve French <smfrench@gmail.com> wrote:
>>>
>>> No objections to this on my part.  If Shaggy is ok with the JFS
>>> change, we could target it for 6.6-rc1 if it tests out ok

For the series:
Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Steve,
Feel free to pull in even the 4th patch into your tree with my consent. 
Or if you're more comfortable, I could submit it after yours hits mainline.

Shaggy

> 
> Thanks.
> 
> Dave
> 
>>> On Wed, Jul 12, 2023 at 6:28 PM Dr. David Alan Gilbert <dave@treblig.org> wrote:
>>>>
>>>> * linux@treblig.org (linux@treblig.org) wrote:
>>>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>>>
>>>>> The smb client and server code have (mostly) duplicated code
>>>>> for unicode manipulation, in particular upper case handling.
>>>>>
>>>>> Flatten this lot into shared code.
>>>>
>>>> Gentle two week ping on this please.
>>>>
>>>> Dave
>>>>
>>>> (Apologies to the 3 of you who already got a copy of this ping,
>>>> recent due to a missing header ',' )
>>>>
>>>>> There's some code that's slightly different between the two, and
>>>>> I've not attempted to share that - this should be strictly a no
>>>>> behaviour change set.
>>>>>
>>>>> In addition, the same tables and code are shared in jfs, however
>>>>> there's very little testing available for the unicode in there,
>>>>> so just share the raw data tables.
>>>>>
>>>>> I suspect there's more UCS-2 code that can be shared, in the NLS code
>>>>> and in the UCS-2 code used by the EFI interfaces.
>>>>>
>>>>> Lightly tested with a module and a monolithic build, and just mounting
>>>>> itself.
>>>>>
>>>>> This dupe was found using PMD:
>>>>>    https://pmd.github.io/pmd/pmd_userdocs_cpd.html
>>>>>
>>>>> Dave
>>>>>
>>>>> Version 2
>>>>>    Moved the shared code to fs/nls after v1 feedback.
>>>>>    Renamed shared tables from Smb to Nls prefix
>>>>>    Move UniStrcat as well
>>>>>    Share the JFS tables
>>>>>
>>>>> Dr. David Alan Gilbert (4):
>>>>>    fs/smb: Remove unicode 'lower' tables
>>>>>    fs/smb: Swing unicode common code from smb->NLS
>>>>>    fs/smb/client: Use common code in client
>>>>>    fs/jfs: Use common ucs2 upper case table
>>>>>
>>>>>   fs/jfs/Kconfig               |   1 +
>>>>>   fs/jfs/Makefile              |   2 +-
>>>>>   fs/jfs/jfs_unicode.h         |  17 +-
>>>>>   fs/jfs/jfs_uniupr.c          | 121 -------------
>>>>>   fs/nls/Kconfig               |   8 +
>>>>>   fs/nls/Makefile              |   1 +
>>>>>   fs/nls/nls_ucs2_data.h       |  15 ++
>>>>>   fs/nls/nls_ucs2_utils.c      | 144 +++++++++++++++
>>>>>   fs/nls/nls_ucs2_utils.h      | 285 ++++++++++++++++++++++++++++++
>>>>>   fs/smb/client/Kconfig        |   1 +
>>>>>   fs/smb/client/cifs_unicode.c |   1 -
>>>>>   fs/smb/client/cifs_unicode.h | 330 +----------------------------------
>>>>>   fs/smb/client/cifs_uniupr.h  | 239 -------------------------
>>>>>   fs/smb/server/Kconfig        |   1 +
>>>>>   fs/smb/server/unicode.c      |   1 -
>>>>>   fs/smb/server/unicode.h      | 325 +---------------------------------
>>>>>   fs/smb/server/uniupr.h       | 268 ----------------------------
>>>>>   17 files changed, 467 insertions(+), 1293 deletions(-)
>>>>>   delete mode 100644 fs/jfs/jfs_uniupr.c
>>>>>   create mode 100644 fs/nls/nls_ucs2_data.h
>>>>>   create mode 100644 fs/nls/nls_ucs2_utils.c
>>>>>   create mode 100644 fs/nls/nls_ucs2_utils.h
>>>>>   delete mode 100644 fs/smb/client/cifs_uniupr.h
>>>>>   delete mode 100644 fs/smb/server/uniupr.h
>>>>>
>>>>> --
>>>>> 2.41.0
>>>>>
>>>> --
>>>>   -----Open up your eyes, open up your mind, open up your code -------
>>>> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
>>>> \        dave @ treblig.org |                               | In Hex /
>>>>   \ _________________________|_____ http://www.treblig.org   |_______/
>>>
>>>
>>>
>>> --
>>> Thanks,
>>>
>>> Steve
>>
>>
>>
>> --
>> Thanks,
>>
>> Steve
