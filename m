Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0034B7CD2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 06:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjJREgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 00:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJREgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 00:36:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3B693
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:36:16 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HJxMVW018261;
        Wed, 18 Oct 2023 04:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=38mRKxm//vCEsPRWfftvMJC+dlz7U8aHLUM8UTVCWMs=;
 b=01mfIupPFTR8kE6zvifyqliDFf0j9p+Z9gu8sEdmrHULH11CjNRvHeZdxNWTVZBpOj6F
 pwZldFsRVgDpM3TBIQSZe5PZvmIWI58GjzravX3glZpG36megkW2BWweOvONgshc10K0
 MeaLfSZCW/BEcB9bUTUQEI8YfZr50vzUMkjhsZOPVIZS0oSCjLjrhcS+Q6zargcU013h
 7kVqiJC5/1ecZHlhI4jeDedtyl1Ofnsgw8U4DXSrvLuAGalopWfCM6ruewhtPq58Ih55
 AkmeurpsW08OeGkU9p7qHgKkTi/6/fTA7ZB5PNKinLzy2DwcALXPCEjbCMGwcWNsf9HI pA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28pq94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 04:35:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39I1xMQ9015234;
        Wed, 18 Oct 2023 04:35:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1fy2qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 04:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+lc/DEKtV2062MA5ShxYc6NrijMWHbLVPD3wnDK3NyEyYxT6x4shBYV42qdDjpV5nFmCL9mQrlJnZv9h+f5Mg0reu2IQBBERrsc+6saSxZH2fqXM6dQIKvw0HNClRP5c3GNc9Ipao6QrngF2FTZIJ6eh+PRJSrOBTdojobpeKk/QQttEStGSbScoisVFM+U0GjXQqHxg4dCY7nDIkaZ7Cp5CvfmduTE2IelKbKLnAurGwd75hNl8MqG6gjYtSvnaXqfJBRCHehWC3LBdVbpd2v8IUlt/gxKhk3hK4A2LMctyoa7sfERriaYK7zZZVWGYyUApNzeZLN6YGovsOcByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38mRKxm//vCEsPRWfftvMJC+dlz7U8aHLUM8UTVCWMs=;
 b=D1/+1YsyepAEJE4LUAleqtxxF0bN8GgkvBLUyXcRHgF0V3QAetbvpY+xsWBSBK4OeQVa2GxoQDu/ridm2ZOIawexSy/BAABmICV5d5BCSrADy0ZqrqdwPt931QKC1ga76tf6+WxDgWUDAQfvaFtw3kkkCWMdkSV1O7j0Nbi5eU1CQbnwwtS54TCTuCxU37KQ977dBH7EpUUJO3IwZzNJfXBPpdYy7pXwf0Y7FLHcUTVcnyIQaRfVXH50o/H3et4WOmmBtsQc4ObzVXDIDwzDYjHKwi/dL6tAZw3PG5D5Mb4pOtvEGCVrvoNUi8xFrVZiPyiiH7jG7NHPes0wQmfS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38mRKxm//vCEsPRWfftvMJC+dlz7U8aHLUM8UTVCWMs=;
 b=yCgI+cRwqaGtc+0bwbElZu05l7alod7fI3CcZCTUaiSDJw3Lvunr+7zkXQvGHXm5+tQXbFolLaa4cKUAWfI6CsEdyOp/N6om1mqiNS00uJQV7jTGSzRn/EXJw5cMBvabNEqTwKZo1oNWDIV+7Ej38fi7yFBeFUFuFdZz3KTmmAQ=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS0PR10MB7269.namprd10.prod.outlook.com (2603:10b6:8:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 04:35:52 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 04:35:51 +0000
Message-ID: <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
Date:   Tue, 17 Oct 2023 21:35:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
 <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:5:334::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS0PR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: acc00937-2802-40c0-a350-08dbcf93b50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tq1PUbIIpXf9oDmpXfO9pZdslelINI//0scnr5+jjIMkjI/u3msDcjXruVxe4Y+dvUvliVES18F40vi8dzuDeX5xRaPcQcQuW8rIRm2zRJrtrB0TmNCkC3sstgbYAOnuFOZ5Xuz2FYbpOigIdrBu4BD4zUECh0BmN4eQrKM6JNgfpNRLF63qU+agM9tlXLBYTRLTj/zO0A22jkpx7eDO2W4dWdHyuvzIW8qdgleGJ35VoWksW3ogBDUyFvScJ2K7TW6M25KHM+JvUujJyYxeN9oBEnb+uikmgI9RBPBHGFXW5IJyQxPJN1Qsyfoqn4HskXVM7eWus2b+YtRdZpvzV4eL884uQMAN8XBVR7SkvtPIvSHY61SzYmpoeJSPXiYn8/kdRb+idSsqZspfsqt3r6B1Y6ib09iTrT+R5Blj8S+xRX9cXoBtUq/uqdCt1pVH9R9CqyprjLwCXqnkPnrVwwyJopSeGQxHYMOSPtJM7Ks3gaF2KTiumk7YlMKj/zqToCOy9wFZNeShbZQnOrWi5znCxveIoyDaNdplr3rfHJPTMWj3jCvOPXY32nyb3iM5StvL/6UAP28jVW0gdhUFG2EdeDZaTGoz/4BLyWo/J8TPp8O1FufWhoauu0NxdoMPqpx+cCzy3IRE+4y7ZgYqDgGEgsrRl1VlnGyGP0BeWG++V9Qa9fYmd824Ue/qMdErMwBKhWk4KJNJW5OGeC9ELA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(966005)(478600001)(6486002)(66476007)(66556008)(66899024)(316002)(6916009)(66946007)(83380400001)(26005)(2616005)(31696002)(86362001)(36756003)(38100700002)(6506007)(36916002)(31686004)(53546011)(6666004)(6512007)(2906002)(41300700001)(8676002)(5660300002)(8936002)(4326008)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEVnTHl5WHFjOTZlUmg5R2pjMWxONkdiK0hLUEdnVXdkZWpFZkN1c3lQMVVU?=
 =?utf-8?B?blRQRHFaUmU2Y2tBNTk0dFU0aFkxZ0VoWDE1K2pYSWtYYy9jZjZVWjhsUkZt?=
 =?utf-8?B?cXgxMloyR2I2RGZidnJXRTFnczVhSnVJQzA4WEhlL0RBdjVKY3MreUJ0YXFy?=
 =?utf-8?B?ak96SWZKcGtYT2U4aXg0SkZad0ZJSlJqdlFFaU5RaGFmbWd3VXByeU9OUTFi?=
 =?utf-8?B?V1lrRUpPdGlUREdHVU1HWW81WlBPaVdQS0tuVGJtcEovVnkrQm1pQVUwSlVl?=
 =?utf-8?B?eThaVFZFNHhZaTdwWjBJZUI1clJmWjEvVEwvSTBCRzZ1aXZjajl3MzlMT0Jl?=
 =?utf-8?B?cnZoZ085cXozeSt5S2NzV1VPblhUOGliSGF2bDNybFNaWE10eVB6ckZ2Z2tu?=
 =?utf-8?B?VVZhbmoyeGM2c2FrWERrcFJabUpzYk1pK0oxQnlLOEVRZkFpRWhNSGtaVnhi?=
 =?utf-8?B?SjBxUnFESzFoZC90cVJjSUFRbkFZeE43QjVvQmFSYlcydkpGRTVYNG95NG9U?=
 =?utf-8?B?clEzbGFiaEc1MVlCVzZaeHA3M2pvZGVNeUU1ajF0R3RlSHBVK1Y4dUFTWUhH?=
 =?utf-8?B?WGxPSU1yWmVVUkN0QmRwVWNhdWdmSWg3ZTBzVGc2Z2MzWHhuYmsxczFUVG84?=
 =?utf-8?B?Mnc0OEh3REkwSjZsZHU4YzBZUWo1YWJNZ0QrbXMxeG9vdmZJRzh6ZTJ1YzdX?=
 =?utf-8?B?dW9mSStEMWFibTB5c0haTmQ4SyswVWtCeWZidGFmdmtwVU9JS2lNQmdMZVU5?=
 =?utf-8?B?dlJoYWNSUENwUkpNTTc0OFdkS29OOHNwaGgrWHpWcEUrdjRrNG5ySjN1bFVU?=
 =?utf-8?B?WVoxVVc4cGpoRHgwLzdiRk0yaEFyZFkvdWpqcjdyL3JIVDBpN1IrTEJSRy8r?=
 =?utf-8?B?bHIzaHR1ck9XT2hjYm9zS0hmQ0t5c2NvWnJzbDY2VzlxMzZWbzJpRTUvbUY1?=
 =?utf-8?B?bHZPbFo4R3lUdFV1TG1RY013eFRRQnBaNGRPR1d3ZHVzSnpHNm9JdGFWTmdh?=
 =?utf-8?B?OHp6Q3BEZmNpZ0lBS0tQZytDWWZoVFcxTE1YeVN2cFhkeHJFUm01cXdtcmVp?=
 =?utf-8?B?bEFSRGVYZCtsRUVhRDJ0MzNwNUZBQTJ2UXNmd2x2NUliZjgxdnp2SmFoZ1NL?=
 =?utf-8?B?cXdLUUlsZnpYNjNRN2IvOWwzcnZmQWJ0TGFjRFh3WGt5aHR6UFRqWGx2cllT?=
 =?utf-8?B?TUZRbnlCSWE1YzUzUGZPNmxQUmEzZng0WXlCQXN1YUtlUXZNQ01IaEhYU256?=
 =?utf-8?B?clJBQ2FwS2VBbllDWmVYU3cvRTVXZ25vQ3Y0VWZOV0hOL09SMVpxM3dYQnVC?=
 =?utf-8?B?bWpTRFlmZmc4WW5rRkJldFZhdUp1RnFlbkc1N2Z6M3BMUXZBMTByTS9YU3dy?=
 =?utf-8?B?ajUyMmRwY0YzMU0wM3duWWdDbmZQZnRodHV4UzNIbFRUVHVFNUhSV2YrZXh2?=
 =?utf-8?B?Z09ZcFBNUTVIVFBKSGZEc243R2tEbGpVd3JvVHprMnhxVlBSdHBUZUJ1RWpu?=
 =?utf-8?B?ajhNMll0Wm1rdDNabGJxZ0x0WDZNREpiVytrcXBjMitBWFdBek1yVVJJV2Jz?=
 =?utf-8?B?TXZONkRUMTlYdHNibjBqNXQ5akcxSWRtcUtIcWV6UUlUNEJxV3NXSFhFUWtN?=
 =?utf-8?B?UnFaanpuS3BvUGd3cVJSTVZiQVk1ZjVsb1N0LzJ6ZHFRRys0UDgwelFLVjBB?=
 =?utf-8?B?ZVVha0FCZGhpak5vNG96a2J1SUR4S2JQaEYwUGFVTkRVSnA1eW03NzA4dGVG?=
 =?utf-8?B?eXVucXdIMW05Q0pHOWErenNUdjBFVjFVZHFNL3FvbEI5emc3WFkyaEkweXhy?=
 =?utf-8?B?SUtHelQyTGIybS8rakYvSEpUM0xjdTFXc3l3dzI2Y1dhTGxKeXVNQkZPOStZ?=
 =?utf-8?B?OTZLcVlvTTNUUXIxdHVVWVlDWG5DaHJza3R4ZjI4SU01aE1yQVVjYUdyeGgw?=
 =?utf-8?B?TFBNZlZ5VThGRkZWbVNvRnQyaDFRYWI4aGxaUmpBai9lMGhJRG8xYjN5TUZx?=
 =?utf-8?B?Y21GU3BuQjZJdmVIVEh3QURnaEpPZFdpVTFOVGd0b3ZlYzVrNnFLRlpCK1Fx?=
 =?utf-8?B?Sk9GdkhWeDBZZ2ZUMW1CWUNhVEZObVhYQU90YkF5WVRwYUpqY29LVHNQYmlC?=
 =?utf-8?Q?aecuHm6AfJKeECThiLD2K/brL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N1NMU2dONXJtMWdrRllSZWt5Q2NIU2xtV3hWc3MyMWx5Q0pkMG1EREcyTlJV?=
 =?utf-8?B?Z2lRWHJCQ3JEamtEeDRMMndBS2U4NjBPckJyK1YxaUdENmNmZjBHQXcrbjA2?=
 =?utf-8?B?TWVEL05VNWx2ZTBCcks1WkUxcks4TlZyN0NFZ29pQWM5bjBYK3JkdklKMUo2?=
 =?utf-8?B?bENDOXFteDdvZFZ1M0dKdXk5UFZDS1AwSjFWeEZQdWRlV0V0QXExWnJtc1pu?=
 =?utf-8?B?YjU1WWhEeHRDeFRYUi9DL3I4bDRtVTRBTUlBZEVwdzNDcENLNGhzV29qckdL?=
 =?utf-8?B?UGRzS0pMVERNUUk3RzU4WXd3UlM0dlhXWlFwTnpXV0dmUzQrU1ZnWW5nWkhu?=
 =?utf-8?B?cFdHbnZscXFwQnJVQkQ5TUNiTjFuWWdibTVTOHpYS25DTGdZaFdGelJEVU56?=
 =?utf-8?B?aTZkc0dCdnNUQW5hb3M3TTJuYnE3dkIzOFlHa0x1WDdwaFBTa3hRa3RyV3A4?=
 =?utf-8?B?d204OVI1cThkQkJyY3luQm9KSGNiSGxrTXN0Y1NQNm9kNVR1RE5WNlAwUTNN?=
 =?utf-8?B?Sm9ZaEtKQ0VPbGgvZFRqOWNrRkhqSVM0YXRFWWxZSmIxb3Rxdy9Ld3lkVzhO?=
 =?utf-8?B?VHgzKzMrN1lSN1RpMENUdi9wWVR6Rk9DMjFUVGZyR1IvbHFpYWxkWmkzYXpV?=
 =?utf-8?B?WldiQmZEbE94TWJqcWJHZEcvRUhyQndGcVFlSGZZWVZjTkd3Y1VFbUZYZWNn?=
 =?utf-8?B?b2d2dFRiZWNKUUp1dThNZzAyK0gyWGYzejZzN0krWkViS25lZFZsenRRVEJR?=
 =?utf-8?B?c3dlOTVuaWVPRlNrMTBCUFdqZXByU1NHZjhwaFRDMnFVakNJdHRVMkNuVjFo?=
 =?utf-8?B?RXRxdTVzclcwdzlMb1hZdTF4RFUyYVNwdWhCTXJMUzV2SXNnV1VWdG9EUXlE?=
 =?utf-8?B?a3RNMWdZaVVmUDkvMDViMTVqQVZmdkRZUXNKT214dlo5SDQ2T1RVc2VsYStl?=
 =?utf-8?B?YU5KV3loVFRpSUwxZHpRWjA0SHZMNkVCOUZjelR0S29mK0hxd3ljTENlYVlX?=
 =?utf-8?B?QUplTjdGSFpocTJncEo0SmIzSm5JczMxNWRJcFZLVURVbGxYUjlHN2pwazlU?=
 =?utf-8?B?M1I2T1cxaDNlWUZBb0s3N2kxWjVOLzZNcXZTVkRZNEcrb0VrbmxPWFNFazJL?=
 =?utf-8?B?bDB1S05ZcFJuUHBTa3dsSDJKOS9OdFNyMmRWeE5KQ3FXOSt1dWpHWlZCNE9w?=
 =?utf-8?B?VzFrRSt3RFBRTk11TmZHb1psNTlHT1JZSUo3WE1UL0luaTNGcTRPQXNZL2ZS?=
 =?utf-8?Q?4aZiRJ8sNzYbEXl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc00937-2802-40c0-a350-08dbcf93b50f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 04:35:50.9539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AANXxWT7Ib+iZcBf2vdXr6JPOUBWeKh/n9RFvxVMteZuNk4oxLtzpFMbk05D+Tsw4J23qlZGxw6BsHaNcw0Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_01,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180038
X-Proofpoint-ORIG-GUID: l3jWM3rlCtvQ-pm2Mhzq4fIm8vhAS6f0
X-Proofpoint-GUID: l3jWM3rlCtvQ-pm2Mhzq4fIm8vhAS6f0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2023 7:35 PM, Jason Wang wrote:
> On Tue, Oct 17, 2023 at 4:30 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 10/16/2023 4:28 AM, Eugenio Perez Martin wrote:
>>> On Mon, Oct 16, 2023 at 8:33 AM Jason Wang <jasowang@redhat.com> wrote:
>>>> On Fri, Oct 13, 2023 at 3:36 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>
>>>>> On 10/12/2023 8:01 PM, Jason Wang wrote:
>>>>>> On Tue, Oct 10, 2023 at 5:05 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>> Devices with on-chip IOMMU or vendor specific IOTLB implementation
>>>>>>> may need to restore iotlb mapping to the initial or default state
>>>>>>> using the .reset_map op, as it's desirable for some parent devices
>>>>>>> to solely manipulate mappings by its own, independent of virtio device
>>>>>>> state. For instance, device reset does not cause mapping go away on
>>>>>>> such IOTLB model in need of persistent mapping. Before vhost-vdpa
>>>>>>> is going away, give them a chance to reset iotlb back to the initial
>>>>>>> state in vhost_vdpa_cleanup().
>>>>>>>
>>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>>> ---
>>>>>>>     drivers/vhost/vdpa.c | 16 ++++++++++++++++
>>>>>>>     1 file changed, 16 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>>>>> index 851535f..a3f8160 100644
>>>>>>> --- a/drivers/vhost/vdpa.c
>>>>>>> +++ b/drivers/vhost/vdpa.c
>>>>>>> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_alloc_as(struct vhost_vdpa *v,
>>>>>>>            return vhost_vdpa_alloc_as(v, asid);
>>>>>>>     }
>>>>>>>
>>>>>>> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
>>>>>>> +{
>>>>>>> +       struct vdpa_device *vdpa = v->vdpa;
>>>>>>> +       const struct vdpa_config_ops *ops = vdpa->config;
>>>>>>> +
>>>>>>> +       if (ops->reset_map)
>>>>>>> +               ops->reset_map(vdpa, asid);
>>>>>>> +}
>>>>>>> +
>>>>>>>     static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>>>>>>     {
>>>>>>>            struct vhost_vdpa_as *as = asid_to_as(v, asid);
>>>>>>> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>>>>>>
>>>>>>>            hlist_del(&as->hash_link);
>>>>>>>            vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
>>>>>>> +       /*
>>>>>>> +        * Devices with vendor specific IOMMU may need to restore
>>>>>>> +        * iotlb to the initial or default state which is not done
>>>>>>> +        * through device reset, as the IOTLB mapping manipulation
>>>>>>> +        * could be decoupled from the virtio device life cycle.
>>>>>>> +        */
>>>>>> Should we do this according to whether IOTLB_PRESIST is set?
>>>>> Well, in theory this seems like so but it's unnecessary code change
>>>>> actually, as that is the way how vDPA parent behind platform IOMMU works
>>>>> today, and userspace doesn't break as of today. :)
>>>> Well, this is one question I've ever asked before. You have explained
>>>> that one of the reason that we don't break userspace is that they may
>>>> couple IOTLB reset with vDPA reset as well. One example is the Qemu.
>>>>
>>>>> As explained in previous threads [1][2], when IOTLB_PERSIST is not set
>>>>> it doesn't necessarily mean the iotlb will definitely be destroyed
>>>>> across reset (think about the platform IOMMU case), so userspace today
>>>>> is already tolerating enough with either good or bad IOMMU.
> I'm confused, how to define tolerating here?

Tolerating defined as QEMU has to proactively unmap before reset just to 
workaround the driver bug (on-chip maps out of sync), unconditionally 
for platform or on-chip. While we all know it doesn't have to do so for 
platform IOMMU, though userspace has no means to distinguish. That said, 
userspace is sacrificing reset time performance on platform IOMMU setup 
just for working around buggy implementation in the other setup.

> For example, if it has tolerance, why bother?
I'm not sure I get the question. But I think userspace is compromising 
because of buggy implementation in a few drivers doesn't mean we should 
uniformly enforce such behavior for all set_map/dma_map implementations.

>
>>>> This code of
>>>>> not checking IOTLB_PERSIST being set is intentional, there's no point to
>>>>> emulate bad IOMMU behavior even for older userspace (with improper
>>>>> emulation to be done it would result in even worse performance).
> I can easily imagine a case:
>
> The old Qemu that works only with a setup like mlx5_vdpa.
Noted, seems to me there's no such case of a userspace implementation 
that only works with mlx5_vdpa or its friends, but doesn't work with the 
others e.g. platform IOMMU, or well behaving on-chip IOMMU 
implementations. The Unmap+remap trick around vdpa reset works totally 
fine for platform IOMMU, except with sub-optimal performance. Other than 
this trick, I cannot easily think of other means or iotlb message 
sequence for userspace to recover the bogus state and make iotlb back to 
work again after reset. Are we talking about hypnosis that has no real 
basis to exist in the real world?

>   If we do
> this without a negotiation, IOTLB will not be clear but the Qemu will
> try to re-program the IOTLB after reset. Which will break?
>
> 1) stick the exact old behaviour with just one line of check
It's not just one line of check here, the old behavior emulation has to 
be done as Eugenio illustrated in the other email. In addition, the 
emulation has to limit to those buggy drivers as I don't feel this 
emulation should apply uniformly to all future set_map/dma_map 
implementations.
> 2) audit all the possible cases to avoid a one line of code
>
> 1) seems much easier than 2)
You see it's more than just one line of code, and I'm uncertain if the 
additional complexity is warranted or necessary, particularly if added 
this piece of compatibility code will linger for quite a long time. 
Instead of adding hypothetical code change for no specific good reason 
and no real use case, I'd like to add the code when we find out a 
specific use case that may get impacted or already being affected, then 
we will have good understanding how to code up the fix and emulate 
properly for compatibility, while not affecting other good implementations.

Thanks,
-Siwe/i/

>
>>>> For two reasons:
>>>>
>>>> 1) backend features need acked by userspace this is by design
>>>> 2) keep the odd behaviour seems to be more safe as we can't audit
>>>> every userspace program
>>>>
>>> The old behavior (without flag ack) cannot be trusted already, as:
> Possibly but the point is to unbreak userspace no matter how weird the
> behaviour we've ever had.
>
>>> * Devices using platform IOMMU (in other words, not implementing
>>> neither .set_map nor .dma_map) does not unmap memory at virtio reset.
>>> * Devices that implement .set_map or .dma_map (vdpa_sim, mlx5) do
>>> reset IOTLB, but in their parent ops (vdpasim_do_reset, prune_iotlb
>>> called from mlx5_vdpa_reset). With vdpa_sim patch removing the reset,
>>> now all backends work the same as far as I know., which was (and is)
>>> the way devices using the platform IOMMU works.
>>>
>>> The difference in behavior did not matter as QEMU unmaps all the
>>> memory unregistering the memory listener at vhost_vdpa_dev_start(...,
>>> started = false),
>> Exactly. It's not just QEMU, but any (older) userspace manipulates
>> mappings through the vhost-vdpa iotlb interface has to unmap all
>> mappings to workaround the vdpa parent driver bug.
> Just to clarify, from userspace, it's the (odd) behaviour of the current uAPI.
>
>> If they don't do
>> explicit unmap, it would cause state inconsistency between vhost-vdpa
>> and parent driver, then old mappings can't be restored, and new mapping
>> can be added to iotlb after vDPA reset. There's no point to preserve
>> this broken and inconsistent behavior between vhost-vdpa and parent
>> driver, as userspace doesn't care at all!
> It's a userspace notice change so we can't fix it silently:
>
> https://lkml.org/lkml/2012/12/23/75
>
> Another example which is related to vhost-vDPA:
>
> https://lore.kernel.org/netdev/20230927140544.205088-1-eric.auger@redhat.com/T/
>
> Thanks
>
>>> but the backend acknowledging this feature flag
>>> allows QEMU to make sure it is safe to skip this unmap & map in the
>>> case of vhost stop & start cycle.
>>>
>>> In that sense, this feature flag is actually a signal for userspace to
>>> know that the bug has been solved.
>> Right, I couldn't say it better than you do, thanks! The feature flag is
>> more of an unusual means to indicating kernel bug having been fixed,
>> rather than introduce a new feature or new kernel behavior ending up in
>> change of userspace's expectation.
>>
>>> Not offering it indicates that
>>> userspace cannot trust the kernel will retain the maps.
>>>
>>> Si-Wei or Dragos, please correct me if I've missed something. Feel
>>> free to use the text in case you find more clear in doc or patch log.
>> Sure, will do, thank you! Will post v2 adding these to the log.
>>
>> Thanks,
>> -Siwei
>>
>>
>>
>>> Thanks!
>>>
>>>> Thanks
>>>>
>>>>> I think
>>>>> the purpose of the IOTLB_PERSIST flag is just to give userspace 100%
>>>>> certainty of persistent iotlb mapping not getting lost across vdpa reset.
>>>>>
>>>>> Thanks,
>>>>> -Siwei
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com/
>>>>> [2]
>>>>> https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bfe5473f1f2e@oracle.com/
>>>>>>     Otherwise
>>>>>> we may break old userspace.
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>> +       vhost_vdpa_reset_map(v, asid);
>>>>>>>            kfree(as);
>>>>>>>
>>>>>>>            return 0;
>>>>>>> --
>>>>>>> 1.8.3.1
>>>>>>>

