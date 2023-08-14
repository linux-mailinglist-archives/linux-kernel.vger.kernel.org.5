Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8280977AF24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 03:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjHNBT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjHNBTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 21:19:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C11B5;
        Sun, 13 Aug 2023 18:19:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37DNQkdC012834;
        Mon, 14 Aug 2023 01:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Mh3ojYchHrfoRu1PPxLxwSIXYJen56GBUN4d8OosHCI=;
 b=y8fiJbAv18PmX1YGYcnxOYILExnlVO6lLlK83p5yU0khrMa1cuwIiNTfRD2OkZW7fPIh
 cfB9OpJtOxQPdtCp7KRgOA6QZ1uQtGoJLr4YU3DDXAqkjirkCY6q8NxziT4UrBs1vWb3
 Ybk8VOa+3tBP0Msy49gJKf3ghP0ctG97e1hGSd9adxSgSutyAui+nguxgAOTUtnzZsf/
 hDN9IX/susvghXML7+46f/jqKeD7ZcbQIXdfXMBuH1ePz3i6lcXXimOQk0NMuFjtDafH
 56ulnpAa9Oy277g9ZG4TOdWVZFoRkDNVu8DDBjamBfPONTR8we33Q/lPGX2z+WIqV2F3 +A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2skr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 01:19:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37DMefK6019750;
        Mon, 14 Aug 2023 01:19:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3tjyjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 01:19:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGGkv7Az6L2AzBgr2pnRD29ddZSQJ6vXo2Utm0WaDHgjQcDUWSQHfkJZaNS+GcFG2O8C3DuEFFXk5PYr6kSRNM6sqZ3MiUmBGNBfyj/wIYxkKtMGORCryUnCunIjEi7PJNYydwyiqTYgkbZLcfmzoN7riZP/QCE5eR3CNzPTc/FAEB/EhBMHqKKjGE3HLLEbfxZxz3sOfBSjnLsITNP/mFrh858+84kpoBLzI8ST5VBXzspp2DkdpSms0L7wWCxOe366njAlWsQfzgLiNwX6xoKT5w4RCYL8Qn5H4EpXJ17aut/REXR766igwnMlByQLRS2m7U0UeiUkdsuiQ+hvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh3ojYchHrfoRu1PPxLxwSIXYJen56GBUN4d8OosHCI=;
 b=M3L57iff9O4RNBL9B7z0GJhuPZj2CNxma3T7tio8ryh0oB+IMrL53oeFGLTZk2M+Is7UmODquf3rQ6Yg5OSapSyU+Z8Wx70DWQjhsIIzTovTjKAnMsGTzR7oQ4pBHhEWWhQQmp5HjJtmtgd2UIRKo70JvHMkWCWxSBAkoTQ+zi5p55YXl61o58HTNESZEYAVBpSZr3d8LdZ1VrOnfF84Bj3C7YwqRQPcjouFBRl48T3ymdH3ypMpoOYQqDfwiIEKRPu7mSR+GBvRXKk/SfNAKz7B0A7doBIbaaLF1pbHKFD3KBldtGz5RbZtCi54ZvVzHW4f3ta5fdgotP2RGASYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh3ojYchHrfoRu1PPxLxwSIXYJen56GBUN4d8OosHCI=;
 b=bQThu/xV24z/ylDei1wmmSxWb5F5a5ddNcrRZn9VHqSewpX8Tx9cK1czfYb83lGsKawJQkimsnbtbiUxHR5OoPAC+C8I6Vzvteglj6VhPLcd18b5DfTfj/3vwjMpZPIOXtgKP6+GJKcf6KuUpD+ofBMmgwZeeyI8pIvmROHbULg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7260.namprd10.prod.outlook.com (2603:10b6:610:12e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Mon, 14 Aug
 2023 01:19:36 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 01:19:36 +0000
To:     Ankit Kumar <ankit.kumar@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, gost.dev@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block:t10-pi: remove redundant Type2 check during
 t10 PI verify
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18raefmkn.fsf@ca-mkp.ca.oracle.com>
References: <20230811153313.93786-1-ankit.kumar@samsung.com>
        <CGME20230811101911epcas5p1b090eea2adf03e143ef6445a32278295@epcas5p1.samsung.com>
        <20230811153313.93786-2-ankit.kumar@samsung.com>
Date:   Sun, 13 Aug 2023 21:19:34 -0400
In-Reply-To: <20230811153313.93786-2-ankit.kumar@samsung.com> (Ankit Kumar's
        message of "Fri, 11 Aug 2023 21:03:12 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0141.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 2286ad39-a510-4db0-b701-08db9c6485ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zWkhNeARTmqYy4ZUVOr7LpzJu1NtW1uyl8wQaAKgyauzbb1T/CRQygwLoobcJbTFT5UWnUR70IkiSUNCtdNNsVLbSQ56A5DiJdCImcQ3lUNQ45bVMVwv/XOOEb1DaqIpFyQPyNTWFDZc8PC/LYfyiWgQubw33IRC43buErlGEbE8lq9TPRlwtRPARyQmYddxm89Jbt0bxOqSGEmtF41WvzUNkmi3P1EljuCwOAvXAhr+mgpct0tWXZriTtvycSVZj7FGX6PnJ55o6n8Gk/y5LhePJvxpjpsjiQ//ICaHEHUq3S72CaCzcgZHIIYJENFx+qH1PuJB+D1+g6cLpb9vsw6eCRQgoD7zdUxPP107U4rvRvdKWcWd80CTZ+x461UKziI3d6pYT7WOiqOYrzsC4FQrdrMtmWI49z8wx2xoc18KkDUr7B4Fn1+ABoQXA6CpH5NKLWQric6wOz719vvuaNeWSxtUcxqGzznbP2rE/q8J2emwWF9HRfTXAezqV6/E1cwCL01qNz5gdXJ/kfXVEMA9UW7le4Cn5el66fO6EVfFlUQKC9K/hUJOo1kv7dA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(186006)(1800799006)(6512007)(36916002)(6486002)(478600001)(54906003)(83380400001)(5660300002)(66476007)(66556008)(2906002)(66946007)(8936002)(15650500001)(26005)(6916009)(6506007)(4326008)(41300700001)(86362001)(558084003)(38100700002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qsAGeVs+4etlslHuAe7AI5s3qloo3DTY1Skfl9fCtyXmaCKopWJcMr8l4rNb?=
 =?us-ascii?Q?G/DCTje+rZnLxVPHe9XVz7pt/fxLxgGLzuBGsZop/zdMkPOXdLKHvnp+6c11?=
 =?us-ascii?Q?O3wIIjLbuxka96Iz7U8zwN38LWPgV+7SgOGJa6yU3wpk0brx4ZOiWprZfmxU?=
 =?us-ascii?Q?6xg8qok28wGPzOiJEKDzSzeaKjzhRRX38aXWYyeluqX1o+VlKrjcQGslmoK2?=
 =?us-ascii?Q?M1iKr5Pi2/jLOAKljEML5xLVtwfINF7oFhsDcmgmW3IdUZeETekNIlm6sJFB?=
 =?us-ascii?Q?uV7FrDLMsMRKSf33MDdX1oFqZR8SIyMm1xdqYp1UTAPlYz7bVHKGwHcpG7lX?=
 =?us-ascii?Q?SWeKuQTaR40sXoE5UuEtDt5KdWsJXZ76/QRLLLG+kPeSRDCDWHAR8d7x3coJ?=
 =?us-ascii?Q?k80dR7bjBqVkWNAgqjywYpaum8apRJay+2w2UaFjOJffwfJNvj9ev8Hlp1dQ?=
 =?us-ascii?Q?LRSj4rC2A9TF4Z+nXYO587cSroFgl3HqqA9PYVhDehGPBYr79AZGNzL1YQCJ?=
 =?us-ascii?Q?Zeuk2s47qY0hrJl1rENfQAyQRUP/zehfsmwzLCeTVKQjBnDnvKacYzdd0Gcs?=
 =?us-ascii?Q?smm7M3EeRq0ExDd27l+mlEcINVUi+KjeNRaitY9B39nJ6LbcgGGTXwmaIqo1?=
 =?us-ascii?Q?/ShcSvasx+/c5xmHJqRYyMQvsf7M2WcIgCm/tYqNoJZx6laHvAuD4RdmyaY6?=
 =?us-ascii?Q?2vEraYpYGRlSOhvYSijhonvjDMGVgW9xbvL+LvkNAgV8PuiFVdJWXbPZ9CYQ?=
 =?us-ascii?Q?C0xaujW1z4KAabAiWXNrjaNh67F3jHKm5lF2POETaJvLUOC+ohGcccLxdvT4?=
 =?us-ascii?Q?XHI46t7gpp1qTKcgotzKQHVagVc/6xXAARgTpHEUvGiKbGKmB9GXxdKSCk2k?=
 =?us-ascii?Q?f3chiPzWqeVSbQoCBX65Tdxvpdit5fJqE6/aYWyj+HaEAMTStY03RSksffjX?=
 =?us-ascii?Q?kBJY2eDvvNx7EQZ/9/vD6aRzmBBPQ0eitpB4vKjycRTs5w/LRTq5yMMVoc95?=
 =?us-ascii?Q?orh2SrLXgII1XftgQgI0UhWlQdXIAar2OiTLLoUNBgKedZhSysnWjk/6MOD/?=
 =?us-ascii?Q?l2nM/4X1YKUaPZfQgtOFFBFm44+Y0n7UUfByHGu4J/33D0VjFYj2XkhYVtHs?=
 =?us-ascii?Q?3SysS88ZyVvXQevQuA6oRDgqtBUg5iXr0AkRVVMHkWA57KfirTEjRiIr9/tT?=
 =?us-ascii?Q?8g0AbA/C0NbcJAiwd0SiUrAmGxhv4bS0iq05Y6ZTgCNC0QspGhkOUS9Thx5q?=
 =?us-ascii?Q?KhbDPNdPu5HAowYCoMijeICUpqJ6S7clU+Y5Rn+iMjGnlhuK6f06/g7QOW3t?=
 =?us-ascii?Q?RCtF+XWdZy4M8KBk8ISc5HKs5psD4od0P2ToZj0A5tXcF4d+L/7wS/VMr7cH?=
 =?us-ascii?Q?UCa+LmIDhOHHBKErI5XUSWtUuJmEz7BvD/NeG2XS5iGxgqcikDwRHHGzUaOu?=
 =?us-ascii?Q?B5oRXZlcyCuBocgUYEHkKwrC0pVk8zRocdWutETr4dtl3gx8N7TG+boHoq3V?=
 =?us-ascii?Q?JJx2jI9j5j2eB6N9+RxFJG4WXOEMQM9sfg6EyCqhsgLM1ITiwOJT/cGHH0Rh?=
 =?us-ascii?Q?H6SiCunCd/OGJlJZjj5fiLp+LJgJgEVKc/6UzpyG4tekCIUwCru0p2D9iX7a?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t1Qh7HLKFrupNofXRcy9Yj3WMZcKPyfjwCZfvWg7jGH3UbPMr04lH8xWVfCRknRB9v/X7DV/A28f66WEFbuuKN6VhvYD6LTCbpdgGrzJ7sa5d/yYg53oWAowAO2qfUeM4CjwcYdChSnJo3igTGo5uIuOboMD1ILk2xnxPx6FJPXBj0XFZk7hpJhxlsUfVeFbLJFuuw2FIwOTAd99ZihAYO1MUr2hjjV3migZ+S4jVZ6lvsVvd6+AL/Zj4+oRFth0CtFyNQdLN+5UTMxmDtv8Y29JP5LcG4DIESifip87m5fa2Cz5FTWPdra70hMEYFJ6LZbJjkg7NuDvw28qOd7BDUhi1t+PmBziWjF7peCcd9kkbhOOdWU2JGGsuMV/MSu7brnroFw2UPNdUtCtPmyW2wqGGGoHkaJwVeu20TZNWzlV+WkMTFjRcXXVHF9yhDvbLQggGeA6kXV4mZPeM2bWJ+riXJvZWebTxgIHIjPDBROGvOIpoQBtiZ9RwMltyOjzyZQdj2BrRLnpaa7q2Kd/P8z8j7GEvxBexM+EH9ZRY013jMIh1vhJFGB1ZWiYFgShhW7WCiVdxplrHo8MJW4LC0kleWPggXdSOe6BloHuhwam+qK7ZLyazoM+sLuIOsUr09Lh+tiplJFUxaB3Xo8ZeOXHNOeDBI8li4HsPzQec9amNwnh8T9wbfQ+RFesdkOz7N+fCA525zD/hPjn3ap/NoUhqxcmrd+UjAqcvJNsHZNkBBoNcD8CDrImYKRHjKS2XEjz1fi04hCAKq0RNgjf6BqesLxMw5bvTLuLiMIwPvLCfj7wV9OhrJ59B185dJ7YjWz6t49QHrabPITzEUlFs9WcR37+TJBUpQxfl4OtP08=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2286ad39-a510-4db0-b701-08db9c6485ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 01:19:36.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vf11gXgeJB9MagThKgGWSD7mjgrkNx96YkxdEcuQs9pPfXgvS5CLd1//zmEP63VWam638o9iYf6Xjf9VX4EGB2G2rXFUGG7nvG2GnKQXs9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=922
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140011
X-Proofpoint-ORIG-GUID: py92DjwYAKyNRgsC-I3aQLtcXgzPzKXX
X-Proofpoint-GUID: py92DjwYAKyNRgsC-I3aQLtcXgzPzKXX
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ankit,

> T10_PI_TYPE2_PROTECTION is neither used to generate nor verify
> crc and ip. Remove this redundant check.

Remnant from when this code was moved out of SCSI.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
