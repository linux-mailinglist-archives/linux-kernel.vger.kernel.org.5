Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9907795C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjHKRIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbjHKRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9301FDD;
        Fri, 11 Aug 2023 10:08:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDYT04000367;
        Fri, 11 Aug 2023 17:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=TpE1wqVtb7MplpG9Vaelj6riR98OXh5MaMtMxiY6bCg=;
 b=BJ5THPA44KkdU4QMLcj4v6tQBaiOw+9AU7LORw7UeP2LNcdBZdvGXKLZJH7QL5wvkba1
 n/QgqkQgbIMeejuMAHYgLSv+HQW8NX8e77EkpPHn2RxkMFy1m2dPUPjKCWfZQE3prOpG
 4Tbl22H0qSZBhXcZYtIu2ov/Tv7ivFCYBqU9XMru7ysk40VN+VIOxXb8Bo755x74G9CJ
 Yzj2UrMIhn60GVSPRnrq2Qe9uyPkWFxVBqqF3GjJlMqH6mJ4T1UR0n7ynwJn8Rc9WGJ7
 yQJyoQibF3yUjRaH/SiY9JDCAQ42gww4P7hCTfrKp3YAHeXIiwNZg2GWdBXhRMHiWE+z JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y6sfvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGT0iQ011134;
        Fri, 11 Aug 2023 17:07:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvh2dnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLRr34Hvf3bS3OEh4am44wPBRS0DjIxH/pKpr1V3IFRHxDKjt9YeH7UDgc8BrZ43m/zOzWNFmFzoeYWvKphjMpDnuhNNoWtFfxEBeXRI9ackKDg7+4BsrVXAKy0+hi335UXfv4SDS2J/NakpTho4tQqREP+knmkIXJqtHKyZTi90un/uuopIV/aWjCgY6gEuQyne318gXxO4PVKscTylE4S+UcHa9nlTMOFSY7OcvOhYDrNroJg4jfSliHN+KORSg66Ai7vaCIT3ZNVGOXkCtRrabNmGniyO8zEhPc/4zqaUvKJ+efY/npv/DrGeyCvkkKh2qomvhtWiEgLJXXrN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpE1wqVtb7MplpG9Vaelj6riR98OXh5MaMtMxiY6bCg=;
 b=LilzivjurDPAgwOUuV7RRdb0bZUAO1DBCWp4+i+nr0eqwX7dl/AX+aHiYR6PbQPzrarHjB79bs5a+IIYVUtyCiXeIupdkhEpfvpC73buscR40k5QuXjbXEvxmspRSBnIo9unUKzezIobZMgyEf1GLPBSiykwz2PHk00S2WzSFOqnjr15GIuOlAEgX5aVbyZJYRYASGKxphFB5JGrA9oxZolbaDpeBTqWnJ2DJ5Z4ednirtUAOUscnnl4FXtRQF46WjkawVKSdbr+sdrmoKioMzJazIhXQr+e9pQqGXDftoOeIVOAnDkc6o0wpbBh3OTr6do+1RG2YUCr+yJif+uxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpE1wqVtb7MplpG9Vaelj6riR98OXh5MaMtMxiY6bCg=;
 b=uVARqjYHUa4TgQHUkDsGfq88nYuhST6JuycyGzWZNeGBaIyZ+NWkjmUxd57ExpQGK91ViX5E0fAgE9mBlURTivDAl5Leg56VQaqTuTUGB+Vyhzpxi9nX79xXqjwvP+GpjGTFdXwrQ/fKQ5smiGD1BnjpEsZDLEcWxUb1y3d8VKU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:07:01 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 17:07:01 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v27 3/8] kexec: exclude elfcorehdr from the segment digest
Date:   Fri, 11 Aug 2023 13:06:37 -0400
Message-Id: <20230811170642.6696-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230811170642.6696-1-eric.devolder@oracle.com>
References: <20230811170642.6696-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5b8132-965c-4ccb-f64e-08db9a8d60db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZiKz9vy+Wgi0KV4Cpr5bdRz5cdRb9vZUGV0miTRGQb+Gh5N1aoDEKozh76c1d9mKf/40zZxBYCwtcvTyCicgBmn0jb/sxs2XFTIImuugIeCzkN/ti7l3XxhHMueDnv/c44y9HEfiSC2f9SOd/Wgo94UOpVwMSyH1eEraa84dTFp8QYpNvhSCMqE3gn2OoXePRQSNhnvoGYMeLEmpG96eoDJR4QMWA9HSOiUvHhhC8999oLASlmWyBaR5HXo7H9nMwZjfgDUkOLAAFcNVbGL/box6wWNX2hrJFhZCWR22MHJztem03EtlrfOqWLAiNISBrerWo+/W1TCdjCh1JzusbvefCsmKTHbRF6/amty4dwObJ7Ae82I3+qaqrQ5IOQJToKIBDqa9WXMB3CXmKaoA3dqrZUE/HmYSIGjBX/iXmTPToV6EHnJBTjaokCpcicwhLFXjspjI1EwqKj89skz/UxPLU9CL3ZNLGYTxXdJIHLfuze0uIKxblfBK3AKIWs2ApS4HUTdwe5soca0gasT++XqW296hkgueTHGNNIKNL0ct5BFiQtj8Bospxwyd84BUwqvbfjMrzApGAl5FtH63gxxJ6GCiG4Q/6vFO8Cte10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(1800799006)(186006)(6666004)(6486002)(6512007)(478600001)(2616005)(6506007)(26005)(7416002)(107886003)(2906002)(1076003)(7406005)(66476007)(4326008)(66946007)(66556008)(316002)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rMg7ShuvNFGNqr8lcc5g87jBq+Qgdsk7LSabMjXF6IX07FyPC/YQu0oVUh1l?=
 =?us-ascii?Q?ATAlgBM5TTk2R6kjptJ2M+dt1Kku2QokrSR8rFG0hV3U4R/+VQsTLzcbhRo/?=
 =?us-ascii?Q?2M56yJ77ZxAeE3RNzsyQ92uSWeBufNiKX0KXYiytKmHS3tBBpSoYVH/eUnK/?=
 =?us-ascii?Q?aajYWZEr7cR4Okpri6uZl72kbThA2WZZOpAX9Ztr3MTgBS+qAy/JcLI+sAIb?=
 =?us-ascii?Q?pC7jcKPmjfu/TRoJ9gN20z7Tcbb0UwxIYZFcRr1ASgRU5B0ROaXdBQyfItlO?=
 =?us-ascii?Q?ELEyyvmTVmiHhsM+qhh4vC3dtlUjF+q0Fvz+A7skstcd5wklnQJPrNz22jtW?=
 =?us-ascii?Q?D65CgNQrPIYoou2kiNQTvnK37XaGdBRDjNCyoHnrzHe8B+ptUZ3B3TZqInSh?=
 =?us-ascii?Q?akTyqI/XiTreWhZ2tvPnrSW0sXmYrO/97ceievZWABSTgqqr3YJgDrS41Qgp?=
 =?us-ascii?Q?8buWJQBysxjnFAlGcgghQ42mmoTd+ZcIloQZh64Gx/bj3MLOy47tjPTjna+v?=
 =?us-ascii?Q?bFLCBIMsnMFe8CrEQdlh+CGi9WuO/QKY8mWMNQjY6pc3vPvcG63M5zYmnVPs?=
 =?us-ascii?Q?eaO5PnxLVBzmvqSdvv8Hncz+ghN37JteKXy9CBpRYI+AxVTfmUUMqYLB0icA?=
 =?us-ascii?Q?9G/Tp5I6kp78U1Kf9PFmQzSxu0OzAvzdZo38y3jjIiKXo5xn85UiOZtIleRE?=
 =?us-ascii?Q?g+PYcUeiiDLdLP2n3+3Y3iVsIzmzLB9RfUjwBEna0WYIl8rNKNx1sfjPo3ZU?=
 =?us-ascii?Q?1Gr9hz173W+Ne716wq/i0hV2BxqbRa+luDsy5BdloLYy8uc06n2LowI9ry2e?=
 =?us-ascii?Q?ZeN2xNZXh+1ChbSx5dwrZydzfsgcDQQdbXhgAjvuSgww6i3KdSF6cnKeD+Eq?=
 =?us-ascii?Q?0Ut8zTJtT/q1xkPmLZjALZ0FqhFpNiow9o3u7H2j1xA6iAsdMKeZtmEzUy13?=
 =?us-ascii?Q?5c32qbtJ94GVi1gjldMzN3gyqDJMscu0/lDgTgWouo3n8Ef7FdC580QM8n2e?=
 =?us-ascii?Q?ml+xtdOqQj6BCAYNEtZZ5shhkiYVeHDQ0sB/KGSm8+mnUyln7XFNIpGVhzKA?=
 =?us-ascii?Q?o5kbnS/eMjdAB6W+fMLJu+ceI9daSd8Nho6FTGfWKNevA9wHUiy2WHpO2B6h?=
 =?us-ascii?Q?DtzDDhEj+WVQykMCMN56v4bvwiLpjftbEfTWZjPJ7QAwYHIHSPkdv2VfMMeE?=
 =?us-ascii?Q?go0aZ1On8YHsfl9NDgLtVQ9cZs31KYj0qeFO06fJuEzOfBCyYEQAM3XuECrH?=
 =?us-ascii?Q?olQpyphQdFYhjZXm2SrJe10/2ApyR7RTDC61Lyef4xHlQj3FpoqclhOF7v9L?=
 =?us-ascii?Q?cgDA7VqN9yyaeM61yxlz+bfCmN+muapXKNuXj3/ptA5mlMK3XDwIcghQ2KUF?=
 =?us-ascii?Q?W8oheyjSzUMVVvlPQmo8Qok/GxfroBMPMIFIruv4ky4xNK+lJpoN/Dj/9yZL?=
 =?us-ascii?Q?iE4NEH2JLBIAx3o3qOf4Hsd/wo6XhsobodLR7WF1La/oFiaG58CEmSeT8RiS?=
 =?us-ascii?Q?qSiJ+qfhzBLS2h6PzY4DUoLQxV6t8nnEvpx6r5Bp57KDEk4boUYGZ7J/UQra?=
 =?us-ascii?Q?6H0U5eTFbA8cIo43bo7p/Vare8ijswtxTMm/j8xZLxXcq2s2WlO6fg7bEdak?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?FENJUGueX4fP9LK3+ctcLip+bzNfajW2/7mrD4u5bohymAX5yVz77uVUJrCS?=
 =?us-ascii?Q?Q2iJuYzqL5aIoOwcSVTMJFf1VLCDs/bPge1NBgK5uD53JZpoxGC243ofxRcH?=
 =?us-ascii?Q?imWGfUDXJWcCNKVwU5nzv9q2nZgxA05g9uGWNa50bdZUwg3+PgbSOpHnGm9u?=
 =?us-ascii?Q?p82pGW1giZnCwjMwwl1KIjAMxBdBzQbgAGDVd2FsgJDamGxaTrnVT6FWs9C6?=
 =?us-ascii?Q?Kw9ASWBJ2QW1FlCUe0bCpaPnNEeur4cu9WVvfXwfcZ5BKCgE6pSnut+SRYNJ?=
 =?us-ascii?Q?t13eqiJj9Z5CyPFWBIrP2ozyvDP6bn+SMDfk2i4wz+NbPRGHV9qHOg69b514?=
 =?us-ascii?Q?U/JRAtpVLCLeBUN94iyBVuIeM/MViK+ea2k2gY+jSjEtWzNlPWs/DLV9sf5X?=
 =?us-ascii?Q?9POwlCpfVLdVezKc9mFh8lsqPTO4ewHXCcFm2EHHHZsOis0Ex5dKnQPTiS2v?=
 =?us-ascii?Q?JaPxjkcmygGj7CV4UZ1EvdrOsRsp7c/lkw5BfM40yXsPxhoCS98WBKGf+cAO?=
 =?us-ascii?Q?qj1U06rtuknSf+pG9KHKScBdww89l2tJIHtqclyP1eQtf9eppSJvbj9vBY3e?=
 =?us-ascii?Q?p2lvg81p+O6PJ9iFqYqozNx/GafBcCBWhUY3SxDJ89JRTf8qCNkwkBK0IJ7m?=
 =?us-ascii?Q?k99WH50+wytaKrI+DN+s6V6gWHBrzVCRWxWfSfxHr+8s/qEK4tV8P3dSs3DK?=
 =?us-ascii?Q?FLYSY86WhXk5N02zOXOMiniDJ5/K+M/S4yznzsEnUkSbmCuvMmOzU3tb5jRG?=
 =?us-ascii?Q?ry7EvFDDbcukG5oO0jSiBB23vwBot9zhyNbXq5gGLQLgbLFjPC1stfbok9q2?=
 =?us-ascii?Q?aHcPUb7IzdIWQyvQJsie+YG+BXYtHOarwlP1XmkH6FyyuRqyF2MtGOYMXezV?=
 =?us-ascii?Q?2KiK8qOF/Y4hwiOaE830dyyzZKulJaCrgyQHRxa3KJelRqY9BomyCyBTIA5p?=
 =?us-ascii?Q?hbDI42Sa3QcPq8hOp1rip/A0Cy1u02I8U6Vc2fwD1AmYUmsUcXVgQkBdLpT1?=
 =?us-ascii?Q?qXK7eyvkHoTBK5AInaIO8SPS3hJenVvlwgr4seF7nspOb2S2DquDD29Mrl5S?=
 =?us-ascii?Q?9Eqr09RAzj13OvlsVMQngeMctFxZ7yeaQG31HZQygd4ecoaHqfdb8Kru4W0t?=
 =?us-ascii?Q?I/L7CDVN0ZHpKQgpK8FDxeqwr56JuDCdn46l/i3StCp1n/X8pEYKI0agiOna?=
 =?us-ascii?Q?cmav6c5ZcwEes9hR5i92zioQ3An2JF9P3Ca6DBO8IHyJAKjWNrhgKqtYFMRR?=
 =?us-ascii?Q?E5bJLSSUUXOGvIdI5ppiTwShFhb41LUHv0qkt8fYCwyVHbqdMr0lUdhIMy1K?=
 =?us-ascii?Q?pdxlGxY2VoOsP4xqnEzNe8BUH9puXKmo1oU/sE5wOsImw6w23nqboUeF0rdk?=
 =?us-ascii?Q?ARFBWhL6iHAf/GlgvwWj87XQsEU//v6p2a6uSCLrTrbDmmRMUdVuui8f0wm7?=
 =?us-ascii?Q?OINQ4T4ARlA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5b8132-965c-4ccb-f64e-08db9a8d60db
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:07:01.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcWMiCR6tfzi3MNad+Dl9OCCj6hsLFj08QoO4YT7f7RjrBJXdt+aQA/lo5sNw2JFO4UuAtD7hU7HX354GJoSsDufx1eSGhd6v/6GrxthFMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110156
X-Proofpoint-ORIG-GUID: Z-aVg-jZHAyDecndJUfDnAIuT68CDdSL
X-Proofpoint-GUID: Z-aVg-jZHAyDecndJUfDnAIuT68CDdSL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load() syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. The digest is embedded into
the purgatory image prior to placing in memory.

Updates to the elfcorehdr in response to CPU and memory changes
would cause the purgatory integrity checking to fail (at crash time,
and no vmcore created). Therefore, the elfcorehdr segment is
explicitly excluded from the purgatory digest, enabling updates to
the elfcorehdr while also avoiding the need to recompute the hash
digest and reload purgatory.

Suggested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 453b7a513540..e2ec9d7b9a1f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -726,6 +726,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (j == image->elfcorehdr_index)
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

