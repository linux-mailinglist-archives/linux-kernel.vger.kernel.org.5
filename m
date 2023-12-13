Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF212811F02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjLMTgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjLMTgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:36:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766A09C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:36:24 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDEQw3c015765;
        Wed, 13 Dec 2023 19:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=dno3GHilYDS8jaN3Rl++N8ZQU4McwD4bzpHAX5oTImA=;
 b=S220CraylBfE7RZP5zSXZTm+Jy0p5ggIMCKCvd/Snu3s64ym78/GRMnbmyjuMZ0ohN8Q
 tRaCEMoJag2L/nQtADLxyXcdNvxU6zrXWDAsrjgyu9zAykzBgnqvgSpSTFHTDMwV3oRN
 M8oRIYJ2p7gJ7pp/gSsZWo5IXZfeVyiL7Hs9+n3BASVSZv8bKJjd/pTzaMLR3Ys0essG
 81toVEAs0wrorn+XpVHG1KNUJvPQnJmlmxxiaddZXRxIoc6SJlDU9gQ08+EZDhwP3qst
 ydzjhTgUD8UlnucdhaHFOJpWBdDPyDZUKXCZZIk6itzToveGoMSEQZZ75Z72ykaoBX0y Zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsuh38r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 19:36:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDJJadg008274;
        Wed, 13 Dec 2023 19:36:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8t5b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 19:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsZMepc8HvF6Rt2wnccc5vPTITpwq9FiHWacdgBNvxq0gkdxjs4G7f1XB4JWdC5Vjr6oQdYexO65RxVRkBNljRdfMPn6HsiGmmsOkgOocch0IDaViRa3h7vGShed7MkQJNqIBw0TOoOKgz6q3PPmjDQvEdZ5ta37cJam7w5rUS7byp9XX6YFThhvbCtcQOdKL6cMKP13vrboIANgQHh254/8KUlMQvmvMx8GZBKjgAi8EeBvR9sYeyr4IUFS99pHtljl1OOj7r/bd/Ibw2gxfnSVJ21JiZzjAIY5eKfil6+oPhfZOi8MuFtIWq9zLLtjpIW4nylWTv6T9hvDkgU+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dno3GHilYDS8jaN3Rl++N8ZQU4McwD4bzpHAX5oTImA=;
 b=BLh1YHCkN9GzK7xiM4HQnRSynDO8+XGmTSclCrrHX/lh29qBjWkmly+IMo/oAWKM6ba0wJ/G5qjPzz+jOEnyHnOEK5qaESB3YJfhMMJ6Je5f2+SkUQdvvtYa++4FwKMXlvqwog2BzZmWATMKxIhsiefPRmiFJIQtIb4l9LBHJ+CsjCNCvSWw2so6d3OWQ7BRH4+kKUG5sXIXqmOEWiojw8lvbOxhgPoYvYJzHBZeynFnCLRn/7dIRZ0A8b0XaBJBl4MyQzg9ybfDKGVgp9a1a7oh21RNFZQs8iL3D3SA/P0AJQaHj2Pw+L118UZ6o4DB4wkQCRc539MjYaiEXjiR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dno3GHilYDS8jaN3Rl++N8ZQU4McwD4bzpHAX5oTImA=;
 b=VIAMuZCJZym99wwHkWhfzUnMXQd/ncwzmITAaGxBhNifCOJLDu8Ytn8Iw33vAld3sWP6s8MRYdellY8EUJziwS0iwIDXRnJix21JbxUEhsUSqovvCktrZKdw3jUgbY5GgC8blbJgDL3ux4dNdMymFzSYbwvHKn1NyBUu6oFW6V4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4589.namprd10.prod.outlook.com (2603:10b6:a03:2d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 19:36:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 19:36:00 +0000
Date:   Wed, 13 Dec 2023 14:35:58 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     sdonthineni@nvidia.com, tglx@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Maple tree implementation for irq descriptor management
Message-ID: <20231213193558.zwqppxa4ap7xvrfr@revolver>
References: <660d8a0d-d490-ab0b-0bd1-e497fc7df1fc@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <660d8a0d-d490-ab0b-0bd1-e497fc7df1fc@quicinc.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: 5403e8be-c634-4d92-036b-08dbfc12bc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbw+NOrfbzWxTE9EcHRKNsPpLRdJaq5p4rLo1l+hlCWpJ10+ehwRqrQmqTPQPnv+BJF8aC3OCtG+TBJNw0iOZZkfl+OqjUWGIDwSWaQIL+atu4MRnJQXu2TRlQzCPu+OY2oaWcoCza7Siq8YsMnA31998AzKKE23gVKiJU5CjB8ui3YFdIq8ETp2xwCCejvKorJjCmpkpVbQ9e0QhDGBt5tJOK7yxFbpQB6mcD0pgis1japuSQrGthQqjoXA4bpm94OsfdRQb9+MwneLYFZgZ8fVzie6Qbcke0EQmfhaEskh3fWA/V5WbSAulvxFxPbCxRs3w9sVohOdOwwv9AsmcyAHyjOvAE/pTIatWbVWtlUYQkEv29X9eTTrlZ8Ivyhyt37YLzeEPIVy4IHygR1R03JrgzqYp2JW5RChBycgdB1utx0XQDT3qsHNdtekXmGl1F87fy5vvoX9UXtoW5On3EsAjkIAoLSQFsdL4Bhs6t40sMd6hLEXieicjEjaSIZAdH2w7eIUD0pAjARHQ0z9rBpIGqBOozbI5AR2RXt+tgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(30864003)(41300700001)(38100700002)(2906002)(86362001)(9686003)(6512007)(1076003)(26005)(478600001)(6486002)(6506007)(966005)(83380400001)(6916009)(316002)(4326008)(5660300002)(66556008)(66476007)(8676002)(66946007)(8936002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVHeUQvgSKw1/qA2RZd5TSE9JsPm9LPmb2CqokFSCAumxqz3cUjVO0tTTtNV?=
 =?us-ascii?Q?GxXOA7nkAXldQPWnQWInIWvI1ZtHrF9gD5e7R+gAVMaC1JxhelM3JZvPzN8Z?=
 =?us-ascii?Q?SHV5abo27lPOnBAccL1ngMZ6+JF2R0QVxQZmbhMVAOlV9K4cNPel8yOMT1Vv?=
 =?us-ascii?Q?mv8PVQIf1675iSPUaaThqeEtXRnW/B9hcPi7fkmNPUWFTla2qyHMmaVBhsHu?=
 =?us-ascii?Q?D0s33CbDJBzdWjbOAt+7QCKk+NtVNzHqUuS8w2HjgOO+brCyxmkN5Yb7EWxw?=
 =?us-ascii?Q?kIq5hdjgdBwkt+br9Bqg1JT7H9IztoZs0GpH7K5Ff4U+rarYkkrXzE4bkGV/?=
 =?us-ascii?Q?fgHLAIAiRvDQxL43MR0BXzXzhjQiSH/Uqj1MTeHSBNYHWFNIwgkC/VXK7G5v?=
 =?us-ascii?Q?O5VoC5BjpebgSK+WKqAZyutLcgSInHstwSMPTdl94AGs4GMl3nIRMKObOpzn?=
 =?us-ascii?Q?P9kXVhuef98+lLcGHVgyhG6dLcdWTM4tblioum+Grmd+uljIGNw+zlNvreta?=
 =?us-ascii?Q?r3Z1r6nFQB+mEhf/KERk+hJGi0FW8Wq1CH9azYjnoCdDcsnI3/Avr0LxZzhz?=
 =?us-ascii?Q?E1PwY39h0plH75XGu3svVKQhDfw5Gs/RA7Q3CE+xCBGzjCMy5n/fXsa2bs38?=
 =?us-ascii?Q?HhXKXQnxpK/O40NF2ISRrnpYYwV8pdT4ESHMDuCpU/QYqem8tCoq/6qgS6w5?=
 =?us-ascii?Q?M4I96ysdXRvsLpF6oXdJWF+OYq1d80SSswcEj38VJliFfbnAfrGpQjJQUTGg?=
 =?us-ascii?Q?XvdY4zP99xpA38fRxdAqzP9T2qeqGEjcrMPTFQMrq5PYjRwrQyga3HKEmOco?=
 =?us-ascii?Q?7bI6fRxBz1nZxrvtOTI6cgssSbg6p1WjDngn+CgTLaYCrAjBZ7lLaAgvbaJi?=
 =?us-ascii?Q?4KQekcWK9OH6I2UKukux5Owdzx1czbmIh3BucxrvXHQxjhKfNU1H0vQGHrOt?=
 =?us-ascii?Q?kqeZq1REvgWIW2TJmJi82mhpJx+uUUTEIeb0Fn9OSotw1uaCY+sFDSpVYqQf?=
 =?us-ascii?Q?bSi1sEj0t/WI1JXAj0X2hdVFr5ryT88/KaHUelpaUTGVIQx0W5rXKyQHXHn/?=
 =?us-ascii?Q?ArICkYK7MCkfZdxqJt0ZgMyHJgyJTPYEfXrQ94bXpogxKmqL94AASZHyncYD?=
 =?us-ascii?Q?a4qzmvuzXQumpJBJqsIV6Xmtw9haqZiDADzw+CNVjfG22fbHBaKXZAPDrR0d?=
 =?us-ascii?Q?gCy4xwsxHu9J5lga+FN+nh5UU/5yWsrLfHphS+QonYr4hxVq07g1W386fDgN?=
 =?us-ascii?Q?D0v6ndl92r1BBHx7PI9LKIoPfSehAJAEanKnXh2Sw2/SwvV3XoY0CyPU68np?=
 =?us-ascii?Q?PzJDrF0Kz60oMMlRP1r4zI50NHjhi8s9fLlBBqSGS3bhGobq0X0A0AXKKrT1?=
 =?us-ascii?Q?Wp97GX6/08sx9st2TOkx1yTmiq/mUC4T3E1YVkSK7tQ0i+yVEQFV8lkSW0/7?=
 =?us-ascii?Q?VZkNNVu5kstwiGH/ZC7uS89RJYDZmMjRraOmAyMWQeRCG9fH/5uui/BCM3sH?=
 =?us-ascii?Q?lc1dgqz0kb7PnaeWBNOBn0c6ED7Q2K1wLqCMO5CASOvfgWDVE25WCsyVGq3F?=
 =?us-ascii?Q?8e3kLqirWQ+naejDmRCgb/CKoPbDLr5CzvRYW+MB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vJdmS4K4b+Pf+787gReCUymWb7wNtHmJpQvp5fw0cGwz8FC8NlYgMpRAZdqT?=
 =?us-ascii?Q?SyRCZt50o4Czh0MBrcI1mAFTEIXu6bU7skdqq6fU2aCwRvkjbmy1p1dPgVGs?=
 =?us-ascii?Q?PYvchIG9WXddFeH5qEqItyJVWR45qh8i75q6pUBEeSgD+cdUALWd223wUhhK?=
 =?us-ascii?Q?DkZVg9vE9G+nAp0l/ssOXGOfH1zsWnLtm76w8OIGlVU0qqnfCQzNFYxZfkq+?=
 =?us-ascii?Q?gX506Gw9ThbVqpVtzjAKbKJEBE6ZpvqiwdysXov1te2uhkJmpCxeUxQVqCAX?=
 =?us-ascii?Q?vAosuJvH4Ilp3p2VhWPPGNsIJRtbAzhkHaRzyP5wEVHESf59HPSas9sgfnPm?=
 =?us-ascii?Q?x1deIKQfiFJVIr3kM4EZ9nSnYKDIHjE7zqrIEY9fwY4Db2JLHQQSfzCoMJ63?=
 =?us-ascii?Q?DunMo8CiFHFQOQ9veT87ySfJjQC98XoKc72wS8iN/IvjBJigveJ6W/WJ/T7X?=
 =?us-ascii?Q?0d5jaa3ATRnyooXEmQ+rDPqjwidirwFXkABlWQJAwTT1TIFeVWUKmB4m1U8j?=
 =?us-ascii?Q?9d23UD4LcyglYhaTbT9znKfYl7uhrEAVfE0cJzPqUqbCo/CujU86ZMo94Jp1?=
 =?us-ascii?Q?8F7/34WnyUuHLrR33qTXC1ZSqPiHylD552FoOhGTNNkI4WuJLjbX7x4Z/kEc?=
 =?us-ascii?Q?y8qPJVt8CThqW13iadpx2oG7InGHBXTqu+UBW7ThK8YtguqyjgHA/GiBKbpo?=
 =?us-ascii?Q?dNPnMxHWyQB/wNX0JA34F+TegH5VNI2Kmk3Iz1R57nF5GSSc+cdOkTSA3TmF?=
 =?us-ascii?Q?YkERTFTWYKdpTovJwmC99Vt5AXCmc/k33XkxBIJKyTFTsVDiDTD3GPcEQ03z?=
 =?us-ascii?Q?2ZMitwFlpD1WwA8Y0OqPCBV0kWY0txe6HqYkY/66gshQx9gSevDo2erPPV7q?=
 =?us-ascii?Q?MeILcYJ/gTiEth/E06I5Vc7wjyhSJVm/P9EB5vMjrS5rSWlwDhKzTn7qvvRg?=
 =?us-ascii?Q?8cRpxVWEySHToH0dccc8mw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5403e8be-c634-4d92-036b-08dbfc12bc62
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:36:00.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 029v00PpEkNQL6aYWxP8EzkDHRAKXGvIcHKfeFIpRASWRQKLT0/xPmcAFa7wUmnv0CLOuvockEdi8+ke9xMg8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130139
X-Proofpoint-ORIG-GUID: TWADg34zlKRbtTfrBmOXml41cxj3cTje
X-Proofpoint-GUID: TWADg34zlKRbtTfrBmOXml41cxj3cTje
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mukesh Ojha <quic_mojha@quicinc.com> [231213 10:46]:
> Hi All,
> 
> We are facing an issue in maple tree implementation for irq descriptor
> where while allocating a new descriptor in irq_create_mapping(index=300) it
> gets interrupted and get stuck in infinite loop inside
> mtree_lookup_walk()=>ma_dead_node(index=287) due to dead node
> (0xFFFFFF8819DECF00) and it is the same node where earlier call
> for creating descriptor is about to added.

What kernel version?

There was an issue with the tree a while back which could result in this
happening [1], although I was never successful in causing it or seeing
it before now.

Looking though the dump below, it appears that you do not have the
patches in [1] as they should prevent the node from being marked dead
until the new node exists in the tree.  Note that this occurs in your
case in splitting of the node which should be fixed in the last patch of
the series.

[1] https://lore.kernel.org/all/20230804165951.2661157-3-Liam.Howlett@oracle.com/T/#u

Thanks,
Liam

> 
> 
>   (struct maple_node *)0xFFFFFF8819DECF00 = 0xFFFFFF8819DECF00 -> (
>     parent = 0xFFFFFF8819DECF00,
>     slot = (0x0, 0x011E, 0x011F, 0x0120, 0x0121, 0x0122, 0x0123, 0x0124,
> 0x0125, 0x0126, 0x0127, 0x0128, 0x0129, 0x012A, 0x012B, 0xFFFFFF8813125600,
> 0xFFFFFF8828BC6E00, 0xFFFFFF8821A4C800, 0x
>     pad = 0xFFFFFF8819DECF00,
>     rcu = (next = 0x0, func = 0x011E),
>     piv_parent = 0x011F,
>     parent_slot = 32,
>     type = maple_dense = 0,
>     slot_len = 33,
>     ma_flags = 0,
>     mr64 = (
>       parent = 0xFFFFFF8819DECF00,
>       pivot = (0, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296,
> 297, 298, 299),
>       slot = (0xFFFFFF8813125600, 0xFFFFFF8828BC6E00, 0xFFFFFF8821A4C800,
> 0xFFFFFF8815595A00, 0xFFFFFF8815594400, 0xFFFFFF8815596800,
> 0xFFFFFF8815597E00, 0xFFFFFF88155B7C00, 0xFFFFFF881559400
>       pad = (0xFFFFFF8813125600, 0xFFFFFF8828BC6E00, 0xFFFFFF8821A4C800,
> 0xFFFFFF8815595A00, 0xFFFFFF8815594400, 0xFFFFFF8815596800,
> 0xFFFFFF8815597E00, 0xFFFFFF88155B7C00, 0xFFFFFF8815594000
>       meta = (end = 0, gap = 0)),
>     ma64 = (
>       parent = 0xFFFFFF8819DECF00,
>       pivot = (0, 286, 287, 288, 289, 290, 291, 292, 293),
>       slot = (0x0126, 0x0127, 0x0128, 0x0129, 0x012A, 0x012B,
> 0xFFFFFF8813125600, 0xFFFFFF8828BC6E00, 0xFFFFFF8821A4C800,
> 0xFFFFFF8815595A00),
>       gap = (18446743558671647744, 18446743558671656960,
> 18446743558671662592, 18446743558671793152, 18446743558671646720,
> 18446743558671650304, 18446743558800159744, 18446743558759686144, 18
>       meta = (end = 0, gap = 118)),
>     alloc = (total = 18446743558747508480, node_count = 0, request_count =
> 0, slot = (0x011E, 0x011F, 0x0120, 0x0121, 0x0122, 0x0123, 0x0124, 0x0125,
> 0x0126, 0x0127, 0x0128, 0x0129, 0x012A, 0
> 
> Backtrace:
> 
> -000|mtree_lookup_walk(inline)
>     |  max = 18446744073709551615
>     |  next = 0xFFFFFF881B197C1C
>     |  offset = 2
>     |  node = 0xFFFFFF881B197C00
>     |  type = maple_arange_64
> -000|mtree_load(mt = ?, index = 287)
>     |  index = 287
>     |  mas = (tree = 0xFFFFFFC081EB3EC0, index = 287, last = 287, node =
> 0xFFFFFF881B197C1C, min = 0, max = 18446744073709551615, alloc = 0x0, depth
> = 1, offset = 0, mas_flags = 0)
>     |  entry = 0x0
> -001|irq_to_desc(inline)
> -001|generic_handle_irq(irq = ?)
>     |  irq = ?
> -002|NSX:0x0::0xFFFFFFC07A0E0500(asm)
> -003|__handle_irq_event_percpu(:desc = 0xFFFFFF8807D18600)
>     |  desc = 0xFFFFFF8807D18600
>     |  __already_done = FALSE
>     |  irq = 17
>     |  retval = IRQ_NONE
>     |  res = IRQ_NONE
> -004|handle_irq_event_percpu(inline)
>     |  desc = 0xFFFFFF8807D18600
>     |  retval = IRQ_NONE
> -004|handle_irq_event(:desc = 0xFFFFFF8807D18600)
>     |  desc = 0xFFFFFF8807D18600
>     |  ret = IRQ_NONE
> -005|handle_fasteoi_irq(desc = 0xFFFFFF8807D18600)
>     |  desc = 0xFFFFFF8807D18600
>     |  chip = 0xFFFFFFC081F21288
> -006|generic_handle_irq_desc(inline)
> -006|handle_irq_desc(inline)
> -006|generic_handle_domain_irq(domain = ?, :hwirq = 261)
>     |  domain = ?
>     |  hwirq = 261
> -007|__gic_handle_irq(inline)
>     |  irqnr = 261
> -007|__gic_handle_irq_from_irqson(inline)
>     |  is_nmi = FALSE
>     |  irqnr = 261
> -007|gic_handle_irq()
> -008|call_on_irq_stack(asm)
> -009|do_interrupt_handler(inline)
>     |  regs = 0xFFFFFFC082142DB0
>     |  old_regs = 0x0
> -009|__el1_irq(inline)
>     |  regs = 0xFFFFFFC082142DB0
> -009|el1_interrupt(regs = 0xFFFFFFC082142DB0, handler = 0xFFFFFFC0800100F8)
>     |  regs = 0xFFFFFFC082142DB0
>     |  handler = 0xFFFFFFC0800100F8
> -010|el1h_64_irq_handler(regs = ?)
>     |  regs = ?
> -011|el1h_64_irq(asm)
>  -->|exception
> -012|__memcpy(asm)
> -013|mas_mab_cp(:mas = 0xFFFFFFC0821434A8, :mas_start = 80, mas_end = ?,
> b_node = 0xFFFFFFC082143108, :mab_start = 80)
>     |  mas = 0xFFFFFFC0821434A8
>     |  mas_start = 0
>     |  b_node = 0xFFFFFFC082143108
>     |  mab_start = 0
>     |  gaps = 0x0
>     |  node = 0xFFFFFF88118A8900
>     |  mt = maple_arange_64
>     |  __fortify_size = 32
>     |  __p_size = 18446744073709551615
>     |  __p_size_field = 18446744073709551615
>     |  __q_size = 0
> -014|mast_fill_bnode(:mast = 0xFFFFFFC0821430C8, :mas = 0xFFFFFFC0821434A8,
> :skip = 1)
>     |  mast = 0xFFFFFFC0821430C8 -> (
>     |    orig_l = 0xFFFFFFC082143000,
>     |    orig_r = 0xFFFFFFC082142FC0,
>     |    l = 0xFFFFFFC082143080 -> (
>     |      tree = 0xFFFFFFC081EB3EC0,
>     |      index = 300,
>     |      last = 300,
>     |      node = 0xFFFFFF881409570C,
>     |      min = 285,
>     |      max = 293,
>     |      alloc = 0xFFFFFF8814094600,
>     |      depth = 3,
>     |      offset = 4,
>     |      mas_flags = 0),
>     |    m = 0x0,
>     |    r = 0xFFFFFFC082143040 -> (
>     |      tree = 0xFFFFFFC081EB3EC0,
>     |      index = 300,
>     |      last = 300,
>     |      node = 0xFFFFFF881409510C,
>     |      min = 294,
>     |      max = 18446744073709551615,
>     |      alloc = 0xFFFFFF8814094600,
>     |      depth = 3,
>     |      offset = 15,
>     |      mas_flags = 0),
>     |    free = 0xFFFFFFC082142FA8,
>     |    destroy = 0x0,
>     |    bn = 0xFFFFFFC082143108)
>     |  mas = 0xFFFFFFC0821434A8
>     |  skip = 1
>     |  split = 0
>     |  old = 0x0
> -015|mas_split(inline)
>     |  mas = 0xFFFFFFC0821434A8
>     |  mast = (orig_l = 0xFFFFFFC082143000, orig_r = 0xFFFFFFC082142FC0, l =
> 0xFFFFFFC082143080, m = 0x0, r = 0xFFFFFFC082143040, free =
> 0xFFFFFFC082142FA8, destroy = 0x0, bn = 0xFFFFFFC082143108)
>     |  l_mas = (tree = 0xFFFFFFC081EB3EC0, index = 300, last = 300, node =
> 0xFFFFFF881409570C, min = 285, max = 293, alloc = 0xFFFFFF8814094600, depth
> = 3, offset = 4, mas_flags = 0)
>     |  r_mas = (tree = 0xFFFFFFC081EB3EC0, index = 300, last = 300, node =
> 0xFFFFFF881409510C, min = 294, max = 18446744073709551615, alloc =
> 0xFFFFFF8814094600, depth = 3, offset = 15, mas_flags = 0)
>     |  prev_l_mas = (tree = 0xFFFFFFC081EB3EC0, index = 300, last = 300,
> node = 0x1, min = 0, max = 18446744073709551615, alloc = 0x0, depth = 0,
> offset = 0, mas_flags = 0)
>     |  prev_r_mas = (tree = 0xFFFFFFC081EB3EC0, index = 300, last = 300,
> node = 0x1, min = 0, max = 18446744073709551615, alloc = 0x0, depth = 0,
> offset = 0, mas_flags = 0)
>     |  mat = (head = 0xFFFFFF8819DECF0C, tail = 0xFFFFFF8819DECF0C, mtree =
> 0xFFFFFFC081EB3EC0)
>     |  mid_split = 0
> -015|mas_commit_b_node(inline)
>     |  b_type = maple_leaf_64
>     |  node = 0x0
> -015|mas_wr_bnode(inline)
>     |  b_node = (
>     |    parent = 0x0,
>     |    pivot = (239, 254, 269, 284, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
>     |    slot = (0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
> 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
> 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0),
>     |    padding = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> 0, 0),
>     |    gap = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> 0),
>     |    b_end = 4,
>     |    type = maple_leaf_64)
> -015|mas_wr_modify(:wr_mas = 0xFFFFFFC082143408)
> -016|mas_wr_store_entry(:wr_mas = 0xFFFFFFC082143408)
>     |  wr_mas = 0xFFFFFFC082143408 -> (
>     |    mas = 0xFFFFFFC0821434A8 -> (
>     |      tree = 0xFFFFFFC081EB3EC0,
>     |      index = 300,
>     |      last = 300,
>     |      node = 0xFFFFFF88118A891C,
>     |      min = 225,
>     |      max = 18446744073709551615,
>     |      alloc = 0xFFFFFF8814094600,
>     |      depth = 3,
>     |      offset = 2,
>     |      mas_flags = 0),
>     |    node = 0xFFFFFF8819DECF00,
>     |    r_min = 300,
>     |    r_max = 0xFFFFFFFFFFFFFFFF,
>     |    type = maple_leaf_64,
>     |    offset_end = 15,
>     |    node_end = 15,
>     |    pivots = 0xFFFFFF8819DECF08 -> 0,
>     |    end_piv = 0xFFFFFFFFFFFFFFFF,
>     |    slots = 0xFFFFFF8819DECF80 -> 0xFFFFFF8813125600 -> ,
>     |    entry = 0xFFFFFF8848A27A00,
>     |    content = 0x0)
>     |  mas = 0x0
> -017|mas_store_gfp(:mas = 0xFFFFFFC0821434A8, :entry = 0xFFFFFF8848A27A00,
> :gfp = 3264)
>     |  mas = 0xFFFFFFC0821434A8
>     |  entry = 0xFFFFFF8848A27A00
>     |  gfp = 3264
>     |  wr_mas = (mas = 0xFFFFFFC0821434A8, node = 0xFFFFFF8819DECF00, r_min
> = 300, r_max = 18446744073709551615, type = maple_leaf_64, offset_end = 15,
> node_end = 15, pivots = 0xFFFFFF8819DECF08, end_piv = 18446744073709551615,
> slots = 0xFFFFFF8819DECF80, entry = 0xFFFFFF8848A27A00, content = 0x0)
> -018|irq_insert_desc(inline)
>     |  desc = 0xFFFFFF8848A27A00
>     |  mas = (tree = 0xFFFFFFC081EB3EC0, index = 300, last = 300, node =
> 0xFFFFFF88118A891C, min = 225, max = 18446744073709551615, alloc =
> 0xFFFFFF8814094600, depth = 3, offset = 2, mas_flags = 0)
> -018|alloc_descs(inline)
>     |  start = 300
>     |  node = -1
>     |  affinity = 0x0
>     |  owner = 0x0
>     |  desc = 0xFFFFFF8848A27A00
> -018|__irq_alloc_descs(irq = ?, from = ?, :cnt = 1, node = ?, owner = 0x0,
> :affinity = 0x0)
>     |  cnt = 1
>     |  owner = 0x0
>     |  start = 300
> -019|irq_domain_alloc_descs(inline)
>     |  virq = -1
>     |  cnt = 1
>     |  hwirq = 0
>     |  node = -1
>     |  affinity = 0x0
> -019|irq_create_mapping_affinity_locked(inline)
>     |  domain = 0xFFFFFF885BFF6840
>     |  hwirq = 0
>     |  affinity = 0x0
>     |  virq = 0
> -019|irq_create_mapping_affinity(domain = 0xFFFFFF885BFF6840, hwirq = 0,
> affinity = 0x0)
>     |  domain = 0xFFFFFF885BFF6840
>     |  hwirq = 0
>     |  affinity = 0x0
> -020|NSX:0x0::0xFFFFFFC07AE32720(asm)
> -021|NSX:0x0::0xFFFFFFC07AC9AB38(asm)
> -022|NSX:0x0::0xFFFFFFC07B3E49F4(asm)
> -023|call_driver_probe(inline)
>     |  dev = 0xFFFFFF8848951848
>     |  drv = 0xFFFFFFC07AFD90C0
>     |  ret = 0
> -023|really_probe(:dev = 0xFFFFFF8848951848, :drv = 0xFFFFFFC07AFD90C0)
>     |  dev = 0xFFFFFF8848951848
>     |  drv = 0xFFFFFFC07AFD90C0
>     |  link_ret = 0
>     |  test_remove = FALSE
> -024|__driver_probe_device(drv = 0xFFFFFFC07AFD90C0, :dev =
> 0xFFFFFF8848951848)
>     |  drv = 0xFFFFFFC07AFD90C0
>     |  dev = 0xFFFFFF8848951848
>     |  ret = 0
> -025|driver_probe_device(drv = 0xFFFFFFC07AFD90C0, :dev =
> 0xFFFFFF8848951848)
>     |  drv = 0xFFFFFFC07AFD90C0
>     |  dev = 0xFFFFFF8848951848
>     |  trigger_count = 783
>     |  ret = 0
> -026|__device_attach_driver(drv = 0xFFFFFFC07AFD90C0, :_data =
> 0xFFFFFFC0821437E8)
>     |  drv = 0xFFFFFFC07AFD90C0
>     |  _data = 0xFFFFFFC0821437E8
>     |  data = 0xFFFFFFC0821437E8
>     |  dev = 0xFFFFFF8848951848
>     |  ret = ???
> -027|bus_for_each_drv(bus = ?, :start = 0xFFFFFFC0821437E0, :data =
> 0xFFFFFFC0821437E8, fn = 0xFFFFFFC08089C798)
>     |  data = 0xFFFFFFC0821437E8
>     |  fn = 0xFFFFFFC08089C798
>     |  i = (i_klist = 0xFFFFFF881ED5C6C8, i_cur = 0xFFFFFF8823649968)
>     |  sp = 0xFFFFFF881ED5C600
>     |  error = 0
> -028|__device_attach(dev = 0xFFFFFF8848951848)
>     |  dev = 0xFFFFFF8848951848
>     |  async = FALSE
>     |  ret = 0
>     |  data = (dev = 0xFFFFFF8848951848, check_async = TRUE, want_async =
> FALSE, have_async = FALSE)
> -029|device_initial_probe(dev = 0xFFFFFF8848951848)
>     |  dev = 0xFFFFFF8848951848
> -030|bus_probe_device(:dev = 0xFFFFFF8848951848)
>     |  dev = 0xFFFFFF8848951848
>     |  sp = 0xFFFFFF881ED5C600
>     |  sif = 0x0
> -031|device_add(:dev = 0xFFFFFF8848951848)
>     |  dev = 0xFFFFFF8848951848
>     |  sp = 0x0
>     |  parent = 0xFFFFFF8851B70080
>     |  class_intf = 0x0
>     |  error = 0
>     |  glue_dir = 0x0
> -032|device_register(dev = 0xFFFFFF8848951848)
>     |  dev = 0xFFFFFF8848951848
> -033|NSX:0x0::0xFFFFFFC07B3E3944(asm)
> -034|NSX:0x0::0xFFFFFFC07B3E3C20(asm)
> -035|NSX:0x0::0xFFFFFFC07B6B5148(asm)
> -036|platform_probe(:_dev = 0xFFFFFF8848956010)
>     |  _dev = 0xFFFFFF8848956010
>     |  drv = 0xFFFFFFC07B299648
>     |  ret = 0
> -037|call_driver_probe(inline)
>     |  dev = 0xFFFFFF8848956010
>     |  drv = 0xFFFFFFC07B299678
>     |  ret = 0
> -037|really_probe(:dev = 0xFFFFFF8848956010, :drv = 0xFFFFFFC07B299678)
>     |  dev = 0xFFFFFF8848956010
>     |  drv = 0xFFFFFFC07B299678
>     |  link_ret = 0
>     |  test_remove = FALSE
> -038|__driver_probe_device(drv = 0xFFFFFFC07B299678, :dev =
> 0xFFFFFF8848956010)
>     |  drv = 0xFFFFFFC07B299678
>     |  dev = 0xFFFFFF8848956010
>     |  ret = 0
> -039|driver_probe_device(drv = 0xFFFFFFC07B299678, :dev =
> 0xFFFFFF8848956010)
>     |  drv = 0xFFFFFFC07B299678
>     |  dev = 0xFFFFFF8848956010
>     |  trigger_count = 781
>     |  ret = 0
> -040|__device_attach_driver(drv = 0xFFFFFFC07B299678, :_data =
> 0xFFFFFFC082143BA8)
>     |  drv = 0xFFFFFFC07B299678
>     |  _data = 0xFFFFFFC082143BA8
>     |  data = 0xFFFFFFC082143BA8
>     |  dev = 0xFFFFFF8848956010
>     |  ret = ???
> -041|bus_for_each_drv(bus = ?, :start = 0xFFFFFFC082143BA0, :data =
> 0xFFFFFFC082143BA8, fn = 0xFFFFFFC08089C798)
>     |  data = 0xFFFFFFC082143BA8
>     |  fn = 0xFFFFFFC08089C798
>     |  i = (i_klist = 0xFFFFFF8804034AC8, i_cur = 0xFFFFFF8821B45068)
>     |  sp = 0xFFFFFF8804034A00
>     |  error = 0
> -042|__device_attach(dev = 0xFFFFFF8848956010)
>     |  dev = 0xFFFFFF8848956010
>     |  async = FALSE
>     |  ret = 0
>     |  data = (dev = 0xFFFFFF8848956010, check_async = TRUE, want_async =
> FALSE, have_async = FALSE)
> -043|device_initial_probe(dev = 0xFFFFFF8848956010)
>     |  dev = 0xFFFFFF8848956010
> -044|bus_probe_device(:dev = 0xFFFFFF8848956010)
>     |  dev = 0xFFFFFF8848956010
>     |  sp = 0xFFFFFF8804034A00
>     |  sif = 0x0
> -045|device_add(:dev = 0xFFFFFF8848956010)
>     |  dev = 0xFFFFFF8848956010
>     |  sp = 0x0
>     |  parent = 0xFFFFFF8851BCE410
>     |  class_intf = 0x0
>     |  error = 0
>     |  glue_dir = 0x0
> -046|platform_device_add(pdev = 0xFFFFFF8848956000)
>     |  pdev = 0xFFFFFF8848956000
> -047|NSX:0x0::0xFFFFFFC07B73DD48(asm)
> -048|process_one_work(:worker = 0xFFFFFF880300AF00, work =
> 0xFFFFFF8833434930)
>     |  worker = 0xFFFFFF880300AF00
>     |  work = 0xFFFFFF8833434930
>     |  pool = 0xFFFFFF8B7DCAA180
>     |  pwq = 0xFFFFFF8B7DCAE600
>     |  collision = 0x0
>     |  work_data = 18446743573308827141
> -049|worker_thread(:__worker = 0xFFFFFF880300AF00)
>     |  __worker = 0xFFFFFF880300AF00
>     |  worker = 0x0
>     |  pool = 0xFFFFFF8B7DCAA180
> -050|kthread(_create = 0xFFFFFF8803290240)
>     |  _create = 0xFFFFFF8803290240
>     |  param = (sched_priority = 0)
>     |  create = 0x0
>     |  data = 0xFFFFFF880300AF00
>     |  threadfn = 0x0
>     |  ret = ???
>     |  self = 0xFFFFFF88030D8180
>     |  done = 0xFFFFFFC082133CB8
> -051|ret_from_fork(asm)
>  ---|end of frame
> 
> -Mukesh
