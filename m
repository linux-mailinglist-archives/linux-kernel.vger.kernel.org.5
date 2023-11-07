Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52D77E4B62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbjKGWDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbjKGWCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:02:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A486B30C4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:17 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJlEW022696;
        Tue, 7 Nov 2023 21:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o9ko8McAd/mJQAjaK4ZmL5KYvONYTc7gV8rSA15DJYo=;
 b=xPNEBlicu9Ca+oemtyFgXqysHdGKoEgMWOdXVxc8v/cMWCRWWn77s3Kld82fK4vrdVuz
 zkRA1qqwrouwNam3Y4PrJhqJ5Rd5XoJImr3+YVIHCRSnSYXXKIWF4X4YMznfTmssYRlN
 TAD7GE1r57ZjNg/9Uc9ZKd1f4RfRtaEcchxIy39lpEXDAglDE6X+o+8xf5ToWxmdDIdL
 SefAokRZ9Nx3wNbY9i788fe8U4H1ilGBKRntCTC/WQxFgM02CEEZb9tHwAx0fWNnc5Ga
 cBTDAfyAIlo5I3riWNJ4gFyp8tY9XjMd4YThTP20xNVdZSvZqRAP9JNsBnopeL69CeLP Pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2002hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJLO2023785;
        Tue, 7 Nov 2023 21:59:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w241g91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as5ZudjeQacMbQa/xBZEMl3nkh+Khztfw1mKPVe/FHi66kGq5Re/EL9J9jCIt56p8fWwxZZF9KGMVh7R8EYf2axmH9dwBkcob7VTlISnavG0veV5yP6RirqOsX/gk2duJBxukrJQmRzVOAjmFM0K6WHEiKz2M8TNJzRL7Dk2HBtJc3ymfjIA3KCZ7nBV3RBCKUOk1n+zk/WUD7CmhPbLHipd0CEMNF9JgsM6XnZK7LKnGwD8V10s/N5PjcmCiviYm7V06F5W3dmeBZEy0FfNsk2HH6TcOPGRunueVW3kB74A21n+gsbjos+8AOIfu+1mFFBXjOpDTT+x7GmQ29WOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9ko8McAd/mJQAjaK4ZmL5KYvONYTc7gV8rSA15DJYo=;
 b=YGqEt0tN6Mm9m4WqnMVYy68xgW8Ey7Adm+6HqP8b+TF0weXsdfmh9NofwCPWnrdPo/B0aJFrnNS1P3nx84FczKCiYqEXOLKsqGCFKaKUSGcRE5Ua9RP6x0vK+57KbiFFLxXSoUAkWZtFjGpZjHa1zA3QnWwE1zrQE3gf5JS2C8QoIqV3cjIG6JwrCmPJjp8AWFWcvZupTWYSPEIGbX0DWRSpIhE379SYCvRFG6qbl9XYINZiHdPJELnst64Ka3OrJlV+lwPu3lUu0gz4rpeGEqS1gXPQVFWlWic7s0thjzDNuLife0389deQ98HwtCdeJdxKGQyNmodRlikNjwjURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9ko8McAd/mJQAjaK4ZmL5KYvONYTc7gV8rSA15DJYo=;
 b=PRam3Ly+CBoJminZNTCRF8yBIrATfenGz/uGCH1cwHZbBr3IPV9BWkmhWOFo+20DQBgK8inAPOpttXMrhd9WI05M0E2p0P8ZUHP5suWFNtkhiyb+EZRpzQ8lPMviqCmNGAMBD3f+tuc1F6vv/9cXzl9xkDGAY83Rm0fcl7KilMQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:20 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 32/86] entry: handle TIF_NEED_RESCHED_LAZY
Date:   Tue,  7 Nov 2023 13:57:18 -0800
Message-Id: <20231107215742.363031-33-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0121.namprd04.prod.outlook.com
 (2603:10b6:303:84::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 662ce798-d107-48c6-24bd-08dbdfdccbaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZFb/SDqUzcrEIGaPkRQCoiPI4o+fV2yd3wvjfknHnT0JaVHiFzqX8jGeEB0OPCbRXwN7MIgvhMI08WnuJoPLAA4aOFXuP8z3ojgjIyHt2WP/28KCv0qid/0WaUjBjoJPu+wSqA8hBkvuoC2WaC2zifjhBA4wIIcLnaD7K6GrU4q8W3nQvE41u0R3mYX+/3bRsR6z6DMPj+y3dTxyfPgA2c5t8yj5VRIRngzJDQgNRgo0GaJgyWFJmLsBkQu+cWGOCCbCCcZNCP42EnNwAj3Xsn4luzuO2uci6V2nmBooB+BKrHzcEpWl9lRWxwWH7pRK0mCAydYDTb3LuvXNGMqSaLr4XcOg/wlcMr00XI/SsfvBFPJcTCDUP1W4/IW5k2yQDxgmjJBm7iMRs+A9SJ7igJDPUGGEZBnzg8X4iux/yYlro0FPvk1z5QdTOA5kVaubzA7VTqYpIqpFbQtJpd0gt6YEJsBqZPCUueFoYBd03INYIWfbuZP6aHrvN4juSBVRRjrsEK9c2lu7KLLX++raCq9i8JS0EQ+/prukIkkZg122G1OqixGe8c7uFDY/9nB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ByaQc6xNdDxTpr4aErCVTJvCUbkoEv0WT0kgrv3URJWq0ZGQC6odLnrp3lsl?=
 =?us-ascii?Q?t/vi6sIw28B2kjl30SmET/bQYjwhDhXhlxHs3G/5G7s42KmS7GgtwzpO2r+s?=
 =?us-ascii?Q?M730UD2xyYSe1B0ZTLvv8Mw9uN98+Tt8N4D4zsACTKdj/zvUvXakymY8ohDk?=
 =?us-ascii?Q?4yC8o3afrhrbMdG2uH7YsN6lNlU0n7hsDqDn5y2qddAt79gXHXRg+Esb9p3l?=
 =?us-ascii?Q?luqUHjMJrJFZqhh7f9QHph0OYw8jUr29focsNOstZZDWxlRZEo0J2Km1fjeb?=
 =?us-ascii?Q?n9jJRcu5R3ghoAP+hvTF2OTRtWnSqQBNRmqMcLn8zqE+RhI+Fs5D6glpNCmF?=
 =?us-ascii?Q?XMoW3CvWd/kkmlsTWeDiV8tywFhH+SlsG2KsWd3Vy2EQRhUdG9LYFg8QECR4?=
 =?us-ascii?Q?tr7uEaBh82LO3+gUxr/lLui2T5/lJuZVf9Jn/MR2Wnt5UgDFRPNBoDwXHDCq?=
 =?us-ascii?Q?sKsbc8ye6V9E1KHOpssGml6z+INzVC4h0eXXPOYqyrRYR2dzCZZn25oAHcG0?=
 =?us-ascii?Q?4r8TMIGkChID5FzzvDhopmhegcXytaYIVB8piWB6NpCJCYyrnxH3H1WvmnTS?=
 =?us-ascii?Q?UbHghrYy7gV3BwVil2RoRYyoy8qehPpW5ePMOwGVr22jEe2BNvG5p3Au4hQb?=
 =?us-ascii?Q?VyCruLeN7500OxN6PgFqeUAXUfPBX5M5n3w+BjovOqg0/StlhGVc2M3pjad1?=
 =?us-ascii?Q?VK/lw938TrA5OaXJlwb6pjuQE8YP/XjqUWwboXFm3xizI30WbXT85VMnr9i4?=
 =?us-ascii?Q?oZX6K3vQ1ZsZm7X3yIOIEiZyBkRCPSh029jIcWacMvZw2dPgFHld53Ny1ddm?=
 =?us-ascii?Q?I5wZFpYXrfwVoV2L4egFv5a8iYlmbhYbx6In36+LqNz/8e+kf2EfQVxVnPau?=
 =?us-ascii?Q?c43adyJBY1gtMA87u1bQuSJWCZDkVNHBBCMboCQ3xgm+g4ycDJtyD0RVykLe?=
 =?us-ascii?Q?Uv7v7kLz2p9KzQASXf0gP91x67nwspXMnOMSYOip4jhq0GGW61q77RxQB3Aa?=
 =?us-ascii?Q?0pNtO2YiMYPm8JN/DBpJYA9fvq1ep4ky69rrXCpsf8cuJQ5HOLjdkCV7tEc1?=
 =?us-ascii?Q?ucUh/cFTa2c67581XcOtR2JoSaHU1TSiAj7LCkK3DNSVd2V83SSQoCZnuIMi?=
 =?us-ascii?Q?l9baCSXL6mtxEozibCVXhs4bcqj1BBctuCUHuPCwef+0QcNDPEOzFfOZQWCo?=
 =?us-ascii?Q?7VFRG9rQhJX2THVCvCuvWv69Clkyvu+HT1KpvBGWzR4T8lGQT2s3IiAKibK8?=
 =?us-ascii?Q?9TWuv4PxxWMImnVxLbnjiHUzaTR8R8Lgl0MvbZ38DgiYH6VxsQSxHUjQl24s?=
 =?us-ascii?Q?vCaXI9XScv0a5r7Hi98JSWXmcqs3sHL9Pmj/Lh5AEsxy43QvMLV6H5Tlywdy?=
 =?us-ascii?Q?H6raqfc5abQ6gsETI9NrMkwx8E41x3WASvcKiR67IFUIahazSmbvvaL3RD2w?=
 =?us-ascii?Q?FYzX2fE56oBJ0jbpO89KcfdN00lm3L4YwLXHVJmIWsErXvKy1qDXbT+o4IZv?=
 =?us-ascii?Q?gRS8SGSK6O4+BC8IdlGyIcnyzjnl1LAA3yViIp6ceWG7u8UapdWydC47x0JA?=
 =?us-ascii?Q?oQYcx8tbE7v7fcV5Rbpedpj/zXZ77oWKq4Et1aSDXd3sZUrHUwmEkS8nAY1n?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mQ8Zts3gINoijm2MpQWV98TxRIcuAn9THCHyya3+sznkc24ABpQl2q8iztFA?=
 =?us-ascii?Q?d67NkMMggU/PKU/zRKLOGioiwJl81vqLMWenDC1nhxZIPX65oXMBdOVBDMQS?=
 =?us-ascii?Q?UkncFDAYWQH8c3OW0uXhPM/hivIEZuwXq5QJt8wl24je082E5val1HN6/+lG?=
 =?us-ascii?Q?VsSpvfc79yVMAphZpgjTO4/duBuNTImjU8fBnLICFiTYkH1z+9CrX3N9exJZ?=
 =?us-ascii?Q?90NW8MbFgahEbmi1DWOHTfr2+b0pHaMQ/1dfFR7EwzYxzEuujlsnrvxLaxYe?=
 =?us-ascii?Q?RvRqY08RoQip0Hq+wcXD8ybjwM9vGtri25NpZEeZgNz8S0vcmcfWaqiJWTp7?=
 =?us-ascii?Q?2tUezUMgM2n1os9gog3zgURd77daLH2YAOpkKBF4sabeHhB8iOqIoUC8QpkK?=
 =?us-ascii?Q?zM5yP68/vw8ZFPqnNg3FwZd3vOkC0IT88Tum7M+GZQ896gWbCgMV2MXGBfA+?=
 =?us-ascii?Q?mheNziJG/dSo70D66RI5QFu7dpnW0rhRK1wKXDnObhpyDPGSJP6WEuBSJx+W?=
 =?us-ascii?Q?akrYYdy6FOmoOBCHwQcOO8E4NbTxZ5VWvJnzSZLZIecAD6krQ8VkFPwZDJUx?=
 =?us-ascii?Q?NWLE6Pd+Sbyg6ybw6Vza2QX0p1xVUeKIYC6DZUbCqp8eRkEruHtrbC8lkl5x?=
 =?us-ascii?Q?aSL8Kw0RDTHhh/jqollNAYaLxuFWbBKrjLIsF476Lep32wIxKOoeCxb6FGot?=
 =?us-ascii?Q?zKUd+U8keeR0lgaJUB6r/KBr5Lhr+npsjB5g2rekkPRDVVvy7I7gsCVxzkHD?=
 =?us-ascii?Q?vb1zCFzGqjaewUHNXdt0eTh2T5rPpbI6n4VAlm9wvyoPBo6fyRHg1Xb9lssj?=
 =?us-ascii?Q?FvJTJh5+xHhwUeO8CDY5R5w7AEDxt3Dp4AtTom9kD/W8Ap7l2gQfNV02BPC4?=
 =?us-ascii?Q?2tB7fS+BgcmAxehWhyvtC7Y7BhiMmVoO+mqtxevSjoDouvhP2gTgSmTkPP2v?=
 =?us-ascii?Q?m2FaJ4GhYhoGig2pTC74UfXhVfLiTs7aLIu24wVYjf0qfY73xxHnzTueOXpv?=
 =?us-ascii?Q?KcmnlpGgWjfPZWl1MupXW+GWuh//D2pniFO/MBoW4zhNQbrecSTNdk9fbC03?=
 =?us-ascii?Q?RiXRPMEONMaa+HAYOMImMl5ExA4d/EqHASoSoXw1wKFHlzzi4sRSEfxnF1PR?=
 =?us-ascii?Q?gOrXIDlo0UNYdcIX4cduXtSx3cYhBZKo72uaj15ayGbnvz3kAMApbNay4eIN?=
 =?us-ascii?Q?EoM3zn55D/Sy78XmfXRAep6x/zfdKIS4zq7yFtLVpTrKLFkq52WCAPGTizwV?=
 =?us-ascii?Q?iIu2ytEl6zJ/05kwc/U7876Wtu5l7EP7rRMSTAKMY1uC1mKBjVO7/dloYQ11?=
 =?us-ascii?Q?b6p/KMuUVa6kgK/RFfMWEK23MCqGidZdFeKThFGcdo/wivktdp1t3tAjAXTY?=
 =?us-ascii?Q?L6dR7B1J12fb9gbfSED8acaqEPKOnIwRnIJMn47deXB1zMDbqW0lgb+e5TIu?=
 =?us-ascii?Q?lQvFUbHHdQts3Uaq4bO81S+xKzB8akGfTYB+bhILggIJHwygiylPoVRlse8Y?=
 =?us-ascii?Q?yuqSLLeUOz/5FXrXbqzEpaJ4YQOWIgKyP489W0T/OvreZdauRo4UCUUyuQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662ce798-d107-48c6-24bd-08dbdfdccbaf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:20.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEKOhTSRqutNkdP0j4qraNKtsM73Cq1Yg1pJDXDBCVR9B2WmzqcMgWa48fLJrZ/eqEZdPxfaOITyZwsn/ogafVfWc0WusRd4plSPOgXwdGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 mlxlogscore=203 phishscore=0
 spamscore=1 mlxscore=1 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: oI0E8Z-_B84-tQXuNskUxG6aIibQfA_J
X-Proofpoint-GUID: oI0E8Z-_B84-tQXuNskUxG6aIibQfA_J
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduling policy for TIF_NEED_RESCHED_LAZY is to run to
completion. Scheduling in exit_to_user_mode_loop() satisfies that.

Scheduling while exiting to userspace, also guarantees that the task
being scheduled away is entirely clear of any kernel encumbrances
that cannot span across preemption.

Ordinarily we don't need this extra protection: the preempt_count
check is always available. However, cases where preempt_count might
not be wholly dependable (ARCH_NO_PREEMPT configurations) will make
use of this.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/entry-common.h | 2 +-
 kernel/entry/common.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fb2e349a17d2..7a56440442df 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -59,7 +59,7 @@
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
 	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
-	 ARCH_EXIT_TO_USER_MODE_WORK)
+	 _TIF_NEED_RESCHED_LAZY | ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
  * arch_enter_from_user_mode - Architecture specific sanity check for user mode regs
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 194c349b8be7..0d055c39690b 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -154,7 +154,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_UPROBE)
-- 
2.31.1

