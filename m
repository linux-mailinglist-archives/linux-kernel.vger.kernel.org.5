Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BB181243E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjLNBD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjLNBDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:03:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3702107
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:03:29 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0SWBe027147;
        Thu, 14 Dec 2023 01:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Bng44QyBno89SU83wo0twbNeKRFlotSdkMNkTxAEofk=;
 b=jkd8Mf2RpsAH0pYTlnIkb4FgSFAlq7Sj7WHW6rIxN2VRya008tjPaO0w7xPgfix9ouEi
 XsAGJGKoDBnHDj2OYMBbN0sOWd0cUVIxfksWE0PUJuJTi7j9RuJkPy8FnJm9G+DjmrfL
 mUvOWowLKQfvKkU8odC2VN4WEuglWaXx/CppwkPNefqGeIkFeeA7Wn4OdxG4sZ4ZVYNG
 hw+stoxptGd+xU0rhLQOah3OqVy50FxTm9B04wdhbeAiRICrmqO+wtP3LbdBwla4afgc
 sk5+HUqBl5l36dV5nb28NdGUb4C4aYbI81UhsTl0YixxAQUaP/CJ2UZtElKyT/WFrtZf /w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu9kws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 01:03:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0Z0GY010087;
        Thu, 14 Dec 2023 01:03:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep981c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 01:03:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/YtPxsrSfdEwJXccrLqghJIYwHX7+qsJSG1+M7emtcdo6rhUT4Ge+wlSsMigr2LO2UM97mLIdUwSzKhG28nm9Aidkh6xyOoCwKpjyntCnBKcNPQ0hzsm1vE40y2yueAojX3srzi5l7hIn/W0r5euY8Ycpme0IwkkNBONiP9TsYlHqKoocHzVV/X9u2dH1aP+p1c2vD4LcTvg1H55wEdEDK5L3j3nzLGp2mdA3k+p9rAkY8vY9EOMbevafBsNirwDLMeMAD7x3N5N64MzrT6ed6t8YU7JLF0Pjo44kJ18vbkislogixh4RHn3s5CC5pajhmQX+UEuZLqD3a/xwsmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bng44QyBno89SU83wo0twbNeKRFlotSdkMNkTxAEofk=;
 b=dHKxXpErfD5p0an+qLIm/WypbIG7fsnEZz6M4XLNYFSLqxBp7OKKVxlL3MrRrobO9M7PSyFMHJQpUdgv55FVR6TV/K/8VYxfzK+DedYuKWtEA66XFaAYV0/w2FrN/kliDniRY91A8PAxpWEmRkphjlFkrPlCVfHdyaewz++iEmQTrAi05BhGMMWyKxdc+9BRypeCgTTRSYJy0EDQyT5smzR+Q8Q7nYlCui3u9jadeIGRBsu0RA0gCimItqiXZ2oZ3WXtMC3bkhwa0JwyWzkCfMZzPad8DH5Va/9v6VrToqowQ+RiGmuNx6EhJwrUUJykECyY9g1k7SNRT1/wujemVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bng44QyBno89SU83wo0twbNeKRFlotSdkMNkTxAEofk=;
 b=Y0gYxJwQgOZ5+0Tf7FE/9XDfdPA/G84a672JiINN0apWljnZDPth0BX2naTiMPI+oFpo2XAKcEScheeTYg5bEUpYFKh/MB5MTndkLObVPLGmGI5HkASEbIGoPxONM53czOhfBRPKLHtFhFsSLm83ckNkFRaznXwzBvhgI4DCSzo=
Received: from BYAPR10MB3558.namprd10.prod.outlook.com (2603:10b6:a03:122::29)
 by IA0PR10MB7255.namprd10.prod.outlook.com (2603:10b6:208:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 01:03:11 +0000
Received: from BYAPR10MB3558.namprd10.prod.outlook.com
 ([fe80::2410:62eb:80e:cc7d]) by BYAPR10MB3558.namprd10.prod.outlook.com
 ([fe80::2410:62eb:80e:cc7d%3]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 01:03:11 +0000
Message-ID: <d9284139-e32e-493c-86ea-77130b503a77@oracle.com>
Date:   Wed, 13 Dec 2023 17:03:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove redundant lru_add_drain() prior to unmapping
 pages
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20231213072805.74201-1-jianfeng.w.wang@oracle.com>
 <3c7d9b8878220571cb7e0760c3a463951252b762.camel@linux.intel.com>
From:   Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <3c7d9b8878220571cb7e0760c3a463951252b762.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::15) To BYAPR10MB3558.namprd10.prod.outlook.com
 (2603:10b6:a03:122::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3558:EE_|IA0PR10MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: b403d729-7e7b-4d88-a977-08dbfc407113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncNRV1PNEMIkrp87G/xK5tFXPr3lh0FlIEWqW8ooUbiUFGVV2gmefowlwR+IlK2imh0l9PqQ1o0B0hICRAOTyisskyaHIzLjzwmFbaqglpFLjSKDJ/7ubZi0+TNCZNw7IdF6WAK8UrLJmCNmoeIqP6oKTzIZrAzUrJiUnr0orQBOiiY9TM+HoS816+0oOqx6TPuwmSLux4hIk5I4O/StLngkv0cVOf/3lGCi94GKTXv+F7QB3SXV4TTIh0VjFlntITRgwuaOXof7kYDQGz5utve51TZReIcQezRzbm5t1zqTno/YQoek1RtcGPkSf07VFPSTwW9dyiP5ovzMViVGX4CxbthTvgOReHj6nvSDp4miYKBnISlWSIhWXsNQ0Zmqpi/YFLD20BX6gotQYBG4bxf1vaAI1lsddHMduIQ5P839hva2xDDWxhV3JPTcla8TYd0tjmwP+cNcbl1TmsPzc9mCLYBwY2SNrbImaPy7KeJqPaxVLalhWDF2EiOtiYXYqI2P7ZtD55KpxABtELn3SRu81QbSpMPiwvZjrPZIujk4KPwV8DHXpLzHZWmQa3m/LJgVUCIyzlYlk9J+QVSCiuzFtFjXFiYFpBp4oRXfWwEqdrB79kbwj47yLj0ne1FUq5/K+eZci5I+2HBOoAtzgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3558.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6512007)(26005)(2616005)(38100700002)(8936002)(8676002)(4326008)(316002)(2906002)(6486002)(4001150100001)(5660300002)(478600001)(66946007)(53546011)(41300700001)(66476007)(66556008)(6506007)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZFcXhZaDVVam0rY1ZMOHQrVnU1UnExOXVnMFdnd3dQSGwrQ2p2SUVySDNs?=
 =?utf-8?B?MHdIcWc1OHJ5emF6Q1FtZ1J0c3lJVTlEcmJyNFMxSUVXcFd4aDgrYUt5eUZO?=
 =?utf-8?B?N0VldmVONnBXWXFzVkdYVEJIcGpkOFY2b0lOSEZadGIrd0p0K0VXRlFleXVZ?=
 =?utf-8?B?cmR5bDFFa0g1WThYRVI2KzdSU0RIMDV5N2FTQ1ZCOWtiWWo0SENmWTJHV3hl?=
 =?utf-8?B?UTN1MmY4bW1jT2UrWEQzV0Y2dUJLeHZoZFRZT0d6RlVXY1NkWU1EODRWTzk1?=
 =?utf-8?B?dGEvSGpaMWZ4emhjMkk4cHllOFFMbnZPdDVHMFhYNUN1aU95cWkvL3NrOGN0?=
 =?utf-8?B?V1lYMUc0TnFMbVhJR2paRmEwVS9qSVQrMWUySVJ4dThrTkxqWXJzSmlLR2Z1?=
 =?utf-8?B?azl4cjJhYmhJM1FHcXZEN1E3RWRNU01KTWVqSW85ajllczBZRkVyWGEzRTlw?=
 =?utf-8?B?NGJPZ2dOeVhVL0lXUUt0ZDVOUGpKU2xaNHdGTjEwY1QvL3V3QmdZMWVvU1My?=
 =?utf-8?B?V3VJSmY2SS80L25PbTdBNk0yTjhyeWpjNWxKQ2Q5T3FqTllFR01GSnVCWnJy?=
 =?utf-8?B?NnBtbUp3TkVyb3lBNkphRjZvOEl5NmNhbGhsTzRxUjVDRjdlcVZXd3VFMS9E?=
 =?utf-8?B?VnVkSG9wWGpQK2QwUk9kcURjY1djTjZsUXNDQnRWY3lmL1lEbG40YjZpblJE?=
 =?utf-8?B?UE50QVc4TStFK3lNa01aUDFXMERBQmk2dzVDOXpHUGVpbU1seFR5TUNmbzJE?=
 =?utf-8?B?U0hhTFkvK0xNUDBoYjA2NFRiNzlZa3JOUDhWNnA2dkYwQndQRWl5VWxMTVlS?=
 =?utf-8?B?UmE5MGx6Y0J4VHltNDg2UktIUi9OYW1jWHQ5Y0FqaXFFQ3drZmRMVVBubC85?=
 =?utf-8?B?ZkxsMDFoTWpQeXBreHhncHlqQVZNaTBWdW5yRkFRTFRlb1FPcC9EWERraDBq?=
 =?utf-8?B?MW9ZaEhrckF1NEpyQmIzMlhhek9Uc253V0NoWWZudXIzUGRyZldnZlZoTmFY?=
 =?utf-8?B?OGEyTkYzaUh1Q1QrY0FHYm82N1RVRWEreFNlRlJ2c0lPNnNpRFdkVk5rcUEw?=
 =?utf-8?B?bXVQbGl1QXdBaVZzeEphV2lhMURNTll6dFRhTlFRQlNkVnVMbFNwOG9MRUtZ?=
 =?utf-8?B?MHNwb1AyNVJ4Q3oyWFBRZ0EySjVpTTdWYVZzd1VOL3N2MmI4aVE2VUd0OGdy?=
 =?utf-8?B?NnJLQUg4YXVtdlhvZHBRMWpxeXRXcGZ0d0t3MmVsQ3ZZQTAzS2lHbDRqOTVY?=
 =?utf-8?B?OXZLa1lLQkl2OWI2NWozSkRsazluY0djc1dhSW8vTlpXVkJDRndJTzJDaUUw?=
 =?utf-8?B?RWhDSVJqQjFSNW5WZGZCc0JlamFIakFkTjkzUVpZTG45cW16WGcxdm9tT2N0?=
 =?utf-8?B?dlh4LytiZWMyeFhCR2xBdEpBSkhNeFRQKzZ3TGZKenhwSHVPdWQxUVZDNUJn?=
 =?utf-8?B?TTJ4QVBhSlQ2dVR2UzdHS0h5T09TOGc1Y2J1ZzlhcXc5am9zUXIvdFFJZ0dF?=
 =?utf-8?B?bVBoMVdvblJZOHBXYjRsVHljVmd6bHNGWjNsbGhYWHB2TXhwL0VuZHczMDNT?=
 =?utf-8?B?ZktjNDhlUXp1ZGdsV2hybVpqTEFoZ2gwT2tycTdacmRKWXF3S0o0MDVTWGE0?=
 =?utf-8?B?Y3h3VXMrS1UxTUZjU0tNY2IranhwaE5DVnVmMXJOdm0rZ2tzWnMxd2x6cDRV?=
 =?utf-8?B?UTdTY1RBNVhLQTRCZ3JBREJVait6SCtPU290SmlIUExaRm9GTCs2VURNekZO?=
 =?utf-8?B?eHRUYzl2a3RYeXVZbnlNUWNFTDJnYzlNc2QzRDBFL3ZvU0x6NnZ1T1NINGI0?=
 =?utf-8?B?VURyTktZNWVYQ2szZ2hvWFhKR2Y0TVFZRS9zSnpobThEdW51cGlPTlN5cVNa?=
 =?utf-8?B?TTZTSElMZCsrdGtMcW8zcWVidjdDc3U0NU8zRmpqT0xHNGZNUGZUdDNtdGZ3?=
 =?utf-8?B?czhOOElaMERZVEs3a3VLd0g3L2paaHJIMEozdmhiREE3b040QmhlalhZUlk5?=
 =?utf-8?B?TGxEZitITXhpQXRXSU1vbXhaeTNFaTl1QWVlWmVtS1lkTHowb0k5OWIxd0pO?=
 =?utf-8?B?VnZwOFc1TDNKb0wweXJFUFJtVGxLcHZ6WjEyN0JBeVlBRE55cFVzTVU4d3F6?=
 =?utf-8?B?dXVnbXppYkhZajZiUzBtNVJnQVB0TWhqZHlJdVVKcTgrcStkNXV1OFpEZ3di?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9qAL5RHxFviy20JimVl1IA1tqSr6we+HfXL5Oak9rUosTQR5RyxCnXI6jQ63wnOipgxufgVFy71/E2CHnYn6T8Vbfgj62hwIgVYBQq3kgjPWUUf0KbjKgy60S1ggqOhFI8Fq4WfgKD7zfQ/WYVLTHy1+YH2k74+3ks7dp9lU/tBNtY1MNH4RCKRuxxKtuPcGn36L8N+iwDNOR37A+JFJfM9PKmdxtSqQyIt7FHYhI7+Jgr+CAzclWoia8M8HYByyoxgw5d7RLc5RsMUSJVGXmHfgRKa5Sa7gaJx+fR8vNI2GEfZ9uQD3o4Fy8TJptAtTm50fEdiY//TC/CPDUS8w/qwSa3XI+Xj9fIlRll6AJoPZr/mX7PLzmRjqGe1xRV0Y6IQ+k+QobK8Y61tt+kGYZuoF0Iyk3+AyeHotCZthr05vhgm6NMze1rq0AEcOsYiBpPu0IvJ3BH6KGOAG+VrXoECb/1Mrq1dFMRFs/ssMeE5YWF5bjX/1shjpYTu624ZdI8AbVRMDel+WSGI5dKy9NEL7ZVfcg0UrQIw0R2mZZ5QGUJMduV5ks/oFrVCwdX016clYDeJwT4chqbO25wnJwxZkCNe1vMKUm1FQMcg70EY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b403d729-7e7b-4d88-a977-08dbfc407113
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3558.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 01:03:11.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybZV3w1OClWiR+TxaXBP2S6dNy7AXbe+nB0M1OinAFo68ME4alZnfPR7aQiMAJW55LekTx7C01bmlKoXN8kKNEk2eUlcehp9tp5EprXIO6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_16,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140004
X-Proofpoint-GUID: 4eZJ6PmYeJ0fTDmxRpuVaev0tdRfCFJi
X-Proofpoint-ORIG-GUID: 4eZJ6PmYeJ0fTDmxRpuVaev0tdRfCFJi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/23 2:57 PM, Tim Chen wrote:
> On Tue, 2023-12-12 at 23:28 -0800, Jianfeng Wang wrote:
>> When unmapping VMA pages, pages will be gathered in batch and released by
>> tlb_finish_mmu() if CONFIG_MMU_GATHER_NO_GATHER is not set. The function
>> tlb_finish_mmu() is responsible for calling free_pages_and_swap_cache(),
>> which calls lru_add_drain() to drain cached pages in folio_batch before
>> releasing gathered pages. Thus, it is redundant to call lru_add_drain()
>> before gathering pages, if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>
>> Remove lru_add_drain() prior to gathering and unmapping pages in
>> exit_mmap() and unmap_region() if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>
>> Note that the page unmapping process in oom_killer (e.g., in
>> __oom_reap_task_mm()) also uses tlb_finish_mmu() and does not have
>> redundant lru_add_drain(). So, this commit makes the code more consistent.
>>
>> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
>> ---
>>  mm/mmap.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 1971bfffcc03..0451285dee4f 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2330,7 +2330,9 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>>  	struct mmu_gather tlb;
>>  	unsigned long mt_start = mas->index;
>>  
>> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
> 
> In your comment you say skip lru_add_drain() when CONFIG_MMU_GATHER_NO_GATHER
> is *not* set.  So shouldn't this be
> 
> #ifndef CONFIG_MMU_GATHER_NO_GATHER ?
>
Hi Tim,

The mmu_gather feature is used to gather pages produced by unmap_vmas() and
release them in batch in tlb_finish_mmu(). The feature is *on* if
CONFIG_MMU_GATHER_NO_GATHER is *not* set. Note that: tlb_finish_mmu() will call
free_pages_and_swap_cache()/lru_add_drain() only when the feature is on.

Yes, this commit aims to skip lru_add_drain() when CONFIG_MMU_GATHER_NO_GATHER
is *not* set (i.e. when the mmu_gather feature is on) because it is redundant. 

If CONFIG_MMU_GATHER_NO_GATHER is set, pages will be released in unmap_vmas().
tlb_finish_mmu() will not call lru_add_drain(). So, it is still necessary to
keep the lru_add_drain() call to clear cached pages before unmap_vmas(), as
folio_batchs hold a reference count for pages in them.

The same applies to the other case.

Thanks,
- Jianfeng

>>  	lru_add_drain();
>> +#endif
>>  	tlb_gather_mmu(&tlb, mm);
>>  	update_hiwater_rss(mm);
>>  	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
>> @@ -3300,7 +3302,9 @@ void exit_mmap(struct mm_struct *mm)
>>  		return;
>>  	}
>>  
>> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
> 
> same question as above.
> 
>>  	lru_add_drain();
>> +#endif
>>  	flush_cache_mm(mm);
>>  	tlb_gather_mmu_fullmm(&tlb, mm);
>>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
> 
