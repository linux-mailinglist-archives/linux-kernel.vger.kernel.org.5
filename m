Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4577E5238
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjKHIzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjKHIzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:55:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A54ED4A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:55:31 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88kxNs014855;
        Wed, 8 Nov 2023 08:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0bPOtEPKUqm7jw8seOqH9PY63Lv+Ex/Snix2PANv5rY=;
 b=vxKXjZr+5aA/CJ/r2/va0n3JPzSs/mJ48wil9ME8yjLk1Ki8RRgLFPMdpU29Lf9226VZ
 ZK58IcgkfatV3B+JPdAdCJ+NlYdhLGTXMg8vag92F1RAslcm5TgSKJUiE8a1lfqW9HOX
 io+ex9CPiDbVd0vK0fFfheTw7JEaX880rWeQtQhpWRgHDM5FHl2AePcL3t2bywZ2M/Q9
 pdKFfxBEykPPFmd8kStdJG4czU7vI4jg6DJgi4D1NvRf4nEuNSb36kZvvV/D6KB0mYqG
 b3lP5zYdMi8TP8K/N9szMuy8gPxpWDM4XIZUwrPnScuHkNm1ziqq2fDESyH4TsuAjQYF /A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26ry10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 08:54:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A882aF7023844;
        Wed, 8 Nov 2023 08:54:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w24nshb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 08:54:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUGq1811U8feBaSU7M4YUn1fR7wtwzIvAIykZ1IorH10gyKjdnY3uSEoNL1oFg/vtrgvPBSrR8NJLaa3wehmF3jH7gmT+VsahSl2r47IWGwofYbschAT3zobpRXfEhE9cJc87gn8klzaWGwt96owFf8DrKq0xIb8s2dclZJKec986mT+RiEcDga40ELm3XUOt3EEewEbgRU/+b+9FnvOewOwMuYVeryoLCUFY1+6Q12O1KaBt1VehJXx5b5tI2lkdYvzEzXcCmADMA9pBIQ4H9D9ZW7wWAzHaRwP3QqZ+g0IYiFs42Qf0rILJUVIS/4ZDcWC+GRueEVQXV2xHYdlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bPOtEPKUqm7jw8seOqH9PY63Lv+Ex/Snix2PANv5rY=;
 b=PIzLrPhifd2PsF9n5CeGzTmGf/bFz6NQH/UOTN4UMbcrPHHnoWxb9A2ZkeDL4QaGm+MKOla2TSaPCCjJH9xVysnrQMarLHGduhTcvZaMsfxOqC4lsmY02X7LV3QPMlU3r5L8UGrrkrR77Emy+4zWYTVbP3BcNdhLyMuJ56yL5ROgEB4aH1d9JpERwX/MtrV6ixxd5yxWbd38HxU/1S9zX3PakRr8iEsAfZ3ZeXxRiZqdnLuTOgIWZOvQ85npfa4qDtSCdmBf4lWLYu2e98oL+ezzojNiWb0U44z/95qunFFrwptU5R60Vugv7PqZLW9A+Dvrn+CfBDtDcQlq/1FicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bPOtEPKUqm7jw8seOqH9PY63Lv+Ex/Snix2PANv5rY=;
 b=h9S5aQBgCw3SnfEde8Rnz3TzszK8D6hfTLzl3BO7iPlb4ixEidv/bjN6DCJFdnNi/n6wlrUoDyylGgeISDOAbyi1tHPpl/qxubNsjwgrKvEIHF2dyf1waDRKThuaLMbhbulzVtzk39FZmD7i7GuODAEpcxW6mlYLI8cMX4jy0Zw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM4PR10MB7451.namprd10.prod.outlook.com (2603:10b6:8:18e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 08:54:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 08:54:22 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-12-ankur.a.arora@oracle.com>
 <20231108012823.GD11577@google.com>
 <7155f21f-a7e5-cc36-89e5-c1ce257b9420@suse.cz>
 <CAJD7tkYYqqYT361pbeqTFxoAep2qtTAWSQx4SzFCcEEOZgRT3Q@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        SeongJae Park <sj@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Hugh Dickins <hughd@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Minchan Kim <minchan@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
Subject: Re: [RFC PATCH 68/86] treewide: mm: remove cond_resched()
In-reply-to: <CAJD7tkYYqqYT361pbeqTFxoAep2qtTAWSQx4SzFCcEEOZgRT3Q@mail.gmail.com>
Date:   Wed, 08 Nov 2023 00:54:19 -0800
Message-ID: <87sf5gocas.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:208:e8::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM4PR10MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 673cfd77-8d62-4112-e22b-08dbe0384d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLuM7u9OdZg6IrYR2DYmfR5/3qoLy2HOQiFs4eUoSiq4EsSHJky1i8u7aXbVvuWrrwLUi9uAHoLvs7WUtfzketmy9B+oZmMcnpyrP2c6zVrYbAC0vV+oce6Jh8nhxNAipcxmkN1P/GEGCU9NGhdn/LYBzpevklDoNHQWfh8fWJgLm+2ZX7PR66dRnme08mLZnRsKqzANJbqjvB2P0p6tUpGvur1ty86Y1UBpfvy+s8K6NHMnrjbiBPaLF2/g4VHAby44lF1OAbyabQXQFBztCSd2+wzQW7Gnds8g/R8uPJsRUzIoDyGY8d0/rbrjE5bJSieO3nRTyt7wgTFmXwviWUel166yfjjs9sjDOtUEhI7rDG2mt6rdSudoNU/EiA3KGcwdWlKRmeMZEQUH+dnXo05ISP1BKhmlOEkfTJWxcJCx0rhhJ+5LYoHY9qMDG7iE79Im3dvOw/qyVrcIHNbm2zTE3X7wDKXYIFlkqr4EUPe5a+bNsw+grFBzXxEMhSs+BW6ThBFhIyrfg5dVwdHhNoEPt+Cdb5AYDYO+6yUbGXHRfp3p0Fo4g3Qica38AYpw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(4326008)(6666004)(8676002)(8936002)(6506007)(66946007)(6486002)(54906003)(66476007)(6916009)(66556008)(38100700002)(316002)(53546011)(36756003)(478600001)(26005)(2906002)(86362001)(5660300002)(7406005)(2616005)(7416002)(7366002)(41300700001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhrcHZEWFphdkk2cFJSRE1GdnlMY1lRMHltWGlmd0dudlhzTkUrNmtsVWJD?=
 =?utf-8?B?eHRtRERnbTRhd2E3c2V4dkxzWDBvdW5veHBZQUZkMFpwM0tVY1BTSDQ0cisy?=
 =?utf-8?B?bHNJQ3Vid0YxeWRXWVQ5cUZqUnB5YlZUMGg5akwwVXVvMDRTdGhrbUFqYTg0?=
 =?utf-8?B?QjFZaFFtY0Y2NmRhc0dSWUtQbTUvQXBlMkZrUXl1aUtlMkVtZ0xoL2VyTVFh?=
 =?utf-8?B?QkNrLzUwL1VpMHFZSkp1ekNuelQrQ2F2cExrR3BrRU01b0krd29oUkRBbUg0?=
 =?utf-8?B?UHpCYmtXWURFOWlDdk1UeDBQcFFIUlRFRlVkZWJldVhocE00TDdQYXBua1Jx?=
 =?utf-8?B?dUZBNDVncHZZb2pCWGhUeGltLzRRbDZXMDcweWdqSkVnU3kwZzRReTNMVXFG?=
 =?utf-8?B?azA5Vkp6THgrbE1CMkF1M0paRWNPQUp2eUZXcU4wUG84L2dielNZUHdRTUc2?=
 =?utf-8?B?SmdlR0xya1l2eGQ4b0c5WUpTNzNlR0lyQm1md2FaVFUvY040bHF6MGdiMUw4?=
 =?utf-8?B?RG5lNkFtWnBzdVdha3ZhNTVhdjVzR1V5QnN6MDUxSDY2L2NpSDAzWm8zK3ps?=
 =?utf-8?B?SUFGTjJUamVJeUx0R2FpV1VwdGNyVEhrd1UxZU5ZTzdmNGxyTjMxbWtUSGFI?=
 =?utf-8?B?dEF2M09BUDJ1aHBvOS8wdjJsQUZVYzk0T1IzM0liL2dES3d1UEIvTTZYZTEy?=
 =?utf-8?B?T0pYQVg4Ky80QnFHdWFWQ09qUFA2QVJlOENUc1BMZm91KzBHZU1XcmdoQ1dD?=
 =?utf-8?B?S20wWnpJbFpybmVabW5hRFV1UGFiWmVEVXUwZ2VyUkIxR3JVWDJCL2RCQ0pz?=
 =?utf-8?B?cjNlT2I2TXhZQWhZdFhIT0dtb2YyK1Y1ZDNteXd5bGFnWFNKVzZCN20rY2hq?=
 =?utf-8?B?elhHTjlkQm9XSmtkTjlqTStEQmhJS2RTWnhQSkJZeTdLQUxoVjRyQWtsL0po?=
 =?utf-8?B?SnBnWldwN1k2ZnJrZXpCWFVuNDhIMDNibmY5dEI2TzJUMGlHNjZyWTZJTXVn?=
 =?utf-8?B?VkFjRjJTTk9yLzZpNkpabG9McHFBb2FubDZBelZ1Rk14c1NTcFFFZGVXc2g0?=
 =?utf-8?B?OHZQQ2tQaDZmT1JRdVFXSGoxS0JkWkdNMER6R1dHMEJMMGt5dDNRZUVoN3Ey?=
 =?utf-8?B?TTErN0ZlN2VQOEMrQXBTSnVvZGdhRHZhY0Rhb1FFRXZXMkVNSGw1azlsMmlK?=
 =?utf-8?B?ZG9PREpCeC93Z2xLTWZnL3JSU0JUSHdrTkVFOTRONGJ5Y1R3b1ZtRERYdldQ?=
 =?utf-8?B?a1B6ak45Zy9vaE1HbXlSVGg2aTJKaUJYajVGKzFyQ2pTWVltUnFUeEcrb3FI?=
 =?utf-8?B?azdld2ltWDlBaFlyQWxjcE9odlI2SkVuZ2R4a1l6eGp5dDhOSTNabXdyemRC?=
 =?utf-8?B?bFlYM2l5OHZTNUFua25qaStZeE1vcE1vcjU2eFlKbTFwbmpjSCtrSUpKQ3pG?=
 =?utf-8?B?K3B0NVNFVjRlakpEV1VDWjBoU2FMUUpvNXYvUk1XVzNrandaS1ZWL1VYVEcw?=
 =?utf-8?B?Q3dMZWlWeTdaSVVGODBpdS9DTTRuYTdTUk0zSThZclc1RTk4S3VBYlBDVXhR?=
 =?utf-8?B?SmxQREpSSGVtWnBPbUhlYjRsTjFuaXQ0NnlMRmpiQUwyR2dHcERwSVJWNGVu?=
 =?utf-8?B?bHdUODYwKzFGblBEai96QzhXZ3IvamtiajJEelBwa2srVDhTaXFUVDNOMy9D?=
 =?utf-8?B?dUIvTVdxWWVzYjB6TTh6TWpzNEVWUFppcEFOcXB3aUZHUVlxOTh0ODR4MkR5?=
 =?utf-8?B?WGdnVlNaQjh5QjFLWEE0akp3Nm9RdzFIN004cGFhd0RrN1lCV0MrM1N4Z1Zs?=
 =?utf-8?B?Mkdua0V4Z1phWWVzY2JEUGZXS3A3ZWZWYldlQ0h5SDIzNkU3MXVCRHl4TTZW?=
 =?utf-8?B?Q2RldEpNWWsxNHkzanZ3VnR6cUdLSGtROHpVYUxHcTk3N1FIeDlFNjdFaEww?=
 =?utf-8?B?VHBUZ2R6RnJCcmN6aTNVSklIWTZ1ZXg1Y0lGbmVyb1AzckxvQlptMlhyNGRu?=
 =?utf-8?B?Z3dtYWJOa09kbmVrWmhCVUxOcklBUHVtalJCbWxIdjZHNjZ5TlpwUjVkVEh3?=
 =?utf-8?B?N1NIMWpTM2VvL2dnSVBzQ25BRDZBQjdoVStPOHhIUDN1MnVMdUlEWGdUdWwy?=
 =?utf-8?B?L015dWNta3RKemxuYXMyeDIvbm1veXFuWWh0cVZhL1dNdXhLeFZWQlRrM1Js?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TlZLODN2dnFPQkxqOXdoZ3VtNmwxMGVnS1lHMU5FODducnovMnBGR2srU0U5?=
 =?utf-8?B?R1BkYnZ6bG16cmVMM1U0dTA2c3lkbWtCUUpRZjlja3BjN0RVbEExbXlxS2pv?=
 =?utf-8?B?MnZsOEkzWDlNR21wekQ5a1FKbm14bWxwdTNRU3VoaFZFc2FyaGIzQVpHVklX?=
 =?utf-8?B?UmdhemZIY0V0UGhRbkkxc3lNNEhOUnF1R3hka2tQWGl0TGVEQXdoa1BpWktT?=
 =?utf-8?B?NzlnbmFUM0dNTVlzWklXWG81MG4wMWtNQllFZE5NcitGM1hQVVl1MDlLTjc0?=
 =?utf-8?B?N1dRR01ORFZKOFlmbHhaakpHSFNuUjV1eWFJWXVCMFlOSUNJekFkbzBRdi9a?=
 =?utf-8?B?Z01ueHR3UW1QODNHQ0hKYXRjbThZbHVsTVBEaXZQTGZ3OTBrVXl0Z25Qbk10?=
 =?utf-8?B?MXdPUncvMjZzU1NXNzVJZDBXMTlOTXVRS0FFeThnU1BkNFB4dEtYSkplZ3Iz?=
 =?utf-8?B?dnRVK0pORkxEN0d1ME51dzh2RkxJZ1A0S2Y0V1NSWFdEM2lXL0VzbEdyWmE2?=
 =?utf-8?B?RlpiQlJ6RGU3SkVSTlc4bmVQd09tRzlNdjg3aDFhZnBaSTVkdEpYOVBjSUNB?=
 =?utf-8?B?LzhmRjlsRkxlaUJpZzVWalJlRUlIZGtLVHVyQkMzcXVNTWw1TXNrbEJGM0o3?=
 =?utf-8?B?cjI3Z3QxdnM1WDdaZ29iU0phcStlQ0VxWmpSTE5ESDZrbEl5c3FEUm95T1du?=
 =?utf-8?B?R0FjY3hJbERrcElDdmdvYUlLeC9ra2FOekZUVVliNmJuejUwZlc3TEYvR2h4?=
 =?utf-8?B?ZUN5Y2RWK29XMzFlRkxWMWNBY2tQMWduajNsdTd6VUoyRnlvSTVvSDBmN0Q0?=
 =?utf-8?B?YTgwdWNkSVI1OFhvMmRpTWplZ0lVRVRLN3FHTHN3R3FnR2IvOE14bkwwaktH?=
 =?utf-8?B?MTN0Nm0wMnE2ZEZpajlFSHMrNzRoYTQwdG1sZk5qZmUzK0xlSHVELzZrSkxH?=
 =?utf-8?B?Z3VNUm1abnNlVGVoV1JpUUlWUmpXa1F6cUdJTVlKOUhzZWJnMXRpaFoycGFX?=
 =?utf-8?B?WTczK0JITWVGQVNsQm53S21PTE4ycDRTSHpaTmZSeXNlbU9XUmRiWTY0Wk5z?=
 =?utf-8?B?VHpMS3EwQkliV2hCZXBwb2YvWkJNdFg4K1pDWHRoSGl6TVYvbXNEUUZsdnZE?=
 =?utf-8?B?UzNmUi9acE9KeDdKSEtLdG1MTkdIRTdST0Y0TkpLeGlpditJUCtNekkrekRw?=
 =?utf-8?B?R1pLTC9FdEp5Q1NEWW9GbnJGMzNBbVJpQjVZR3lXOTRQU1JNUldZTUFHRXVt?=
 =?utf-8?B?OTBIUVBFRE9hUnZFZG9JWXNua3dXNmJaTDRTZjA4c09yK0lpcVpBcTNkY3pI?=
 =?utf-8?B?S0kzMEpzaGhJZmczYVU5ZktHcjdRLzArOC9WWEFsSmt6Q3MvZVhDZnNsUW42?=
 =?utf-8?B?ZXhEZFlHNXlVcFhDM1A3bWxLdzBlSmFMWmR0Ti96UVpieGc0dUZ1VDloelZp?=
 =?utf-8?B?bnNmalA5RThCazZ5b0J4THhIc2VJd1JhZXREWkd3b0N2dzZEcG9TNmtnRGdI?=
 =?utf-8?B?Yzc4cm1iRTlFYzNSMGJsa0tramVGdDVGaTVhMWI0amhlUllabzgrMTlkbVlj?=
 =?utf-8?B?YnhmK2ZxOWhicEhtNjBSeEQ5WkF5OUJxT0JOTGNYbGlEM1MzdFdLMTBiQ3B3?=
 =?utf-8?B?Uld6U3AzTzVzT29ZOTROR2ZwdU1kZ21vVHRhYUZ1VTFsVERIVmo3NGc4K01q?=
 =?utf-8?B?ZFdRRG5BQ2I0T0xwMFdjNGNJV25xYitVZXNoNjFWVGFhS3RtRkFHNkRIQmor?=
 =?utf-8?B?WDF1NTdPQml2WFFOSUVIdzBJTWszSVJWTENkUCtmcTc5VHZya2l5Q2hnZDFY?=
 =?utf-8?B?NGlNdXMxenBRTk1NckpzWmdTV3ZNaWJobEE2WFEvLzRBRlB4RENVTWdpUzRo?=
 =?utf-8?B?aXNOMDBMZytNTlhPcXlmN1dJaERmK3JFNytxMG5MWkxsQmNKMUMzb2huTnBU?=
 =?utf-8?B?c0tWZjgxZFlVYkN6TU41elorMDNob0FlK0ZHQjNqZGNRa2dJM3ZiNHAxcUUz?=
 =?utf-8?B?cm83SWJacTlVZmprdm5qd1B6N0F2K0I3RTNEVHU2UmJ0dU5mSGFFcEdUNEpO?=
 =?utf-8?B?WDJ2VXlkSE1FdWxWVHRIYmtpaWtZL2dPaDJyTHRjNGJvL0RFOUdCUmhzZVRC?=
 =?utf-8?B?TFhjV1MvZVpFamhZUWt2VngwbVBrZGJ6bjQ0cG15V1htalpmZ3Z5S1A2RVp3?=
 =?utf-8?B?Y0hSQVE4emRJVmVVNUNsWFVqRHBtSlpzczJxdWJPbHNqS09QUVRjaVFibUs3?=
 =?utf-8?B?R3pTaWRhczk1a0NzQSsrVWUwU0Z3YUc0UU1pYTRhUGZTdDQrbHlRdDc1MGZu?=
 =?utf-8?B?VERuMFRDc1hqVVJEVm1VYWVoc3BSUk5LVFRwbUh3YXV2Ui9icm5mVnlLUHY2?=
 =?utf-8?Q?BZP4k6AiLDKH4Y1VfCTXRaScNY+6nVCJYhsfiu39mQpno?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: mrNbZkyxinTfD11kLQdBur7ziGAquY93eTrxMBkS2vd0LncEucMqvXo4HMrYAnv+oLRWOTIWxF55N9rrd/EE61zgMMnfSt5Q111vtShKMZv0FFZy6M9+cFxX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673cfd77-8d62-4112-e22b-08dbe0384d13
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 08:54:22.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nq7nyNZe4F5M6W326Y3xK4tI3NUIAjXsfmxxndS0Ic8g966alKRTfOaNKLfCKgk+kyeMOiIX6L12BW3oalpnu7ptRrDYe76U8B+jHjeJkmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=960 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080073
X-Proofpoint-GUID: uhZSP4S10oWnlNHB_yYn-2zj-Ss1uojN
X-Proofpoint-ORIG-GUID: uhZSP4S10oWnlNHB_yYn-2zj-Ss1uojN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yosry Ahmed <yosryahmed@google.com> writes:

> On Tue, Nov 7, 2023 at 11:49=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> =
wrote:
>>
>> On 11/8/23 02:28, Sergey Senozhatsky wrote:
>> > On (23/11/07 15:08), Ankur Arora wrote:
>> > [..]
>> >> +++ b/mm/zsmalloc.c
>> >> @@ -2029,7 +2029,6 @@ static unsigned long __zs_compact(struct zs_poo=
l *pool,
>> >>                      dst_zspage =3D NULL;
>> >>
>> >>                      spin_unlock(&pool->lock);
>> >> -                    cond_resched();
>> >>                      spin_lock(&pool->lock);
>> >>              }
>> >>      }
>> >
>> > I'd personally prefer to have a comment explaining why we do that
>> > spin_unlock/spin_lock sequence, which may look confusing to people.
>>
>> Wonder if it would make sense to have a lock operation that does the
>> unlock/lock as a self-documenting thing, and maybe could also be optimiz=
ed
>> to first check if there's a actually a need for it (because TIF_NEED_RES=
CHED
>> or lock is contended).
>
> +1, I was going to suggest this as well. It can be extended to other
> locking types that disable preemption as well like RCU. Something like
> spin_lock_relax() or something.

Good point. We actually do have exactly that: cond_resched_lock(). (And
similar RW lock variants.)

>> > Maybe would make sense to put a nice comment in all similar cases.
>> > For instance:
>> >
>> >       rcu_read_unlock();
>> >  -    cond_resched();
>> >       rcu_read_lock();

And we have this construct as well: cond_resched_rcu().

I can switch to the alternatives when I send out the next version of
the series.

Thanks

--
ankur
