Return-Path: <linux-kernel+bounces-4742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17055818172
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825D51F22362
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D4879F0;
	Tue, 19 Dec 2023 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hZJLMjpc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B6SdSL11"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E98BFD;
	Tue, 19 Dec 2023 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0ItgV024921;
	Tue, 19 Dec 2023 06:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=z0seJmAEvQpX6SDO1IWCEvO7kVRzcTTnXBMztVcnhq0=;
 b=hZJLMjpcG6il6K+MigZ40StElWf8ZFjV0wGtCBWp759ZKsdEKoFpn6MXxLZkahBTGIwF
 8HRluz2u+ZG5iALk8tHt9vqGceKSirj+F+BNsNpOxH/JZsLWH8D9KBqnHV8exhuqwMZ3
 roouWVQP55iMtbAyBNhaKi7paSr2sfIaApS2ohXp+iQRnrcKr+M3982Nz5KeDPe0aiV5
 397g9TkM5RjG0rhOAWYbzYprNXanqgfOzm+10oViZxI7S9v4Ch4zekKOv8J4k49t6Nsn
 EKNvm6MJaH9XseBMGeIK7vSEYygM5GJ2nOpjSHSPyXWc5xQLTMgvbmc6//phXj3AP8qp oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12p4556g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 06:19:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ5gaJM029241;
	Tue, 19 Dec 2023 06:19:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b678r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 06:19:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBMxdRJPlpCBnsFQwE1aKobXxWZL7jlzUPMcGH4FjLUSnKTR+9JxgagHVbzUlOkQGy7s83nkRlI5zX29qQ0UG1CgYJY+eGKGJW8CSWgf/00NlljDBS99umdjWM9Jg2oWZw2pzRmgAc+mp7LFUf9OU1RFlzIBYG32KQ37NBzgk/rfFiIsxGs8t4t3PrZYzSFjBGIXvs+EbOyzUqI7f/e5Szb5ak8B2zjjDu5aOcRN3pp8qhPUnOZ0s5Azrf2ZRIG+ZaG/JKiMvSJ6obyTfs6rc4ovFLstaDMJknC4FPyHmr80qiw2flTK4hWgRKlKwPRhn9DtH5bFsTBaSaD1/BOEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0seJmAEvQpX6SDO1IWCEvO7kVRzcTTnXBMztVcnhq0=;
 b=Gk+B0+l4lrGQiil2cXTZXtY1SuzFcVEMaZm4iO6Lo2TU31kUmoYf08pvMZvCDQvyl0Euu1aVT7VWo8mvNERV1u+54PBcSpSVSqDxcghHotSsUAANyGC9Nvqo0wH1Xmg8yD/bBQcfUlfb0DQ+Y6MyH3H+uwNgA4x+avac5goaS5w4nLUQR+5vtLyhpkThIm/0+UjxSTkrn3Cg5vaHwGTQiQaErXoTtCW5/HNAAjp8FlApfS8dsvwMTRUa+5txyI9EkejGEDS+wPPg2SqOADPEoufuN+aU9O68Me5O6UjVNG15gWMjWXx2usjZogGWRaJhAMRaEOcLkPPJoGcAMmR7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0seJmAEvQpX6SDO1IWCEvO7kVRzcTTnXBMztVcnhq0=;
 b=B6SdSL111lhmsMRocZ/odMossCOf76dF/NUlsFziU6uzJJFSkzKScq4d9Wnq1CC0K4MExbSAqUwpjve0UZsne907CO655DmQ4tcrqWTjJcHJRRJ+QWtnlaUOjBUVW4xaIfJiI8vLUDu4avgRogwC+H8mJNm0Y/DfIH7BnUyVgi0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA2PR10MB4633.namprd10.prod.outlook.com (2603:10b6:806:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 06:19:36 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 06:19:36 +0000
Message-ID: <c10f870a-282c-4346-82fa-9ea27d3ce645@oracle.com>
Date: Tue, 19 Dec 2023 11:49:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/40] 5.4.265-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231218135042.748715259@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231218135042.748715259@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA2PR10MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d63cc19-1be7-4f6f-93e4-08dc005a7962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hByW/xFkMSWLAmiBqCp7TSkxxfKg6fJZnF77f2ZI4o8kjf1WwLWKvINUUzh6ZTkSdi5ADx3C2ccR/2gmj3gu/DZx3KsSchQO0H1zfFJa+zyERPyWh3WCTi453rF0gmbIiabP5NUscRHJUiUVjpNC/6eg8vmRh5VWA+n3qwCYMj6ta48WgNwpQ9TZ+yeSJZcEYlxiHYY/HhpmM3Y638y8z4F6i13ylUudlUMduToZLYqOrLvT4w8lgCO140NYXD3ij+8YiLJhi6p/dctyWhHbyu3H7COfoafiV+HWUHchJnUyJliRucmEGoh+ZjBilZVQiiw16brYAMOt0v6lWo4EdiE/qZ8RylmSRs4OYUh0+ke6itEic9qCXak/LSsPARS1VY8UElEDc0AgtrntNUXHjbeZbX7Hrk1KTTJOn5nIXU5SHKaerhQ2Cz2cZEfD7HatMd9KZIYEqi1647Bl4TOhjy56wzkcIVHBTkgSPeDKqKfZa5q2Rt7WB1R1c076cUssMAUn9AP6oLH3STqnnDa46rVYKPrjCH697vz3WshevhPgbdTcYOAgo5rwTP6se0hnaLrUy8UtJFwGloHp7dtcLA8T4smcqH0ojMF3HCT+fUblHDZx9CZ3A0AbSmKFGE9PpZDactTXgF3JHwZSwe/t8A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(107886003)(53546011)(478600001)(26005)(38100700002)(8676002)(8936002)(4326008)(7416002)(41300700001)(4744005)(316002)(66946007)(966005)(6486002)(66556008)(6512007)(5660300002)(54906003)(66476007)(6506007)(6666004)(2906002)(86362001)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3BkdWxqWkdlaUpnam1NblF1WFkvckszcXJDdmM5ckVQK1YyTFVoc2NnZGtQ?=
 =?utf-8?B?Ti9WeXFrdCtwWHgrY3FJaHIxVTE2NVhjU0J2OFpuVW96NW9IQXNGK0twckhQ?=
 =?utf-8?B?eERCTnJ5eWd2VTJxRHZpWWpEdm54MnFmKzliUmdwa0tQdWJTd08xNWxsbmJ0?=
 =?utf-8?B?WitiVGljSi8xRmNLbE1RSmJ0RC92eE92RjVLa0FrR3BZSGVLVnpEMWw2K2ZR?=
 =?utf-8?B?clhHcE5YRGxlTlhIUlhCZjlUelRwTUZPd0JtV1ZGeldER1U4aTVUZE1YTmpB?=
 =?utf-8?B?cVNVaUw4TUJzNFFOT0dRRkdnbk5QL0N2OElaR2kxS05RbnVnYmkrQlgwMkJq?=
 =?utf-8?B?cFFlaHlFM2FGSjlpM3FiNGpoa3NLMzhjZmVtTHY5em9kRGRjU0dka2VMRW5E?=
 =?utf-8?B?TGoyOWswUVBTeXJaWG5oZm9xMlZBOWVvMnNPUXZkb2phN1lJWmxkakk0U092?=
 =?utf-8?B?UnlIbktlT29ReFd2ZnVBTEhxUldDNlFUcS85YmpPVFJRNWhHNzVCdVFtM01J?=
 =?utf-8?B?UW1xdzRDdzVaZUNPWnlrVEUrRUJubkdrbitUME5xZXhXZzEvcm1RSitLald4?=
 =?utf-8?B?eVV6QnVmbHhTQnFIY3JUMFg3Qi9ma2RVVHphTnNnbHVibFM0eE9uZjEzNDV4?=
 =?utf-8?B?Z0N2SFl5RnA3RWtQNm1DYWhTTTJ2QUlOdnRyczJOUlZnUU1pcjZzTDBSMmh3?=
 =?utf-8?B?OGtMdElWMWhuWTNLbDFWVUg3WUVHMlZJU2JUdENIMkdRQ0V5U0VPa1l1UDV1?=
 =?utf-8?B?UWljczdsZGhIbmttdUU2S2M4QmlzaGJIcHphZ2Fvc2NQYXJaZk9PckJoRWF5?=
 =?utf-8?B?bGZ3Ui9rTHI2ZENWWExJU1RNam90RytFUUJlYnBOOVBJaksraGNLWnhDdis4?=
 =?utf-8?B?eUR3RGRsRnAyZ2xVTWhVVm12UGdLUEp3ZUNwa2tpTlpvcHZIbFROYWZlZnRp?=
 =?utf-8?B?UzNKdUIreE9DZ0lhNGR2amtvbGlEYVZEM0YxUnZCVE4rSlZIUDNpUW5BaDUw?=
 =?utf-8?B?bmdHN1JJSEdVdG5mZ2VHNzBaUTZta20vQzQ4WnJOd1pTQS80WU5IZlYyZW1j?=
 =?utf-8?B?UkRLaGdUbnhtVVMwWEJ5RVNySC9UWFMwVThVMklFWWh1ZlhkYTBrNGJpOWNM?=
 =?utf-8?B?QUpGNVNpamZqb3NjeWJQQkhKVHl3S0ovWW1oVmpUS2lnZ1AyWCtsSWFJVWI1?=
 =?utf-8?B?bjZLMGw5QVpLenMyVkVydDU2ak9kQVliYlBQcC95RVNxNTZsTkhBWWhiSFY3?=
 =?utf-8?B?aWlvS1kwMmhmYkZMbWJQaFF0Wit3R1dhOGw2aDI4bm5xbEsxdVREcSsrNktO?=
 =?utf-8?B?Z2NOeWRCaGlSd3ZvTmVYelV1TndwM1NsNHFlbGpqZXdiS2JBZjRnRzgrUXFB?=
 =?utf-8?B?L1dQc3JaQjZ1cjUxemNoejRvNEdpSFZmY21CRHNRenI4MkRqdlZqSGw3TXVB?=
 =?utf-8?B?Ui9paHVmdGNPeXhjMnhKb3FKQVBxVU14QkRYWDhFb0dWd1U1RThqSUF2Tmw1?=
 =?utf-8?B?QXk2eEtDK1BDYmJpb0laeHNDQ0RkbW1RZnpYanpCVlUvVEp2VHRmM1d0TEpp?=
 =?utf-8?B?L1dTazVsa0RjMHhQMkwwaHc2SERDZjBnREdHVXBKeVc5Z21CYXE2Y2tSWmF2?=
 =?utf-8?B?YTk3aWJuMGc4UDZkdEliajhkVWpuckY4YkZlOFNENmxsaUYwMU9PV0pmZ3h0?=
 =?utf-8?B?VzBvaHhyRnF6OXZPMEc2TVJUbG9udWFJVlljN21OVUsrZXdFN1d3VituU3F6?=
 =?utf-8?B?VUlvVEpvUE9QczJGczFRZ1B6WW5XbDNPWnV5c0JGNHh2WjUzeFBSSHVuVVJR?=
 =?utf-8?B?ZVZvM2IwUkpwam9mWlBHZktYMlBKQUtjZ1I5SllyRXJpSEV2ZkJjT2htRXoz?=
 =?utf-8?B?Wmp5Y09oNksvVnNtbWpKV01KK1RlOHltU2dNa3MrMGNlZHV0a2VzRE0rRmRC?=
 =?utf-8?B?WEdVUzlyQVdxTU5yemJqaVhJQXdmaEszT3htS0hlRmNWMVZzaWNhM0ZieDNT?=
 =?utf-8?B?NFhuTFo5R3pHeGJESEEzM1NIV3M4T01uUkpFM052OFpBZk1QRXJRRWo4RmFX?=
 =?utf-8?B?T1VWM214aENaaTVlUTRZcWlxNGtMSkVGaWU0ejNkd2hYZmRkMWQwWmtDd1Jw?=
 =?utf-8?B?VUh6Z1QybSs1bktodnhOSllLNGhscEtSb05pYUtKQm9lUTR4U1l1SmxJclA0?=
 =?utf-8?Q?MRjNQIcrIvr6mxUA/d+X5p8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z1/XUz0oh3kHespN5c2LrLWCdVsPjim4oGOMOurFzQEO6j2GbMUBSQexD+VbQlV8b7dDb85fS2o6G/EW4invmiMi2FI5TWllsfTIkV2SQPyrpqvffvbBDti8mE04DD5D/RDhDZM9IlBVnz7chXvpGh9hAHQnChEVvtzdX0cB8H6lFW2lEVUxSDfEjIjtskQ1vnmeqS/0BKWiZE0FbxJ1vQSSnX6a5g+ASlIRYSG0PXYtz8P9XGFxC60wE+d0B7zjuJEEzgzM6F3Izww/eXKInmjhXxRAxVm5CQ/uGy35EGs/LjdSrAzOiKaW1jbywy5sgyCasD71yBmyw94ZObOk02+Ci5AvzQNZeconuCdtcNVnxFOYIS8v5+o49On9qW+g+sYewUtNUmRl1gKyPrjj4QUcsArMD86OBOQGNYILMdOnuCUektINPVOzPT65L21YePA5TSIqjVTcY1IeD9iSjAd/EdpNSfiNCpUXGbAmbLsZyLDC5bK0JasJjbyoDXf/xSxrHVzm/Q4/mcbtbk4Bga20o8Pim9OuZ4/NqZ+1gUFHJhhbxKExufmDjU3BJqGyG5bSS85lTq0rPpHHeMNTDvIY0t+iWhacKQ65tlZ+rh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d63cc19-1be7-4f6f-93e4-08dc005a7962
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 06:19:36.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72AphJRUc/S+cmuD5EOnh7TinK0JPF0IfWfoDlJ3FfsIjYaoSD5HhHq3vFjvnVFcplyzPWQ9I1gWGRRajMsX6PWq5QmYyyptJEY8L7QhMxNhOj1wJhBf2mMidNDv2yx0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190045
X-Proofpoint-GUID: AVhS4lUxBv6IUnMPqiLzcB4YItcY4wUl
X-Proofpoint-ORIG-GUID: AVhS4lUxBv6IUnMPqiLzcB4YItcY4wUl

Hi Greg,

On 18/12/23 7:21 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.265 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.265-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

