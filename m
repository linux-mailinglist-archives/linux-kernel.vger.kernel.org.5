Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C0E7AE2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjIYXtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjIYXti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:49:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C16FB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:49:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PNDtbL021928;
        Mon, 25 Sep 2023 23:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=/NHM7VaeEfDia6EH7j8Eb5iVUqEnbrMv6N5cLhl9+Pw=;
 b=xAPfYYE00r4rCaYekqqAULdNWuCuncbrI00jFywUSOr7Y1fdTpO2WvbIDx6S6HjLi8fx
 KpRiQGSSqieVH5K6aE87x6cRKOEfUm0pBTIvAXWOS29fOiB5e5avOMhKt4pGzeZJIxBZ
 4D1CzCQl7rgjY2Ow/ON4LwYltLq0y4b9F0t2+B5dgyI39JGyTiM/npDDXc6Alr1Ml8QS
 V1yZnCBD0erL3CRd3Vf8VVaav6MX10kyPUDatlwqcUU6tH7gftTRaAO7SlvMa5oR3PZ2
 xxyMeV0DIrBzDXK0l/FIeUBLcmrpQugYCikWb5YhtDPCNAYzRUfWj97eJ72+bMxEkc4t rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmud5pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:48:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PN0WIq039366;
        Mon, 25 Sep 2023 23:48:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbbda5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:48:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSJ1ZOK5202HkesphdzaDSMBa1YutXu+Rk/xGQV7tua4cpn3w+3WPWeD9K4hXa5UOBdh7kCIwnI5RPYKyeKJJuPmPaDR/wHjAi0FbufPYnTgwv4G9UhGl0OcfHZG81ZC8nOq9KRfVDkwMfWGkkdPkhLlt9h9C+odKS7H4K6TR6x9cZ7kx66aydnAM+/STDtpJtNSBJXD2VWItRTNyyfA460NJYjStcbChLgryqXB99hUftGFZSWEx3xAhLNgp2Cfyg2X2/zbEcuYb5bh82QmesA5m0cGWElNJI9c78VOUmSc3BQ48g4CRgwuOMl+h2borWRpv59BW2CE3j/AcZ8n/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NHM7VaeEfDia6EH7j8Eb5iVUqEnbrMv6N5cLhl9+Pw=;
 b=asJet6LOSePIDIOUgN8i030unH140m3C1PGB6W6hWX4aQHL5aXohfdVVp+1AI/FYYRraNdvuBKOEoK6+XRFBShZKN3667ae/fWtOX2fcESNePK9B2y+ajrtAeEDTUm471mjV8U7jZJzAxNrwDuKGZKCyoKQbkIoqp8u2hc8KRyvur/EKf6UBNSjSr4PZPUOAh1ItDQqUw7eMiZTIVUqw13uaSlt51p7XfxeBLLQQoq3ruTTxtEX8KiTErq01Ra5Jln10dHlfFVhDLhbU4Hgdn97jrqbfQP2Nnriq2nPm65tiKv09gt2HVDQFmGzZxO4TMBr4yinH/tcpwCR5CbcPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NHM7VaeEfDia6EH7j8Eb5iVUqEnbrMv6N5cLhl9+Pw=;
 b=VLbGU6nWnov2i7knhLNQpKtLdOTC0wwza5UdQUbu7cpgNoXx/RvMv0rH7kizyf7ZkkORP1F3CPyo8gWd7G6Wdj6ZJ4KJqGb3o6V0NPDseIXXtLswKtBFtFbwWuAaNB2rhBpPgqfzL/wblkX9a7qFBqlsAyfsVjRo50RLEOz/sVM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN4PR10MB5653.namprd10.prod.outlook.com (2603:10b6:806:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Mon, 25 Sep
 2023 23:48:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 23:48:50 +0000
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
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v6 2/8] hugetlb: restructure pool allocations
Date:   Mon, 25 Sep 2023 16:48:30 -0700
Message-ID: <20230925234837.86786-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925234837.86786-1-mike.kravetz@oracle.com>
References: <20230925234837.86786-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:303:8d::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN4PR10MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 42372051-d28d-4f04-e0a5-08dbbe21f78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4BHOX2j42xs9dyNUUfN0Bcyvhmo0HIWCHWB/WNMSVag7NcFTFk++/ClKGhFapOq83liKTe0Qym81Oyp/mIr/zZq7b7FHxVAIfPu6r12jTVvgk4Fw9+3b2xNy1nGyT2O2NxTVPmtPyysJDYGO3EVHMkFb67DqDDUCHspSjpp5TA+BGRZxT0bikwUtmn7rzMWRTb8JgLn1DkMWZweryOoc2o6IDuXBR23uzaD0IBSKpkwblDLW7A1+DNuE933MMSxVO8e+LOpjjqbdQ79dyKjNoILTOqXVtUzyIUpcJcC10uO12X6jSvvDAW6pv/QQirjrgkUw46NrlgqKQylp+vtiI7J5WWrFg+HcXQENme4gj+F5hG28FP8bIhUlCVDXCUHKxGO8lZ0182DbvnF71PuNPoqTIGDlOIt9nvcKN8pOt8KFmv454uLtqoyubE42/F/DuOl4d0Xx4D309zpOoQCB0LoYE5J2pCsCrj8v8yY2gA6fSC8ah+vcCqyRk28hHOc0LFWPdDoqmpPfQYtY5aHKr8hD0VURPOPnwZ59BiLSxQ0QZVxlGqEsV4EYXJGNsU+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(86362001)(2616005)(2906002)(30864003)(7416002)(36756003)(26005)(107886003)(44832011)(1076003)(5660300002)(83380400001)(4326008)(6512007)(6486002)(6506007)(8936002)(6666004)(8676002)(478600001)(38100700002)(41300700001)(316002)(54906003)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NN7MG4Du/x5LGF3hnAYTLETFlUaoEU8yZxQiaS1vGIATZ+Wnt667jpu0r5WJ?=
 =?us-ascii?Q?DbbUNHpjLwjdlLmYQyI+dHgJ1R5neidzbHYZFicRr5G/pQUVDsyDEOSwgJZv?=
 =?us-ascii?Q?uqVWwWEYbru87RT8G9zQ+X7yPbbv7jeLMbWxHuSKeH1Vf49hvk51fxZ+5Jom?=
 =?us-ascii?Q?WBiyaaQxdWUHp73DuLaZF4AFJ4+KB2kBKGPHjTwRYy0u4s9CSAac37Ib2vsq?=
 =?us-ascii?Q?oJah/Vos72E0T/O3fXvqNdyeD0mg3G2hwa/1QwI/T/Wfzuro9MBvArGC4C1Q?=
 =?us-ascii?Q?TAF+jPCudzkLzvOUJUYMl+zP3n0KD/BRCnQp/Uc1e9634PMMZdN/7kxaY8fn?=
 =?us-ascii?Q?hizW8LipK+Zx3a+cJxxjvn18vF6BIsT0+hPEAeHiEQhmo6Z+mcAkx1320u2m?=
 =?us-ascii?Q?sHGyM6U1kijFDTkc4XnVdcvOL9FNBHD5AU3oehix2duRlZ2pMpbTw78+smjJ?=
 =?us-ascii?Q?1Suq0wJNg2KeEbOyRnnXnZ2RHDdQ9lKTh3NNdZoHmYdAvTY0QdKJI2H6/KnM?=
 =?us-ascii?Q?bjUDnhQigJryZ2xRDxHKCasAK2IJ6aXLxgTdl2uHUjlUFMfKe3MfKahIAC5S?=
 =?us-ascii?Q?KeTs/VEt1OalzAxKsUPEpHffccoiq++29wBVbxN9xelwKhO30hhoCYtI8j/N?=
 =?us-ascii?Q?0r3K4ixHFgi7QoLckGvFyqYpE2LI+WoWvELSVfHrisQm8Q7UwdkSWGBCnVGl?=
 =?us-ascii?Q?kGf4KtJm5AaZcH26FMjkHkD582r5vSsT2TLXAnQcGU50ZHL7miVLL4chyYlS?=
 =?us-ascii?Q?UtX/Emk5JORnbLBJMpFRsGlnkKcLinleNEj1ArowgFyQZxyhdzNGiArkEzG8?=
 =?us-ascii?Q?SothzJgcJhUnsVdxQRhzX0KV61f8qCO97ddTeheqCwdIqNBOzx8uQJwpbh6W?=
 =?us-ascii?Q?jcq6a3c1QCcBdwCgrUVNfCi3ZNK3o2058XEfM25TGynTCmseJdrynyJmrwsf?=
 =?us-ascii?Q?DAtYhySBufcBZ8nDesYp6cCO0U8PSD8IgTmwtcSFU4EuywMx8IFyaK/H/OsW?=
 =?us-ascii?Q?wwQpCxUuO5Xn8NKXUservdoHkJAen5WtAytzjAdCTKLRhhjqqvBMfX1owWe9?=
 =?us-ascii?Q?qeACXn6OmmKQOufvpoh4YYPGfwHDryKMpQtdqijNfUmRRdoXkcqnaKb2TyC8?=
 =?us-ascii?Q?eTCjTGgS7xPp5Q7Px4Q/q9URUKzHTIaeehn/rhvbtFUG5xo+Ght5ljsePLMe?=
 =?us-ascii?Q?K1FTRiNojyQ35QvmO8YaYwnjMl+GWpYl2Lv/7Id6abwc78LxBXN7FsqKwWg7?=
 =?us-ascii?Q?pYfbA7pPZaEoAfzGWLm6YGXQYRNwPsOTNIqC8ioipVcX1djLApxcJLveHHXS?=
 =?us-ascii?Q?bXK1FEs++9WPoUPfAemRQ8k6O7C56X/M+rHyr+i4OKbiTVojjie80D5AvByM?=
 =?us-ascii?Q?yPFfmBi7O53mEEwA9tdeSuhoZNRfSB4isaQjucZBEjgrXAvkq4nHz1ICSFeV?=
 =?us-ascii?Q?fhQbfMdLyeiGTYmPcgBJ8DM76bTbBJ2caerilglSVumBgfBWNJ9JLomy2xPt?=
 =?us-ascii?Q?7KLqw/cPQCHL9tQ5EqfnMWdH9IrA2L7Ib9336wyXuVLSbkjFF8KbLzmS2KTH?=
 =?us-ascii?Q?eNjHPZLCJVM7pEIybur9cK5qlQawx06mqPpU/FsKGyCvX+T2r6SRnmBPyt8E?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?J4zBtftiUWee2MpjCGDIDSWtp0ryXYinkIOXDS1h/tRkHir8cN7E5mlnREAG?=
 =?us-ascii?Q?ypoZN7pNEsgzSzvNx0tAdJlNLtSnvHQtsHsSKoaESis06clOUmcCg/ZrJqGr?=
 =?us-ascii?Q?u4+ozhxvByOTZjEUJcUhwYDmzaGOGctP4BhfGN5Tb+jh+IHC4uuZnWPTEV6N?=
 =?us-ascii?Q?vVQBbw3Vw2sUQKECFK1SIg2jVP8kwacbQOYp5clBdfhX3z4q5dIfPCBxreiH?=
 =?us-ascii?Q?l+H7F33lv6z4GuEbcubS5emKwUm2FR9ldT+wWDbTdLapm/cPX8fR0JlyQRe9?=
 =?us-ascii?Q?apEt9dOjnttanm86YcZTbrijX5gNkJ38QqJM/jplvdQ0y7nEndMl2VzAAx6Q?=
 =?us-ascii?Q?DfIbVw2fQCSQegxELf4n6e6FJDmtd7QdAPN7QoAl6yJPme6XXRwCoMOqCFpD?=
 =?us-ascii?Q?IChwfcIPkJ98ztUAmjkRt1aKEybxgWoP+bzFoS1/TIO1fNIdRmHcxkZGeoV0?=
 =?us-ascii?Q?49Nkk5mtxJKl1ZLJwBe4hqvtuUm5ouNepZkjIIElQPWHqRcHP1LhOWTZH/kF?=
 =?us-ascii?Q?hje7JG8W1hNk5owkOqWSunYLczbN5bHf2+5xVSMWdHr6aaiXwOM2pv9o5vnH?=
 =?us-ascii?Q?Q+2xUJ6IKSzyf8O6/6UkRzhp0QcTJ21KllrBNJ+6aGhRjVGOQRcHnXAGod8O?=
 =?us-ascii?Q?sWw1Cw9OBUW/6gDJT/zbzNXf7OMtI+FL/fJk2j0yOlyPgZ6HSyPZ9N87gf7m?=
 =?us-ascii?Q?7Q0lKI8CfoW+gS+nRJX0+Ed86ei78DeRP8llmobCSYAI9hJsCZK9d8W6rW6U?=
 =?us-ascii?Q?Q+894c8zvJJ3Z3mryQOb/XHl5nMg02CWAOJ5vZqqCZxVvdtiRZoRm4Vg1vC9?=
 =?us-ascii?Q?V4jyVw85FSaRoXmhUFKbo8nmUXdlij1zR4fAbKL/+6ERP3qEuy5DvVijQUj3?=
 =?us-ascii?Q?r7K0W8nLPg93P4lSDPhFfuwgoOp5gJBdain88ERzD01zinrXoZs1p/sielUQ?=
 =?us-ascii?Q?6V/Ps3iRAyqRiXbdRI7k2Kjui4ZcxWKjL66X5ZrDowmisuqeVUN26IndgWnI?=
 =?us-ascii?Q?nS5GKq55/CJrZdY2Q6d54fNn/Cg39IkpFVidgSfpGav0LcJOg6JUTUp9JPcO?=
 =?us-ascii?Q?M2J9ILGMCKoBTx5mfmcQOmNSkyaXb5zy6LlX48G0pvGwv63X9jskm3/nJ1yM?=
 =?us-ascii?Q?w+NwIkbUI1ru?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42372051-d28d-4f04-e0a5-08dbbe21f78a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:48:50.0379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/8KoQzpAwDS/iCKc8FhinE0n5OGXy6bxIfADs1CqGopF/FCGD+uS8/eniCMX+QDa4CY5dEJHw2rPBXx6YTabA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250185
X-Proofpoint-GUID: EU_Vg7tC1sN9L_Gf4iYJuU3zZEyHGk9h
X-Proofpoint-ORIG-GUID: EU_Vg7tC1sN9L_Gf4iYJuU3zZEyHGk9h
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation of a hugetlb page for the hugetlb pool is done by the routine
alloc_pool_huge_page.  This routine will allocate contiguous pages from
a low level allocator, prep the pages for usage as a hugetlb page and
then add the resulting hugetlb page to the pool.

In the 'prep' stage, optional vmemmap optimization is done.  For
performance reasons we want to perform vmemmap optimization on multiple
hugetlb pages at once.  To do this, restructure the hugetlb pool
allocation code such that vmemmap optimization can be isolated and later
batched.

The code to allocate hugetlb pages from bootmem was also modified to
allow batching.

No functional changes, only code restructure.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 179 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 140 insertions(+), 39 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 47159b9de633..64f50f3844fc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1970,16 +1970,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 	h->nr_huge_pages_node[nid]++;
 }
 
-static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+static void init_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	folio_set_hugetlb(folio);
-	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
 }
 
+static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+{
+	init_new_hugetlb_folio(h, folio);
+	hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int nid)
 {
 	__prep_new_hugetlb_folio(h, folio);
@@ -2190,16 +2195,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 	return page_folio(page);
 }
 
-/*
- * Common helper to allocate a fresh hugetlb page. All specific allocators
- * should use this function to get new hugetlb pages
- *
- * Note that returned page is 'frozen':  ref count of head page and all tail
- * pages is zero.
- */
-static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask,
-		nodemask_t *node_alloc_noretry)
+static struct folio *__alloc_fresh_hugetlb_folio(struct hstate *h,
+				gfp_t gfp_mask, int nid, nodemask_t *nmask,
+				nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
 	bool retry = false;
@@ -2212,6 +2210,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 				nid, nmask, node_alloc_noretry);
 	if (!folio)
 		return NULL;
+
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
@@ -2226,32 +2225,80 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 			return NULL;
 		}
 	}
-	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
 	return folio;
 }
 
+static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
+{
+	struct folio *folio;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (folio)
+		init_new_hugetlb_folio(h, folio);
+	return folio;
+}
+
 /*
- * Allocates a fresh page to the hugetlb allocator pool in the node interleaved
- * manner.
+ * Common helper to allocate a fresh hugetlb page. All specific allocators
+ * should use this function to get new hugetlb pages
+ *
+ * Note that returned page is 'frozen':  ref count of head page and all tail
+ * pages is zero.
  */
-static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
-				nodemask_t *node_alloc_noretry)
+static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
-	int nr_nodes, node;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (!folio)
+		return NULL;
+
+	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+	return folio;
+}
+
+static void prep_and_add_allocated_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	struct folio *folio, *tmp_f;
+
+	/* Add all new pool pages to free lists in one lock cycle */
+	spin_lock_irq(&hugetlb_lock);
+	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+	}
+	spin_unlock_irq(&hugetlb_lock);
+}
+
+/*
+ * Allocates a fresh hugetlb page in a node interleaved manner.  The page
+ * will later be added to the appropriate hugetlb pool.
+ */
+static struct folio *alloc_pool_huge_folio(struct hstate *h,
+					nodemask_t *nodes_allowed,
+					nodemask_t *node_alloc_noretry)
+{
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	int nr_nodes, node;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
-		folio = alloc_fresh_hugetlb_folio(h, gfp_mask, node,
+		struct folio *folio;
+
+		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
 					nodes_allowed, node_alloc_noretry);
-		if (folio) {
-			free_huge_folio(folio); /* free it into the hugepage allocator */
-			return 1;
-		}
+		if (folio)
+			return folio;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /*
@@ -3264,25 +3311,35 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
  */
 static void __init gather_bootmem_prealloc(void)
 {
+	LIST_HEAD(folio_list);
 	struct huge_bootmem_page *m;
+	struct hstate *h, *prev_h = NULL;
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = (void *)page;
-		struct hstate *h = m->hstate;
+
+		h = m->hstate;
+		/*
+		 * It is possible to have multiple huge page sizes (hstates)
+		 * in this list.  If so, process each size separately.
+		 */
+		if (h != prev_h && prev_h != NULL)
+			prep_and_add_allocated_folios(prev_h, &folio_list);
+		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
 
 		hugetlb_folio_init_vmemmap(folio, h,
 					   HUGETLB_VMEMMAP_RESERVE_PAGES);
-		prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+		__prep_new_hugetlb_folio(h, folio);
 		/* If HVO fails, initialize all tail struct pages */
 		if (!HPageVmemmapOptimized(&folio->page))
 			hugetlb_folio_init_tail_vmemmap(folio,
 						HUGETLB_VMEMMAP_RESERVE_PAGES,
 						pages_per_huge_page(h));
-		free_huge_folio(folio); /* add to the hugepage allocator */
+		list_add(&folio->lru, &folio_list);
 
 		/*
 		 * We need to restore the 'stolen' pages to totalram_pages
@@ -3292,6 +3349,8 @@ static void __init gather_bootmem_prealloc(void)
 		adjust_managed_page_count(page, pages_per_huge_page(h));
 		cond_resched();
 	}
+
+	prep_and_add_allocated_folios(h, &folio_list);
 }
 
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
@@ -3325,9 +3384,22 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 	h->max_huge_pages_node[nid] = i;
 }
 
+/*
+ * NOTE: this routine is called in different contexts for gigantic and
+ * non-gigantic pages.
+ * - For gigantic pages, this is called early in the boot process and
+ *   pages are allocated from memblock allocated or something similar.
+ *   Gigantic pages are actually added to pools later with the routine
+ *   gather_bootmem_prealloc.
+ * - For non-gigantic pages, this is called later in the boot process after
+ *   all of mm is up and functional.  Pages are allocated from buddy and
+ *   then added to hugetlb pools.
+ */
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
+	struct folio *folio;
+	LIST_HEAD(folio_list);
 	nodemask_t *node_alloc_noretry;
 	bool node_specific_alloc = false;
 
@@ -3369,14 +3441,25 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
+			/*
+			 * gigantic pages not added to list as they are not
+			 * added to pools now.
+			 */
 			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
 				break;
-		} else if (!alloc_pool_huge_page(h,
-					 &node_states[N_MEMORY],
-					 node_alloc_noretry))
-			break;
+		} else {
+			folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+							node_alloc_noretry);
+			if (!folio)
+				break;
+			list_add(&folio->lru, &folio_list);
+		}
 		cond_resched();
 	}
+
+	/* list will be empty if hstate_is_gigantic */
+	prep_and_add_allocated_folios(h, &folio_list);
+
 	if (i < h->max_huge_pages) {
 		char buf[32];
 
@@ -3510,7 +3593,9 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
-	unsigned long min_count, ret;
+	unsigned long min_count;
+	unsigned long allocated;
+	struct folio *folio;
 	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
@@ -3587,7 +3672,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			break;
 	}
 
-	while (count > persistent_huge_pages(h)) {
+	allocated = 0;
+	while (count > (persistent_huge_pages(h) + allocated)) {
 		/*
 		 * If this allocation races such that we no longer need the
 		 * page, free_huge_folio will handle it by freeing the page
@@ -3598,15 +3684,32 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
-		ret = alloc_pool_huge_page(h, nodes_allowed,
+		folio = alloc_pool_huge_folio(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock_irq(&hugetlb_lock);
-		if (!ret)
+		if (!folio) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		list_add(&folio->lru, &page_list);
+		allocated++;
 
 		/* Bail for signals. Probably ctrl-c from user */
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		spin_lock_irq(&hugetlb_lock);
+	}
+
+	/* Add allocated pages to the pool */
+	if (!list_empty(&page_list)) {
+		spin_unlock_irq(&hugetlb_lock);
+		prep_and_add_allocated_folios(h, &page_list);
+		spin_lock_irq(&hugetlb_lock);
 	}
 
 	/*
@@ -3632,8 +3735,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * Collect pages to be removed on list without dropping lock
 	 */
 	while (min_count < persistent_huge_pages(h)) {
-		struct folio *folio;
-
 		folio = remove_pool_hugetlb_folio(h, nodes_allowed, 0);
 		if (!folio)
 			break;
-- 
2.41.0

