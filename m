Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227277A6B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjISTGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjISTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:06:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7349D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:06:15 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JHwvZQ003802;
        Tue, 19 Sep 2023 19:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=2+wvBgP6OxOa1oIS4/vBWDWHFwEySmobTV+NvfQzlb4=;
 b=xVUNnn3nu3wpc2+zDbU3SRWX3z8v88NIwdNU33iyYIf9twKGHoqGi0Z135ZtIf8+dA6n
 ZJrdR7KKVEntTN/Vnfm7MM+ecEj5rutOR/ZoGMJpSvbiPqUJMiUZJIUC7XYQZ25aLviZ
 spFz0l1liPzVg1oG67wzFJp5UqC94rbILQY9OwoMX8Ye1fffeGCx0KRYR9dvIsj9PSVq
 jAcRNwqIpMsCIrHOBLbXxDUP+nr2f20qe8AAbMfYBiXYG9QMA28aNHoc2i8c/mh39R+W
 HFtcZzEhFsEbxfsqppky1riF65ckE+BHK9PiIeEjcTyCyMpxo/w0AIvjX1LOiYpeCG48 hA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd5p31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 19:05:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JHVUsl012104;
        Tue, 19 Sep 2023 19:05:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t6bnjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 19:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BANLErTMmwjIJeKYRxcT5ovjcK9WbfNoUIeOxY/txz0FMNI9MP0WPFstKHqy9Stci66QNBzdlIDsAckfyxc4BR/2p6OPLej4NRrFYHitTvBHFQ6lL6+W1n1mXVwvPS+sLJQpvb/bhDwyGRsYj+N7HIQzUBpHCvExE9leWGzj7Z1/ZMsCNHPPecMG9hqi09xkmnGxteOTsT1eietpeSeV7m/aGHNEEOU0y7c5tNNz3ZTZAjOp8+va31vpqcJBjhCwW6tcOCZnGq+WxLAnADGYOPYGffRVNRK4fHTWYOnb0yQBZ/AHUJduQWQB4cRAH4NqRSnqKl7g7W7LHhXrZZ1DAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+wvBgP6OxOa1oIS4/vBWDWHFwEySmobTV+NvfQzlb4=;
 b=BQRBi/6DQn5S1SuUCWj2iV6WNizI0EPzwLsjJvGpMcl9thGqShMw0nQt3BlPbJrTM5WOPS59BSPy8gL2Nrr/eQLqDxSgb2biHV7hjak48pjjStskd1+3KR3iDziUOIAFAmuA75fcwY/auhyeQL3MSiwrikgWUatbmZZl3GsA968KTV6IfKcj6r/YGlgobGQzaFtSVhvzl/33xePnzuQpAFuoPX/9hLHdEoArCS4Bm55Kw4y1J0xJHVmctBaY36w19myTq2flvqp4BcBtr7JvURByYkIpJJ4Ve39GEsCqQWgEAtyKDgwZwJny1AcJpEycYfLtq5PPhjLuoAjsGGZU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+wvBgP6OxOa1oIS4/vBWDWHFwEySmobTV+NvfQzlb4=;
 b=fJO1K8wVXDFWt5z3PpfW1HkZClyawd71o8TrHQ68PBx5iy8vDDRRaJrZEQWwD9zao5zr7lMzat0wfQplGVvjX4zzKPQs9ZbK2F7zIKfQUutXYMzWtCvXtuq6DsmzcoZkpO/rtYcz1dQnDggYonPtQXw11mPjFq4dS7fHSJ6t1WQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB5076.namprd10.prod.outlook.com (2603:10b6:208:30f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29; Tue, 19 Sep
 2023 19:05:09 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 19:05:09 +0000
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
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-reply-to: <87cyyfxd4k.ffs@tglx>
Date:   Tue, 19 Sep 2023 12:05:07 -0700
Message-ID: <874jjq56ho.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:907::39)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: b062e9d7-1a88-4258-f9e0-08dbb9435803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sh6PQxIWfdroQAMfU/WdaRd83WlUuBv5/FaC4hdKEUEtD+bteN3OwwKIX5StTbKMmjQ4vp77u4GeO9ZVj7qm87/zfcWSnOrhyCyqAXJUi126SxND+qieTxEE07kPmoCSQSSY/QlH3IJEuuWYTMTGk+5EvB6dLp3CwULO6KSp9X1cjvR8jsFQFS5+jZGmZdJHx5j4Z4Bw7J2Gf0QgW6Ap5nQsLSfiGmVHV5lbQAlT99dDB+UtLs91Z1PKtgXGGceWaBJtlaiA1/q7g4W7E6V56oWjNOMuhqFgiXnjz5kKCbRm5aqLmR4BZDEWEpCp+m2Y4VZkwBCloJX5INbQD5zbZTflvma+omIWQKxMvIEGw+qEHihr7piyr7VImKm7bLP+uFEdohyvS0OqBikOKzUULfDtA4i5pEpbN5jiE6UhTiEqQkdSmcjB+Mxoq2JjrRcPx5fZMvzcwI8Rl3EYFQUP+7AIwXw9+GNQ+Wjx309P5+I7LoTqBvmbt8X0YAx2OZeShC+avVYoe4oTbLpkCkPmI1snOt18TjQvrumVwukGFEj5bcR37flHO2YIJzxYC7rYsu1pG4vWRwKHc+pr8UUlEUZ8ApsUVMvv3J/ntoyqf63z7Ir0zNTU+ORg5a4bcdgE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(83380400001)(6512007)(6506007)(6486002)(36756003)(316002)(4326008)(41300700001)(2906002)(66556008)(66476007)(54906003)(6916009)(5660300002)(66946007)(8676002)(8936002)(7416002)(38100700002)(478600001)(86362001)(26005)(2616005)(557034005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uMRmRZEBKKtWYp78zHJdX4fZ3Sqn38gfi1v2jpQFBW5xGh4Mn90bOFAAjdPo?=
 =?us-ascii?Q?EPPDD2c9eVkOSzn1HgYio910CPCjGdCLOaNFr1/3TBErviCidEdl0MYsw4/L?=
 =?us-ascii?Q?nftxLEiyecWsSa5Cu7VlBZTqB6TcAoSabti8+oWfatViDkx1Qaq572HOWTaT?=
 =?us-ascii?Q?j3Cm7X+daiSYtC2dCRcHV92XyZFAchSR4oR777RX1QsWBLRfEKG+EAjL1Zdd?=
 =?us-ascii?Q?sdG7o0McypeZRyOI12UabYAi8tJgb9CjRnCNpnlLdtFpAUxwtVEjdlViV7S9?=
 =?us-ascii?Q?RQo1YBjktZQ2vSoJHAzWyXneY+Z9og1ZuknaCej7K5JiE0FoeYuyDG+tsz6F?=
 =?us-ascii?Q?4s52tjSAnRbZkuCPSSYXRKaqJZgbNTrtEPC7ORJgTwE6PUfbHUrhf3fjJp8i?=
 =?us-ascii?Q?gBBpUsTGUQxhbqdm9le/rmSEnzUWcOSen82hpqA5T/KPBBYQnBTpKevVsltX?=
 =?us-ascii?Q?c/bE4ipC/7yc9YgP1MkSROPyvNhe2sLiOoRcbeY7MSNgJaVBcEMjvThQXjvk?=
 =?us-ascii?Q?8+fEsu8JhG9vn996Pv/4WjMEjVF56ZXtRX/8BjHRnlooQMUf3rTrvUAeb22U?=
 =?us-ascii?Q?CHCFDLlvdWmK4C4hNBN+fwlyJQ2+HknNKqtCMhRenUUnexwXXARRSQCJKLFX?=
 =?us-ascii?Q?SbHLlDtHAJ1esWaf4qPjNDgRyX4XTuMJ3ZwlZFbZg33keLO2SD9lIg+iL97d?=
 =?us-ascii?Q?AYd2BqAWq3BqidDWw5dp214OdSODvsmYmoOlnl2IrJqYYvHKv9ItbbZVO0jn?=
 =?us-ascii?Q?uw8iTZvg0htX9yOHGJzMheiWIwtyQAyxx+mITl2c1tiIQUhux3m7r5tUwXdy?=
 =?us-ascii?Q?MJtqxLZ6mYo0cFzvBmVqIeRFDqqGiFSsyE6ii+E62HhuJ1J5SgZFv8WSSG7G?=
 =?us-ascii?Q?tbhGF81DrIPKP3zUecnDDu1fvhZSyo64Vzfw36tjHFyy2a/mN9PIr5Yaup6V?=
 =?us-ascii?Q?8TJj2BL6YO/83zpTRX89df9yKNJPtQmJHmayGEHYNgJ9X7aqz7SJqYaYCCn5?=
 =?us-ascii?Q?wslOM6woP6k/Dyq1fldASwr8biiHienMz8v+kPiEt4VVXX4m3rKiDjNPn1B+?=
 =?us-ascii?Q?ebnRoYv5L9At4NocVfJAbSdAPECd0dojqW2WU8wQYsV9J56VoYOlYQ4GsD7K?=
 =?us-ascii?Q?Y+HiTyq5vcjOGmOsVc7lavhqi/sRjJzWX+Bm8O1Yj4f1NNIyDJTElhhBs9jY?=
 =?us-ascii?Q?K04SvbCHB3FFd6PeoaNjm9a9N6C8nGxjah4G+iI3iokHzJMh9MJDhCwhvz3C?=
 =?us-ascii?Q?WeMEihH+eBnn9qxBpABQQquiZXaE5CAQqrwvHencyQdOXoCGvbj85A9N9FWd?=
 =?us-ascii?Q?335K4zfQ2DB2Tlap1vAKCmNyjIuWc5Apiz69B3dUUG74ItW6V2KM/lkQmFfg?=
 =?us-ascii?Q?Br/WvXpawVZdCmmHZrHnfQ/WfXj4U0sTfZ9I47SM6JAR14fxeDJQxiru8kNN?=
 =?us-ascii?Q?GHFKK7wjZmV1CecEcJnZU10KTaontBPVRUfk1VL/blrQbVWgAYCG+nxpxP+a?=
 =?us-ascii?Q?imT3YOr+62Nr2d19cVW+R9MN9NdXrmryg7LMQTgX52iWhKpNHsr2RTNcsWC+?=
 =?us-ascii?Q?N7PvnXPJYl+0q3+zPvKIHBFyi1jrr7NBQS+DwFXF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zD/cok/DUr/0WrL7foVat+DQwM5R5NN3uNRMrouqvY/3PpxT/O35Lx8dRzKJ?=
 =?us-ascii?Q?dUiAL/K9lb9uHer/tyfc9wxtF6SeYklOee0C2r1W9M0jWB5bqwiRnTlSQbwZ?=
 =?us-ascii?Q?fWIYvifs4ntwDgabwbfPKfge6KrbgC+ns+GeM5Fb6bnAR3sJ8Bqx0z7/zt1E?=
 =?us-ascii?Q?LNM8eD1plAWabKZiA8evHONFN3TlpFZ8vDEFmkvrX+H0uvkLHvtH4wlTRc5e?=
 =?us-ascii?Q?N8IQhCzlU0xwLZYD1dGhRorONK4vibGCX9HNA5Yj3iaEEQcF6Q8aVTbSgpHm?=
 =?us-ascii?Q?C2IkmWZND6VmfGEf487Q5oHKVPfR529tYMeuxw4RY6CGCjJc9ZZb8UxW57Ew?=
 =?us-ascii?Q?mP9YoR3D4Wx7fIE1jq/oGUtmOJizpnogPc80/9/BiVqiQIFrBdm46wXq0yW5?=
 =?us-ascii?Q?2XN1DtjZ66Uji9Lsvd+/hIy29Mhj1391x275vQi/a756LryX/kFzj9zaR+w7?=
 =?us-ascii?Q?IjDCmNH0vrStph1qouHekNpAyTZaKjSEXvBSpgPjBoDOhyJ0Z1uOstBzb8ls?=
 =?us-ascii?Q?S0c8GYKZPcGLuqW76TrUjBPj/u/JZhfT/49YPCQn5GwZOBYSjgTP0Fs5TYlN?=
 =?us-ascii?Q?m9RjjKOw4FVmFN9HWs4lnSkC+LnASkA3c9lEuulqneRnr2q98f/0V2YEeWUB?=
 =?us-ascii?Q?UYR/nZ5RI3dUvIu5W0ZLpbm4k1pANz1WRje7c82kbSufH3ABTCC1GP5wc8uo?=
 =?us-ascii?Q?LD1QjmdZu05rjsJ4dXkbVEObeEcxby9nKOLlKhOET08WMXkLk3szsm4yI1uj?=
 =?us-ascii?Q?/LNJGQR6mTurb/Bb2MxwUf+urI0GRRwoi8iixUuyntVLQqEwZfSJ6Po+Uql3?=
 =?us-ascii?Q?OjMG4VybBDNro1wDrRexN+grdpDhHXn6b68OvILZhqJ9hixTjeR4hPd+WbJf?=
 =?us-ascii?Q?3xNxtciR20qGz8n5qoNfC9SzK6kKl6/yfBhToYFJd0L7XsGWOsCO/++KP1Dl?=
 =?us-ascii?Q?BSgkSY0ky4BxTTsReK8kEmiOh+B+Y0h5hr6/XVqrFMw/nW8I75QYX2Z96uWj?=
 =?us-ascii?Q?FfYJ07GvTHPyt+THf+2lBFmuBfJINDq+u62dqbk+7+olAcpC/Vyt84HJD/1p?=
 =?us-ascii?Q?upozQ8+K0/GmcXdjnGEYGfuuBZHlZJax/+Yyds+gTojDkQtmOAhBV6ynpG9L?=
 =?us-ascii?Q?/rK0X/HHseqGq2gNkG2iXVd5lU2mrCO44iGTMwM1i3l2qzlCRCpruLYyuKHd?=
 =?us-ascii?Q?Nab69z5RVLaDxUgTes303F1ulPnwVN7tl3nrjcySncGbqVK3XH3nBiK6R/Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b062e9d7-1a88-4258-f9e0-08dbb9435803
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 19:05:09.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Af93K4JMU+KgIbXjfQFJ1YnGRqrOcawVpMSSK1pL4DdM9yZRmpf6rVsiiXx48R+tqjwsfnhA8uK02BIk0t5nPGaGvnn6EH04ruNxha8DpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_09,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190164
X-Proofpoint-GUID: y2GTEBcUrIuQ-76ah0YnwVnvhSvmGT5D
X-Proofpoint-ORIG-GUID: y2GTEBcUrIuQ-76ah0YnwVnvhSvmGT5D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Sep 12 2023 at 10:26, Peter Zijlstra wrote:
>> On Mon, Sep 11, 2023 at 10:04:17AM -0700, Ankur Arora wrote:
>>> > The problem with the REP prefix (and Xen hypercalls) is that
>>> > they're long running instructions and it becomes fundamentally
>>> > impossible to put a cond_resched() in.
>>> >
>>> >> Yes. I'm starting to think that that the only sane solution is to
>>> >> limit cases that can do this a lot, and the "instruciton pointer
>>> >> region" approach would certainly work.
>>> >
>>> > From a code locality / I-cache POV, I think a sorted list of
>>> > (non overlapping) ranges might be best.
>>>
>>> Yeah, agreed. There are a few problems with doing that though.
>>>
>>> I was thinking of using a check of this kind to schedule out when
>>> it is executing in this "reschedulable" section:
>>>         !preempt_count() && in_resched_function(regs->rip);
>>>
>>> For preemption=full, this should mostly work.
>>> For preemption=voluntary, though this'll only work with out-of-line
>>> locks, not if the lock is inlined.
>>>
>>> (Both, should have problems with __this_cpu_* and the like, but
>>> maybe we can handwave that away with sparse/objtool etc.)
>>
>> So one thing we can do is combine the TIF_ALLOW_RESCHED with the ranges
>> thing, and then only search the range when TIF flag is set.
>>
>> And I'm thinking it might be a good idea to have objtool validate the
>> range only contains simple instructions, the moment it contains control
>> flow I'm thinking it's too complicated.
>
> Can we take a step back and look at the problem from a scheduling
> perspective?
>
> The basic operation of a non-preemptible kernel is time slice
> scheduling, which means that a task can run more or less undisturbed for
> a full time slice once it gets on the CPU unless it schedules away
> voluntary via a blocking operation.
>
> This works pretty well as long as everything runs in userspace as the
> preemption points in the return to user space path are independent of
> the preemption model.
>
> These preemption points handle both time slice exhaustion and priority
> based preemption.
>
> With PREEMPT=NONE these are the only available preemption points.
>
> That means that kernel code can run more or less indefinitely until it
> schedules out or returns to user space, which is obviously not possible
> for kernel threads.
>
> To prevent starvation the kernel gained voluntary preemption points,
> i.e. cond_resched(), which has to be added manually to code as a
> developer sees fit.
>
> Later we added PREEMPT=VOLUNTARY which utilizes might_resched() as
> additional preemption points. might_resched() utilizes the existing
> might_sched() debug points, which are in code paths which might block on
> a contended resource. These debug points are mostly in core and
> infrastructure code and are in code paths which can block anyway. The
> only difference is that they allow preemption even when the resource is
> uncontended.
>
> Additionally we have PREEMPT=FULL which utilizes every zero transition
> of preeempt_count as a potential preemption point.
>
> Now we have the situation of long running data copies or data clear
> operations which run fully in hardware, but can be interrupted. As the
> interrupt return to kernel mode does not preempt in the NONE and
> VOLUNTARY cases, new workarounds emerged. Mostly by defining a data
> chunk size and adding cond_reched() again.
>
> That's ugly and does not work for long lasting hardware operations so we
> ended up with the suggestion of TIF_ALLOW_RESCHED to work around
> that. But again this needs to be manually annotated in the same way as a
> IP range based preemption scheme requires annotation.
>
> TBH. I detest all of this.
>
> Both cond_resched() and might_sleep/sched() are completely random
> mechanisms as seen from time slice operation and the data chunk based
> mechanism is just heuristics which works as good as heuristics tend to
> work. allow_resched() is not any different and IP based preemption
> mechanism are not going to be any better.

Agreed. I was looking at how to add resched sections etc, and in
addition to the randomness the choice of where exactly to add it seemed
to be quite fuzzy. A recipe for future kruft.

> The approach here is: Prevent the scheduler to make decisions and then
> mitigate the fallout with heuristics.
>
> That's just backwards as it moves resource control out of the scheduler
> into random code which has absolutely no business to do resource
> control.
>
> We have the reverse issue observed in PREEMPT_RT. The fact that spinlock
> held sections became preemtible caused even more preemption activity
> than on a PREEMPT=FULL kernel. The worst side effect of that was
> extensive lock contention.
>
> The way how we addressed that was to add a lazy preemption mode, which
> tries to preserve the PREEMPT=FULL behaviour when the scheduler wants to
> preempt tasks which all belong to the SCHED_OTHER scheduling class. This
> works pretty well and gains back a massive amount of performance for the
> non-realtime throughput oriented tasks without affecting the
> schedulability of real-time tasks at all. IOW, it does not take control
> away from the scheduler. It cooperates with the scheduler and leaves the
> ultimate decisions to it.
>
> I think we can do something similar for the problem at hand, which
> avoids most of these heuristic horrors and control boundary violations.
>
> The main issue is that long running operations do not honour the time
> slice and we work around that with cond_resched() and now have ideas
> with this new TIF bit and IP ranges.
>
> None of that is really well defined in respect to time slices. In fact
> its not defined at all versus any aspect of scheduling behaviour.
>
> What about the following:
>
>    1) Keep preemption count and the real preemption points enabled
>       unconditionally. That's not more overhead than the current
>       DYNAMIC_PREEMPT mechanism as long as the preemption count does not
>       go to zero, i.e. the folded NEED_RESCHED bit stays set.
>
>       From earlier experiments I know that the overhead of preempt_count
>       is minimal and only really observable with micro benchmarks.
>       Otherwise it ends up in the noise as long as the slow path is not
>       taken.
>
>       I did a quick check comparing a plain inc/dec pair vs. the
>       DYMANIC_PREEMPT inc/dec_and_test+NOOP mechanism and the delta is
>       in the non-conclusive noise.
>
>       20 years ago this was a real issue because we did not have:
>
>        - the folding of NEED_RESCHED into the preempt count
>
>        - the cacheline optimizations which make the preempt count cache
>          pretty much always cache hot
>
>        - the hardware was way less capable
>
>       I'm not saying that preempt_count is completely free today as it
>       obviously adds more text and affects branch predictors, but as the
>       major distros ship with DYNAMIC_PREEMPT enabled it is obviously an
>       acceptable and tolerable tradeoff.
>
>    2) When the scheduler wants to set NEED_RESCHED due it sets
>       NEED_RESCHED_LAZY instead which is only evaluated in the return to
>       user space preemption points.
>
>       As NEED_RESCHED_LAZY is not folded into the preemption count the
>       preemption count won't become zero, so the task can continue until
>       it hits return to user space.
>
>       That preserves the existing behaviour.
>
>    3) When the scheduler tick observes that the time slice is exhausted,
>       then it folds the NEED_RESCHED bit into the preempt count which
>       causes the real preemption points to actually preempt including
>       the return from interrupt to kernel path.

Right, and currently we check cond_resched() all the time in expectation
that something might need a resched.

Folding it in with the scheduler determining when next preemption happens
seems to make a lot of sense to me.


Thanks
Ankur

>       That even allows the scheduler to enforce preemption for e.g. RT
>       class tasks without changing anything else.
>
>       I'm pretty sure that this gets rid of cond_resched(), which is an
>       impressive list of instances:
>
> 	./drivers	 392
> 	./fs		 318
> 	./mm		 189
> 	./kernel	 184
> 	./arch		  95
> 	./net		  83
> 	./include	  46
> 	./lib		  36
> 	./crypto	  16
> 	./sound		  16
> 	./block		  11
> 	./io_uring	  13
> 	./security	  11
> 	./ipc		   3
>
>       That list clearly documents that the majority of these
>       cond_resched() invocations is in code which neither should care
>       nor should have any influence on the core scheduling decision
>       machinery.
>
> I think it's worth a try as it just fits into the existing preemption
> scheme, solves the issue of long running kernel functions, prevents
> invalid preemption and can utilize the existing instrumentation and
> debug infrastructure.
>
> Most importantly it gives control back to the scheduler and does not
> make it depend on the mercy of cond_resched(), allow_resched() or
> whatever heuristics sprinkled all over the kernel.

> To me this makes a lot of sense, but I might be on the completely wrong
> track. Se feel free to tell me that I'm completely nuts and/or just not
> seeing the obvious.
>
> Thanks,
>
>         tglx


--
ankur
