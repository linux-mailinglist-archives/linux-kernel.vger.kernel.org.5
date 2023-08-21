Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B808578349F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjHUVHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHUVHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:07:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC98C7;
        Mon, 21 Aug 2023 14:07:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxUog014093;
        Mon, 21 Aug 2023 21:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Mqqp8ZS+z2ozH4ryIsijn/9Dq+RQdBAfUfT5Xz8Miwo=;
 b=LnJ67dJ0SBmla43tg0S2cZW1AB/5acOkErd7sitVYCzQ2+6uei3TvLx1f8To0bCW3SzV
 XE0i205x4dkZV524tTZ5z+SuuZ+5fqQn5TxDEy9GBPeTU5M7eccNzwMClEG4Pm8l1iJw
 yIfeMeajrpbZn+2uV32CjBLyd0QAzD9MOkuuFmQPp3TrLYhCmsKWXDz63MVzjsc7U44u
 V4nDbZGfau05bDW36rbODSo5QJeoWOYLt0+8p3/MYzf57zvSCY6vrawcO/oguuD3AV7p
 3FJrnYNgXEr/ocaLBs+k32e18+6YZisQTl8Rl4b/+GVwj9VUUk2LNaZsEDzDD1/8jEGy rA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnbtuvhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 21:06:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LJJjUK026654;
        Mon, 21 Aug 2023 21:06:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm647rj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 21:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAZq2YfooUcXH2sw/nyq+FvCIUu05yFWCleUsQlByY1QBigkWBZa3Z8qow1BDa9ijb8YneF+w4DAgAaN8Qm59Z8sfyRiFs3mcePnCbiEsqcQgZYVoaUHPnhm8+3z9q+m2h52r95OakkbRaW9ZuJSovNkLKiX0OPE+7STrSQC0/40AefZH6CNeKWcEcJLFNQpz9fG4j5kjH7KUr6WhPvVVTklu6jpY4OwkGr+cH7ub0lBuTitSJCinlQDj/SX6ujHts3c1+x0hkCy8whxMh0BkxtUiLXTbxcB8c/CTrE7jwoeRZ072IN/ra0O8/CXuQLBG/tizPDkgvklo8blBHbmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqqp8ZS+z2ozH4ryIsijn/9Dq+RQdBAfUfT5Xz8Miwo=;
 b=X5jaVA3oFo7zDA0Fw8eMvK+p1TK3Cff82re/QY2grsqK5Xc0I0t7/SnbTFvNo8djCdn9sfFx1hfY6yc4OUiCCc7rrq/e1YEDxL71qk/O/IWSbUxhgCv/lShTi7hSlfAjHoR6wYJEKuK6lDeTRWwp8wsuMza0Tygn0rKs9vgXlboVRBou/JCTnKbbGdDBrLBs4LXk7/eT4Xx/Ky3XXmqpoJ2vFaGsEXZ2QIK5AyrtLizsVxBJtWLqJTl5G85kKEHTBC+FYU/djLO6BTGevQwRP3u2s4W40ZN/2AsMMp4SSPTuTzlvV2JXHlHEaCUc8mSanw1VZD9MkaHcono/4cLomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqqp8ZS+z2ozH4ryIsijn/9Dq+RQdBAfUfT5Xz8Miwo=;
 b=jrTv5RxJPtk5uwv1sMs7VX8m0m+6A0cd4M54B6GGJYwiC5jHqTJu2KMgDzFmqGHUDgKlgg58n53m7UssFbY0n+LAOzdq9Kilr4Q/ZtuF6aqKJ+v34P23448q9WrlmbpFvz+F+ClV7lDwirskatSkxQmraAUoJ/5jvXN9MQSmLJY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6743.namprd10.prod.outlook.com (2603:10b6:8:10d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 21:06:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 21:06:32 +0000
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <john.garry@huawei.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: pm8001: Remove unused declarations
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bkf06r73.fsf@ca-mkp.ca.oracle.com>
References: <20230818124700.49724-1-yuehaibing@huawei.com>
Date:   Mon, 21 Aug 2023 17:06:30 -0400
In-Reply-To: <20230818124700.49724-1-yuehaibing@huawei.com> (Yue Haibing's
        message of "Fri, 18 Aug 2023 20:47:00 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SA1PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f83aa8-fd46-4082-7daf-08dba28a7ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bK0HjsNvTkqI/mw0PjvBS+96qzPtpsDjBspFlKBDD2th+yuRNr09jY6d+l2bskwIQDUheiy6R0hJ/AK5lKQft+c4lvWYZc+yY/je9q0ELGZWrR1p4hw6yRm9DZ3P9mmtmJAmDchRCuczt6EKrqHJWdMt7OE70+kYFNFpYumprXKN98rJmYV9qJdE2j+b3mz4VgM1EtBo0MTDs7pIsvpi+8XAaqjrKfP+BMaUUE90dmnvPxhLxMHucaygJKFJclHyedhm2XHOxyKXpZnEYs9bj1VFsMs+I5FI14HcMHMWttkF8Wa3fOJ2avrAz16x4r9uN/sNMk9aNSH0itC0FetyrdoLH24oNcUZPm5y9HmSFpmGY0Sb7C6Jd6hSElsWN2oyfIsXRK84tlchRKhhGdK5xb7ym3DusHxT3HbiUW7BFSqMl+LGQQi2WfCPF6xUwF/92OFLx1omcd+B8wOgAS/nht2rQwIjSWu1u0IIYIdmyom8joVFlGbwwk0R+yRbRh6kbEw+TRke6FQfHVjgWd8obr0/d+NHz9YyY1jxEj+9Igp/XQGXyqKvsRNOkdY5Ce5x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(6916009)(66476007)(54906003)(66946007)(6512007)(66556008)(316002)(8676002)(8936002)(4326008)(41300700001)(478600001)(38100700002)(36916002)(6486002)(6506007)(558084003)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQ6qW7A3U69vwNuhJL59m+7yWJ5GhzDcybER9+z8JKQyaNKRcAip6vNbG/Og?=
 =?us-ascii?Q?PZEvqpEincRUs7KsZbw2Q95bxxsMUkoJtksEK/KXtYfl49saRnICQMKaOlH0?=
 =?us-ascii?Q?mbZv1eBFtB1d7UMZLu+HuqfhBj0UcHJn9QkMahrjZ6ShpnAVZI5ch7g3yQim?=
 =?us-ascii?Q?4cJP1x+98Gt9mF0dsbil7uwzmSoXW0q2aWgj/I0zNoQA0yECDxoBrsWXZp2f?=
 =?us-ascii?Q?0PB4r23Z3GUw3ObTJ+utYCkavXK3Zq6q+awKGYtJznB9PGWneLnDNodujGri?=
 =?us-ascii?Q?wKhxWtDW3zAtKrdjcpUe8GmGXn29b0g4CXSgYnYlpUFYS5hZZw/VXgdGJDqr?=
 =?us-ascii?Q?RZMlhbXT0JzBSSuNZnvyny92ahcjUg9Y1z5/rdf084mMl60lRevsjexQJe8C?=
 =?us-ascii?Q?TDubIKSIRtGSOHjH/dypnoR+khDrcKGF7PTz4V2ExPteXBOliQ/npj4G1k0C?=
 =?us-ascii?Q?cQrV5kRy/M8XxDkfhhc2nkvtbLFIRoDPCni/5z3TaGwTmpdTuE43BrKtDweN?=
 =?us-ascii?Q?j16ekc+Ju9KwDabG4HLQqlup7V7wffCLRn9d0ZgV7+XMyOadtgPfjH6fRInn?=
 =?us-ascii?Q?zf05MpmtlG/3XcnoHGOK9PfynHrrLSF1x65XQWMpKC9x8AKQN1detSw4ECx+?=
 =?us-ascii?Q?gkKx474y/hbMv6i4dyGJBoENX8T9HhkiIIa9biWbgzCTnbBScuFS0JvNTOO2?=
 =?us-ascii?Q?PZgZvqdX+5Z+xACgIt0TQ+SeuIamToL6YlayN8MV0SgU42dGDMcloSMerVCj?=
 =?us-ascii?Q?Hqw/VsGGzJSmLmUa1iToopKMJAbRxDo5d51lsUd4UqKvajHWw2HMPAi+SbCG?=
 =?us-ascii?Q?CAi3Xw+XxGaPHK/0jT3aSgZUtm0plBJB6hBjnCZ2O+qyzHVcT9w9urH9B/vO?=
 =?us-ascii?Q?5RTaDRn1gUQ2seksKAcebpfxlHL+Yat4I90H/EAgC4c8y7I/Mij8JQOZZgbx?=
 =?us-ascii?Q?PDbIFVvD6RwLQr8Le01PEOlpdH6ySySmQ84MDwU+YH1A4tybnyagNsSC+SDR?=
 =?us-ascii?Q?bSgSgIkQ6zKfKvL8XazNWXOVQyskwmiBZp/6ikyf2w5Cal8788FPM/Gt7v0s?=
 =?us-ascii?Q?RGKeFulcn418xUA3VmP5VWOXgshp1X1gSBpXwoPblB1BoaBV9cIExLxHwiKV?=
 =?us-ascii?Q?1DBb+JAPV+Pd3giaes3616j6RVIQfTxg+PLNvZ702LQqpf4GqknFWyCGfhbV?=
 =?us-ascii?Q?Y9eiGkr20S6FZuktT28h5x3L44Ib90ytjE9uYmOfOwd167jnPlZLXqJmrvq/?=
 =?us-ascii?Q?jxiN+d+j4VA+Kxut9efAasB0Lvqba2YDwhrX1JDCr8jOWEVj1PfSKP9lgFCc?=
 =?us-ascii?Q?iKqnA2Ha9JxmuleBEfQOF/R4CkVKKvFoV+dNUQDkoZr1aN/iR4SfCUMk+A4O?=
 =?us-ascii?Q?iBrbF4ASzfKci+UROMfCGGsKu37FEOl4T2+gwBY4cJNaGoP81jrbYtsJB5oY?=
 =?us-ascii?Q?ej7p+saZjQFsFiXyE5wP8W6vE1KspqWXtDBiBzJeb/Bnpc7pywtOeyMSDs7m?=
 =?us-ascii?Q?iy0iI7LOmZzOD/pGtndebXPSwDp7Ns6t0LwqadV1wfie4HGMUoULHKwTW7+A?=
 =?us-ascii?Q?qKUh7Mx4fOYK+HGkZa1Yg/57zZBBVtNEc/r75b3UUYSWXFCrF5+cPHMkYxeP?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7zJGvQY8zAn5o360XTZF2KAOwqTqSseIODt4EADcMS0lh3h2NVyfxVpLtOrgbEsJpvXk8EsrRW5yTMhQN9oUcMqK/MslEYPBXRUJuL6VofGXxE7XKfcAg9FqHXF3KlrGjyEKWB75l+/zfwVHg3her1LbtwHjuFGHZhexricf6ELiYhce6aWy6WwF4/IU4GFxNjjPhKJ7uLhgxEHDxBzt1dOobHuizCsAkUcvbrtXzMTh/ao2y6ZL1PTtHPM4fUn/crTcnpFUOpjzxIrvG8IHhFhnTq9gD9NshzE6OrOb6enbxDu+F9og7mG79kQpfWpFFjssXM4KTCLoviVW92fJAW2KhC2tlYMA+EjiuFnLP3SK1ja3Z/14Xm3tBrjUlf7CVjVAlTOQqp/+BuN8VF0DaCa3p7nwoxzWaMGnCFMPc8Uip7eZM3TLSB16cslHBuT3L0NenBZJQCdOj6UqLG/QW/hmrwaBOZcxCHcp5lcFgEcgXt3oMUnbWZTJpVyuRqzTWGH2vYtJGNfpGtVsjGvMrdF1dZyrd92kS6npRkME1qsRgblBjYkWfyERK9gGDMIwfVPjLwpJqLWbScowIKObyRfhEj3VQj6G9PwtI/693lknDvAJW/g98cvHFs0kvCpk6EcOMZARIQVUC9ie57jq6YtusmOZ+CRO2WSMiWSlQo13PQ1E13TEpKslNKAYcy2173oAewUTyte/hnG92m3RR5MR188z858pO9U0ewo08PDpsKg9w8BtjHYkukQEEO4V/iQUpmDfEIuL17fwdXPX+C2pU5U6curtr9bskg8DaixPNAH1RZDytl/sHq7GgMHleonkjqAc5oprepk0MzushIYSCyqaKX5kQXC0NCYfHvSR3RupCEKllKOquhJE7Dx+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f83aa8-fd46-4082-7daf-08dba28a7ec3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 21:06:32.0254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EX4ZIsmzMZFJQ6xlSZIba1Etho9esMnEn2U2mlBXmSk71mcmTtnUioxMsmZHQjWw/O+PC1E6cuM31h6y8JeUT0EM9DBoFi/WmcQeyN88KHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=711 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210196
X-Proofpoint-GUID: XFtncle1z7xjYgPvPpWzORiX_So8nXLi
X-Proofpoint-ORIG-GUID: XFtncle1z7xjYgPvPpWzORiX_So8nXLi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yue,

> Commit 4fcf812ca392 ("[SCSI] libsas: export sas_alloc_task()")
> removed these implementations but not the declarations.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
