Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3C477C0A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjHNTU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjHNTUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:20:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FBF10FA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:20:01 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EGTtbH017837;
        Mon, 14 Aug 2023 19:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=mLtCbFjAw1X6E6WWtmYFLNLG8wI+Rwq/V8Wzyk5rXkE=;
 b=GC78u2KrQjJVklGTAqUjsWWZofS4/maNHPxAw33CgG8fPf2CldkqG0+mLeUbWAsehE3R
 GZi0elJvRmR39zYYHriQPfGUyF/+XYjixmmCj7JnWs47S/WlUuznAuJjfLnhsCWn5O8E
 fnX4KV/AUst2mt335/d1AjozcOgI++LPUE+Q04eELaqIuiz30n5AjPL8wvjRuuVTx43q
 eCSaUXibbsw13ygKw8Hs3amRRwpHr76QKzq57vRbVltJOoOpHH8qReFpuztA8ZyPZ6rB
 P9QYpzuHk2JEhE51CkGOTW/J7OtjzSXHwGlNpZ8u0A5QcqwKZc7KLJUmbAFVa2D9l92C fQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c396s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 19:19:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EIOsSL040350;
        Mon, 14 Aug 2023 19:19:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0q1uwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 19:19:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8YsQdZunWMeKDII65q9U67xHP++QkngCNUFz5lpk2S7cPM2xw0UefM7dq4vLOuyDqJbBDxFNT8K+h2sHw5JBlXAz895l/3yR3+BQtcgelz9vPTFWVhTKz5vyNyZDV1CdGaTuMt7Ahf7xRCDwUj9ymnanpDQsz+e/ru/KXw5/8Rfp1ptKf8o9trUJw4nIPNoHOlWIzXZpPB1JEGiBlQCRGzeOwnL5Sf+NKsPpzcFBty11SX+4kbO9PyltNek1IOFAeVIvPlqybMSrRimrePVOM4LyjKqDlSWHT18o+I9wvSU0jodIjg8ZICQSHWxQWv6e0xjDrmmVo4bsjv5JeJ+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLtCbFjAw1X6E6WWtmYFLNLG8wI+Rwq/V8Wzyk5rXkE=;
 b=IcAid7cBXAmBAre1ycXHCmTJj2s238SiZ7GogatERFhVNjenHch73KUl97o8amIkXlHrhivSIalKTm/Xckcr3D8n2/VSgsMuweZlItXwmXoPxNHcrDVDy55Ofrr1MAKdUMuiHt8RHDHAgIhkutsWLcmSmJ5vgPunBSdi7qj65buR2TG4JDSgWsk1636C2TdECqcqM82mDgP5tlGMHoiA7jjM6Mza4kimJLhLMTRSLKpZQ8prcm4QSW9mamBdPOjINpaHdwpsQp8kjlQnBDa07FXXbFKdrzKFNp6Lsp6QONv0H8cxqxqQ3EeH5I38yuk0ubcUxBUqDZzvowwl48VcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLtCbFjAw1X6E6WWtmYFLNLG8wI+Rwq/V8Wzyk5rXkE=;
 b=abV1PrLEppViKnHsYUAt++EevE0DgdsfryzLs+7ZoiaHYXjhB+8mrB1Mct1C3ly9AG7vd0tEm+v9p3egLzu7jS3B/ab9c0fhn1kABVKx3yCLN5x4IE0ZePPK1iQ7klFAX2efdg/zowhMs81wVWNs96s9p/SoIbXLAhhdHceekeM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB7078.namprd10.prod.outlook.com (2603:10b6:510:288::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 19:19:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 19:19:25 +0000
Date:   Mon, 14 Aug 2023 15:19:22 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        torvalds@linux-foundation.org, willy@infradead.org,
        david@redhat.com, peterx@redhat.com, ldufour@linux.ibm.com,
        vbabka@suse.cz, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, hannes@cmpxchg.org, dave@stgolabs.net,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 5/6] mm: always lock new vma before inserting into vma
 tree
Message-ID: <20230814191922.vgdorjb3gjonbrdj@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        torvalds@linux-foundation.org, willy@infradead.org,
        david@redhat.com, peterx@redhat.com, ldufour@linux.ibm.com,
        vbabka@suse.cz, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, hannes@cmpxchg.org, dave@stgolabs.net,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com
References: <20230804152724.3090321-1-surenb@google.com>
 <20230804152724.3090321-6-surenb@google.com>
 <CAG48ez0XCXoXbSR6dyX7GUQYJKRFKQsHuye5q-PLU3-gR5of5A@mail.gmail.com>
 <20230814121521.83c2dda21765757d272538b2@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814121521.83c2dda21765757d272538b2@linux-foundation.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 828bd47c-82d0-41af-9b3a-08db9cfb5f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szj7ii6sJuoeNMp5djAD3gkAn3muU1/PulrXVyulbbEOR41Q3YxhCokCT25XRkzCcCI0BHNHQwAal9LsNbrIwstZr/b++XvJLV+2SULTCpJagxTujhDJgpcShJ45klVOARPBcnkT3L05SIUPOaUXaazGHJHlMwTrZ+APFjKeO5a4el9cdZB5BN4DhQ+Am3qj2+4P4Mk3i2WkUlaitAtkqI/JxWyWmflbhflCQvQIDhqjBQqFm+U7IfcmZDu3xJzCsrxBJhym8pS6CTTus48l/5VYsp9wb0/fn1jhlBu4qNXFSL7rlpQmu6/jaOOpKbhqe4PpjusXtMXCbimI26KJIU2pfCauGdatVZ75i84FGO3uvwSWB7ThCRAsmakGPfnHISUM69HUCxujDio1fCgVfU24rWhEnnHEldCELRjFsK5d/q0+jW4PA79s7ACJ2PIwFcjwVE976A1DZMdsgImOCUA4v/cxGhhEdoY2iJF15OeoZ70IabB4zmwh/ph3Zc4RKkt+gWqVrZGQmt3L0l90YOMYg1br2Jb/0/KOfi9fH+5/DAaCCIvGYaqNC13qie3Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(346002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(83380400001)(33716001)(41300700001)(38100700002)(66946007)(478600001)(6512007)(54906003)(66476007)(66556008)(316002)(6916009)(8676002)(8936002)(9686003)(5660300002)(4326008)(1076003)(86362001)(26005)(6506007)(6486002)(6666004)(2906002)(7416002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pJfugasN6+k7O6+WB4hv0gTuf879JcwNaV9UsO29TnP/zAZObDfVIwzqJCF+?=
 =?us-ascii?Q?kgftxFcY2xHE9yK7soq3FDQYAQyreij5i7eSyGe0k4uFSWjWmhKAp5U4jBab?=
 =?us-ascii?Q?MgpSRVL8Vu0kYe22u2TLUmFaZ76xVmwLNN4wPiPvJbYwxxpTx/lFP75WzxUK?=
 =?us-ascii?Q?k6UOKhh1Sd+KNGh/jInmcrSj+06npW7xjp/F97QeRWq3MOPpSyPcx13Ozy3n?=
 =?us-ascii?Q?8uZEr2eI4WF5xFDpK5q67Ho8ulZhC+Q4WC8DISnv3KExWDFM5g5wIkRma8lm?=
 =?us-ascii?Q?8OuKeAf4+cV0PfQdT8rKaOqdtzid3GY44K63Wr1wuXDm+IvRWmmBFFs7Bb8Y?=
 =?us-ascii?Q?WiN6Y0u0925bIf2f3/ELDUDmibsdaltmHHqxKvfZq6zgvmp4YsdHhN7RNXfJ?=
 =?us-ascii?Q?+gWT9qBEGUOD5/1PsCYy6IBjUHFKr49MsnMnXiA3lu3Rc0cN2JxgH0DArV0f?=
 =?us-ascii?Q?lhJ48OkDhy/MC+1qK9AGfpmAAvSYuQtgCodp+XTWINM59ikcEog8QOlzuhiZ?=
 =?us-ascii?Q?WyS0IlAFOOV9ZJZZZKSuErWSyRRySJ7DiHmuJZ74dk/rzoCEOBZXZsVemSCD?=
 =?us-ascii?Q?s8scEBVd8k8nQLLfbfGDt6lzEYTqIA4R2PGHe7OGHlgsoLKTkVK+b908zSss?=
 =?us-ascii?Q?5K06O6GD6IKMnxjVG/eMsaB34PIReOHyXmCoDkRSN5oTXvAZqspohdYSfzkj?=
 =?us-ascii?Q?P238BRHyxG5LVnvkqQ5qrAWyR8rvRKY19eU8ANI3hfQoRhunrPSyARB5isWw?=
 =?us-ascii?Q?xZz2TuuaKNLa0eWAiwLRY/hqyis5nYKtl4tG2IevM+0+hoQzJHfSRi0PZhYf?=
 =?us-ascii?Q?wn6+6urawMveZ5SEqAib/FJqmpWAT4zNXZTChRw7mqy2tit1Qt2Lc8YzRng7?=
 =?us-ascii?Q?HyJiRuSCjd9buqPWEED1YeFSb+Avx5y6HYJbk2cPi3Fx93jk3cdrVG6v0Xrq?=
 =?us-ascii?Q?7aAdPgU1/nJg8OJj8+GmSzHWsuCrl9VCCz/9lne8JWLUA7UKb/tA89Donr/v?=
 =?us-ascii?Q?9Yb/RzVtPcN2Wxs/ppTsP1pH1uTdFLSFtD38e5e5xAPoBTNPDntkJB3KAsSv?=
 =?us-ascii?Q?JoU0ZFUaRzWGFoePwlJGdMFlby+DgjAXXyrnnAHZ8UT8BsnI8mgdLD7geYGr?=
 =?us-ascii?Q?l8ZKGgJRAZW/ROMD28XjjvABwZqSqP49pic4m93GKGv6TYPtZqX4mFibwrhN?=
 =?us-ascii?Q?st1D3AN+9ptvcrA8M6f83eXkuVLSO/pFNQmDc3RuFq/30AY4Mfagst/E/lSg?=
 =?us-ascii?Q?/VYbF858c34pPdu+v/LRuL/UfEBB02uZsR0Io8wjBZRUoKg2GEqOJqHtzHwf?=
 =?us-ascii?Q?WdAvKy9vJDbgCm31qSa3ACqBCwiZqGzVwIJQlwmMZD96NTWjAeOCnEyXSq8c?=
 =?us-ascii?Q?uKy+WmLkABxcsbEtBHFOv+0aXsSDqFCY1MJN3RKVU2+YtHleaNVyeHAWCiai?=
 =?us-ascii?Q?tJRIQaudez0tIcDmolOiJH7dgAr6Py6dX+LCMczGDFAP7g8WsnOixEoZ4wyq?=
 =?us-ascii?Q?FSjA4NGxfT7EgdpAbcZfPbuvcfhuAVqSIt45G3dicxJFdBJDhZX0Jl3qEojG?=
 =?us-ascii?Q?e3Fv3TK4BjJ77IB/uew39VHhuDpXNegp9ZThhHToMpjQ16mObrLHbcxdsOzK?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/+fIXaP/z/nR/cc4ewD5Uw6WteL5OCz09dg3aGDoFNd+PUaZGx0JJ7WpDgK1?=
 =?us-ascii?Q?DaXYCf+Gd1pdDwgDQj+hoOm4Jv2YARuIv4vxxl0gbdF1U5rFZb0ZIjFr3hgx?=
 =?us-ascii?Q?45QxoWhx8yXrfY3xHGETNBbPQKDHetRb0Rmttv07w00m2HM0+WYvUnCDINRZ?=
 =?us-ascii?Q?+pyehuRh1w2dWRmmEk0LMyyUw6jpyhCC6nKzAc2w6Eoqlh36YVvNcf27TRT2?=
 =?us-ascii?Q?r4RtX1kc3y3islD+C7lyDk0Kwsj0c1bUVU5JrjtkNKbvviXIUuLCDjfyjjmO?=
 =?us-ascii?Q?a/dxppRHfmsiPkgZkoTqBXK8RKw3MkfMZ0mAoaasE+BsU1b/vwRjX955zSf1?=
 =?us-ascii?Q?XZoxDWA85vfdAiAGV+UiGvIXxcQ+414NQ5/i+dAaYGQeRfPXt6OBWsiQ4c5c?=
 =?us-ascii?Q?t8/cWDKX+267WhELlndTiiPYVybOW55VFlF1663UdNdJ262J+tdEnNGj3SR5?=
 =?us-ascii?Q?Ydi7G2y3VnIpxPHG50n8iTxTfuyH4hJ9mcPuOSJtBMWXiU+RDDPbTl7fzGfe?=
 =?us-ascii?Q?95bGAbJ0tqYqivsq6xDz+ubdFC0Ydjow/gHidCGXZlwzwGqxuflt6yyI6Qc2?=
 =?us-ascii?Q?FRzK3kMEbQ72+MZsQAh+rlXbPAeI5HKIvkqaPuxU3oOkp/wR+OpsBSms0JBM?=
 =?us-ascii?Q?9A6VazmloXiAjERuj6L6BwIQgeHu/f1SWvPFRA51JV0xr7reZ/bEmtrBhbUt?=
 =?us-ascii?Q?WIiVSJoK3tw1dmVcPGt/8XozFH2u1zphpdNGW+heOf73F+v/SbFKYiQGHAlr?=
 =?us-ascii?Q?B0d4wAx55tOFZtHCpcIO53Nr0UyjnHLXt3mZH3lrJVfJspMwHowe8ubjIDh/?=
 =?us-ascii?Q?gCSbGmv5DnEB1raqN1FzS/l+8fdjNpv8pWEJnKTiKppu2Cg5eWXjXtRJVlQq?=
 =?us-ascii?Q?A7SLD5XWEgpTo4PE/pnp4p0rzG7jBTUDLpjij9EPUstjTSKgEkeXj6316oni?=
 =?us-ascii?Q?PEBqtkBDTgX+4vjQNDFHBbzjS2sI/xU3tvTOLOtUrFUtkqVC2ouYYZifYrqE?=
 =?us-ascii?Q?tJGQnAU6eGRyT9j5a+32HSFj5A5qMRnr4GxvtqD/Y7KRd/gzU+po/48Me5KD?=
 =?us-ascii?Q?7ckB97OETSpGa327M/NrBmNO/WAHo8PjsvRiY3HXZ3zEq5HhaclTdvyDXN4J?=
 =?us-ascii?Q?r4TPF9RBfw64JKORBKzymfMqQTZiakLROA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828bd47c-82d0-41af-9b3a-08db9cfb5f95
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 19:19:25.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAtTHLZFb4nYiaR3vJ1zpEtrRlZLlIkYpBYZEvaTHyeG+G2eMZxA+Jj+IHD80StYfi7FjBBaXvzY1BF5VE8jZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=735 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140179
X-Proofpoint-GUID: YmvzpD4PynPVTNzUN6JAurwVb4tV1Xgq
X-Proofpoint-ORIG-GUID: YmvzpD4PynPVTNzUN6JAurwVb4tV1Xgq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230814 15:15]:
> On Mon, 14 Aug 2023 16:54:01 +0200 Jann Horn <jannh@google.com> wrote:
> 
> > > @@ -403,6 +403,8 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
> > >
> > >   vma_iter_store(&vmi, vma);
> > >
> > > + vma_start_write(vma);
> > > +
> > >   if (vma->vm_file) {
> > >  mapping = vma->vm_file->f_mapping;
> > >  i_mmap_lock_write(mapping);
> > 
> > The "vma_start_write()" has to be ordered before the
> > "vma_iter_store(&vmi, vma)".
> 
> Thanks.  This?

Yes, this looks good.

> 
> 
> --- a/mm/mmap.c~mm-always-lock-new-vma-before-inserting-into-vma-tree-fix
> +++ a/mm/mmap.c
> @@ -401,10 +401,10 @@ static int vma_link(struct mm_struct *mm
>  	if (vma_iter_prealloc(&vmi, vma))
>  		return -ENOMEM;
>  
> -	vma_iter_store(&vmi, vma);
> -
>  	vma_start_write(vma);
>  
> +	vma_iter_store(&vmi, vma);
> +
>  	if (vma->vm_file) {
>  		mapping = vma->vm_file->f_mapping;
>  		i_mmap_lock_write(mapping);
> _
> 
