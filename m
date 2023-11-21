Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073EE7F25D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjKUGgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUGgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:36:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE70F9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:36:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL6YKel027745;
        Tue, 21 Nov 2023 06:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=tKYtbneG0PEYoOW/Ly40zhyr+mgkQ4jDklb+wUPXse8=;
 b=vDX73P5mleOUbZH5Xtxs44DC49E08sVTFSmRVCPcLEAEMqR0BHl9ez52yas0s4fEwOvv
 yPZaP6a3FFuGNNoWI9fn9XoBSlaxV/Mu4G13UCQ5oUcfJQ7NuLKltvayaiLsRx0XS8d9
 vkBpwBkmIYS3KrwH2VfCNtGcOxLmI5CGfWNXuaCPZh58Xr0gI1zKAkzrPXB9tCnYdUZz
 wFzWaxXhoQcjeJWQVm4MVAZvVHnx06x10QkipsnXIpKxi+MQA3rJABEmmm5tzmhX0v6X
 Bv2J/GCWd4oFJce1HG5FamK7h2t2u7b4qcN0H30Jf1egzfVsP+bo5HqLrqNxpa0N2uag NA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uen5bc9nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 06:35:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL4V0aO037459;
        Tue, 21 Nov 2023 06:34:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6fhnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 06:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKXHiAXfpXVhffNTE/H4se0vsZwQfWLbJZiORa2Io5vVEjW7eHf2YFbvkO2D6g5cg9Dame9Wf7INltbL7U2/TlJpTIUQUeuwzMLwwK2s4s4lvNXkgtbU9w1eHqgyDELohCqNcx5VKYvf/n63ouF/lVaxJPeCRAfKL45urNi0kTpBgxpv6/mFiY4KB6e5JHtep8bBEvPZKNyh6/qygM4CJSC+jkM1k3IaDL58td1/utFLxySsknutFcZj3qf9lbSiffy15v+6A9TbB/BrzE4Xqlr1fZEZW+Sl09tmzLEwgjPFnmZvM/SHLOpbULoPMD9HOQNZwQ8mYMHwgue+pOV7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKYtbneG0PEYoOW/Ly40zhyr+mgkQ4jDklb+wUPXse8=;
 b=egdORKA09sLFi1cXaCDhmLbZP5j5mo0Bezd40WZeO+vhycnge5I0WXL/7WL+C0iynZ1O1trMZeecGaJNK13eEi11Ufp7TxkSTz94Dot7xbDIArv1OwFj4At0r/3EJH3h4eFKMKHI9uewuOCRbSFjm3fCnqVHO/LjA44rv2LcMSVDiEzBolzPKNN0vTvHSkXfgOrpSXZW09xHqG3EE803SWYr7YkO4Wof796w0voaWAccHSK5IX2nHMJC/8kYiwfNuGhVq/yzk5bcFwrooCBanIglX657i27CZy5usBz1fZt0Z4QkwquXOix4O29rfsO69Ig+X5xygojhQypel1zMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKYtbneG0PEYoOW/Ly40zhyr+mgkQ4jDklb+wUPXse8=;
 b=tzGu+eCGX4Y9h+BO83PgGokkQbbqhFqpp40pobEJs3t14bchaviuQuYjX7GCXIzUXVg80Lm8+bXubbStv9dudsMqvvCdHge2bHDFtHzV4oc6nHndBbQnWxUA/ZmoCG/QXR3yxpHUZrk+zzqTAnoaFntG+C7Kh7V++1ZB2vXj0Ss=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6733.namprd10.prod.outlook.com (2603:10b6:208:42f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 06:34:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 06:34:55 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-42-ankur.a.arora@oracle.com>
 <20231108093645.GL8262@noisy.programming.kicks-ass.net>
 <87fs1gk0bm.fsf@oracle.com>
 <20231108104615.GO8262@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 41/86] sched: handle resched policy in resched_curr()
In-reply-to: <20231108104615.GO8262@noisy.programming.kicks-ass.net>
Date:   Mon, 20 Nov 2023 22:34:53 -0800
Message-ID: <87fs0zy5pu.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:303:6a::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a48d684-5db5-4efc-be4c-08dbea5bf9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXEt/xcPpe8Dwkrf4FIV64fDayCd0HUpTJfp9WUAD5IVE1JVIftuNVQs0a9x2qpRm1T9Biq0RlZhEOEQMXKPEOG1+KEdQpaOFe3cw1JKQn+666ntAH1WYXT3UtwzOYmeAsfEWnSNyrKq5fJtUlIAtb0yNdcFaVTcw5zgUkoqX6l208gNR3/pd+o7aZTs3m3OykV5/2jdvNYIzBJF4idTPCjToQ7nw86Cw3Ecbln7cZ0ULreWoPssuU9CqigfeNZ3EiZ1i/UZKVl4wqh43DwYdp2TFTYaJKckE49+MuKgE8Ch0qBadg8Uma1oTOUv+yuH1jzXCOBK+BYps6d3A69XbfCV5banDvXh3tukwCBH7By0EVLn/gtnXt14qnt52y0kB1ZVArNlhBp1MVSr9Sb4tRv8q3pZ94ip/DxH4Bag25bBZaXHbGVedMtxX5HZ0D6MOoLNnXSjZ6+d4gIaDKViLjF+ROjaIkKoSKxQUrxU4esO7eSKt/RQV7ji45fDh2tH1yStP7AnqeLeAfSfDmOaWLLntse+scvhApasPNRvyx5Dw+SMHaOBRyZ/otwZAkx6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(7416002)(7406005)(4326008)(8676002)(41300700001)(8936002)(2906002)(316002)(6916009)(66946007)(66556008)(66476007)(86362001)(26005)(6486002)(478600001)(36756003)(6512007)(2616005)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Nufru+vuePAcUcf859mSMXnPmwvWR6Y3tV2OWtqkHBzkqz5lHM7PgwCxZtk?=
 =?us-ascii?Q?gixMI65s9PP1sLpdlG3NweZUmPGVa28J2RPDSbn7wdXtVj9LF0EU9TfJ7d/P?=
 =?us-ascii?Q?0v9Rabx4wnjzgjMVZ6j2DJbPdkuJZEr9O+Ij8qA3Ct9nlkjHRaHLiyM0r6By?=
 =?us-ascii?Q?UMIV36Rv2l1bWGJ2O5IZ2w9qKzLbG6+D18Tt/E19KkHHzo0DqcOTfACXslAy?=
 =?us-ascii?Q?nUvI0tzgLt7aPfrKcni4eJ1+kf+iPgsp1h6eaSACjlEZhiuFKOLMX/BI/TB9?=
 =?us-ascii?Q?HjGa8Wa4FN0PtD6xeX36tKHOBM/7EJg6Jkcej0ERon26DpXl9Xh+oySyMYkn?=
 =?us-ascii?Q?65hXDgJfcP7a2SkTIllR8GgyL30g3hyKGZ1uA/vAOUWRnrZqlLu5DkutHOMb?=
 =?us-ascii?Q?15Sh7DzoIfYvSfc0WGJ+8WSshQBR1S0CykGkHQtrdZ0Xbhka6lMxM8dLulGy?=
 =?us-ascii?Q?Wib71eVPB1obg0nkmgIZxDxI4eR7yaRSbNJwl4C3ADwsT8RMEf3I9++GPGvF?=
 =?us-ascii?Q?lneXbXRdBAOGtL8X6boamlpkoZ30iY0qiAGWSR8z0Tf6su2NYk5AKYoB0lhs?=
 =?us-ascii?Q?eUlXYrNsV+cYK4YiC2UdxSt8cpGucPZY+7fT3T0v8wS+y4TG6+zKtqWiDNvT?=
 =?us-ascii?Q?J4XKP7VByCP/dVYB9ajc+hVqMcP3wSZazTqdX4eT/RyU6i/d+JzfFp5GHgxR?=
 =?us-ascii?Q?kbKW1BofuCftXGY0tB3xyCUVcvUNwrJymH+1WB0SkY33xlgOD6MD3bJetMj/?=
 =?us-ascii?Q?4YW/M9jdahIC27clgIgvXuXYswOH86vwoVTXcagHtQu93VoRgj1qramKg6Wu?=
 =?us-ascii?Q?kv6E06OEb6VQCMGWoa8f7YVZgh+tQO5U9Fr6oD1e6rYTsIbvoSoFe6aLDOUh?=
 =?us-ascii?Q?vkfELNuqlDGZITQp2Eq0NWG+HFTjmLejTwsI3gQR7Sw3l3d96BUQOKm1rJxZ?=
 =?us-ascii?Q?g14lcQ0qvyg00CiOtFymGgurRzUS3ziaYCTRX/0tw35aejaawJg88pW/ZKeC?=
 =?us-ascii?Q?bXX7S+gQ1DngUvtY4Jd0A/l/TJ+CzKpG8KnfeZWNfB1GmMhP5He9SlUWETPW?=
 =?us-ascii?Q?eIMPdFeva+s7KLWATbzf+Tr6N5NvP7BaW4TLtC4NkSLSRhf64zJ+ZrYcGxxo?=
 =?us-ascii?Q?WZkS7tYhy8eRQzQ5ukxom+TudyQrJs8sGqtUDTjrSdJ+SUc4PppRt63/hKoY?=
 =?us-ascii?Q?YJKYTX8aoJu1ibCoPshYf9gNsnR5O6TalGfmnyWYGOHpKvLM9TIH+6ih6wlh?=
 =?us-ascii?Q?Ad5FGLsNimunZ1AmhWtT96F2Ne3c6Nwx7mfy5sA56+u0LjS04q5A+Mh8Hlsi?=
 =?us-ascii?Q?4Drjs/BGXi/xuLJ/y98NgvpCcCHFIYO6h4N301a6szjfabUQej899qif9p26?=
 =?us-ascii?Q?u+LO7JhlbF3YUva6Z/+9YHwnUjMl4I7R5NPi7QUhkEN2pLoth30BKnzNojfX?=
 =?us-ascii?Q?dj4r4qI6mxqT6toFfy3h0p6XMBeorjfrLBzBESbrUOQV8U8UA0cs0EJwshIt?=
 =?us-ascii?Q?uu9C7W4Qoe3jo3k5BKjxcrRlXDYWAp17njIkkuPLNW0kn/VKu+wIrfSbYFkQ?=
 =?us-ascii?Q?na3zHbDU9xMtHDZYUe4wFtMLr9tJFffyyJMdm9MV+HBrYaF3v3GE73m5fnjS?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zW1W+Apk1/+Kcxxn/xM6Ddq0cpd6aqv5ArCmaa6C9pRClI3NK0yGPD/6YpJL?=
 =?us-ascii?Q?luoQcjgZtvviRG5siJOY9mP4NzgeD6dVw7rEgJgup+yh28anGUAbRli3lX4l?=
 =?us-ascii?Q?jJTIlcBe8Bl383qxG0aODGQp5z8wIM3K+QSm0Y+ynwEG0AWHOcWKpOa/8R3R?=
 =?us-ascii?Q?BUHfbtxXoAz0eBpZaQlpfhWxycMDFB5B9QotLXtfQfKmsC1UB5b4xmog3jo/?=
 =?us-ascii?Q?tmeYCmZf4X/BLbD8NSbh3ZUYdFljkdNE2FPd594bsw1OKy+b1mfVbFZryXIY?=
 =?us-ascii?Q?QUpN+iB0NdEu91Yx+DqbbEoo7h7q5QOJQA+dbzCbeA6LlKyO0P+soQgJvXoN?=
 =?us-ascii?Q?5b0VvaGOZkZxtbd6APoELghufubcWQOccXcK2fb8bVRmusjp1N8VCew7eQlH?=
 =?us-ascii?Q?+Xv1MgbNPpIBj1Cb9Gwzns/t3Srik6FBBRDHqcJ140UFR5/MbX6RQjGjnb1p?=
 =?us-ascii?Q?zEgkDCxhEQTKvy39WE7uRsDJ3IiLyyaGswMiHCsvcRPX6Q2mFE7ltF1AGlRw?=
 =?us-ascii?Q?3yC9jjritlYth332g5eylBOD61rJV0/zqv8C/jT7lbfRH1pEb/H9Q+7YSDJ5?=
 =?us-ascii?Q?41HN8AgPpJ17tT2prhhbs88FjixODTC+xQKEkwjW17oCUzPWg0iJduA6NRxC?=
 =?us-ascii?Q?L58rdQ+9AGsYGg22Svb7sc4u5kn4K5UlA87RdyT2V7xLB1M/AIuJGFb7JyUN?=
 =?us-ascii?Q?NLUSq4psGJGl3KiviGpVwOxo+dx3mDafgPnLylWPpI/GhSsw5Ncmi71wPpuo?=
 =?us-ascii?Q?kuXf2U+0k5A9shSowYpj9qlV1IO7bdb9UxZqjjIYIiUe6LrlitWP45edou1n?=
 =?us-ascii?Q?MPVdn2gCyo2gUG8sWB5sCuZs2QIsSqM7Pz7i6KSAtaN2r9RY2XgT849+Y9rX?=
 =?us-ascii?Q?mjKAJeGitQgNMRoNqAYeDf8Bvfu00g5ATWxFFBr6HIUREmMFIbMdoSokEXh5?=
 =?us-ascii?Q?hR85NbT09CTNcGLkIQ3YjFcwoy/2TjWaqLc0XgAtK0BTh5cIRCApNHKBwZ9q?=
 =?us-ascii?Q?DvdaIVlCeWVBDmAbRFkLeFDHuhmWi+gLvF4hGbOVLYyeAW6YY/8Tdn2dcRyZ?=
 =?us-ascii?Q?nSLCsDZ0iHA4AwrQJV0yEdecTvdkOgUMkX0W2Sw4HZ904w/ChKBTk0MzMDZI?=
 =?us-ascii?Q?81X+HhleITNUoIWL3smn5QKwypFJABVqhNJhJIgtPvOzC432ZbmR794DZTWj?=
 =?us-ascii?Q?pmVnOM29kM73O9uwnwHQkQ1YYMGRk3oVj1IPdJzNhfYFJIdd6ZMQqvVI3Ds/?=
 =?us-ascii?Q?XNmz5oej0Xo71erYiZLMxJFcseM0y+G3Su5ZlkjvH7hKgDHPKMO9cDIUD1Pc?=
 =?us-ascii?Q?wqaiH22SNp5IZR2dckA0LACgo8at8XGwmB4NF6kAWtVN2cunVtUG0EdkQI5t?=
 =?us-ascii?Q?nm7j4WqT9nZisBTgYTVlc0SboWR/y0YJtct+GXV4qrHhh9VmHj5sHgRaavpw?=
 =?us-ascii?Q?uOAdTOy4qwOiEK/UCa0/IZUx8gvAReEjJNdiWakN4mmAd4DILTJCidh0RdLH?=
 =?us-ascii?Q?yFmfxKBucQpUNDRzXdlNb3u7gvIRl9zGEWG6CBQ8rt81Vs2K/lXDwcxG6w?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a48d684-5db5-4efc-be4c-08dbea5bf9ce
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 06:34:55.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlvlrtmDEnvFCgJFRWYMvXcnOwv4QgL5I3eCZmM/5r1HHfHChJ2fEXY9bTHPa/UYxvisPuF+D0Hg8ORp/+G1lIxMnoHSOF9wKGCXxeMTJow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210049
X-Proofpoint-GUID: J7LMcCxqXbQzqwTkhOvt9BdH-Yo8ZBS_
X-Proofpoint-ORIG-GUID: J7LMcCxqXbQzqwTkhOvt9BdH-Yo8ZBS_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Nov 08, 2023 at 02:26:37AM -0800, Ankur Arora wrote:
>>
>> Peter Zijlstra <peterz@infradead.org> writes:
>>
>> > On Tue, Nov 07, 2023 at 01:57:27PM -0800, Ankur Arora wrote:
>> >
>> >> --- a/kernel/sched/core.c
>> >> +++ b/kernel/sched/core.c
>> >> @@ -1027,13 +1027,13 @@ void wake_up_q(struct wake_q_head *head)
>> >>  }
>> >>
>> >>  /*
>> >> - * resched_curr - mark rq's current task 'to be rescheduled now'.
>> >> + * __resched_curr - mark rq's current task 'to be rescheduled'.
>> >>   *
>> >> - * On UP this means the setting of the need_resched flag, on SMP it
>> >> - * might also involve a cross-CPU call to trigger the scheduler on
>> >> - * the target CPU.
>> >> + * On UP this means the setting of the need_resched flag, on SMP, for
>> >> + * eager resched it might also involve a cross-CPU call to trigger
>> >> + * the scheduler on the target CPU.
>> >>   */
>> >> -void resched_curr(struct rq *rq)
>> >> +void __resched_curr(struct rq *rq, resched_t rs)
>> >>  {
>> >>  	struct task_struct *curr = rq->curr;
>> >>  	int cpu;
>> >> @@ -1046,17 +1046,77 @@ void resched_curr(struct rq *rq)
>> >>  	cpu = cpu_of(rq);
>> >>
>> >>  	if (cpu == smp_processor_id()) {
>> >> -		set_tsk_need_resched(curr, RESCHED_eager);
>> >> -		set_preempt_need_resched();
>> >> +		set_tsk_need_resched(curr, rs);
>> >> +		if (rs == RESCHED_eager)
>> >> +			set_preempt_need_resched();
>> >>  		return;
>> >>  	}
>> >>
>> >> -	if (set_nr_and_not_polling(curr, RESCHED_eager))
>> >> -		smp_send_reschedule(cpu);
>> >> -	else
>> >> +	if (set_nr_and_not_polling(curr, rs)) {
>> >> +		if (rs == RESCHED_eager)
>> >> +			smp_send_reschedule(cpu);
>> >
>> > I think you just broke things.
>> >
>> > Not all idle threads have POLLING support, in which case you need that
>> > IPI to wake them up, even if it's LAZY.
>>
>> Yes, I was concerned about that too. But doesn't this check against the
>> idle_sched_class in resched_curr() cover that?
>
> I that's what that was. Hmm, maybe.
>
> I mean, we have idle-injection too, those don't as FIFO, but as such,
> they can only get preempted from RT/DL, and those will already force
> preempt anyway.

Aah yes, of course those are FIFO. Thanks missed that.

> The way you've split and structured the code makes it very hard to
> follow. Something like:
>
> 	if (set_nr_and_not_polling(curr, rs) &&
> 	    (rs == RESCHED_force || is_idle_task(curr)))
> 		smp_send_reschedule();
>
> is *far* clearer, no?

Nods. I was trying to separate where we decide whether we do things
eagerly or lazily. But this is way clearer.


--
ankur
