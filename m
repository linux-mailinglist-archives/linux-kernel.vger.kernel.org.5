Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ACB7A904E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjIUA7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjIUA7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:59:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B008C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:59:29 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJ5Ph002736;
        Thu, 21 Sep 2023 00:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2023-03-30;
 bh=t5rwjKm0IFEluzu4TwWJKWdo6ls786nnmc1SsLIUKkc=;
 b=ZDGAWrNEJTx9onr4vcues0q9REZpBunoJsl5DWHvLpQWOXNziebaPjuZlepjS8UTQH9s
 8ZISQt9xdLQd44tBMggmoWJFeEXMZzHfUVFpAc9or2VmA4QOB8Fwn1mdKBucKrYaaOfI
 JU1t5ZCCOItpVqi8PzZm2Cp/NAO4Vrh22y41434rp9RXB033anmJ9HGNGZL+oLailrKY
 Vpqm/rrTqPAL0cvcu0RWUNlwbbLj+1HnMAoGQpyUVvQAaT36ECIUNsCkOY4/Rt0bBjI+
 tllLPBLqS0yiwL8CzV5TjYywjIkWJAOsE24X7uJGs+n0A0mk5asjiBecv3UFrV0dXS4M Hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd8ma8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 00:59:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KMEpiq002103;
        Thu, 21 Sep 2023 00:58:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t7kb79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 00:58:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+NA+dFA8QfkYYm5PfYBSlPM/8zZ4ok1j9P2QPh50RnnbQu7eRLbLnFQwmxa1zD3b2VGkOnvQsak5d0fRaLvO8/ooz6GkN8yTAJy9CJu9jznlAjwe2ubh6fz+okdDkvfn2pd924N8ag02O3TdPn9nNiH4W6dK7L04qx+WO+tpeqTxr/j4KfJcT0ONp5m8m+Mziv9MkqAO4Obw7tizX8kD0bGb0emmTpwrPOuKSQkRwwLlIeeuP6KLKGZvsOiMbwsiqA5Gvx697zOWWxYVanAqhfOSo8ErRBa36mg8GhYPZ1jITJoCBCElaW9LwT6O8fOfi1yr7cW/WnSjiyY+7gARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5rwjKm0IFEluzu4TwWJKWdo6ls786nnmc1SsLIUKkc=;
 b=QPReF3sVvTfXs+GnOTvrAmGalk2SyCxD0+2w1wMjzquavzJre3trIIiMPrkw+U5BZXRSzhY6SEF2RbtlnzGJR8TbgsuwA0c4iSEZjRFbSJ112ltbRu+6FRqvPYOuX4R/Ld6ICX95vHziLatfYjOzxm17W0nh8s6qrmaxVgoHMVan1Jdinbv4dElUCG5BQuai0UZlV4t1AxkxAjvsLbZjpmaBB9LjjQ0E2nkstjrIa7WX3s5RPXCi4AEzCCbH3Nzy/Q4wnEEb6Lo+eMqd1Kf+Fh4CNfwwJYS4V5kJ1AUwhawEkGrLqYvpe0GqbTCdSC0odEDJt718MJBFpbCcyvOQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5rwjKm0IFEluzu4TwWJKWdo6ls786nnmc1SsLIUKkc=;
 b=QtV2dsYoNBlu4x29jHmsLC0c65L2Sg84l8JUIPOaj2bwEzETAK2MvAhiCu03csI5wZAinb2vfnJ4FfvLz2GTUljd97PqF6MQqfqFyitEtiLkcnMEhcmiaYceYG1OYmk15ALKVPuMuvjbt9goo5pwZFc7V+5P68cjEA4WHksgs4Y=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4555.namprd10.prod.outlook.com (2603:10b6:806:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 00:58:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 00:58:57 +0000
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <878r90lyai.fsf@oracle.com> <875y44va9t.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <875y44va9t.ffs@tglx>
Message-ID: <875y44ibow.fsf@oracle.com>
Date:   Wed, 20 Sep 2023 17:58:55 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0268.namprd04.prod.outlook.com
 (2603:10b6:303:88::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA2PR10MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: ca82a2a3-651e-4623-9ea5-08dbba3def44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7TUHD/CxearBJF9RrvHABaMEO6JYW94xbzG0AzhJ/C4+xzaHSG/+IWpBYAUO3zZ29MSiCQjmem5fQC+otsFm5Cx2GavcDiyqGOEpJamY1PKL1NU9tr74YZeC2+jOmEZVYEFoZDPhvUuIdu4lMEhK/crNPmpDP/ujYgZ0X+ylk+XiPcx/Afo909QMZCy4liMTfkeN4EIlr4D3vX3CIgfZZQWT1BKpfY3WjDqsYV1K00HdBrdB4e+97qHRCdKihSYQn2J8bbbnk0nXxPEvaSn8x1pX5qJOQdy4z5ioCwirR+25+Gg6Odw353C6xstMrd3ctnmiOo2A2DcvWPsOh9jzR84z8SlDmjeOqTouRGFdoTAtDXCziutO5PNoOjUDKFKvnKRSk9Hb10CeSjD3OfsFy4PT14PcdWHPWl85sKhYXkpUtdDQOc1+Dr+xsnQcop4SYvVwI3YdjLE4lYHT+9wdktcLi+xA+JfMPsyLyLZmcClEqhtRehngr5+asaqVuHESSj1gXl9drt+moqZtJHK9BvBHqNG+pD0BqIToUDwXY4V7kE586xElj+4qJqCKGdF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(1800799009)(186009)(451199024)(83380400001)(2906002)(54906003)(36756003)(6512007)(6506007)(6486002)(6916009)(41300700001)(4326008)(5660300002)(66946007)(66556008)(66476007)(8936002)(8676002)(7416002)(316002)(478600001)(86362001)(38100700002)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DpGpmLU+hq0ewTx7q/6uaEbC8tJTalGCC63D9aorz49eabtj7hKNnRtjqrEq?=
 =?us-ascii?Q?37groRmLpFUKcMcNsRDtSjHUaIzF77TVKerIenzbD3oMm29Gt2vROPqhtugx?=
 =?us-ascii?Q?6Wur80pCSQ/jzxpPz2qFziYxxg0jyoLSK+PD395dol6RZBIOuFtbf/Q5DJRJ?=
 =?us-ascii?Q?lmzTVsrJD+Q5n/9Fub6d3Ji6b0HxndfwsqdZDx03HbcLgaCM4ooBqrb/SIPo?=
 =?us-ascii?Q?QYqghKfiBVmBXFj1+wpEccT7u7F2bcnHnbxNGThc8EYJ2y8xyUORsbOGTRuD?=
 =?us-ascii?Q?noEw4Uc24ZUGE4hAEF41vcVKzxAnENrzjdWo/kTsD6EYpWMM5K0b4WSwFcH+?=
 =?us-ascii?Q?piI6shh4/xShzOpnZpaBoljIBwZlnQoPwiiGj1OU2JMLEBqeinTCYU5cCJA8?=
 =?us-ascii?Q?0A4H7l14Bj4F6rFsXnSBXKZnqa6RiN4F4wQ/sA9Sr++O3wkYr/YKEpA4kEvs?=
 =?us-ascii?Q?Lpdj1HTH92Uk/aXtM8JkOXjCZ8hQIR/HrlwEjxgF0yeudkCmOms0ZD8Bff28?=
 =?us-ascii?Q?8ssaz7YDHFgWowlz+ZB1c4XrjioUGgTd/nx7cGSgpfOzxw0VWMvrV7GoOGBe?=
 =?us-ascii?Q?DR3dfuxBC27VT5rx/P5VzTvh+l4XrRoBbo87MeLdKgTvpotTB8RvmACOcpQ0?=
 =?us-ascii?Q?aYiS8jarYtFks2YPwc3NDsqR43HMeACcmas7o54ohCUXlON4rqOTQggdr765?=
 =?us-ascii?Q?Cdz9flwsIOKeDRfsgJmLa8qQEqqeQG/MylNKrrk7CpJ5vUgI+LLaE6XLL1c6?=
 =?us-ascii?Q?oIND1Am+fEmF8GdKptgNWHcBHwRIUSZ27YkJlFv5ckg+yr4prCDfuEjAN9v8?=
 =?us-ascii?Q?wCSQ9JGnWNPbcqDC3YvsQggSdweucb/CujBoDIWyENh01hX03jfGqEDcrcDo?=
 =?us-ascii?Q?S3HrFQhYBnsW0KJ2sN3lGff4WABeICXTa6cMTy6wsQSICM+/rdxPqlZiboBy?=
 =?us-ascii?Q?ByRUYoIuQf6NvYIiZexe9fFAiowOUzm8nUXf3q2X1oBV48tTv0Iot4+8zhkq?=
 =?us-ascii?Q?TUbngGAeeSzrKhW8ag/sUp4fDQ4p68bcs6dzahTboGjVMNHr+/pCO297JQIx?=
 =?us-ascii?Q?lkbEXoXjUoAIM8EYcmOSQVdT8JrDxjy7EPKRRafLddPkqcFq/bJXQeK4AOFV?=
 =?us-ascii?Q?0EECVlQGEVz5Xj1jg5HAlgQjIhXCzQP2NsKhz5rXvq0V9/5KgLoxWrFuLKd4?=
 =?us-ascii?Q?K5lU962tSyp6p3/rLWiuoBO3IB3KesyyqUfjYZiIk9RKtowxRt/zGXgjr0sf?=
 =?us-ascii?Q?pMnPa1P3e0AWgt94Pas4rdlGm/PYDppMn7YU0kiAhGMIN90BEHknPLZOCeQM?=
 =?us-ascii?Q?loL2G+72yLBqzIFFpdxvunB6QRhbUqDKlFSAJatgeR4g++8q1dJjGOjVmnrg?=
 =?us-ascii?Q?qBNHaAIpRvnD2LOwkf5EXUT4TsKKmqV6VLjEo/FzhAFIGgoC86KU1drsSV6w?=
 =?us-ascii?Q?DR7bzW0uXTLbuDEVd/yFnyJVf/6QyFd05BPWbOfaox9lCF96MAnAU7BUbJFY?=
 =?us-ascii?Q?u7IOXNY3a/f5HZU+XSQ5tQVVBN19FDn+cf0aJMPgOVe5F6NavfqjYbimYnWz?=
 =?us-ascii?Q?PoT+7idTDDn/NSjX/sQwkSn66PFWtHtHW2gaPrZjpavUPXL6/FqP1aVQiuiY?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fOU1F7iyIwqct3MwC/K7LCrwuLsjgpRfkjDJ88LcIVKk9bNLpZfC6hF4o6h2?=
 =?us-ascii?Q?/PbxDzOb97p246js/dAFpit0ZRGiTVuHt59Z4g60MW4oQaDGNocBIx4LafBp?=
 =?us-ascii?Q?CERgrCCcD2vY8IFBcOQxQUgTiifpMxYTYEdAFRU5o48Sg4JmD9Yn23LsZVCq?=
 =?us-ascii?Q?bVkuZeEVtFl/RqR71rI9rFIsdQqI3rrIFQGcHAzCD+fTQtzN+ahUPgIh/Rn+?=
 =?us-ascii?Q?4xcfwk5SDYuIwNnAT3lgFhIZabZlrcYGyh454QD1SMndYQb5C5qUrXhN+ie9?=
 =?us-ascii?Q?Ziz/EkYyAt0qGxv7nmgeJuymyH2jV+yxAh9ryv9Z+lSkngEgx08fbQEbTU7G?=
 =?us-ascii?Q?DWMSKlcTMJs1sgIg1dbMas3X1ITN/PZRzPyTUDz9eLxsF+R673ZGtciEA9tg?=
 =?us-ascii?Q?x+7Qg2VzN0IFkdurT8wFliCnGhe5vFntKzic2BuuuJAdQ8QDf7tnE8iVqdBD?=
 =?us-ascii?Q?1Idwm0wCvs59EABz1FIcuhoG0+XKZdj3oCsUWEJGdzOokiHU+lmqy8SdNGt3?=
 =?us-ascii?Q?oWy02ArsV5zf3xHnRSAKKdOXcmIrXoQrH9f7I2gecF2CjlB2BpmdpGqvRts+?=
 =?us-ascii?Q?pJF4BCuxVNlmERUxxMfcVFgByidnGtD0llgIVc+4l+M+yEipjrUI0mVG0aCa?=
 =?us-ascii?Q?RGFsl15I+qJLm/3Qj/DbTMJNjNuoXAYrFgn6vU896P3UJL2SD61ReHdq1fhe?=
 =?us-ascii?Q?WRzUcunXrINmzX83QqDhNZUgaCRKQwsbvhQkRyf/u+Ye1INqTqSjg9C/+FWd?=
 =?us-ascii?Q?pLbWENwCRUq2jNExgKk4Q+oDUP3PdQ5pVzc+jv0k/Vp6wj5Mh3xP58Oog3dE?=
 =?us-ascii?Q?YSj4q/3kczg112BInGxFzi8nOyWYFU5G06lfebqMpX2ipXyQiQBR6JGM5e+4?=
 =?us-ascii?Q?+MChVkXb5JvPg11b2s4Rke34VO0cYh5lKzy5Tpd9Nx/S4i83YqiAmQ14YSpO?=
 =?us-ascii?Q?q2UV7GXB9mBV/faFiBzujGYypMotLXYXXSZy/Ms0l0Y2Og3/s17eiVoptBuH?=
 =?us-ascii?Q?GD8+6K+ZpXwR6fUALMT53G6Akm0OZkcmDOvM44yYjewR61Mp8ENJfb8kUFC8?=
 =?us-ascii?Q?B+xhPOpsKudkNMyiH3rTFEo8MltQqCKPv+4463DGtaAvY0rzKozm+hkSzYjs?=
 =?us-ascii?Q?EXzQbvnwZ8Ne7U9SAAPGTf1QlpyWPJXYTj1MnXHfiqgqRfKFQyD2ybbb6gJf?=
 =?us-ascii?Q?rYSameYfhx7zmHijO2fSUbjV9zRht6MdlTRCHnnZQVyelMYBLI9SsS8uSZY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca82a2a3-651e-4623-9ea5-08dbba3def44
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 00:58:57.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaqvgwGW/h3HGpEpx3J0oblEgwKml2oylo2b91Pms+jVdpJSITQPi0zYAC3c9QEzRZ/5VQ4d/s6cQYQ1R0/UaUlsVlndSmNHhyjb9E7iHEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_14,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=707
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210006
X-Proofpoint-GUID: 1sUI4IaLtiQQ0WKEFONXlydD__BnN75F
X-Proofpoint-ORIG-GUID: 1sUI4IaLtiQQ0WKEFONXlydD__BnN75F
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Sep 20 2023 at 07:22, Ankur Arora wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>
>>> So the decision matrix would be:
>>>
>>>                 Ret2user        Ret2kernel      PreemptCnt=0
>>>
>>> NEED_RESCHED       Y                Y               Y
>>> LAZY_RESCHED       Y                N               N
>>>
>>> That is completely independent of the preemption model and the
>>> differentiation of the preemption models happens solely at the scheduler
>>> level:
>>
>> This is relatively minor, but do we need two flags? Seems to me we
>> can get to the same decision matrix by letting the scheduler fold
>> into the preempt-count based on current preemption model.
>
> You still need the TIF flags because there is no way to do remote
> modification of preempt count.

Yes, agreed. In my version, I was envisaging that the remote cpu always
only sets up TIF_NEED_RESCHED and then we decide which one we want at
the preemption point.

Anyway, I see what you meant in your PoC.

>>> But they support PREEMPT_COUNT, so we might get away with a reduced
>>> preemption point coverage:
>>>
>>>                 Ret2user        Ret2kernel      PreemptCnt=0
>>>
>>> NEED_RESCHED       Y                N               Y
>>> LAZY_RESCHED       Y                N               N
>>
>> So from the discussion in the other thread, for the ARCH_NO_PREEMPT
>> configs that don't support preemption, we probably need a fourth
>> preemption model, say PREEMPT_UNSAFE.
>
> As discussed they wont really notice the latency issues because the
> museum pieces are not used for anything crucial and for UM that's the
> least of the correctness worries.
>
> So no, we don't need yet another knob. We keep them chucking along and
> if they really want they can adopt to the new world order. :)

Will they chuckle along, or die trying ;)?

I grepped for "preempt_enable|preempt_disable" for all the archs and
hexagon and m68k don't seem to do any explicit accounting at all.
(Though, neither do nios2 and openrisc, and both csky and microblaze
only do it in the tlbflush path.)

        arch/hexagon      0
        arch/m68k         0
        arch/nios2        0
        arch/openrisc     0
        arch/csky         3
        arch/microblaze   3
        arch/um           4
        arch/riscv        8
        arch/arc         14
        arch/parisc      15
        arch/arm         16
        arch/sparc       16
        arch/xtensa      19
        arch/sh          21
        arch/alpha       23
        arch/ia64        27
        arch/loongarch   53
        arch/arm64       54
        arch/s390        91
        arch/mips       115
        arch/x86        146
        arch/powerpc    201

My concern is given that we preempt on timeslice expiration for all
three preemption models, we could end up preempting at an unsafe
location.

Still, not the most pressing of problems.


Thanks
--
ankur
