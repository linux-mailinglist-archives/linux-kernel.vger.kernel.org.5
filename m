Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6914757114
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGRAuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGRAuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:50:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13D110DF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:50:31 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HKOL3a023700;
        Tue, 18 Jul 2023 00:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ZgV7qJ5Wq9AaKiuOJNgLUYIz8E1B+1MkUqffdohg7SM=;
 b=MlWCxkzX4YDQJmrpp7+xKoYrbHnz8jJ6+BvO57qEhd/1X+AwaP3EVACY+hFcb1RC/moM
 1wggJqacg13/V9BY0W01wXK5woluj2C9gupKTd7MRSnUMoTqAGu2Qw4OOb2sJQcA0z7y
 aTyE2nLiUT2VsvCXOZ8IVSq+M7ShRLa8rphfWdLPVtjJqbtSZmOJlIXRR1GtszaMcMCG
 os66GlVCwV0/3YGfDLx/pJWU9Dhl2wiH3v/vUzIrmR5NJOLBFpqMzpYNsb+s2rhHsQ3g
 ujlh6MxfFP4UnercS1moL087wl94YsSjW1AiZTUooKCvasTITZgbXVu5Lr+5bq1BgFZ5 YQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88ky6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 00:49:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HN24fc007757;
        Tue, 18 Jul 2023 00:49:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw45dqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 00:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHKucMnXopTCDhuXXPr+XTd87+Kp0ayLXxDMDFI8Mh/QarplmsumP318CUKTB7ggcOjPOEGGB3KQLOTzX+MrARf2TF6f8UJFX08ZfNa5dmQid0AzDk4BAzRDZQNxBZmBcrReO7MdjvXfEMMv8fzfyIzK5djtDTxzuaOx9ztQhmfBlUEV+QCG1f15j+WU8H6nVGJDLHLpJsxvQCYZdAu4yTiVJi3PPfnJjXi8EaIo7f5JSbHc617uIJMd+m+VuI34bc3FzVtobBQ1zs79a77gX3J7dMfdiXDY/WvJ1uvPPMC/43rcDGe9ZqcfRxABH/UZEieWvWEi5JwM8VScJa9RmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgV7qJ5Wq9AaKiuOJNgLUYIz8E1B+1MkUqffdohg7SM=;
 b=LFmHjmWFcQykli3VcAsf/UF7Jxa9qtaS4vTG8Fu6r/Pc7ogJ8NQSsEasLvuaoQd4NELWROjn6YBsi8hAvNWyIjqhi17dSvjrF9kYDN4v11tk71UCFl0EGB4ZHNrpUrcug4l4etk+aNlbAGnbsMhk5Jht/ZeV2bFEBY/+vxqT8Mr2EBwI2b0lNncmbRdernUl+DKX5YomFWV4b5Gjd8nI5AiJ9dTs94UEHshK60TKinnzSzBpUC/eoVpJBeEYZba3Kt29jw2XXtUXO4gULDtVjjpYorm3XxRY/jJJhJgqXm9PeiH9Zgk/v9Shyp/ryiKv619AkN3RrR3HkZX8XqpshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgV7qJ5Wq9AaKiuOJNgLUYIz8E1B+1MkUqffdohg7SM=;
 b=ONQlmkrq8Hsb49WH/qlMrRs0If4jjIDKq0lBHnFCRczwPoEO/AE6W1vCOzZdBdTYtLhQXvj9Fqz7k8+NiYI0hhHCXVj+uJOEqtaht0AyZC87KmvgHHTY6oDAzLtXXnyfQIFK4CQhuETEyI9ePWZLtDH/EqvFianBkjPB2bH3mXM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6193.namprd10.prod.outlook.com (2603:10b6:208:3a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 00:49:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Tue, 18 Jul 2023
 00:49:53 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 2/2] hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
Date:   Mon, 17 Jul 2023 17:49:42 -0700
Message-ID: <20230718004942.113174-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718004942.113174-1-mike.kravetz@oracle.com>
References: <20230718004942.113174-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:303:83::32) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0a0528-001c-4cd6-4f73-08db8728e5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7muyrlVdGiGSoIwzPME2poQSpbS6wzNvMgQAw4qHdh6eKsrn6xNBzAKlbnot6RLfrrNalsc5fAYPToXGNsh9K3T1ReKFYDiVMsf2rKEwMkOLUKtgD4X4d8io25uzLppTLyBD865cD6XQ0CrwCMsXlinQa6HBa/+IL79LF9JSLIiih8XEGhEiy/H0nvA+D7cpjR+vV+bIaiet4NBEbxLw01/av5UTL/EhQj6YMHKPMp2kNURo/qs3e96GKToMqmrbnTcjnueIgysbX1vVlgHzLclwHaUKWcJCbzgXGjEl7ZEVy8YlqxbKa6cnWYDRFdAuba/pdDruWBfRAlLfZSYRPfXviO3SxiHWH5mF2Nh4jNqNwtHxn7369/eEL/Pm/7qKASomvKqEGosG2yuQ+AvMdIF59JV+E1DuUt1Fo5cjJamM8sAseDaskOIHSwEa4l0qlAHHfqI9BWDO+OmTsBxfPePw5DQ5URSimXalZ6IgyRuKr/8Mmrkx9cHIrst6KUZtSU0Fy0dgkglWIM5VOF9zcBZ40p8Oa3Om/pt6Gwq51wLVg0vKlURP5zmOkwWoCXKo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(54906003)(6486002)(38100700002)(6666004)(41300700001)(8676002)(8936002)(5660300002)(66946007)(66556008)(66476007)(316002)(478600001)(4326008)(186003)(83380400001)(6512007)(2616005)(26005)(6506007)(1076003)(107886003)(86362001)(36756003)(44832011)(15650500001)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bMmnxjIDcqNnb/iYJoQ241b+5iEnY98WoX/AKOg0gPnYQM6U962+6DW644gY?=
 =?us-ascii?Q?BVA/u7KEIsjWR3IgMkH0a96lfNC1Drr4ORuJrMVFnw4dXXJ0ZokgZtavh1Xf?=
 =?us-ascii?Q?Kzei8mAUGzFcfXrO5N/2cohfC2skoihlVBsEt7ipwWkB+L75VGvKdckeqdFB?=
 =?us-ascii?Q?Bogb4JUTmqW976CivQDy3kLKinNnzFjS7tVzLRPabvQ0ZeudQJWtfTiWx+No?=
 =?us-ascii?Q?YjX29QD7CcaUyl0YToXjl20O1/gXWoIPJatDmK4A9uGRCaAURuRS2Neo7gr2?=
 =?us-ascii?Q?7qHdiEyHJs7j/drz1FzhU3IKBsw9FZzAU8bhldrdRp4fTCwZatoto8mlInpc?=
 =?us-ascii?Q?Y15+gJExdDJ/Y54DYtqwPwbnueK7Eg6zI9KOAcpb+0KzIqHMSmedKELSOla7?=
 =?us-ascii?Q?jwUQ6vZjxAfw2MDEpS7M3xG2TcQs074QcIjTUaUtxKpGuHxRySk0G5MWxR1D?=
 =?us-ascii?Q?cFnfuOBWep/oJNdpIxhw7fiy+CUBXL873h4TB5tjewuQUoLQtM/HDoUthrpi?=
 =?us-ascii?Q?XoVpsfED1LrHQZdkoV+TFv4R9XLExz32z16Bd9TJUIxR6O0ujlhDCEOWroz2?=
 =?us-ascii?Q?qh+SpE4BG0pXELa3Dit+zWycs34tJ5BLDKUsrWwmoM/BezqCc5AcGQDIpjau?=
 =?us-ascii?Q?171Z81L2UUwi5UzkShHh+yDnag2DdAjiaA0+D+6n/ZCei36BR9EWVASR0j4U?=
 =?us-ascii?Q?d0s+/STZqp1EJdjD05Nht4kaKqvgydu2QWLc7ZkXKUB/lln4T6wg0/GPVnob?=
 =?us-ascii?Q?HVKE2uYJF0Ps8US9xtduDbFZxTDo/l1A+Y9KloisNZJngw/r6ljQ69oQ63zf?=
 =?us-ascii?Q?pqVLkuXKMxYTiHO5poD18sGOCYYcJDI6Eu4MSRVcQxnjLFRLDWh56m9SkZVv?=
 =?us-ascii?Q?7YnxXZagmhuoLj6KXTT5ML/COLLUowhQUNxzx54XuBd4DlGFU/UMiTkitI0s?=
 =?us-ascii?Q?XteIXQWVwFVv/9wtQQvEaSg+41VP/5ENfG/PvblSl3APAoVf9KzWQtrCP7+M?=
 =?us-ascii?Q?XuSzCbT2rMtV3KDnNMvMtvNGffhKyr1AdfPysBPTf+2fBoNNKA1XzXoYQP3E?=
 =?us-ascii?Q?Cw4F1x6HHyXHdsrT0MR8khvsZtAonQghSuhZuyqyEs8oDyJc7p651Dt3VNas?=
 =?us-ascii?Q?FV9FAElB8ckx5NEj/h4ycDluXfjmGttrfW9bN2buXyUDgNWJyo6UKQRq64Pn?=
 =?us-ascii?Q?sxef7OBz6tLKk0hm0hZJ4lY4KorZRimWvUebFqjD44NvDyaGwpgsI5wIEDca?=
 =?us-ascii?Q?WCt+DUssb21OEjgE0n9FpL8fvS7mssy3rZmxbXcb/2c9gnCpvZapwIhXf0zV?=
 =?us-ascii?Q?MEWKJ2T9ZCb4/rhu84yyGNe2V5x0nKUXQA1uT5WT7MtepC9FEyUF6IQUOq2b?=
 =?us-ascii?Q?LupDhprwgmY2Foo4HZzQKlFA7JZgyhlo/9bftrq9QcOvF47j1oP3fo2kiNt5?=
 =?us-ascii?Q?llZ89KG51/cZzcj5rcvEwY4mdHH+vBo6tRgRJIUOAQDnHbpmClqQj1YzGtDW?=
 =?us-ascii?Q?/ssKAFXlMNuglwjvuJfd1hFBQKtvcLa/NYAdEHQ+V772Ac3DPL2zUVcgzT0l?=
 =?us-ascii?Q?pmm/NLBgVzGY7MWazbWNWV+ZlEZJkIc755zVy++HIrikb9eAguece4gx4vfu?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eXvGaZXsU6P8RGNnAq+SjTN7Ht4qX2IINgOLXa+slLloCtYEKDcCqOkY5yoB?=
 =?us-ascii?Q?AvUEuvEVZQ3oPg67ldsXZq0Ah9XRhmugFLaMbH1dnhehmRVpWUx8hcA76DYi?=
 =?us-ascii?Q?XoKhTq8rmwRMK9freKzDHIsgDFniDVICKYBYAYiGXVd8uCyJIB0nyWqXlM86?=
 =?us-ascii?Q?QmSjlR8Sz7Gmlqo6FCAdnjMd/qPU5FKNk5IJE+h3XFt245mr8gsjewZK0C2t?=
 =?us-ascii?Q?RjQms4kjafFsnmljuGVzyjR/FITt8XEht6y+mXygFijKFKB83DWz7efPg4/n?=
 =?us-ascii?Q?X8lD5Xvd0jWCvwlCKpiBccj2RBLzxxXgZYde49NVWwKVmIgwEiqxiVAmGbus?=
 =?us-ascii?Q?eznPQuYRvJz5riGaMoWJAj+i6Rs8vLZSe6SIjDhqC35/UG/O3htmvM82vjCM?=
 =?us-ascii?Q?El5yuTJYN5G7uj3N0N19qpRT8RJjLXivaQ+n3rEAUQx9M3HVCFKCw9C6VLuv?=
 =?us-ascii?Q?xXs+JkKkrAwMhv3zS5V0YzNs+DKyrfzAgYaynm+zYYfX5EKsTmmJBktaZ2rW?=
 =?us-ascii?Q?Elrx9l02Q3mVrqItVVN2tv/mdQTCENoN+GKz7X6nrFN9EUSlb1nk6mStxBVw?=
 =?us-ascii?Q?TxSczZ02EK+z+WD2N+Pmx9tG5nIFaTmlrpfynutM9zsriYmuS8Nq76eyUQvk?=
 =?us-ascii?Q?KNZzhZrBBdSBe06GhplFZxtLbtFohXrJA8oXTvFIf/nOiWPVhPYOE45SffuR?=
 =?us-ascii?Q?VdCcth13qgccp52SfX8sSISmryjuN8sKkZ6gU40t+3CPVfj1frVJWWRrIgMV?=
 =?us-ascii?Q?zVQtddV3AG9XuJnF35aNOBT+PdzKFVA7WaI9dc7fnbXvsSqqjng3+KOPNsYJ?=
 =?us-ascii?Q?PbPEaEv7tEiRzA13T8oSlXPZe79TCSP+3jjDyzBC0JQuCfbC4FW3WCB+zB+Y?=
 =?us-ascii?Q?2PuG5lR9jeYTBSB4f5NLW3OIMDciGcpQIZQ8AfYbnf2/uN61vn+Y+3EwyZoy?=
 =?us-ascii?Q?LZftOMOcgtTcm88wgStA+Q1DKvy+L0bSB2E3pftqyNjxTEP71n0PvKLBSy1D?=
 =?us-ascii?Q?X2LM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0a0528-001c-4cd6-4f73-08db8728e5e5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 00:49:52.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMJuAxBUdTfDB1y7JACY4im6hyYsSnJm9J9SCnBJfCl+3NrHOo2Xx8c/GaRYxHLKIB8VXMNfSymnH7KbzQfs7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180006
X-Proofpoint-GUID: -sYHlFC7LOPP7X9cvRVh3iPq52MmGGLK
X-Proofpoint-ORIG-GUID: -sYHlFC7LOPP7X9cvRVh3iPq52MmGGLK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_and_free_pages_bulk is designed to free a list of hugetlb pages
back to their associated lower level allocators.  This may require
allocating vmemmmap pages associated with each hugetlb page.  The
hugetlb page destructor must be changed before pages are freed to lower
level allocators.  However, the destructor must be changed under the
hugetlb lock.  This means there is potentially one lock cycle per page.

Minimize the number of lock cycles in update_and_free_pages_bulk by:
1) allocating necessary vmemmap for all hugetlb pages on the list
2) take hugetlb lock and clear destructor for all pages on the list
3) free all pages on list back to low level allocators

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a910121a647..e6b780291539 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1856,13 +1856,43 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct page *page, *t_page;
-	struct folio *folio;
+	bool clear_dtor = false;
 
+	/*
+	 * First allocate required vmemmmap for all pages on list.  If vmemmap
+	 * can not be allocated, we can not free page to lower level allocator,
+	 * so add back as hugetlb surplus page.
+	 */
 	list_for_each_entry_safe(page, t_page, list, lru) {
-		folio = page_folio(page);
-		update_and_free_hugetlb_folio(h, folio, false);
-		cond_resched();
+		if (HPageVmemmapOptimized(page)) {
+			if (hugetlb_vmemmap_restore(h, page)) {
+				spin_lock_irq(&hugetlb_lock);
+				add_hugetlb_folio(h, page_folio(page), true);
+				spin_unlock_irq(&hugetlb_lock);
+			} else
+				clear_dtor = true;
+			cond_resched();
+		}
+	}
+
+	/*
+	 * If vmemmmap allocation performed above, then take lock to clear
+	 * destructor of all pages on list.
+	 */
+	if (clear_dtor) {
+		spin_lock_irq(&hugetlb_lock);
+		list_for_each_entry(page, list, lru)
+			__clear_hugetlb_destructor(h, page_folio(page));
+		spin_unlock_irq(&hugetlb_lock);
 	}
+
+	/*
+	 * Free pages back to low level allocators.  vmemmap and destructors
+	 * were taken care of above, so update_and_free_hugetlb_folio will
+	 * not need to take hugetlb lock.
+	 */
+	list_for_each_entry_safe(page, t_page, list, lru)
+		update_and_free_hugetlb_folio(h, page_folio(page), false);
 }
 
 struct hstate *size_to_hstate(unsigned long size)
-- 
2.41.0

