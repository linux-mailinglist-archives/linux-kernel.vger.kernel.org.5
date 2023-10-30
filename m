Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D097DBC96
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjJ3P3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjJ3P3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:29:10 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305E4C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:29:08 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UCfYei018031;
        Mon, 30 Oct 2023 08:28:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=date:from:to:cc:subject:message-id:references:content-type
        :in-reply-to:mime-version; s=PPS06212021; bh=YoRfuzJfLiR2quJcY3V
        iDkUGDwrkqJFR4LvM5B+FmJk=; b=gowJCg47QBCTYEv/DBrvRZVfl+8KYZ6TBEK
        S/LTNUpbXzzyEBmbwReg0VWCXQxce+kCteeR0IcZjf30otgFHXn1bG1YaLbJnA4a
        ZjAj8QQ7S9LkFmdt2vIgNMqx6Vz/y+k1o1CI3aFr2EwwE8KXIfayAMaYfTlXAjl2
        ybpDCmBf306V2XWW5AO6LejnCp8gOptm/TS02+L91hg35sI03ofPKiiD9Iog0l8y
        ghc8Vpz3gO+LsTB4Br/pJ1oTFar+0i9wSXWqHcZq5oftavoRpHdkK1Nqtjzr68kN
        pjpKzWpHwNb34QVT+hxXGA/dICa+XQmoTJpGXFI7iO3yK/ePO3g==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u0wk0j6p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 08:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq5ECJMGTkqXCNrbE81xw3RESqJ1ATyezxuG1OBB5JD+v7EEHySb0KPDdsie3ua5gwJml3i8WWV2wETcpUdLBcdMcJZmXRPxBD2auu6YBnNCrjzWWPvvS3sPXkA/43bxtT7hyhMiKzCP0a504ezZmRvhUXdFeF5OQNro5lepdOeP/IclIN/BLWZiYUZzmfQFxiBhc9BhXr8IVcaX6FUPZoL3JDUjLJGOEpVq9XySaYOz3nKkRKT6hdrihawJ8oUz4fdjNyLFWfSR/RUXss6+rQ/iTZ0Vncw6rwC5CmFK4bPt88wxQc5SH3imp05qgr9M3A4IuYZcjgiKlCoZMtLMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoRfuzJfLiR2quJcY3ViDkUGDwrkqJFR4LvM5B+FmJk=;
 b=Ugbd1/L8XDQbFU65S3m2lxGvmtdYN57o8Mz/5bpW4jQM7aOmmwc0lGKSB9F1shjXIFaYgneEOlWkCl2btXDH8ZBT35F/z6jqLYF9V6o7VzyfIr/fXM4hcd3aqHJzett+/IBmXORIGV0JYLstjJ1LdHEdQzvadgB0rRb9inq9od7ndl0CRN5sIREYqMaCX9dPricQxT9OAFIfXrT7a5GwxVwEMtlEXzqg1pPRbQ1ngQfw8Ib9604OYCo3eZLnzfs/avpc1gRoaLeaDp3dhfY/x1r5SSPSJwg6yQkIL8+0YBy+Gl5+FTysVNMeHY6ofID0uo1zkMV2k4QUNO1phnpR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by SN7PR11MB7018.namprd11.prod.outlook.com (2603:10b6:806:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 15:28:30 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 15:28:30 +0000
Date:   Mon, 30 Oct 2023 11:28:26 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Richard Purdie <richard.purdie@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
Message-ID: <ZT/Lmj3xAdwvLE7R@windriver.com>
References: <ZT6narvE+LxX+7Be@windriver.com>
 <20231030082644.GK26550@noisy.programming.kicks-ass.net>
 <ba1369810b39f79c0b092151bfa062dd0cf505b3.camel@linuxfoundation.org>
 <20231030114450.GB12604@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030114450.GB12604@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: YT1P288CA0020.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::33)
 To IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|SN7PR11MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: f783f5fb-793f-408f-7c50-08dbd95cdee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qb+I/5KIfeAPuqIYNW3ypkgDH571UwPQAS5rhYHEzBcYXBSgtkw0oP/ra6OE3mDgriwC1+76iRyiIqaebJ1syHMJ3+2usICbIEJNa7AFUnEbshaYACTR3EiHYOSw9Wmv1OyyhBjuu3O/wCxQ5OGfe/OPnR7wIZMfvjObvEbrH1oY4nwXyugs6FjmkSWtmJMu3vsZRnVatNhfS/g0vRDMsmo9rzs5tF9RoYL07N9Npco+AeLN09t8iy9c7/pz8kmHiYY46d7QmatlEmUaCHU10JMuLqvleSsD4cAm6JgfxLZQk8+rvqvMWKh5bLJh0UstYaV81vxBYiI8xjsOqU2iqY5SVwiQlLYqmWcSg4Tjph+iBqRohwFeO0wNo1ouwyADwAVWy4ZwYszUL1sZbauMtCvzLAQDSxLz/KbWZmxET9ZZRGeMvhD33PCqkZr4z2a3drkJXi/U9xSN0wcaiAE8jcmxrbTt8m/piNLaha6b7lGA9KL+h0HiDpcp8XI0P/tC8BBzEEU368lSTdyhCEnSTbRKV4u7r8SpEsnR9RWRoFRI+y6RWGSYCtg53AwGQ1NU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39850400004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(4326008)(8676002)(8936002)(44832011)(2906002)(6486002)(26005)(83380400001)(2616005)(86362001)(5660300002)(36756003)(478600001)(54906003)(66556008)(66476007)(66946007)(6916009)(41300700001)(38100700002)(6512007)(6506007)(316002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVgC+4wuBye3M2YUo1yPfo3TdAGYjqKgwg5pA2JveykxX4SERlgDb9q7sJdv?=
 =?us-ascii?Q?Ut5b3SWQmtWm1opd6pqTQ2Y9+jzAwZodjiX+MqD2J80ogtgmU4kt9I1vb3rH?=
 =?us-ascii?Q?ZttCXUovhNQaulc/6EATnmp55rGyeBVlURUdNCNFI9hOfUQmu0DU8iKVPmYP?=
 =?us-ascii?Q?FJbamPPvCPxOQ1wOSHfdGQIXy92qFK4GC1KBGOrpAN0bhmeG1ZJtslZv/sVj?=
 =?us-ascii?Q?syn/gfBGARmfCXAVhnDcWyk7g8vwOBgq4HKSOfZgS7mAkW63mVtsOwRiY0oD?=
 =?us-ascii?Q?bWohXWI3glIRfG1R0w0SSPnXbWRMaWfOmq3f2q0PNjfEEuFm61A8nF6BRKzQ?=
 =?us-ascii?Q?X5Nc50JRftN/IzyZdlqkGhPFgzuVzLhjgwcNzcZgXwApEiNNaPt54PEd3/W2?=
 =?us-ascii?Q?AzucGu+vQdAzDhjdZAWmDU4nSxnRGALC+AkiH49s9t29/3AuM2ioex434Ksh?=
 =?us-ascii?Q?IPZo7gxhwY461FtXC2siLebWqdi3ZwytpXeyiDnCXPekNCVemUFfBHZngebD?=
 =?us-ascii?Q?X84JeIzmzSCHtNFmkFwULf+8/fh7yBnj7oQuyYMUdySs3rX3NlKuk8GSVHsk?=
 =?us-ascii?Q?JGluRbZhHGbmiRO28GAHwirW6B2O5gwf04y7m2oPtDW54heuuSez/9190z6T?=
 =?us-ascii?Q?WM8EF397HnUQSpkPpEgVMTsSybeqeHkhT9iL4jghVXTp/WpZdmBWg9fSWwSk?=
 =?us-ascii?Q?SHX7cWRLIFMhLCXs4zPcCY4flFW+NUMGzMK4ovbi0ihwhluGy+gdOr4pSPF4?=
 =?us-ascii?Q?3fs2orclFXdCVfyrZ/0x8hSZSXOveblxZYtUGr/k1n185nFfizvPVZtNBLgb?=
 =?us-ascii?Q?gezZ3BB6sKOx5cGZH52UlkyoxH8uAdQnbssllzIPLFHY/UO5vgrrSQ/0X/sK?=
 =?us-ascii?Q?L9BQldxhloSLWbfW+HRo/t7DgC+pgIQ5eaQVB13UAQy+s+//+eqQV37P6/5X?=
 =?us-ascii?Q?ndMZgMJsCB/eWnZ2BBpkPtqcWm1kdQAt2RzrmoCm9bl6ClJi1liq8qyxLNl8?=
 =?us-ascii?Q?DiRV5tlNwptnVCflayAl9Mk69STiqz1fToxx+025TNqv5IPcyhoZV4URxoWD?=
 =?us-ascii?Q?o1Cxhxn9BOUunQ1Tw+KycB+KdYvcwKLrrbd8nSq3zIWIEKeDvGz5OudnE+IY?=
 =?us-ascii?Q?6oecaH/t2xyLfo7UvObZuB9mgIhPbGU94HTfkal2fYidfyCUsc3Sd5GiQ32R?=
 =?us-ascii?Q?ESJyhX4eqrJc6AYM2Kep7ZMuzzlIlQdbGsc/e684IBRDq88l+1CdcYdN78fc?=
 =?us-ascii?Q?eLlbi68Vtb1VPyEaIPz3qoQ26Aov2CrgCBMgt4qx083GS5ONhbJMD3Ux46rY?=
 =?us-ascii?Q?30ZuVIRGiI7vfvCOF1nfMAJuEvx72PVu9960KuAkzQxCab4A+ANLZJ5eBnVf?=
 =?us-ascii?Q?NHWR3cPDCBLdnx2b23Guig04WvrQzA+RjA8PyDheDN+dAE763bpBM5gFXa1A?=
 =?us-ascii?Q?EUuaJWM/pH8xHgkxcGYmAms52tIj/M1WMHO3dpKvffHR5G1zDC65Yi3GcXkV?=
 =?us-ascii?Q?oLv861v/S/AlAxPDLqM1Wcx731CMHHpGNv6DtwvHQ7opC1l1w9zU2lPio+PG?=
 =?us-ascii?Q?GfS88e04pMZfUEzfzO8Q8I22oEhSxp+Jhql22Q1pOKw+6wLeOJV3U2LmT9TP?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f783f5fb-793f-408f-7c50-08dbd95cdee4
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:28:30.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NM5//z56Yv1stUztBcVgN0ilXH6X7Nq6mrDXPTmN070gjEXGzDEx12muoEm0RpoH4pQ68JAwcsZ6Nifx64uw3bTkaP65Zfn0cp4O+Ojqsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7018
X-Proofpoint-ORIG-GUID: _JbkhNiQLyIrUcwZQHqICTWCrMgkzbpT
X-Proofpoint-GUID: _JbkhNiQLyIrUcwZQHqICTWCrMgkzbpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=747 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2310240000 definitions=main-2310300119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128 x86/alternative: Rewrite optimize_nops() some]] On 30/10/2023 (Mon 12:44) Peter Zijlstra wrote:

> Thomas was looking at this and wondered if something like the below
> would help?

I tested this on a vanilla v6.5.7 baseline, for lack of a better choice
and got six failures in 136 boots - everything else unchanged - even the
shell instance that builds the kernel.

Paul.
--

> 
> ---
>  arch/x86/kernel/alternative.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 73be3931e4f0..fd44739828f7 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1685,8 +1685,8 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
>  	} else {
>  		local_irq_save(flags);
>  		memcpy(addr, opcode, len);
> -		local_irq_restore(flags);
>  		sync_core();
> +		local_irq_restore(flags);
>  
>  		/*
>  		 * Could also do a CLFLUSH here to speed up CPU recovery; but

rp-qemu32-v6.5.7-tglx$while [ 1 ] ; do date ; ls -l1 qemurunner_log* | wc -l ; grep  -l   _common qemu_boot_log.2023* ;  sleep 5m ; done
Mon 30 Oct 2023 10:29:57 AM EDT
22
Mon 30 Oct 2023 10:34:57 AM EDT
32
qemu_boot_log.20231030103001
Mon 30 Oct 2023 10:39:57 AM EDT
46
qemu_boot_log.20231030103001
Mon 30 Oct 2023 10:44:57 AM EDT
60
qemu_boot_log.20231030103001
Mon 30 Oct 2023 10:49:57 AM EDT
70
qemu_boot_log.20231030103001
qemu_boot_log.20231030104722
Mon 30 Oct 2023 10:54:57 AM EDT
80
qemu_boot_log.20231030103001
qemu_boot_log.20231030104722
qemu_boot_log.20231030105036
Mon 30 Oct 2023 10:59:57 AM EDT
89
qemu_boot_log.20231030103001
qemu_boot_log.20231030104722
qemu_boot_log.20231030105036
qemu_boot_log.20231030105809
Mon 30 Oct 2023 11:04:57 AM EDT
99
qemu_boot_log.20231030103001
qemu_boot_log.20231030104722
qemu_boot_log.20231030105036
qemu_boot_log.20231030105809
qemu_boot_log.20231030110019
Mon 30 Oct 2023 11:09:57 AM EDT
109
qemu_boot_log.20231030103001
qemu_boot_log.20231030104722
qemu_boot_log.20231030105036
qemu_boot_log.20231030105809
qemu_boot_log.20231030110019
qemu_boot_log.20231030110615
Mon 30 Oct 2023 11:14:57 AM EDT
123
qemu_boot_log.20231030103001
qemu_boot_log.20231030104722
qemu_boot_log.20231030105036
qemu_boot_log.20231030105809
qemu_boot_log.20231030110019
qemu_boot_log.20231030110615
Mon 30 Oct 2023 11:19:57 AM EDT
136
qemu_boot_log.20231030103001
qemu_boot_log.20231030104722
qemu_boot_log.20231030105036
qemu_boot_log.20231030105809
qemu_boot_log.20231030110019
qemu_boot_log.20231030110615
^C
