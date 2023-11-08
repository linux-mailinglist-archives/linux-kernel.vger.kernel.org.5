Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA1D7E526A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjKHJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjKHJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:11:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE7E9F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:11:30 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88tgsI015927;
        Wed, 8 Nov 2023 09:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=2O5oTPWeu0FvYRwmW/rStfRD/ckaxV/jEPslvZmrun0=;
 b=brYNOq/oNMPwbEbS+DBaJGX1vQAuqBSRmSY62k67fjRAqtcTN+64YrAcnOOed4vW5fYq
 Yk95+Nb8rx4cgZ6B+x4A3TBNO/SsRbliNg6aHnFPeldR66p/tFK0FsizTzGfNXWkwkJt
 rP9wklPBiO/HhiulmZCDf1kJQNOUhg/FQAoZjYcwI6IVyYCKhcr4/czw7ZtXnFwbLUWZ
 817y3UY8/1mTqPjZ3ZiBYF1Xfe3ivPEs52dzWT8+X+HZ9jgu2smBb/wmG2Y+atpRtT2x
 xcGGAeUeENkzLy+A0RL5A8f7XVthbISTu1Ux0utFzgZb+ZPdOx7BTOQCsQ0a8HzMc4jk qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22h07x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 09:09:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88GPRX000664;
        Wed, 8 Nov 2023 09:09:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1xedww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 09:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEboro5eITI2/bZyY4tLqSGGFjooI4OFquFq3286/8uwknrTorpOyq+m1o8kP4/7GiZGlyC64Q1W6D4RtRnpkThdQqMnUINCuVX09gWMJbHP2imeQioTiEoSY33IfzNf35F0HPbDrF8b+6kajp8332cltU/bcSAWTI+u6mDgxXDUhdcwTiFd4hIAUbxaXAv+OwPvoJ8a1HvHfNFM9mItsMermPVLsmycc5jk49aLkbSiDkJm853lSF60LUjnM5UCAClvICjdNL9s3ey8Bn5IS3ySg2VvEfmX1YvqhrgVkyLa5Q+tBlkQJCqSQpNKTUI5s3s2nRnxMfGQ7N8xLs4ZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O5oTPWeu0FvYRwmW/rStfRD/ckaxV/jEPslvZmrun0=;
 b=QHcSx+ay7nKQ1/khXFfmQYLzY6AL6LZ81MDL/dHCOVzauat1zYtgmaQuXV6g7U0GDgW15NKusqilVTqRshq+LEQ/+b8xSh6d7n9ymzgrFUdM6J9GdYK9wKigm1vuBMYv6Y/KAW5EWHLfWkBdvhTBSSAu5bZvic2hKDptlaB6URbZAFWrA4l3EqkFI2sjA7usAvTv+OCzS2PMk9aFj8NpsGIOYumKRY2TQ3q0UpCT5Raj3Q3bzUEx+eMoEhsNwJPJ/Xsl91qebQmEdJuMXjY++Uk6FELbHzxrP7cwIVgbo+c+3H9Hzn8Wy8gFPxmovZBO4EGUREA5OgojisNFVoAa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O5oTPWeu0FvYRwmW/rStfRD/ckaxV/jEPslvZmrun0=;
 b=Ecc+N+FYWnc/ApFcA/RBTleAHxRnKR5fYc6EuT6wX7YunNKbdLudwGJBueVG4lFXJh/7AmuKkUkKV6hsNWnVMf/CwUaRUtG6KGkTYYTQwpoOiofAz1GNY5dKrt1W/221u0y3HTPZI1Iu8VdHl19/b7uOmm61wwblKujFjxsUVZ4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ2PR10MB7810.namprd10.prod.outlook.com (2603:10b6:a03:578::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 09:09:13 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 09:09:13 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-7-ankur.a.arora@oracle.com>
 <2023110801-bondless-disregard-795d@gregkh>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 06/86] Revert "entry: Fix compile error in
 dynamic_irqentry_exit_cond_resched()"
In-reply-to: <2023110801-bondless-disregard-795d@gregkh>
Date:   Wed, 08 Nov 2023 01:09:10 -0800
Message-ID: <87v8acmx1l.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:208:178::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ2PR10MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fe229a-6b7f-4fd1-8649-08dbe03a6048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vANECxY2RF0bAtytAs9zG36zN0kjDVYX2Ed2GfICpEdMrOvRBBxyOorwDkQdgEOeRc6n633Af/FJM+JOgO3laCQ3w4IP83SAQrU9BiGhlSnOuHyQ0/NBYeSAvl+iDoGsgLbvr5fzuDnvVC+CaPwyl5bIpLMW3nN6vKBfAK3Obv60DmrKB1Q6qbalMa3llpdlLGuOt9Rya4JRTw6F3FJpFbaj2g/efZfVZaJOFnK8AM4lQQXlGGTYBvHZ4RGkk62y4Coyiieol3V5kilGKcBm6VzOi7f5hOe6FQTuIwxgiTcHMBvh9uSPUg3ei+b8EvNbgv2YgRr0YYhpwuqtU9S6/LCb32zbZdod3+ob/lav5Yzd/kNbiRAPv95Izd2dKieFz/BZD7uFi/PB2sNOsjUcOMpTR+tIVweOCnmpgd9p13oJkLHmhAn+ViTrkxDXPwQsGWX6I/tnc2toKiSSF2KhEDOcO3lRlJvrYMGroafq34F6tYnOkXcQK3hBupgODAsX9ClEHWLfmpXgPs3pyHgXLEsok8fOxSuzgz1KGxEPy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6486002)(8936002)(2616005)(38100700002)(26005)(8676002)(4326008)(6916009)(5660300002)(316002)(7406005)(2906002)(7416002)(41300700001)(66556008)(6506007)(66476007)(966005)(66946007)(478600001)(86362001)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zz1gR2nL0LQklQELf+KYqFyt85nOGFQjqeaThHB/oJo6kN6NS8Ps/o7WFOEi?=
 =?us-ascii?Q?9g6W2CVtBTCyKgNNU9I+wiWEVEoREJy1V4PvP/MiMujghuL39jSl7wYkVUcf?=
 =?us-ascii?Q?cspi4SO4c79TRpvkXUkderPhx86ByLfASrkYow9/nBNOC/h+e3lSwKnGArRM?=
 =?us-ascii?Q?k7FQdhyCTjBJBv4Q90fk6NyAcRdqXmnI4kYa/wL1ybAaZZIRXuYI2u2eGwPn?=
 =?us-ascii?Q?BmHRs3Ooo+3DLbhC3bvFcWA/4ZRw+xRpYQKIyCTZjSmPTh59lIP7nq7YjbW9?=
 =?us-ascii?Q?qoInGJ4g/6RQKVwmjKLk0UlQ6NKGR1yNBS+qNAOnPg8wQt8ppLr7WREo0ep9?=
 =?us-ascii?Q?u15HWKietpqxrUEDvDOUtMsIkNPWZM2QhIPJDfTVAvpIaDWfWElnrUxcCMsg?=
 =?us-ascii?Q?EEi7CrnVJER8sn9wd6+/PnzDYg/GPcZcpsqxgjDq9K/oAd7G9kKAlCKpm8Xz?=
 =?us-ascii?Q?wbUvVplFmZCk51iS7cFAKAPktQ63Ynv+vAkCpuHlZvLl2cNlaL4MphAAh27K?=
 =?us-ascii?Q?2fcGHUDRaubrvRoSVUo+IbysjlmK/eSOmXRDb+4Y/obZYlOTtMQL2eW9fNwk?=
 =?us-ascii?Q?wIvtSqHkHC1tlmgyXcTawjQL4PG0eDUb6uU7RH+uY11PlermVsLcC8TF16ag?=
 =?us-ascii?Q?lPQrHziNTefFbb1LcYZm8gcDOraCfKTMT3KpjOa2g7u8Q1CM3BDgRsfyZrl7?=
 =?us-ascii?Q?xD8nHFlnH8Qm7DmuIbYDHtdH2aKNIWTnNbB7nwOp+UwNtm0GoDKlIDOG5b7l?=
 =?us-ascii?Q?MNTgSdsmCTZMTwO3/9zWcnIZ+8xGivaw6BTCDUQUcRFlSCsBgBYV6i+jKYJa?=
 =?us-ascii?Q?CDJBOHl59Q9Rt0P7SYXmMQ48gUHZci89jINI+jxH3bkWqa9Oi4RzlMx2F5ir?=
 =?us-ascii?Q?qgMS2bLk/ikpdy9fEm1kaZCfrBz+nTu/BHeSnR1OKYxYsEaaNsMym+eZTACN?=
 =?us-ascii?Q?aQ7DG+5LJl40kueG1SVZLRZSQbU5Zq9QEjsBaXCHsCf8JQ1/CN+EhiXibYtX?=
 =?us-ascii?Q?lCbkv6/Wzh21olL3XMXUjvoYyYmK0flDZKNr8VCmWuGJdcR+8hC5qr6baMug?=
 =?us-ascii?Q?doQjMDylN+0PNCtgzbWsqbs+wXRb2HglmCEj/jHQwOVvHDmedKRstg6LSOBP?=
 =?us-ascii?Q?0DfvNh+BlF1tsGH0FWUERxQuLQB9JG+nJjfVC/w8fzOC4+Q3hmga7sLYW21K?=
 =?us-ascii?Q?IAQcrxNbBMc589FpQeD1anVceBgEdE/wOFNDlOMykk/lSNFE2YHN+iOsvtSf?=
 =?us-ascii?Q?oOdvayfcHJzdZmjrcUf7F+dhxuxEsym0fVGoHOT0R8aESKz8Cet7LbCf8gHL?=
 =?us-ascii?Q?xs5j+nzWxLEXi4rsPtaD/ejZ+eh2kjGpKZyztSbRrGF+GQTkIdPqzoh5vrrO?=
 =?us-ascii?Q?TV7jb7I+f5vhZT2xNqUyvxLPOepnPqMoUHxi4Z6jtagDSUVPwU/ai4XmNGHi?=
 =?us-ascii?Q?3DmM1hxj4F6AQOwMsF4VhulMeoQWWzS673ckq6lZ+ifWuKzxNfUdkdeJ8STn?=
 =?us-ascii?Q?Wu7ssBgvujMr01OwJvVaYAl9R06ikFFxBNrBd/d1SKZOB6nJsrFcqd+wC0iF?=
 =?us-ascii?Q?gmM/hV1aF3UUy7H5Z0lp7WVyzLxz0pgVZCLhC4CJHXTqEqkrByZNYeoA3gu8?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1h1ZmUnNAYx4z7DwOD5zcNVpf/8VNzS4hGfLLiJbIt75cRHr6VkStfbSYzC/?=
 =?us-ascii?Q?doV58iv0QjTi/Jnh40ZcfzXi0ewyvHEUE0PesZ26Dp3et2jdBlLHSjaw0gMC?=
 =?us-ascii?Q?jE8xB9x08K5PhsUMwRd/9anEoUqib4csnivsOel8WV3zMKbxstyUk5BtHFTw?=
 =?us-ascii?Q?yiT9qCu2KHuaYrxeBcyu5uZqK04AY6nh07By7I8mtWKvuBkSA7l8LV+mOLno?=
 =?us-ascii?Q?kqjWI2Gu/6BP0kArNYT100KSlzU8+GLdNyKfb/bIHbLZKU52aHUCfCZaMC/c?=
 =?us-ascii?Q?aapiaXmrh+0HGzO0BKoIwHD3+A9AkgXNWHha7rW0qCjwjMqE2pe3S6kt162L?=
 =?us-ascii?Q?Su8noE+bs1E8+11k8DjsamKs3A0pF+6/LwTAfRZFr7P+bcz1pyBGZ0derPsz?=
 =?us-ascii?Q?fzaH27A/YmfuIt0tsSXdEWyykOTP2HJZRQCFWV5xh1FgToSQyAM4jMraaz2d?=
 =?us-ascii?Q?+gG8taIke89Mc8IBNfgRq+YbdemYUjyxd5I90lE/gtreeYZlnT4mbaCIRkzd?=
 =?us-ascii?Q?MoFKZYgPy8FI1bWJIMjRvGXxIkyDfskJhcSOj4VfbRI8msj2uu7VXQBq//Wn?=
 =?us-ascii?Q?GmYeXV9xy6JjKIeAKEXnQzc49NgMjqx+zVu4AbDTt/8P8IECLduBoTUmvLGn?=
 =?us-ascii?Q?2jpnscIft6aYhSB6VSewNLH8qcaeJpv32CzKCYihgYvHt194JexxobPgTeW0?=
 =?us-ascii?Q?iWQpJTxYdPqhVEJkaqCKF3N/yH4OpRC9KQkCvH6FhfAWNViiX7Du2OSuWZuJ?=
 =?us-ascii?Q?DQDNsV5ZC+8lGy1NNUKEP4q8aNK7bJYqfayOaIRh0KnfWo+G/DtpyW6ltJJN?=
 =?us-ascii?Q?rDrf92QJVKrSt1IHPEM9mqftIvfVzszP+X05IuQvUeQ6AUKbc2KNgaL4WPHi?=
 =?us-ascii?Q?VEnzPyZUhnevoyr12jlBn9uQtJ0AOzUFTDC6B8Cht+FnUwVtLn6PVCxCwVoV?=
 =?us-ascii?Q?U/S5bqb27ydSmS74qi2KGmuKvvnvnUxkE6GlcL0cgAWlGCgj0Nym7F3V2BgX?=
 =?us-ascii?Q?6eqJn9p+v0j16QkIiJX5hVVTI/g8TyPg5ePvZz77HdB1rtLWTa0IfT1TQDIR?=
 =?us-ascii?Q?ho3VXjGzlegllwlzBjBuG1ooHD4K4/K2I84jOawfLB/CYZ5Y60L4UKwWDWNA?=
 =?us-ascii?Q?d4iEWpGwtqopwWeGmofd/alR/nLbAoKAY//nNlOww4Vyio85DOJyBAi2WYiu?=
 =?us-ascii?Q?ardceE5Fwy/nrFw2ebYFB4w4MQ8LM9NZwBnui1F3UchAWIxrMRpjU3YrSYG6?=
 =?us-ascii?Q?K7aYGy4tP5tuwWLGW5aOtGf3ohLEzUGRdlJ7O9fKdezmuP7Si5spKpx6zmKX?=
 =?us-ascii?Q?xuxApmAt55J79+BLCEf/DbsUsfdi0+xQf8l6mgB7M4sTE790CCTVZzX1BQCf?=
 =?us-ascii?Q?XdYupLAEEE7N1qP5HSRoeG9DcWDxvlB1AU4EXR0lREnogHeeKn+zO0cSu56J?=
 =?us-ascii?Q?2Lre+W63lkp7dh/v4jBDDAL5MZGofSLrwsnJ7f+F9O9DcvtR9Ya2CtOlfvdW?=
 =?us-ascii?Q?vZ0j7F33mG19/yMo5q6f7eUyz8JUCRi0IaTSDnmbbV0Etnss/FN+iWhV5ES7?=
 =?us-ascii?Q?mVZkprerkZIKhtMjX/GR+MWBINIACmdloxETtMWQJ7iyutsMD6WGABoWDhDy?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fe229a-6b7f-4fd1-8649-08dbe03a6048
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 09:09:13.2765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ/kr2jv/JtxxqSVocO6viDdTQjVM811Ff5vI0OneWw2TBEdoYIQbYLaMW8wgvfrAaUrWJCR9nQkKrnZgVwwgvB/CcXbk8LfyfuTSLzPuV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080075
X-Proofpoint-ORIG-GUID: sXT2ilJClmhpUqGR4t1ZgV984HBRAM4_
X-Proofpoint-GUID: sXT2ilJClmhpUqGR4t1ZgV984HBRAM4_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH <gregkh@linuxfoundation.org> writes:

> On Tue, Nov 07, 2023 at 01:56:52PM -0800, Ankur Arora wrote:
>> This reverts commit 0a70045ed8516dfcff4b5728557e1ef3fd017c53.
>>
>
> None of these reverts say "why" the revert is needed, or why you even
> want to do this at all.  Reverting a compilation error feels like you
> are going to be adding a compilation error to the build, which is
> generally considered a bad thing :(

Yeah, one of the many issues with this string of reverts.

I was concerned about repeating the same thing over and over enough
that I just put my explanation at the bottom of the cover-letter and
nowhere else.

The reasoning was this:

The PREEMPT_DYNAMIC code uses the static_calls to dynamically
switch between voluntary and full preemption.

Thomas had outlined an approach (see https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/)
(which this series implements) where instead of depending on
cond_resched(), a none/voluntary/full preemption model could be enforced
by the scheduler. And, this could be done without needing the cond_resched()
preemption points. And, thus also wouldn't need the PREEMPT_DYNAMIC logic.

But, as Steven Rostedt pointed out to me that reverting this code was
all wrong. Since, there's nothing wrong with the logic, it makes sense
to just extract out the bits that are incompatible instead of reverting
functioning code.

Will do that when I send out the next version.

Thanks

--
ankur
