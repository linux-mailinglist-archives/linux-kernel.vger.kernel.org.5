Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7458C7E51FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjKHIaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjKHIak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:30:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF381715
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:30:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88JxVX029132;
        Wed, 8 Nov 2023 08:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=baZUkrWkZa0jVuImrgCCGcF8eXi8+KxLHPox5asR7sw=;
 b=RUuc8c9jYRPy5DH+LAR4tHCZWrzD/Ag+aovM7vtuASo3quYzx8IGWyArzg70envqKp3w
 jXgPLzlzq3/nhfeAQmE2ExlqQHWPE77VUhs6m2VWE4tkzEX+RuCrs2fj4RW8rLzlAJSs
 95Kg1xroWZJtTJ6Bxwx+uAVeLob8QmNmsELKiF15pSXOh95uQY6a5PzVew6FQJQ1rjaG
 0j+A9LiUJxp2wgFHcw9ScsgKFXgyaMi4C/wP7u5eH54GO3EbEKLMaGwhljpXLzMRUH4J
 79gWdfL1cYNcSGRWWkox7WdTg1wEz7h7Z48Cr5HtsR92ZQnFjr19SYvx+d8P7Rim+fVX aA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w230wh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 08:29:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88CsJc000440;
        Wed, 8 Nov 2023 08:29:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vvy5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 08:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRxyG1Uwd35plnfgyfnhDAsHsqNFRRm6KUYhjx/ptHa0xNo+nXm72edRnIvqDvlyG94C0dSVryUbyahEJdx87XQl05paEf0HRVzkRk/S6wmesmXt4m7Nzo49eos+1HwXAIRmxWe9HCSmxG3AbB2SjTK8CIGYAB47AZKpEIy2ik9gCG1f0oqdRAAWhdHdhrZFAMQJbY9A8Jjg987yV3Uw7O2a5meSs/BUdwyYAMdr4YgmwLNr+NaGokb7YT+Az7746gRTWppjxtdDv1YYKZEYW12r59PQJByKmVkx9t+LLOtZm0ubyIOxL77mPvcEj7LdwR70d8n525WtDd+KwesbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baZUkrWkZa0jVuImrgCCGcF8eXi8+KxLHPox5asR7sw=;
 b=Icys028qbE3K6k7JUb/DdtyWqqqSvky/TnDG5qTMa9jRgXCrhLFG537kvs2c3ARu+NXuyf2hVzmZ/gz6oQ2BO+pe1jvQatn6JRCmnN4jGkh3EFE6m8OY59guOREpwCODzOB5TPQx10Bn4qrlesFoS4P0chp1JaM24EcLaznEW652GjWe7UTjBh7By9Thl3r4wTWnoUnBwQGfGqdTcwkRQahzgyS3CWoYpQBVB0jPLnkCnYJSi0WaAUtSYZxYOfs1gZ1MYSoT9rFflGL3JZMIUQRh0mNSeQxUcA/fKA3mZzbVKWXRQ5Ldj7NLk3edzDcXJYE8ar2NYRDv0tLMD72hjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baZUkrWkZa0jVuImrgCCGcF8eXi8+KxLHPox5asR7sw=;
 b=J4OeMndNJeFk95RGBU3fEh371Ot4uhuOFDuHXxs7k9V4MDgbzYUFAlsSUwpsd/i6g0Dd7TmtVcaHsq1lqw4wg5AYQDS0zZy8N3yQNC0oqaY2IB4KZ159I6uj4IWaf+r+pg0qbgNDybqxcAKSq0+ost3x/amkuFRUtRoII+KzhuU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB5648.namprd10.prod.outlook.com (2603:10b6:a03:3e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 08:29:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 08:29:11 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <f55cbce4-42c6-f49a-482-88ec7b893dea@inria.fr>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Julia Lawall <julia.lawall@inria.fr>
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
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [RFC PATCH 57/86] coccinelle: script to remove cond_resched()
In-reply-to: <f55cbce4-42c6-f49a-482-88ec7b893dea@inria.fr>
Date:   Wed, 08 Nov 2023 00:29:10 -0800
Message-ID: <875y2cr6ll.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:303:b5::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 4393b0dc-0783-4057-c0a3-08dbe034c8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDLLfNNezpLSabxFwUzOZFx+G9477+gAg4h4si+QN+nt9wcGrkma4jJUrnoU4pwn8DhI9sx0f+ImXA4xU2Ci0DmApSKv4kuBJF6ro077PaZS+tAbVxX7w6oUsEcJzv9AZshovOVZZ5h6xi/r56K+IrtFrj7wM5i7dtDvP7fJnO+Ceu6Ctd23xGU5Rz3bLoyzDJNE0sVPuFCJpfOCW4ozBt6vRrP3cHigil/8NUbuymnMeFRPTVM/myRMSjtJd0gQ7dfXD4ygHrjBdogWhglNBbuXgwb2CokyHb3xZsum8OGaiSBdTfCgDcRzPsTpbG40BNiXP69pS5r0+CLanUYQgenQQc6vRuXdNyZ/gG7bi/bu7uQKxLJYW8doJxh2cHV/rvd+4K3iH7ZD1D5N5EgsdUbJBmcw522kNCGUO3iZHA3TqfvcP43LfFUBsaPM8+cFOENuQZIdgFyQkFgGr59He/Rbm7lhMNtS/95SjFIboSH7sef6RTi0GCyVicVZIblOYRrW8bCpBZYTgOPiW3IEbGG43HLFWzpp0KaE7kqxWg6hOOSZNjKCPQ2wS39Uf99W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(26005)(41300700001)(83380400001)(5660300002)(7406005)(2616005)(7416002)(6512007)(6486002)(6506007)(36756003)(38100700002)(478600001)(8936002)(86362001)(4326008)(8676002)(66556008)(316002)(54906003)(6916009)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0m7xxwkBqlApH5HL9c6jme/ZEFGFWX/W28Ud7/2eG64yYpgMmCYJwPCg8T9t?=
 =?us-ascii?Q?1wtlyELAzSkc9aQ1+WYqYXIIyi7UDg9QoWHu1cptDPcRVddEeiC1X7Wj+DWQ?=
 =?us-ascii?Q?RQvrs1ZgdD66MwVFw0xxyieWz+oao8F7iPrVsG1vjCbxvjYbaajy46XmBgmz?=
 =?us-ascii?Q?rUIZscM56/iirzLecYAOH43S4YHflnSMK/7lgyfTUAFhM/TsG4WBWPE4NpCa?=
 =?us-ascii?Q?FwPauuBOvpVM/844cdAadvo5FE8UCHuGtUTcS5kWjo2M74KUH95ywsijz+hK?=
 =?us-ascii?Q?aVZ28D/ZMjA7pBf7zdJRdWWh6u7XpTSqr6ghjiW9+vS6FqDXbuYVJtWbaToK?=
 =?us-ascii?Q?6bPOfuvIs/As+4x1DJ94iTbfvALvf08VhKKe3hqHoiC4vBjsEaM9ExfWbxoL?=
 =?us-ascii?Q?dyVgwrory16mpkT04GGQt5YAWTw1EQWRj3AqAb9M7mkIxI3azl2QTUVwqRDE?=
 =?us-ascii?Q?GlUVa8bj/6fb1/e7d7uEV4eb0SRpLt1BF8erCtNKZMff3aBX6Bho1X0y2ckK?=
 =?us-ascii?Q?p9N/mr8BAcB8AaigcpQbXbIHfUtOKut4abfzsqoFrvuWOCLBwKVtedFKHKwh?=
 =?us-ascii?Q?aYFcz5I3MWS8lfoUWfoq7uqIkZy3z6qOt2B3PTfQ+8PmP88nzv/KizV2Kzkh?=
 =?us-ascii?Q?Alhxwh6eMjIR/3neSM6iY4rYsGc+Tq+K2mBETSuCyw17vv8hPwn1j03X/7uL?=
 =?us-ascii?Q?Nq9dYKLmGvUOLa8C8FMA5eBV2vMbmkcqrzJWFk07FwkxnasodNy05NaWmGBD?=
 =?us-ascii?Q?YNuHVj/kyXF8YYmsW+b5DUcFZxj4OhFUHF+jV5Cp2Se0gaCFXSe6uvg3bOBs?=
 =?us-ascii?Q?DePt2K30wWhMDd/NViNLaiPcm+Ctt+x8BrrbNU6yB5TLaS1+083dUtQ0cPuI?=
 =?us-ascii?Q?/7KfV2LUFES6u0RDqq6B/43PO6Lr+ujy7uIV/p6VRrmpYp4teSR99dLF4Ew6?=
 =?us-ascii?Q?Meu5QvFBBAv6BCDkNIFeNAYvmcQ7o7n3pDpzejvAGL462RKDEIHk/4F79pKx?=
 =?us-ascii?Q?mBWOsAE84Ax59vX9EVVjhZqTVAkcxKXqNiiF+DojIgneS5iV4EUFczE+eh/H?=
 =?us-ascii?Q?Nxmq054kqA3jYhwXOsoAGZiS7oRsm9D3UDB9JWDr0o/y1UKK0kEFn5li5bmQ?=
 =?us-ascii?Q?LXWzAfNgNdk1hvvUeiGoe6ZNg6kD4QR4TurtRXnSQf3KviShhNh3VbzCA/Wl?=
 =?us-ascii?Q?9gtE0SVHLB/yOtas9KDAIB8nd0et8pyRT9gxODTYbilH7AnlY81FH0nsirFA?=
 =?us-ascii?Q?Y/mBRD3cLTtx6VOEixaWHGG3YXwZ6V7R2wwGmamCI6uk3ajwajs6qh4fUG8C?=
 =?us-ascii?Q?X17IaUPiba3MSm6Fxc+6qR4Fu+HsIT0QEHKng6pvS0ibey6zH92PPVTCkFGq?=
 =?us-ascii?Q?+RGlZELGPDO/54PaLxPjT7LudntUei2IWJkOTVgoC8MSOdyPj5Vh/QAbCpGo?=
 =?us-ascii?Q?2suTYdyF8ZP2yQRYwqJXqCJAHpG8u3NC51fNSf9d2meQxLsOF1ZhUhDwM+eg?=
 =?us-ascii?Q?hJUAbXWKe5yAEQhA+2hyKG4nO0UNn+vVtiRooT4TcU8+8tSEolpTnMHDuc2M?=
 =?us-ascii?Q?e9XiwiZMQ0OT8huYYXXSaXCGbf1k/rCxn5FNySVEMy30IvfFi97N9tQHTOEU?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?RYY+lU5kKtxhhB5uy0P6wF5TOqcqvqWSz96W3vvwbBRncsTtFqdgarYDtBVu?=
 =?us-ascii?Q?0p+EQyy4o1afpsANYBGv271ydvuZhuZeQ5MPVLuWPXSFOgfF+CmeQ+ZABtEL?=
 =?us-ascii?Q?0kRfyhGU4QxMqwNMZujFzORE1muXQT4xnXMK0j7hrSQ1M+Rn4loqbmQxA2Pk?=
 =?us-ascii?Q?hpPbTUyB80FLpjc7/6EYJrbnzITRKntMc4bX3AtKxvVAYVY8CIUvAu/ZB+ky?=
 =?us-ascii?Q?8dsXL4fwxUANfcHBl3BDkffHOzirWfeScBLYxIxL11wbOCxmc5CH/CUNDp+Z?=
 =?us-ascii?Q?WT/MYWE3D1eJXw3Stn3TltF6ppXna3mOCSUP6cr2RK6jAWAF6qjmTt0xtBDP?=
 =?us-ascii?Q?J9f7qNRpXrrSSoLQryGocgBZppDn/boZDX28jyHINkJ7AW7yWDGtrGJTqcQe?=
 =?us-ascii?Q?S0Eza2dw+Cl2P2eDIUsObe2Lk020ItcwftrHK2lioFa8rL7mZXJXMnfVzaeF?=
 =?us-ascii?Q?MM+IejNxgxLYHurXGH1cE25A3tBp0Baqr0CETZfv/sopwAvwRikYm6QAVcYI?=
 =?us-ascii?Q?o1Xu3FoZXvwGe3cGESUTnms2oFGQF4F3k0M+oVLS8syns3oj0ZEkN2kr5HiW?=
 =?us-ascii?Q?deF+001fJVxzQ5+RGSHZboJlumb1K0d+WlwT9fFuyqXdf2mwTweY8B/nxN6L?=
 =?us-ascii?Q?qlZpfSJ6d+7Ip2tNPC4kBsDT8hM03A2SONDVNQIRR8YQYZECBFABtEBRT/eJ?=
 =?us-ascii?Q?gAjdh48hvbf40I/jeLUnkc+N+NXyPhlxJ45iXRi43bNdISuc8K7u60bl0nb6?=
 =?us-ascii?Q?GGuQy4zGROTqIieYskB1dhRyDt9JYbEcOPKZz3+FYpB6bwQJGt5dYFo1NkRv?=
 =?us-ascii?Q?7HS3JOs4UgLM2zZsjMMD1mmW7/NakxF2L6uu1a2ztEcgs43olmTAA1nVs1dw?=
 =?us-ascii?Q?0d1tAUzP2y+h0AS2JKEE1kRZXQI67wtdcr4FNJDXNHg/dhjrnJwszvN/JxIr?=
 =?us-ascii?Q?/qkNQn4LpPFTrQLIwBrO5uBhW2zCRQ0ZWTjeyPImVlajPxB4cKLVt5CHypQB?=
 =?us-ascii?Q?TE5Bk7enS+XXvMYbCTOJ0ua0eLEZpQ4LXKCYK9fWZ/TnoQKDyC7oo/njsDva?=
 =?us-ascii?Q?5fCmVHu+xctOoHI49jw0DeipnrGXhk7H5pusYPU5R37k7It2mTKknL7e09ta?=
 =?us-ascii?Q?ZDpHYBh+YTIvKEBXTSSzOfBtD11QcT/LmddHstgvdTr5bzRyfZEOEJE7pn5L?=
 =?us-ascii?Q?VAZS6EtISYqv95hRDdYgPunk7CaY4AyYmS5ZNcSXUAhi06MaxxNnGAOd3Blo?=
 =?us-ascii?Q?xz/XEIvWvk/UdQVJ8WHWPcXXIKDhE2dHYlEaSiDVtCEU+NOnUc3nCj2sRutY?=
 =?us-ascii?Q?0zWC3KsKy5FFbLsoyRN8qVZ3dziYWb1UUvwwqMdWqALtmlynzk76xcb0gVIi?=
 =?us-ascii?Q?Bd6tTekKODN5Wlx3DXh2phLfeHgyZjDUXyW4AuMtI2sspGMfzJ2Pfi6kVXIE?=
 =?us-ascii?Q?SLkrDUIEvo/RtgwqYYP75lN3I5741Dw73eeOTk9axTntK81K0HsH9m2RNewz?=
 =?us-ascii?Q?IFZfz9h34W312+EaRYl1nUGd1hV9KEd62yCDao7kPo9QB9pWmCTpmiJ4XFFx?=
 =?us-ascii?Q?4+dc+QuDkkYXMiMbUOwEeKiAVef4qCASRubJgiUW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4393b0dc-0783-4057-c0a3-08dbe034c8ec
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 08:29:11.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMEw0InByscWU28GvJnFbXIx4mE5Ls6k4EAmhbd19DV9nnq5ItKis0skIt3nd0dp9hL5qpJXvRdKbYZ5a0kd92q9KdjTZbj2SI0QokZ3+k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080070
X-Proofpoint-GUID: -M1-knBjHyC8IqlEtclul-4OPHpseJWN
X-Proofpoint-ORIG-GUID: -M1-knBjHyC8IqlEtclul-4OPHpseJWN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Julia Lawall <julia.lawall@inria.fr> writes:

> On Tue, 7 Nov 2023, Ankur Arora wrote:
>
>> Rudimentary script to remove the straight-forward subset of
>> cond_resched() and allies:
>>
>> 1)  if (need_resched())
>> 	  cond_resched()
>>
>> 2)  expression*;
>>     cond_resched();  /* or in the reverse order */
>>
>> 3)  if (expression)
>> 	statement
>>     cond_resched();  /* or in the reverse order */
>>
>> The last two patterns depend on the control flow level to ensure
>> that the complex cond_resched() patterns (ex. conditioned ones)
>> are left alone and we only pick up ones which are only minimally
>> related the neighbouring code.
>>
>> Cc: Julia Lawall <Julia.Lawall@inria.fr>
>> Cc: Nicolas Palix <nicolas.palix@imag.fr>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  scripts/coccinelle/api/cond_resched.cocci | 53 +++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 scripts/coccinelle/api/cond_resched.cocci
>>
>> diff --git a/scripts/coccinelle/api/cond_resched.cocci b/scripts/coccinelle/api/cond_resched.cocci
>> new file mode 100644
>> index 000000000000..bf43768a8f8c
>> --- /dev/null
>> +++ b/scripts/coccinelle/api/cond_resched.cocci
>> @@ -0,0 +1,53 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/// Remove naked cond_resched() statements
>> +///
>> +//# Remove cond_resched() statements when:
>> +//#   - executing at the same control flow level as the previous or the
>> +//#     next statement (this lets us avoid complicated conditionals in
>> +//#     the neighbourhood.)
>> +//#   - they are of the form "if (need_resched()) cond_resched()" which
>> +//#     is always safe.
>> +//#
>> +//# Coccinelle generally takes care of comments in the immediate neighbourhood
>> +//# but might need to handle other comments alluding to rescheduling.
>> +//#
>> +virtual patch
>> +virtual context
>> +
>> +@ r1 @
>> +identifier r;
>> +@@
>> +
>> +(
>> + r = cond_resched();
>> +|
>> +-if (need_resched())
>> +-	cond_resched();
>> +)
>
> This rule doesn't make sense.  The first branch of the disjunction will
> never match a a place where the second branch matches.  Anyway, in the
> second branch there is no assignment, so I don't see what the first branch
> is protecting against.
>
> The disjunction is just useless.  Whether it is there or or whether only
> the second brancha is there, doesn't have any impact on the result.
>
>> +
>> +@ r2 @
>> +expression E;
>> +statement S,T;
>> +@@
>> +(
>> + E;
>> +|
>> + if (E) S
>
> This case is not needed.  It will be matched by the next case.
>
>> +|
>> + if (E) S else T
>> +|
>> +)
>> +-cond_resched();
>> +
>> +@ r3 @
>> +expression E;
>> +statement S,T;
>> +@@
>> +-cond_resched();
>> +(
>> + E;
>> +|
>> + if (E) S
>
> As above.
>
>> +|
>> + if (E) S else T
>> +)
>
> I have the impression that you are trying to retain some cond_rescheds.
> Could you send an example of one that you are trying to keep?  Overall,
> the above rules seem a bit ad hoc.  You may be keeping some cases you
> don't want to, or removing some cases that you want to keep.

Right. I was trying to ensure that the script only handled the cases
that didn't have any "interesting" connections to the surrounding code.

Just to give you an example of the kind of constructs that I wanted
to avoid:

mm/memoy.c::zap_pmd_range():

                if (addr != next)
                        pmd--;
        } while (pmd++, cond_resched(), addr != end);

mm/backing-dev.c::cleanup_offline_cgwbs_workfn()

                while (cleanup_offline_cgwb(wb))
                        cond_resched();


                while (cleanup_offline_cgwb(wb))
                        cond_resched();

But from a quick check the simplest coccinelle script does a much
better job than my overly complex (and incorrect) one:

@r1@
@@
-       cond_resched();

It avoids the first one. And transforms the second to:

                while (cleanup_offline_cgwb(wb))
                        {}

which is exactly what I wanted.

> Of course, if you are confident that the job is done with this semantic
> patch as it is, then that's fine too.

Not at all. Thanks for pointing out the mistakes.



--
ankur
