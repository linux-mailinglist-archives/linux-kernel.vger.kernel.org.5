Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA97A8665
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjITOXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjITOXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:23:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06649AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:23:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K9shYt030394;
        Wed, 20 Sep 2023 14:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=/7j5v3v7+cZBKvacGHeHBD8Su5jfJ7uIABMmiibyn1M=;
 b=2ABvszAXOZg4MViin6Fkd7O7ABaI42vLpa/SqtjkW7e5FIyvcwkZamBWwmkFQHrq7Jfg
 SC3hqTFSygd0w+lKETdwOIRAwu2pxnX8QJ+w6aTaxU0rTlTHN60BATzH/R2x1/oP9ofQ
 SiZVCG785r0teVSeVwSPvosye8Ey3VMCBBmbZ6eONM3jpBbVXmyoJGpoFxdeEvXrUjws
 pi7tetqWn/Z/C94ibDOmHUe0qKPXWG9/I2mNgrWkAXF9BSZdb3DtBwFfJFI8BU0rsWE8
 bxSOoRowzuaGuvCBljVnwCOTe4ET7Ovqxmco/+bfPqB8sjlM1ycdIMywQbDFBIwnMMKt 9g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53yu7d7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 14:22:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KDeGeo030918;
        Wed, 20 Sep 2023 14:22:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t75fam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 14:22:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dViy3dbV3PTuM4E3FVI8HcwYI8WT9fMNYUnqcMSjVXT1pk5Lwr2GkV1ljGCs3hM0VN9I1dXpevVHNpfpiSVyXP6/8L10k7SNhPo6wQ9Wt0YKsutCNDSTBASYcQsFhN6T+kWaDcWL4W2O5gxvZC4WQM5GAclsgumYUJ6jt4ox9pYg6UQV5rQbPBso2O2GqUIar2AgRD70nxsW/HKdeK6ZGVrr8OQggLhUc23I+QJFT8Qs5/QZHHPzoAJ8epDNAWwHheAYAjwBWVZqBo4Jt/AF7G+hDbv73kDirL0pVbr8s3+lRykIObt+9owyEznLpKkxu5XJSOqp6OdAIZTYqFvAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7j5v3v7+cZBKvacGHeHBD8Su5jfJ7uIABMmiibyn1M=;
 b=nxHZ/Hc9VPw4F71k4REirT9ciQMT56M7l9vv0imbKWHSZo9AF8NfeNXjfyOeiysea25w9SIc2yjjKaAxipbWuzRkgnhvEFQcM/F8qzOVzQokd0IHW9YEWJPlLYN+lSbnNpYr8v68c5SG60Qcq/H3ot8z53s/PXphpJTGl94jaCslvPZt6Gl82p3uzw+qeiGbaw9VFV5zIZ/4lam7EQCQWy6KjUI+dfqrxsa4AXYagT1R55osL4TyAn3ow/DUtKxMU4RDxgTSyiI3E0B+1eTLQJZypIhgsxxymgZiQa1fDgQT+/8k9XBpPWAcddO5XYaSBtbTTpqN6iKNJTKbzfzo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7j5v3v7+cZBKvacGHeHBD8Su5jfJ7uIABMmiibyn1M=;
 b=TxOsQNCtVAaDkGOLEDW0SOPXNh9dtAoAuM47cG8Ik2nlX6bpQY/zmcwz63bYwT3vri+KfE0pbdXnsdA/9TMKgu0JlyWEc1DvsYjsbSWe2IjmYq/GpHRL89F0tSmsWjRhTJGV+qgpKNegF4I3zrqh4PHCN2qSGZw0A3T0vw2BOIA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6024.namprd10.prod.outlook.com (2603:10b6:930:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Wed, 20 Sep
 2023 14:22:31 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 14:22:31 +0000
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
 <87led2wdj0.ffs@tglx>
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
In-reply-to: <87led2wdj0.ffs@tglx>
Date:   Wed, 20 Sep 2023 07:22:29 -0700
Message-ID: <878r90lyai.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::44) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6390f3-a05a-4d1d-74e6-08dbb9e50670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+3/6ABwno9ApZyyfXxhpF+bJcEEzJQ6YOkyTPX/KKy9voRWkXXFg79+1WC7WCcxvWKgvWT259877PANTWeM78QBSaNIE1BvtBuLpaGoHVR8dN32/Z+VrE3/hEsWfvQr+5cehokMnFqNQEDGjKCvc6smtA65JnhiMDm5nQVPJk60L3vNVFTBAISiapS7/sRkumouhRoMTSpJNvsBuEPgjqhK98dFjIeljPt6mxIib0YjOxYvY3P3Pyk0JokB2/9Mv5aGCLyQZgNzlvj2MiR+z7XoeVo6JbDs2pcEQpuKuMLem5lsAMrCFmS7Ui/CTEdJ1ny7KZDnIFvfl4TDH/woxF6/VHqB+2UteHR8PYtiBlyjf2nVcvN8dhhVhRDCp2BubUK4xoivBBKVCexejcliApVTEsmpL424RFz57I3fanh88kATow19MVKKADkV7r1gL5WHCjIXoOM/cYG56RBcFc9osQLwREg1/8iqQEfaBnFjVnOAsvQg15OEEisXjBh5+vCqpJKQSJZ46wgTH1M1M/bBCqQEa9G3vKoi+ad1bM06JKMhyrrdH8Wf+EL2P90n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199024)(1800799009)(186009)(6486002)(5660300002)(6506007)(86362001)(66476007)(66946007)(478600001)(54906003)(6512007)(66556008)(316002)(41300700001)(38100700002)(6916009)(2616005)(8676002)(8936002)(26005)(2906002)(36756003)(4326008)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8dtwZM5Cew7TtO49gE11AlNueeWDAf+ir3fxZzdHGzBTGwggd/7FR9l/IpHT?=
 =?us-ascii?Q?end6nM3FbMtEnAraF8Sv43N6wWkUnPdwXjkCyiXMMqgPPTG3w+DLNyzg8XUA?=
 =?us-ascii?Q?SUhH2zdeHwjFJDWsUEjtkfimVNR3Lq/0WRTmB8xbzTnv0vLxMKv/p6teGuIG?=
 =?us-ascii?Q?GIdi1PxsD5q147bYKYNFgYpEyWKdTOJwZ2R0M1pHZs2cZKNjm+l6eA5mTUcy?=
 =?us-ascii?Q?hQZcQe22ZKxLt6s/iv8GQyaO/rR86MlSZAO5cSBlP3X8eZUefGXu/xCCxJ8B?=
 =?us-ascii?Q?tS149M46ERyqtgpudVbLTz2bVIXgmya3eLcErLrnrmwrZ3dU4Lxz7h2Jeioe?=
 =?us-ascii?Q?UnaWZv9ZO0DgOJmjXVIWX6miTu8LOOKsAwRHEFAarMMD8CBSPdQv4Mj5TJG/?=
 =?us-ascii?Q?3ko8FzDos98MLiDBoSCHObKmyMN3xuiFx/qNvC+JpoqffUHgN/vNOQb81Huw?=
 =?us-ascii?Q?JOdWquAamDqV7XYlkz2B8cLPG6SEz4kwJPJbr7AEfLroQvCdkGoJ2Yu4bKuV?=
 =?us-ascii?Q?XUUir3BDM/gyVxt+P9g3/a8BBzCaiw1rS8TsmnVtgLJsLI2yEDQqf39JLxC9?=
 =?us-ascii?Q?yVm1fNA6ykIfJTZay9RmtNZ7hNeKfTyw6Q2RIuBOnrHdGidnJX3r7trGcrIp?=
 =?us-ascii?Q?jOHVJtskd3d/N/vlsx6Bpp/eBCYWxw7szigfzE/xL7fHvNBWgWQkAlgNToew?=
 =?us-ascii?Q?Cv9RlUaeiYmWjUAkGwlpDT39yLnFhRACUI0RKRbfQ5M6xdWkKqTf1wyzJedS?=
 =?us-ascii?Q?ueUDDYEeqrIMGsLrcVzW+8foC7smYWzHI1B4ESrSugZZ+jDWhsC6ROyfmNsL?=
 =?us-ascii?Q?3Ev1ZA+fhzhEqfv2/RjX+qrLEoNocRqfatAKVENMWTehj4IATGwqUDrvpPby?=
 =?us-ascii?Q?tBLnp47kldZB9OX+DOEWpimJYLQIEcDGWYslmrZzgfQFyQi3buYfwZkE/X9S?=
 =?us-ascii?Q?CgQkiEqaFhUB67StAfzAHrXh5EShN4hjkrzUfj49vvUoJFVGU9hkiZ89BSIM?=
 =?us-ascii?Q?l2gH6B623cy/vz1cvs8fAxzDqrL+YZP4WFgVnekE8Cw7vILTire5CD4+Prf6?=
 =?us-ascii?Q?U4il9GpLdMjrE6Bfi7TIn70YLwqgBBDKuQkAha4noPiJBy0Y6yu/hC3+DQ21?=
 =?us-ascii?Q?PARfzkmI4lUOjrs5bx0dxXFjp8rbjIWHcdVIKMatvLWbzBVzF/gxCk+lwtTn?=
 =?us-ascii?Q?Ye5UI9uauEbmrrKPdqaroQjqdtXAKnSAOzyTdFeiobuGNnmgfgg789Ux8kc1?=
 =?us-ascii?Q?azFRRFteMi92ObLoP3qj+TbUQ1Vpx0FYwBwIsxjSb+VymjXfWor2QXokqbg9?=
 =?us-ascii?Q?LUh9gcfK8PflCucDf9c9mcQh/FQjktKiiSokh/yG0zfdnScsOaYK1mQ3qZsW?=
 =?us-ascii?Q?SPpsiMGjPDEi/nlF+j+Vx+Nz2NJvc8NlGTQ+AGiMCinGZNQ8htOY7wdqRV6m?=
 =?us-ascii?Q?4nnJ982iEF818ImSTQqMCdTwbXhVbTqverErYPgTDaxQs8ZWdwlNA9R6r/te?=
 =?us-ascii?Q?hDDL/a92lA6/yYxlYxSBvkUUMNrlOODqXLpGUmfkeSY7ForugovbsiMRzrm/?=
 =?us-ascii?Q?vrbtVGTiD/WoBRxqpukCW8/B11o6C+psEAuX6uwfRYihLl1xdllTCwepd2ei?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/x3Pase/AgcP62cDkiUA/cSZCkLyoOlNPQ+2Mhpv0idctAiHHAFa+c9oTjKM?=
 =?us-ascii?Q?zN/C0jQ2d3IC0uL746iLiz3ZvZoOdVjCNPG+qVa7RlFmZEUQ3TcMjc8KM/c0?=
 =?us-ascii?Q?Bfflt1BnXN1YFEzu5ifJJH2dnP3ybBlecGVPfIraaIVetOUEajb3BxZ/MjcM?=
 =?us-ascii?Q?j4XKZ6ynxpbevL2q/Ox3FWc/KOUah0FWditxHgeDiM9pZ23lUFPD5oOiul4P?=
 =?us-ascii?Q?TJvHbyJj36vhnHoM7UYy/vnbvbeKmsB2xZVr/vAsn/TLKZn3awXoYFlSvphS?=
 =?us-ascii?Q?D2+1w/YWey58mXR9/xRg1fTYF+ZMJP/dpeVggBChc9clVOfUSMMssFNpy16z?=
 =?us-ascii?Q?49JD9CjhE8cdE3U0IMKmGUWFVHBVVcyuoaT3IO7XNVeX02aoZpr15pAEae2H?=
 =?us-ascii?Q?HPijhV0unumz7yCtFMh2Kisz/sOA+4xTB1y6LjQrf2g+0R7Mr0ck5Y/zCgnT?=
 =?us-ascii?Q?dmjOhYcAZ68ZmQDHZzJpt8k0hHo691dc4YySNL6mJjqIcqSHDnbl6cLhuAeP?=
 =?us-ascii?Q?vNB0icLNiChJKkW3RDjGgH2JBR7F+0s6TpNq9CtY4Ork7W1UILhYeY6rObl8?=
 =?us-ascii?Q?dGvqBZT1WGxLazRaEhd2MiJ8ZRnAXoKdgTorYPYNKjstddcYiilO3Zgx/Z0C?=
 =?us-ascii?Q?kWe+itvKvRWSAUbpqKV6dKfIajCQ/6y+ESKFiVjMybJqhFmKn1EoiNUAbPbR?=
 =?us-ascii?Q?IFdUsUXzLWFn93+iqFqOFkrw3h7vuEMfa3W7nF9EpCWnaZkeccnCR/B0Dtex?=
 =?us-ascii?Q?11JIDWq4tf53Sq+fdAKTWmQ+ukLAzdgnOktFGgIITklju3kqJFD7tSY+2zTZ?=
 =?us-ascii?Q?EWvsStglmB+o4Ul1fiOpJ+RdYksAvsUFtiABHxEg1i0jKo0j1p8AkOxK6b1Y?=
 =?us-ascii?Q?uk/c0CCDT9KK92qRV4XtYnYgOtQm1i4nz71cqu4IjPk9R8tLgGnVQqw3S8Eo?=
 =?us-ascii?Q?07LX82Ccu3eXjGK8lzRRRhI2DN3zwjYf6bGlik/RCq3tuOojEpobiSyol4/0?=
 =?us-ascii?Q?GM2XFWYFanHPJ0fhYbGbh2+NV6XZaGtmV7h6PVbfVmb9CHWhZzBTUYEvMIBz?=
 =?us-ascii?Q?6nXoOV4u3LX4Worvz68avavu7tkZ/e3FHld9fk9UrVmA8JSC7XLDGTvKHVK8?=
 =?us-ascii?Q?UlnkFazWElmj2vOBXnogP6oNrHH7sjpL+42yC9hQVhkzvfPhPtKs0gHxgKZR?=
 =?us-ascii?Q?B6RO/GvameQ6w+NBdiaHNGCbc3UC+SRQABIEasceYF+wFZdNWr5kUo4qpoI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6390f3-a05a-4d1d-74e6-08dbb9e50670
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 14:22:31.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syksx0mxZdg9P4G4Zty34wpwgQWBPVPsprhAwZ7EUrQKZEfVQOEukuNsCkS+I3LovJma0WnyyO8pX3ARDnLndpmo9h4YaO9YTlH7sqEvAl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=785 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200117
X-Proofpoint-GUID: KEkIz4pqhcEnLIZJG9OCUgnO-KJJByse
X-Proofpoint-ORIG-GUID: KEkIz4pqhcEnLIZJG9OCUgnO-KJJByse
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

> So the decision matrix would be:
>
>                 Ret2user        Ret2kernel      PreemptCnt=0
>
> NEED_RESCHED       Y                Y               Y
> LAZY_RESCHED       Y                N               N
>
> That is completely independent of the preemption model and the
> differentiation of the preemption models happens solely at the scheduler
> level:

This is relatively minor, but do we need two flags? Seems to me we
can get to the same decision matrix by letting the scheduler fold
into the preempt-count based on current preemption model.

> PREEMPT_NONE sets only LAZY_RESCHED unless it needs to enforce the time
> slice where it sets NEED_RESCHED.

PREEMPT_NONE sets up TIF_NEED_RESCHED. For the time-slice expiry case,
also fold into preempt-count.

> PREEMPT_VOLUNTARY extends the NONE model so that the wakeup of RT class
> tasks or sporadic event tasks sets NEED_RESCHED too.

PREEMPT_NONE sets up TIF_NEED_RESCHED and also folds it for the
RT/sporadic tasks.

> PREEMPT_FULL always sets NEED_RESCHED like today.

Always fold the TIF_NEED_RESCHED into the preempt-count.

> We should be able merge the PREEMPT_NONE/VOLUNTARY behaviour so that we
> only end up with two variants or even subsume PREEMPT_FULL into that
> model because that's what is closer to the RT LAZY preempt behaviour,
> which has two goals:
>
>       1) Make low latency guarantees for RT workloads
>
>       2) Preserve the throughput for non-RT workloads
>
> But in any case this decision happens solely in the core scheduler code
> and nothing outside of it needs to be changed.
>
> So we not only get rid of the cond/might_resched() muck, we also get rid
> of the static_call/static_key machinery which drives PREEMPT_DYNAMIC.
> The only place which still needs that runtime tweaking is the scheduler
> itself.

True. The dynamic preemption could just become a scheduler tunable.

> Though it just occured to me that there are dragons lurking:
>
> arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
> arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
> arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
> arch/um/Kconfig:        select ARCH_NO_PREEMPT
>
> So we have four architectures which refuse to enable preemption points,
> i.e. the only model they allow is NONE and they rely on cond_resched()
> for breaking large computations.
>
> But they support PREEMPT_COUNT, so we might get away with a reduced
> preemption point coverage:
>
>                 Ret2user        Ret2kernel      PreemptCnt=0
>
> NEED_RESCHED       Y                N               Y
> LAZY_RESCHED       Y                N               N

So from the discussion in the other thread, for the ARCH_NO_PREEMPT
configs that don't support preemption, we probably need a fourth
preemption model, say PREEMPT_UNSAFE.

These could use only the Ret2user preemption points and just fallback
to the !PREEMPT_COUNT primitives.

Thanks

--
ankur
