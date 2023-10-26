Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DDC7D7D87
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjJZHTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:19:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C981D6;
        Thu, 26 Oct 2023 00:19:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q3VO6u006370;
        Thu, 26 Oct 2023 07:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BGjJ1O5eH94b2SKTHE9tjpzYHEhBbkwcPy/TDp/dvQw=;
 b=HdjLBK5Tyrd+JILFTqCHBtEk/omQzw/gI+68AIywNzD2A9N63rS/3EZob7A8paxeukWp
 VsAoWdNJMyYygU0032dMSHSieOFCgjs+WGajOiC5DmSOT1tqehzcjXIe8lTeUhPUY91d
 cvYrz9YDEtwroK/IXfhNkhA1Ga2L25+pcEJSBBUBAVWTsAuxTgCrK4Ll4jD0nSx2VeB8
 pDtM6YJ99f2plyJGXFrGQjlGlzKDQwnIGvVf8HkWS53V/SU0vqdN2B+MWmS14CgyB6Ot
 yAkwugq0mSBStuJpZJmEs4TBUfwOUMF+JZz3U9NF3piD9EN5BdUJFs6msJ51aarefyVc tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581taxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 07:19:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q5xUcj031109;
        Thu, 26 Oct 2023 07:19:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53e9x0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 07:19:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWO50q09rWsXOs0s6oejsqJ9T7UXfmA4Qjy8zyNrBIrAOwGWbCocBVQo9/AqkMvJoLwSfL4zpagDQhfsQtG8/XCDwjHC+vHXNlrJrG2XvxXNg36z/pdU+cOwZxqKbSfUUmHBDWEQJpEkOgRh+cYcbd9DZzFtKFFjgIlN1wyDmWPCo+ycObpA5AooxffgUL7AppQxNhohVWiq7ILqRw4rbvcms2WM2H/EneqZxT8MTp8mO31Eni2Ld4MaWvM3MzaUL8LXtuivoCy9vAEtTq/4F/MVUtcxjKk8Vj48+0D6xF1z1NaCqNAQkB+XmuqOsh6xC/V2QjGBABjv7lmU+iPmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGjJ1O5eH94b2SKTHE9tjpzYHEhBbkwcPy/TDp/dvQw=;
 b=iGtIWcj69EK7mHs5uzinQDb02CEZZaT5hawT44XFb19b9GWL6iFtw4CqWIsIJvM0zbjVul47i+DgI8DsRgph54dxgd4j3xVVC8VbvH2hHEbB/wElmuKLEQ5gGIG7FLY3iHGc/OG0oYtTE/yicBndjyejQlrXJF/Hc0U0eHWJB6JVI77dA5GwVy3LXRrKcaX/vISxD8vF0ifJaqakQPXYzjoap6Ld+h9eZk6vLlipH7jxc5hRHvpsI1kV++CsShyWnoaU0NfxQ9BTkZ1NqTu9oZsN4lErOvt1HiKHuMSrBNDKRj8TZgN6zvqHljouwRTCGGNrCEMAT/RdEb1YyL2zow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGjJ1O5eH94b2SKTHE9tjpzYHEhBbkwcPy/TDp/dvQw=;
 b=a/skYYJaFcX9ADaz/YWevZPtIWCzjosmBgSBXmkkoYzwHjIbTRNTGoPQYTZWhCMR+bwJS5mjUi12V/aGJT54chr58kCTdFPxiQFU+6E64f9X6I/Mw7KDBZysm4+WiEq+T17wRyXDLxaQh5Vp2DMrqTydMqmj0g929vJvP3YZXow=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 07:19:36 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 07:19:36 +0000
Message-ID: <489dd10f-928c-4479-9633-59eedf9b60dd@oracle.com>
Date:   Thu, 26 Oct 2023 00:19:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-vdpa: fix use-after-free in _compat_vdpa_reset
Content-Language: en-US
From:   Si-Wei Liu <si-wei.liu@oracle.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        sfr@canb.auug.org.au, leiyang@redhat.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
References: <1698275594-19204-1-git-send-email-si-wei.liu@oracle.com>
 <20231026012326-mutt-send-email-mst@kernel.org>
 <8f7418e3-816f-4bfd-bf6e-8be68054f55d@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8f7418e3-816f-4bfd-bf6e-8be68054f55d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::11) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8029ea-4eaa-4fd3-fa2a-08dbd5f3e8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1c8OgFatI1n+zi/2H3mQ025bFPsRUAjGdQB6yCZJau567fifgnu7y76kCdOFhrpx4QLxBVGBF9bWOQbMiNuyyerJm2Eh2C/Vp4sTX2cc484HOrFV77Iooq71pTOusNOO+ogj7yT/pmOtiooBssoG8drUzwo09HVBzFcB4HsndjHHI6hy6A9lztKmhxpbOSe9VNbv4TbRRKTyT9bRTnY+19NhRv1L4vQI8B1SIlXpk2WCzrakohiF7V4AGFbPBdiT7xq/wkfsX8t3oe9/ijafUn2wLYYdI48F7hP5g9B1tTyZb75O6aZGYTXKPfbvVII+OVNrFZlMDIRpeVOkIlSGOkAKAN10cX/U5P2xesipPrzDCLffOfTsA9J09+CM68vw1KGH4nkQLWoLn55Rn891UXZoGUPXgsqRNh0FpK0Ow6Vq235hQ0aQxqSWqUo2s5hp+t2HBn5lviFmrMYUAGjVaFEEir3d8E+CFRYPquREQM9s7JT/Tl3yOY8KkWTD09BQjlNVsz6CTqUzAxgsjWO5AJsIb5Zhhptz9ohwr0ZV85ytgl6AH4mhKErJ8zg00JxbRlw6e1Fwg5Spn42XBWRyBvyCFwLjmIFZTYZ+Wonrhcj6nhwuMzqp8YC687u2VOk6Fn2lU93BndsIUtwIuPAaCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(2906002)(83380400001)(8676002)(8936002)(966005)(6486002)(4326008)(53546011)(36916002)(31696002)(31686004)(5660300002)(41300700001)(6512007)(86362001)(6506007)(6916009)(316002)(6666004)(26005)(478600001)(2616005)(38100700002)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9DRFBQUG03L2xsUWt1ZDhVTFp1MDdOWFFLZjZlY3JxNng5NXBScElGd1RQ?=
 =?utf-8?B?all1ZTZmcXkvQzVFNnM2TkpTRlU3aXNrajZBS2J1M0NzVzEwdHVVNHViSURH?=
 =?utf-8?B?NGxEbTU4d1dTamxhL0RhNWZiZmlIa21oM3QzaXNCT0VTc1hFTUxKMHlCaTdO?=
 =?utf-8?B?ZjFtMEp2aTJuSVJ3cU10V1I3RjJkb0FPa09BNGhic1VKUmpGdWVhRmFIVXRo?=
 =?utf-8?B?cTNmdWtNMWZLdW5TbUd0QVJ6SkR6QXRFbUxlL0RhR2l3UnJ5ejFzaHQ4a1hz?=
 =?utf-8?B?Ui9jbjJjL0NlOVN6TUlsVFl2eXAxcExhN3Z1K1hPTWpUWnZ2RzlsSzM3RW1M?=
 =?utf-8?B?V0hXZUQ5VmU5YjlBQ1BBS2FXZlZ5Z3Vwa0dmbXJUSnZMeklVRGNaTkVhVTJp?=
 =?utf-8?B?d2ZvRzYzc3ZRSU0rcThxU0lYOFM0bFZXcTdNODhXZTdLdlpINjlMMm5uWG82?=
 =?utf-8?B?Z0o5RVl0aHlGS21PQWhhZ3VnMC9OWXdTTW1WbHhBdXBtUVdCb1J5ei95Q0E4?=
 =?utf-8?B?SWJidmx5aE53dDdTb1N2bUlNT2FjdStGYm9BRFJtNVJhOW1jK09xQkE4eFhy?=
 =?utf-8?B?TUptY0Z1SEFmRHNCZkZ5K3ltQk5hZm5BSmVPOEdaeUZFQWtuYmFoYmtMeGJI?=
 =?utf-8?B?eS9jclBYaVRsb04zbEw4TkNOaFVNR1RVbUJIaXVxV0picWkwNkF3eVBCM1li?=
 =?utf-8?B?dHg5ODhLaXB0MVFPUDlORmRzU2JaaXFlMVBpN2NNcVV1ZXNiU1c1NVJHM3I5?=
 =?utf-8?B?OWl3VlA5WWl4L2tzbUxpWlZtN3ZtRHlNdHVuMGxyY0JNNm1NdlhyZlJSVTVw?=
 =?utf-8?B?MmFLK3I2eDhWd0F0VEltYWw0TlIreTBZTzcwUS84VktzbnA2K1o5Tm81ZFRB?=
 =?utf-8?B?cmJpemxPeGhTcTFUSWRGMDhwekFBWUtFSUs3VzMray83ZVpmTjF4STdqd0RC?=
 =?utf-8?B?cU5ZbUUrdVBzL1ppaGdZaTQ2bXVDN0NmdmNLRFNCVk9tQWpqdTdDSHpOVUhV?=
 =?utf-8?B?N3B6RmZuZTE4TkswNVlmcyszdmNLZnJWRHk4aEJ1cVo0TXBBak1zNXNIQ1lX?=
 =?utf-8?B?dTc2RjVDMmdNRDBoK3RiTWlsS0VBY0NKeUU0d2VuMW5oSG1kaCtLSVc4Ukhp?=
 =?utf-8?B?aHcveVhUU2FlYjhnZ2FrZUFubEVqbXFiY3ZkcCttc294dkZDU2c0eEUxSk1z?=
 =?utf-8?B?RnhTVWhYMmFQTG9VN1pmdmZlT0RteFBsalBUQmsvQjhZNUdYMUxRcnJCNUpk?=
 =?utf-8?B?OEhkNjdiNWFJSlF3TCtWaS9oMXNWdTgxYndVMXJWYXhJNnY3dUFRd2lWRTR1?=
 =?utf-8?B?OTB3VzZDVnJnZmh1VzN1dkd1bzN4dXRscFNXcndjM0tRU1pzeWhjMi9HK0Vm?=
 =?utf-8?B?ajZ0MUUvcVpYOEdGbkFMVG1UNTVkRjhEY2lHN1dWYnAwYXFndGNIc3lHWUx5?=
 =?utf-8?B?ajUvWndGMlpVVUM4Qjhxd2p0VzVoaVp2NGxMMXRFcHRhVWdsK1pLK1NSTjYv?=
 =?utf-8?B?bklHK2NqbTlJd1RwTjRVK0xINWp2UklyL2VCUzFNSlFQYjZqR2loY2lNdzJo?=
 =?utf-8?B?U1kzdmpjYVVmdE1NN2FjMDFPNk1MZkg5QVJ4M2VPUzNGaDBTK1pDWTV6ZGZz?=
 =?utf-8?B?YkJiRlJPY0NHbXd1VkgvNFRKRGg2N2JwaEprSzZNMkgzUnJKSUZQd2Rvekw2?=
 =?utf-8?B?bnVrdWluV1JqdW16UkN4NFVxMzVDZzZKMGtSRytJZXJnSHdzdXVTaDBlQUZL?=
 =?utf-8?B?Y0NaUmNRV3RObVhSWTVrejcvT3JyNkFnVld5ZHZvYm8vSzdGUVVpZFlkcUxp?=
 =?utf-8?B?cnVmZmxsN2tMY0d4am1kOFVNZ1BtWFYyMk1hd0hNbU5jTEs5cllMUStLdWhi?=
 =?utf-8?B?Y1dSN3ArQ2hKc2crSXMyRVB6dStDWks3aTZWR0ZyVHVGL0tLOUNqL3ZSempz?=
 =?utf-8?B?Nm93dDRjR0pxVmR6clFxeUpoUFZzczhXLytldi9SczV3Z29pZ0lOUzdPd3dz?=
 =?utf-8?B?RlNDdnpmK0tmbjFpUEpmeCtRSHQzSWpPckpGeldqVkhvL3hnSVRHTzV6QlZC?=
 =?utf-8?B?VVBTWlcreVNka2hMdkRKb1ZzckJ5bndaZWhHYVNzK0VkNDc2MzlYOHorOUxU?=
 =?utf-8?Q?ljKKXWcavtlMwCBdf7tEISsiC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SH81UDDdjH19haZFigbUZrm4CdalY0iuq1Ryi3hF5UsRobKXNVzRuYUUfVGOBZtDmf0C6V1XsipUlFiRm09G+wPb/u6OVl7MPOypz72AidZMq1sjQP0tBdKHGu1SpiYTr5PQ3vDVodZUaeauz8fhyD7IegX3AGzIg372mp4rLJbG+J588LJwf2/4g5xmLSmzK+qLjVvDIcZ3BXnh9PtrDfR7pA+vv7cEybO1DSLgDiA1B+7d7ukfgmB/B7sTMd4bewk68ciXiQQq9xDLTeJCIcLvX2qTz2GTPCFGCXdDSUAHRTdHzJJiHidhV/iMyjYQLN/+/S8P/KMzRl+OmGlpUl2bnh6Ee2YIkKIl1PaeJrRRRsVzSIluE1JBKVDvrRRn/AJ+wH03dln5m0F+FL+raqlF2d1HJhyRCB78euHW4QpT184wXpvM7dTtlIXrX+akd7oBikhOemWxqStFyU0CeADAG5kWer9hOFTIrot+dZrSdbdJQd7D3szEQLRzWbB5sBcrRfOzV7hPrdlxJW9gLUkS/ce1DtTMoPxILL2/SqMb/amSd3gMpe8Da71I7x3ORxlTwXAZXIPZo8sN0WoDO3ViiTxq98h41ar7xCL7Z3uhikkr+QS9M/lGh3AysjFCiGF3j5+mSa080QuSI6n6rS6R4C6f5tKg9H9aPF0g1DxRQT63/IZ21/xpsnFYNeX39xH0LRBl+DVgQyzsb4118hRAxKdqQIYeq9o/HNMjFmadQ1jKAVoeL97YZGWtjFVBoO6FiO78f5OoWeQ79sGnHD6Xxzui94WjaxnVeqJCaOuRbg/sCT06Ln5cxL3GrjMyTxjMTz3QLInrBBQzXMX8iam2ErcqWaxUGf52dfwA8zx2WiAuLfJSICuXlzJzD687+rykG+8PWbN0StG35E8GpJcvGPbJnXkeuVmL2qj/KEw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8029ea-4eaa-4fd3-fa2a-08dbd5f3e8d7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:19:36.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFQCiSCyNR9cy2vxV6pMjtauLqUCUdrjy42cpXpHMfRBLdvMb5I1cPpF2NgLCACoHO8WLPzoq/eHBN2bTDjFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310260060
X-Proofpoint-GUID: 1BIZW-wlixZsn-uhVRQihnQQr9yyHpiv
X-Proofpoint-ORIG-GUID: 1BIZW-wlixZsn-uhVRQihnQQr9yyHpiv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 11:55 PM, Si-Wei Liu wrote:
>
>
> On 10/25/2023 10:26 PM, Michael S. Tsirkin wrote:
>> On Wed, Oct 25, 2023 at 04:13:14PM -0700, Si-Wei Liu wrote:
>>> When the vhost-vdpa device is being closed, vhost_vdpa_cleanup() 
>>> doesn't
>>> clean up the vqs pointer after free. This could lead to use-after-tree
>>> when _compat_vdpa_reset() tries to access the vqs that are freed 
>>> already.
>>> Fix is to set vqs pointer to NULL at the end of vhost_vdpa_cleanup()
>>> after getting freed, which is guarded by atomic opened state.
>>>
>>>    BUG: unable to handle page fault for address: 00000001005b4af4
>>>    #PF: supervisor read access in kernel mode
>>>    #PF: error_code(0x0000) - not-present page
>>>    PGD 16a80a067 P4D 0
>>>    Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>    CPU: 4 PID: 40387 Comm: qemu-kvm Not tainted 6.6.0-rc7+ #3
>>>    Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.8.2 
>>> 09/14/2022
>>>    RIP: 0010:_compat_vdpa_reset.isra.0+0x27/0xb0 [vhost_vdpa]
>>>    Code: 90 90 90 0f 1f 44 00 00 41 55 4c 8d ae 08 03 00 00 41 54 55 48
>>>    89 f5 53 4c 8b a6 00 03 00 00 48 85 ff 74 49 48 8b 07 4c 89 ef 
>>> <48> 8b
>>>    80 88 45 00 00 48 c1 e8 08 48 83 f0 01 89 c3 e8 73 5e 9b dc
>>>    RSP: 0018:ff73a85762073ba0 EFLAGS: 00010286
>>>    RAX: 00000001005b056c RBX: ff32b13ca6994c68 RCX: 0000000000000002
>>>    RDX: 0000000000000001 RSI: ff32b13c07559000 RDI: ff32b13c07559308
>>>    RBP: ff32b13c07559000 R08: 0000000000000000 R09: ff32b12ca497c0f0
>>>    R10: ff73a85762073c58 R11: 0000000c106f9de3 R12: ff32b12c95b1d050
>>>    R13: ff32b13c07559308 R14: ff32b12d0ddc5100 R15: 0000000000008002
>>>    FS:  00007fec5b8cbf80(0000) GS:ff32b13bbfc80000(0000)
>>>    knlGS:0000000000000000
>>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>    CR2: 00000001005b4af4 CR3: 000000015644a003 CR4: 0000000000773ee0
>>>    PKRU: 55555554
>>>    Call Trace:
>>>     <TASK>
>>>     ? __die+0x20/0x70
>>>     ? page_fault_oops+0x76/0x170
>>>     ? exc_page_fault+0x65/0x150
>>>     ? asm_exc_page_fault+0x22/0x30
>>>     ? _compat_vdpa_reset.isra.0+0x27/0xb0 [vhost_vdpa]
>>>     vhost_vdpa_open+0x57/0x280 [vhost_vdpa]
>>>     ? __pfx_chrdev_open+0x10/0x10
>>>     chrdev_open+0xc6/0x260
>>>     ? __pfx_chrdev_open+0x10/0x10
>>>     do_dentry_open+0x16e/0x530
>>>     do_open+0x21c/0x400
>>>     path_openat+0x111/0x290
>>>     do_filp_open+0xb2/0x160
>>>     ? __check_object_size.part.0+0x5e/0x140
>>>     do_sys_openat2+0x96/0xd0
>>>     __x64_sys_openat+0x53/0xa0
>>>     do_syscall_64+0x59/0x90
>>>     ? syscall_exit_to_user_mode+0x22/0x40
>>>     ? do_syscall_64+0x69/0x90
>>>     ? syscall_exit_to_user_mode+0x22/0x40
>>>     ? do_syscall_64+0x69/0x90
>>>     ? do_syscall_64+0x69/0x90
>>>     ? syscall_exit_to_user_mode+0x22/0x40
>>>     ? do_syscall_64+0x69/0x90
>>>     ? exc_page_fault+0x65/0x150
>>>     entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>>
>>> Fixes: 10cbf8dfaf93 ("vhost-vdpa: clean iotlb map during reset for 
>>> older userspace")
>>> Fixes: ac7e98c73c05 ("vhost-vdpa: fix NULL pointer deref in 
>>> _compat_vdpa_reset")
>> So these two are all in next correct?
>>
>> I really do not like it how 10cbf8dfaf936e3ef1f5d7fdc6e9dada268ba6bb
>> introduced a regression and then apparently we keep fixing things up?
> Sorry my bad. The latest one should be all of it.
>
>>
>> Can I squash these 3 commits?
> Sure. Or if you want me to send a v5 with all 3 commits squashed in, I 
> can do for sure.
Saw you squashed it with the 2 fixups in place, thank you! Sent a v5 
anyway, just in case if you need a fresh series.

Thanks,
-Siwei

>
> Thanks,
> -Siwei
>>
>>
>>> Reported-by: Lei Yang <leiyang@redhat.com>
>>> Closes: 
>>> https://lore.kernel.org/all/CAPpAL=yHDqn1AztEcN3MpS8o4M+BL_HVy02FdpiHN7DWd91HwQ@mail.gmail.com/
>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>> ---
>>>   drivers/vhost/vdpa.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>> index 9a2343c45df0..30df5c58db73 100644
>>> --- a/drivers/vhost/vdpa.c
>>> +++ b/drivers/vhost/vdpa.c
>>> @@ -1355,6 +1355,7 @@ static void vhost_vdpa_cleanup(struct 
>>> vhost_vdpa *v)
>>>       vhost_vdpa_free_domain(v);
>>>       vhost_dev_cleanup(&v->vdev);
>>>       kfree(v->vdev.vqs);
>>> +    v->vdev.vqs = NULL;
>>>   }
>>>     static int vhost_vdpa_open(struct inode *inode, struct file *filep)
>>> -- 
>>> 2.39.3
>

