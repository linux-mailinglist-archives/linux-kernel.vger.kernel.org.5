Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EEC7EBA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 00:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbjKNXyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 18:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjKNXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 18:54:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9EBCD;
        Tue, 14 Nov 2023 15:53:59 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEMsNPw019305;
        Tue, 14 Nov 2023 23:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CuateX7JiPTTQmqUJG5XeQLy7o7ft8V3X9VvqgmRo8E=;
 b=SF3s+TJ6Gb9lL6m+WkMHq0krNvFe6lc/r0q9ClrBAO3GLKw/+4NMDWFdB9UtLl7132ZX
 4NfitBVK9/h+WVlnCBNxHkBgm2tSsykBmhQK+WQNRZEG3mjQvEM3ibH0DYnNwYRI+Djv
 MCU8yRdN97n1oXYm8hNj3oDidbot3pJhCq8j0OlwY8WdEwrJOLVRr4um8Trr2Ga6KCdb
 maXFB9dP76/EQ1x6B3BtqNsmSoC7oBxOXyeDTIMYdE75YqAEPTVY+xOFACFjrvTmIo4B
 CNYwC0O7hKZETSEF9KhtLMiUb/WjsPtDoTHLzgV1rg+7X7N8o4mrl/mlzZfBqhOgKzZL 6w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2r06yda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 23:53:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AENpI8H014806;
        Tue, 14 Nov 2023 23:53:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxqsde4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 23:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I02+Qk+5J4OXHCQ5jRJne+4qhJFw4tCT+azRIbNmtCDD+hHewQhOXCb9bMiqfnIJqmlosr5k9Zwlh7xQst/LmW6IotoiAyWsT//53q0gaAk2s93rfO0h9WEDW4nlZuXeSlMV1EUg+wvr9SWfrqR/uSJwt7AYuddNWOYiK9q2SHQnyHtwR5voVzLD17gK+RM7pThOTs483nXIvJIRWLO66ZodJg1CVN5diP3U3oRLMYTFBfit/JTw7wv76Gg0efxEGP3GNn6cMMygw4VuZz1W5OiUc7VVG10NoBKET8Hf/s/Z8G3TeKgs7HuKZizYNMxECUPemYsK/4C8VOjOFU41Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuateX7JiPTTQmqUJG5XeQLy7o7ft8V3X9VvqgmRo8E=;
 b=jjmKXhuLS43BvS9zyHAiWopCb/iYGBkUWGWottRZBT8HKbdRkyltk+g6jFTffl9mCubyx2NF0xtLQRWJ063dRRA4K73d+gBbrXZr9ZadE3XHXCG+ZHtRWDcS8nQk1pNPNuQttPASY/XQ6MdqAe8Ck35igoG21+lWMUAwBH7Z4zi1MEJyN4IAQK8/9GQtAOaf1Mevw1G87kShdrhPday45AIRa4CWCLRd+4COPZT0/6iqFgTVLTChiMZrKjciSM7/L2gOxF+Qu6rNTNzY7QveepohMq07iTilxWOX0xaBAA5cY3Hyf8cmisBqAvR09CcY5UY6f1St+xV39aJBtS2U3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuateX7JiPTTQmqUJG5XeQLy7o7ft8V3X9VvqgmRo8E=;
 b=SxzAsw7NX0eZQ2sia4mUi8ogPLvH3Lt+m+OG9JpZBpD1b1KBfSGSju4kNYvmD5PuQHq+hzcrBgRNsOhqdZAc2Dq3o+N78FaksKqhRmMBxXVtnP1D95rMcqWn8pCtgZ/4LI+J37OGDn5CuoW+o3SexLiER95/ga7FU1SdpH2wp5o=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SA1PR10MB6472.namprd10.prod.outlook.com (2603:10b6:806:29e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 14 Nov
 2023 23:53:51 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::baa:8a05:4673:738]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::baa:8a05:4673:738%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 23:53:51 +0000
Message-ID: <443775e1-ed94-452e-8f06-eadb777bede4@oracle.com>
Date:   Tue, 14 Nov 2023 15:53:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernfs: support kernfs notify in memory recliam context
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20231114185947.42829-1-junxiao.bi@oracle.com>
 <ZVPFMzHAx9JVz2ak@slm.duckdns.org>
 <c71f1cb7-14d6-45e4-9df1-dc9bc82deda8@oracle.com>
 <ZVPXd-3TshjeScek@slm.duckdns.org>
From:   junxiao.bi@oracle.com
In-Reply-To: <ZVPXd-3TshjeScek@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::29) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|SA1PR10MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 7620bd46-2bed-477c-53f8-08dbe56cf3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqscVjmT/6hfjCATuTaGoHOwFSlZMpQrL24akanbN2V4IYeX6HYYJ1EDjmRlzf11lY3dJaf0xynp+Pj3liTknHrFmXzccrAP598IzAguWnTOzAObVaFBOpKQLOLBNGRVIfjdGS9ZRX1eN9jJk4N3WhF0/OxkmemtN3X5OgAhIqyYGMRMu1kOhoHWSADuLAEkCEaPXuVmNSdpsaSmT2tOp+T9+neJ6w/IXn3m59zHFy5fwbEvbW46plkSU5o1n2/GwYXWZCwveP6GUY2sjKk0W0GdJENSF9Rb/1yrlubla05HAbx6gNZDU0w2sWWlxUDXCyOoK2btyqBopYXRHjsF6qf2UO3ftDCVkXX6pedcjuAO5zaIuKZ9TpnYYtvOzenHzhJSWAHXrbPo0HHJQ3KjqPI6Z8moHmdE+bJS3NVVev+kvyJMCSrntV+xwxGneZeRyZiOIIOhrhcOH01t0FPPITqV4QXhD24AAUUpHwh66DkAz/+/N7sElFaEEkcwmWOOAH8NyxKBxxQcQelOLAEkugfWKjMepbv5lbckJB9f6/0Er+kN4c60XBMDLN/dbQR4XP7nckqsxryQ12sb9C6cqKyjdIXp9daTMrtiy4zLKXKaLeBYaDwbJQyE0zTNdpy/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(9686003)(6512007)(66476007)(6486002)(66946007)(316002)(478600001)(6916009)(41300700001)(6506007)(6666004)(8936002)(8676002)(66556008)(4326008)(53546011)(2616005)(5660300002)(31686004)(2906002)(83380400001)(26005)(38100700002)(31696002)(86362001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0FHazRueU1NRjM4K042RVJuK1ZMUWNHMjhsSFNyNTYyTllnYk1xTXNXd2Z2?=
 =?utf-8?B?QjVIaWdDd1gwZDY1Y3lJOUF5MUF5WmY5MHYwamNXY0oyaTFpT2NJcFR5c1Vy?=
 =?utf-8?B?MXZ0QXFnUmRpbFVLVTFmbGg3Ym1RTENucjRFRkltdDFKOHdiZ0g3Wkc0NC9G?=
 =?utf-8?B?VXdhTTBPOTMycjZid3VvMFN1RmlCdjBldWhEc0EvWWV1MEUzZlRjYmx6RGtP?=
 =?utf-8?B?U1dXa0RHTm5WN1VpRTh0QUJEdmQzZ3dBZEwxUVYxOHhCaGNCSHo1clEwREdD?=
 =?utf-8?B?am1ad3J2Y0Z0K0g4d0VEOHh3YUd0VlVsTGdsaExtOXNvb1FCVjZFZzFUWDNZ?=
 =?utf-8?B?bnZ4KzRvUlUrS1hKMitoR29McTVob3E2SE8rL0RKSDVQYlp5OGFqVC84ajRs?=
 =?utf-8?B?Q2VVczJCSlRZMDBaMU9RM0dhRHhDL09TdkVzVHREOGVad280R2hCSi9jcHhz?=
 =?utf-8?B?SUYwUktVcENjejMrdHo2V1R5QTJ1OThyU1hwaHB4ZlltdlZrOFAreVZqQVE5?=
 =?utf-8?B?ZnNqcXkvbTgyQ0tialJ5YWQrM1hZU1dnRDdLUzMyeThDM1VnVHl6R2ZGK1pF?=
 =?utf-8?B?M3VYeDE4WEdPUlMybEVVWWVpRG41RGliYXI5L0tRTldkZVM3aVBhL3hjejZF?=
 =?utf-8?B?cVJzTit6UVcvRXlaRDFnWmZJUWJqcWtDM2FGdGxOVTNFSGJzM3pZclJNWHNO?=
 =?utf-8?B?SElaVWE4LzRhZlEzMHJtZ1U3NEZ4YXZPYlN0czFmSGNWR29Bc0ltMnp1Zk5B?=
 =?utf-8?B?ekNtdWtQbFFZQ1doWGlSQy9uc2xuYUg5OWJrMk5PNFFCQVJ5OE9Wak9WcEZy?=
 =?utf-8?B?cmdrUFRWL2lIczd2R2I3aXdpVnI3N3JVYXo2SXJ6ZFY5bS8zSk5HSU5qbkhC?=
 =?utf-8?B?aW9VZzFORFBMUGlhd2JrRkNxaHlPcFN5NkhYNmRiS3JFbUxra092R1FOU20x?=
 =?utf-8?B?S2ljeHBnQU1CZXF3QkJTTnJGRWxjMzBORSs4cFpWSHRNeG10Y2JtNDlSdUNU?=
 =?utf-8?B?aGJ2enF3RjhCYUN3dG1hOUFZUGRMZU5VNC9LbjNHOXRCaWprQzJ0MWFYWllj?=
 =?utf-8?B?YnJxTGZIUDhOOHZjbVBZMDVqZ2FRbkhmdzIvUGM0dGVDZ0RYV1J5N09GanRZ?=
 =?utf-8?B?WllCT0psM1BLaCtqZVNGSk4rMmloejNMV1NvTDJ4SWRsSTNHcUtjTUlhZ1Er?=
 =?utf-8?B?dEVtb21yQ1Z5bklaSVBjZUp4VUNiVGFPc2tPM1ZKZGtwem1tU2xaa3NYWWV2?=
 =?utf-8?B?SkdyVmdiOE1IY2hSUDBzZWRLOVRDenNtSmhpL1BMdUlUK0tNL25XR21QZ0tN?=
 =?utf-8?B?cWp3Vi9kdS82YTgrM3JCYnp5dWtYRW5lekU1NDJIRndleHJNb2NEWFcwWE5h?=
 =?utf-8?B?ZytIN0NMMEYybXUyNjlpRmU4ZGh2M0dXajhCNlkxY21tR1VZbU45akJ1a011?=
 =?utf-8?B?OVZVSTdRcndRVHhkaURXem5Ja2JwdktFb2VVaVJjbGxSZ1lZZ3J3WUlGS3Ez?=
 =?utf-8?B?bDVSb1EzR0t1MCtibXBxckpZc2Y3cE1zbFlEQXJyODVqYkx6b2tGZkFueGlF?=
 =?utf-8?B?SURSVC80SUpKSmRxVzRDY3NlOVNLZ3IrUGhCOVc1UFhEZzhnc0dtbEdRclkr?=
 =?utf-8?B?YnRrTXBNc0gxSE8wV1BlRnliNTB5K3BVWDR5WUhxUlB2c282aHNHYkRrN0w4?=
 =?utf-8?B?dUovbXFSOVNpeFZWeG9pTWh5aUVNRmhJN1ViVHpiSEI1TWFIM21GVklQYlNy?=
 =?utf-8?B?c0dWMnFXSTFrdG52TGdrY3E1V1M0WHdVTThZUG9TZ3oyQ3FIQ0V3ZzJNYkpx?=
 =?utf-8?B?V2FmUGY0dGRxeHhDNHRtdGRWSnIwRFNlNnJDUVA4eFFmZVNQQzUyUGlkWUwx?=
 =?utf-8?B?SUJMWGJnbzdIQTUzSXpDTUhxRElsTktCNDlqUk9qWThRMVBqb0RmTVNya0c0?=
 =?utf-8?B?aklyMlUzajdWRUpQQnB2TzZucldyT0xWazhmN0x4VzNHTUN5OFR6alZDTmZV?=
 =?utf-8?B?MWJvdHhnZlNyNGNEZjRIVHk5dFRsR21pTzltdXlBTlk4TUpSYUNuQWpCZVJp?=
 =?utf-8?B?RFFMeHJYSWx4MnVqeUZ6RGhlVGgzT0JNd0piUGRBVGw0YjdweDVkTmhVQi82?=
 =?utf-8?Q?2BqTn4oLCryFazI7xuh/I5jy8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yT4Z5sm4ApvyKj/Aks6RXewGVI1jaJ2WRh5rZdY3rxVYwvJFSY9qzLUcp+ciLKFf8Qd6uxH0EPxnMBeLQoq/uhRg1PvDHyWXns1KTUQUeLovNLvOLXGw/k1R6kT3hmSjPhEeW5oYR8F96vvuSEPqpd9ZXoDt9brL0Jx1kpHTO/eoVeRP5rf6Nw2cDkoTcxv/7TqsbDEdJ7wAuOuWiT/xtwvpVmuMJNRhdKf4tWgCO2dniZwAaIRANtfXp0i7FhF5l/EF/8RECl25Mi+5vvzOc8+XpDlgEDybevfEUOz730MkqstrSpOm1KqzYNqZNMU7f6fv4OSRfuSDPTorLsyeIc8DQAXnJlzvLJOFyOtdANG4HQF1VfR6jdvxn6F30wdFrKsyfUCF4JUPZGDUe7O/RyaoboF1nVnS/uNAFJ+cmXbraz9qpdzTevDu4siqYmV4pIFbTgIMo+KnIUfTcg8syg1gzY7L2v0WZ6hxwvarojweQZncHvvxTtKylDE/c6d39XesfQRLhiMG4OWPR7VtCKWbUWnXE8BVHqQPDJNNQB7noUapRRgZuB9EtYxB3bBvkRcxGCZHgpkQwU4ZLuKWtZzaQ+ZKZyClmwmLYmq2oaMONejPYJrXjGDpNlLPwHu4X2mzTXPj+F8Pn8IzvuyF8699nO9iaeprJ7ctofu8//f0oRNcBCrxiwh7v7NEGCqSl1D7yEOy4KyyncyRe8iN4H0C/zHtn4EB7a3X9+i8VWUWSj38zvFPe3pdIC88DOjzK3Oh0dJoz0bLXRJNmzwA66g36ywdex8VlsEaS7o5nejS7s6sGEjRGPbY4qeiBas3qdoqQXJ10RRCTYKVS8yWi3c01EAysSWVJEFaPydQhpM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7620bd46-2bed-477c-53f8-08dbe56cf3b0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 23:53:51.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDJVzJLD7Q8Ua8wvZL2utQwOFSRQSi8k5C5g1ov9chQE10qm4xxh4ZuoRRoQdBApC9wL/oC2VwJHBz1ZxLvTYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_23,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140179
X-Proofpoint-ORIG-GUID: 3R6rRpmhUGrzIGKHgP3HchP5iXNET-RO
X-Proofpoint-GUID: 3R6rRpmhUGrzIGKHgP3HchP5iXNET-RO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 12:24 PM, Tejun Heo wrote:

> Hello,
>
> On Tue, Nov 14, 2023 at 12:09:19PM -0800, junxiao.bi@oracle.com wrote:
>> On 11/14/23 11:06 AM, Tejun Heo wrote:
>>> On Tue, Nov 14, 2023 at 10:59:47AM -0800, Junxiao Bi wrote:
>>>> kernfs notify is used in write path of md (md_write_start) to wake up
>>>> userspace daemon, like "mdmon" for updating md superblock of imsm raid,
>>>> md write will wait for that update done before issuing the write, if this
>>> How is forward progress guarnateed for that userspace daemon? This sounds
>>> like a really fragile setup.
>> For imsm raid, userspace daemon "mdmon" is responsible for updating raid
>> metadata, kernel will use kernfs_notify to wake up the daemon anywhere
>> metadata update is required. If the daemon can't move forward, write may
>> hung, but that will be a bug in the daemon?
> I see. That sounds very fragile and I'm not quite sure that can ever be made
> to work reliably. While memlocking everything needed and being really
> judicious about which syscalls to make will probably get you pretty far,
> there are things like task_work which gets scheduled and executed when a
> task is about to return to userspace. Those things are allowed to grab e.g.
> mutexes in the kernel and allocate memory and so on, and can deadlock under
> memory pressure.
>
> Even just looking at kernfs_notify, it down_reads()
> root->kernfs_supers_rwsem which might already be write-locked by somebody
> who's waiting on memory allocation.
>
> The patch you're proposing removes one link in the dependency chain but
> there are many on there. I'm not sure this is fixable. Nobody writes kernel
> code thinking that userspace code can be on the memory reclaim dependency
> chain.

Understood, thanks. Sound like depending on Userspace on memory reclaim 
path is really bad idea and the only option for fixing it is to remove 
that dependency, but i am not sure that is possible without breaking the 
consistency of metadata.

Thanks,

Junxiao.

>
> Thanks.
>
