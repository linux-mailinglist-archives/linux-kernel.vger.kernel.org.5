Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F81788F27
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjHYTG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjHYTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:06:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3222139
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:05:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEMlu020647;
        Fri, 25 Aug 2023 19:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=1D7XqVWhwIqkbRqvMvx7UBrASxcP9XTXO88KGrxsyNw=;
 b=XGZnny1mk5Tp15Iqn/7NPm/bRsrvoj4w77pjtk8OTaNoExvFo8z6QgX77mKB96+PEJBX
 LG0zMeEwQTx92cGeDv/zn5EgswruNEn/lVUYhYsrcSRHOnHI+kIZfTl1H38tsYZEABEa
 jcO/Pbf47Phjr/aFWKjU1BXzSn/4jIxEY3qc2F6Z6FtOye6c3gYMkezHMgZSt56xXJ5h
 FIThXNkX6WkuM0nrLEXgEZSrBC2qXnANgJBdV9XmfGzvSEI/qF3ZSNDa67mff69krNF2
 Ytlp8UZ965QKnH3mJn618QvWcxUxzua9RJ00qASMyrtw7GWvZXcIVvifn9J5l9DyESfi 0Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yu779r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIH5Qe000942;
        Fri, 25 Aug 2023 19:05:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yv79m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp46wsg6ySSmD8YL63Gb8ywxwTJGrLF9+PtVB8V4KNNT6TtPVewRflutN5DVyCZW+q28Mb5ucZu5SrGQAnBxXttoDXl4XmBQJWPPzAV1SCWrcJkL/BMc5owWlOhGFaWezM1l1ekKLtHx1HPe//neeF3yEEO0rZ441PPt/IqoQDhzkfxtQ8PmMTJBaL5KU+S2lzE5I2HCBIfl6gyT3kldYZvG2U0ukfbdH1Xw7ccn85vDJugyJ7ElxDZn8Sh1mYs3GonbKUVQQI/7sR8he8s8gwC4xgJ48eEwb6Ulne1Tm1odvHjB4jXaufdJrCHugxg/a0GyTaj3UBKWEi7t0f/bWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D7XqVWhwIqkbRqvMvx7UBrASxcP9XTXO88KGrxsyNw=;
 b=RfL6tOD5anylMFpNV7vG0zezUTUxLHBHtfkNO7NAFwgDy3x3m2mznNiiD37Nu428m1LGEar/nso4wt74tZ8FPicRbZP51zw5080JqdT6NtogdYVaTSdRQpxrL366FisJg+NfARf/ToFXpDezAXyZQMpo0L8D6jLVw9Vi6ZOMMc5NB2brgru2X9QJSSTcVfrPDJ897Xbp1hITMWbZjd4CWpY0LixfX6Lo9C8YcOlVa2+/yKWsBo2OoEngavumQ7s+daated3YUcxDVba7KibsIl8UzsOcx1Ftrwjp/ymX3A6VBT74gcwlaU3/FZrJYL23fpA1VcmBeIkbV4bMNvSxEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D7XqVWhwIqkbRqvMvx7UBrASxcP9XTXO88KGrxsyNw=;
 b=fN13S1eMfLh5RgTzNRCpLLiYU4avKxx22pJjV6GsnorZx4jQxgvBsbHhEs5ljBKKtWI4qijuctpPmdd00kbw7DzFPRA3FqLDvgiASVcIu7IfA8mkg45PGvEidsHA/MbIbm6mz5af+05DFByq6Psz5vw/WWrZqIIQ6R36rdlYhHc=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH7PR10MB6580.namprd10.prod.outlook.com (2603:10b6:510:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:05:19 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:05:19 +0000
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
Date:   Fri, 25 Aug 2023 12:04:30 -0700
Message-ID: <20230825190436.55045-11-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|PH7PR10MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cc4ce3-bc06-4cb6-c1d6-08dba59e3972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TH/mtV/sqimst11xZ31aIsahAJp+tuvMJLVDbkjRPL0pQ5JDV0GvQp6crCngSlJU43k+zJBqKukAxIMuk05Y/0gOzUrr9DlYv5LM9X6Ep3ILkikSshc6Ng1FtVdTFLAtaqvQ4/ND95dnThTnjyGMwkrdnNaFXonY+MmlFUPhs20nkBKF14N6k/O/jUmNIBtc5AxS3GKPSKGj/qwi3J6N6pjr4CuWF39m0nGS6BMZ25jef4Katzebih82o/mxDTPtjHAQOePbjmcBA+WeiK6mZOQUy2OdH6YxphjaE0KQ+8YkI6luexdNzShGBhx6KjmHo4UiCGdtcmQtuofN/2qROC5kDEKKV0sIxlewNIGUyp8JENypVmemKwEhAT18EcnaxWleu6UI+dZlQnNfyaQJx8LGT93NmOUL0uAYlQBqwWd/eapVqygOGUcQ9WjO/Vw5GKaGABS12EnRnPUB8TqgHXRf54AJeF9x2GMBsQ5ERpQ/Tnva2FNQeXx5OfX+n+QJ+INVbvUb9/Mo1jQH/ligPr4VA7xUDdVzrB4xxgHfTHBr9TYWO16Pa+Rq+plI3j4I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(66946007)(54906003)(66556008)(66476007)(316002)(478600001)(26005)(44832011)(6666004)(38100700002)(41300700001)(86362001)(6486002)(6512007)(6506007)(2906002)(4326008)(8676002)(8936002)(1076003)(2616005)(107886003)(5660300002)(7416002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2qGuJyf9zoUbjmBndJ8sXknO5gcBXuP/SyL4yqQLkSDL3zXSEik7+We06wWc?=
 =?us-ascii?Q?pTwRGbXYL4t0weeTLEsJrhs7LfhJTZkFjT6achXCMml8FZIs0SXdli5gZU3x?=
 =?us-ascii?Q?rJqHsmpGfpFGLLOwctOM/xDliS323CmEOku5aEBCbgtB1lJKRsdu9sG0jy/I?=
 =?us-ascii?Q?yPg4Rt4mfOYff0QLq4I4naYhdQQ584xoadEU5Sl2/siXSyZ0YqwBHAo2Lefm?=
 =?us-ascii?Q?Bhg2zGbeiH4ZUIJA5apUKmRQp2MpO15XE0QrxK84nSmqxCxcTGWwUQT4d5H+?=
 =?us-ascii?Q?VHY1fiY6xhll182NzWfFmbMku0sTQe8HLmRY653RuOe6fhkczxD/19qaQTXJ?=
 =?us-ascii?Q?UFRvRuZcYDojgW6V2ZkkO5fv5I3kywqTu31UbEsRXqh6/jDj1UA7/9WY+qDv?=
 =?us-ascii?Q?buu0b68lBVpDMtqm/lYOdB9mwN4/XbioQYdMJHpRBqLp334qFKARQQaZj0Ve?=
 =?us-ascii?Q?2UyvOArEveJDKRe0yqTMCQ555y8zsfENrOtPKPw4yP2q5jsUXqtgI5bopWIi?=
 =?us-ascii?Q?FUt221zgZn4X3DaYKXqkM7LYdacKDtEFLck3VdNxLCxwWu0huiCEG/AobZ4s?=
 =?us-ascii?Q?6JU5oATsmV7fAMT40WpzTK0IWJ/9i6f9TuwUYYRQIwaObq6PMuD9Ohb1cv2Y?=
 =?us-ascii?Q?ypCgt/kcL03W/nAOyoekn8TKNDjbKWWuLItwMgOIsdnb8OczJyZ2/n64DtWT?=
 =?us-ascii?Q?rSpov/BB5hp+X0SBmASF865ct/xGXXHoCzZzcDK6lP5JzbrnQbZRbpRsziuP?=
 =?us-ascii?Q?zuB9NR6Y8C7D5strDPZs2VhE+2rpvQjhFi0oxe3a3IR/wal2Lzca5sxNMIc+?=
 =?us-ascii?Q?8DN+1HUzCWT1Zj7Vqq6dnOz0voohZ/PLbcA4hTwu0L0/ZYgyKIUsFCdn2OfM?=
 =?us-ascii?Q?rzfDE59PPZO5x0HVqriOvm6v5R4WsWMIRDE+sPiiZJxwrLTvPdgr8bVC93mz?=
 =?us-ascii?Q?BPmzukFB5a6s7L1n68ZOryPmxkJWBeA7Op/8LOCVvew+3LN7EiRa2kbyw7W5?=
 =?us-ascii?Q?LJA6sGZb+A9Wa/NjX9O+bS58qPsEqYGs7cg2ug3MQjrqdZSLYZbheEhvV1SZ?=
 =?us-ascii?Q?10fuW3lxNGRKabUmsY+sgXnYkjfWS6fWlOnBdQ3VIdtLBGQ4otPajOvd7nvn?=
 =?us-ascii?Q?Q8bJYdzAsWAelYlnqlwywNMyo7kKbxrbaQj9AMzu8TRkBrP3jJCfEW1hE+bF?=
 =?us-ascii?Q?8kx+valFj+107MV/YIsl5vrchITOtJ/eypnEhWyO+JUBOm8HAWqLug3zeBz8?=
 =?us-ascii?Q?TfXBKD+eu2X3hDGMnuOGXR0RQJgM2UYCn+Fyd8hvghCvWtBG0V5Xp68sEZ1u?=
 =?us-ascii?Q?tOxGVQiTyJpayWKBvZDNtuGFK2Pc26pzbHr8Mk9htIyji+mlGXXlvwBqaSmH?=
 =?us-ascii?Q?qoT/QFmdDjnTsdHK5MZQoQ4ndTR7tnmEY4ve66q4Ode8ETO5edy8BulUiM6Y?=
 =?us-ascii?Q?/re44gx5EYi0GgDWe2xn3zZWI/Nd9YQG5LEmfYRqvKMU0QGqYcbWILvqDhMn?=
 =?us-ascii?Q?gIWUzvrBzlN0ma9DlMquHu8sF6kP2RFqC7MU+ObWK5lHgUTUCHKhZmYK2Fj3?=
 =?us-ascii?Q?7fCD7b3cA/fUGzgWfIQNIF8eoPOUq3hhMCHzlJjckEHQm40kPASqpk8xKM2x?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5Na0018J4TK22mjBFP1Awvmq1mHd8jb9g5N0RX+OzRPqVLhba/COFv4Eqd52?=
 =?us-ascii?Q?fw7Zqa05B5IoV4hcnIKjumNvTjarLbBqM1OSkCEUHtmNdXx5dv7F2/w8T2AK?=
 =?us-ascii?Q?doIGXULOW3qD/TLfkfZdS1el05GJDoMwLDBqUkElpaSkKj0XOZsaf2fVSFDz?=
 =?us-ascii?Q?UJowAquvRvGRHFeCgVGJAjlmZSvJEZca8mFzD8OCCaJQCbB4jqdlyaWNHvmq?=
 =?us-ascii?Q?nn8fLsytev29Y2Arr6yPSbOd6qdWKFuZ8Q1hvZ+YOxd9Ad32WacTGO1D3ygo?=
 =?us-ascii?Q?T4ozSlqSjOWZAyefFbBT8ILf4L+RShhWtcbBvYip0rtPEUKO6mu56qpWioJt?=
 =?us-ascii?Q?xrssFj1lhPDkBCxT/B6S0EwmsWx6PrV79k4Vi21A6Oqfq8xyZThqKzD2a4ps?=
 =?us-ascii?Q?l60G/zRA7smYdfNW/Y0v9IMIof5pBE7t7fI+IFr9Vk5G+/C9Te1uvbaDjXWb?=
 =?us-ascii?Q?JxoyqJcz0agtAYGhLn+4/gFLW3aa+nB6wbIMt+thHAKzYqvIUdOClXDi4bx0?=
 =?us-ascii?Q?CFhjYc68RiqinU4HXXbw3XJvuqGr0oI/GFUDsWh1HgbkxRkkmVNb3AsPJqcM?=
 =?us-ascii?Q?9n3QKldUdl1DaEpUczFLfBZZYvLg4MzqTDSkKIsF48M488ylQsrCCN8IPS2N?=
 =?us-ascii?Q?kJ60QwOQVYQeQBiwfJLtYvvPTTI5Bc9r6VWUuSB8As3oMIjQhTdBi/hVfU/7?=
 =?us-ascii?Q?/piR0w4cNh5gPam8n1zLRRHHr0EzLx7jgA7Fws7E80ktOqiTneLmZJF14y3A?=
 =?us-ascii?Q?GTLxF6I+MNsVSnT9zMGoHPYjQzN9msq7Eei5Mrz67FOpnO8HseuJ/oDwhK0D?=
 =?us-ascii?Q?a5u2dPdI341Mfx3kXA+kzQwZJIvS+9ufNQXYZLxYqBghfzQFUfwwBI2rErGU?=
 =?us-ascii?Q?SPe7oze8q81bFJnisO/lefo31414hKQzLQoQ5qBMRpU2k+AfYJxR9kJlte5r?=
 =?us-ascii?Q?oBP3h2V/PK/AIec1swaEZb2OBf7nHLy3p2BT8ebY/feIHSCs5Q4cbAQB8zdF?=
 =?us-ascii?Q?qMeoC3OWY/FzcyyEucJEXT/ELl6ZUvT1pwUD6AD0wK3spYHU8uyVLI998EVH?=
 =?us-ascii?Q?bYUzIsGBEcFDxGGH7hTPKfym3+hO0ZUX/z1FWkwYzXiCnwmFlWoRuloOI9S2?=
 =?us-ascii?Q?OZgqNUcvXVi3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cc4ce3-bc06-4cb6-c1d6-08dba59e3972
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:05:19.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4NhHKJIv27o2YjGCnDkACiRmC91W8gezH2F/jZ0WqLFSi+QvNizHYenh3TzGddgjbyT3jDTlzjtrKmemz6eaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250171
X-Proofpoint-GUID: H-ODefkFRKhDbLIp3WcUJaGTuSa0E1dP
X-Proofpoint-ORIG-GUID: H-ODefkFRKhDbLIp3WcUJaGTuSa0E1dP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

In an effort to minimize amount of TLB flushes, batch all PMD splits
belonging to a range of pages in order to perform only 1 (global) TLB
flush. This brings down from 14.2secs into 7.9secs a 1T hugetlb
allocation.

Rebased by Mike Kravetz

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 94 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 500a118915ff..904a64fe5669 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -26,6 +26,7 @@
  * @reuse_addr:		the virtual address of the @reuse_page page.
  * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
  *			or is mapped from.
+ * @flags		used to modify behavior in bulk operations
  */
 struct vmemmap_remap_walk {
 	void			(*remap_pte)(pte_t *pte, unsigned long addr,
@@ -34,9 +35,11 @@ struct vmemmap_remap_walk {
 	struct page		*reuse_page;
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
+#define VMEMMAP_REMAP_ONLY_SPLIT	BIT(0)
+	unsigned long		flags;
 };
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool bulk)
 {
 	pmd_t __pmd;
 	int i;
@@ -79,7 +82,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
 		pmd_populate_kernel(&init_mm, pmd, pgtable);
-		flush_tlb_kernel_range(start, start + PMD_SIZE);
+		if (!bulk)
+			flush_tlb_kernel_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -119,18 +123,28 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 			     unsigned long end,
 			     struct vmemmap_remap_walk *walk)
 {
+	bool bulk;
 	pmd_t *pmd;
 	unsigned long next;
 
+	bulk = walk->flags & VMEMMAP_REMAP_ONLY_SPLIT;
 	pmd = pmd_offset(pud, addr);
 	do {
 		int ret;
 
-		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, bulk);
 		if (ret)
 			return ret;
 
 		next = pmd_addr_end(addr, end);
+
+		/*
+		 * We are only splitting, not remapping the hugetlb vmemmap
+		 * pages.
+		 */
+		if (bulk)
+			continue;
+
 		vmemmap_pte_range(pmd, addr, next, walk);
 	} while (pmd++, addr = next, addr != end);
 
@@ -197,7 +211,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	flush_tlb_kernel_range(start, end);
+	if (!(walk->flags & VMEMMAP_REMAP_ONLY_SPLIT))
+		flush_tlb_kernel_range(start, end);
 
 	return 0;
 }
@@ -296,6 +311,48 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
 }
 
+/**
+ * vmemmap_remap_split - split the vmemmap virtual address range [@start, @end)
+ *                      backing PMDs of the directmap into PTEs
+ * @start:     start address of the vmemmap virtual address range that we want
+ *             to remap.
+ * @end:       end address of the vmemmap virtual address range that we want to
+ *             remap.
+ * @reuse:     reuse address.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+static int vmemmap_remap_split(unsigned long start, unsigned long end,
+				unsigned long reuse)
+{
+	int ret;
+	LIST_HEAD(vmemmap_pages);
+	struct vmemmap_remap_walk walk = {
+		.flags = VMEMMAP_REMAP_ONLY_SPLIT,
+	};
+
+	/*
+	 * In order to make remapping routine most efficient for the huge pages,
+	 * the routine of vmemmap page table walking has the following rules
+	 * (see more details from the vmemmap_pte_range()):
+	 *
+	 * - The range [@start, @end) and the range [@reuse, @reuse + PAGE_SIZE)
+	 *   should be continuous.
+	 * - The @reuse address is part of the range [@reuse, @end) that we are
+	 *   walking which is passed to vmemmap_remap_range().
+	 * - The @reuse address is the first in the complete range.
+	 *
+	 * So we need to make sure that @start and @reuse meet the above rules.
+	 */
+	BUG_ON(start - reuse != PAGE_SIZE);
+
+	mmap_read_lock(&init_mm);
+	ret = vmemmap_remap_range(reuse, end, &walk);
+	mmap_read_unlock(&init_mm);
+
+	return ret;
+}
+
 /**
  * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
  *			to the page which @reuse is mapped to, then free vmemmap
@@ -320,6 +377,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
+		.flags		= 0,
 	};
 	int nid = page_to_nid((struct page *)start);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
@@ -606,11 +664,39 @@ void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
 	__hugetlb_vmemmap_optimize(h, head, bulk_pages);
 }
 
+void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
+{
+	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_reuse;
+
+	if (!vmemmap_should_optimize(h, head))
+		return;
+
+	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+
+	vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
+	vmemmap_reuse   = vmemmap_start;
+	vmemmap_start   += HUGETLB_VMEMMAP_RESERVE_SIZE;
+
+	/*
+	 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
+	 * to the page which @vmemmap_reuse is mapped to, then free the pages
+	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
+	 */
+	if (vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse))
+		static_branch_dec(&hugetlb_optimize_vmemmap_key);
+}
+
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
 	LIST_HEAD(vmemmap_pages);
 
+	list_for_each_entry(folio, folio_list, lru)
+		hugetlb_vmemmap_split(h, &folio->page);
+
+	flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
+
 	list_for_each_entry(folio, folio_list, lru)
 		hugetlb_vmemmap_optimize_bulk(h, &folio->page, &vmemmap_pages);
 
-- 
2.41.0

