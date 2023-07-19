Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E7C759D54
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGSScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGSScF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:32:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CB1B6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:32:04 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOLHX029562;
        Wed, 19 Jul 2023 18:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2023-03-30; bh=dRsWouBYPnZ51/qlUn5PDmbA6cDcesrEungkp8ty3SQ=;
 b=XaDRg+T0DFYC/vgsiloYlfI/74ajfx3CtFK/SkqOjBv4unQQMI9HnMkIRe0YcQbtX3w6
 sm0aYbs8Hfk9hXd2o8An6Y+7F7fD1zfgyIKQYGAoS6p1CblZ58dcn1kSsp21Wbo/oz6k
 rsINg4uaWtedw8Pn8S4T8TbaZHfXWN93M3JSjY4whtc748xjtRgKQv00VXs1pQ7723Y1
 RFi1TCLKMse34pE8d5CN5LCudnGsxCsgMtf3TQKZBSV4kJS35sFGF3TEwZq0htYn3gKF
 SheTy0/CctkWYNr3FK94+a7XrWL7krmV2z5EImfTtup+0La7VC/Bim+1FAQF102Rvbwe bQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88r7nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 18:31:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JHKWGi000801;
        Wed, 19 Jul 2023 18:31:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw79t6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 18:31:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMStBH191EnIfYfmZLt3AOrv19sk2IElFUnwKdwwO3nmo0OnZe3TWtkRkNecFl/TdYUZsK1RF4nrCGum9hK5qWZDLxs7fs1ri/LHWhsEoz4WqmwH55SHtclHqJ+xLa/mfSQG6jOReiM+LU3lLg6KXlZ6AE+hVhMByo8zjldxtotj0LQJnDFeYUkVn8qOWAWCry3kAjGT0oXB9Pn9LN6VNkK8VKRxGaG49VvuFzAcEVHd16w0n9tdojtp2z6tqnqgakLgyIdbRfnjq0MEBE3RjcUONQVy89/x/aCndO7pGM3rLcyf+77VYZRVg6TWtDeaB9Q36GUOJXG8mKRoK5nDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRsWouBYPnZ51/qlUn5PDmbA6cDcesrEungkp8ty3SQ=;
 b=PYJfK8VGOgKVMZy92KB4ndOJUjfMSSScu1z+aXahu9lxRdfyPElMCS1RqjDe/XHmH50wb/t+YIjekqtydOxfEmO/pjI8dmEl3BMZGgQnnu/LEuwnqkRR4/iDM57qnPE4rnwgzaOlNRHqoo5YuFulvKi/nkMtTP+dcWzpLRhzcSKn02sJYvgaQnjYsjsUS1XLruY757FGumIuxCsnFoR09lBt9VS1bCr6kllYMjtswMwqnSY74H8fyJsSCrAZbx9u9moxWxDBuBEh8UWRXtyomuNOw8vFVNlT4zN3AUyXOyopbhm1j2B6nPVUCoP+MrxMPcuMgfdt0ySVwPe2cxyfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRsWouBYPnZ51/qlUn5PDmbA6cDcesrEungkp8ty3SQ=;
 b=qi7VJ+waO9Itw1ks1elRI+5v2tRRV/0yCrI+nxCwnQ2+iBzRcg/0nMCQxDr+Brqk1UciW3QxygussD/X0jxB/O9uklxqtGHDc2AgL1Yr8yxV7KJnvJSydHbRoxGCrp2ret+PIbIn/KXF3x8QF9OzF6fINLNm09ADQs88nd0H+t4=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by SA1PR10MB7681.namprd10.prod.outlook.com (2603:10b6:806:375::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 18:31:44 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::567b:a4ec:2f3:619f]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::567b:a4ec:2f3:619f%2]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 18:31:44 +0000
Date:   Wed, 19 Jul 2023 14:31:42 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 3/4] mm/mmap: Change detached vma locking scheme
Message-ID: <20230719183142.ktgcmuj2pnlr3h3s@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: multipart/mixed; boundary="q3otxkya3yodrrcj"
Content-Disposition: inline
In-Reply-To: <20230714195551.894800-4-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::27) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|SA1PR10MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: a49aef30-1073-46a2-1a49-08db8886670d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJNv0cGke0mgPWAPfbFDDvN5dUEbFxc8GDEP5PW4NL+V+0FhEDq3us6RkRvMbP7VgRtrBeRL0KFQ3O1cER4tfMXhSRHywmHovxos8CkfcgC9fPqWKaXdwf9MHP9Zu7PKWySxWvz6fLUbWxFcJrwi3c9acsfvTiJyb6fReymtweVHtFFVrOvZnmBCQKMu/mCiZtVCVyP8QatMgiWfu7bEvp3HIAa5dZuuRseyW4k6Mo8w407KhRvaxBm4nIEQNpcbMw5o9plFBq4H87058HzK1HXkUu7OOUdMnhueUeGvfLM/AEpy5Zu8Bnd2sEOJhZOOtR6vvXT1FphN+lg3R62dblgIAeLrtyyCF2+zJkww06XgDQTACk9biMZ29I6AEKkmwtmlbcdy2c9LP3c6thiALQRneF1oNt/OxQFwu4oExt6+O98kpCH5I/YiYsKDR7u63XDBsyVSzQ/FK3aOykxFbIG06XR2Fob7ulB/yWdOwysKgipIsvWgupFURrnIw3yw6wA6zBYA5m74uWKfNbPKrboVfxJfrHpb/bcdTIHnRGPR8TsHqrWsC+uLhMr+V7T0lgvVd12umVxbG6OPX+3N7m+h5S7RLiZs4YADU5TA21E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(83380400001)(2906002)(38100700002)(66556008)(66946007)(66476007)(316002)(4326008)(6916009)(41300700001)(33716001)(6506007)(186003)(26005)(1076003)(478600001)(6486002)(966005)(9686003)(6512007)(44144004)(54906003)(235185007)(5660300002)(8676002)(8936002)(86362001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IHiQ5mSqKa3OzKIuiTaOiEjEzJ3ndqeOgksn4Zo+tFVnEz8MFGPq143FABoq?=
 =?us-ascii?Q?QRAlZaGqkSbq/2L8BFC1nKGt7qai2t3QN7cJ11kk6PfoyPacYR36gevVX5+3?=
 =?us-ascii?Q?6UUl5QGYIvJn4lbinweMRC7Exl01MDtZ0qy1zozRcV5IDdJa+jo634HdQMQp?=
 =?us-ascii?Q?o6FGUulGAJSbk1pPMyFkWqaiJ0nV5s92vCS8N9N5JsUiY0f6hh/J5JpajhS8?=
 =?us-ascii?Q?rzollkjbyi95jmw1gMSKYZDt58Y4ufU00UQ3qIRybL+g7XdkwqE/6JRKV/TX?=
 =?us-ascii?Q?wjUSrRPBp3N3pqVN1omTXzmN5PRt3l8aSUwA0aUTqAQjJmT+BMnKL8ciEsve?=
 =?us-ascii?Q?KVYDCXHTUisNKp5bMerQfL+f97xGiBu3Ag3BBlgNAJkfBWioi/Py1I0YI61f?=
 =?us-ascii?Q?YVnxEuYdT5Wx1KS9FDlhzVE8sAmukbrjCr1wvbfccMjRov0dcje4OLAom8+6?=
 =?us-ascii?Q?NmMuDSHxnbpikbjjamiZMiq6iVA1Xa1SJI1j0AisfQLbujHM0utbtVptTv2b?=
 =?us-ascii?Q?Y0bTqaHFNlQjL9LXsCi2vXntFaQShZZLI4IbcCBFVqwb5dSX4sfxY0ni0h7/?=
 =?us-ascii?Q?7N4Dl8dqcxrpXPQ5xZdqeIWTsxYXrNF5OCAAOKNPHrE5Bw8TvoqGWyz25qRh?=
 =?us-ascii?Q?mIhaNjaLMp8tJiuZ/5JAJ1BhoaNAlKZA0CGjlSz1LjC09BWxz8WaNdDhdfHB?=
 =?us-ascii?Q?l8PLIxBzIOqyb4BweErAZPlrbtl//6JoCXhQVHuhmkm3eUwQacZ4eMt7qYOG?=
 =?us-ascii?Q?jT9Bp+iW6gdWzDtzAeEfpyjo+CL7bni810lmEXtX2Ayaa7B25R2rSjNhEKMD?=
 =?us-ascii?Q?IH5shof3c+DJZVvOD8W3IUOMTDFVxvBaMu6xY9uHUNyz1lTo4273tyYAk9B0?=
 =?us-ascii?Q?20pC3ht733xdyGn/o9IxgksMsd4hfvgbdhU2PT48+WdztUppDSEdKXbUrxk9?=
 =?us-ascii?Q?YJgsffttZ3NMJvx3CIzsV10wWfJhQ+2SystOFxtjbkMesxGPNQeD/NRdQIkV?=
 =?us-ascii?Q?Ld8VmrsSAbx9G+Mm5usA2L6XbU4LBNa5Hk6+2PZcQyo+umPs60hjGtEB/LMP?=
 =?us-ascii?Q?beEpzm4sVroT+WFkjr724fDLSa3iP7/qOVGIjuYYhFeWZ7cnFIZUGWZ/TNaR?=
 =?us-ascii?Q?WeXDGYulqoKQ42TggwGYkyXPHX46aGuG/22xEjs3IWUYiCljqANCewtr7R+N?=
 =?us-ascii?Q?dK279mNOfNyAXVlzN0OMuI3XW+f4qMeerUKZdJs5sdM4Nb9y8HXlKM3QKlC9?=
 =?us-ascii?Q?5XFYGcd9ux7wi04h3kT15N0Z93ViUmIR+uPnJyaqclhUxViAy54nQ4d4jM8y?=
 =?us-ascii?Q?fiIls2xq/ovugyVDtYpUGRLLfMrdIpeoe1v66QAsshy5gr8PYEb5nG2iexHe?=
 =?us-ascii?Q?93Xt0nd2GG31g85sJdbAg6EYFLJIuEcra9vrhm15yRViLuEKzvCgoGx+DPEm?=
 =?us-ascii?Q?NHnyjgor5Zq0kIOOj6ENIRD8tTNjVkLBIoJlCD9OspigUz0naUn0ZRKec/+S?=
 =?us-ascii?Q?e9aKOZyqkkBsuoskeIBeigmMrbqgoPYelsPTrA7UEshQzNjMRoN8kTYZghaX?=
 =?us-ascii?Q?REvzt4GLHYyTttHvUnDMMKnS1GzQiRPfHwVs2R1swuVUCuwo625yYa/hC+GT?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IOvad1cN6QMSdlqv9H2hAqFs64kgrXZDcMCUzhooHdzr1MqENmkxVZDaz1tV?=
 =?us-ascii?Q?pqh8fU/IttEMK6Bolc4pneJjLCSCOTR12hoNpa4wCLLFJMeFMBqWKDPjhe6z?=
 =?us-ascii?Q?vjyaC9XWsp8vYOp3JGLkxAo6gP6/1MzKgCDaVB1/dg7PHY6RO8raCJ2WZ4FR?=
 =?us-ascii?Q?JO4OBdKSwje2JFY3y2T4pH7tLFaNytF+xiNBJAN2JidaIVGPTi0Nm7v26a/a?=
 =?us-ascii?Q?jXAAP5uA8lK4YR/sl+q2wppOlNFKuS9uvEs4J+6varNLdRROjiW340gPuw09?=
 =?us-ascii?Q?S7TEuCt7jbkNdW7axUDd4M7e68NKDUX+XaXL54LMD6IrsX2RfWEKEycE94Ur?=
 =?us-ascii?Q?ynSQSMv5rKN+vfW6a6kQcYl6/zoYRknSQsH5ab6Z7ddWdlOdBOYbDU5K70q/?=
 =?us-ascii?Q?r3ZS7oC8Fl3gL7w4biJZKI8Jhvay+Y+SDgGbp0TAu9XWzETIC5fEmfzI4Lcc?=
 =?us-ascii?Q?YJFqxbAntPTZ+/A7KrVUILETeqCZTuFyUB6sNQTk6UAVq1KubFhMvf27fETw?=
 =?us-ascii?Q?isK+J88ospZE+Se9n++HJ9kScqTiUqBaj4iNMrgnn+sM33bPaZJe5h0Ssbky?=
 =?us-ascii?Q?SSkeL4eiP27S6AN9hxsGTzR+oHUZTctvsdM8UXEUbsrQ1vh+DfA6flpUwg2v?=
 =?us-ascii?Q?durO/qYkgONzJZamHnC6RBLNNE4a1BFERfKKtLqW9P65GlT8BB9mijHg8z9v?=
 =?us-ascii?Q?Q97XKs+VnBxtc9OLauNkmXISrmT3p6VGJyK3Nq8V7hovXRU7uiSov0OzUUw+?=
 =?us-ascii?Q?Fg0QYiDeSYTQXDPCdvOrHKVPIQIW+OmTvpUFRaBeJBCTGh3esIGhx9BG63wO?=
 =?us-ascii?Q?0IRnMQXn8zdf10deG7PRmjYpnMicghQkrOja5eYWTLevm9sJG5medapZgtL8?=
 =?us-ascii?Q?WYUHrpCIX88NZTAa2CRKIcr3I2mMYe7MKCqdwBhom8kR6WiEruZXLFW7RmX4?=
 =?us-ascii?Q?i9QVPX6g8cRLhmTV0gQ1ag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49aef30-1073-46a2-1a49-08db8886670d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:31:44.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gp3mDRTvkSYNcUnkN/YznuqohfvrIiGr9pLcCmDK25eLU4VcySd4tMErhGbbFzaPlWUqkZvVNJe3H84VOqcaRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_13,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=964
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190167
X-Proofpoint-GUID: iOLWMWzyCRnPdPAEDp9KylFqW4xicUxw
X-Proofpoint-ORIG-GUID: iOLWMWzyCRnPdPAEDp9KylFqW4xicUxw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--q3otxkya3yodrrcj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Andrew,

Please replace v2 with the attached v3 of this patch to address the
issue with building ARCH=um [1].

[1] https://lore.kernel.org/linux-mm/20230718172105.GA1714004@dev-arch.thelio-3990X/T/

Thanks,
Liam


* Liam R. Howlett <Liam.Howlett@oracle.com> [230714 15:56]:
> Don't set the lock to the mm lock so that the detached VMA tree does not
> complain about being unlocked when the mmap_lock is dropped prior to
> freeing the tree.
> 
> Move the destroying of the detached tree outside the mmap lock all
> together.
> 
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7b70379a8b3e..ab6cb00d377a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2427,7 +2427,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	unsigned long locked_vm = 0;
>  	MA_STATE(mas_detach, &mt_detach, 0, 0);
>  	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> -	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
> +	mt_detach.ma_external_lock = NULL;
>  
>  	/*
>  	 * If we need to split any vma, do it now to save pain later.
> @@ -2545,11 +2545,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	/* Statistics and freeing VMAs */
>  	mas_set(&mas_detach, start);
>  	remove_mt(mm, &mas_detach);
> -	__mt_destroy(&mt_detach);
>  	validate_mm(mm);
>  	if (unlock)
>  		mmap_read_unlock(mm);
>  
> +	__mt_destroy(&mt_detach);
>  	return 0;
>  
>  clear_tree_failed:
> -- 
> 2.39.2
> 

--q3otxkya3yodrrcj
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="v3-0003-mm-mmap-Change-detached-vma-locking-scheme.patch"
Content-Transfer-Encoding: quoted-printable

From 099a01955898a852aba26bda8fe85af055e4caf7 Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Wed, 5 Jul 2023 14:47:49 -0400
Subject: [PATCH v3 3/4] mm/mmap: Change detached vma locking scheme

Don't set the lock to the mm lock so that the detached VMA tree does not
complain about being unlocked when the mmap_lock is dropped prior to
freeing the tree.

Introduce mt_on_stack() for setting the external lock to NULL only when
LOCKDEP is used.

Move the destroying of the detached tree outside the mmap lock all
together.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 3 +++
 mm/mmap.c                  | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 6618c1512886..e278b9598428 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -187,10 +187,13 @@ typedef struct lockdep_map *lockdep_map_p;
=20
 #define mt_set_external_lock(mt, lock)					\
 	(mt)->ma_external_lock =3D &(lock)->dep_map
+
+#define mt_on_stack(mt)			(mt).ma_external_lock =3D NULL
 #else
 typedef struct { /* nothing */ } lockdep_map_p;
 #define mt_lock_is_held(mt)	1
 #define mt_set_external_lock(mt, lock)	do { } while (0)
+#define mt_on_stack(mt)			do { } while (0)
 #endif
=20
 /*
diff --git a/mm/mmap.c b/mm/mmap.c
index 7b70379a8b3e..18971ab91633 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2427,7 +2427,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 	unsigned long locked_vm =3D 0;
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
+	mt_on_stack(mt_detach);
=20
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2545,11 +2545,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
 	/* Statistics and freeing VMAs */
 	mas_set(&mas_detach, start);
 	remove_mt(mm, &mas_detach);
-	__mt_destroy(&mt_detach);
 	validate_mm(mm);
 	if (unlock)
 		mmap_read_unlock(mm);
=20
+	__mt_destroy(&mt_detach);
 	return 0;
=20
 clear_tree_failed:
--=20
2.39.2


--q3otxkya3yodrrcj--
