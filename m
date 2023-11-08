Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF497E5840
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjKHN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjKHN7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:59:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951A71FC1;
        Wed,  8 Nov 2023 05:59:09 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8ChUUR004013;
        Wed, 8 Nov 2023 13:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ds9mx2lVZt+19yBzOeKlV/1hVlhhApvcIiUtUSReWdk=;
 b=vVsVSy4TlW7Qg1QK57DLHZzhpsxCnHhRlLRuo+2y+uiSRGsVyNWiSZ31vt0iThtY2prB
 ELg3kvXWISYltC1gsHaqHQJm66OBZEx6qAYW6TfhJCgrHCw3kBzwXl9RQDCwTOXHOWBx
 jPl39w3wnnq7tMSLZ94Htq3hwBn03u+VM0WtYLiUID9Omyzu3jqBwkDMtKiDmaH9TCEB
 LUd43Q0+OuoAY493QFEd2rW6ozXy2aBOhsQ8GQRE01OB8L7hlC9DMRFO11630iOadGys
 2Lx2tIVxpcE0Kkw8lPhtrefdB02bJK0uBrtlXS3oWjNFoCY5NHsHJYN9W5RzcVZdlkKB Uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22hgjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 13:57:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8DeI4h000495;
        Wed, 8 Nov 2023 13:57:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1w9682-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 13:57:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKmJigErxVglSGHV7lf5KRHXn8xJvceQjLHpM+G4xdEnIrFt/Nkap4cHCsHqfhXDaV+oNaEysxubGNBoBZqnFuAUKJxjLWY+30E6Qp66LX/+ShoVLsLu0jyPwcrUuvL13uqn8bR0NF6mlKXHBtMU2I/7bSFasfzWg8Aoby0H1rbqN4Bxqde39wxtc/Q0XlQlakBSRYD10ZvkTeEOTx+ii1pQPqjUBML/4ixP3Fef9tKD6GX4gzWtp/0TBTRGkh1HfiGTo1ZbvicYwT7hOB5zRcp6EEGGHBuxTqMbDEGlPqexqyfvZrFVPI+Qw2bnHYWyZr48Z1KYmw4saUsHTHFUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds9mx2lVZt+19yBzOeKlV/1hVlhhApvcIiUtUSReWdk=;
 b=LW7mmC8mkerJylNcHR3jf0yDwR+OcSRY2AsYu/ivc1KTSDUX/JrH3ocwu/IHRXfdkGltFldQNFKlw+oFbRopGwtNgBHxf7F2Lw2SLY8Kui0WLlnHB+PkWjF0mFS8xOjwHTGz+RZnyMhwUP8Ajp/zH7CIjlkDDFEOZc4wXrBYWNLnxLuaAyGUqEiEd+brTnQnE6ucJQ5MQCVTSpRYHhTshpoBoZJP94B1PYKMwGrw88/6OAY/c+oljYGb6Nt+5cb7PFkXmDyx8cZtp6VFEkd58EJb9nmk4cRsnrJwAVhxSWamqj1D6WlIpon6KhhK6eM0ProQ7Vn5KtxguDRmVdcagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds9mx2lVZt+19yBzOeKlV/1hVlhhApvcIiUtUSReWdk=;
 b=DKXdyP6u1nPOPrNezEb4z0N51NX8C+c869jFS5FoZK3iPzft6Iz8VTNqfnX5389bV0DmxbUxBl1g6KlHCWfET74AtI+eUv3imdTyRUg84M0GwEiClb4QwjBXUz8TfmrZpuO2g9uMlyuT4api7Ldi/jl7dxwAq9u9+kb0ZAozt0k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5287.namprd10.prod.outlook.com (2603:10b6:408:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 13:57:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 13:57:06 +0000
Message-ID: <7912855c-c661-2b83-f19a-4ec6287ddb4b@oracle.com>
Date:   Wed, 8 Nov 2023 13:57:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 10/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic_main.c
Content-Language: en-US
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231020190629.338623-1-kartilak@cisco.com>
 <20231020190629.338623-11-kartilak@cisco.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231020190629.338623-11-kartilak@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0364.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 894a779e-d34d-46f8-9774-08dbe062980e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sT3HsfjGvll5l/H5WB718Z1b6tnOThIJxOd3NAjYW8O0wxE0P+JmfF36OahmNDjxfUNK78HxvMRa/gVAjxkTGMifOGbQD+A9FPRkqifIp2KOWOGKZZp0OKe3UqqmPjaGCuagjUGscCeKp9LnKVh+eKHlIcAMxSJeTbk8sj5gWFLuR5bK+OuVprDdPb41SjsSKFuJzbfacKlzb0DT33YGR2li/EF/O1tYki8YC8eXSnmKn0LypilXSrfLqGKJnafbO20sWiZy5JBWn4fXPla+JnW52F1zFTLV8lvfUKpsPz6K23V/AbOmnuhY0JPVLFAb9j35UopX/277oxX4xTemgEgsdXtoNCj+TTYjZFo9MMMhkIGkowhxTG9kzgXdMe2qI3Q45DR0yjAT4WM3oGm1OIop39vdrVpbhDr+cavXCakAxnyVYKBdChuf/7kAQ7//8J9rm8q7vaTXD0tgATmXuK04Loezq56KDoTlxoNnXw1AFwN3YJvv5q8YCzw3Q8P6bliDgP3D1mzL1GRHMQ6QMuyvquki0vnw8Cwqt+kCjyi/nMAt9elvngAWJn9K5UbdKCptSbYwGmvatRN82oTjtvtUXpsWIT//xdjbb2Rz/7r4yGFy16jcbZXBnyy5tfpUi2/H6XVUuNCIHGkifm8mMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31686004)(38100700002)(5660300002)(66946007)(316002)(66476007)(66556008)(8936002)(8676002)(4326008)(7416002)(478600001)(6506007)(36916002)(6512007)(36756003)(6666004)(6486002)(2906002)(2616005)(86362001)(31696002)(26005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHJnaStLOUV4YWc2L0hJNE1LRy9GMWFiYWtMZ3VWaWEzeDUzRmhPUUZ5cVNU?=
 =?utf-8?B?eUF5OWU5bU81bk5iMVBPNk9PZ0xVT3BCVWJ2Tjh0VFFmTG9zMkROaUhFbjRJ?=
 =?utf-8?B?VHJXNWo5RDJncUd4MGMwaUVHVlhkOEVnanpocDhodzNOZWt6MDBxcU5mcFVa?=
 =?utf-8?B?VDIvWkZma0JhdFlVd0UwNHR5cDcwY0xsWHhoTTRFNm9DYWgrdVFtWVNoQjNw?=
 =?utf-8?B?ZzE3dkNDRlg0MlhpTzEyUnNhWTRyTGxuczdkM1pkNVArbkYzWXE1K1QzVW4r?=
 =?utf-8?B?VjBzNW5UNFh1Wk9icDVKSENkNkMxaG1RcGZlc3ZlRjZwcDl2MjVmZU05ejcv?=
 =?utf-8?B?OWlmODlqSzVTd2l6V2pUaEtrQi9yaEE4VUh5OVc3QzZSL0hvMG9pdUVLN1Zq?=
 =?utf-8?B?dWx6M01oSm5aeFZtcDNXVFNlREIwTi8vb1pXemY5b3N2UDJhUjJHbjU4M1ll?=
 =?utf-8?B?NjZtRGVDZHZiSjNyL3dGSUFDYTM5M0p6MjREK2FDZGVNVVVoeGthSUdkY0Rt?=
 =?utf-8?B?cXRWbWlqTi9vdjluejNiT3RWT2J1K3YvYkVGUXRncWJYckF6T0hmaWdzM1FR?=
 =?utf-8?B?cnlGK1Z5WXlUZlNYamhFbXBLV1MwV3FtditmWWFJUHhSTFRjSWVTNFhaZDRv?=
 =?utf-8?B?YXk5WFJtdWt4TnhQRndTNHNOTE1BcjQ0SCtQdDU3UjlrUEJndnNQQ1Q3YS9Z?=
 =?utf-8?B?K3dIU201Y2pUekVEZExBWGVKTlBPQU1kQzJsMjlnTzJwWDhkUG1KdGhYQ1Z3?=
 =?utf-8?B?MnRUOXVNc3FsTWxpMlFiaVJUZ0FseXZCRUhaRHFTQW1kV3JrVlVVUTRVQmVo?=
 =?utf-8?B?VmIxTXdGYUNQc2FuUHk1Nmw4cnIyR1hZYmdJVTdoRTRiYTZFVzdxaWFISjRB?=
 =?utf-8?B?R2liK1haaDdrU1BvTXFvdzZXTURSNEE0SUF2RGxyU3dYZ0lPREdIMGZTQVhU?=
 =?utf-8?B?M2NkQ081b0ZkN3BTa1I0Y2RVcTBCNlhyMnpKUU9oUFNvd2VOU3doUkVnVlgv?=
 =?utf-8?B?bXpJUk03YzRZUWdqeEh5UE9sZXJJL0JpQ0xqSVVTeU85QTRDTHM4QmxsVHBt?=
 =?utf-8?B?QXEzS0RSNkU0SFJsTVhzZnN0ME0vcmlyNmFoMC9iMmtKNFMzR3l2ZVNkYkcx?=
 =?utf-8?B?MHE1dWFiTmVOOXZEOVcwTGtNVGRqK2NnZlZzNjlSUlZJeUF5VkozNHYySjFN?=
 =?utf-8?B?bElLdUM1SmRkQSsrTjc3T2s4SzVXOTc1aFhFaEw2d1pnZVl3YkhrbXZWTXhv?=
 =?utf-8?B?bjZqZ3NNZTBaRkpnWG4ydjJETVl2R3FGMmdXeHN5ajNrTnFXQzgzVVdBVUF3?=
 =?utf-8?B?ZnRCM1VnRmhiUjF4UUxobTlmOTRIT2hKekhKcDdzQzRZbXVZM2M4RjNrdDRU?=
 =?utf-8?B?Vnd5aFV6dStUWEd6blIxNXBaQ2Y5Z1hjZm1Tc25PNE9qSmlmZ2xQVk5OMG1p?=
 =?utf-8?B?aXo5VlFPcFJ5WEtwa2d0REtrbVAxbW9penZMV2V2NGNObE1GOEFzWmNVUTN1?=
 =?utf-8?B?VTF5eEVmdHhLWWw5V3M0MWFKb1dpTFRrR1VWTHZqNDdPcnEyS0VweUp5enlh?=
 =?utf-8?B?UWhqMEhuNTFnNFBrRjJhOEpaYVhZRytXazhSMDFmdGFMa2hFdWQvVUpaWC91?=
 =?utf-8?B?ZHpJVmNSMWx0WXpSNVZTOXQyc3dYTE5qU0lJdklnSDJaWmhQUXFLR2J4aW5k?=
 =?utf-8?B?Y3NjZHVTNnlPaE9nMDlEb2pxMS90eTV2T3RHMFB2UXpKNUxKaXBYcEtDTi9R?=
 =?utf-8?B?UnJLYndQM0hrNnlya1Q0ZHhzRW5HQW1JYlgwL1hEVUNlNkl3c1dDTTM2aUpM?=
 =?utf-8?B?QWVlTUxzT2w4aDIwWFNlUnIwVUFrdjVvK2J5bGZXY2IzZTlDd29seVhlcDlD?=
 =?utf-8?B?K004RkhwOTNOWDJBK2g1a0NqTnN2SDFwcklIK3I2d2wxUVBOSTkvTkpEQ2Ev?=
 =?utf-8?B?R1ZmZWsyaTRTZnV4SHJsSVJvcEVIOVZhbGEzMHYzbFltRWpocnpxT3ZJNk1M?=
 =?utf-8?B?eXZ6bjB4RDdxQkRQbVV0RXhYTURIQUhhMnpJeTFtMERaOU9TZnFpUXRyL2hK?=
 =?utf-8?B?NEZ3TUN3UEJDdDVSd3VBOEJGNldiYWxqTGIwdm5iMzhoNDJranJRL3Zoc085?=
 =?utf-8?Q?RiY7wPtxuZ5/ie1d2IFlSBPow?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pqdVndZO2WIjfWHmBq1Gi2o8tsQ4/cWTZIT20FqQbNDEyQjBW+qfNlTHGeGPLVVRlupLLR6nLR8C3H046+GIPvmmrgfldMT4gp2pJXKkDfkU9KkWwwAJ51DGiypXQ+BzaSXzcf2CWRPjMZchaO68pURIaZwdScg2GGpQxq3n67ucEZhaEonx19ya/QoKe0j/pb5garDINnMKkS9LvmM0a7ugFLnUUg83LIn0NGACH25Hn3QteTP9xf0/2YklqZ3grHkfbMYFC3f6d0lzkKfxKSjVrkDCygl7y3IGQTStSFor0MabtpSgOjw27MXdZZj01mHrba7witvbKOwcAOJtFH2mB2b+VVaGxFi6dPnhjIk/Kc7sAo/qWFPiLLbAHuWQNA9VPBd6HqpMjCj9Wh1GDqxDCbOC4elot9eLGSKpg5fUnpVsSMSrELKpEJQAXvoyZZ6CrFLf7NahSEkPKgx64iyO4pqkVkYqJPLHlJPR1+XRv9H8IfCc86oytNqY0up8wsoMbqaJn9GxQhFt8AwwjlvnFWawL3Bu+3AXLRqbAlxwU2vEGmcgRuiXO3xc0OSrEnk60oJHL2ejL+ZZ32mJcmL/HW1Elm9MJyZRet6DRyRo4a+zGB5myzuZ3uf/P4lCU/QELqaSx22RrKx/5OKfx41JOrzDZu22tKA7jNFcQPIEQICnnBgoFJfXexXJTxdNDb7QCDrkhxW159RD4WPEQOeF1Li6J5wEh++TZSyOrrgSmAoQgsOoh2vrMrfAZ5n5CcCuhN70mVsbjjkDUy6yILnFhYLEMr8RS6xPmpVIWLioAh/uJrtAlL1N10iSaOAXRcgD1Tb26VFRgHZM3By8Iw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894a779e-d34d-46f8-9774-08dbe062980e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 13:57:06.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o0ZCLmvX53MDO/QUAHZHNisAlQxi7LOIcQzd38EQr2+PcRJa23mZf4rgCmEhPnfol1+f5vhdUOAlMnli6l6nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5287
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_02,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080115
X-Proofpoint-ORIG-GUID: 8cvQhjnA7UvXqt6RiLBkdtC7ka0z9kFi
X-Proofpoint-GUID: 8cvQhjnA7UvXqt6RiLBkdtC7ka0z9kFi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   static void
> @@ -392,7 +394,7 @@ static int fnic_notify_set(struct fnic *fnic)
>   		err = vnic_dev_notify_set(fnic->vdev, -1);
>   		break;
>   	case VNIC_DEV_INTR_MODE_MSIX:
> -		err = vnic_dev_notify_set(fnic->vdev, FNIC_MSIX_ERR_NOTIFY);
> +		err = vnic_dev_notify_set(fnic->vdev, fnic->wq_copy_count + fnic->cpy_wq_base);
>   		break;
>   	default:
>   		shost_printk(KERN_ERR, fnic->lport->host,
> @@ -565,11 +567,6 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
>   	host->max_cmd_len = FCOE_MAX_CMD_LEN;
>   
>   	host->nr_hw_queues = fnic->wq_copy_count;

Please be aware of comment on nr_hw_queues in scsi_host.h - maybe it is 
relevant to this adapter:

"the total queue depth per host is nr_hw_queues * can_queue"

Also, since you seem to be using blk_mq_unique_tag() as the per-IO tag, 
I assume that you don't need to set shost.host_tagset (for that reason).

> -	if (host->nr_hw_queues > 1)
> -		shost_printk(KERN_ERR, host,
> -				"fnic: blk-mq is not supported");
> -
> -	host->nr_hw_queues = fnic->wq_copy_count = 1;
>   
>   	shost_printk(KERN_INFO, host,
>   			"fnic: can_queue: %d max_lun: %llu",
> @@ -582,15 +579,71 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
>   	return 0;
>   }
>   
> +void fnic_mq_map_queues_cpus(struct Scsi_Host *host)

This function looks to do effectively the same as 
blk_mq_pci_map_queues(), right?

> +{
> +	const struct cpumask *mask;
> +	unsigned int queue, cpu;
> +	int irq_num;
> +	struct fc_lport *lp = shost_priv(host);
> +	struct fnic *fnic = lport_priv(lp);
> +	struct pci_dev *l_pdev = fnic->pdev;
> +	struct blk_mq_tag_set *set = &host->tag_set;
> +	int intr_mode = fnic->config.intr_mode;
> +
> +	if (intr_mode == VNIC_DEV_INTR_MODE_MSI || intr_mode == VNIC_DEV_INTR_MODE_INTX) {
> +		shost_printk(KERN_ERR, fnic->lport->host,
> +			"fnic<%d>: %s: %d: intr_mode is not msix\n",
> +			fnic->fnic_num, __func__, __LINE__);
> +		return;
> +	}
> +
> +	shost_printk(KERN_INFO, fnic->lport->host,
> +			"fnic<%d>: %s: %d: set->nr_hw_queues: %d\n",
> +			fnic->fnic_num, __func__, __LINE__, set->nr_hw_queues);
> +
> +	for (queue = 0; queue < set->nr_hw_queues; queue++) {
> +		if (l_pdev == NULL) {
> +			shost_printk(KERN_ERR, fnic->lport->host,
> +				"fnic<%d>: %s: %d: l_pdev is null\n",
> +				fnic->fnic_num, __func__, __LINE__);
> +			return;
> +		}
> +
> +		irq_num = pci_irq_vector(l_pdev, queue+2);
> +		if (irq_num < 0) {
> +			shost_printk(KERN_ERR, fnic->lport->host,
> +				"fnic<%d>: %s: %d: irq_num less than zero: %d\n",
> +				fnic->fnic_num, __func__, __LINE__, irq_num);
> +			continue;
> +		}
> +
> +		mask = irq_get_effective_affinity_mask(irq_num);
> +		if (!mask) {
> +			shost_printk(KERN_ERR, fnic->lport->host,
> +				"fnic<%d>: %s: %d: failed to get irq_affinity map for queue: %d\n",
> +				fnic->fnic_num, __func__, __LINE__, irq_num);
> +			continue;
> +		}
> +
> +		for_each_cpu(cpu, mask) {
> +			set->map[HCTX_TYPE_DEFAULT].mq_map[cpu] = queue;
> +			shost_printk(KERN_INFO, fnic->lport->host,
> +				"fnic<%d>: %s: %d: cpu: %d <=> queue: %d\n",
> +				fnic->fnic_num, __func__, __LINE__, cpu, irq_num);
> +		}
> +	}
> +}
> +

Thanks,
John

