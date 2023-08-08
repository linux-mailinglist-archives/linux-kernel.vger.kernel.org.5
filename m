Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C744E7736D7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHHCkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHHCkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:40:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8163D1FF2;
        Mon,  7 Aug 2023 19:39:47 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3781iQKE008106;
        Tue, 8 Aug 2023 02:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=jm1ZTrMv4JtULZpopSAu4Y0IqnzTKBchDqwen5nWw6k=;
 b=trYZBNID+i7mglr2dMiKNQ+Ok+MdROjCGy+SPmIhJ9Pb1dtCFbAARsviwS+nnSzzoENW
 x9qbb9RyJ4gvgm+/Dr5gtC9nzP/AtNmQiRWvFdYtSOTBA3th4V7xZuHDCHzx6qNB2C/c
 +UQyTdOVqkjIAe/rthG765JmIvQHuFKPEFtW2lqkoyAxBbOAxDFzoWvi1tOmD+gXNw/K
 7Z9V1XG7ZWJcp2wdKmksbaT/ZUS2XKee5FOyH8rIPa6gVCPXYHzp1+/beDHhkjhAbC7X
 t5SBFS4qLyLsxg4WCDaxWlDjtCOf+ggQu7osE5kTTRznRJHfKim+Werxibi9p9Oh1Df5 9A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9efd45k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:39:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 377Ns2dh023043;
        Tue, 8 Aug 2023 02:39:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv5dss1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 02:39:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT9eXrEp5Di+WisB9qh5ifWpyHjXs9NIm6LbvfxHVTGQC9X4n3Y2Q8RaKNfQJfrnQj9CcCR+yX4vnb7Q2brTbVUP1J2mYbFiDoj2NZ8wnOjI0W/YnKDj9yudMKTCd4wApR/lGybSm0r/wABHIsqAPd6Wh63Ko+4QgfXmo8vcjgjUmHZXg1xTb6cI4jNHYjH4SeoqmQCZ+9wEvupQ2rrDcidTel3fZTs/kUncyw5VgI5bgX1kV/xvbZOdGnCpme7tMXJuVuGIOv7+TyW7/0ZrgLHXUaCx//pb0fs0gnZUexBVpn0qbQeiYTIuIRLfDtPE31UHcb6HLxqnjj4NnXJKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jm1ZTrMv4JtULZpopSAu4Y0IqnzTKBchDqwen5nWw6k=;
 b=aI09OJr0lFHToSvuk5QxkEEk4axk383jr9/qcM0RkEyblS37S6st32vxRP0hdtZGLNn4OcOHVAKN+crDLM0JVvyVcy0VqyHw3HCUkHDvX6IoIoF2rMEdjeED1Q7rxXGnkRJIOvRSC5+DEhjXgp7jwqsTGn8md/QxoLr4aHmTnZW/mZkdFXf/WEJNMdTtR2IOZU/C7zWTZ58OHd/g8MiaqBDYPdbg5GrOpDvtXbcKpCky2tW49Bfmtie9Lhr/zbT57Hs0oTLSQbc2Kxue5gKy/IPI9RA29s9YJyVEPsIchO3r0Gd/Z81fx0Zgm3qtUt9rd9kju2kIm0s4IUjIkSWtjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm1ZTrMv4JtULZpopSAu4Y0IqnzTKBchDqwen5nWw6k=;
 b=o4JQ77koYPZBq/80cdRZABJy2KMSukRb1lQ08Ld6Ks2n7ALCOt2OvzVyhpH1+afeKJRcKnl7V0Dv8xs4iQU7ngexBWJJ3H1tLMKqs0Ftdk/rHE99omhxEkkkY3YGed/4Z/WLTXRG0ue0oh5bMZKOggZufoZngqfkH3XK2QozXXA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW6PR10MB7590.namprd10.prod.outlook.com (2603:10b6:303:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 02:39:33 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 02:39:33 +0000
To:     Jeuk Kim <jeuk20.kim@samsung.com>
Cc:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: ufs: ufs-pci: Add support for QEMU
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1msz2jm08.fsf@ca-mkp.ca.oracle.com>
References: <CGME20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
        <20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
Date:   Mon, 07 Aug 2023 22:39:28 -0400
In-Reply-To: <20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
        (Jeuk Kim's message of "Mon, 07 Aug 2023 10:37:26 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:806:20::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW6PR10MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e452340-8e6c-446f-897d-08db97b8b2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+C10O1xSSqFo8Muouvj5Rih5VW+G9Mk580EuxsTVdpyKcWj5yEMxqfGQLdv5tVEMEJ+Ec4GrslSI0Wd8WY/KZhiF2+/Uky6HWGy5UDsxn8x7oobZVGGUbNREhcjcaYgoOze7cUlAVq3iI+xFz1xgpLEeLEHjtTdua9GuPyB+rh4rcQbD6evUjeDxKImBOnoAPAnSLnSVFGGr5QWimVL+IfzAhBT0cZgzc4SkQalFalGTf9C8CzuA9UoCNMeKewCh1R5x1UNpsNNF7RqAzLsBB0oGPSgfPU9Oiy71ItqZ5grmvFSzyYqcpoeWoiglQQ0+5ARDLNSWyAAEF4nkIKOx3B+n+hbpNGE8N1/ZToxhBViXahSgnvQ2aYluH5GMzc/1SuR0X4+6ZEk+j9l5JL2J14VLDBUGFa+mq4nL3XAWLM8qALf0grgeDY58zGA2GjMapCHZnDYZVjAfz5PWmNNd4zoMUxjBqwScgIIXJC82r6xqKo+bSrzCFMIBw2c3bnFMgYKrZ9O7rnRZR6OUzree+q0V07CLnpkuzggyncNTnK8WyGtNw5VjARq1PymieWWh4+/kHCrzxUYLfOTf7FlK24tKX1eazfpZtDNudJj/XTowygggWZAmxLG1d3IDC0kaYUqiOGznpA/yDnWspAsFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(90011799007)(90021799007)(186006)(1800799003)(6512007)(4326008)(316002)(86362001)(6916009)(558084003)(38100700002)(54906003)(36916002)(6666004)(66946007)(478600001)(6486002)(66476007)(66556008)(6506007)(41300700001)(26005)(8676002)(8936002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xvjH73Y103nkDtNvfMk7O8N3fCgsGRFFHKszDK6R9tuRYJF6hyhwtxiFJVLI?=
 =?us-ascii?Q?rhng1hmHUCnY9Ah4slydgHFr6/fYSat6P7hr+mO8S+9X2EgXV5iDDnpmFZHb?=
 =?us-ascii?Q?/r4R3/Apa5nCqeGfmyk0Zuz8OXBPrWeMMj5wkmIAKYMtgx4ZxsiPOa26OB90?=
 =?us-ascii?Q?ECMhJEkgW5FBCCyiXizunGmdBw04CxkwOeQEekPDNXE7SHQxvX1HZGaKP3tZ?=
 =?us-ascii?Q?slI4wWESCTfInpRLC8EToKJUr/g503p73JOgET2lxJL9D4YY9LgqZq3T5hKA?=
 =?us-ascii?Q?T015dNX6J7rH5puEF/bs2791kws5Dd8uTLJaiIro7aK3ILWrPrTpbr+TxstJ?=
 =?us-ascii?Q?3IQILKLvUx74y+Jc0YHGVC1lxUsiWIdTyotU37D93D8gQ9torO77MuzaAiyb?=
 =?us-ascii?Q?aRzIsVBvTQfdDAA/33vJWBrSELTq0DifsyV1IqoELlDdYq2JFWvyVV1EQpLH?=
 =?us-ascii?Q?+elhgLFVPOrymmTlsrP7yONCSW2gsagy4TOE2hRk/dn658vASrekWWoLZ88d?=
 =?us-ascii?Q?NezVJmSL4ejQFtBUMAwTDzOaJwguEXO5uir+WHCVbd1xHQRsPFEFJIb0E5jQ?=
 =?us-ascii?Q?EwHAT0kMTd7egAf5Ezo4agaVKUkO+FCsDgNuvJD4vKGf2sx3LmxUBLi9K6ak?=
 =?us-ascii?Q?XFpaFnNzOyiGOpLcCnLaeYc9ooN3A7vIw6WmoZ8YRuAC/3u5Z47ZVNBwzfO/?=
 =?us-ascii?Q?2CYdJ9rngrSFz4MR7jYO+BbtByPaBOjc2XJ5YvNDn7a7piwGu83m3HXjhpJb?=
 =?us-ascii?Q?9E3wV6R2hf9vKXsl4HE0dFq4DtHCuGz0qYJNutT3znYZs3G51ZeSs9m5BM2p?=
 =?us-ascii?Q?xVGzpUNOeEB9g8c81DgX7Wt8QMGclHCFkgdkXZKd6yBpHfZK/ONKwG0a05KV?=
 =?us-ascii?Q?Ru1jtxSGSpwM9luNvnVYtuzjBSmCL+yGcyyP0H5rzGnMeHJQP7dYaJB1wn6s?=
 =?us-ascii?Q?tpSJGwXyBrWTD6pkcrkJgcuflzG73HkYijTDs7wAfOOL5wrMpC6/8KpvIFuq?=
 =?us-ascii?Q?gBxSIbXlYdAADkj8xW9cY07Of/9CzvgVndzQ82ksyiuWrln6igqPB+Eoc3p4?=
 =?us-ascii?Q?1wgq3pz38t+J0zi2E1H7gQLtSwIja4TYZWM7u/bXn2NLADvkYFPi5Hc258qJ?=
 =?us-ascii?Q?MeHNByuumX7eihHJg/4YqRAyWDPB9ifyQQTTqeROfe4lLHUAhrR/u2Hqk+8G?=
 =?us-ascii?Q?IEUKZIeMbWX/4wTMo+fBz6AHioTw0/RnfD2VrSI7xO5aSeY79Yq3nDfifvaD?=
 =?us-ascii?Q?hpyM/LEagO3XdTaAihJ9LKyqZzhOXLv67n7BfNN6uCCp+sZilMlA2FnJtK7+?=
 =?us-ascii?Q?USBC3X99uZf2Mk1jpK3SVXwrO+XUkrQKKqnLFqGsFamDiv3HX6a4gjvWFFRJ?=
 =?us-ascii?Q?b5oA9RS5Ll34BURWnB1Jw0VHA9bggp/144Ex2bHoFjckKZsKIcYDTgQdFowq?=
 =?us-ascii?Q?lHPwnC8k8i9nB7UxroAJWCKEXvDHUZC4dHbpviy1io6rGCfONhVioZv6N2dp?=
 =?us-ascii?Q?teCiXUdjWM2DvuAUQvS49/a5J9PKwdoQzlQgQH3uNwUw1s5VogMZzokK0say?=
 =?us-ascii?Q?cU/8HRCThnKKULWq17lOYM0TyUdo5KfInJvdu8pFoj5e5jtzjlNBn3lkqtVq?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q/NNl1RAHBAKtJHML4nZWmixfLGHX1ENlgzdOr3Or2YLKeTStgtnqpnsBNcSQmwmrFI3LQunYt+t3xOsRYe7zJxAckxQ2l2oauY1JDyjSumaRng3p5wdRr5mmMCCJBdtla0/tWTl/CeepzB+h4uAHj0lHws8zYJ8e8SqXBxFT65dp4IbuSq19AS9b+yj40IEQzCZCaM/KkKzCknqPRpRWqFowbrkFWYZzbEMutdoGEqYUKubcgMxa63S49hqCClxJUiBaRZ+K+3SUQY03Xk8xx0BWeU9YYQYPQvXfEa5dSPUTIDwSlP6UtXjRi8aZu6WJVxwJOqj38fJ1mGAnPtBtzdvklPRacesZmTzXSvFRE4CC8GbVyHaHjiRmpYq5IAyOvErZucEeFgVB0R1EDveNL9jq1eVPNss7/Hhrko658pOxnWw9nsCHluqG1wfV8PB8zs/9n0aYL6EnOC47ntirQ2wNK+6c4ltPXyDzVki7aeFs0/8D0KTepQF7qi4v42qf0ANNKNCCQDIS7q8jTpO5qkcB7wIFOjbWEbRfPqVQ+bDeBd84AtSxvmxj9LZ7rUEwu6uoPQ+CT40hscl9qL/tWgg/emRV8iBDxnx7Xo1ONLzVFve1oBL4uCvhy0QNHDrRxd0FlZjT5vPNXC8uZ8S2+94HlRIWjRqKdqBVclnOoIGo828pxsMYt8z1wgOmHgVWdEe7vMSRjxskstB1vZoFzAewzEZ3+nCpgDB4TluEoOoYaX//k1+CHM5klcOtvCPmwcV4VP2VCw1qtbBZVSK4c13vlLJaJX0pF7kLVYvzr04bC70SmDdkciAGL4MyRO+HBkxGP6lW9bChTN1jDlhdxb+QgeMf5ySLoOBJWqsS1kjijrYWB3JNMSNvj43X5N9Ay4hcC7baAnMS+iQyaM4EA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e452340-8e6c-446f-897d-08db97b8b2f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 02:39:33.6681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ItOT9iv60WCGrXqXhGRjK2tCj3fUaQypD3NZHSYUp0nFz9yC2yd2BSmt5fybaCOjc1T7d+SuDxToWye7A75SUaikZhQpeYA3tRtdaXUQ48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_28,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=868 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080021
X-Proofpoint-GUID: 0gWyrBNt-FJ2W68V_qryxaLQUVFClkcw
X-Proofpoint-ORIG-GUID: 0gWyrBNt-FJ2W68V_qryxaLQUVFClkcw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jeuk,

> To ensure that the pci based QEMU ufs device properly works with
> linux, register the device id (0x0013) and vendor id (0x1b36) of QEMU
> ufs device.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
