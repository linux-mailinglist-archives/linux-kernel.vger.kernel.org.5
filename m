Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791CB7CB7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjJQBAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjJQBAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:00:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795B192;
        Mon, 16 Oct 2023 18:00:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKO4Bx011132;
        Tue, 17 Oct 2023 01:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=tfHMnWXukU6PWHyKz2Z0Wdt+egZDNWDjxmUz+ZXGmww=;
 b=wj8gJ7Mdu++LbSNkrrlcQH8YxD9y0KDyqZP5cSUXEg1k28rATPbj+QU77oGr4J8StVDz
 c8ukIJvetB9kBY7mW42rr/x25aeXUt+nuOsXjlMRPfS76yMeTfV4jO4+zAkaGBjy+xFG
 4iHId2aRkyjn/nleDGZajOCZi2vUSBxPoruR+fWzCqpz7/ljWjXo1jc5VCj4xLL6efvr
 JRXmrbxxqsb0zfl7PsCX0UcFq5SYQf1UN3et5yEnPuwLKfro7tQQ74cY15FI4TfaCSpA
 JIEA20nL/HR8OwUyFmRFj/X4RCudsoJalBp/1py87e+SCUfFSX9duIC9WLqqLcWq9Tc+ 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjync0fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 01:00:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GMOsu1040562;
        Tue, 17 Oct 2023 00:59:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfykmapt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 00:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lleXxOnQjY3Kuz7mLqh/fQKjmyVWc505VX/FPyTcpMLznzyc8uRbnQlpx5roCwCYGOZZHflaGdmYJ7LnmYKfrhG/0XK+Jj9jL3mHF1fdI5so09V7eKyc7+6fXBydAZTMhrXWfjxSezSbZNX2Z56/UMjE1p37t23DjYlEgRDTPogbeWFQ/OPfHI6b0Ctuw+0LSMgBQI3OmbtTIv3GvuThWYMSZ21nZ5jAiSE5YprDXvBYh6wwrIBQUq2UZj94dnF1HjFHWWJzT4JcepFQHkb4ynrc6r1NxMXyxqSJcIGxuiz6TbozDPWRMKHGr/Go8pntBRA1Jr5ytR1fAbA0rzZOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfHMnWXukU6PWHyKz2Z0Wdt+egZDNWDjxmUz+ZXGmww=;
 b=fbYcDsAjgRwGmFsWe/uY8CjDv8G8SuUultsfCXRoI55n9KL4rdDTrxcglRnpnyxdBy+8sphBgN9FUWFWtuebn7+BbNtlTxtVZqA42SmTv5jqQDBJzXuX4QI/CEUZ/XBQ9evV5tyOvARs272shrcg9LeIHDmh83EAgoyjym5E6SvFxDX9hLYLRL9T/x43nrj25KxYu1WNkW0gEiGyFiZwEgkT2ubY3GDn03eGYwQ0aIhEAFpdZQzByAUuGLvvdEzJnrbifGd5XucWaOxUmSRUKDlMDKtRPuwzHZ6Av1maaUlcKaG/PKmgIP2/Q+kRX9+wKc0zlMTNP76a8G3+IsyUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfHMnWXukU6PWHyKz2Z0Wdt+egZDNWDjxmUz+ZXGmww=;
 b=Jr5eIQgTkDuytS/v+N6NSZ2/X7/DjogzvbEAEhLQ2Pp4lzgDZIm0yFV79A/8s6nRbWr6lWwVY12pViJ6oFj0zTZkU4H3WxzswCWH0CM+Tx8u7FWM7WOcqZ2fXuO3ig+AsfABhx4c8gkIB+r3fh50KEapKbgBEtTF+K9IXoMZ8oQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 00:59:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383%4]) with mapi id 15.20.6863.046; Tue, 17 Oct 2023
 00:59:55 +0000
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com
Subject: Re: [PATCH v7 0/5] UFS: Add OPP support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1jzrmhxmp.fsf@ca-mkp.ca.oracle.com>
References: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
        <20231016035917.GA39962@thinkpad>
Date:   Mon, 16 Oct 2023 20:59:54 -0400
In-Reply-To: <20231016035917.GA39962@thinkpad> (Manivannan Sadhasivam's
        message of "Mon, 16 Oct 2023 09:29:17 +0530")
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:36e::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: 517cd19b-0e60-4679-928b-08dbceac60ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7Y5anDsPVpsGwnen91U7zooEdxF6QDc9DuPfcgxMnj8PNGItCdhFEgc0jMvZ54M2dcVKREXVkqhyxW811Pgpm9Tzc+75m0SvOpRvTh5LF9FpzKOf8K5MEbqTNZtWfWG30is38tgPzDu422uaJEav012b10QtUAzJyrrCWOJuvLt2L5XlODB3/bduFYvqKFqkpNrSJ37beSA9NFJ6ibZVJLocACU+fq2+InWz/REq3v6nLURYlwg+PjuRe7hFtM1HVxaVnLv8HuNAlEbgOLWGKw9SgDkBtLAI54R3wvkFa1tTOzMw25IPqwc5i9MObkcP5KtQ2Rpw9kK5EHoEBsFmak3eo0KNprzIahoQ+NMJfbGT/K1ZXN0hGaHc28xNUbJB0izoHeXvGAL9LyNd+p9x7CMfqDlWjg26NI7ZxCgxLI/PNoyKlIRxxYWKuowyz0G1KOurY6lnNR5Xz9fTddSYOLGjC/2uVuKyhtimVO7j6+4S9BHGG8M9FluitDjJZ9FUOf/sSl5O4BTWy/eMMORdUlNa89OZr40GGTT+u29gQc6VLo0VQjB7gRzXeBQBDQC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(6486002)(66476007)(66946007)(66556008)(6916009)(316002)(38100700002)(86362001)(6512007)(26005)(36916002)(6506007)(558084003)(41300700001)(5660300002)(4326008)(8676002)(8936002)(7406005)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yWECXb/I/9wFnSCwSeR3T/9MiLcY+nYzVA1SUUNGypHugU9HZtXXbsMVQcvQ?=
 =?us-ascii?Q?Cu19/EjTcSlgqDCHKM+wCEZUeicMvO5BEaet9a7TWOK3UltCGRFZpDKIsb/O?=
 =?us-ascii?Q?g2QUo65GPEeAjk0LMeV6PXc6EOvSpBoulUeMUC9l2HwPxs6S5TApJMnQ/JtN?=
 =?us-ascii?Q?zT3gaMZVHtCuCANnOX1/yansZzw2f8ZAZlEaQbuaofAtrq3/WnLfboBENIz7?=
 =?us-ascii?Q?lvLZbgZk+Dz+5A2dTlINUopAAKYxseIJYQPja94siTkASYZmiP267HOZS4+k?=
 =?us-ascii?Q?untQ23RsitQOLbgbZ4MYN/9a8LOibZIJN7KdiXDhgOp0IyQ6wrZToRgISU+V?=
 =?us-ascii?Q?NmummDHrauXfTSecKJyeQrI1fTqDcoIu/1RMNbUDC6MbEEtGOC3JN9qySQMW?=
 =?us-ascii?Q?XD/6nWetDDKgvu9IgGDwFPxrz7Tt4ifAwg+OL1pq36BztL7wa1zhZG0yxEhs?=
 =?us-ascii?Q?MivpeaS+JWSZWrRwdC6Daezwo3+ChEo+8M6qmUXoVtbG1GnYT/UDFcCZP5fV?=
 =?us-ascii?Q?HvQOWWvYIc4JzZNfdDE5aQo/U5rlvgt4MMCDBjX8m1y8eHZrpOWk+CDzHC8s?=
 =?us-ascii?Q?0hZYLEP/GcY2crsJxF/Gb2ZsuA89ja+SQB1iPKk+QirNYqEjHaibyDYrmYzm?=
 =?us-ascii?Q?Ok5jwe+ln0BrlKF7n232DWALfYlX2qCbBXyQtvSlqOwebYKa8nXCQj6LSKse?=
 =?us-ascii?Q?+PjcNGsEDCBHUcf9EL0tvMjV9NvgRE/zEIll+FKuXn5CGY2kXYMCnSe1MeZ4?=
 =?us-ascii?Q?8kxXlGyj0Wbn1yI94OYjU9HXr1Ug5aJIdsm8H33AyDv6nYTHpmCv1F1dTQ57?=
 =?us-ascii?Q?Dq2uv3Q6UqFW9PFSRnBh+dUx7Q2DX0RNuZO8MfXAVnDrRqJ3WI90jTAn7U9o?=
 =?us-ascii?Q?oUFBZYI33K3ur6kCTWTVQ2IOTQW5JNhxntQwUr1FXRNP/G2kQ84HWT4qMxfV?=
 =?us-ascii?Q?1pEQSvBNeAhltx9qIMsNapRPPQGpL2eiSmCfiug0+0n77BdF7OHCrmXpyPJP?=
 =?us-ascii?Q?6K+/Y6N6mrLwXXAvNyO38HzT1sxqwc8kQ3jkEs6f2xC4pEr02pUuM/CJgLPx?=
 =?us-ascii?Q?AZY9hNTrxePE9zQmy8Q49p7mdL/ulTsqWRTPodRvJuOjw+/IUDo1IAc38075?=
 =?us-ascii?Q?9VvoGVIValGSTrotveumLtpmZHJhuuMznf4U0gk2rp5abOmvAmXUa48YcJV6?=
 =?us-ascii?Q?1s03+lK/nET/byK+vVYmR6OYCbveM+dVz6M4qwS8g+15xQTukCstIcjhGsaC?=
 =?us-ascii?Q?sx1kjtjm0xmyZwLNxf3qrJ2wJcw5y49HdpOFMTaKjfmqz6mJUowvG8FnyCi7?=
 =?us-ascii?Q?0drZH4/HBV1x7ve89C/tpUgCh0Q0kO2vxeEJYlxhER+ktI7N+B3da7aXVG0H?=
 =?us-ascii?Q?rxe7mHDhIsmTOrHpDH6CCAKUbXkrTDSNd3LNoZd1j2Leen6EeF09aWroH65g?=
 =?us-ascii?Q?R1Poih5c6+8jIFSF/Gc8Frk4HweLdNzOATwoPjQhlzy4aaoYvqS9PJYb+kRn?=
 =?us-ascii?Q?KgKxmi6MO7FnpOT/I3gCHNECj1WonBgdmWuD7J1UgVNQURLVC0EjbqzVvNxv?=
 =?us-ascii?Q?637aBAaWevZhA9LaQ9AZJLd/11IL9Mie2E3fumttBdGv/iPlfTK/7MHUPTZE?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?e1bVXVyL+2R3OpaefDuFOi6CWgRCYccXwU/O7vH3o7Wvh3qK6KvlgyRwkpPR?=
 =?us-ascii?Q?nhpxqgrcI0fW3k2RDHj+WRlcmdEwqh1JScZtyczy2xNBuwihhPWJHRHh6Km5?=
 =?us-ascii?Q?O8Fgw7Nsh/brUFdLzeY5Sw/m9H2/kHmHSFksKT2KwGarxCKhoQQI8uWzLaE4?=
 =?us-ascii?Q?w4XCHXoSbbP8D4s2N+B7vQu56g7ww6CPDp5ZlWpj4Z8JtpfQ0rCRvmcimHQW?=
 =?us-ascii?Q?YRESO8WeYXt2zJANrAoe35RSOHh/s51q4ui1n4FBlvpZqyDCV3BsoXhoimhk?=
 =?us-ascii?Q?TUlZLSkDPsChl6XfYv4Z8zrix/cA6avUjUpWiuG7LAyvSIX3zwmJBaVo6AKN?=
 =?us-ascii?Q?CeHTm1B3iun7omU4vG0PxXYDd247AvQ1Pa3eHsQmpkl3XY/R7n9kgYAY+lQj?=
 =?us-ascii?Q?YPWVzz7wYazmlJitOz1o4DqQFiWaSX5Fx7AVuXIiQefxCsDRD4KIv7UkEPjA?=
 =?us-ascii?Q?34Ebqfu5zv2AbTH22bN/V2N7Gx2NogiOHMOin38NU9G/AYD10TECAXFP8Bws?=
 =?us-ascii?Q?T6dU0T6bby1pf9qAmh2u7HIrJGGJAI+Gbmjp9eDwlJ5jkwyA4rnSk7ZOK2UF?=
 =?us-ascii?Q?oH/I1C27kHKKDNEXOX6TlhKdb30r6ftccL+fZPPubIZIusp9Ld2fGm4OWRLo?=
 =?us-ascii?Q?BF34zokIuc7xdQ4dsKto5U8D3qQVGPEzfdXyPMsiFziPfGxOwfKzouGEvuKf?=
 =?us-ascii?Q?9mkzxIprGWctAcKM49wP1te7wZUJOOY0DqNHVmM2TeRYQI3tANJ9eMFq3sLl?=
 =?us-ascii?Q?qjvpAwBtHyy++RuuxPmXK1O+Vxg+TthX+oiZJyFmBer+Tmo+TMY18RcW6MtD?=
 =?us-ascii?Q?YzQR1eUCfK2wyrfiWuOabXBWtCGRnAmbd3e+CiPPh3jp6jJmntklXxJX07SU?=
 =?us-ascii?Q?TME7PkUJo6NYiwBU/iHXUQqJZO8GDQ0II9c8TGk6cypRiH5zVTEOeR9mN4A7?=
 =?us-ascii?Q?PCyRinQxBSXB+5cwzEoMGfCIdxcVBPTP0Oxjh7Djax127rBRBVLzmX9PqK7L?=
 =?us-ascii?Q?zZ7WpQtTwkVyjbKrU7SW0iFfJQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517cd19b-0e60-4679-928b-08dbceac60ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:59:55.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0o2Vw8oGPXHheww9u1drVQlNkZaFmScbOiSb4ajF1SGHxzNXsJiSqRbHx0HYfnj0MA4695o36yAXzjgSeMGPu/iCnV7wHYR5tMSGDMG6x9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=849 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170007
X-Proofpoint-GUID: kXUuNgwuhUedITHqQKnMX7fUE9UyAByk
X-Proofpoint-ORIG-GUID: kXUuNgwuhUedITHqQKnMX7fUE9UyAByk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manivannan,

> Martin, can you please merge the ufs patches (drivers,bindings) for
> v6.7? Note that the devfreq patch already got merged and the above
> text is outdated (my bad).

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
