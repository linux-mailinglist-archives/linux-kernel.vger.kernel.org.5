Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5F7E4C8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbjKGXL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjKGXLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:11:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E572510F7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:20 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJw4U004992;
        Tue, 7 Nov 2023 23:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=8OOP07ZJ5K6zJC39RegnS+KEULj9FcngGrvEUb0ws6k=;
 b=XmwyzCdNvorDE0taCW4iQoVJcWUOkisSdhd0zc36J37LmN6Grzy67bBU8uOxmfNu+gfc
 MwGkI4Y2C+0T/3hYgYaorQGA/AIA0Ozf95PgJXYm9adbnu/C+hSTkgfbE/9V9NKcIMgg
 HRMeJHRNIBuicTGs3UQ+sDREa7IliIfsFCFabvRGb6TsGW3SSHpPtHbx0yIy/j1iKuf3
 TDUrl8Nh/82Rvld9cf9IM7ELtUzgAgFs+Gr0ul9y9bsWQcAs0KNrYW5oAJA2Gg/PdMoT
 b04VtXAaq44YyyEtVt3RD/vSlwXSv8nN8ebYcfV9FKa8Vy2S+MC3aFG0FLFpc0trmbZ+ Ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22g6aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2EWc011007;
        Tue, 7 Nov 2023 23:08:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tv9m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK3DOo9G/Cu4iKnECZHgG1Rfs7Pu7IYi1qkcCjeaimK5p+1v44+4eQAnCswWXoJYTrbywwrjeexk2pv+VADzvQHzezV/S9Un3RSIO3gxvO1Wb4udyxgepzQzTsz1UWrLHsFziwfC026qrGBhjr1xrEuqohcfclL9dacezv9eJeE6JnUwR0WqpdulQk0JTeTjIXQSfG2DF8JX1jZluaLEnwpmqz7OfSQCfBrgN/LpcQqpqYJo4T0slVFe+ZzBDrf9kKFpqSw9zVKl6WoLZJ9cG/4FcB2NLZFcVjy0wuN2P0PZqnUjkg/HP+T+aFHVcV/H8S41ypsT9FizPVs2bKlQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OOP07ZJ5K6zJC39RegnS+KEULj9FcngGrvEUb0ws6k=;
 b=DbJKLtrh631FVTCkt7PW3L5jjxA2svLR9XENlLXilRbohygi1N0BKW7ktoKywHC8oZScBsoD74GyZNRO9mFCpuo1+mPGu5frNUe+LQm0kesC6WzCbZ6IVWO637LVrQYqwTMrmTZ2QcCSn8PjzTh0yL7fExt/RZwyfdYROuuNKlHpWUCQ9SnruKFO2NnGCcTaerNdkrtYlxsvxqhnTEAEadUbVkG8E0RtdhLTLfgLCaVY4bZXg8bKYh/bJ0+eZxEegR8hn/8G2szr6lMOZQjvz3pDhVWM8wj+CFoGuaas3E/BwImbDA65o9y6a4eMrGEiQT2DuXNkY7coiwFVcSoA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OOP07ZJ5K6zJC39RegnS+KEULj9FcngGrvEUb0ws6k=;
 b=chQK03sWHUl3IwwtZ4T148M+FywzSg1R2MIFMPabA9H7dHkR7Cov3PNBR2BvOxilnCUSPFreo8A4fA5PdMIRc+Z3YJfjM0Y7ydn72Nz+Kf4KuCAtalljX3DWnGnf9WK7TbBbknSY+qXFPuLDWGQyE392JucY/+KqvUeV6PploFg=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Tue, 7 Nov 2023 23:08:55 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:08:55 +0000
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
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Will Deacon <will@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH 66/86] treewide: kernel: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:02 -0800
Message-Id: <20231107230822.371443-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a03:505::23) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|MW4PR10MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a33053-30f6-4fd4-9b3c-08dbdfe68414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaRAPPZXVgVD5Jt/SdHiz1qj7K32eddOMxf14d9iiY/DnHBFukcb3pAQxBQhQcxjdyH1hTXTOqVzxkP20S/KfcxpSHos+3Ds45nFMmDLl2e/QNlkIdFQei6ggXiPbLzHQ6iq2PYxhQjHwrh2GaGGeRhh7SQto7ByhxxmPUSYgxWfIffx6TaNsfVsxhsMPlQ9FSAIAmDCfxAVmq0KwRojUl5bEk1usi2pkFErUNs1BtMUxv+jpyZSlIQPkuA2VsNinK8An8g7i0kGlnCygA9l9E+xs1h4RPjymAeBPDPxSwEDkcLPxJ30asS1lWG+et8E/wpgbyzxm861a8pXY5MwGCu023XBWHiZV+Dy37FDZOR0dpnhbc423+o4t0b66l6lYCqm36KN7hvB144H1wFmi3Uhocet0BTbtCrd7uqVDBWIaEgg3REXIOVVXaEwlURK7C51iPxmcPLT62J7NztvCURkJ2NCbe90ivpxzSo31dtYC22CNT9v1VDOer/j+WxPGjWt6yuPOePbzvx+vl/3bzbIewEBmogblbfjCXPV698=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(41300700001)(6506007)(2616005)(966005)(6486002)(6512007)(7416002)(6666004)(7406005)(8676002)(316002)(4326008)(8936002)(5660300002)(83380400001)(1076003)(26005)(66476007)(54906003)(66946007)(66556008)(6916009)(38100700002)(2906002)(86362001)(103116003)(36756003)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sx5Rda8oJzkLUFM3YvoR2Jsf3Wy+79Wb2k2dv4GlFGHCz3bVVovekmudqSyG?=
 =?us-ascii?Q?pc09icC5RhDEY3c9nGs/3DyIBVoHtcO6VLps+BbvjdeGpZtB0lmuFtRYc/JI?=
 =?us-ascii?Q?D0g3+VIm7CH8wyHU5kqMzJr3/929DRsykjRGjjQQUnzPOZ8kEmygQU95TejL?=
 =?us-ascii?Q?8Ve8zoWBp7TQUBeVla0mNh2g0WY6DoNPoV4F1TSkjCttoXIs2A9dlgB75xpj?=
 =?us-ascii?Q?z3Txj0k6WiaGBIyR6svYxSvOA0XieqtEPdCP5X3aYxH+76QaOs3RB0mbTc3U?=
 =?us-ascii?Q?mbO6VPW1mSco2828rhQm85qsQ1f1zogj92aMfyNoBGOOOv678D40x5Vhvh+m?=
 =?us-ascii?Q?5z+FrIf1dSMqzMZA1e8lzlZQ3IQ/EGynOqWAoxP2x6H6Te7xI+PMRQPBZa+A?=
 =?us-ascii?Q?4j7+2sfAJjH4ioWwVViiaG92Qw21L0eHZsioOi7LipSJZ7L/zwE7JA2Gdh8u?=
 =?us-ascii?Q?MkLCk89IbP29BYhkSPCAZHJAU7Bsj7D8/RRBZaQpW6uDCPhb+jdqJAL1rebI?=
 =?us-ascii?Q?mndNH0ReoY2S6p5IW9Vyy0qBmCLwIwUh07xSVUf8LStnWHHBbsM8bZZbrh29?=
 =?us-ascii?Q?WbWrT6zc3gDWvNeGZtiPMcUzLX62yefSr9yx2lJiJvs2u7eva0b+Y9YdeU3y?=
 =?us-ascii?Q?lUHb+KhxVc3xoMUdIwPXmUiK4aHHmhnZcE3iRF8I3DrWv79t2xWxJxksVCdz?=
 =?us-ascii?Q?HkAXkJeOx4Mse/swg3OaPhuaPRQL8rKI12X2vdowD6G+MTwzt5KmYo8toqsW?=
 =?us-ascii?Q?+ffukgUbM+mNiIrgpVvRtgYmKuJxLU0GZ7ZlAbgzYiiBnowx2J6VQxvxlf56?=
 =?us-ascii?Q?osIHeA856e9RycDiD/3HBCsV+RrrgygjObi0ijdD1JFEWytlU/p5/AOq9Cd6?=
 =?us-ascii?Q?AA1pN8vn378C4JOdveuDRrgoMuVvwsfBWhL59vbiQqowCS8OboONTojRdS3m?=
 =?us-ascii?Q?KncU0M7No/AzQlqcUT4JAQ1nk8snCjkrwH7oW+ZeD9lbZbAo/GichH143uYl?=
 =?us-ascii?Q?taRRZxuwUdifQ25U4YunYLJRPiA1k5BevA4D6eNk6VJTS0H2TrH+F97WAJeZ?=
 =?us-ascii?Q?3S3FZwMZQ7RcqQBfAsu+wg7lwV+Bk+6I5GqhSpsBLlZstXAoR8zUB3yg0ZO5?=
 =?us-ascii?Q?6v8UJroqXAdCjXVaDMNNrddg5QmDhWkqJddYzXtLHN2ygB+Jr0QNYEXlEVfX?=
 =?us-ascii?Q?ZQnDDP66WYrpjBeHTDcdAss0X+pndL3jkSUtjMUOlU/cYQrls+BtiCvlTiU4?=
 =?us-ascii?Q?7cxy/izxfwgocWD9Q7Eerxkk/20VJSeuvVbxksB/7E1GCwZh4bruFQuHe01n?=
 =?us-ascii?Q?rdJVlsrQtVf4xV49xkb+61jzM+fEmR+Mgx4zp1GkFH2BWCHWjCj6IovMwg5a?=
 =?us-ascii?Q?aVFPDdYChhCdOhmm98ww3Wep8M4tERLk9AnOBtUWm3xcGYYDL4YGu4szJ6PY?=
 =?us-ascii?Q?qKsF+5uS/3vIlMDftWUplYbnSZsDIyr/jVGC0c8ww1Iz26lf8cNwxJdRBtK/?=
 =?us-ascii?Q?6fLzjY/c12XIiK++1qUTcP7ONEZ9WsCq2yfRuJ5/OvTIVex7JnWXZD3gk0c5?=
 =?us-ascii?Q?oQpu2CTQMlZ1qfpBUupKfgz2cA2PhNMA/vBeQ7p5p6hhDGr+1854KOf1KJNr?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KfctkF6sY/Z4SzOekByewTHv5g/F1f8USFypEfDIHZFKVaYPCfOI9+56gjTh?=
 =?us-ascii?Q?XYNYvsTvPqIC3tmC5eG6sx73Wzj9GRk/QE/aQgJ58ap5UmiKxLcoDbQnMGaF?=
 =?us-ascii?Q?ewAUxb1RKjAwHLYJ0C8X8JYA9tSh0vdLqoNXUjt7A0zzVheTwB9bgOTTd/ei?=
 =?us-ascii?Q?DyzvFPGexSTguxZjNz5qWqItxhjCEbtumj+T3+Pl/lfEwqDkYYihIxQ6JtJN?=
 =?us-ascii?Q?5JztMPqiJp7rvHjiBHTWtj6tB/ntUjiu4Vh/XILrXj3ud4etQBGXVkCvWogm?=
 =?us-ascii?Q?iYmuMRk5pGwkQVvSZxNUivSrZWTcXGgGzvhtOvBfYS5B1VJBPcyt+aB9tq6f?=
 =?us-ascii?Q?bc1q1Ttk+JkfHa3Ukz1xllR/qq5Qn8GaWg0CXeHK4a1+7YLeeK+BFidqqzwz?=
 =?us-ascii?Q?yWAtYmfmFt51NwBi7no6mCiToB4QBPm+sC3whByjqmNLarBJ86u/dhWabgkT?=
 =?us-ascii?Q?TT1bDAdod/LLp37WpPMD+h7Pi4Re3fmAP5jMPiBXrBFJOO49PSa47SO/lQLO?=
 =?us-ascii?Q?7loRo755fLIF/OJkRFRcOmkLkTO7OT7ym23RyE0qxVogEoO2UmmlXANi4KF6?=
 =?us-ascii?Q?rKZaPVwhB/kXZyGhyGVWPhH2D1zbAKq/32+mAlsg3ssVa+POKGDL92nG219Q?=
 =?us-ascii?Q?mxGIIygVF7pmMMP4oI33sJrjpqcjzehFfEH2QS93J78yF96q8jbnCndebAeF?=
 =?us-ascii?Q?TqMiCFrCWUCZ57sET7tPTh1CAnX/6i9w6zraxti7UWi4t1OiPQOxgK/Nwh51?=
 =?us-ascii?Q?pRLQA55uSe3eR7TlzPndFNsEAAHa0uyRp54uCMSeVLhJH0JCFkeOZ+0n7y6Z?=
 =?us-ascii?Q?/Vw2hzcXxUOWaUdEVDI7EHh7fsB/efYFuQQ//w31mWx5dzAsbqA5sFT9qxC2?=
 =?us-ascii?Q?giu7oksbfnhI7gElCzopNGmaaxIoW21ExdcUaddvgh/fUv4fIkA+4dKhwM0P?=
 =?us-ascii?Q?rTnsbHo1/vh3+vDA0BAunylwR2Gs/gZkQH9sKTzwd2pJ3gAMDBeZJe/qrAaj?=
 =?us-ascii?Q?gf7OZuzVPFx/2WcuJ/mJNICB49YxEMA6vwjJ63O9u13I1rFSjGk4qds8c8xF?=
 =?us-ascii?Q?FwwAAFQBy5IoH32DVrmIx5PIfpZItaUumuPzHAq3k8WnFnujch9QsVKpxMNw?=
 =?us-ascii?Q?3vem60gQPdItUTAWDShniS5pR3e9bNgPnoJGHjM8adUYT0/GainFslUjCieO?=
 =?us-ascii?Q?gS5eeiQ5b1X1Qr033+/SE4o8nRPTVXHEfekmT0X4lfg5Zm97zeHz2Grxe8Td?=
 =?us-ascii?Q?Y8+RZVPReZmuOhUOIrg+Xz1Iqrj/4LIeVh4sEFiDATLtlQ5u1dQZVKt9x2VD?=
 =?us-ascii?Q?E8EwXEdm3AUmvbXKqjBx13gGEqQLIw/W9WQS3sCHUe3dErXTF146UnUGpuO0?=
 =?us-ascii?Q?NWpuIJ3j2zMqsuNSflb+bcwz/YfPE3dHsjcEbFZ3vRqv1oTDxCqueHOlMFQw?=
 =?us-ascii?Q?qReKS2TqtT923/fjwEDaG+/leGNaCM7BdHsAJIpb8YGfMAr59F8EgOJCI7ZU?=
 =?us-ascii?Q?q1LTzgzXjm48WexOWX7Zut2RLbMaMFmRXAA8Qu6GgYW5TdupjySpEYYxC5TP?=
 =?us-ascii?Q?Ote9l6kZKe+Epvsj7/V0OkmcooE/QImTnEIJ8PG0Z3NH4GdOvBPOj7SP5aDT?=
 =?us-ascii?Q?sfcbb1f4ww4A8LUrTtF2D+6G9JS6OnV95Rgzab2DctxEexym87XXEdhc3WkR?=
 =?us-ascii?Q?Lk2A5+P4WoMyDupYmyYmlQv+dCI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a33053-30f6-4fd4-9b3c-08dbdfe68414
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:08:55.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5q7pLPijrvOPMona7K8sU5qbJw6ZOVffbtpr00rtxqqt5Evn4cX/JYxn1imiHYiz5Psfx7T4TTh8hzpUEdhbuNwfUq2keKJI7GE8TYkiVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: pdLlzmeJJ_4t3JNhsYOqts4QHNbXtwH6
X-Proofpoint-GUID: pdLlzmeJJ_4t3JNhsYOqts4QHNbXtwH6
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

All of these are from set-1 except for the retry loops in
task_function_call() or the mutex testing logic.

Replace these with cond_resched_stall(). The others can be removed.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Tejun Heo <tj@kernel.org> 
Cc: Zefan Li <lizefan.x@bytedance.com> 
Cc: Johannes Weiner <hannes@cmpxchg.org> 
Cc: Peter Oberparleiter <oberpar@linux.ibm.com> 
Cc: Eric Biederman <ebiederm@xmission.com> 
Cc: Will Deacon <will@kernel.org> 
Cc: Luis Chamberlain <mcgrof@kernel.org> 
Cc: Oleg Nesterov <oleg@redhat.com> 
Cc: Juri Lelli <juri.lelli@redhat.com> 
Cc: Vincent Guittot <vincent.guittot@linaro.org> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched/cond_resched.h | 1 -
 kernel/auditsc.c                   | 2 --
 kernel/cgroup/rstat.c              | 3 +--
 kernel/dma/debug.c                 | 2 --
 kernel/events/core.c               | 2 +-
 kernel/gcov/base.c                 | 1 -
 kernel/kallsyms.c                  | 4 +---
 kernel/kexec_core.c                | 6 ------
 kernel/locking/test-ww_mutex.c     | 4 ++--
 kernel/module/main.c               | 1 -
 kernel/ptrace.c                    | 2 --
 kernel/sched/core.c                | 1 -
 kernel/sched/fair.c                | 4 ----
 13 files changed, 5 insertions(+), 28 deletions(-)
 delete mode 100644 include/linux/sched/cond_resched.h

diff --git a/include/linux/sched/cond_resched.h b/include/linux/sched/cond_resched.h
deleted file mode 100644
index 227f5be81bcd..000000000000
--- a/include/linux/sched/cond_resched.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <linux/sched.h>
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..47abfc1e6c75 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2460,8 +2460,6 @@ void __audit_inode_child(struct inode *parent,
 		}
 	}
 
-	cond_resched();
-
 	/* is there a matching child entry? */
 	list_for_each_entry(n, &context->names_list, list) {
 		/* can only match entries that have a name */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d80d7a608141..d61dc98d1d2f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -210,8 +210,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
 			spin_unlock_irq(&cgroup_rstat_lock);
-			if (!cond_resched())
-				cpu_relax();
+			cond_resched_stall();
 			spin_lock_irq(&cgroup_rstat_lock);
 		}
 	}
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 06366acd27b0..fb8e7aed9751 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -543,8 +543,6 @@ void debug_dma_dump_mappings(struct device *dev)
 			}
 		}
 		spin_unlock_irqrestore(&bucket->lock, flags);
-
-		cond_resched();
 	}
 }
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a2f2a9525d72..02330c190472 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -125,7 +125,7 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 		if (ret != -EAGAIN)
 			break;
 
-		cond_resched();
+		cond_resched_stall();
 	}
 
 	return ret;
diff --git a/kernel/gcov/base.c b/kernel/gcov/base.c
index 073a3738c5e6..3c22a15065b3 100644
--- a/kernel/gcov/base.c
+++ b/kernel/gcov/base.c
@@ -43,7 +43,6 @@ void gcov_enable_events(void)
 	/* Perform event callback for previously registered entries. */
 	while ((info = gcov_info_next(info))) {
 		gcov_event(GCOV_ADD, info);
-		cond_resched();
 	}
 
 	mutex_unlock(&gcov_lock);
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 18edd57b5fe8..a3c5ce9246cd 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -19,7 +19,7 @@
 #include <linux/kdb.h>
 #include <linux/err.h>
 #include <linux/proc_fs.h>
-#include <linux/sched.h>	/* for cond_resched */
+#include <linux/sched.h>
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/filter.h>
@@ -295,7 +295,6 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, unsigned long),
 		ret = fn(data, namebuf, kallsyms_sym_address(i));
 		if (ret != 0)
 			return ret;
-		cond_resched();
 	}
 	return 0;
 }
@@ -312,7 +311,6 @@ int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
 
 	for (i = start; !ret && i <= end; i++) {
 		ret = fn(data, kallsyms_sym_address(get_symbol_seq(i)));
-		cond_resched();
 	}
 
 	return ret;
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 9dc728982d79..40699ea33034 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -452,8 +452,6 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
 	while (hole_end <= crashk_res.end) {
 		unsigned long i;
 
-		cond_resched();
-
 		if (hole_end > KEXEC_CRASH_CONTROL_MEMORY_LIMIT)
 			break;
 		/* See if I overlap any of the segments */
@@ -832,8 +830,6 @@ static int kimage_load_normal_segment(struct kimage *image,
 		else
 			buf += mchunk;
 		mbytes -= mchunk;
-
-		cond_resched();
 	}
 out:
 	return result;
@@ -900,8 +896,6 @@ static int kimage_load_crash_segment(struct kimage *image,
 		else
 			buf += mchunk;
 		mbytes -= mchunk;
-
-		cond_resched();
 	}
 out:
 	return result;
diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 93cca6e69860..b1bb683274f8 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -46,7 +46,7 @@ static void test_mutex_work(struct work_struct *work)
 
 	if (mtx->flags & TEST_MTX_TRY) {
 		while (!ww_mutex_trylock(&mtx->mutex, NULL))
-			cond_resched();
+			cond_resched_stall();
 	} else {
 		ww_mutex_lock(&mtx->mutex, NULL);
 	}
@@ -84,7 +84,7 @@ static int __test_mutex(unsigned int flags)
 				ret = -EINVAL;
 				break;
 			}
-			cond_resched();
+			cond_resched_stall();
 		} while (time_before(jiffies, timeout));
 	} else {
 		ret = wait_for_completion_timeout(&mtx.done, TIMEOUT);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..03f6fcfa87f8 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1908,7 +1908,6 @@ static int copy_chunked_from_user(void *dst, const void __user *usrc, unsigned l
 
 		if (copy_from_user(dst, usrc, n) != 0)
 			return -EFAULT;
-		cond_resched();
 		dst += n;
 		usrc += n;
 		len -= n;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 443057bee87c..83a65a3c614a 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -798,8 +798,6 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 
 		if (signal_pending(current))
 			break;
-
-		cond_resched();
 	}
 
 	if (i > 0)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3467a3a7d4bf..691b50791e04 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -25,7 +25,6 @@
 #include <linux/refcount_api.h>
 #include <linux/topology.h>
 #include <linux/sched/clock.h>
-#include <linux/sched/cond_resched.h>
 #include <linux/sched/cputime.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/hotplug.h>
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 448fe36e7bbb..4e67e88282a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -33,7 +33,6 @@
 #include <linux/refcount_api.h>
 #include <linux/topology.h>
 #include <linux/sched/clock.h>
-#include <linux/sched/cond_resched.h>
 #include <linux/sched/cputime.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/nohz.h>
@@ -51,8 +50,6 @@
 
 #include <asm/switch_to.h>
 
-#include <linux/sched/cond_resched.h>
-
 #include "sched.h"
 #include "stats.h"
 #include "autogroup.h"
@@ -3374,7 +3371,6 @@ static void task_numa_work(struct callback_head *work)
 			if (pages <= 0 || virtpages <= 0)
 				goto out;
 
-			cond_resched();
 		} while (end != vma->vm_end);
 	} for_each_vma(vmi, vma);
 
-- 
2.31.1

