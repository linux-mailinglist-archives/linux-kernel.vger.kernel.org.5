Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADB07AB5B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjIVQTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjIVQTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:19:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE199
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:19:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MGH4oU023447;
        Fri, 22 Sep 2023 16:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=W27Xkl34hmD6Uc+nTDzwyaLUvxNEig1ishMna/bYvDQ=;
 b=KST3zJ6soStynjIc5NiKrOagNM0NFODOq1SlLc5KSbS1MpqRakwdiKqq2loks1H4A9M9
 lMKRSl+eh7UG4rdEEL3ZzKGCvKk8le1f3OLla1LNMu5s6EKmJ1J0LXSI631kEy8p0CiH
 G/8oSZyqiUiIh1x3WEQDfdGGTAOeD4T+SSO1L1v2LdFIE2C1YfeByEdMyUn6o4a+/Wc2
 N/iFWxNkH+pNdg6sxe+1ZQz8fLfuwvPB7wqdqqCythtZjkIi2xdOqbFoLejnuw11jtC+
 uiw2UI7iX5Xw3Aeh1Zj++gXuQaaVzgpcYq5HxsRr8FDXy4YU7RrxinfHKZK7bF9oDHKs mA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvt76v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 16:19:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MFLi6d006302;
        Fri, 22 Sep 2023 16:19:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8tt89aeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 16:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mvlr3aUgSOpxM87XLkvrolXSToDyUWy4xc/Qs+6ro6wZEl+idxcqiH9NCCa2DuNNhSvZc6SVCnXRMoo5GRWHOaws0q8K6UVk1/0xsX+7yoJ0WYsst4TLtQR/yx8uSLyBDgSz26AWpYN2TKr05il4MB9wve/Q0FpjbP33L1QPWKlZGftSDJFhgipDCFpcknpX0eTM5Ju2gHnoOLyFO8D7j+/p7P21Ko/PuJa7P1QHIgyARb9SweNnAnbpT6KJgdkRtvveVYrRPpANpOQDSV6MvHacABHR1wNZyURDcg62r0+TBPukx9Tvy7Rx9ikv3TqVenuc8Ke7M4Oh5mfGtjJBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W27Xkl34hmD6Uc+nTDzwyaLUvxNEig1ishMna/bYvDQ=;
 b=lvxI9nmGWtc7t0xCe9xpBCTyj05kF19vkdXQbcuVmmYCLmTxjvMzcB3ERI53VAFhgI5RASQ1newUM//YL7F34srKm1DKDJ1BG81IicjMsOLory0VumprzEYUHN/+KYnmYU2ocVIdK8ekBesBlaQUmX2RxaRXDG88Y7lLZvExL+r2+C2zseA3JRqy48Jz0uW6EeKvV16LM1ghuQop/fxsh2omtONCIiZJS2knhso+RLEbnfv1TGNxp9dYng0W4hjO3VisS+HJxIYVeJXuNbT/SBiTRHreMeJkQejCVXkwypxmsLXRadepdVRz9wZfUYCUdtt3KDhex1F4Q4RY+ewqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W27Xkl34hmD6Uc+nTDzwyaLUvxNEig1ishMna/bYvDQ=;
 b=eCyeKBoooVDtqZdY/GBjTr/7uP0znWJolQKrsVPJmchtFSQBnuAgVmUpISp7vyu5WqaJcVHrbdscTcC6HZyMnufSDItkSWZe6RvxGFoUBe1GsWxYmdSdqlLeq7EV6TEufk/UHKGgy5YeQbHOOiTBi8MxEd5KCpbYGjx25OOtJRY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4400.namprd10.prod.outlook.com (2603:10b6:208:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 16:19:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 16:19:22 +0000
Date:   Fri, 22 Sep 2023 12:19:19 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: maple tree change made it possible for VMA iteration to see same
 VMA twice due to late vma_merge() failure
Message-ID: <20230922161919.6ct5c7tj35r4ex7m@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com>
 <20230816161758.avedpxvqpwngzmut@revolver>
 <CAG48ez3mcH-ms0piv7iMcB_ap+WDgkE_ex6VHSZw_Aw30-Ox8g@mail.gmail.com>
 <20230816191851.wo2xhthmfq7uzoc3@revolver>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230816191851.wo2xhthmfq7uzoc3@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0036.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::49)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN2PR10MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: c8416cca-057a-4ddd-c461-08dbbb87ae95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvpMMaNTIojOWT6/PUvLVS6uygYnifwsK6SzoVD5S2UODsDWYDRR6PdtOSowJCHR9hM9mO12RNuuLv/d5+tICrdM5KeA+YFi6Bo6pYdhU1RJPBNOdBD3B+v2fY6xFTsrbFIbZ/dkhGH7nfMSBb5boBs4MZzqfMdxHPC5hR2THyFTOe375v213eDhxDr8sGmYeVmJ6BvyMpEEnoPF6P6eTc1426XfMVPwi7NBWCb/jVVtXMxdzwctHLHWaa7fhO69/leCMu7ySHKMN2Y0jFmu9lr6iO5DBkxIXFGUvuRrQrupI1psHAPF8bzXF0oKOjXiWokrZJRYxb/04d7VOxMDOZHkXoXnr2RwrGIKM6s56Jo5tVS/KvwecRP1QeyBm28LYG7CNoUQDhTyPM0iVwo0Eh09+W0Kzzk/3xUtBwp5YsNcHm6fCeU1n4k+16x3ZS5eCsGlLWHR1ZS7TcCBm1ky7yza7HY7Xf5+YhCWhvO6vvDcSOFgLkJCd8mgrroCPfiu6Rt7V75bKW2ADHnM7q80Q9Q0sYeXqUid9I4o/5ZEgksPewXqkpcqmxm6rs6RmuQL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(186009)(1800799009)(83380400001)(9686003)(6512007)(6666004)(478600001)(53546011)(38100700002)(86362001)(4326008)(6506007)(1076003)(2906002)(6486002)(66946007)(5660300002)(110136005)(33716001)(316002)(66476007)(41300700001)(8936002)(66556008)(8676002)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTZjZUhLUzRDTVRJTkRhaTlzWDEzZFNQYkFJTUhxRVIyUllRYWc4Zlhqd2ZN?=
 =?utf-8?B?VDZsa2hMWFZQWGpxdWMrOEhVVDBzNG03TFRBQlBYVHpFRlFtbzcycUZmeEpx?=
 =?utf-8?B?L0xMUDBnUUpUekdKSEpGM0hBWktMUEJFc1ppUFRHM3Q5WFU4clNFS1BDTFU2?=
 =?utf-8?B?eU5zZ1pwMWc5YkpLUmxxY0s0NVVpRm4yRk1xT3NpbVFuT09NcHNNZytNUFgr?=
 =?utf-8?B?WnljYk9adVFzZlduY0dJZTNzcVpnaGduM2JXN2JhVXdzWTFycklDS0F2RUp6?=
 =?utf-8?B?VnFlUXVPc2dYS3hpa2lQR1Nxc0JLVWtpRmZIa2pQSTFBK3FCSUo3NjdFalVM?=
 =?utf-8?B?OHQ3Rnp3REVGUUJLMytHeUZGOVR2VEdCS215UlpRbkpRU2wwQ1J6MFVCbkts?=
 =?utf-8?B?ajMrRWZuUlFKYWZFKzJCNXY3cTZHY0hub0g1V05vVjlFeEZnUDY2dmxZTHJv?=
 =?utf-8?B?TTdhenh6K1NSVG9TZEJBUTl5NXBhditHaFNsbXVibWxOOHNxNUU2MkJjRS9m?=
 =?utf-8?B?MWdoU1k1T2hkY2hHZXhXV0ZSa0orNFNWZnl0MEZDbHRUUmFXbnFQcHpuQ2E4?=
 =?utf-8?B?WnlWT0lFeTFOWndtbUhWZlZkT2t0SWRVS3JRdEFMZkxqQmlKWFFhMFhRc3dD?=
 =?utf-8?B?aTRiYU1oblFBNTlPR1BmWTNhbEFxZ05BMWFmVElIdGpzKzJjenNJQWdrQlVT?=
 =?utf-8?B?NFVtdWtLUjl0OFlWUC8rUmRIdWFrWjRRc0R5NVdqZGkyUlFYTStvd3pUbFYy?=
 =?utf-8?B?Q0oxRk91bDJDcGF1NFljTm12dWdnY2lyaERoc0R6bE1Jd2Nkc0JvMk9iTEJL?=
 =?utf-8?B?WUNRY2dXWTdqTHl1YVRqSmYwclhQYjFNNU9wb2VGWGZ2S0xGMnJ2Sy9ualp0?=
 =?utf-8?B?ZlFJZEJwQlBGWk42cUx3LzdTYUdGMnJLZ3psQTc3amVKMmY5YVRNWjRDLzgv?=
 =?utf-8?B?K01MaU1CNHliSkI5UjcydGtTV1krd0w4Zlk2SEl3UGRTYnpOVGt4dkYrMFNs?=
 =?utf-8?B?b3paL0pMQ0s0R1djUlZDOUZFbU13WDNVRnJVOGJlYzNpY1YwU2dHZklpL3pj?=
 =?utf-8?B?ZExyREQzM2JYTlNEQTJERkNPM2pqK2lLWHQ0YXZReWpZSGN6VlFJQ0NEZnY4?=
 =?utf-8?B?YlBqVXBQQUF1akg0MlIxSVBZNm9QcWZ2VmJ5b0tuYi8rTmxoRHhTcEl3aTBs?=
 =?utf-8?B?akVlajRpK3V1R0V0QzBndlE3NjRmL3luV0NIUVVjWitqSkRKTzkySlBZakZJ?=
 =?utf-8?B?WU52UGV3MXJnQkF4QUdGelZYdjIyS1lCd0RuL0xLNWpmQWltbUJGNXc0Smx3?=
 =?utf-8?B?TGVSNWxoNWRLZi9ZUjVBTmV1VTVvc1VSR3BVZUlZbDJ6K3dlc3hOcVZmN3Zk?=
 =?utf-8?B?eWdHSG9DbjRlNGVDNVZIMTZtUGRqTHFhODQ0RmFUYXM1NTdpUWhkaFM0T1g1?=
 =?utf-8?B?VU4xVnhHaGdYRXpSZGxOYlN1cHJIUUxkd09xSCt2SGpnRUZKVjhZaWVUdWpj?=
 =?utf-8?B?YWpqMGRQb29NRHc2dVcyb2FpeUpsNTgzQnROOERuTnA0OENQN05MUW1WM3Mx?=
 =?utf-8?B?SEZYM281UFA4WVYvaDNVSXdKaUtVak1ENFB0UGlBU1Z0VWZTcHVabUs4dUt2?=
 =?utf-8?B?N09BTDVpOUtBZlR1V2lzVXc2NHZTMUwwZWpzemhYSXFNOVBNVlEyY1ZmMFhq?=
 =?utf-8?B?ckMvSnBremE2L3lnakRoUFU0TVNBM09HZjRXS25YY2lDdXZhR2tiN0lncjA1?=
 =?utf-8?B?MW92S3hLcm9ZWnR6SFZWN1haZE5BQjdkT3BEVVBTV3hqZkNwMWQ5SzBsa2tW?=
 =?utf-8?B?UXlzZzlHUkVQeVZyckUydHpFZlArcmJOcjdNKzRuRUMyOWwzbkkzaEdZd2pn?=
 =?utf-8?B?WW9nRldxdW5ZUmI3Qkk0U2hyZVlTdWR0dVdnOTl0Uk1pV2wzeS8wbWlVdVBD?=
 =?utf-8?B?aFRCSjVuS1ZsQkpwaVBYdU1lem8rOHMyZmtqM2YrZXF3WnlwbG10Q3RveUtr?=
 =?utf-8?B?T3g5WE03QXZ4bXpRcXlpeVhiaDlIZGViWkwvKzlacW5udTQ2dkEzS2dkSUk2?=
 =?utf-8?B?SXBXOVhKMnc3L1VHcHBsMmMzdHJhbVBrd3hxUFVISFZrZnNmU2ZKUmxIWFZ2?=
 =?utf-8?B?bjk0S3lrS2VnaGlKK1V0cmRTVG1xVktDMloxQXVqNW5kWStzVHhSekcyeVoz?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: armqGA9K+xluvYF5rH2slyB335/KD/OD2H6poNt7URpmR93DSuwO54A4mMf8/5T4oSNVrY/9b49m03CpOj68Lgyxsi8cXrA1FU55ql5lPzQs2w7YaZZnVGbCSsmXaOe4Rq67N9Vad6/eocB4KNgPLiWYhJdHj6Fw+ZALkk6Btj3Upp87KykRwH0ssEkuMB0zWUL9k2DbHm11l247xe0C0CpX17L0piJ5WIdVOjqnZM2UdkgdFl8QSlfZzcS5/h+SQfInnjTwjTtIOmjW95iuDyZmXXzpL2ws1cqn6TTzBAwo4DRWfrVXbI5KFOOfK7enL112N8wEIUb3HjfWE3UizEg8Esl1SZihBCnj9YX9m5RKNtSoAXxOHCZ+JYPx7gdnHnrtvCCwJq88pngBILZgRYZ/l8Od2egWtRDlmlkP5f8uD7w8bIhCoOb5hiNIDKjN6qEnGHeFfQwVX4s/X0kIz8OdZD4Xi53JBllNkFfi1WDP39jEPhnH2VGZsGcwDwt0Wtxi7JcCs4QfX3DRsWRhCMlTy/vZc6I4uhJ1bmCcwVWL3zusb7Ua6cCsQUxDgefscwDvIqea8bcpcspptzmg5QDtXZaKo4Bai+GA1jCo4HWRJzZJBTCa+Rn1/AXeOMVZaEvwDG4Mnejat3hS8NymNsg3sgLe4itGgC6ehns4whNvExH3xBApOl6nbdjHbjf7axuNrUy4UoJKjOdhLoDfuEhq7BcGXwsMLwVeDNKM+xE1b3JhjDkwAqM7UqldfEwt2baFqoqCOPwv+ZBiR2X0tp/Ki9GALMY1/a9ojBwzcTywm85pClVg68TVt0DkuhOoS4nPhHRAlO2928YiraWrySehqXlZtFCfQ5h5JSAzi+AvRYaoEOuUaUiWFjBPbsCRT3L/e84xIOmdCr+voBwmmYHxqSteY522rla4vj6Z6Lg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8416cca-057a-4ddd-c461-08dbbb87ae95
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 16:19:22.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLowv/TzOumG+fQydE4HtcAxrgjY7lgmkOseChnqNIwEiu2TDrJ2CTdSrZQUd04s/NntnBd7u/Ef0TjEHDrxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_14,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=845
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220141
X-Proofpoint-ORIG-GUID: dRaqsgAPxwUPrWVBEYImNdjnI-Bcs5K3
X-Proofpoint-GUID: dRaqsgAPxwUPrWVBEYImNdjnI-Bcs5K3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230816 15:18]:
> * Jann Horn <jannh@google.com> [230816 13:13]:
> > On Wed, Aug 16, 2023 at 6:18=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > > * Jann Horn <jannh@google.com> [230815 15:37]:
> > > > commit 18b098af2890 ("vma_merge: set vma iterator to correct
> > > > position.") added a vma_prev(vmi) call to vma_merge() at a point wh=
ere
> > > > it's still possible to bail out. My understanding is that this move=
s
> > > > the VMA iterator back by one VMA.
> > > >
> > > > If you patch some extra logging into the kernel and inject a fake
> > > > out-of-memory error at the vma_iter_prealloc() call in vma_split() =
(a
> > > > real out-of-memory error there is very unlikely to happen in practi=
ce,
> > > > I think - my understanding is that the kernel will basically kill
> > > > every process on the system except for init before it starts failin=
g
> > > > GFP_KERNEL allocations that fit within a single slab, unless the
> > > > allocation uses GFP_ACCOUNT or stuff like that, which the maple tre=
e
> > > > doesn't):
> > [...]
> > > > then you'll get this fun log output, showing that the same VMA
> > > > (ffff88810c0b5e00) was visited by two iterations of the VMA iterati=
on
> > > > loop, and on the second iteration, prev=3D=3Dvma:
> > > >
> > > > [  326.765586] userfaultfd_register: begin vma iteration
> > > > [  326.766985] userfaultfd_register: prev=3Dffff88810c0b5ef0,
> > > > vma=3Dffff88810c0b5e00 (0000000000101000-0000000000102000)
> > > > [  326.768786] userfaultfd_register: vma_merge returned 00000000000=
00000
> > > > [  326.769898] userfaultfd_register: prev=3Dffff88810c0b5e00,
> > > > vma=3Dffff88810c0b5e00 (0000000000101000-0000000000102000)
> > > >
> > > > I don't know if this can lead to anything bad but it seems pretty
> > > > clearly unintended?
> > >
> > > Yes, unintended.
> > >
> > > So we are running out of memory, but since vma_merge() doesn't
> > > differentiate between failure and 'nothing to merge', we end up in a
> > > situation that we will revisit the same VMA.
> > >
> > > I've been thinking about a way to work this into the interface and I
> > > don't see a clean way because we (could) do different things before t=
he
> > > call depending on the situation.
> > >
> > > I think we need to undo any vma iterator changes in the failure
> > > scenarios if there is a chance of the iterator continuing to be used,
> > > which is probably not limited to just this case.
> >=20
> > I don't fully understand the maple tree interface - in the specific
> > case of vma_merge(), could you move the vma_prev() call down below the
> > point of no return, after vma_iter_prealloc()? Or does
> > vma_iter_prealloc() require that the iterator is already in the insert
> > position?
>=20
> Yes, but maybe it shouldn't.  I detect a write going beyond the end of a
> node and take corrective action, but not to the front of a node.
>=20
> If I change the internal code to figure out the preallocations without
> being pointed at the insert location, I still cannot take corrective
> action on failure since I don't know where I should have been within the
> tree structure, that is, I have lost the original range.
>=20
> I'm still looking at this, but I'm wondering if I should change my
> interface for preallocations so I can handle this internally.  That
> would be a bigger change.
>=20
> >=20
> > > I will audit these areas and CC you on the result.

Looking at this, I think it's best to make a label and undo the
vma_prev() with a vma_next() - at least for now.

I'm also reading this for the error path on dup_anon_vma() failure, and
it appears to also have an issue which I'd like to point out here before
I send the fix for the first issue.

-----------
                vma_start_write(next);                                     =
                                            =20
                remove =3D next;                          /* case 1 */     =
                                              =20
                vma_end =3D next->vm_end;                                  =
                                              =20
                err =3D dup_anon_vma(prev, next);                          =
                                              =20
                if (curr) {                             /* case 6 */       =
                                            =20
                        vma_start_write(curr);                             =
                                            =20
                        remove =3D curr;                                   =
                                              =20
                        remove2 =3D next;                                  =
                                              =20
                        if (!next->anon_vma)                               =
                                            =20
                                err =3D dup_anon_vma(prev, curr); =20
-----------

Since dup_anon_vma() can fail, I think here in case 6 we could overwrite
the failure.

That is, we will fail to clone the anon vma and mask the failure if we
are running case 6 with an anon in next.  Once the first dup_anon_vma()
returns error, the next call to clone curr vma may return 0 if there is
no anon vma (this, I think _must_ be the case). Then we are in a
situation where we will be removing next and expanding prev over curr
and next, but have not dup'ed the anon vma from next.


Thanks,
Liam

