Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F560808E5C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442083AbjLGQxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379599AbjLGQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:53:28 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126B91708
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:53:33 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B75PNAI004352;
        Thu, 7 Dec 2023 16:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=date:from:to:cc:subject:message-id:references:content-type
        :in-reply-to:mime-version; s=PPS06212021; bh=wv1byS+ef9KlwRLpAea
        bJUWmPvCca71AVa1u+qxnitk=; b=Rc6fDW0OJp9eCv5x0jcBKOeyOmcIxyQXBe1
        Yc5yeVmi5GT2QL9UUvgO/JcojKK9ncXhQPtgJpolFrkWH0VDz1IEU/K/qfgj48gS
        F0gku16SqAuZcH58CIvfULaYNqzm4ZZbgSf5CzEDrYp29RV9x3AeZKpBhuZXN9D1
        AQiue6EYyYxazcr44/ibIoTRzHbHv1mb6hiGAUH8isldnpx1rI00pCL8RxtMxHk+
        huLQW1aEmSrTtfk56+7EOJtGwvoB+LWYd96AI0hEp9tfTir5awi6KPX+eERmi0Ne
        Wcu3HaLMRlcKnTel+VlX88y4Y3wJn1cPPOshUSozykJJPeh+M4A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3utd53hwg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 16:52:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFLt+s3rVAr8V4mViLQ08Uk5+8JNz0rt7FNrTHGX82r5OjmwxivaQGlv4ZReRLfNkH6cRPAQzfGJBzsn2susfNpZmreGPN2PXYttMxwEdsPK5VL5x/YBEdOXIzl8x2CBb7mscvuL1pptigx5gLDNbFVwx3vmpYGHVh3iqZWvC/Ec9ZXx0EAPFnOHSxMdz1f7ESo84wEXBVx0AGIjYw1rNQiXvnv2OZLtezh4U/3tjBGU0qIG9LC69u1vNDVHZ+CNROuFScZEtMY2Dg+Nh50miae+dBTFqkqlH3UZJ0KGkY3Mpwc6tgmHMWpkrJERNXS5r8uxlcfWQyecfIYI6SXl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv1byS+ef9KlwRLpAeabJUWmPvCca71AVa1u+qxnitk=;
 b=XhXIY7JFLOX/oL+BzXzM6qgTn2BcbWGTQHeW78IXQvuEuSYWggHF8YkKD3D1ntSlgbZUy+nT+3hQ9H/hi/OLWFi+638azs9kwZalm5HwgqwhcgHS/QvawUC0H/17qiMgvE0ZLpNEdAwxm8BeWRanio5C+VgDgY4k/dM2/Q60G5jfcsZ7erVOAnoQVmbcSZY4dAJsql0/19ej08+QY1j+50ItjvLa1UURTyat9fydJ7dr35Uz91+0dBPEAVoHJ6VNXakYK/+VtcTWSjd44wqOBoekzEm2xANS1lKMsW2LXDj/3vZJFBxZO7uxnQe6gQSbw+IxknUTh/2ID1NmR5g6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by DS0PR11MB7216.namprd11.prod.outlook.com (2603:10b6:8:11c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 16:52:48 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 16:52:48 +0000
Date:   Thu, 7 Dec 2023 11:52:28 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, bp@alien8.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        richard.purdie@linuxfoundation.org, x86@kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
Message-ID: <ZXH4TCyc6aPUF4tS@windriver.com>
References: <ZUEgAAGDVqXz2Seo@windriver.com>
 <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info>
 <87r0k9ym0y.ffs@tglx>
 <ZXCXc+BtnLzqMbFv@windriver.com>
 <87h6kut1i5.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6kut1i5.ffs@tglx>
X-ClientProxiedBy: YT4P288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::17) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|DS0PR11MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 04557d22-f8ab-496a-c3e0-08dbf744f133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/HxQmQuRlMl8MW6h1mCyyQPJRceUO02BsXDxeI/NjlD0tVQG2rhGRaPKVHCconY5/qn6O4omDOFPpz2GVpUBIwfTM2vQtiMMAIIsG5GDh87nQo2toYLn0J0WAyBwuNWHrCBsn3U4jSha8uioq1qOIV7eY9RthFNZOyzAjwAwL8IopdvtQXXoWxSZsUWGabxX7wWOWaf18+FwVJgXqxvyvAu8AQSbtnrK9RO1pRLTJRGgYfv+Mml7pleXcrU4ml/ot1Dm/WekeqtoR948FTUULjTLtBslLSOdzulb4jwKvsFNvZTo/yejwzlhUGG3HSVzvNuHnTX7DGgfsxZLjN2AK2pXC6yWAcVzHLloeslt+0TGQvzEMEkJZfDmocVu0AeJZnzM/TSOBQrQOV3JOlOcTP0o4btCR+6Kg3EEmYS8wdGOShhRXMUmV1J/1jzVatEKu7fekz8wix1N8b2gFhZU6E5ZGataoLRIUjp6SWzeYFD0F5MuIjd1mrSFf356HQwQUGwHr3sQ1NdecREJTeMfsAp1hewfUoURfxj6diKleA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6506007)(6666004)(2616005)(26005)(38100700002)(41300700001)(6512007)(6916009)(66946007)(316002)(66556008)(66476007)(54906003)(6486002)(966005)(478600001)(86362001)(44832011)(5660300002)(2906002)(4744005)(4326008)(8936002)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B4fX1a6hs1u+ornQOMr9rG4p0HBJ0tIq3cYCZev2zOcZ5K/ZhediIVHsU7oe?=
 =?us-ascii?Q?KHv7pUbiTTCVZfjuyfM0sZU24hywKlfqQBvoBTOODiQXgXkOhoy4OyP8uVBi?=
 =?us-ascii?Q?zSPd2GG5D1PhoQRKGHJw5hem3OjQ7oLrIx7Ut6Gl9pCl7zzx31hArncP6/FD?=
 =?us-ascii?Q?/Mk2n4a7nJmydHFJr0PfMtcekiCEATsnlieDvEO78qXvipp31dt+MKmwxSSE?=
 =?us-ascii?Q?3441wMZXUUi4CYABXSzQ0uEVsRwx3panXMmZ0FxqOmQR95mjgiGq4O4aw+lf?=
 =?us-ascii?Q?JiKiB8NYnRJqyboDOOIJ9m13Xx+Jlk0XIGX7AG3XxtlCUcgOmg+OK12J44Mm?=
 =?us-ascii?Q?EIbZRWCCSuYEdRcg5QBJKpU+OEya8G2Z8+35IzmAfjpWOlbi+NwAkbAOtgV8?=
 =?us-ascii?Q?lpB6ZsFcHB97GOXPzCp9liaxjYP2cKBkM3huC+op/RrfbF/3hBIsfaPp9j6B?=
 =?us-ascii?Q?ldVYH6T1qoiD1P42r9F9CJgOp0tlQrYH3g0SuX8De+OaBWGJrzmHHHZsowHk?=
 =?us-ascii?Q?25jnJHCq/I7ONGrVfcyG5k/wHhbVqKW1Uc39Xd+xUeIKnrQZoBgJBHHtZOWh?=
 =?us-ascii?Q?iaxx4CTK4PhQKb0EI0d7iGauGzsOwQvX9g8CjEFlPQis71gryqmgR9Zkk+uh?=
 =?us-ascii?Q?ftnm3nW0lSJWY5Tx5b01973CDKeZwr4JlHSrqU7LhqFO22GEV1NGZ1ntUsrc?=
 =?us-ascii?Q?2NWDUBAFL78zwbgjyxotlEMyOi7J7I4fOHlvOVWNZ3FGTNY6byRoJO9msHjU?=
 =?us-ascii?Q?BCGeTgxrt78RU3JEttuGF0NffkQ/v2BO1EU9pwJr/QjM4670mnN4dnAHSVVX?=
 =?us-ascii?Q?hU+iFfxiiFtG7RVUs1IsxaX2DJHxhAYWIFKT+8/Y3mWibav+VPMB+7HCOoOg?=
 =?us-ascii?Q?KW/2ZRKkACo1ZRMEJiNRTT9gyXKS4HhrqwQ3oCkEqpO2aM0JlA99tFrSc6w2?=
 =?us-ascii?Q?G4EYGQz10EUNm5U2cCVZn32PdRSJdUUfu1orNsR/sCjkHSyjiCmijukAovCF?=
 =?us-ascii?Q?Wj42YEJEMd/zrBIrkhFwjIev2t8gspL8dCaU5pFJ4+p+Ta2f8c9gAO5xMNqZ?=
 =?us-ascii?Q?m+eXzQF3t6s/SN2YgNlcYu6w3xlWhG9pwggTlxN1B9R9kQJCbB+QK1r4KuL4?=
 =?us-ascii?Q?lfwh43BiR3SBJcHKsbY0zh2+d3Za8qttLK6K44ED1CwOYB6CmlpW67dBA9Dy?=
 =?us-ascii?Q?uqPABMpse+trGYfeemsAq3sgBwl0K98pfWnnfKnNfjphWt7V+k7ZaL4U5C0r?=
 =?us-ascii?Q?MTS7AwqaDIUxD3lX68yxjpmL7s06A8eFVQlIWSCC5CHVoWQLe3cmLIQvRto4?=
 =?us-ascii?Q?nXcmBXGBv3pZeSY3ZOl+u1DQOCFmsGAqqz6bqp6fKGp9CaDncnaMqOD56yzF?=
 =?us-ascii?Q?OT+QRtkyXOIgIKjIupnENApIMxgBPRMoKJwFvMSXTa9rlMQypf4+zSd2uDJD?=
 =?us-ascii?Q?UAkV102BALRKPs9BuMgxWKJyMVrvcHhTxhu7RrtPo7i59pjgVlHa9Z1AZYtt?=
 =?us-ascii?Q?dKy2Wd4FJir744Vzbbir5WWRTXqSOVXD6KMoLqyVYQEEftUrBBXrKzYUW+Aa?=
 =?us-ascii?Q?XjMbzcN9IxyEWEQ/B52Xur/6CQHhP+5P7XgdAWuYhaPWRbTjJ9S7gU6P/VnT?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04557d22-f8ab-496a-c3e0-08dbf744f133
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 16:52:48.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6tWq1hPqBxq6UxRX6Nv9R1cKlpIICj3SSIXv6rjTubPiMtk0D06LTfr/tUGC78PbhaHNOEH0R20y6WMSfs06SKeRVxPNOfisviuY3+Ne1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7216
X-Proofpoint-ORIG-GUID: xoau5m-biifO-P3_9v0vHKJyvYpanV58
X-Proofpoint-GUID: xoau5m-biifO-P3_9v0vHKJyvYpanV58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=783 mlxscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312070140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128 x86/alternative: Rewrite optimize_nops() some]] On 07/12/2023 (Thu 17:34) Thomas Gleixner wrote:

> On Wed, Dec 06 2023 at 10:46, Paul Gortmaker wrote:
> > The config file and both "good" and "bad" files are there now:
> >
> > https://bugzilla.yoctoproject.org/show_bug.cgi?id=15230
> >
> > There are a lot more debug lines in the good/working output!
> >
> > $ grep alternatives: dmesg-debug-alt-good.txt | wc -l
> > 4868
> > $ grep alternatives: dmesg-debug-alt.txt | wc -l
> > 19
> 
> Unsurprisingly so. The failing one dies right at the start of
> alternative patching....

I'm still set up to where I can pick a version of your choice, add a
debug patch or whatever, and let it run the 200 odd boots it takes
before it fails once.  And I'll try and be more prompt this time!
