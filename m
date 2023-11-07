Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183D37E4C84
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbjKGXKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjKGXKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:10:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94651986
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:02 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LKAVv026491;
        Tue, 7 Nov 2023 23:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3uI/fZFeuBr6jA7+6es//f2md0mir79g9QeIhmGXwRI=;
 b=XCt682Da902H1JOx4GpvspdbXkv3cnNlPxXM5GMDD42oyqHH6OM5ueseh2LcB05fudqq
 9UnWndXQyFsIgfscCCK48BKPzXn9kX53kDXTBGG+P+2QfNrlFGP8SFufx7Ln+BvbZRRq
 JCxr2C1gsAGWHphObumbo4DhbSD4s2th/r4pY4kW32Y6lYhZFwkeLfUwx+aswH0ct7TK
 MfJqda06eCfQd0g27c7M4gJlBWxWoC3qr7NAObr5NuSNZzPksNLxde/lSqbaZ66ymRfH
 GVpTID25VeAR2TOmPNKNzk50Bh8oiC7sX073e/yyZdGeNoeqRMnvN1ShIcWez2Zs/FX1 IQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2106vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N3ZLT000474;
        Tue, 7 Nov 2023 23:09:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vcbk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDcafdkPv2AMXR3KeInQtRKujO4TfcUJiGf4PF2BltvUCy5iA/wm7qa39C14/7Wxi8fYa78+OSkIg0whlIGR+TQMUZxVGS+WPrYrpjMplG7+bwyA0U1UuXkX518rJ2A9igDs/m9KvTkDKW5LoXv7KFPjIjMHclxhBQ1BENg6/fQdHwKX+fUvcWhb3+J9EoYct8vjXTeFzXkX+PtawpfWbbgTfjnYGqGvMWK5NbtM7+Xfj9XBQlni43xb/e1UUGDj4HANV4rtOvXYhegb6J1nBtSyw4Onoa2UEDO+mAfgq1BDTpl1Q0pepQqBIXcsScGRafpu0oZs+u9tzTsk1JNJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uI/fZFeuBr6jA7+6es//f2md0mir79g9QeIhmGXwRI=;
 b=L2zTaKlHd4Ff+AfTqKbOvps7RvqgBrcZReEJkH5RfYNBLPSMYTIInZnuvDAC6hdYt2XRMl+ygcocCaGeCFu6dxCcbqVvlrVFWJeTVrXBL5X7KQwKtdj5BoOQwF9YDMkiSc5tDIH6unzGPv8AfUfzvoADl3QJjgCXfzWJXKM2ddA2t7a4su6Nq6WXWIVq83p8P2STt36e432S4HESqyUaEavRQ4yu0so5bA7Se2Ozzfxqz0pPS+B2flv6iS0VYPQM+Qsa/RywrI8tUdhUbmykeJiujHQyAtqIuRWzLE7k3woD6wd3W93xSzILU0jcyPxmlMoMn5J3czKa6vbA+QcYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uI/fZFeuBr6jA7+6es//f2md0mir79g9QeIhmGXwRI=;
 b=ULPGQF/53ERyl7qiIiBXq56ajqYolS+R1MRCImVMuR/RPD7rXo/8/A65J/tJTTKO0bHoj1waJLSZOBgnfjcdKx01yZ/aSiypkbxzqRL71PYM0x6bvwthmrQwrO5qe4D8/7o4fI7IwVBnjTM9R4TcAQQoKjEsQg6EVXe9mnwY8Uk=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:00 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:00 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
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
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
Subject: [RFC PATCH 68/86] treewide: mm: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:04 -0800
Message-Id: <20231107230822.371443-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:a03:80::35) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: e4371a20-9aa2-46da-6ab3-08dbdfe686ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iHVqK5mdApJWfcw7ZLYmLnwwrfmfqkv3UWIjrrGrnl4/GboY4+tu/En5ac4qnpWDONmUOIiE0eWw1IHmwMYAWy2KZCkhZG+/nyV+b93qHQigK9hC4nPUhkKYw8QR77+YC7pFkSww9MIinB8ai2u3488Nn2SIhCkKPXy80J8C7Pto6KgHy8T7c8P0seVzFwa/gMsTS1A3SINXRDira+zrrrCn6H6bR6GxvxfstywXjhWj3mVprSlSAt1dKHAr8a4jC1+mD2MnpXTpjdA8LxUDIy+LTaN1HEgJ5UBCVil+hH1UtwacPE4yFig3NQ54q52pbJR6xG07QQjWZEqbAZRdNyl45mfBS0lZARc/w61oF5cztHIDmE53xauhPWGVEGZGg1DFsf06b8xL2cdd/58zDjeT2BM3LgHgbOPeKHvNfdcWTOGXWmrlKf82Uu2AmIsAz2SE3wvuHJ1bhBnIzN0YtnF1s/DAH7YVJaV8Kr4r1jE6TISqPiLH+INHpRNT4l/ot61YxkSaCSsvvm1AG8BOTQlRhWhV9WckohLTr+tOIn3kmSq1k2QQO6HgP+m+cdbBpFGR5dOZmwzutvYZzsz9QbLi3lxBl/WGMd61gGWQQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(30864003)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7366002)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002)(579004)(559001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FopSakw1Ko0kKgkFKXciaBS33hpYTaLW9JyipZJ3Xt+VPel4zwqCF21RKzF?=
 =?us-ascii?Q?e3gVGsW1TcV+hdCYCZb0uhue4vV2MTdQUoJeQyKHpJ4Buko3gl8W5V9fDsUX?=
 =?us-ascii?Q?dSWRqiIDTvOWeNuagGyMTM/fchUXeZ5fysVqMHCoNIN1HWGYcmx0TDCa9jVK?=
 =?us-ascii?Q?c2v0ZmxkwXxfWMdCPKwhLTEl2rMoJ/eiq08V9r6WLSKdn+WZZwasK4bSWFJS?=
 =?us-ascii?Q?5i6QHwALnETvdIY4jHsLt/v2G/MXzHnP2G/boFI1LYoJRQqMYUovenakl5nx?=
 =?us-ascii?Q?AbtQmIByJ3cV4gDL/QRx4p2q4MdvMQ995T9AExkGgF7x1+Kc2PoPWTIPiXBI?=
 =?us-ascii?Q?VJingZoXPSmNr/CcylwBZIuaKgaFOs2jn6ZVF3fO9unY4sOXExEB4XnixyjF?=
 =?us-ascii?Q?GyZdUn9ctOx2DUzGT5cIhD9jjHQ9lkdRwng/2r6ft7SF+35is8NYahXuP/PK?=
 =?us-ascii?Q?2jdtk4vPXj0+afbEd3WILTOhV7j6rkjttalA+iDsSmZV6oq0hvOjx4oxZ0l4?=
 =?us-ascii?Q?jHieb2MzpJxZ4Pb6phxFmgsb51cua8R9jamZZKJ4EBugisIgqEL2vtK599pX?=
 =?us-ascii?Q?GqqgmL5UmAgqlZvDm27LC5wwl6yA4TejTAghZrXGP3dlwpec8TvngBnD4l+x?=
 =?us-ascii?Q?M/4r9jntZd608nzvCr11tKJIkIPQa89CpEiGYqeUKglVau5SoueYRPjeNATv?=
 =?us-ascii?Q?AwwVEVlBA7BxTkhQHsk9wB5j43epR3W0fb5IXwkODezdm7KJmTXsBnHTr5wN?=
 =?us-ascii?Q?E58/9RkLHoL8a17Ms2NVh0STSVKjMc3N/6QLJKYKGDpwe4tY1OoBNJE3+9vI?=
 =?us-ascii?Q?t+qH4Sr9v4/eRsn3mD/GBt5hlmXjk5VfyXtLHZukpeuB+/x+tMRuIX+E5s5X?=
 =?us-ascii?Q?zfiOrMCNCWEG6KhfJDoFYskDJNwQ8HFOJOrvyMPVRJkQfarG3NlNEKXH5kkU?=
 =?us-ascii?Q?woyJmwFVwBiDC6iR2c3bw9IpKMtwNkkjGQf7ZY7wbiWrm6Lhmb1Aqkwv2AiY?=
 =?us-ascii?Q?VPfS1dxeQ4fULpAnNAutHyc5I9OfxCP++KEK1PvlZd3wuGUt8Uc7wKDPNICk?=
 =?us-ascii?Q?LdxMlF1enSfM8dcjs0PN1af+mgr0yUcasUFZBakSfamCnJKNS9q1vQkUn+sT?=
 =?us-ascii?Q?4m5fpnx0oSMIV7veAJEDesk6XnBbyPBMHMLBn76RfyuGzGEKbsNqdlzSS63Y?=
 =?us-ascii?Q?Cxr2j4Ikix9NGFMvvsqWd+2d2uvHfT3kweERKQ4sEnhJ9P/T/8MLGTcTs1An?=
 =?us-ascii?Q?BE2LU8T9Cmr2aMNdQbkflqZshLwJjGy+kDfvh4IEvVMcBw7ts0EU+vnhci0c?=
 =?us-ascii?Q?CKvYm6zrgDTmlgIbjWSS1s/BUHoVAFSi41JzxWitfl1pSNOkeahocQ7FOMdQ?=
 =?us-ascii?Q?tnN+wVuXeL5ElT3XvZIodZ74HOIO9grAwaEjKbjRv0VgmmGTwXWLTtFfNUqD?=
 =?us-ascii?Q?AtpypVL5/PDRNQZ+XVzDtBDDABMoYyW57WTJfsykTvnJ9m9uXn+p4U3ihW3C?=
 =?us-ascii?Q?NQ9sZLzo+gjLfkO8unVnPoFPNvGe0J+2/M9LuLTqCuWxLt6MJTd5NMRicsHA?=
 =?us-ascii?Q?ktt9d0/WzZZI6atM0C9TEtjMKNVqSn6gozlNvug146xtxacK9yX7Nlg9RvL1?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DLpYkEWB2bK4n0tpbwfJUwoW5uF5KlkkqKBIkfm6ui0H+3L8H+eUO5wsSRku?=
 =?us-ascii?Q?5Mpbkm7YuGmFD15vl0O59n4uciWstjkuPmkhMXvb5W0R9aJ9pSAf8OXnJLmC?=
 =?us-ascii?Q?xLyPvh2CpLalt7oN8JX8Q7cqUOQ5a4uNCDJ1PfhW+w/oxXf+oknhXTmSPoKl?=
 =?us-ascii?Q?wWaxBkjfUdWcbsYlKDnX4/a5b3CopKaGkDojOh80LmeHqUdiEgctjr3ZdaIH?=
 =?us-ascii?Q?zt5AfgQcMamWSgr82gSDuDpBd5lE0r6jYVPJMAztpF1bKDQNfciNTV4GHNyt?=
 =?us-ascii?Q?gGVPt2J/O+QHZ3+h9/52WGAmZggcAs9eH4sHD7XwpeRVb3K2RafbNI+ScSOc?=
 =?us-ascii?Q?XMVo4crD11pd4wBfknprvRWbf1eZJbajoQ9lVvOqxO8DVcuUoEU6TMBzSV4M?=
 =?us-ascii?Q?laGvOl+OBTMGOKcfTrfrdUdQ0Rx/zjpX/kef5DDaQ/U15yB3sY1KXKI55LRu?=
 =?us-ascii?Q?aKBWuqprS9foUPicnK2bttd6e8TJlI3ETC8kYfOXz4+mVC1FxpLRBrcI9+Pt?=
 =?us-ascii?Q?PlL7PPCex/kwGtukscSkUkG4bylwn8UZtusA5DbV0yLrfbuuBy7sjsx2aDLg?=
 =?us-ascii?Q?/BLL511aN8DVBqYeSUHhKsTzDHD7ECiojKHs9k1M9MFNmLjqPumJ2U6MAfmH?=
 =?us-ascii?Q?i/UUMMC72j+imz1FKeWX2RZgh6bzFKPzL8q3oHdMlTOSO6tkoan1aUVeymgP?=
 =?us-ascii?Q?GgwSIXCx/OQssd5idxPVJEJGUNFgbDsXTYAIa5evTHrGlCdvS78vZW9JCJbI?=
 =?us-ascii?Q?N+xlTTPhHCxfu3fNXU/sGTVJ1fGWkjewR8G+K5JMJYR8lCvksI1LgekoYZIB?=
 =?us-ascii?Q?IqaJdG3p3loIXtSX2U8Mrrjv7nR3eCUnXt99boUQ23Nav6qcqE1bZIS/aVx/?=
 =?us-ascii?Q?W46WEp1TdN4/haZ8sKXvu6VMGvkm/eWv38g5AXwwRMPXRy+6XPdSUNTS2iBw?=
 =?us-ascii?Q?8IbL24Fidw58udzMYYCyemU6KZ1E7jFMQQomtr3vTeoq8Wak5icN5NXxfC2+?=
 =?us-ascii?Q?4g1SJLAZ0uXYlqWTdDRVOp3hCDebEP9hZBLlyq1WyGQdgY9SR88lDoV4Fv+Y?=
 =?us-ascii?Q?mKSXYAPyzzxWn7pWzGNZcYx1WwEOsR64wCU4vIqU9TsjJFrNBURKN991fB4C?=
 =?us-ascii?Q?PQK3DRNGgLldZ9QI/dJFGc316FN84yiCmbStmQ5RxLySvemXQz5bwWpGyhpz?=
 =?us-ascii?Q?PZ9C7TbEveyfyLV86dGxeRjBcOyFyLfUqfru5ZMMD4EXiLFHErE2WbQewA02?=
 =?us-ascii?Q?YKa/Vrhz8dW2feeNA6Y6arR6/2Lit2t1muiN8GVlRnms906x8gM0jpZf3nOE?=
 =?us-ascii?Q?AfDGo/M6tG1x2VAqosmg7kwjnPK+2J6aWkqdlKzRSZ28iyqBSUya+1+sa4KQ?=
 =?us-ascii?Q?S4Q/AYHNsxVixJHwenvA84RdHqk5U/FO7E3aYk+62xFFRMAz7MMGDQN0HpNm?=
 =?us-ascii?Q?h9O3pQ0cyiPMGmz+EdB3UAThwMYJ5VOHdKjvxjx+LM4R5sB7PjT95Fnwbhfa?=
 =?us-ascii?Q?snY3M/Wj55GzzP/vPHv+Aq3YvJZ8VwB47W83JMbDxUHfEUfVFVKU4P3kpAuo?=
 =?us-ascii?Q?AzF0/wwQSukNSf+g8zbP81TLH4UzdgjpFBYKgCk9wGFNpIm7GQR3L5LxoFUN?=
 =?us-ascii?Q?T3LPSccm51gNHuI5GI6TvmCD8HEBmLaeLLf3X7Se4YmF9k2eyWQQHSWtJC8n?=
 =?us-ascii?Q?Uvtp/0LV4AihkzuyY+hryFSpmgujptaUHa47TC0EFDJStEvjcfB/egtIlV0V?=
 =?us-ascii?Q?eDntsw4K9Q3V+FTAlCk9NauWUl+LC/0SXmkh22av3Aocapr006eO9mDfwCSr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: 5yPG2gYdWudJghAE/epF9eHuAPIuBHP9aOsvPdV6YeCulyBi5D+jmXoLxekwkMH33d1FkvvG3LcRfFC1Ri++6KhwtYpAv/UcrobFieqaB3RvKspDzW4xD7sw
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4371a20-9aa2-46da-6ab3-08dbdfe686ca
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:00.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyndtLu+I1Gk3UxiwfsM2T8DI/boxg3n4LeOu7t3Sc3BJkjLh7El3ojDTdwc8PNDf+DCatavWXXNQIPCGMgLX7I9jc0JpdzVg1LB4UXGryA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-GUID: VEx-YbWmKrd44qtDJfQl0QM31CdMnzq-
X-Proofpoint-ORIG-GUID: VEx-YbWmKrd44qtDJfQl0QM31CdMnzq-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

Most of the cond_resched() cases here are from set-1, we are
executing in long loops and want to see if rescheduling is
needed.

Now the scheduler can handle rescheduling for those.

There are a few set-2 cases where we give up a lock and reacquire
it.  The unlock will take care of the preemption, but maybe there
should be a cpu_relax() before reacquiring?

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: SeongJae Park <sj@kernel.org> 
Cc: "Matthew Wilcox 
Cc: Mike Kravetz <mike.kravetz@oracle.com> 
Cc: Muchun Song <muchun.song@linux.dev> 
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com> 
Cc: Marco Elver <elver@google.com> 
Cc: Catalin Marinas <catalin.marinas@arm.com> 
Cc: Johannes Weiner <hannes@cmpxchg.org> 
Cc: Michal Hocko <mhocko@kernel.org> 
Cc: Roman Gushchin <roman.gushchin@linux.dev> 
Cc: Shakeel Butt <shakeelb@google.com> 
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com> 
Cc: Miaohe Lin <linmiaohe@huawei.com> 
Cc: David Hildenbrand <david@redhat.com> 
Cc: Oscar Salvador <osalvador@suse.de> 
Cc: Mike Rapoport <rppt@kernel.org> 
Cc: Will Deacon <will@kernel.org> 
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> 
Cc: Nick Piggin <npiggin@gmail.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: Dennis Zhou <dennis@kernel.org> 
Cc: Tejun Heo <tj@kernel.org> 
Cc: Christoph Lameter <cl@linux.com> 
Cc: Hugh Dickins <hughd@google.com> 
Cc: Pekka Enberg <penberg@kernel.org> 
Cc: David Rientjes <rientjes@google.com> 
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com> 
Cc: Vlastimil Babka <vbabka@suse.cz> 
Cc: Vitaly Wool <vitaly.wool@konsulko.com> 
Cc: Minchan Kim <minchan@kernel.org> 
Cc: Sergey Senozhatsky <senozhatsky@chromium.org> 
Cc: Seth Jennings <sjenning@redhat.com> 
Cc: Dan Streetman <ddstreet@ieee.org> 
Cc: linux-mm@kvack.org

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/backing-dev.c        |  8 +++++++-
 mm/compaction.c         | 23 ++++++-----------------
 mm/damon/paddr.c        |  1 -
 mm/dmapool_test.c       |  2 --
 mm/filemap.c            |  6 ------
 mm/gup.c                |  1 -
 mm/huge_memory.c        |  3 ---
 mm/hugetlb.c            | 12 ------------
 mm/hugetlb_cgroup.c     |  1 -
 mm/kasan/quarantine.c   |  6 ++++--
 mm/kfence/kfence_test.c | 22 +---------------------
 mm/khugepaged.c         |  5 -----
 mm/kmemleak.c           |  8 --------
 mm/ksm.c                | 21 ++++-----------------
 mm/madvise.c            |  3 ---
 mm/memcontrol.c         |  4 ----
 mm/memory-failure.c     |  1 -
 mm/memory.c             | 12 +-----------
 mm/memory_hotplug.c     |  6 ------
 mm/mempolicy.c          |  1 -
 mm/migrate.c            |  6 ------
 mm/mincore.c            |  1 -
 mm/mlock.c              |  2 --
 mm/mm_init.c            | 13 +++----------
 mm/mmap.c               |  1 -
 mm/mmu_gather.c         |  2 --
 mm/mprotect.c           |  1 -
 mm/mremap.c             |  1 -
 mm/nommu.c              |  1 -
 mm/page-writeback.c     |  1 -
 mm/page_alloc.c         | 13 ++-----------
 mm/page_counter.c       |  1 -
 mm/page_ext.c           |  1 -
 mm/page_idle.c          |  2 --
 mm/page_io.c            |  2 --
 mm/page_owner.c         |  1 -
 mm/percpu.c             |  5 -----
 mm/rmap.c               |  2 --
 mm/shmem.c              |  9 ---------
 mm/shuffle.c            |  6 ++++--
 mm/slab.c               |  3 ---
 mm/swap_cgroup.c        |  4 ----
 mm/swapfile.c           | 14 --------------
 mm/truncate.c           |  4 ----
 mm/userfaultfd.c        |  3 ---
 mm/util.c               |  1 -
 mm/vmalloc.c            |  5 -----
 mm/vmscan.c             | 29 ++---------------------------
 mm/vmstat.c             |  4 ----
 mm/workingset.c         |  1 -
 mm/z3fold.c             | 15 ++++-----------
 mm/zsmalloc.c           |  1 -
 mm/zswap.c              |  1 -
 53 files changed, 38 insertions(+), 264 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 1e3447bccdb1..22ca90addb35 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -816,8 +816,14 @@ static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
 			continue;
 
 		spin_unlock_irq(&cgwb_lock);
+
+		/*
+		 * cleanup_offline_cgwb() can implicitly reschedule
+		 * on unlock when needed, so just loop here.
+		 */
 		while (cleanup_offline_cgwb(wb))
-			cond_resched();
+			;
+
 		spin_lock_irq(&cgwb_lock);
 
 		wb_put(wb);
diff --git a/mm/compaction.c b/mm/compaction.c
index 38c8d216c6a3..5bca34760fec 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -395,8 +395,6 @@ static void __reset_isolation_suitable(struct zone *zone)
 	 */
 	for (; migrate_pfn < free_pfn; migrate_pfn += pageblock_nr_pages,
 					free_pfn -= pageblock_nr_pages) {
-		cond_resched();
-
 		/* Update the migrate PFN */
 		if (__reset_isolation_pfn(zone, migrate_pfn, true, source_set) &&
 		    migrate_pfn < reset_migrate) {
@@ -571,8 +569,6 @@ static bool compact_unlock_should_abort(spinlock_t *lock,
 		return true;
 	}
 
-	cond_resched();
-
 	return false;
 }
 
@@ -874,8 +870,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			return -EINTR;
 	}
 
-	cond_resched();
-
 	if (cc->direct_compaction && (cc->mode == MIGRATE_ASYNC)) {
 		skip_on_failure = true;
 		next_skip_pfn = block_end_pfn(low_pfn, cc->order);
@@ -923,8 +917,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 				goto fatal_pending;
 			}
-
-			cond_resched();
 		}
 
 		nr_scanned++;
@@ -1681,11 +1673,10 @@ static void isolate_freepages(struct compact_control *cc)
 		unsigned long nr_isolated;
 
 		/*
-		 * This can iterate a massively long zone without finding any
-		 * suitable migration targets, so periodically check resched.
+		 * We can iterate over a massively long zone without finding
+		 * any suitable migration targets. Since we don't disable
+		 * preemption while doing so, expect to be preempted.
 		 */
-		if (!(block_start_pfn % (COMPACT_CLUSTER_MAX * pageblock_nr_pages)))
-			cond_resched();
 
 		page = pageblock_pfn_to_page(block_start_pfn, block_end_pfn,
 									zone);
@@ -2006,12 +1997,10 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 			block_end_pfn += pageblock_nr_pages) {
 
 		/*
-		 * This can potentially iterate a massively long zone with
-		 * many pageblocks unsuitable, so periodically check if we
-		 * need to schedule.
+		 * We can potentially iterate a massively long zone with
+		 * many pageblocks unsuitable. Since we don't disable
+		 * preemption while doing so, expect to be preempted.
 		 */
-		if (!(low_pfn % (COMPACT_CLUSTER_MAX * pageblock_nr_pages)))
-			cond_resched();
 
 		page = pageblock_pfn_to_page(block_start_pfn,
 						block_end_pfn, cc->zone);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 909db25efb35..97eed5e0f89b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -251,7 +251,6 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 		folio_put(folio);
 	}
 	applied = reclaim_pages(&folio_list);
-	cond_resched();
 	return applied * PAGE_SIZE;
 }
 
diff --git a/mm/dmapool_test.c b/mm/dmapool_test.c
index 370fb9e209ef..c519475310e4 100644
--- a/mm/dmapool_test.c
+++ b/mm/dmapool_test.c
@@ -82,8 +82,6 @@ static int dmapool_test_block(const struct dmapool_parms *parms)
 		ret = dmapool_test_alloc(p, blocks);
 		if (ret)
 			goto free_pool;
-		if (need_resched())
-			cond_resched();
 	}
 	end_time = ktime_get();
 
diff --git a/mm/filemap.c b/mm/filemap.c
index dc4dcc5eaf5e..e3c9cf5b33b4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -526,7 +526,6 @@ static void __filemap_fdatawait_range(struct address_space *mapping,
 			folio_clear_error(folio);
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 }
 
@@ -2636,8 +2635,6 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	folio_batch_init(&fbatch);
 
 	do {
-		cond_resched();
-
 		/*
 		 * If we've already successfully copied some data, then we
 		 * can no longer safely return -EIOCBQUEUED. Hence mark
@@ -2910,8 +2907,6 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 	folio_batch_init(&fbatch);
 
 	do {
-		cond_resched();
-
 		if (*ppos >= i_size_read(in->f_mapping->host))
 			break;
 
@@ -3984,7 +3979,6 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 			if (unlikely(status < 0))
 				break;
 		}
-		cond_resched();
 
 		if (unlikely(status == 0)) {
 			/*
diff --git a/mm/gup.c b/mm/gup.c
index 2f8a2d89fde1..f6d913e97d71 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1232,7 +1232,6 @@ static long __get_user_pages(struct mm_struct *mm,
 			ret = -EINTR;
 			goto out;
 		}
-		cond_resched();
 
 		page = follow_page_mask(vma, start, foll_flags, &ctx);
 		if (!page || PTR_ERR(page) == -EMLINK) {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 064fbd90822b..6d48ee94a8c8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2954,7 +2954,6 @@ static void split_huge_pages_all(void)
 			folio_unlock(folio);
 next:
 			folio_put(folio);
-			cond_resched();
 		}
 	}
 
@@ -3044,7 +3043,6 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		folio_unlock(folio);
 next:
 		folio_put(folio);
-		cond_resched();
 	}
 	mmap_read_unlock(mm);
 	mmput(mm);
@@ -3101,7 +3099,6 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		folio_unlock(folio);
 next:
 		folio_put(folio);
-		cond_resched();
 	}
 
 	filp_close(candidate, NULL);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1301ba7b2c9a..d611d256ebc2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1830,8 +1830,6 @@ static void free_hpage_workfn(struct work_struct *work)
 		h = size_to_hstate(page_size(page));
 
 		__update_and_free_hugetlb_folio(h, page_folio(page));
-
-		cond_resched();
 	}
 }
 static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
@@ -1869,7 +1867,6 @@ static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 	list_for_each_entry_safe(page, t_page, list, lru) {
 		folio = page_folio(page);
 		update_and_free_hugetlb_folio(h, folio, false);
-		cond_resched();
 	}
 }
 
@@ -2319,7 +2316,6 @@ int dissolve_free_huge_page(struct page *page)
 		 */
 		if (unlikely(!folio_test_hugetlb_freed(folio))) {
 			spin_unlock_irq(&hugetlb_lock);
-			cond_resched();
 
 			/*
 			 * Theoretically, we should return -EBUSY when we
@@ -2563,7 +2559,6 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 			break;
 		}
 		list_add(&folio->lru, &surplus_list);
-		cond_resched();
 	}
 	allocated += i;
 
@@ -2961,7 +2956,6 @@ static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
 		 * we retry.
 		 */
 		spin_unlock_irq(&hugetlb_lock);
-		cond_resched();
 		goto retry;
 	} else {
 		/*
@@ -3233,7 +3227,6 @@ static void __init gather_bootmem_prealloc(void)
 		 * other side-effects, like CommitLimit going negative.
 		 */
 		adjust_managed_page_count(page, pages_per_huge_page(h));
-		cond_resched();
 	}
 }
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
@@ -3255,7 +3248,6 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 				break;
 			free_huge_folio(folio); /* free it into the hugepage allocator */
 		}
-		cond_resched();
 	}
 	if (i == h->max_huge_pages_node[nid])
 		return;
@@ -3317,7 +3309,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 					 &node_states[N_MEMORY],
 					 node_alloc_noretry))
 			break;
-		cond_resched();
 	}
 	if (i < h->max_huge_pages) {
 		char buf[32];
@@ -3536,9 +3527,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		 */
 		spin_unlock_irq(&hugetlb_lock);
 
-		/* yield cpu to avoid soft lockup */
-		cond_resched();
-
 		ret = alloc_pool_huge_page(h, nodes_allowed,
 						node_alloc_noretry);
 		spin_lock_irq(&hugetlb_lock);
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index dedd2edb076e..a4441f328752 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -235,7 +235,6 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 
 			spin_unlock_irq(&hugetlb_lock);
 		}
-		cond_resched();
 	} while (hugetlb_cgroup_have_usage(h_cg));
 }
 
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 152dca73f398..1a1edadbeb39 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -374,9 +374,11 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 		if (qlist_empty(&global_quarantine[i]))
 			continue;
 		qlist_move_cache(&global_quarantine[i], &to_free, cache);
-		/* Scanning whole quarantine can take a while. */
+		/*
+		 * Scanning whole quarantine can take a while so check if need
+		 * to reschedule after giving up the lock.
+		 */
 		raw_spin_unlock_irqrestore(&quarantine_lock, flags);
-		cond_resched();
 		raw_spin_lock_irqsave(&quarantine_lock, flags);
 	}
 	raw_spin_unlock_irqrestore(&quarantine_lock, flags);
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 95b2b84c296d..29fbc24046b9 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -244,7 +244,7 @@ enum allocation_policy {
 static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocation_policy policy)
 {
 	void *alloc;
-	unsigned long timeout, resched_after;
+	unsigned long timeout;
 	const char *policy_name;
 
 	switch (policy) {
@@ -265,17 +265,6 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
 	kunit_info(test, "%s: size=%zu, gfp=%x, policy=%s, cache=%i\n", __func__, size, gfp,
 		   policy_name, !!test_cache);
 
-	/*
-	 * 100x the sample interval should be more than enough to ensure we get
-	 * a KFENCE allocation eventually.
-	 */
-	timeout = jiffies + msecs_to_jiffies(100 * kfence_sample_interval);
-	/*
-	 * Especially for non-preemption kernels, ensure the allocation-gate
-	 * timer can catch up: after @resched_after, every failed allocation
-	 * attempt yields, to ensure the allocation-gate timer is scheduled.
-	 */
-	resched_after = jiffies + msecs_to_jiffies(kfence_sample_interval);
 	do {
 		if (test_cache)
 			alloc = kmem_cache_alloc(test_cache, gfp);
@@ -307,8 +296,6 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
 
 		test_free(alloc);
 
-		if (time_after(jiffies, resched_after))
-			cond_resched();
 	} while (time_before(jiffies, timeout));
 
 	KUNIT_ASSERT_TRUE_MSG(test, false, "failed to allocate from KFENCE");
@@ -628,7 +615,6 @@ static void test_gfpzero(struct kunit *test)
 			kunit_warn(test, "giving up ... cannot get same object back\n");
 			return;
 		}
-		cond_resched();
 	}
 
 	for (i = 0; i < size; i++)
@@ -755,12 +741,6 @@ static void test_memcache_alloc_bulk(struct kunit *test)
 			}
 		}
 		kmem_cache_free_bulk(test_cache, num, objects);
-		/*
-		 * kmem_cache_alloc_bulk() disables interrupts, and calling it
-		 * in a tight loop may not give KFENCE a chance to switch the
-		 * static branch. Call cond_resched() to let KFENCE chime in.
-		 */
-		cond_resched();
 	} while (!pass && time_before(jiffies, timeout));
 
 	KUNIT_EXPECT_TRUE(test, pass);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4025225ef434..ebec87db5cc1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2361,7 +2361,6 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 	for_each_vma(vmi, vma) {
 		unsigned long hstart, hend;
 
-		cond_resched();
 		if (unlikely(hpage_collapse_test_exit(mm))) {
 			progress++;
 			break;
@@ -2382,7 +2381,6 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 		while (khugepaged_scan.address < hend) {
 			bool mmap_locked = true;
 
-			cond_resched();
 			if (unlikely(hpage_collapse_test_exit(mm)))
 				goto breakouterloop;
 
@@ -2488,8 +2486,6 @@ static void khugepaged_do_scan(struct collapse_control *cc)
 	lru_add_drain_all();
 
 	while (true) {
-		cond_resched();
-
 		if (unlikely(kthread_should_stop() || try_to_freeze()))
 			break;
 
@@ -2721,7 +2717,6 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		int result = SCAN_FAIL;
 
 		if (!mmap_locked) {
-			cond_resched();
 			mmap_read_lock(mm);
 			mmap_locked = true;
 			result = hugepage_vma_revalidate(mm, addr, false, &vma,
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 54c2c90d3abc..9092941cb259 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1394,7 +1394,6 @@ static void scan_large_block(void *start, void *end)
 		next = min(start + MAX_SCAN_SIZE, end);
 		scan_block(start, next, NULL);
 		start = next;
-		cond_resched();
 	}
 }
 #endif
@@ -1439,7 +1438,6 @@ static void scan_object(struct kmemleak_object *object)
 				break;
 
 			raw_spin_unlock_irqrestore(&object->lock, flags);
-			cond_resched();
 			raw_spin_lock_irqsave(&object->lock, flags);
 		} while (object->flags & OBJECT_ALLOCATED);
 	} else
@@ -1466,8 +1464,6 @@ static void scan_gray_list(void)
 	 */
 	object = list_entry(gray_list.next, typeof(*object), gray_list);
 	while (&object->gray_list != &gray_list) {
-		cond_resched();
-
 		/* may add new objects to the list */
 		if (!scan_should_stop())
 			scan_object(object);
@@ -1501,7 +1497,6 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
 	raw_spin_unlock_irq(&kmemleak_lock);
 
 	rcu_read_unlock();
-	cond_resched();
 	rcu_read_lock();
 
 	raw_spin_lock_irq(&kmemleak_lock);
@@ -1584,9 +1579,6 @@ static void kmemleak_scan(void)
 		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 			struct page *page = pfn_to_online_page(pfn);
 
-			if (!(pfn & 63))
-				cond_resched();
-
 			if (!page)
 				continue;
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 981af9c72e7a..df5bca0af731 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -492,7 +492,6 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
 	do {
 		int ksm_page;
 
-		cond_resched();
 		ksm_page = walk_page_range_vma(vma, addr, addr + 1, ops, NULL);
 		if (WARN_ON_ONCE(ksm_page < 0))
 			return ksm_page;
@@ -686,7 +685,6 @@ static void remove_node_from_stable_tree(struct ksm_stable_node *stable_node)
 		stable_node->rmap_hlist_len--;
 		put_anon_vma(rmap_item->anon_vma);
 		rmap_item->address &= PAGE_MASK;
-		cond_resched();
 	}
 
 	/*
@@ -813,6 +811,10 @@ static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
  */
 static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
 {
+	/*
+	 * We are called from many long loops, and for the most part don't
+	 * disable preemption. So expect to be preempted occasionally.
+	 */
 	if (rmap_item->address & STABLE_FLAG) {
 		struct ksm_stable_node *stable_node;
 		struct page *page;
@@ -858,7 +860,6 @@ static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
 		rmap_item->address &= PAGE_MASK;
 	}
 out:
-	cond_resched();		/* we're called from many long loops */
 }
 
 static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
@@ -1000,13 +1001,11 @@ static int remove_all_stable_nodes(void)
 				err = -EBUSY;
 				break;	/* proceed to next nid */
 			}
-			cond_resched();
 		}
 	}
 	list_for_each_entry_safe(stable_node, next, &migrate_nodes, list) {
 		if (remove_stable_node(stable_node))
 			err = -EBUSY;
-		cond_resched();
 	}
 	return err;
 }
@@ -1452,7 +1451,6 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 
 	hlist_for_each_entry_safe(dup, hlist_safe,
 				  &stable_node->hlist, hlist_dup) {
-		cond_resched();
 		/*
 		 * We must walk all stable_node_dup to prune the stale
 		 * stable nodes during lookup.
@@ -1654,7 +1652,6 @@ static struct page *stable_tree_search(struct page *page)
 		struct page *tree_page;
 		int ret;
 
-		cond_resched();
 		stable_node = rb_entry(*new, struct ksm_stable_node, node);
 		stable_node_any = NULL;
 		tree_page = chain_prune(&stable_node_dup, &stable_node,	root);
@@ -1899,7 +1896,6 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
 		struct page *tree_page;
 		int ret;
 
-		cond_resched();
 		stable_node = rb_entry(*new, struct ksm_stable_node, node);
 		stable_node_any = NULL;
 		tree_page = chain(&stable_node_dup, stable_node, root);
@@ -2016,7 +2012,6 @@ struct ksm_rmap_item *unstable_tree_search_insert(struct ksm_rmap_item *rmap_ite
 		struct page *tree_page;
 		int ret;
 
-		cond_resched();
 		tree_rmap_item = rb_entry(*new, struct ksm_rmap_item, node);
 		tree_page = get_mergeable_page(tree_rmap_item);
 		if (!tree_page)
@@ -2350,7 +2345,6 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 						    GET_KSM_PAGE_NOLOCK);
 				if (page)
 					put_page(page);
-				cond_resched();
 			}
 		}
 
@@ -2396,7 +2390,6 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
 			if (IS_ERR_OR_NULL(*page)) {
 				ksm_scan.address += PAGE_SIZE;
-				cond_resched();
 				continue;
 			}
 			if (is_zone_device_page(*page))
@@ -2418,7 +2411,6 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 next_page:
 			put_page(*page);
 			ksm_scan.address += PAGE_SIZE;
-			cond_resched();
 		}
 	}
 
@@ -2489,7 +2481,6 @@ static void ksm_do_scan(unsigned int scan_npages)
 	unsigned int npages = scan_npages;
 
 	while (npages-- && likely(!freezing(current))) {
-		cond_resched();
 		rmap_item = scan_get_next_rmap_item(&page);
 		if (!rmap_item)
 			return;
@@ -2858,7 +2849,6 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
 		struct anon_vma_chain *vmac;
 		struct vm_area_struct *vma;
 
-		cond_resched();
 		if (!anon_vma_trylock_read(anon_vma)) {
 			if (rwc->try_lock) {
 				rwc->contended = true;
@@ -2870,7 +2860,6 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
 					       0, ULONG_MAX) {
 			unsigned long addr;
 
-			cond_resched();
 			vma = vmac->vma;
 
 			/* Ignore the stable/unstable/sqnr flags */
@@ -3046,14 +3035,12 @@ static void ksm_check_stable_tree(unsigned long start_pfn,
 				node = rb_first(root_stable_tree + nid);
 			else
 				node = rb_next(node);
-			cond_resched();
 		}
 	}
 	list_for_each_entry_safe(stable_node, next, &migrate_nodes, list) {
 		if (stable_node->kpfn >= start_pfn &&
 		    stable_node->kpfn < end_pfn)
 			remove_node_from_stable_tree(stable_node);
-		cond_resched();
 	}
 }
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 4dded5d27e7e..3aa53f2e70e2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -225,7 +225,6 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	if (ptep)
 		pte_unmap_unlock(ptep, ptl);
 	swap_read_unplug(splug);
-	cond_resched();
 
 	return 0;
 }
@@ -531,7 +530,6 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	}
 	if (pageout)
 		reclaim_pages(&folio_list);
-	cond_resched();
 
 	return 0;
 }
@@ -755,7 +753,6 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		arch_leave_lazy_mmu_mode();
 		pte_unmap_unlock(start_pte, ptl);
 	}
-	cond_resched();
 
 	return 0;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5b009b233ab8..4bccab7df97f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5650,7 +5650,6 @@ static int mem_cgroup_do_precharge(unsigned long count)
 		if (ret)
 			return ret;
 		mc.precharge++;
-		cond_resched();
 	}
 	return 0;
 }
@@ -6035,7 +6034,6 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 		if (get_mctgt_type(vma, addr, ptep_get(pte), NULL))
 			mc.precharge++;	/* increment precharge temporarily */
 	pte_unmap_unlock(pte - 1, ptl);
-	cond_resched();
 
 	return 0;
 }
@@ -6303,7 +6301,6 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		}
 	}
 	pte_unmap_unlock(pte - 1, ptl);
-	cond_resched();
 
 	if (addr != end) {
 		/*
@@ -6345,7 +6342,6 @@ static void mem_cgroup_move_charge(void)
 		 * feature anyway, so it wouldn't be a big problem.
 		 */
 		__mem_cgroup_clear_mc();
-		cond_resched();
 		goto retry;
 	}
 	/*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4d6e43c88489..f291bb06c37c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -804,7 +804,6 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 	}
 	pte_unmap_unlock(mapped_pte, ptl);
 out:
-	cond_resched();
 	return ret;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 517221f01303..faa36db93f80 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1104,7 +1104,6 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	pte_unmap_unlock(orig_src_pte, src_ptl);
 	add_mm_rss_vec(dst_mm, rss);
 	pte_unmap_unlock(orig_dst_pte, dst_ptl);
-	cond_resched();
 
 	if (ret == -EIO) {
 		VM_WARN_ON_ONCE(!entry.val);
@@ -1573,7 +1572,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 		addr = zap_pte_range(tlb, vma, pmd, addr, next, details);
 		if (addr != next)
 			pmd--;
-	} while (pmd++, cond_resched(), addr != end);
+	} while (pmd++, addr != end);
 
 	return addr;
 }
@@ -1601,7 +1600,6 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 			continue;
 		next = zap_pmd_range(tlb, vma, pud, addr, next, details);
 next:
-		cond_resched();
 	} while (pud++, addr = next, addr != end);
 
 	return addr;
@@ -5926,7 +5924,6 @@ static inline int process_huge_page(
 		l = n;
 		/* Process subpages at the end of huge page */
 		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
-			cond_resched();
 			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
 			if (ret)
 				return ret;
@@ -5937,7 +5934,6 @@ static inline int process_huge_page(
 		l = pages_per_huge_page - n;
 		/* Process subpages at the begin of huge page */
 		for (i = 0; i < base; i++) {
-			cond_resched();
 			ret = process_subpage(addr + i * PAGE_SIZE, i, arg);
 			if (ret)
 				return ret;
@@ -5951,11 +5947,9 @@ static inline int process_huge_page(
 		int left_idx = base + i;
 		int right_idx = base + 2 * l - 1 - i;
 
-		cond_resched();
 		ret = process_subpage(addr + left_idx * PAGE_SIZE, left_idx, arg);
 		if (ret)
 			return ret;
-		cond_resched();
 		ret = process_subpage(addr + right_idx * PAGE_SIZE, right_idx, arg);
 		if (ret)
 			return ret;
@@ -5973,7 +5967,6 @@ static void clear_gigantic_page(struct page *page,
 	might_sleep();
 	for (i = 0; i < pages_per_huge_page; i++) {
 		p = nth_page(page, i);
-		cond_resched();
 		clear_user_highpage(p, addr + i * PAGE_SIZE);
 	}
 }
@@ -6013,7 +6006,6 @@ static int copy_user_gigantic_page(struct folio *dst, struct folio *src,
 		dst_page = folio_page(dst, i);
 		src_page = folio_page(src, i);
 
-		cond_resched();
 		if (copy_mc_user_highpage(dst_page, src_page,
 					  addr + i*PAGE_SIZE, vma)) {
 			memory_failure_queue(page_to_pfn(src_page), 0);
@@ -6085,8 +6077,6 @@ long copy_folio_from_user(struct folio *dst_folio,
 			break;
 
 		flush_dcache_page(subpage);
-
-		cond_resched();
 	}
 	return ret_val;
 }
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1b03f4ec6fd2..2a621f00db1a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -402,7 +402,6 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 					 params->pgmap);
 		if (err)
 			break;
-		cond_resched();
 	}
 	vmemmap_populate_print_last();
 	return err;
@@ -532,8 +531,6 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
 
 	/* Poison struct pages because they are now uninitialized again. */
 	for (pfn = start_pfn; pfn < end_pfn; pfn += cur_nr_pages) {
-		cond_resched();
-
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages =
 			min(end_pfn - pfn, SECTION_ALIGN_UP(pfn + 1) - pfn);
@@ -580,7 +577,6 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
 	}
 
 	for (; pfn < end_pfn; pfn += cur_nr_pages) {
-		cond_resched();
 		/* Select all remaining pages up to the next section boundary */
 		cur_nr_pages = min(end_pfn - pfn,
 				   SECTION_ALIGN_UP(pfn + 1) - pfn);
@@ -1957,8 +1953,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 				goto failed_removal_isolated;
 			}
 
-			cond_resched();
-
 			ret = scan_movable_pages(pfn, end_pfn, &pfn);
 			if (!ret) {
 				/*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 29ebf1e7898c..fa201f89568e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -554,7 +554,6 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 			break;
 	}
 	pte_unmap_unlock(mapped_pte, ptl);
-	cond_resched();
 
 	return addr != end ? -EIO : 0;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 06086dc9da28..6b0d0d4f07d8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1528,8 +1528,6 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
 
 			nr_pages = folio_nr_pages(folio);
 
-			cond_resched();
-
 			/*
 			 * Migratability of hugepages depends on architectures and
 			 * their size.  This check is necessary because some callers
@@ -1633,8 +1631,6 @@ static int migrate_pages_batch(struct list_head *from,
 			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
 			nr_pages = folio_nr_pages(folio);
 
-			cond_resched();
-
 			/*
 			 * Large folio migration might be unsupported or
 			 * the allocation might be failed so we should retry
@@ -1754,8 +1750,6 @@ static int migrate_pages_batch(struct list_head *from,
 			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
 			nr_pages = folio_nr_pages(folio);
 
-			cond_resched();
-
 			rc = migrate_folio_move(put_new_folio, private,
 						folio, dst, mode,
 						reason, ret_folios);
diff --git a/mm/mincore.c b/mm/mincore.c
index dad3622cc963..46a1716621d1 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -151,7 +151,6 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_unmap_unlock(ptep - 1, ptl);
 out:
 	walk->private += nr;
-	cond_resched();
 	return 0;
 }
 
diff --git a/mm/mlock.c b/mm/mlock.c
index 06bdfab83b58..746ca30145b5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -351,7 +351,6 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	pte_unmap(start_pte);
 out:
 	spin_unlock(ptl);
-	cond_resched();
 	return 0;
 }
 
@@ -696,7 +695,6 @@ static int apply_mlockall_flags(int flags)
 		/* Ignore errors */
 		mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
 			    newflags);
-		cond_resched();
 	}
 out:
 	return 0;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 50f2f34745af..88d27009800e 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -892,10 +892,8 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		 * such that unmovable allocations won't be scattered all
 		 * over the place during system boot.
 		 */
-		if (pageblock_aligned(pfn)) {
+		if (pageblock_aligned(pfn))
 			set_pageblock_migratetype(page, migratetype);
-			cond_resched();
-		}
 		pfn++;
 	}
 }
@@ -996,10 +994,8 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
 	 * because this is done early in section_activate()
 	 */
-	if (pageblock_aligned(pfn)) {
+	if (pageblock_aligned(pfn))
 		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		cond_resched();
-	}
 
 	/*
 	 * ZONE_DEVICE pages are released directly to the driver page allocator
@@ -2163,10 +2159,8 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 	 * Initialize and free pages in MAX_ORDER sized increments so that we
 	 * can avoid introducing any issues with the buddy allocator.
 	 */
-	while (spfn < end_pfn) {
+	while (spfn < end_pfn)
 		deferred_init_maxorder(&i, zone, &spfn, &epfn);
-		cond_resched();
-	}
 }
 
 /* An arch may override for more concurrency. */
@@ -2365,7 +2359,6 @@ void set_zone_contiguous(struct zone *zone)
 		if (!__pageblock_pfn_to_page(block_start_pfn,
 					     block_end_pfn, zone))
 			return;
-		cond_resched();
 	}
 
 	/* We confirm that there is no hole */
diff --git a/mm/mmap.c b/mm/mmap.c
index 9e018d8dd7d6..436c255f4f45 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3253,7 +3253,6 @@ void exit_mmap(struct mm_struct *mm)
 			nr_accounted += vma_pages(vma);
 		remove_vma(vma, true);
 		count++;
-		cond_resched();
 	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
 
 	BUG_ON(count != mm->map_count);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 4f559f4ddd21..dbf660a14469 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -98,8 +98,6 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 			free_pages_and_swap_cache(pages, nr);
 			pages += nr;
 			batch->nr -= nr;
-
-			cond_resched();
 		} while (batch->nr);
 	}
 	tlb->active = &tlb->local;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b94fbb45d5c7..45af8b1aac59 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -423,7 +423,6 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 			goto again;
 		pages += ret;
 next:
-		cond_resched();
 	} while (pmd++, addr = next, addr != end);
 
 	if (range.start)
diff --git a/mm/mremap.c b/mm/mremap.c
index 382e81c33fc4..26f06349558e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -514,7 +514,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 
 	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
-		cond_resched();
 		/*
 		 * If extent is PUD-sized try to speed up the move by moving at the
 		 * PUD level if possible.
diff --git a/mm/nommu.c b/mm/nommu.c
index 7f9e9e5a0e12..54cb28e9919d 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1525,7 +1525,6 @@ void exit_mmap(struct mm_struct *mm)
 	for_each_vma(vmi, vma) {
 		cleanup_vma_from_mm(vma);
 		delete_vma(mm, vma);
-		cond_resched();
 	}
 	__mt_destroy(&mm->mm_mt);
 	mmap_write_unlock(mm);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 61a190b9d83c..582cb5a72467 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2510,7 +2510,6 @@ int write_cache_pages(struct address_space *mapping,
 			}
 		}
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 
 	/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 85741403948f..c7e7a236de3d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3418,8 +3418,6 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	 */
 	count_vm_event(COMPACTFAIL);
 
-	cond_resched();
-
 	return NULL;
 }
 
@@ -3617,8 +3615,6 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 	unsigned int noreclaim_flag;
 	unsigned long progress;
 
-	cond_resched();
-
 	/* We now go into synchronous reclaim */
 	cpuset_memory_pressure_bump();
 	fs_reclaim_acquire(gfp_mask);
@@ -3630,8 +3626,6 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(gfp_mask);
 
-	cond_resched();
-
 	return progress;
 }
 
@@ -3852,13 +3846,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	 * Memory allocation/reclaim might be called from a WQ context and the
 	 * current implementation of the WQ concurrency control doesn't
 	 * recognize that a particular WQ is congested if the worker thread is
-	 * looping without ever sleeping. Therefore we have to do a short sleep
-	 * here rather than calling cond_resched().
+	 * looping without ever sleeping. Therefore do a short sleep here.
 	 */
 	if (current->flags & PF_WQ_WORKER)
 		schedule_timeout_uninterruptible(1);
-	else
-		cond_resched();
+
 	return ret;
 }
 
@@ -4162,7 +4154,6 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		if (page)
 			goto got_pg;
 
-		cond_resched();
 		goto retry;
 	}
 fail:
diff --git a/mm/page_counter.c b/mm/page_counter.c
index db20d6452b71..c15befd5b02a 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -196,7 +196,6 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 			return 0;
 
 		counter->max = old;
-		cond_resched();
 	}
 }
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4548fcc66d74..855271588c8c 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -472,7 +472,6 @@ void __init page_ext_init(void)
 				continue;
 			if (init_section_page_ext(pfn, nid))
 				goto oom;
-			cond_resched();
 		}
 	}
 	hotplug_memory_notifier(page_ext_callback, DEFAULT_CALLBACK_PRI);
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 41ea77f22011..694eb1b14a66 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -151,7 +151,6 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
 		}
 		if (bit == BITMAP_CHUNK_BITS - 1)
 			out++;
-		cond_resched();
 	}
 	return (char *)out - buf;
 }
@@ -188,7 +187,6 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 		}
 		if (bit == BITMAP_CHUNK_BITS - 1)
 			in++;
-		cond_resched();
 	}
 	return (char *)in - buf;
 }
diff --git a/mm/page_io.c b/mm/page_io.c
index fe4c21af23f2..02bbc8165400 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -106,8 +106,6 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 		unsigned block_in_page;
 		sector_t first_block;
 
-		cond_resched();
-
 		first_block = probe_block;
 		ret = bmap(inode, &first_block);
 		if (ret || !first_block)
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 4e2723e1b300..72278db2f01c 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -680,7 +680,6 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 ext_put_continue:
 			page_ext_put(page_ext);
 		}
-		cond_resched();
 	}
 
 	pr_info("Node %d, zone %8s: page owner found early allocated %lu pages\n",
diff --git a/mm/percpu.c b/mm/percpu.c
index a7665de8485f..538b63f399ae 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2015,7 +2015,6 @@ static void pcpu_balance_free(bool empty_only)
 			spin_unlock_irq(&pcpu_lock);
 		}
 		pcpu_destroy_chunk(chunk);
-		cond_resched();
 	}
 	spin_lock_irq(&pcpu_lock);
 }
@@ -2083,7 +2082,6 @@ static void pcpu_balance_populated(void)
 
 			spin_unlock_irq(&pcpu_lock);
 			ret = pcpu_populate_chunk(chunk, rs, rs + nr, gfp);
-			cond_resched();
 			spin_lock_irq(&pcpu_lock);
 			if (!ret) {
 				nr_to_pop -= nr;
@@ -2101,7 +2099,6 @@ static void pcpu_balance_populated(void)
 		/* ran out of chunks to populate, create a new one and retry */
 		spin_unlock_irq(&pcpu_lock);
 		chunk = pcpu_create_chunk(gfp);
-		cond_resched();
 		spin_lock_irq(&pcpu_lock);
 		if (chunk) {
 			pcpu_chunk_relocate(chunk, -1);
@@ -2186,7 +2183,6 @@ static void pcpu_reclaim_populated(void)
 
 			spin_unlock_irq(&pcpu_lock);
 			pcpu_depopulate_chunk(chunk, i + 1, end + 1);
-			cond_resched();
 			spin_lock_irq(&pcpu_lock);
 
 			pcpu_chunk_depopulated(chunk, i + 1, end + 1);
@@ -2203,7 +2199,6 @@ static void pcpu_reclaim_populated(void)
 			pcpu_post_unmap_tlb_flush(chunk,
 						  freed_page_start,
 						  freed_page_end);
-			cond_resched();
 			spin_lock_irq(&pcpu_lock);
 		}
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 9f795b93cf40..c7aec4516309 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2434,7 +2434,6 @@ static void rmap_walk_anon(struct folio *folio,
 		unsigned long address = vma_address(&folio->page, vma);
 
 		VM_BUG_ON_VMA(address == -EFAULT, vma);
-		cond_resched();
 
 		if (rwc->invalid_vma && rwc->invalid_vma(vma, rwc->arg))
 			continue;
@@ -2495,7 +2494,6 @@ static void rmap_walk_file(struct folio *folio,
 		unsigned long address = vma_address(&folio->page, vma);
 
 		VM_BUG_ON_VMA(address == -EFAULT, vma);
-		cond_resched();
 
 		if (rwc->invalid_vma && rwc->invalid_vma(vma, rwc->arg))
 			continue;
diff --git a/mm/shmem.c b/mm/shmem.c
index 112172031b2c..0280fe449ad8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -939,7 +939,6 @@ void shmem_unlock_mapping(struct address_space *mapping)
 	       filemap_get_folios(mapping, &index, ~0UL, &fbatch)) {
 		check_move_unevictable_folios(&fbatch);
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 }
 
@@ -1017,7 +1016,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 
 	/*
@@ -1058,8 +1056,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
 	index = start;
 	while (index < end) {
-		cond_resched();
-
 		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
 				indices)) {
 			/* If all gone or hole-punch or unfalloc, we're done */
@@ -1394,7 +1390,6 @@ int shmem_unuse(unsigned int type)
 		mutex_unlock(&shmem_swaplist_mutex);
 
 		error = shmem_unuse_inode(&info->vfs_inode, type);
-		cond_resched();
 
 		mutex_lock(&shmem_swaplist_mutex);
 		next = list_next_entry(info, swaplist);
@@ -2832,7 +2827,6 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			error = -EFAULT;
 			break;
 		}
-		cond_resched();
 	}
 
 	*ppos = ((loff_t) index << PAGE_SHIFT) + offset;
@@ -2986,8 +2980,6 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 		in->f_ra.prev_pos = *ppos;
 		if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
 			break;
-
-		cond_resched();
 	} while (len);
 
 	if (folio)
@@ -3155,7 +3147,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		folio_mark_dirty(folio);
 		folio_unlock(folio);
 		folio_put(folio);
-		cond_resched();
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
diff --git a/mm/shuffle.c b/mm/shuffle.c
index fb1393b8b3a9..f78f201c773b 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -136,10 +136,12 @@ void __meminit __shuffle_zone(struct zone *z)
 
 		pr_debug("%s: swap: %#lx -> %#lx\n", __func__, i, j);
 
-		/* take it easy on the zone lock */
+		/*
+		 * Drop the zone lock occasionally to allow the scheduler to
+		 * preempt us if needed.
+		 */
 		if ((i % (100 * order_pages)) == 0) {
 			spin_unlock_irqrestore(&z->lock, flags);
-			cond_resched();
 			spin_lock_irqsave(&z->lock, flags);
 		}
 	}
diff --git a/mm/slab.c b/mm/slab.c
index 9ad3d0f2d1a5..7681d2cb5e64 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2196,8 +2196,6 @@ static int drain_freelist(struct kmem_cache *cache,
 		raw_spin_unlock_irq(&n->list_lock);
 		slab_destroy(cache, slab);
 		nr_freed++;
-
-		cond_resched();
 	}
 out:
 	return nr_freed;
@@ -3853,7 +3851,6 @@ static void cache_reap(struct work_struct *w)
 			STATS_ADD_REAPED(searchp, freed);
 		}
 next:
-		cond_resched();
 	}
 	check_irq_on();
 	mutex_unlock(&slab_mutex);
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index db6c4a26cf59..20d2aefbefd6 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -50,8 +50,6 @@ static int swap_cgroup_prepare(int type)
 			goto not_enough_page;
 		ctrl->map[idx] = page;
 
-		if (!(idx % SWAP_CLUSTER_MAX))
-			cond_resched();
 	}
 	return 0;
 not_enough_page:
@@ -223,8 +221,6 @@ void swap_cgroup_swapoff(int type)
 			struct page *page = map[i];
 			if (page)
 				__free_page(page);
-			if (!(i % SWAP_CLUSTER_MAX))
-				cond_resched();
 		}
 		vfree(map);
 	}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e52f486834eb..27db3dcec1a2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -190,7 +190,6 @@ static int discard_swap(struct swap_info_struct *si)
 				nr_blocks, GFP_KERNEL);
 		if (err)
 			return err;
-		cond_resched();
 	}
 
 	for (se = next_se(se); se; se = next_se(se)) {
@@ -201,8 +200,6 @@ static int discard_swap(struct swap_info_struct *si)
 				nr_blocks, GFP_KERNEL);
 		if (err)
 			break;
-
-		cond_resched();
 	}
 	return err;		/* That will often be -EOPNOTSUPP */
 }
@@ -864,7 +861,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 				goto checks;
 			}
 			if (unlikely(--latency_ration < 0)) {
-				cond_resched();
 				latency_ration = LATENCY_LIMIT;
 			}
 		}
@@ -931,7 +927,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		if (n_ret)
 			goto done;
 		spin_unlock(&si->lock);
-		cond_resched();
 		spin_lock(&si->lock);
 		latency_ration = LATENCY_LIMIT;
 	}
@@ -974,7 +969,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	spin_unlock(&si->lock);
 	while (++offset <= READ_ONCE(si->highest_bit)) {
 		if (unlikely(--latency_ration < 0)) {
-			cond_resched();
 			latency_ration = LATENCY_LIMIT;
 			scanned_many = true;
 		}
@@ -984,7 +978,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	offset = si->lowest_bit;
 	while (offset < scan_base) {
 		if (unlikely(--latency_ration < 0)) {
-			cond_resched();
 			latency_ration = LATENCY_LIMIT;
 			scanned_many = true;
 		}
@@ -1099,7 +1092,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 		spin_unlock(&si->lock);
 		if (n_ret || size == SWAPFILE_CLUSTER)
 			goto check_out;
-		cond_resched();
 
 		spin_lock(&swap_avail_lock);
 nextsi:
@@ -1914,7 +1906,6 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		cond_resched();
 		next = pmd_addr_end(addr, end);
 		ret = unuse_pte_range(vma, pmd, addr, next, type);
 		if (ret)
@@ -1997,8 +1988,6 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
 			if (ret)
 				break;
 		}
-
-		cond_resched();
 	}
 	mmap_read_unlock(mm);
 	return ret;
@@ -2025,8 +2014,6 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 		count = READ_ONCE(si->swap_map[i]);
 		if (count && swap_count(count) != SWAP_MAP_BAD)
 			break;
-		if ((i % LATENCY_LIMIT) == 0)
-			cond_resched();
 	}
 
 	if (i == si->max)
@@ -2079,7 +2066,6 @@ static int try_to_unuse(unsigned int type)
 		 * Make sure that we aren't completely killing
 		 * interactive performance.
 		 */
-		cond_resched();
 		spin_lock(&mmlist_lock);
 	}
 	spin_unlock(&mmlist_lock);
diff --git a/mm/truncate.c b/mm/truncate.c
index 8e3aa9e8618e..9efcec90f24d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -369,7 +369,6 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		for (i = 0; i < folio_batch_count(&fbatch); i++)
 			folio_unlock(fbatch.folios[i]);
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 
 	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
@@ -399,7 +398,6 @@ void truncate_inode_pages_range(struct address_space *mapping,
 
 	index = start;
 	while (index < end) {
-		cond_resched();
 		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
 				indices)) {
 			/* If all gone from start onwards, we're done */
@@ -533,7 +531,6 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 	return count;
 }
@@ -677,7 +674,6 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 		}
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
-		cond_resched();
 	}
 	/*
 	 * For DAX we invalidate page tables after invalidating page cache.  We
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 96d9eae5c7cc..89127f6b8bd7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -459,8 +459,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		hugetlb_vma_unlock_read(dst_vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-		cond_resched();
-
 		if (unlikely(err == -ENOENT)) {
 			mmap_read_unlock(dst_mm);
 			BUG_ON(!folio);
@@ -677,7 +675,6 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 
 		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
 				       src_addr, flags, &folio);
-		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
 			void *kaddr;
diff --git a/mm/util.c b/mm/util.c
index 8cbbfd3a3d59..3bc08be921fa 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -796,7 +796,6 @@ void folio_copy(struct folio *dst, struct folio *src)
 		copy_highpage(folio_page(dst, i), folio_page(src, i));
 		if (++i == nr)
 			break;
-		cond_resched();
 	}
 }
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a3fedb3ee0db..7d2b76cde1a7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -351,8 +351,6 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
 		vunmap_pte_range(pmd, addr, next, mask);
-
-		cond_resched();
 	} while (pmd++, addr = next, addr != end);
 }
 
@@ -2840,7 +2838,6 @@ void vfree(const void *addr)
 		 * can be freed as an array of order-0 allocations
 		 */
 		__free_page(page);
-		cond_resched();
 	}
 	atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
 	kvfree(vm->pages);
@@ -3035,7 +3032,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 							pages + nr_allocated);
 
 			nr_allocated += nr;
-			cond_resched();
 
 			/*
 			 * If zero or pages were obtained partly,
@@ -3091,7 +3087,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		for (i = 0; i < (1U << order); i++)
 			pages[nr_allocated + i] = page + i;
 
-		cond_resched();
 		nr_allocated += 1U << order;
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..e12f9fd27002 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -905,8 +905,6 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
 		total_scan -= shrinkctl->nr_scanned;
 		scanned += shrinkctl->nr_scanned;
-
-		cond_resched();
 	}
 
 	/*
@@ -1074,7 +1072,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 
 	up_read(&shrinker_rwsem);
 out:
-	cond_resched();
 	return freed;
 }
 
@@ -1204,7 +1201,6 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	 */
 	if (!current_is_kswapd() &&
 	    current->flags & (PF_USER_WORKER|PF_KTHREAD)) {
-		cond_resched();
 		return;
 	}
 
@@ -1232,7 +1228,6 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 		fallthrough;
 	case VMSCAN_THROTTLE_NOPROGRESS:
 		if (skip_throttle_noprogress(pgdat)) {
-			cond_resched();
 			return;
 		}
 
@@ -1715,7 +1710,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	struct swap_iocb *plug = NULL;
 
 	memset(stat, 0, sizeof(*stat));
-	cond_resched();
 	do_demote_pass = can_demote(pgdat->node_id, sc);
 
 retry:
@@ -1726,8 +1720,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		bool dirty, writeback;
 		unsigned int nr_pages;
 
-		cond_resched();
-
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
 
@@ -2719,7 +2711,6 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	while (!list_empty(&l_hold)) {
 		struct folio *folio;
 
-		cond_resched();
 		folio = lru_to_folio(&l_hold);
 		list_del(&folio->lru);
 
@@ -4319,8 +4310,6 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 			reset_batch_size(lruvec, walk);
 			spin_unlock_irq(&lruvec->lru_lock);
 		}
-
-		cond_resched();
 	} while (err == -EAGAIN);
 }
 
@@ -4455,7 +4444,6 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 			continue;
 
 		spin_unlock_irq(&lruvec->lru_lock);
-		cond_resched();
 		goto restart;
 	}
 
@@ -4616,8 +4604,6 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 			mem_cgroup_iter_break(NULL, memcg);
 			return;
 		}
-
-		cond_resched();
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
 
 	/*
@@ -5378,8 +5364,6 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 
 		if (sc->nr_reclaimed >= nr_to_reclaim)
 			break;
-
-		cond_resched();
 	}
 
 	/* whether try_to_inc_max_seq() was successful */
@@ -5718,14 +5702,11 @@ static void lru_gen_change_state(bool enabled)
 
 			while (!(enabled ? fill_evictable(lruvec) : drain_evictable(lruvec))) {
 				spin_unlock_irq(&lruvec->lru_lock);
-				cond_resched();
 				spin_lock_irq(&lruvec->lru_lock);
 			}
 
 			spin_unlock_irq(&lruvec->lru_lock);
 		}
-
-		cond_resched();
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
 unlock:
 	mutex_unlock(&state_mutex);
@@ -6026,8 +6007,6 @@ static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct scan_co
 
 		if (!evict_folios(lruvec, sc, swappiness))
 			return 0;
-
-		cond_resched();
 	}
 
 	return -EINTR;
@@ -6321,8 +6300,6 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 			}
 		}
 
-		cond_resched();
-
 		if (nr_reclaimed < nr_to_reclaim || proportional_reclaim)
 			continue;
 
@@ -6473,10 +6450,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		 * This loop can become CPU-bound when target memcgs
 		 * aren't eligible for reclaim - either because they
 		 * don't have any reclaimable pages, or because their
-		 * memory is explicitly protected. Avoid soft lockups.
+		 * memory is explicitly protected. We don't disable
+		 * preemption, so expect to be preempted.
 		 */
-		cond_resched();
-
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
 		if (mem_cgroup_below_min(target_memcg, memcg)) {
@@ -8024,7 +8000,6 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,
 					   sc.gfp_mask);
 
-	cond_resched();
 	psi_memstall_enter(&pflags);
 	fs_reclaim_acquire(sc.gfp_mask);
 	/*
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 00e81e99c6ee..de61cc004865 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -835,7 +835,6 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 #ifdef CONFIG_NUMA
 
 		if (do_pagesets) {
-			cond_resched();
 			/*
 			 * Deal with draining the remote pageset of this
 			 * processor
@@ -1525,7 +1524,6 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 			}
 			seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
 			spin_unlock_irq(&zone->lock);
-			cond_resched();
 			spin_lock_irq(&zone->lock);
 		}
 		seq_putc(m, '\n');
@@ -2041,8 +2039,6 @@ static void vmstat_shepherd(struct work_struct *w)
 
 		if (!delayed_work_pending(dw) && need_update(cpu))
 			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
-
-		cond_resched();
 	}
 	cpus_read_unlock();
 
diff --git a/mm/workingset.c b/mm/workingset.c
index da58a26d0d4d..ba94e5fb8390 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -750,7 +750,6 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	}
 	ret = LRU_REMOVED_RETRY;
 out:
-	cond_resched();
 	spin_lock_irq(lru_lock);
 	return ret;
 }
diff --git a/mm/z3fold.c b/mm/z3fold.c
index 7c76b396b74c..2614236c2212 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -175,7 +175,7 @@ enum z3fold_handle_flags {
 /*
  * Forward declarations
  */
-static struct z3fold_header *__z3fold_alloc(struct z3fold_pool *, size_t, bool);
+static struct z3fold_header *__z3fold_alloc(struct z3fold_pool *, size_t);
 static void compact_page_work(struct work_struct *w);
 
 /*****************
@@ -504,7 +504,6 @@ static void free_pages_work(struct work_struct *w)
 		spin_unlock(&pool->stale_lock);
 		cancel_work_sync(&zhdr->work);
 		free_z3fold_page(page, false);
-		cond_resched();
 		spin_lock(&pool->stale_lock);
 	}
 	spin_unlock(&pool->stale_lock);
@@ -629,7 +628,7 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 		short chunks = size_to_chunks(sz);
 		void *q;
 
-		new_zhdr = __z3fold_alloc(pool, sz, false);
+		new_zhdr = __z3fold_alloc(pool, sz);
 		if (!new_zhdr)
 			return NULL;
 
@@ -783,7 +782,7 @@ static void compact_page_work(struct work_struct *w)
 
 /* returns _locked_ z3fold page header or NULL */
 static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
-						size_t size, bool can_sleep)
+						   size_t size)
 {
 	struct z3fold_header *zhdr = NULL;
 	struct page *page;
@@ -811,8 +810,6 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 			spin_unlock(&pool->lock);
 			zhdr = NULL;
 			migrate_enable();
-			if (can_sleep)
-				cond_resched();
 			goto lookup;
 		}
 		list_del_init(&zhdr->buddy);
@@ -825,8 +822,6 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 			z3fold_page_unlock(zhdr);
 			zhdr = NULL;
 			migrate_enable();
-			if (can_sleep)
-				cond_resched();
 			goto lookup;
 		}
 
@@ -869,8 +864,6 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 			    test_bit(PAGE_CLAIMED, &page->private)) {
 				z3fold_page_unlock(zhdr);
 				zhdr = NULL;
-				if (can_sleep)
-					cond_resched();
 				continue;
 			}
 			kref_get(&zhdr->refcount);
@@ -1016,7 +1009,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 		bud = HEADLESS;
 	else {
 retry:
-		zhdr = __z3fold_alloc(pool, size, can_sleep);
+		zhdr = __z3fold_alloc(pool, size);
 		if (zhdr) {
 			bud = get_free_buddy(zhdr, chunks);
 			if (bud == HEADLESS) {
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b58f957429f0..e6fe6522c845 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2029,7 +2029,6 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			dst_zspage = NULL;
 
 			spin_unlock(&pool->lock);
-			cond_resched();
 			spin_lock(&pool->lock);
 		}
 	}
diff --git a/mm/zswap.c b/mm/zswap.c
index 37d2b1cb2ecb..ad6d67ebbf70 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -704,7 +704,6 @@ static void shrink_worker(struct work_struct *w)
 			if (++failures == MAX_RECLAIM_RETRIES)
 				break;
 		}
-		cond_resched();
 	} while (!zswap_can_accept());
 	zswap_pool_put(pool);
 }
-- 
2.31.1

