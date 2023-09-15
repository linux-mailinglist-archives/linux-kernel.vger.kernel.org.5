Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5B77A2A60
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjIOWRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbjIOWRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:17:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C1191
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLx9pG007419;
        Fri, 15 Sep 2023 22:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=qMEVjuvfkFjYvAgifMfI1ykIObOzu1AqZltnchTcTjQ=;
 b=yKe4AgVAeecCRxLkm8a0yu3K56ssTMsX/b1DldJY/PwJhQATjWxCktUBGqDy7YzjJljg
 A1nHI1mFvxrWHAeMn4tEaA4rQ323e7Pwi9K8rXgCdq1IkbqHnc3x/T/LO/ZcnbXdaSUF
 1JGRa+9C5cpeHRIcifcVAjaT7wcrj8mdngjo7CX2nSnJiJ58H9VEoqdh76l5jFJza130
 mPdHdUBFSje8TnFaijpWEjE4A4z3/ghspwQq+hiEN61ph+6bUzJtKcQh9L81KmpHrDUf
 /EvEgdJgweBsY7l7aClpjGS8GXgZVzGZ+j8s4+9mlRfNsxnD5Lcu7ThTXTWSRJen4U8m /w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7hgsw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLT2W5030436;
        Fri, 15 Sep 2023 22:16:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkky7bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIjsB/ARC1KioLR0Lnr9fyYS8Ue+SXOCc6LxSeEqHviOsKSN4w8b0s2To9KHTxBzG8idflUTCVsZO1c5zCAU8QhH8LJ/gmOsvZh58Osj3zbct9aHi1bygXRX8I13AKtwv1DvCnJy1eLm5tuxgt2j0HU9uP2lgmDL2i96ALfoJtSK7FdSHQCKXVmqzpz0oZCo8ccyQNQNQfte2uEQHs/RDOG/McKD2aiJpqPy3iRhYeiOdwM350UEAuI5ZJqWquyXjgadPVQkVUlJ8xIHmp7X0Jj199N7JzmtnxauZox7G3UwuyluTuVvg+eYhnDokHG+bMRmzQ4DbmHNiE2gct+/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMEVjuvfkFjYvAgifMfI1ykIObOzu1AqZltnchTcTjQ=;
 b=kup2QUgVPEHlI45bkXqLlHZbB3Df+Kullt66f8pDFCHKUqu2A2HemaKA5a1hnhCLMI2VkNiySo/BFSvnSLHFzSes1+yZnlQA50tH3D3UbnKO1vwvNn58BvRo+ZBK5ntdWiltj2CXAWgWUQniQFmIaWvBCp6nuvZ+N8KSjRjW/k9p7q2iTSgRTnTAW4q9CbLFFgKsBhy/YDKed7uA0E54Q7BMqcj8I6YvBzIfQsdGT6MH71rcrTOuo50qRS++FkkMfzijl1VSR2q3c9du4L/XD3MX0BFDcFl1WexYAuPpizTrnBQaezJ2miZiQKChpUN8DbQQ/VMeN/Xqfc6gkOUPSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMEVjuvfkFjYvAgifMfI1ykIObOzu1AqZltnchTcTjQ=;
 b=nzqn3FtNt88Av3X4XlmOd5b5YEuPibh/F1MOkad1ze9uMsEx6V+wlkk9VK1ZWI0ZuC1mfEG3r+2Brr7R8wZfMQcnP+7oGyCDqXgHBbNfvgs0XBrCQm8+fKhC27Sj0EHAftQYgK88dCE3eofN3eRtap/dKivQ1/i+sR5XMjpE0bE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:16:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:16:17 +0000
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
Subject: [PATCH v3 09/12] hugetlb: batch freeing of vmemmap pages
Date:   Fri, 15 Sep 2023 15:15:42 -0700
Message-ID: <20230915221548.552084-10-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2c3b76-2789-44b8-2034-08dbb639618e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oSU7QTzK/v4SvSuOoilAkoV80j8viuRa1HfM1/stxBO8fGuCmRW0IYxHuYf7bIhhit9/KgTQsrHu2tb3RJ0z9HI3UpiUsbwWCtY3TXMrH+G7gmqV6QGLIISFhIDHDf/luEXtHsGuDebhmtbtoEFq8u5a1ljUMxVCHUD3OYqRtYAXTJGKiRvW3d+vMIIbCrWxENQJvs0XftujCWAYCdb4d1C27vURfOGt00+hlsSRCtHpma6OpxnaGFaHV30sNWtvbEjRDFT4h7jNr1zXTESZxQSjwxhGA5z6lVKuG1YJUV5Ln3C8dXZUaf7tLu+Ms0uJeVI66WHwSzkRJt5Fq/V+Z1wQJLx62hiM+oCiG25HzcsNNpbcpipTIEBbhH8FJ2HHRnCRM6ouhJ19SucbJ3OsodXV9OamexJKGdzdRJXfasusScg/V734XPQlcg4r5MiE0jL7Y0ywhqg4WvJWe1ETTZ8ZD5e3WV9w6CosI9bWmtP1l9QrCfMs5dyPRAxznmexh+vUQU5LKDJBR35d1vs5hwcXKQqdhDXj/YwzrM2lrnyU4mxXcjBKjYG+pwvXs3g6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iFrVz4s6v4uIN5jTg6lJouiLySvuAWKJ+Rlt7377C+D469XIA0hFR4LJ6Gg9?=
 =?us-ascii?Q?WLtnEnXU854ZFbQKWNOwLcaLCmPXr2zi0I5PeMU2NqXt+S9BY8DSOuWGv1we?=
 =?us-ascii?Q?NFU/fH61ERr4glCFPZBvJfwO6XbBt+TQc6Wj35ARC0atva2A1PU9D8v/tTDm?=
 =?us-ascii?Q?5/QJGGP0EZVM+odr4NG6kiSIk/nlQe5zVGCV0HHcA/PaEzWg+txLznct2iET?=
 =?us-ascii?Q?7l3fS3xKC2Wxe2Pdba/Nsmov4slkUXs3b3BSqMJ2lnZ7+c2YW+8etaB9dJGc?=
 =?us-ascii?Q?V8PnbOA/QZFR3ZaOjdf0l1c0ODjaz1H6+51OBMQfQeMLvIBA3gPbY2hGUhiV?=
 =?us-ascii?Q?UfFraMe4hKbqduttUBnA0UnNK6Bv1GSVRZcRb0j2AQcDEie792kuacY4E7Tk?=
 =?us-ascii?Q?2B/MghaN7PX4q/3WgR8LXKZUU4nQkzkpzBdgZnMfNIN/yopIVSWBltSNVyEj?=
 =?us-ascii?Q?2PaJZIQHC52lko4eUsFQs0UUicvhSfr0229zzXtgOzrINptg11iPVB1Y5Rps?=
 =?us-ascii?Q?1NBchThJomiDK5Oqk7q3D2qlwbTITBLP/8cN8YtAGngx+DgvRsXeOeq5s8wf?=
 =?us-ascii?Q?uIr3Kuo1Dt+5Wc2uR7+dqYqEttXfFi+9KgKnkgm4/vrSQ+HnFUY6EALIb4ar?=
 =?us-ascii?Q?MU8Bzd8qy9sb/cGEB23IQzo70aoQUmf5N/+5UaAGbDGh5APSZsPEM543+WU3?=
 =?us-ascii?Q?l2njXYYFoG5IuypY/w7wzqTszJJVTVLp0J5ahkSvcplx+yzCjqi+6af5i5NY?=
 =?us-ascii?Q?VqXHVGaHqa00W1cSEa62pw6oEZMpCInV9itNxfxjAjoJCrbp+BLD56g/THqC?=
 =?us-ascii?Q?FBA8UTbuu0C18yDFEpu4Z6JD/T8Myet6Fl33x0nTsHMWlGdZX/ABvwG6spnX?=
 =?us-ascii?Q?Wc1ZPnWvxrEVyaRv5UfDTKhxcfY1Y8M4AB1TwgZrEpbgohBffTgALh119UV4?=
 =?us-ascii?Q?4cm36f23GyzX1qYzOoWaS48i4r3MpdGQtJdTk5XZpKt+LbUuEsmTMRZvzJvE?=
 =?us-ascii?Q?a0Ch/2QaJFe4V3r6K69zH2SYQxl1rxiG4fiiZsZqFax9xhpJRLX2AdmWgz4l?=
 =?us-ascii?Q?hwI2kPVSo+R9WrOfU96cPnPSf3b63uZ/1+S74Jcl893ll1YCEZAZDvXy04V0?=
 =?us-ascii?Q?yLayZZyUAsZFVo/SpgVonkT2CCbOokgDWlnLvuplr5lKWRD2xL61DEjmXtlS?=
 =?us-ascii?Q?D9OTKmiVm+HJ10j5+cstbiJF1zjHV33NdYPxI/i9e3/YDwMHTDofff+0FqsI?=
 =?us-ascii?Q?fctfc5pN384gsEXkEAk3vZ7xDyvfSc9Np49hIBlk5eM0ldNx15caoGdkCFQH?=
 =?us-ascii?Q?0OFVXW3a1dgbpIsUCnFKRHAh2Izqococ4j3miZO6gPJT3Moo91IXutx5npDy?=
 =?us-ascii?Q?pDjm7OthcLVoASIMIZRvj2IRn2CarVMJCn7aoZriH0czPrJkjRWNiq/B2iyk?=
 =?us-ascii?Q?ApxZpKG8yR/i5XYsCe+zbft/wukekWXWFmsOfhJMSubu8bjGL16N6PziPOPo?=
 =?us-ascii?Q?UNSP2i/kDIfZzgFCIbpYlQezQbHPhYAeS3X7dRRLh5aMPZaRwQ3m0K4tbgHW?=
 =?us-ascii?Q?7ryzLbo7LQxkOW6ZfSFbrt2W2+gLTUhdpQwiuN9LTwI4gNZi+ZT0Qfikb8xP?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ps0r0JVQXB4tlo465QFf+bb24uD88888b/BhSFqwyj/RPBKEiF3KM5F6yKAt?=
 =?us-ascii?Q?vZdNPPEPmR82LCVPsFyFwW1ZLBW/JXPOpw4Oi/yjUcHWaPdDf2ZyEfhlUaVK?=
 =?us-ascii?Q?2ZUycvdijipt8TBqyuTVWC3iFXhUFgO/bja9xnvX5bXBZVr6NoLmeUD/yZXj?=
 =?us-ascii?Q?xvBT1GNNIiWkIxE6YCgZjhi2yehnM8FdelsCOWvw0OWwEoOsOixx+Bk7fDou?=
 =?us-ascii?Q?+xW+rhdPVrtwQ2bTLl6ZsSZzJB70IfPfJmf0m1TnGN8TRUcA8oU+hBw/52ow?=
 =?us-ascii?Q?1TA5M22iomzJJKi2CORtEj2/6iWUBCokcnDzL1c+k9l7SbjtheARVTmrXU7C?=
 =?us-ascii?Q?RVQFYmo0mMLSkSb5lldTsSXNdK+da6hMylDjVCoekIkB8p/TB7k7GkjO62Ii?=
 =?us-ascii?Q?GicVyz2EtG0nY1CjkhFTV1nr9esTVGl5qbpN5PEHxAanx7ON2NtjCMJ9yjWN?=
 =?us-ascii?Q?BjR0uhP/PZiD2BMbqVgncjCMJgHpE8ZMn38lJTGVsEpqmrOXFwCfv5fOgrQJ?=
 =?us-ascii?Q?rdvgKIj8Sy1SXzRyTQk4Tf5U7LdNWH3i8w13jU5UgnvNJAQ1GuWeLYt5lphz?=
 =?us-ascii?Q?YIJCIK4IsBXzrQ6wKXEc7oAeeoB686aMWliXjx7RmjnCinIgpfpB8BdFsUFk?=
 =?us-ascii?Q?02rp3TYQ2sfc3CmQsjF9xaoflaxoUwOlatgrP+IvumVYsh38qAV1L+GDNsyF?=
 =?us-ascii?Q?Fpz/XLnJR/zb9Hlw9Dnu/De5j+57YxGXoBy+peCH5KhgR/2Kw2OtmxPGSsuh?=
 =?us-ascii?Q?WpZl3gdvK+OLl6tGxnGJQYCUJ1Ht/E2Q8Q/tDKvOvBtwZzgvv/GMY4lMK2AS?=
 =?us-ascii?Q?rLZwPfuCJnLSNYT8n/ipEUTuWwHZbdESL7uhbExEgLI3jTSuIZPP5NdJECH5?=
 =?us-ascii?Q?ZQWSVjK0zxzd72Ls/GYzlJ2rfpry9x7qMjhGSJM9AkSpKzEZGHa7Iq4ViWxU?=
 =?us-ascii?Q?snq3m3ul+AdZu47rUQapOOLoe8S3gijXo82+G2gyjNeDIM/kbFUmKIz+IlEF?=
 =?us-ascii?Q?ZehUgVnfvwt5v7s5Mf+8H82r2gyCYU+OYwZ2xnXe+CFdvSKOxnEwF+d2Cwsy?=
 =?us-ascii?Q?Sd4VE88nk6TAB/+dGhUrQLEl2qRstzZKuwfSSfAtUUP3NtEjkKgfx6HeGFEP?=
 =?us-ascii?Q?QM2JZE5fM4pn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2c3b76-2789-44b8-2034-08dbb639618e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:16:17.0488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+qqFJ6mvOfgJ/Vf6y2CkI3FG7KFafnmZNedrdQMI/XYzIq9JeJzWIWp0vi1ocVzWfSpvwj7YKfqz3DAgkksOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150200
X-Proofpoint-ORIG-GUID: GBV07K0Cu-JuI4Xj5UkNQK0it1kmM2rJ
X-Proofpoint-GUID: GBV07K0Cu-JuI4Xj5UkNQK0it1kmM2rJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that batching of hugetlb vmemmap optimization processing is possible,
batch the freeing of vmemmap pages.  When freeing vmemmap pages for a
hugetlb page, we add them to a list that is freed after the entire batch
has been processed.

This enhances the ability to return contiguous ranges of memory to the
low level allocators.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 85 ++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 0eeb503d8a4c..8f8a559ff6ac 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -222,6 +222,9 @@ static void free_vmemmap_page_list(struct list_head *list)
 {
 	struct page *page, *next;
 
+	if (list_empty(list))
+		return;
+
 	list_for_each_entry_safe(page, next, list, lru)
 		free_vmemmap_page(page);
 }
@@ -251,7 +254,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 	}
 
 	entry = mk_pte(walk->reuse_page, pgprot);
-	list_add_tail(&page->lru, walk->vmemmap_pages);
+	list_add(&page->lru, walk->vmemmap_pages);
 	set_pte_at(&init_mm, addr, pte, entry);
 }
 
@@ -306,18 +309,20 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
+ *		responsibility to free pages.
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_free(unsigned long start, unsigned long end,
-			      unsigned long reuse)
+			      unsigned long reuse,
+			      struct list_head *vmemmap_pages)
 {
 	int ret;
-	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
-		.vmemmap_pages	= &vmemmap_pages,
+		.vmemmap_pages	= vmemmap_pages,
 	};
 	int nid = page_to_nid((struct page *)start);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -334,7 +339,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 	if (walk.reuse_page) {
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
-		list_add(&walk.reuse_page->lru, &vmemmap_pages);
+		list_add(&walk.reuse_page->lru, vmemmap_pages);
 	}
 
 	/*
@@ -365,15 +370,13 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		walk = (struct vmemmap_remap_walk) {
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
-			.vmemmap_pages	= &vmemmap_pages,
+			.vmemmap_pages	= vmemmap_pages,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
 	}
 	mmap_read_unlock(&init_mm);
 
-	free_vmemmap_page_list(&vmemmap_pages);
-
 	return ret;
 }
 
@@ -389,7 +392,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 		page = alloc_pages_node(nid, gfp_mask, 0);
 		if (!page)
 			goto out;
-		list_add_tail(&page->lru, list);
+		list_add(&page->lru, list);
 	}
 
 	return 0;
@@ -576,24 +579,17 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 	return true;
 }
 
-/**
- * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be optimized.
- *
- * This function only tries to optimize @head's vmemmap pages and does not
- * guarantee that the optimization will succeed after it returns. The caller
- * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
- * have been optimized.
- */
-void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+static int __hugetlb_vmemmap_optimize(const struct hstate *h,
+					struct page *head,
+					struct list_head *vmemmap_pages)
 {
+	int ret = 0;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
 	VM_WARN_ON_ONCE(!PageHuge(head));
 	if (!vmemmap_should_optimize(h, head))
-		return;
+		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
 
@@ -603,21 +599,58 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 
 	/*
 	 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
-	 * to the page which @vmemmap_reuse is mapped to, then free the pages
-	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
+	 * to the page which @vmemmap_reuse is mapped to.  Add pages previously
+	 * mapping the range to vmemmap_pages list so that they can be freed by
+	 * the caller.
 	 */
-	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))
+	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages);
+	if (ret)
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
 	else
 		SetHPageVmemmapOptimized(head);
+
+	return ret;
+}
+
+/**
+ * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be optimized.
+ *
+ * This function only tries to optimize @head's vmemmap pages and does not
+ * guarantee that the optimization will succeed after it returns. The caller
+ * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
+ * have been optimized.
+ */
+void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+{
+	LIST_HEAD(vmemmap_pages);
+
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	free_vmemmap_page_list(&vmemmap_pages);
 }
 
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
+	LIST_HEAD(vmemmap_pages);
 
-	list_for_each_entry(folio, folio_list, lru)
-		hugetlb_vmemmap_optimize(h, &folio->page);
+	list_for_each_entry(folio, folio_list, lru) {
+		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
+								&vmemmap_pages);
+
+		/*
+		 * Pages may have been accumulated, thus free what we have
+		 * and try again.
+		 */
+		if (ret == -ENOMEM) {
+			free_vmemmap_page_list(&vmemmap_pages);
+			INIT_LIST_HEAD(&vmemmap_pages);
+			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
+		}
+	}
+
+	free_vmemmap_page_list(&vmemmap_pages);
 }
 
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
-- 
2.41.0

