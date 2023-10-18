Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC87CEC43
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJRXs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJRXs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:48:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2413110F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:48:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIp5eT018065;
        Wed, 18 Oct 2023 23:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jZ2ztBDuE1nVqB5i58AwsA3rQ18vsZArxDIvTBOu8kk=;
 b=nlISE4v9CPpcsK343IaC5vETg05gdNQBOswh8Sjl4f4iXo+6oMJQEW8+t993/4zaS4MC
 zjngcKElCBJt7s4e/o8TvB61TuGRj0RR9F5QDK7tFA5S0hlgOCpgOyXgBWizh7nHBl8P
 3/qYIR0UpZPKtOT1ST2aqKDQ0/91kDsQmmmaZT6TUBal3gnJ42dG21VvGolBpwgRl845
 AGRZC13aft1MYfpiUQvkmmAq8QiSoUWBvfm/krJMw98+T7G+vWcZP/eX3Cdnqmm0g6ob
 ZJBpN6MDUof1nxeQG51IFVh6CFImfb7DOVZM8+4Hb1Ykc2UJiN3NkYc0RvdqqSLGKaUW hA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu8wxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 23:48:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ILo3c9040665;
        Wed, 18 Oct 2023 23:48:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfypetkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 23:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbv1sBtKDhkLuXt265Q/S4Z5s4f3GEc+Md0teeAfdKv37MTRZ53fFcplcbhntAbhZpymLjKM09D2hvhXUkuQg5BC/yPaEq0aGHaR9436DNJoBDj8Ob/97csawRRgnOFnikZPQ8H0ZhVKkZRmQbF0Pg7k8xWyGB9OfUyhoa7gsiEcCeHf0BuhIBarrhQBba1aYRdMP4rg/BKAJfyM815kCaqFt01wJ1kCub5bRGZE9yAOxD2ZBY9LFhd6X+YNuJcN6o2InTyFdTxXIi+qvPhuzfWuKdzeQTtOHv6LK/WzQ5mlDwo3BMZrFsIxgrqaxOQuQWtFnaLCxiOdopyhmEznYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ2ztBDuE1nVqB5i58AwsA3rQ18vsZArxDIvTBOu8kk=;
 b=WH0rU2X4RNx/fdu5tzxgJykdi1CeY8Mbfa5M5+gAwYdOa9eEA/uTpyreoYn1gNUa+zmnZ5MUEAaKYVE2MkMuUWZkxEGR8Rm2D3p67BvDk/Mzaj0LOAjK50WXXIbbA6/tNBuyhVs95aiT9B+nXfEqjTg3Zn5ilZ+JAm1dOxRsKu8Ajm+hSTpWJ2TQDPyWN6DjajaXDEAfaspkNkEVjP9t4vyvXdd/3qOQXweIN6KIin/h075cPGYJCFE9wxqhQf5tkqYxTZgPz63sY2L/ASiH1zxKHMQG6Dfbn/v6TvwGIFdkUMHp5GoqpT7XR4EFuFmgk17fYs4iMChzX/NPZs9HvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ2ztBDuE1nVqB5i58AwsA3rQ18vsZArxDIvTBOu8kk=;
 b=tnpX9ZZiN4qwy8geK/+rBKBj3HMeleA5sWsomuPyfPld9FN9AOgVLwUbg04o7+/bffDWFUCYJLWuwg4ZSHTlWXyeKcuvBPmJbCIR/t6kpopWw/5yPY9REjjKbYSDDEV8E6nf1t9Z+wHLF7f1dOkFDilTYKv2L781hxJu7UzPBsY=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 23:47:54 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 23:47:54 +0000
Message-ID: <171a1147-2099-46da-81f1-fc953e9410e2@oracle.com>
Date:   Wed, 18 Oct 2023 16:47:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 PATCH] vdpa_sim: implement .reset_map support
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1697605893-30313-1-git-send-email-si-wei.liu@oracle.com>
 <becui44lhdptriz4ds7r2b22kazofwo7i44rydacjssnwb7mrq@f6sa74zjhlfp>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <becui44lhdptriz4ds7r2b22kazofwo7i44rydacjssnwb7mrq@f6sa74zjhlfp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0117.namprd02.prod.outlook.com
 (2603:10b6:208:35::22) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f01ccf-0cfc-4c0a-11dc-08dbd034a527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqHGu/F18P4QNjZzZHg3YUssHiOAjt7EeJFqNAMdab7h5qWD4FtQCo6QApNSzFwNxtKTFtuLvVLqC/rcknw0VYA5n2AcREtRQhz4vs4Oo6H3tiPX3RgMtuGUkn3fyMwdWFALrA4cbCNq0dbWrxDorrsh2HTRyUhtjmBJUi280BaOAd60HiqettIn5iiZ4yyO94IwKuPeD4qwD9AQk5cuh7laBQErDYD36XMzLC54r7gQnb05PGXUs4rtvIGdTkIAlWzR0CT5djP7yoU0cXT9YEJBxUYgn2KplSutjs6Vnmd+Oq4mj3EIw5pzvyfIbzUg8unETvXdJR9Vda5ueJQ30TENIDM/bKI3c1Gm9r3McUEW4LMKDIM+k1myy1zArjQrStPscrMzydxnjUzq0s5St05n7Ez4ISnXTjM8cTIkXcPUHRyN1jAqrn9Ay9fxDNucgjBok+hQX92kdE/Oots6kBKqCBfHy6y1acn84dLEWA0gNkcNr/1tV8ONcENBNoiLYO0TPuqqcWS7dWo0F5YRaPpuBe0yYgVrazJGfhZ5WzRpln2hGkaic6vIVjHFZcYCcu2vKKmbBh+V6kU0iIIKEbFif0/5iRp5qLjdfrAI4x4tXZqfWRc8yf/nfivvEBJFrQyI5OMPemB0IGIKE2t7CvE1GXeNjo+4VO8xt9YthR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(5660300002)(31686004)(66556008)(316002)(66946007)(6916009)(66476007)(8936002)(478600001)(8676002)(6486002)(966005)(4326008)(38100700002)(83380400001)(31696002)(6512007)(86362001)(2616005)(41300700001)(36756003)(53546011)(6666004)(6506007)(26005)(36916002)(2906002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVc4dFdhelZvT2lKblR5L2FtaXlvNkdVeVFZYTdicXBLckNaWGxUTmhVN2Vt?=
 =?utf-8?B?TzhWZjBNSTR3ZldtMjVwRXoyL1Z1dWpnbExvdXc2YXFQZ2tpQU1WY1Q4Q3pT?=
 =?utf-8?B?TGRFL0Iva1pTbVpKZ3JaV1RsVHRTa2lTcUdKUjlsOXdtWER5Lzg1MVVVZHNs?=
 =?utf-8?B?WlZoZ2EzZDEzUE8xeUx6YkQwS29zZ1BrT3l6M0lVYkFzVGFvVHVvMXN2Zkxh?=
 =?utf-8?B?WWpUR3dFU3Y0ZWdReGtYQW9BbWJ4RmxPOUM2dmtab0s2a0w0ejlwdk1Taklj?=
 =?utf-8?B?Wm5hL3dhd2ZMQlBmVFpRa0tWeW1PR0s0amtVenBjb2dLbUhON29BL1B2Qldh?=
 =?utf-8?B?Y3Z1VUZnaE1rY1BvdXc4MC9weXkzWG1mcEZPZzRMODVvb3BrYW9JK0k1Rm95?=
 =?utf-8?B?blYxaTFDQVlocS9vcmowVkJES0ZMUURSUXVoTzFsV0ZkOENMVVQ3L2FBT29H?=
 =?utf-8?B?Ujh2Zk4vOFB3K2NBMkk2QjFKY2tMQUdIZ25PWXJ0NjFnUFZOT2NlcE1qMDNn?=
 =?utf-8?B?TlZuTENkWEtyY1FSSGRBYWI5bDlnZ1JFQXd6L2IrSzBWMFJSTGFqMnRncndt?=
 =?utf-8?B?c3VsN2V4dnV0RkNhdGdJNmJhV1NvMVNVMnUrT3p2bzZ0N3NmSkpWREdud1h5?=
 =?utf-8?B?ZWZ6MExMaHFzM3hjVG9rYWszMHYyZi92L2RzMU1lMktvbFZSZXdjcmhvVFdm?=
 =?utf-8?B?bnFtWEd6cWV1MU52ZnF1N0UvZHlrNStVeER2cVUzWmFyMUFGU2NnSjUyVkJp?=
 =?utf-8?B?S1RsZ2hmMjM1QWJnbVZiVU90bnBTK1RzeXRMSHQ4THNYSVBHbFdWNmFFTUtm?=
 =?utf-8?B?ZlllbktNeUU1Q2FQWDY4ZG9nYWpuMGNBcFRmNG9OOGIxVUJKNnE4MlprMmR0?=
 =?utf-8?B?VHErZzF3UmYyTEJkWDVwN3FNbGFvdU5rZG5KeGZ1RmRWNUZlQ3orKzM5S2k2?=
 =?utf-8?B?N09VWkFIbHM0cFZQS09JTXpXcGU3L2Q0aFhxdDdxeWlyL01sTERnQ2krcyto?=
 =?utf-8?B?Z3hETlhlbXJVNnJvMXJxMzlFWENpV3l3NFE2c3piNnhrRDdVa25ISFJoTUVQ?=
 =?utf-8?B?M01GaXVXRzNiNlFvbFRPeFB5d3Jmb3ZOdXdmVFBRcXdXRWJTSjV4alZpaEpo?=
 =?utf-8?B?eU51OVdBK29iYW1GOHAvTEdXejd6VzlvWUJKbG42VDM0M3B3bjJ3NVZqN2JW?=
 =?utf-8?B?eFh4c2ZhSzVJcWZDb0QvRE43a0MrY1Z1WmxmMVlMV3FkVGEvckl6T1o2eExE?=
 =?utf-8?B?eVBwZUlyalFmaDF1Nkx1SzZtUUM4dmIzbVY2OFhQNWlEQmVyOTBFWjR3UU9a?=
 =?utf-8?B?Y2lWVXBFWXZGdjNHZDZ2amFQNWlnVDdYdDloQys5eUM5LzlKRXZJM3dVa0oy?=
 =?utf-8?B?Yy9ZUlhEQTRNMjdROXluVGJQSDRHQzBVOHU1Ulc0ZG1wOTBHcFNwaXQ4cHZB?=
 =?utf-8?B?cXV1MHBmQTB5TzVVa0UwRkh1ZDRnYjd4WXdPbEVydWV6Nk51MnFrdUNHT1Vy?=
 =?utf-8?B?ZG5uMUt2cmdNV2wyejBQM0lKVUQzSXRSbkdPOHI4N2xEbGhOSXpDSTZHZFo1?=
 =?utf-8?B?cWJBUEpTcUhnMHU2Mng5Z3NKYndQWUhObjJYRzI1cTJXeFlRMllMcDhJc2dB?=
 =?utf-8?B?K2pnVFA2bTJyd2NSVGVEQjRlUUhSVkROV0JpZ2FKT2QrNjhSOHV4MnYzWjk4?=
 =?utf-8?B?dDV5QTBoUDZvc3N1MDIzSXhPbHZObm00RU5vUDdLaWtwSTI1cE5mUThDWjVw?=
 =?utf-8?B?Vzk4a2NiNEhUQ0ZrZHk1WkhpdzFFQk1EaWVxYll2TUt0alY1TXFlQlNBYjZI?=
 =?utf-8?B?UW9sYkJ6cVVJWHUyUzJvT01FZUxpWFpTSkd6Z1oxUDY4cXIrY01RWHFTeHlM?=
 =?utf-8?B?dGd2YTRRVkJYd3hpbGh5UzlGSEhZZFlLR1FGU016a1pjU0ZWcFc5V2Uyclh0?=
 =?utf-8?B?azBLdXJtaGp5eVFxeGhWWXRlMUNzNDBnM2I4aUNQQUswZ0NheUtueHNWMy85?=
 =?utf-8?B?OXFGSllWMVhQWGlPVXRsTWJPbUNvOCtUTytsYi9hb2FEU3VHb0tMMzI1cThI?=
 =?utf-8?B?RjZHT3lndzR6YzBpVDV6cEpNb2VOT0dWNTVNWTd1U2laUldWaXVIRzVWT2Rh?=
 =?utf-8?Q?DsYtELc96Tr3I3JwQ3FqUG9hC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NOFnaL88h7NeDs9NQklBK5O6GMOu7Fqf6pDn/F0U6xpZFqyIa0kVvrqSpFsiS0Efa5tuWQDboDvucz5iNzM+sJb9dw3s7rImImh56UnLYEc0kSVfDf+w+YkoXrSn98gJpMxC/ab57UowGiY35EEHLC6CGKFgFlsJvasLlEsW/m9FgYPFa/7yBi5vJ51plHgSVu48unkX6S8ZUfSVcGmhC/wSMmNLTymJYmtbsGSkpPWdkNyczFCI7E0pzn4FVarrjE8pVkO0lZp0jQpweBymNS7w9MI4pFvANXsHSZSDPJjOMxcofQtGm9Wt2EHIlJ+guCvvhAaiJXHSNRQ/ynuNa/uwJ/J4hHsGGvdeKfX89IHhBZVh8qx7dufbxC7Gu3hoVqEsPUd99Yrnn+TWrzE+z7gYH/6DPROx9X/CGEUHZU9suUjtY4Seuu1XenWzgwv4XuoilrxKI4a1oJ9DL2X8KZ/bVMkIjwI5HC14nEr9KkVgwPhnHgyUADv+32hhF/sOOdYjmIVE57uTtXW3ZeDEQq3Nyff5nsmoGRFCtpd4MAsN8KElmZ8rd5Rpmw2UQz2h7fI4decWMIQbrEgKoZ2kmz7SDjXiz34+slfqLYdR9p4HnqY/x3CBrv9HeTOb8ymlWXIqc5Yq/SzYjZhCLsqcme0wYnM5DPiQpjdUKFmJFe4/mTq1irFKwmPywu1oyRBizWTpTENGsy5VOPtZ4yy1+Ik6ULJVuX5QXWngeIF0UXIy/GuAyl40uZUAORMRyyLwcpGUcPOyEpZOTrP3JzcSalP6np5KckZe/wEQ9Y3u4wiWjj9cTShHkyQ8U+GuesLu5KYS6K2cvy7RrFD585ZVMcBmHBrVr/JJ96nPZoGkfOtUwbDM+k+46BgVNfXWXl9R
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f01ccf-0cfc-4c0a-11dc-08dbd034a527
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 23:47:53.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9DjPsK6fpjghp+jZENoTYum2naPwzBrMrTFLdhq6fJ5yzKEI619VGzsevLkc6Gmt8xDoRo0Fdcvbrl4loA7PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180197
X-Proofpoint-GUID: MxiAhUpqLFcoK8qyRC2OyzllKxIvt1If
X-Proofpoint-ORIG-GUID: MxiAhUpqLFcoK8qyRC2OyzllKxIvt1If
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/2023 1:05 AM, Stefano Garzarella wrote:
> On Tue, Oct 17, 2023 at 10:11:33PM -0700, Si-Wei Liu wrote:
>> RFC only. Not tested on vdpa-sim-blk with user virtual address.
>> Works fine with vdpa-sim-net which uses physical address to map.
>>
>> This patch is based on top of [1].
>>
>> [1] 
>> https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>
>> ---
>> RFC v2:
>>  - initialize iotlb to passthrough mode in device add
>
> I tested this version and I didn't see any issue ;-)
Great, thank you so much for your help on testing my patch, Stefano!
Just for my own interest/curiosity, currently there's no vhost-vdpa 
backend client implemented for vdpa-sim-blk or any vdpa block device in 
userspace as yet, correct? So there was no test specific to vhost-vdpa 
that needs to be exercised, right?

Thanks,
-Siwei



>
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
>
>> ---
>> drivers/vdpa/vdpa_sim/vdpa_sim.c | 34 ++++++++++++++++++++++++--------
>> 1 file changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c 
>> b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> index 76d41058add9..2a0a6042d61d 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -151,13 +151,6 @@ static void vdpasim_do_reset(struct vdpasim 
>> *vdpasim)
>>                  &vdpasim->iommu_lock);
>>     }
>>
>> -    for (i = 0; i < vdpasim->dev_attr.nas; i++) {
>> -        vhost_iotlb_reset(&vdpasim->iommu[i]);
>> -        vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX,
>> -                      0, VHOST_MAP_RW);
>> -        vdpasim->iommu_pt[i] = true;
>> -    }
>> -
>>     vdpasim->running = true;
>>     spin_unlock(&vdpasim->iommu_lock);
>>
>> @@ -259,8 +252,12 @@ struct vdpasim *vdpasim_create(struct 
>> vdpasim_dev_attr *dev_attr,
>>     if (!vdpasim->iommu_pt)
>>         goto err_iommu;
>>
>> -    for (i = 0; i < vdpasim->dev_attr.nas; i++)
>> +    for (i = 0; i < vdpasim->dev_attr.nas; i++) {
>>         vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
>> +        vhost_iotlb_add_range(&vdpasim->iommu[i], 0, ULONG_MAX, 0,
>> +                      VHOST_MAP_RW);
>> +        vdpasim->iommu_pt[i] = true;
>> +    }
>>
>>     for (i = 0; i < dev_attr->nvqs; i++)
>>         vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
>> @@ -637,6 +634,25 @@ static int vdpasim_set_map(struct vdpa_device 
>> *vdpa, unsigned int asid,
>>     return ret;
>> }
>>
>> +static int vdpasim_reset_map(struct vdpa_device *vdpa, unsigned int 
>> asid)
>> +{
>> +    struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>> +
>> +    if (asid >= vdpasim->dev_attr.nas)
>> +        return -EINVAL;
>> +
>> +    spin_lock(&vdpasim->iommu_lock);
>> +    if (vdpasim->iommu_pt[asid])
>> +        goto out;
>> +    vhost_iotlb_reset(&vdpasim->iommu[asid]);
>> +    vhost_iotlb_add_range(&vdpasim->iommu[asid], 0, ULONG_MAX,
>> +                  0, VHOST_MAP_RW);
>> +    vdpasim->iommu_pt[asid] = true;
>> +out:
>> +    spin_unlock(&vdpasim->iommu_lock);
>> +    return 0;
>> +}
>> +
>> static int vdpasim_bind_mm(struct vdpa_device *vdpa, struct mm_struct 
>> *mm)
>> {
>>     struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>> @@ -759,6 +775,7 @@ static const struct vdpa_config_ops 
>> vdpasim_config_ops = {
>>     .set_group_asid         = vdpasim_set_group_asid,
>>     .dma_map                = vdpasim_dma_map,
>>     .dma_unmap              = vdpasim_dma_unmap,
>> +    .reset_map              = vdpasim_reset_map,
>>     .bind_mm        = vdpasim_bind_mm,
>>     .unbind_mm        = vdpasim_unbind_mm,
>>     .free                   = vdpasim_free,
>> @@ -796,6 +813,7 @@ static const struct vdpa_config_ops 
>> vdpasim_batch_config_ops = {
>>     .get_iova_range         = vdpasim_get_iova_range,
>>     .set_group_asid         = vdpasim_set_group_asid,
>>     .set_map                = vdpasim_set_map,
>> +    .reset_map              = vdpasim_reset_map,
>>     .bind_mm        = vdpasim_bind_mm,
>>     .unbind_mm        = vdpasim_unbind_mm,
>>     .free                   = vdpasim_free,
>> -- 
>> 2.39.3
>>
>

