Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0878CB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbjH2RY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbjH2RXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:23:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374C0CE2;
        Tue, 29 Aug 2023 10:23:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCCbir017691;
        Tue, 29 Aug 2023 17:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RaWo1eAnZ0dbHSpR4cbHY9dnnOF6oFxo4i1v0llsqqY=;
 b=HaIB+b+zFxosbv/WGccn5TcRx1AbFg4va1RI+Lz7/YGT4wIGRAThmqlHH89vA7iCIYHx
 8LvoPaWulYBZ+uaD0MAJ2ksMfWEjmKQTMBzi7hPGeN0qu+9YKnU5TTZ1H1+dJqmeT67j
 0+Dg203O08HkgNH+BnD21oXwuwyPor8hxzl09++YlRwk38E6Vq3C7UlLGFvCLvonZYxX
 GHCF5SF4t0IrUL6mouOU9SUku+L0eYlvAD32iuqtR5fF/NL/OuAQRLFsMikJK1WQzKBT
 /tWcGBbXbZLFc2POrUQZhHhaHUhgSpd3Rp/hmiQ6nhnUOFvAzfEvd0Tt5v8VzdqW6wve Dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9nywfj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 17:21:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37THBUZT040617;
        Tue, 29 Aug 2023 17:21:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6mneaaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 17:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kg/3LtCXVXuusulzOEkKxhHoPflepMaMZRtLCWn0EDZP4Rse3kDKDvUq9pu5Pn4ioeoXSAiJlLfRpNVabgPm9QiEt10kJU9IbLAX8ObgcEwcdTJW8fhjnTjor7rdbcQKrDjM8iLCrPdhUm/VW2D/796m5GNNtwxmU5X1i2sdTMLo20/o562Wh+XKqPeWXu9GSvEH/BFaWE1ogdKFIOgeyG0gcoWn0EEz/S/q3PXA+W+Eob7Gw9jNKurZliVO2zJVwGecaETAtaTLyzTclUNeAZWjC5N6wGY+RiHMPor9n00WyKfH5KsVj+2VU1K+DYMS/JDqRw5FuuMX0yA70T70Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaWo1eAnZ0dbHSpR4cbHY9dnnOF6oFxo4i1v0llsqqY=;
 b=LOZWHovarcyq1U8ZGQE1x5SDL7YPwn4gJzsj2WKfbBvEel1HzLRfi+Kcg4xceU9FToM34W0r54YsiUnRNe3NeSsyQhaFt3qkZmxVTi7tI7PcGrcjIdau93inRu+fKs4Pcm7LM54+QO0NorBgILZp40IJ3VCAVB/l992eK6NXL1UjKuongC04A7+u1JLaxMkphsOCwxBE2iuODzPghBOI5dfN1X9CZsid6BNgTH4a/bpZrGioxk1HDacRS8hYVXmNKop5mO3fdYhO034hKSHLBuozTOA/8mBsIWQg1kJ81qfguHmEOsIIb4G2/s8fZ5jHRUs75+CmYSE0tOZhsC61Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaWo1eAnZ0dbHSpR4cbHY9dnnOF6oFxo4i1v0llsqqY=;
 b=GDE9t3A4lxVkanaG1U7ZVvu9vHud4lf8h/VNndHFuPgn1zblyaDx1+qt0SbsuTp3E/J4RJ+1yhFcSiyVmA/3BQRURJa9d4MfZXWKmnTfJ21vNNtiXRblTghoz4B4g+q2nB8M4bzcUJlsyCf3oqz8zOrjz3LZ0Jd5+jHkBLjSRCg=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by IA1PR10MB6878.namprd10.prod.outlook.com (2603:10b6:208:422::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 17:21:54 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 17:21:54 +0000
Message-ID: <6974c489-3238-4037-81e5-3d9ec5e48ee0@oracle.com>
Date:   Tue, 29 Aug 2023 12:21:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next][V2] jfs: remove redundant initialization to pointer
 ip
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230818150210.1208746-1-colin.i.king@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230818150210.1208746-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:610:38::44) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|IA1PR10MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: c4da2499-c0b9-4776-eaf6-08dba8b470ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAF9F3Zu8LNz8u+KHbIQpa6gK3fhK5aQZKwSM6Nfbrpchg8MVDbUsQili7SN7/cn3P+BrvsZwlVUvAVMXYMYlx6lfptUJnqA6Qw5KLieDqxa0QbbDsjFy4F/YcHd1tL3SaGW7f8xiSSCyjSrj1nNdlEyi9lyjATQpbegnpvCxNuHq0I0mT2tCkfyjC077eqGWP2a4UiuqZ7t6jSmUZIBQPq3ku7QKxSmNBMGgkeo0Gcv2wXvyD+DGHdwK1lIZzvYdZbsVnuATBrAILzIHQ+L9n60FQX9Ik32jbKtjo8yCDJjEkS8L84jKUEwUUBj0JXVVU2+cBJ5QUvRy2b2p11AwYdVgfG7w+TtjRUas29618AmBlULl17dGigEfx4F+Y3iPoSKJ/IVzoC6FpFHJkEz6fOKVM/YU9WfMy8fyTEjwszriNGvfABe5nqO+CWKj4bMJ0PRxuS9dKiAJ2k7Aavx0Ka9Q25JawA+Uk5AHD/0mUUIfKer7/0GSh8HRlH7ECLgzg8+bmWpt9hxNEBR//ze4sQO/tkVps2qhUDhKVRidvymcWgzvHb/P52vmavwjT40x7cSbF8hOfs3+pvf3u1BlYS3VIItk1b8jirT5DLLgVDNLZ4/tZcTov5nY6p+CvkAEsyF8vxyTBeG58AOEqfi4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(66946007)(110136005)(31686004)(478600001)(6506007)(66556008)(66476007)(6486002)(316002)(38100700002)(41300700001)(6512007)(36756003)(26005)(44832011)(8676002)(5660300002)(83380400001)(31696002)(2906002)(2616005)(86362001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S01LVER3NHpOY1cwYVRSRW02MFhEYVN1QkdMZnBPRTFyOU84MzcrQkRRd0Zp?=
 =?utf-8?B?T3BTek9TTXFIVGZaUGY0eC9WSjh6UW5Lc0tNbFFHR085aGlpaGhtRmlrTUlG?=
 =?utf-8?B?bjlWTkwvUDBmZ3E1a1ZIdnE3eE1TcWpmSHJWdlpRVDRUZzJ0REU0OG5rQ2tz?=
 =?utf-8?B?OWhmZGJPUXN0U0Fab2tpL0RBaDg0Q1RIQ1NKeCtWejFQalhhSHkrZFNtQ3pX?=
 =?utf-8?B?MkRQTEMwUStYSDduS2dnaHZKTER1MGszRzBGVlRoWExVTTFSdDdzS2lQNVNo?=
 =?utf-8?B?bzIxL1NlZHlJQkVZUm1JZGlQY2RDWXh3UlFjVFlOcldoT3ZTSmlvNlRUUlh1?=
 =?utf-8?B?dEVUQzFMcFVHVXlVckMrNXp1WEcyS1g5aWhZdXZJaHhpVmpxUDUvVk02aWpG?=
 =?utf-8?B?ek5oTTUwaEtrdzdoOERodHZsUHdkVFdYYmREbzBYMFFYd2tTVER0TGlvOVNQ?=
 =?utf-8?B?b3ZpcHpTbkxoMlBBcXpneTdGRjFyWnNwME1YQjNSZzJzMDhmMXRhVGV1bmZW?=
 =?utf-8?B?QlczMGxPeHFtNGRUSHUybFk5cVI2Y1lDTWdLbmNwY3M2Rkt2OGVSdkxGaWhx?=
 =?utf-8?B?WEI5QStISU0vY0psZ1N3MjZncmV3THBVRWJQOVdqdnQ1eGlKZldkM2VSUnhM?=
 =?utf-8?B?NmE0SGk3NmgyMGp2ckF4U0RWN0cyMi9xNGxsREd5RExhTmYxM1lUejJkTHM3?=
 =?utf-8?B?NGRHb1NweUF6VXQ5Y3BzSnlKQ1BDeFRFYmRiVHZEMHdKOGFieGZpKzJFemhz?=
 =?utf-8?B?RUhLSG5NNzJtWDJHUFpJUEVhTzI5aTlPRW1HRnB6bUlJam5GSGtiSExXb09M?=
 =?utf-8?B?bGZGeUdaN0xOemhTU3pvcG1oK3lNb3BDRUR3dVVpM2lnc2tLU2RpbmtkejFV?=
 =?utf-8?B?bnZEbXpKR0gxWnVFN1ArMzczMVlzZWpqMDNjeThyQ0RuaGZNZFZ0K1IrOU5U?=
 =?utf-8?B?T0hDcUZ2Ynl5YmdzNVB1VUk4aVJWTkQvY25nKzNMWldPUnQ5dGdHeUxBaU0w?=
 =?utf-8?B?cjNlam93K3ZnaTV6S1laZjk0L2x2R0UyL1RMeTVBTFFpMFZyNWt0K3p3VWd1?=
 =?utf-8?B?TFZWcE9JNWpVSXJsaEhLd01zNlU1ck9tdHFVL0tXNHdvZHlzTFQyd3d5OERG?=
 =?utf-8?B?RCs3V3l0QWxId21mVFlVc2tmWG56MmhYcGNpTE8yaHRVblgvMGdPa1lHSTVH?=
 =?utf-8?B?Tkp3T3ROQjhKOHRwVk96NzBuSE0zbEs2VWc3c2JQUFJKY3NhMW92ZHNvNlJM?=
 =?utf-8?B?dmhSSjlVVCtFNVJVbnI1aU1FMnhtenFPYm5rRlY2SEJBR3NKVkx2UXJXcGpB?=
 =?utf-8?B?V1BNUFB5WXMrd3czMlllUkFYM29qdmlVZlc2UkEzRnNPQWRLUUlGbnM2anVD?=
 =?utf-8?B?ajBxRXJPd0hma0Z0UmxLSjA0YjFhcFd1N3dlTW9Od256RXViTVlTU1Fyb1B6?=
 =?utf-8?B?NStiT09IYkZRamlmSGZ4U3BVOGphVisvc3NlNzJ1VU9DcWxDUGNwOVVmVEFZ?=
 =?utf-8?B?d2VsdHNiZzlsTlhEeXFrSlZnK3Bua1V3dUN3OGk4Tk5DMWlxT1lEekZEUG95?=
 =?utf-8?B?VlhJdDFWMFJqZ0wyMFJuRkNxOEdpZ0UzcmlpTGdkdW8zWGZmUCtUTWc2bDkw?=
 =?utf-8?B?RDF4cFd3N285NVFJSG55S2RWYnNYY2pzdWJCM1FES0JPOGRhRFdvcEoxeGQr?=
 =?utf-8?B?WDdIZGU0WHZqTWhvb3JiSXlUZjBRcHdrZzc3OW80cGhkeDJEZ1hHMHVCZFB6?=
 =?utf-8?B?Vmx1MDMzVng3WFRvZGhONFZodU51enhTSGU3aTA0RjJFdnBueUxDRDhhN1A5?=
 =?utf-8?B?UC9mcExBVjdkVnltNzJnSnhab1lkMi9qbk45dkt5SFRpZUdXRmw4SFQ2RUV6?=
 =?utf-8?B?MmV0WVhFR1hhaWRLbDh2QURUSjVOTnNQc2JwMGFJYXJhZWVMZ2Nxek5wRzFM?=
 =?utf-8?B?N1k0SyswQWFSUjRLZHFuelVSZENaNkpUMnJ5Y1YrTU42VFFycDRESVZ3SWlN?=
 =?utf-8?B?Yy9ZQUJ2aTByNzdLNjJjQTRaSUlwYXpWemg1ek5iK2lDSnVHQkNXd2FkK3o3?=
 =?utf-8?B?NkV1WnI0VzBzYUNHRDQ1MnowaWRUcUJLRmJaanVkK0Q2UTRERkQ2YmpQOERG?=
 =?utf-8?B?MnhnSVJGNEhtT3laY2pNZk1PVEhLS0VPTUZHdkZDODlub1hqekJ4SUFwTkYv?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y2hl4eFH2Q/2SjK0HA2c1CTiPHvEhMXw49fAXGr5ypTrHJnRyLuvwhaljPuqhkSk3QIs+SKyxJzFPkIlixLdsMa4MP9lwMfkDXI9Hj65VtTt/AougRwVwr9F5vjk5oFbvunc3RdedgKhi7jNPNZgJZnmZAurxJswdOUQeSTDuIh4+S3r0qgSzLkAOkmUrZ4E5wjDHPCGunQV/bYoPFwdp9fxRMS7KUIy04nenZaovsK1+EfPbJNyO5xT26shLLLY3bLNJ2iga2cuJ/JrElR4KmApmKvhDl+IJCDlz8hBBK9EFqwjuS2WgOeMvnt8tuvBIq9S+jqBmF7GXcHAKtvKgrKTqYkBV3t5wbao0+Im6pdhvJnOPmx5ZL2M09mK7rfmr3AFMF45RtOogGRHbgvhnonFNYNWeVAcmDMDxVlbF2SztYmWC0+3vPW2UySbB5lNADWpN/Zit/H7LWkwIyH4L3PwH2Jooj8sKMUxvq8CY6SJ85xKdX9QBQajL4tml2VYFf0khk3IFxVDSNwYk3kOgPCvdq9zcC361Qm38sjdU4uO1MUQGU173pZ+8LuFR3o9m+bLkm2pOxiKLfWgc9n8sZOOVUbJ3PC/Y20JuQM2zEoXS7HkVqWQ+a+oHw294S2AJfLyb6srLhLHl+lXYTX/DyCpvUF17QFPViT5JpNE2ES/9CKMXhl0o6bl9LZQEAuYkLsgBAig8JWapPNZb2mquufIQWYEVxvIX2OcvQRueGot5jAnwcAEe+bZkYjLhQ9Fwg9XHe8C5BmTtkxaGxSzJtVQJz5fcoIPCqh0whxRImpGCiNnvG/8KMhTrvShgG2aG62/0kBWZTamw73XvA1dcDO0q+Wjg0FBQXryi1aihJYNxXv8jCa4mZOoJ8hPkFCZ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4da2499-c0b9-4776-eaf6-08dba8b470ac
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:21:54.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MRTp8yfbrAXUmt/o4e3OXdeDhx0uoVMiHWWs3Q8v768V6ECHEKdtEPUK2XoRGt1FkeGJjzGAniGLDYg1uAJ+3ggE8Vmjkm3xYXiP7PHPTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6878
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290150
X-Proofpoint-ORIG-GUID: 2lxreCWwlxGNVFb2Iyvtggnh8PtLwi-P
X-Proofpoint-GUID: 2lxreCWwlxGNVFb2Iyvtggnh8PtLwi-P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/23 10:02AM, Colin Ian King wrote:
> The pointer ip is being initialized with a value that is never read, it
> is being re-assigned later on. The assignment is redundant and can be
> removed.  Cleans up clang scan warning:
> 
> fs/jfs/namei.c:886:16: warning: Value stored to 'ip' during its
> initialization is never read [deadcode.DeadStores]

Looks good. Applied.

> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> 
> V2: fix commit message "uninitialized" -> "initialized"
> 
> ---
>   fs/jfs/namei.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index 029d47065600..57d7a4300210 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -883,7 +883,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
>   	struct component_name dname;
>   	u32 ssize;		/* source pathname size */
>   	struct btstack btstack;
> -	struct inode *ip = d_inode(dentry);
> +	struct inode *ip;
>   	s64 xlen = 0;
>   	int bmask = 0, xsize;
>   	s64 xaddr;
