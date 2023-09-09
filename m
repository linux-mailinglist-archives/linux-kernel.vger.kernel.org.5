Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65B4799676
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 07:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244331AbjIIFcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 01:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjIIFcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 01:32:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9CF1BD3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 22:32:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3895FCEY026212;
        Sat, 9 Sep 2023 05:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=3jjdvIkzUAVcKRAthKLtBI9skCgx4DYsFHFAnz1w89I=;
 b=f7OtQPZgT81VRRf+IiWpL361fIa3Z2qzHqCkz8VI5lnuRPqLVwuVNdkyO5bnUNIgIX1w
 TFNsdkGlEsZGDWlyV6jFFIIOFG0oSZ3U+HqBnHoLxsruu74L8TvP5bCcOHU9RNuhVU73
 v662CLW/k4XCXcx6TPLtAAX/KPpUDQyxV8BBpphmxVF8LEtn0e9lcahTWw0VKG0PR6vg
 hcXQzT//BlGLUgnRsGqHKs5dirLquo4DGXuVd+wJ3edTLztdoy/iCa/1QiM1W0xukGRO
 hD3TV1yDvvzsV/sASQnYny8zNJ3jGCFwM8E8GVXCnHNg57XCMYzx/zagNnjn4ZTBpnSn QQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0jcy80fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 05:31:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38950JK9021585;
        Sat, 9 Sep 2023 05:31:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f52m0rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Sep 2023 05:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1kbpX/aoLmMgRWaXVLNl9DRmx1JQ1FOcR4JgSzAS8jvkWsjWpHmYpFC5hGJp/DwYi7JvP690sp7715uiIMTTkAYW481O9YjTNk0QSyuWvbhMQYCdaGLShbu/9lObsWXgEtVO1cjgwuNGKM0Wt5B2eeXctUQ1Skw7HsLDzn9YTPNBy0xQoQzLNv3mNYE0QHOkCQCt6T8evjc5uDGem+VJkbPOPVIHeuzUetLQAIemD57XbZJsqYUQ2m6A7DR2nnBUR5frs+RPkHtKhVTSIt5MeknxxFcTh5xsJKTEPq2XM4w7pzFAH4qonGqNzUJiW129IjbjS7U7iTUmZB6VciTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jjdvIkzUAVcKRAthKLtBI9skCgx4DYsFHFAnz1w89I=;
 b=dBETOvfP2jD36NJBL2JFiqD6ai7xifzoycOg9cG6vfqtgjrG9E34JVi1CLRB1EJvW74mGr851yB8XNGTzaxD73PzqVAv0jkqkr07DJch8eKUrlzDzFaFH/BaYunEjzPaWtear8gzFtOEatYDVc4lRFzmCxMIch58KSLvMEWb/eZM7RjMbJ2JuHEeRtHVEYRUFFuA5cShD0DfYBNHC+lY/VjZDenPMQpnUeOIPhmC+g1RXTSKyrhsUNESbt7xIh2iA791H19QwGo6X5gSKZU9QntiGJXqQYnYZQQqC5+OhiDq3r5uE+w91kufUiIuV6dEO4N+gfk5AJWG8+V1NsH3aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jjdvIkzUAVcKRAthKLtBI9skCgx4DYsFHFAnz1w89I=;
 b=o586JU0U0u5qwv73YZSNhGGQQJR4rH/OtkYm2N3zGiu5zaQeWlWBt6rgGOjQnLDixphiUICSGmaRPVHeYBujPJhQlpkH+TDRtyo9AOhPqBt5t08Iy8I7QFRJlmR758V83rWW1g1UUUaHUCiuHIMkuYnRHRCVCvk9TbMrBqeLCvQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB5914.namprd10.prod.outlook.com (2603:10b6:930:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Sat, 9 Sep
 2023 05:31:00 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6768.029; Sat, 9 Sep 2023
 05:31:00 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <CAHk-=wif4WMu-k9Pi9BoVRZwH6npjS6Km9DR9aROxANZzN2iRQ@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <CAHk-=wif4WMu-k9Pi9BoVRZwH6npjS6Km9DR9aROxANZzN2iRQ@mail.gmail.com>
Date:   Fri, 08 Sep 2023 22:30:57 -0700
Message-ID: <87v8cj9alq.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 410b1267-70bb-45e5-97c4-08dbb0f5f335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CP5Z5ubJQ3meMVgnKUZ7szVQfPV2muqiXVcMf2UsE8HKvuHB+x75tOVJD1jm+MJ+ZuU+WsqhgXQxjju9Oo4j0TrVGV2F5+buuaqPAbs9MOCv8j7adsfwhAMH1E7LPS277tbI+rlL8eTMGEDkcjvYZFw92IyAPxdf/AhpuPYpz/Z1cgY46n6hUCk8qjpYVM5hz9W5sDm8BzXVrRCWua6NnXI8TDFoOKHjiAeyW7KYJq6KmIfcBK7i+LbsQ0vaj/cxstpz7bmB0ExaXz6SRPcbOn0MDqvSbG7ylZ1/HGfwfmkFPSDYfHZXsiQ1Mp99IMfhK0nJYcpUiMvVGz9173n9wIKdWH3AJPcQ7T4IkQqTbBqsizqbTt6n3y85Cq8GzalTYQma7sgrIHE9AAyyfQwRkSfsx9/MxEPx+gTUetYHKZPQfqAiVtbVF3SkGsBBBIiJ6Rm6xwy3O6pJaMy509USMdtwxHvJ/txO07NFaBqjrCkkakjnGYWKFAt/ft/DEYw/fzfQc70BjJJKYzyHzjPYqDSu5X8S4isVYMdTQJkSPq6++GCmrsTQrAG9uRMfwsz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(186009)(1800799009)(451199024)(41300700001)(83380400001)(107886003)(478600001)(6512007)(7416002)(6506007)(6486002)(6666004)(26005)(2616005)(38100700002)(66946007)(2906002)(66476007)(86362001)(66556008)(6916009)(36756003)(54906003)(316002)(8936002)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eAioXxETRzLOo2j9ZkOVtPJlFcceeZomBe2wRmyXkHjFDkqSCSI3n8HhLNKn?=
 =?us-ascii?Q?10NXp7dU0AMjTu2Gm4fMmbPBii3/YLjwigohsySgJJlqmKsufU0XkaGPNQxo?=
 =?us-ascii?Q?kaXsNFclYfZToyE7p4nJkAOgtlbNKb2igO5spenz4loqkV2BA/+utPe32C7G?=
 =?us-ascii?Q?thSgAqeCLbVyFKYoUhFV5b6h5BQlcgc+vL5lQiH/jjL5lvXheLnXcvLU8g9y?=
 =?us-ascii?Q?gTlGx23v4zclFVzRAbfcFq+pXbCnFkodMnFb4gJuoEh1XU8TB160Ve+VWERz?=
 =?us-ascii?Q?i4H9r6nx1MaZiJSLy9fftfsYjyBXsLBGCDcCgMqc4G9RnHH0QCF6Y+zH0yIv?=
 =?us-ascii?Q?oE6doaXsuvJZIjo0XiVC9cRWprJrjBPxa+xf5vRFjCLzPDeV8O0iGR4upHbM?=
 =?us-ascii?Q?E1nzo6mlTSx129D2W1ZEoXlJGTquVOHBoc8tq/zSx8SkOHwtJKc1l4S4NG+2?=
 =?us-ascii?Q?FLKtOrkm8hQmTa2FC0cF/dSwF/wxOxC2vFvijT0CARkEOWFr/aAYnYva9vZI?=
 =?us-ascii?Q?FUvwTDZ91xAwNk02gqEoA3iEueyXQsxHOFFTSPK/qctD+zL36iirAOoj9Ecj?=
 =?us-ascii?Q?1C09xqztwP9OtMnPYt8cH8YYSlaiicnK2cBwnetybE2lXhdIMUwOPRSe+OgG?=
 =?us-ascii?Q?VyMUwtksYqoWEpFA4ArHZtPQyKlkyc5Ns9eeYhIBGjEchG+7p9nE4GufWB6y?=
 =?us-ascii?Q?2Yqpy4KI8dffQI1Ze1hB7GpjyveszuwgZB2wVTCc4A9rZ82kwYf0wLv10tWP?=
 =?us-ascii?Q?/QWUa8SCBpQs2D9hPZjMUbg25bVpOeizYy0f5gGsMrxFlIU0K3Ey0zRRMhX5?=
 =?us-ascii?Q?vXJAgm0CeCreYobxSQcshetxenoJeCX6I7X60//78dMkRJTKYnTvm3lDTfTi?=
 =?us-ascii?Q?ELFD2QEkazFdEbflUzXLDjQ8dEe5GFgOeCY2yGIhFTiNNwzf2hPjteKtWc29?=
 =?us-ascii?Q?nq2D6kN4KqDg4yyjvUAnVvvDUcmWe3CWiLuL3ALXn2Bz3YhzG+f61UzVTEhv?=
 =?us-ascii?Q?NE/xMQZsExE7nTTXvTm1lq7iMEjdMwJ8UKSVIqulujk2pNxig/MkKd3HebnK?=
 =?us-ascii?Q?mFcJL82wz8rB0tREXmnGNj0Q+3m3SwQgQOsv5kCTvrqru+8+IJaiFMxL4WuB?=
 =?us-ascii?Q?nHJ+28zRaWJNzYHK2rFhyUx6V9PVU+6W+9T3qDa+rEI04RKYNxaorp+6eRIl?=
 =?us-ascii?Q?KyWp9CyX/EeubunkHjc+7E8pQLFRuTp1Dar/+VEgaRsU3sd9PwfSgbrSFKcS?=
 =?us-ascii?Q?UtflTrt+EKMX2l5oXA45D8OmGqXbL7WVstacYWigi6Fos2LpgSFZx9AFCxhQ?=
 =?us-ascii?Q?/iNdoRss/0uX3dfSAsv02MTozar3VTRnJ4fQDnYAHthXY9msTmkSyFq98DG/?=
 =?us-ascii?Q?6qaE/ih2lYlaKMfxU2NqJ6U+IATNPyHf9vmVlYgvrfg2N8sQq+4ZiVkYEhzY?=
 =?us-ascii?Q?7tSRafSwjfJXEkYk7kSTnXgrK7ksZyx3xUthx+Apo6Eq5ysXPlMu8lCE8lKQ?=
 =?us-ascii?Q?F2R2JwdWfoKQgwlk/yNn0fhSQJ77EnqEtcTiYYmIEdskrLhhf1egQLuqA2+Z?=
 =?us-ascii?Q?i5bO1/gpFLTsQTl3idMlxUbN06GaOMV5N4y2aoJtoPOwWHaCh+iIrkOB3PT4?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jNfbEl8mfC/RcQfdf2EuMNIMYQQkqhsYIuzLdVu4qa1HrRAUvn6dbZfDoyaN?=
 =?us-ascii?Q?Nb9A0H63/GOIi5Vj56AgQ+Y/R4AdPNb7H9LK6X7E+cAwMUZ2OcQr6oj1XuT1?=
 =?us-ascii?Q?9/3Kdu8/YkJxaAnTskwWXjScgJYXSf7VSJ7pTve5MzESeQ5nFkxggyImXG/c?=
 =?us-ascii?Q?40sxT3P9RAMYpbWSTovk5Gfig/TxIX7ophqMDH4HxBk1pmb9nDNxOQUJk+gF?=
 =?us-ascii?Q?0ymI4Bd03dvB8uaX27pK8xdnyxGxWAP4CZDQsBNea4bCXwMKyqlFjR6Zx1fP?=
 =?us-ascii?Q?fIbm4NE9dcjrZR/g6lVKJYJGwmvOO/QqywbYMunjcufsCvgOQc+pjNgp3FME?=
 =?us-ascii?Q?otguOhXxyWSa83xEsnLiWUh03ULXahP+40LzixQqt6sDoj2/HADXMGRtOaAA?=
 =?us-ascii?Q?qaWmhBK1FkVqCZ9Ut6+DafOhtAFykhyR0mPhkjRq11RNBrBM3lTEBBkXxgD/?=
 =?us-ascii?Q?w949LoNxVH/kN2ZKcDOwlAXrQGVjK7X5kfDcTjcD7UDvzFZbqBAMC9EEyZmA?=
 =?us-ascii?Q?Ww2i1WYKoiZZ83lOfR9FwRT9lECy/kmyhHlRcJA8mLEjSXrEylS+RXSfdaKl?=
 =?us-ascii?Q?Rpv2hCNDzvqEQENu7vaJxArsWvu8BXbrnnWdiMZcBZAQ7/jvSTlbe1TIAWfE?=
 =?us-ascii?Q?cLI8PvFZEfWSeYVfOLBz/gLWMWuwRPEVhxjK8nxJtZ5qX0wTp7EHmfAISFeH?=
 =?us-ascii?Q?YeLYwPI8BhDru9sOI3rd6+6zgOCJpYnUmFRI4InKYrwzUvX6w+dn0+fTpI5T?=
 =?us-ascii?Q?gpWA7ipeU9NljagnABZ0cuFkCEn6G+aFH5sBjVx/U9ibbuRW8lF0iRRtrfBE?=
 =?us-ascii?Q?bH4CqZTeZhirOJjuAXmXpzmfAp86E50S53YrdVfDW1ktV/bC2fXtAn8Hq8e8?=
 =?us-ascii?Q?hCZvSGCN1wDNnxNHfPxUdp+TaVvfkX99SPVcPyl1rxbKUyKsnvclyy0b4tIY?=
 =?us-ascii?Q?iUt4owDGAkEXObY2i7tOZDazMtto3rZDQBJk4tr3/rRaICKLtshWXgos+6LF?=
 =?us-ascii?Q?ma/XR+cVSSeYnPIfcTQKQ67RPQaPHzUhB9l0NOn7Eh8LeLsCCZIzwYzlPqIx?=
 =?us-ascii?Q?7+Ssj1M5WiuxjzQ51WXoupQVre1Hi7qPadLQXh0ZKV7VurxqbFsAJHb8UUFw?=
 =?us-ascii?Q?pBgXLQmhyI6A9HpgEuU/7a/nR9OWxPy80Tgtakf4Kme+7T98rTwuvN4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410b1267-70bb-45e5-97c4-08dbb0f5f335
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2023 05:30:59.8953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFvbm8Y1IoHeCo27Qfwn5oYeyT28rQOHqRqSCV+tf4wxhAUKXcxsAFUIjFZ7YQAqpBd8krZz0XXH3J3pvJWktb8kErGfKXlCdLGcPo4hweY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=789 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309090047
X-Proofpoint-GUID: 4ajkyw7Op6S6PF45yzltOsqj761CBsOk
X-Proofpoint-ORIG-GUID: 4ajkyw7Op6S6PF45yzltOsqj761CBsOk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 8 Sept 2023 at 00:03, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> Which on a PREEMPT_COUNT=n build will cause preemption while holding the
>> spinlock. I think something like the below will cause sufficient
>> warnings to avoid growing patterns like that.
>
> Hmm. I don't think that warning is valid.
>
> Disabling preemption is actually fine if it's done in an interrupt,
> iow if we have
>
>         allow_resched();
>            -> irq happens
>                 spin_lock();  // Ok and should *not* complain
>                 ...
>                 spin_unlock();
>             <- irq return (and preemption)
>
> which actually makes me worry about the nested irq case, because this
> would *not* be ok:
>
>         allow_resched();
>            -> irq happens
>                 -> *nested* irq happens
>                 <- nested irq return (andapreemption)
>
> ie the allow_resched() needs to still honor the irq count, and a
> nested irq return obviously must not cause any preemption.

IIUC, this should be equivalent to:

01         allow_resched();
02            -> irq happens
03               preempt_count_add(HARDIRQ_OFFSET);
04                -> nested irq happens
05                   preempt_count_add(HARDIRQ_OFFSET);
06
07                   preempt_count_sub(HARDIRQ_OFFSET);
08                 <- nested irq return
09               preempt_count_sub(HARDIRQ_OFFSET);

So, even if there were nested interrrupts, then the !preempt_count()
check in raw_irqentry_exit_cond_resched() should ensure that no
preemption happens until after line 09.

> I've lost sight of the original patch series, and I assume / hope that
> the above isn't actually an issue, but exactly because I've lost sight
> of the original patches and only have this one in my mailbox I wanted
> to check.

Yeah, sorry about that. The irqentry_exit_allow_resched() is pretty much
this:

+void irqentry_exit_allow_resched(void)
+{
+	if (resched_allowed())
+		raw_irqentry_exit_cond_resched();
+}

So, as long as raw_irqentry_exit_cond_resched() won't allow early
preemption, having allow_resched() set, shouldn't either.

--
ankur
