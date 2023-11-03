Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB79A7E02CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376342AbjKCM2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376306AbjKCM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:28:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499BECE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:27:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2NP953023495;
        Fri, 3 Nov 2023 12:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=azOP88aNvczz3FhjmCF/8KKXTqoh3pQMYwSE8dErS7E=;
 b=dq+8g0hkwjpMWNXDB2KGW+5omxvvxOEdtc6i3tX0HRAchQbvk5/jRyVtEXdWcQpL/XPJ
 IbKahk4hwDhuGTM/G8/OzXwTJUOpA0+bICIpsCzrWU7yJZugoZyCPXM8YUCff0KfzL8K
 Vt6QUU3CY8HN85n0aaKH8Pe+Ggnxpu9W/XhEKJmCMJzS8mfiKzXiQrwU3c9IpKgcJBVf
 xeGyN/BybLfnQrItB1+npPF0pur5Lt/sHzSkZzerRq56a7j5XhCf1u+2zT5O9Hy2xs6P
 SOMNGa0+rUpWJOK3r6l2QFqu/sx58MG6spvkJZ+h0QUemNZpxQVlN0q5+UEJph2npLkH hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqe3upe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 12:27:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3AN1d0020108;
        Fri, 3 Nov 2023 12:27:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rra1th7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 12:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT+1XF2yoxjRjmXshCGDnGdh1DeoS90WzVCcEyYzP+itoWNKgvzW1XrlO+sU0a+073orKYqnbxyfVSD3G2LBdGQsmkBza1P9ZX5TAoKdSb0DOg3snB0fvMdacdsmUyBcNw32RUFUwP/f5b6FHUF6rRzxYL3soJ5xlfiYki6Ew3E9eC4WmsMOdK8w2gGPuMv7IA4DPHo0UCU3PXEYxuHFZ8IpEKSCAElKkLcQp66PdeCDXacEYxc0uIhjNwYgNNHAB7iSbtTs/2yYwSx/q4RsFOqmtVLk2f5ZmfHpzSI0FLWvVN1dfLvIr+j+BDSQAyLENHEoYa3OsXewTvDlFjYYwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azOP88aNvczz3FhjmCF/8KKXTqoh3pQMYwSE8dErS7E=;
 b=iW4bsG3Mzc0KJNZan1VST49MDcGjaQxGCodKuHJWmF9+R6+IzjctPPnQNJRHXAbFiIKFtHaqJmMCc3QXp70PNqGluTh4EWOs6XZokApIZ72B7RlbLx4N5DkUWFQg/Z1ksP2mnvFMg5rrWT6BDZgXRuqYlWAuR6A5nQ/PDglM2NqEzcD+8spSvWXMdrJb7u8K+eIap/PpR3AURYLLWwutIHZ1JZYM6+iJ97/cY6zc5I8n4W0JP/34LXj6BYjCrqS/RuVIusZ9IC4E6dUG9WnWpRK3v0SA9xkNLlv8ulVGsF6SnoIqDf9aAXq6usM4KOuvFvb8hl2aSGZO85SwO4jYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azOP88aNvczz3FhjmCF/8KKXTqoh3pQMYwSE8dErS7E=;
 b=atDgaS46ND/Bb/rL5y4nuRyQWMFNVsBZeeFwWbnsD62hb+ZDH0f4TbRYmghYKayQDaAHLBUx9Z1C7P3vNTuLl5072xRvSxAyUMvviaE0kkYpudwlAoJP3oqPQvmATpJldYKcZ6Gl/0CB7bD/5NoiMTfR9HnSA24GCkH0vbsKuf0=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CY8PR10MB6852.namprd10.prod.outlook.com (2603:10b6:930:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 12:27:46 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 12:27:45 +0000
Message-ID: <af830b8f-cb31-4584-be9a-ee081be6eb23@oracle.com>
Date:   Fri, 3 Nov 2023 08:27:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] vdpa/mlx5: preserve CVQ vringh index
Content-Language: en-US
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
References: <1699014387-194368-1-git-send-email-steven.sistare@oracle.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1699014387-194368-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:208:239::18) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CY8PR10MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: b0bfebaf-358d-4446-a35c-08dbdc6848c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbQgbOjZH5zsIS/cLy6nK9cCjMmgj/Z7wTvUvyAepHNRBkBOgpFcyO9HbjucB1aaefKktvnAsXpSgeVT3OYLimiM7sz3hoDjZ08krumMqr2ropfxlOKLgMZZ8m0XRTtPrHKbjxYMEhDHM9jGEm9g8ANOsod93rfjlFFT5KmbuOACJn1i7leY5xm97m8oD1hVejuDK8dVqgqZfRU6aCciq9cKY1xUrcq/hE3qVqBuz5XUw7LQiIR3l5pczSo9PfmoN33B0d8gLQQjZxGqA0kFIMTJB/ixtsnFWZk3DqfrUWmocErL3hUuyR4qFsiBXt9P4hGnXUBt686IvcpPgjWPXUROkwDqD7sgZOYJ0+txx1VqFfodVft5sJzDezaMVcqEjirGNNxmkSof80Mc/lnb9Z0gRw3udGmmbAXfw9HvXKTNIIPDydxS9sZ1j7Y8TIbQnKhbKK7zqRYChCbooooPNqkc2j++5x8H6O0zU17cE2YWlUdMR97k7JXkuc9X7TWVN8J24rktImpVDT8HsFRE1rifKIPKzDFOAWBp1++g03W+1GoNcq23nh3XYSspaKqCbVaiyxdK7o3kWZLm65fkG/bEfZfNXIVEiaZaOkRP0G5S6q5FU3jhL5yuclorfT2saKCyrq7nmLjklXZ1gQACwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66556008)(316002)(66476007)(66946007)(8936002)(4326008)(8676002)(54906003)(478600001)(6486002)(41300700001)(36756003)(31696002)(5660300002)(44832011)(86362001)(6506007)(38100700002)(2616005)(36916002)(53546011)(2906002)(83380400001)(66574015)(6512007)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW10eGNlQkEzUUxwL2ViZzRXM1lSZk1HcUlLd0haTFhJcW9nNGFMcGFpam8x?=
 =?utf-8?B?UGxreHNaM1UzN3hvNE9OMmFSSU5xQW1iNGwwZ3dOazFmLzlmMDQreHRyTzcv?=
 =?utf-8?B?eis1bmg4OXlobXpZZGZWT0tPVE1RdUIveTJGYmh5Q01oVm1aaU9Yb2Y1ODU5?=
 =?utf-8?B?c2xrUHg1MEM5akJwcVBLT3d6OE5kQ1kyS3dseW5sc2ZrbXJaRzVid0MzL3k2?=
 =?utf-8?B?MVlMck93RDdQUTV2d1VlVFJWSXZVeVplNWo2RGhjSnVHTkxkV2kvLzNlaVo0?=
 =?utf-8?B?Y3lZREtVWi9NWnh6SUZtd3gwQjFqV0ZPM3pYUk5kb3BmdllzS1ZUb05KaGtr?=
 =?utf-8?B?QmRjaVFNSTloenMrU2N3SlFYVHk2czh0TGRIbTVHSG9VSmw1ZU9IV08vSVlt?=
 =?utf-8?B?QjI0dVVQTTBsYUhEQUtZc3lZWFMzcWE0TmxQUnB0U2ZwcUN1N3RPcm5uclVO?=
 =?utf-8?B?QXZqRS80WjhQZXBKRXBtNWdpV1V3TStDdUtDUzJvazBxTWNzSUhZM2RXU1lD?=
 =?utf-8?B?WlFCZXByWnRKSlpyOWxyZnZsa3JiUjVPOEx6blhrTUpwY29CbitMSGltWTFz?=
 =?utf-8?B?S250MXByOTNJS2MraEovVU0wSTd6d0JqY2IyZGNnUVovOHZOeEt6MG1jL3hR?=
 =?utf-8?B?aDVVRmRPTXBJNjlMUjU1cUtONmNrOTdkcU05TWo0UmRpdDFieGtiQjhyL0Fk?=
 =?utf-8?B?bWU2WWhWZmNzT2hLQTNyaFZBT0RuNUJBc0FYN0pFL0lNNzY1MGxrakp0WWRp?=
 =?utf-8?B?b0FYNFRvZDh0VmRkNmNsa1FkZHd4aXRZQVZSMXQvVWxpOGtmZzZSZ1cvajJM?=
 =?utf-8?B?V2xKd2tnR0phcFJIbklQbzg2Y0UxN0ZCOVE4bEhXeVgxVXdpRVdGelpOaHZ3?=
 =?utf-8?B?aHIyVkFQS0cxSVdPK25XeURteDJOcXJqdCt5eVM2ODN4RVdBY0JZWFkvUWRB?=
 =?utf-8?B?S0FibU82ZkZjSnl5bEtxYzVmZWRpVGFMaEVTdDJtVjFuSmxsQ1VERTBtYXBJ?=
 =?utf-8?B?ZHBEczJNTHF6enJ2SUN3Tjg1ekxCb0ZIc1hoWCtueCs1SiszNlAweVdiZUFM?=
 =?utf-8?B?ZmowTFcxclhrNVBaSE05cG1JL1kxRThVZ1RWSFNjNit1ZnlNeHFMc3UwVFQ2?=
 =?utf-8?B?aER4Q3ZpWVFMbTZ2SzBSMFk1dVk4ZVZ2T05kNjBTRTJETERub0pWc3N5YzVS?=
 =?utf-8?B?VzFhcE01WTNPVHRmR0t5TmE0TlZKN0lYQXdiWWJncGVpK3I5dHVoME4vZE9J?=
 =?utf-8?B?Q2N0a0RkZlBuVit5OHFEMDd4Sy85emxPS1ZIRlFYdCtkbytaZUFjOHZ1MmlL?=
 =?utf-8?B?VUR6MjZJZ0xlVlIzSDVsV1hmUE51cUF5amw2R2JRRVpUaXlZVDQ2anFteGdV?=
 =?utf-8?B?SjdUbEs0dkJsQWZKNmorOGdBQW9sOFZJZTFOUkhNQ3dkY3VxbnhnWVpQa1Bo?=
 =?utf-8?B?b21YMlJieTVJYWdXWHk0VDBKajh3eHloL1cyOE9zZTVwanpkakVjM0c3akwx?=
 =?utf-8?B?V3NneXpyR2lUaEFqeUt2L0RpYjZGUmJtSjg3azNza1RHVXlISll2emo5L2FR?=
 =?utf-8?B?U252VzQrZDBBR3JnQjZXMURyQ1lMcjdVUURBS2IwNWI5R1diMklUTVhPTjFk?=
 =?utf-8?B?VFIxaklLNkhsRGd6eVFzL1NJM3Uvb25heWNTcHdieWpwbnBnR2ZrV2pYSTl0?=
 =?utf-8?B?T2RMbkNlM3JIQ1VCTlVadERyMGx4cnZuVFJmUFBNc3lNM3lacEIyaDNlTzRk?=
 =?utf-8?B?eTNIU2gwZm04SFpRWTQyYjZneTFuWHh4WHlVSHoralpKWU5wUDhtRVB1dmRm?=
 =?utf-8?B?UU5tdU16OTY4ckZzM3pwQTZLVzJDOFQxY3B6VndsL1J6Y0NUQWtBRGtZcmpK?=
 =?utf-8?B?OGxpRExxS1dqbVg5bWJ4RG56WXB4ZjJzSjdZNlJFVU9EQ3RQU25QKzVndEJ5?=
 =?utf-8?B?YWRqK09wMmtjcEJjSVBMdDNDUXU0eW5HdEVubGE1TlBQcnRMb2lNeG9DSmNp?=
 =?utf-8?B?QnNnRVcybTB1RHhsd0hDN3prcnF3MGI5RTQ1eUV6cGJzRW5qL2VPU0tLeVd1?=
 =?utf-8?B?bzJ0a3BPOGgxc3dCRHZCODErS0luSFdnelJsVjNIL2hUUkpsL0hnbnRFLzU2?=
 =?utf-8?B?LytTQXM5TmFRaGhpa2orZUdvWi9VYVdxanY4aTVNLzQ5Y1RXVlUyQlZ1Z0Ru?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QmtwM0dtUVFLckd3b1ROc0MycE8wK1pvOHFhYjE4ckxyZis5cjI0RWUwZ1Bs?=
 =?utf-8?B?ZFhQT05WbG1RQ2pUT1cvZXZVOC95Vm1sY09OM3pTMkoyWS93L1dpSEZCQzI2?=
 =?utf-8?B?TDlJTUtyVUYzNi9rOGYxTWgvenlmL0N6UUczUTByQnJicG9uaFBaQlYxNEZM?=
 =?utf-8?B?aWF5S0YwdjF4bHlhUENYeFN2ZzM3MXN6UWlTQmYzamFoMElQcjZhQ0hlTUlC?=
 =?utf-8?B?Q3V4UzJvUVFKT3UvQkRldzNWMStxT2ZYSWk2LzVEUWpvNGRwU0Y0RHMwUEJ0?=
 =?utf-8?B?RlluUlc3V3B6VzdRUjJGdzBUVmZCZFYwVGpoKzRFUG5oeUpvb0Z2dXIvOStj?=
 =?utf-8?B?b0wzSGRiTlJaaGFJNTlRZVpTWHllQU5GSkxJWG1maG1GenpyNllsTTZpNmVI?=
 =?utf-8?B?bHM4Wnl5U2MrcjBkWjVIbGtvZjNNZit3d1FsQ1J6bGdQOEtSNWIwRlQwNWk5?=
 =?utf-8?B?blRoZ3NVWS9YZHhMb09KTUg3UHZEekhxZTdUL2ljQ3dCREtZY1M2RjBFcXBL?=
 =?utf-8?B?L0lQRUtGK09nVXlqV3JmYVVLOWVaV2FTRWVFdUVqT2pxK0RXOXJjVWVMc0V0?=
 =?utf-8?B?MVVUSjcrc2FZSVV0d01peGdjeTdUbjhLT1U1eHFoeVZGN0xEdEIwZTFKeUdl?=
 =?utf-8?B?NnhsMWRyY0RraGpqZ200bXd4VXI1b1Y1N2VpWWl5Z1NQNDVocHBnMGpETis2?=
 =?utf-8?B?elJVRUtYS2J3Wkg0OWIxTDZkVktzSW51cmtpVERtYW5zV2lHWE8wT0Q5bEZk?=
 =?utf-8?B?WCt4dm5lRXkrcUdSbWJEMVR5R0FUN2t6Q0xTYTVlc2N4QWZNQ2FCZG9BcEZL?=
 =?utf-8?B?dnVPTTZVVFU5UFo3cEFpc0RDbzd4RGRXbzg4Nlk4YVRubnZzOWpaSitEUEVH?=
 =?utf-8?B?cWJLVlgyM241emNGMCtoQ3oyNmJKd1JXZEpOSDB0T0puRjExU1E3L3IxOWNC?=
 =?utf-8?B?cUx5bjdIcVNEMndSZVp3MjFIaUlYK0djdEU4MnRzZUlDbm04ZFZTRUZ1R0F4?=
 =?utf-8?B?b1c4K0g1N240eHJaV2NXTVJlRFkrRXE2MWVRcGZES3ovNjQwS2Q5N05LMlYr?=
 =?utf-8?B?RlFRbGk4UVlkWkF2Z2FDWkRlNWV1cEdwM3dWSnYxVmJFeUxTcEwya1J4VUhB?=
 =?utf-8?B?cElMRzJNMjdQQW9sUTFieWEyMWZRUzNnSU9jdEJ3SWtrWlVxeUFXam1FUXJS?=
 =?utf-8?B?RzBzQU5OcExuS0pKQXdGcWNEK2FiMGlrVkZrRzdFelVsVWZZN3lRTEtWKyt5?=
 =?utf-8?Q?EP91RryuaK28bnl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bfebaf-358d-4446-a35c-08dbdc6848c3
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 12:27:45.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3haRdQ+CmO8sE5TJ6BuHYzYH1khlLSLljPw3J07UJN7ApeeBOVOfx9HD8f22M7n3QyQxnfn/KQqq2u4o1iKKg9uXWzNJC6GfKpdBAogfv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030104
X-Proofpoint-ORIG-GUID: 2eKpgNtsMWR1SakeKvfO0Liy_8LCUz3X
X-Proofpoint-GUID: 2eKpgNtsMWR1SakeKvfO0Liy_8LCUz3X
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In V3 I added the fixes tag and the acks.  No other changes.

- Steve

On 11/3/2023 8:26 AM, Steve Sistare wrote:
> mlx5_vdpa does not preserve userland's view of vring base for the control
> queue in the following sequence:
> 
> ioctl VHOST_SET_VRING_BASE
> ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
>   mlx5_vdpa_set_status()
>     setup_cvq_vring()
>       vringh_init_iotlb()
>         vringh_init_kern()
>           vrh->last_avail_idx = 0;
> ioctl VHOST_GET_VRING_BASE
> 
> To fix, restore the value of cvq->vring.last_avail_idx after calling
> vringh_init_iotlb.
> 
> Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 946488b8989f..ca972af3c89a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
>  	struct mlx5_control_vq *cvq = &mvdev->cvq;
>  	int err = 0;
>  
> -	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> +	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> +		u16 idx = cvq->vring.last_avail_idx;
> +
>  		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
>  					MLX5_CVQ_MAX_ENT, false,
>  					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
>  					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
>  					(struct vring_used *)(uintptr_t)cvq->device_addr);
>  
> +		if (!err)
> +			cvq->vring.last_avail_idx = cvq->vring.last_used_idx = idx;
> +	}
>  	return err;
>  }
>  
