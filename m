Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F987795D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbjHKRI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjHKRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20192D7D;
        Fri, 11 Aug 2023 10:08:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDWrcK002634;
        Fri, 11 Aug 2023 17:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=neX4dgrHOHpPdCnxirrY8SJnRS3HP5J4e2JJvTSuYE0=;
 b=v53QORTm2hzVPndas90/ZLzYey7tEOB7nRW78a7p09f/5nsK9ZZPyRKBxCEWr3VPdsrS
 bqX9WWzU6vx1z49k0/c4vVa6mLaP7NjA3/iN0v2C08aXtYIK7yGd3CBVgILYWNbPWPN1
 A01TENapZCrinpTVWgSlk58FFYE6sQVu+Q7HlQADuZoaAvS/TpN4T5Ha59Z4aMI/oIea
 V+JPLt7TPLaY0Xrsh0VNgVS6+66isw4M1p4qQ8SbrDQMaQ3R3ybdo5Q2rQ7PAQBc0pFZ
 NmfL/7gip07+D20Lp0B4Mb+fFamBKZS6qukTXk02x08RYXR/Uj11gblDq9rYEvHZV4fU bA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y5hfyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGM4Rk012069;
        Fri, 11 Aug 2023 17:07:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cva2g9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfrabkHC4Ocp45ftBR9NCKelEnyAvvLKtMOLA0RtczUezdCGmW3jXv7WPiKm4pcmHjsl/rXGO758s1BhAyKDxtBerGGgYKZ376+XBBaepZFK4pvhNvrBSxfVsyr/JOyuJJZabRFmGonlzsB6Y9AYkpok9YZtPVDJV5v/y42taM9+mvR4DJZNI6nNDz1NYIHvcOLNiQRAw8uoxtcrIHdglWLipf1845cTafbQj2zCw0WV+JiequtJjV4kvNTrAnp2kG4k9hXN+TyKpwWGJFAvemlC/3rZnbA1PB3DwoB4lktrxK1C3ToXz2DDMnG0/vLtci1JBEveixhp8QQ/XYV9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neX4dgrHOHpPdCnxirrY8SJnRS3HP5J4e2JJvTSuYE0=;
 b=JYmw3jAs3SwmL0cMrUAnuEVY3kpOtZcfsevKX6aw2sh5ztRhrn+z1wocGa0Rd7FprrqDA8kT5rwf0jzPdK2LlOOEMLLCJQBn+E3DL2kUGAQqYEKAR/JlIsokRBluNHCULDkbfnMWqnUuajUt1YsZJJiFDXpfiLfcFYymGdCYPTziME6xrXZYpQz8jSnAz5fushuui7wF5Hx9rfLexPdM7tVCW8PaatPFB5e0OIJfkEyTEuiVSSgEyCqSnpjCy23KMq9jqHmwQtK/JYSg+Peh35zF6i614sUQOfcq8rOdtG2ysg6X/0ce9FyLqJPg+9oGDkWM8zmK9dlk/fGq6yOn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neX4dgrHOHpPdCnxirrY8SJnRS3HP5J4e2JJvTSuYE0=;
 b=Zq83F2OMwV0jI4FSPonYfRX6CUGazvwo7mDzRbFfXMUP8eIWoy2U4u0MAoHO0wUfcXPGzW2RS6W420lyLy6stXvGXdSrzv94CI9JJSTETWuQW3R+LYdZqrOAuJNrtR+qp9+7pPWE2ExkfhxznFr7Td4gJRZq9kR9Zs03HGK4QAI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:06:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 17:06:57 +0000
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
Subject: [PATCH v27 2/8] crash: add generic infrastructure for crash hotplug support
Date:   Fri, 11 Aug 2023 13:06:36 -0400
Message-Id: <20230811170642.6696-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230811170642.6696-1-eric.devolder@oracle.com>
References: <20230811170642.6696-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6e7094-801d-492d-4e99-08db9a8d5ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBlN8TaUinOCzdd7jg11zAiYTwAXGUQdwrppZ7kGBW2MhxNsPP0De/+3oy6FyZUS6PFPJBYVNHWQMG92YQlo6aRK+lpKn0CVu6Lh3gmqTZU6jo0bI3GoLKTiep3cYK+5QcrwUALuKS9UdxhjmMh/1zr4A7Vdgs6Xs/5wk3lI9IEwWBykHeRAcXGnKT6aaK2o2GYWbJYpJ1k5Nc3vFsXO84kMXM9HW+3BAMf2pf73x0Z6OnR8FJNROGBWYjrQ6yVOJulKmH8I/zZ2ZGy8Hw1Yxqjv+VeBncvw4XOg3pMjemKkWjg0HrBs1uBs9WYdu0ePafFzYw2DFxsXMG9SvVuChSZjUwcrFdE0IDkadQIBnn8+ack+GmpeUt7v+mRFT+KXzozJnTEJoepRWfKopcDIMMcdVCFSDyaz1ZINJp/sQqEHZBQNdK9iKv8SMXaXXDq2XgK6UFjteGwAx4dkTgWV+kqcdDSrG1+1rC4/P49OolgO2beslKczEbrYJ8eWNdZdpG/T3TF8gS2XLtHHHsJYmJvQDSNZUmt1nbqr82HXRE93sJT3jt1W81pFJysP3Qo929TzWKg2mODyOpCI/5oH7twhvmbTOpSM02NkzYL1Zu24vkLr863LkZ3giQKE1LT3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(1800799006)(186006)(6666004)(6486002)(6512007)(478600001)(2616005)(6506007)(26005)(7416002)(107886003)(2906002)(1076003)(30864003)(7406005)(66476007)(4326008)(66946007)(66556008)(316002)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(921005)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qLpJTknDWL782SMjMMKJkEQaoijvBxRd9QKyQO1sdXsVE3rE4MNw8hwtkdCV?=
 =?us-ascii?Q?ptfNXc1mUiK0FE9Mu2QHB7FctPjKsclj1qH+Tl0Sby23oRrdVoJkMH5maL6G?=
 =?us-ascii?Q?MWWJsyy9BlZpTsMPzVFxqsgg78EKdu1feKlG84U++nLyJxSBUIwX2YKs5o0m?=
 =?us-ascii?Q?8vMZC13BZVmTOGvuFmgNHF5MtGLA4UrQ1CYEeL4qe0yCcxjxraIwzOUl8IuE?=
 =?us-ascii?Q?lEbIUdU4B7aPHmfoJGPDJuS+H6Su+m35eAon0mGZX4DM4CHA6sJcOXNGpefz?=
 =?us-ascii?Q?3TI4Gq51PQrIP9CGbqj656Dov+apJwvy8nbe4oYn+iyhRSmiVnkQbehcfis0?=
 =?us-ascii?Q?LDYzl0bQRJYfrXPxeXLDsNjaS6Epb8hzJjPEw++GuX3KZpYG/6+SqnOqkK+u?=
 =?us-ascii?Q?MOGtGddFXAA9sycsdidkazL5nuRn0kjs7qYtiyGyrpl3vMp3wqGyU/z7BZ8U?=
 =?us-ascii?Q?ZRVsT5Hcin1txXcDDkq5Nt1THMAsm/cvkBwg5mpHvFhXNfFaZB6Hnu/7Cj+E?=
 =?us-ascii?Q?UDKC/uTI5mQ2YmP3hNpoo51QwQ0PU457pKBxzlyNoT0IoEkzUqH9Lw0dUvaq?=
 =?us-ascii?Q?bzY5N0TqYwAJopqL8mYKdKV17p2YWAHEOz9/65mOBXcbSr5ikGEsUIGpcaQP?=
 =?us-ascii?Q?pREBro4S3Ihb2bCHy99O/XrLmo2DBAURqzV5CSOAzcuA4GIKFxsKXfLkfES5?=
 =?us-ascii?Q?eDED957FmEHjLl7nrhFtS7zG2yF+tVDSR/Tpb0qsOxW3GToK21ue0ix/Zv1w?=
 =?us-ascii?Q?lCvIv6ys4WC1PGkiYDYjjACPuM9a0Cju4YSc4wJL3bqZdNYApTjYbbGnHULX?=
 =?us-ascii?Q?yY+x3eACs9zcVwa4Vor+lEr9X1p4XJfxE/IG6QWCF6A1Q0OdZ4jDr4nCSfIB?=
 =?us-ascii?Q?LPOqydvIQJIxNwqXTHGlB/qRe/vvojXOOmNMd4OUA5dsyW/sdqUKqWt0gcKw?=
 =?us-ascii?Q?PEyeJh+b7bWDpo3i9w+aH3Q5kR+GWLPXVQak7qWE8yIUSTMOSsWcDLkPJ9rf?=
 =?us-ascii?Q?oIDxy+PP6fqgnqbg68/aOS15dO/JfeqKds9XqWhMsNI+kS12oMQeyFpjQcDf?=
 =?us-ascii?Q?4uUNn4Vq1jCCAcxcMqwrBXKHnNCcHiAD3uhzsUUFiB9Bj4VxL7n2xAezGfIG?=
 =?us-ascii?Q?mHUgwDSQjKcZOm24qGM+9aIXEeOOzJThxW0TafBmoKb9XhO0AM1b2Ure2h8E?=
 =?us-ascii?Q?TOmJYIFUQNodfhX9Hvzgrm8sVNwRgThJo51/wePbxiDNC5Z68m/wzn5P0ThL?=
 =?us-ascii?Q?jaH1IvvtJ/Gz1/KwzSq7D2XlatDLRfiwNw9dzd7b09TjoQE9rvPwvEug0c0q?=
 =?us-ascii?Q?eofPLdaGiIaSl1EA0nm52z0BaD1KLT+Dkq1HrpXaq6tQnO5oVnzt7i1oheVy?=
 =?us-ascii?Q?sRRxb93nEX45KJNkSp0wX+ifUZ9C8nZ6k+yIC2QXBraTCuDDG1LAZPd/T0cw?=
 =?us-ascii?Q?buzE1TGKwhCD0n6oEl22vQgYlkSyBc5Ios1XXvYUlb6r7Wf1tWTZea5Urscl?=
 =?us-ascii?Q?5BF7UELuk10B/+XQxgCMqTkQCPWMg4/SnRVx5AjFyDqfgvU4nDt6qzK//VOU?=
 =?us-ascii?Q?DlXUa6MnAIVqyx82NolYQGTfd4GVejJ4d/mCGe+gb0Y2wiD29T9fNrfiDU6K?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?R9MGNTwfsivtM0wqj1b+D+m3SfcHw9UPNJXukp7gkE9ZggEeIyMe2Ry4dkYo?=
 =?us-ascii?Q?NokMTVTiJoN9LFXsAOOrHxoDIwhz2kHVg5iX5b9WS/5bDA20uyjYUhUHnnCe?=
 =?us-ascii?Q?PHLnSdLuaPZ3Jyd/tdGr8hl6OUj1jzFv8W3NfwtlIxVu9RoVpElrwNrlhcO6?=
 =?us-ascii?Q?IwGliAZjEyiRt6BT93pdHIPNbF8ejTSPuTGXEQX4ijfUsIc3DFIVH6Q8zg2F?=
 =?us-ascii?Q?S50wFZC5mWmyrjHQXiZ7SBLa4nr5JQoFYBUd2BelYk4h302FW35asCkI0RDZ?=
 =?us-ascii?Q?MXVfA2ccJ5FvmqxiCchXWDyyRIP/fhBw+9TCuN7+apUkrikfnYBZyjzp9uGw?=
 =?us-ascii?Q?6pH6xuBCPcLgGtN5IJB01mUtqqHg+wkPus1Mh8ePnH3l5mR94OacXivCyJws?=
 =?us-ascii?Q?kF9tN9P0Cq+WZksxyIavQ9sy5vhXOsl4MRKtwGErOVMuTPa4Wd2imm/dHlgs?=
 =?us-ascii?Q?4EKM7EdhRJANpUeGPvoqOiwmzo4DjdKROkpG+zfLp3rPuiPynY7fPmCK100D?=
 =?us-ascii?Q?uwDa9JP7gQsjL7w8LMxFfI2hK0zIpkqarwgKjbX40aI/nsiPwvjIwXRr/fVU?=
 =?us-ascii?Q?QHAjxXhMyyrKi61ixfRAXMM2Nmp2QhLuFAXT+VPT7AYXgk3sz2ZqOR2M2QvO?=
 =?us-ascii?Q?l32d1aR31v2A9aqNxl5OaYvT032ZT/reKaSUQatRldRtwj2j1PZUfk9Kh5+p?=
 =?us-ascii?Q?0Q1+SWrA8pwWIVMrZmERM6M+LvhAWN36pz1hhCJ/clp7rTt3qHFK213HuvoP?=
 =?us-ascii?Q?SKh7bGiEJz7uNSrLtzmyXOtDfgK929BGqGzfxEZE+Ce75b0SBrjRRwkk+wBo?=
 =?us-ascii?Q?eWwskmN7NOGQqfqPBvrAeJ7HiP8bmhKa9szGHWs6kN29ranXI6FYuGagzuFG?=
 =?us-ascii?Q?4/Lb76EGgxlVIrWAEMtsur7UZUjw53E21V3DJCf4AASDHO6uszGQSsrWyjtP?=
 =?us-ascii?Q?4XT1cUkjeFvO5TxypYMNLIDKHuxGP1wh26KYlMbWRvBkqQNTEpARV7CPjNpo?=
 =?us-ascii?Q?RcxKP7U4M3MRPeRqygQtkpBzyo4LVzlYjqNERQBao4xp/Zn1F447D+S3mCVB?=
 =?us-ascii?Q?5SKsHe1BtFlo/ysRpN0JFM+k/KpVb59rLWJ0WIcsWKmRfBa0dK3970xBOWzm?=
 =?us-ascii?Q?yf0FOf4aXGTVbycQxRvOUfD+4Jbu3a/Vfs4FLmeR8Bvbr6dfnA+MzfprfQuI?=
 =?us-ascii?Q?mtsUlREyfnr/pe4IaPT1UuEHxjdUkYPBCh69v3dRM3RvvQdMI6YkQ7lugw1G?=
 =?us-ascii?Q?llsG0ORyZcO0/RvKToM3yTY3icqKr6mp34Nv4htK3/0xICFBKrVLlVRCUJ1u?=
 =?us-ascii?Q?MfTwTY8PfKbhh91iu9kFTbrztSomiy2e8oy3S23wvhWAtIzoH9Nkzmk39Edp?=
 =?us-ascii?Q?wD72wvPpv394dBqayAeSKsbMSCDLtclGKZhJZx+LFFNVuxwhNYvqi3hMx8u5?=
 =?us-ascii?Q?Gnpp/dDmSB4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6e7094-801d-492d-4e99-08db9a8d5ed4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:06:57.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzsLtG0EnSTVdPvZfFmB2mgwZ17YWC8LRcTTmMi/v3rY4U/ObNsjOF+DL/RbQm6hZbwW0L5B16m3NC/fg//BwQYIh2XD3oMdbwA+QKKoCq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110156
X-Proofpoint-GUID: rbDj_Xf5EbyRiLPZ3J31uIATVXqeHjt6
X-Proofpoint-ORIG-GUID: rbDj_Xf5EbyRiLPZ3J31uIATVXqeHjt6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support crash hotplug, a mechanism is needed to update the crash
elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
onlining). The crash elfcorehdr describes the CPUs and memory to
be written into the vmcore.

To track CPU changes, callbacks are registered with the cpuhp
mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
crash hotplug elfcorehdr update has no explicit ordering requirement
(relative to other cpuhp states), so meets the criteria for
utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
state and avoids the need to introduce a new state for crash
hotplug. Also, CPUHP_BP_PREPARE_DYN is the last state in the PREPARE
group, just prior to the STARTING group, which is very close to the
CPU starting up in a plug/online situation, or stopping in a unplug/
offline situation. This minimizes the window of time during an
actual plug/online or unplug/offline situation in which the
elfcorehdr would be inaccurate. Note that for a CPU being unplugged
or offlined, the CPU will still be present in the list of CPUs
generated by crash_prepare_elf64_headers(). However, there is no
need to explicitly omit the CPU, see justification in
'crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()'.

To track memory changes, a notifier is registered to capture the
memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event() to update the
elfcorehdr with the current state of CPUs and memory. During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |   9 +++
 include/linux/kexec.h      |  11 +++
 kernel/Kconfig.kexec       |  31 ++++++++
 kernel/crash_core.c        | 142 +++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c        |   6 ++
 5 files changed, 199 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..e14345cc7a22 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_CPU		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 811a90e09698..b9903dd48e24 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -360,6 +361,12 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	int hp_action;
+	int elfcorehdr_index;
+	bool elfcorehdr_updated;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -490,6 +497,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index ff72e45cfaef..d0a9a5392035 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -113,4 +113,35 @@ config CRASH_DUMP
 	  For s390, this option also enables zfcpdump.
 	  See also <file:Documentation/s390/zfcpdump.rst>
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default y
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	depends on ARCH_SUPPORTS_CRASH_HOTPLUG
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug or online/offline of CPUs or
+	  memory. This is a much more advanced approach than userspace
+	  attempting that.
+
+	  If unsure, say Y.
+
+config CRASH_MAX_MEMORY_RANGES
+	int "Specify the maximum number of memory regions for the elfcorehdr"
+	default 8192
+	depends on CRASH_HOTPLUG
+	help
+	  For the kexec_file_load() syscall path, specify the maximum number of
+	  memory regions that the elfcorehdr buffer/segment can accommodate.
+	  These regions are obtained via walk_system_ram_res(); eg. the
+	  'System RAM' entries in /proc/iomem.
+	  This value is combined with NR_CPUS_DEFAULT and multiplied by
+	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+	  segment size.
+	  The value 8192, for example, covers a (sparsely populated) 1TiB system
+	  consisting of 128MiB memblocks, while resulting in an elfcorehdr
+	  memory buffer/segment size under 1MiB. This represents a sane choice
+	  to accommodate both baremetal and virtual machine configurations.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b7c30b748a16..53d211c690a1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -697,3 +700,142 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes of cpu and memory resources
+ * (including onling and offlining of those resources), the elfcorehdr
+ * (which is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	struct kimage *image;
+
+	/* Obtain lock while changing crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return;
+	}
+
+	/* Check kdump is not loaded */
+	if (!kexec_crash_image)
+		goto out;
+
+	image = kexec_crash_image;
+
+	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+	else
+		pr_debug("hp_action %u\n", hp_action);
+
+	/*
+	 * The elfcorehdr_index is set to -1 when the struct kimage
+	 * is allocated. Find the segment containing the elfcorehdr,
+	 * if not already found.
+	 */
+	if (image->elfcorehdr_index < 0) {
+		unsigned long mem;
+		unsigned char *ptr;
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+					image->elfcorehdr_index = (int)n;
+				kunmap_local(ptr);
+			}
+		}
+	}
+
+	if (image->elfcorehdr_index < 0) {
+		pr_err("unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	/* Needed in order for the segments to be updated */
+	arch_kexec_unprotect_crashkres();
+
+	/* Differentiate between normal load and hotplug update */
+	image->hp_action = hp_action;
+
+	/* Now invoke arch-specific update handler */
+	arch_crash_handle_hotplug_event(image);
+
+	/* No longer handling a hotplug event */
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_updated = true;
+
+	/* Change back to read-only */
+	arch_kexec_protect_crashkres();
+
+	/* Errors in the callback is not a reason to rollback state */
+out:
+	/* Release lock now that update complete */
+	kexec_unlock();
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
+	}
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index e2f2574d8b74..5d323255862a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_index = -1;
+	image->elfcorehdr_updated = false;
+#endif
+
 	return image;
 }
 
-- 
2.31.1

