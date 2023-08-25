Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885BF788F29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjHYTG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjHYTGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:06:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63862132
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:06:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEepJ000972;
        Fri, 25 Aug 2023 19:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9P3Cyny+mcYwz1jwFSE8K4E3sWShTXUh71C/hj9IWl4=;
 b=pACqANPjZGRlFsTq2VJ0FL80q/JHBrsJ+jUVMbK0ACpMXN/uDgnZeJhiGSHYWxUrJkDR
 ECeRIS9hkXx0lKBsRfSV5/JyzOYP1A8qeJoGwukYEewrnhQXpY81WLvebFEXjHmYjFp8
 0plKVPUcYg9AWD07S+KRtz5AiKG5QBZ8iH2/esS36kT5bwkpLs4+t7pFk1I1dKViWSW1
 G4ZIaE9f0LchEs7ztK5ZDEVsWutGn8/4y+o8yyjVMq97sbvjvLihwAsKH5PFM69551uL
 OHRYZXcD1YR8skBEqIk7SKOyjkr+QoUqPWNg5Olt1FOVYCRJdacxYMCuw0EjgapHEMTU xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yxq01b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PI417C005759;
        Fri, 25 Aug 2023 19:05:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yuya0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVcPmGBj19r133Gy/VFs+hUe4ko9UR1s4FN2yjogf0RiIx8OMZDaSqBSvRrJ7ryKM5EbuLP7arZMMd7JC5RuRMkIjH0Pt44DiK4Y93qC3PA661SykBQ9yAHUyfD7iKAZ+jYvooN51mocNjeY29WPfqTYyBVLmSxWzDmQDc6hGgMpIFUnE2AugTxqwfXU03O+HCap/GXEjOsn0uxn97okBjynsqDNEzotA6VFJKVmFOA6IKNWDHRFyuc3ZpaMRbqnyMdEMFQoGLvxls6iBmDn5w1SDzCaco9V+yha3YyW413tScnN3tb9MhNILrQeIlJcgvFqDEtvcPwb8wDkpxBjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P3Cyny+mcYwz1jwFSE8K4E3sWShTXUh71C/hj9IWl4=;
 b=LVZZxllwW5bofTD1Zoh4lB9vxurlz+v0CVMuO6vlI4DP/lcWcgP01NDSdzBqwUIBLIKDJpYn6DdgAUSyU/T59xybNDwd+DPFJ36piPTdL7nL63kjv6fOUdB4D04eM2VtP+5TIYOcxGtwNcgD81Ua2eDzEVuHWbV0vG2msUnsU3c249wHKwELCt++6ToiMMm0Joh5zU56/Fh8xZa88XA/BR0qCrb31c8LhLosvi3SwMpAD2QkNifeuPq0a4mfV5kNaB8s+7zyQn45F1KMMNgt9mA843C7GtVOmnq6mlgxFJ2tQZ7HutdPv66NEF4RjuPu9ed5waT2HCS6KSdSGfBB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P3Cyny+mcYwz1jwFSE8K4E3sWShTXUh71C/hj9IWl4=;
 b=gTWTMZna3DkMP2t2BbLfW+hTipfF0H8hIZuwzCpSEIMB4JGQxdGK+fZ9cVGrrbnbP0qFfzoWFCU90ONN/7BiMzuPCmtFYjsC/NgDVtARMq2zwH1HHJCHvxrayCCoQ9hYZpuNYch5Y0aqUi0sJPgKn9W5xg2vGOUgpVDFYL4/djU=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:04:58 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:04:58 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 04/12] hugetlb: Convert remove_pool_huge_page() to remove_pool_hugetlb_folio()
Date:   Fri, 25 Aug 2023 12:04:24 -0700
Message-ID: <20230825190436.55045-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::11) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3179b0-4cfb-44ea-5855-08dba59e2d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arA0fqYiuagTDTT5usXxz3l50Irt/cQTgoVY4737hdO3oI7Txl5cHL1H2J8PEPse8WtibGhylArf+DwIibQnVqPVbXra5zFm1mCdIQ+KH/u/ZMB55XE+VH5xA9xUj/G5BLU0xx4yrMwn1tsQ5sfL3YaaRcwZPO4Giwy5H2waqlwWT5jAK1Asm6NRIE76VBSmo+j9YKR3RsSvmPNc3dbyb6Aq4w01U1uyIPs9ZtC/WJacn0wpQ1tgrbTFsZoTtIQnT8H5WobGoothiN2yWGZEEsDh0gCuL0bcpgJQEZyF8ysWZMRm+8elP1BXH4sm1Wcgx6oCqkiEtCPj3sTqPQb+tam7eQLGZxa8/yku+A8QHi/dZr1Wbafu1rBvCG54lzBoIJJ/HHKMoUQ6PcTCQzwdN4MYLJw9k/e4z71stvZ8RXXbubMl9StFt/I9TB379iwl8JzuWWJfVsRGD317IYCMmkk5+JWvXZwz/6mlw12+bNHz1UL0MIOnaQ3xndfY+88DlsGdjTlp9oQuIPAAlLZQ6pyHJlzbsONjoo5ca3I4ze2Aua20CJpQXyujSf0fXVGYgo9tylck631RNkbMQz2swK+gXY7gU82S0BUjHXxTK+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(186009)(451199024)(1800799009)(54906003)(66476007)(66556008)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6486002)(6506007)(86362001)(6512007)(2906002)(83380400001)(8676002)(8936002)(2616005)(4326008)(107886003)(5660300002)(7416002)(44832011)(1076003)(36756003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sDyjABoO2OnZ1+8Bc1YJhA4ZcA6z6Vq4x9xG00tC+QGE3DtXcS6VJgStCzzB?=
 =?us-ascii?Q?E+2mvU8cNggcivRi00WDaQniUtM9njpPIi9LamKsoMHxZZhB1I1AntTDlHI5?=
 =?us-ascii?Q?T0idpdXrhicXJZTNT3GIgHHRfTlxuCy9zbYEn15UnQ0WGp8HXgKL7cuotHJc?=
 =?us-ascii?Q?D/QF6lIeyGAo/KE+33zLOJgV42rAgLr7XWZQDHLrhuBDyzMwF3YBUGP8G7BS?=
 =?us-ascii?Q?JJ6rtFT+FkPKhKGsDLfhxAlbsyxsBkuIWvC2JiYZKZQLhGjJ5c7Wgpz9/OXw?=
 =?us-ascii?Q?7c7MzeTpo1F5/lXbSalnrF98B1SW/+J8uVm0sklaJib37P1NJaAM4D/zaOEh?=
 =?us-ascii?Q?r4dt/M7B/SQ9DqUHA+HYyLf1B9QwM1rEMJImy5nEmkWJZIpZrekX4KbyNRZ6?=
 =?us-ascii?Q?n00hnEh+23l3KyWiWidlZx+Xr/P5zlIB007CSTpgfSlW+rHQMESlBdnEvEAA?=
 =?us-ascii?Q?txo3SDwqojCYHYac1pN28uVivurlp4aZRgkZgNPRkw/+/nTJswNQIsymqyqQ?=
 =?us-ascii?Q?FDlZsNmSiA3AqvPiGHMRUGbPAnDFORXvRSGMdmFKmQsUw06w77CM6cj3pD1U?=
 =?us-ascii?Q?5hRhQpDYAfwkbUBzCR9qVe/xbfJigN+10pPmK3LzxgwqjVsBdnb698tlOvxs?=
 =?us-ascii?Q?lm9boiiwejxfjR0aXdgJyPmnvvDswvcIzqstFlGKBDnFH612EARUnfbKM1Ym?=
 =?us-ascii?Q?blRGPYzr6vKIl1f3b/BsotP4QNJaOfaQPjWaLa7zBq2Tr4QA3sEdgHlA7aLP?=
 =?us-ascii?Q?LQZds4lm5+cjQR/joNvKgfMPL8nfVlTBkwORL4MbWzSmu+xPm6onO/YRDooS?=
 =?us-ascii?Q?vO2PDDAs3E8h1WfUFsnzehQ3jg33Yzm24xgvdI3u+pO9asvcZ0vIDmOvPaLn?=
 =?us-ascii?Q?yPDroe+dfm4DGWzEhanUwPCuysms7Gh/r2kpWm5gy4Sy8f+D7FQvVYysTqI4?=
 =?us-ascii?Q?W4WTMNJZYOQXfBcyhdk9SM6jS9TTB5sLJ2tOyeDgE6NWZzoiaHXX6GhHw+EV?=
 =?us-ascii?Q?WaQpQYrip8RI6RKE/mD2VsPkFf8DRrsE8uoo/Gj/fnwbvy9XRdb8ELgnRucp?=
 =?us-ascii?Q?d1sQoif3AwmzhgACQWp8s+TmTH6e8+ceMtwqv+dt9PuSULHhYe0lC+hVTNDp?=
 =?us-ascii?Q?ovuz3Ay9zWY+21YGFbiE/ZwUG2NlHp9kQvKl8bdOyfQGgJuus/EPEK6N166k?=
 =?us-ascii?Q?/nYKkXq+gMajsIXhjHs2Y9GMm/Os4y/OalltRKskNNOWr+FKHvw+Zyyjr5dV?=
 =?us-ascii?Q?RK8iTSPnabTHpeCO0yHhrRqzBYAXHTEESzyu3P2MrJKsmFW3kf33UcWDdaFQ?=
 =?us-ascii?Q?FDRk7wrt9Il4mt8fS1T/l22T09CAQZW5fcdDKhDbFVFExZx+Xdv85cNkCdtb?=
 =?us-ascii?Q?KOQud4PdmVJbcWPCiqoHDJjQ0x2lfP8HtdDbaFRVIziCWitvKGdH38gPpmks?=
 =?us-ascii?Q?1v3V9RVEhtyQEijKnuxl8SW9khBCfvONj6kDBnfvqdtAIkQpsTTTDm/kkluN?=
 =?us-ascii?Q?c3Vuq23WQvE0AX3D5YLTTTjsuPQTPD45S+J2lUdkZIWjycm396ueQkf7BJaU?=
 =?us-ascii?Q?+diTfKCi5WnlzNRHtNGFT2eo8w7thasqW3QgNUapDWqCOG4zlXmY9N4ahuxB?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HoY4neH3eiGkzzi7sZjMmEKwYVrOQY2+tYoJdTx8GBqT3RwLeU0tZ01mbR88?=
 =?us-ascii?Q?VxCHxATCy68hTAe67VrlfTQDN465oezv+ujqu/EJXRhi1AjUInRUkj0iJuZb?=
 =?us-ascii?Q?TADUNvunp4E6cudQsuOLw/tXNUoTQCYrWSUZy58xV/KGbG5O0lNYfb67ruVp?=
 =?us-ascii?Q?wioa8QIaLT9PVl0ZmMI7dXPFpWRq1IXeg7opRpwmbmTlUo3OdPdNW6f1Qz0t?=
 =?us-ascii?Q?NUtIeV/BG7bEm3onRG4yeU9J+AWwP84wkYADdpMkIwftnpwScsNi9CHWmZUR?=
 =?us-ascii?Q?oydrd8WKBU39HhJ1an9S/efMsZ/I5qVMdzz/BOJNePUEwA7wXxjk5YFDBaKQ?=
 =?us-ascii?Q?wrgt7IBE7pWicuz3ETJVg4v5ZQGVavkA4wYKPNnuwPw0q/bTlJtoG9RYiadp?=
 =?us-ascii?Q?FjjcwwWHQGNOO5YnJ2EVXM9stouhDQayiIs6DbTXmCDxrva15cNWuR7cpiyr?=
 =?us-ascii?Q?irD4mWhyyCO3b+v8SOsHZdeL6RlJPVtogT4hVOe6+eWIKlWe8greUhFIzJul?=
 =?us-ascii?Q?mpazst+tm3oH63JR0igQb6z/AvhDm85bj27vfJHtPTosZ0B9gTvzWSoh4GGe?=
 =?us-ascii?Q?Ja8XZlf1KPp7cVtz3IEtZEttL+RJMULp2lKp+/3SimetFcqtmg+58e5pktNy?=
 =?us-ascii?Q?gvG0mYBcBvO/mxjIlkEO/IE//dVc9HaxTHG+TeobGpUtVMjvMUrhKgh9iTsX?=
 =?us-ascii?Q?nz+GSTmpZTRjCj9xL4qNUe+gOHs1sX+21mpNaH7aBwBsQ+0oeMoCGfR0V0Oe?=
 =?us-ascii?Q?K+Ko2qa7w94D09cm0PMV7tB1VFnfwCpyYfTUJD6Mfa7g3K7w7eKtXDFm/UgW?=
 =?us-ascii?Q?CcR/W3c9s/G8TlctnY4SiIye9z1KY7gtde0ALU0Zi2H4paRK5quFl9nON7Pc?=
 =?us-ascii?Q?O/xCnQVNfRoU/QhixG1HpNYXV5SSaQ8J1416WgY3vRblVMGQTK7gTidcrtr2?=
 =?us-ascii?Q?NMlmG0EkgB/4wXTYq9hEprojpE22BJ08zEMotSaaqlHgn+FHyjmp2KfTJdfU?=
 =?us-ascii?Q?zvxM1gvJxVkQjIp4sOfraNBnEAXBtkra9lwsDOx8Vw296wK3Mo8Oc5QaKROf?=
 =?us-ascii?Q?uLI1OqDWySmL629VUQk+bHuKIHMTHdHrGIQyYgnj0gHMwLnCz8a9r+FKJBCI?=
 =?us-ascii?Q?vKyIYl7vVIFx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3179b0-4cfb-44ea-5855-08dba59e2d10
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:04:58.4911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWYBOH6ca0+EYdEoSF9dsZIJjYIR1CZqRiUJepR7Tb6DK8aaYFM/c5XwO4XAZPvTIUZ3vz9tEMi0We2WGhUXbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250171
X-Proofpoint-GUID: b0m3FrRmbHGtG0JsJ0bwj8eE5EcS9YFF
X-Proofpoint-ORIG-GUID: b0m3FrRmbHGtG0JsJ0bwj8eE5EcS9YFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Convert the callers to expect a folio and remove the unnecesary conversion
back to a struct page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a5348dfada89..ec10e3804060 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1446,7 +1446,7 @@ static int hstate_next_node_to_alloc(struct hstate *h,
 }
 
 /*
- * helper for remove_pool_huge_page() - return the previously saved
+ * helper for remove_pool_hugetlb_folio() - return the previously saved
  * node ["this node"] from which to free a huge page.  Advance the
  * next node id whether or not we find a free huge page to free so
  * that the next attempt to free addresses the next node.
@@ -2217,9 +2217,8 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
  * an additional call to free the page to low level allocators.
  * Called with hugetlb_lock locked.
  */
-static struct page *remove_pool_huge_page(struct hstate *h,
-						nodemask_t *nodes_allowed,
-						 bool acct_surplus)
+static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
+		nodemask_t *nodes_allowed, bool acct_surplus)
 {
 	int nr_nodes, node;
 	struct folio *folio = NULL;
@@ -2239,7 +2238,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 		}
 	}
 
-	return &folio->page;
+	return folio;
 }
 
 /*
@@ -2593,7 +2592,6 @@ static void return_unused_surplus_pages(struct hstate *h,
 					unsigned long unused_resv_pages)
 {
 	unsigned long nr_pages;
-	struct page *page;
 	LIST_HEAD(page_list);
 
 	lockdep_assert_held(&hugetlb_lock);
@@ -2614,15 +2612,17 @@ static void return_unused_surplus_pages(struct hstate *h,
 	 * evenly across all nodes with memory. Iterate across these nodes
 	 * until we can no longer free unreserved surplus pages. This occurs
 	 * when the nodes with surplus pages have no free pages.
-	 * remove_pool_huge_page() will balance the freed pages across the
+	 * remove_pool_hugetlb_folio() will balance the freed pages across the
 	 * on-line nodes with memory and will handle the hstate accounting.
 	 */
 	while (nr_pages--) {
-		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
-		if (!page)
+		struct folio *folio;
+
+		folio = remove_pool_hugetlb_folio(h, &node_states[N_MEMORY], 1);
+		if (!folio)
 			goto out;
 
-		list_add(&page->lru, &page_list);
+		list_add(&folio->lru, &page_list);
 	}
 
 out:
@@ -3417,7 +3417,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
-	struct page *page;
 	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
@@ -3537,11 +3536,13 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * Collect pages to be removed on list without dropping lock
 	 */
 	while (min_count < persistent_huge_pages(h)) {
-		page = remove_pool_huge_page(h, nodes_allowed, 0);
-		if (!page)
+		struct folio *folio;
+
+		folio = remove_pool_hugetlb_folio(h, nodes_allowed, 0);
+		if (!folio)
 			break;
 
-		list_add(&page->lru, &page_list);
+		list_add(&folio->lru, &page_list);
 	}
 	/* free the pages after dropping lock */
 	spin_unlock_irq(&hugetlb_lock);
-- 
2.41.0

