Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B817B7E4B3D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjKGV7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjKGV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABCD10DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:25 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJqiU015022;
        Tue, 7 Nov 2023 21:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=jJZCgv6rasNpsHSZGpFjq+NCtAYr81PJxscCsS4YJ/A=;
 b=W7urn/dVjmE4r0Noy4Us2pa6B3z+wyjYa0gqC6/DO12KBFP/UmxiGa4iL6jfyEJXmNgg
 Nii7mM+OalZJMtSgSWb1QyvZfEPJznwEYaKUlYc3BULtslYqruPpOwVFxYZtWMx+4oEm
 WDPhJ4i4ru16Pt3QG42iyKbDFttiqN7i+rD2tT+imwVET3cdyEwdgIxU5oEAoyL91SLT
 TCexX0xkrO9AAfP4KPpeZwl1ENOtMqCU6p8HzNvMXGmc0GaqTW+23L3232VbP1odfjmL
 a+BTGKm2F1CFInxe016UkKuqV14fVjmwepXMU6Xz9nZ4rCwwuT+4kzXLuZoomUxa0gSh 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26r2bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIrDP003912;
        Tue, 7 Nov 2023 21:58:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vsh7b-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKW8uWrq+mAmNbu5T/9BeDT7R8ioS8MgOTJNvvaBS7/2+aHWiuU2kwyNMaV60SqUh3V9X0I972O/9OE9UaCBf6t2HpI4qQ6WUY9hnfRt230542w7fzTBcZj8Bl6l+3usYuuuyqGZhcxS6LAz3IIuFtmStwgbK23AH4OxU9kEsIN8je/lnb0g7VVtXh88lJCF35pJScmlBl8IrABcRmWkRttuYZ8T6u32dcMdvrLWcTSZGsq9AJsduyUcwokVk0EA2NdUl5ZNW8A3HRibJzXP5d2/OmlejbqvMXGFlO+HdHrVkrTvqoReWb8Kj7Ub/Ie65HDs0zMxlRj1BnGfBfBuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJZCgv6rasNpsHSZGpFjq+NCtAYr81PJxscCsS4YJ/A=;
 b=ZjDEiZEkxAU2TM8bDS1EHNtlE09GqJne+Tp0onFBwK1fRbkc+4oA2Y6rSJuHdRk6yX1BBvjUUtjxzZ/ncv73e1yNSQ80qH0JUM70V4N7vHwEwMCVrXyZVBZmFAdNZ8sJTjDHCNcYPZfBPXd76Qktg31Ssby4Szw/Kg1zCPEYF96IvyQl6/X6JrKXTDoD2kMbUykU15EiIXQ6oKAlbp0JCdztY6hyoZ2aRWtN/D92Oaf4O8qG/u77qhZ8JMa76W5hKbGARukKKnE0wsZv7N9o5uMaQGwzkCUL1Do8GmFkdrdmMvptOxjsFLAUxrxMC5GkgfoWHEDbu+ST4AQCZJvG7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJZCgv6rasNpsHSZGpFjq+NCtAYr81PJxscCsS4YJ/A=;
 b=jyf6YoOiPdpEaM6cfk/jl6by4ZL8i1T0azao6Isr/4gZepgJAca/XNuqT00IoQ+cDdzqFfTEXYdg30y3YrdB/ujOTslfySjXejTeiaQIS/H4LmdRuMh4clWAuD3WqlWtLib31w/NnE7Vr9i6WH+pMKZE1eUXUPgsbWDpBbTEPN4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:58:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:11 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 09/86] Revert "sched/preempt: Add PREEMPT_DYNAMIC using static keys"
Date:   Tue,  7 Nov 2023 13:56:55 -0800
Message-Id: <20231107215742.363031-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWH0EPF00056D16.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1d) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfe6ba6-7ec3-46dc-d2a2-08dbdfdca28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKZPLam/CGH+Fs8abqyS1bWVFZSpDxwbxQCLioMgjEzw1q32Po/izXToowFAHbMnC26ORWqFs8AU9UUxyw2x+4UEWQB4Ck9GrSfzx1pQ3nYEC89cuA3zIbXw3u73eiqFpOF7VRzGP0C2KsrFAvWzjaL5MMeD4aobeDmIr8y3diuwM5fNCoRe/lWeCk7TpECe9MPmpw2JxH9QHp5R14sdXmu8bJua9ItNONc4PucmLffPyCKV0V7J0mvAfX/LdjLNzepSnDQCTebZskRChso847qwboO/Q7PwO7fz6IjXrI+XXFEz9lZArwD2jI8cWCLXs5xkNyFQW5/p3FsC9lCJeurMjcyh+B9Spd2jGzG5Dm1MKYUWHrAUDe4e7T4B9D0SHXv33Vx9NIe2cWUPwedA9BUQpIjjBZzoFa7e8Ip7nBohktGtmxSyzNKAUrN0hMhwPchvh+VKKaboRKWdEpUgtnaDXptjIFGin5bLVLwxZSZ0D+24m1HCI4K9GIxcHOmHn0xeNyt+k5LAqJivRzr7ktw2rBZuCv8BsGWHoDZPaYyGaQCDcb/8+dijc6xmgaag
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(30864003)(6916009)(41300700001)(66556008)(66946007)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(6666004)(5660300002)(4326008)(8936002)(6506007)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CKgehby0Awlff/hXozmM6PrHx7Jxj3rq29glFu/O39ie+hpUoOD4SdD9q5iE?=
 =?us-ascii?Q?/ZqxJto4GAbLas3xckbjMXBGipDgJtk/fWtr2benf+h/dJyEAzjG2l50TAAT?=
 =?us-ascii?Q?/clP2IuAdDixGEdyTW1MSs9Fe7vu2N34rE4BtW7Mjz+P2ABAJqyz1c0APzDS?=
 =?us-ascii?Q?kaWIfY1zHPYzWFdHVhg5SUjn0/5CO3EnEu1fjrxRXwVOqyZx/GpHzNxLN8Jg?=
 =?us-ascii?Q?z8Qu/vwoN6OJdqSaHJ5HoJExf+I0hNKxiYEskyYUqaV1i2SlxiWRIdOdcRAA?=
 =?us-ascii?Q?G6RYMebVOvQFgL4lA/jATZlPXbRDvQ+Lp1nCfnZ7tARwB2ZwsLsYB3Mbd1T4?=
 =?us-ascii?Q?XxJG3RY0UHScwCNgwCczg3bGp+nps9rrepeOM7wwNDb+C3jYWz8VbjhfLAn/?=
 =?us-ascii?Q?FpyOat0H4qLa/zJYG/JMZflQH/SnIryCs8KairDbi8NT+T1xb6fVrJhKoB/u?=
 =?us-ascii?Q?te6vmqrR/LB1IpImFoCGptXVpvlRC4vTgYogugB0lLyhwfjFRXi4cbEkBY19?=
 =?us-ascii?Q?4HvgfifJtuni+85dX7JVcqq6UcoT5VGt4971nfIqRyQvn/UG2NmcCBjU+1OC?=
 =?us-ascii?Q?quqLHk/T0WZ+DNLqvw8fJ17DXKD5Pjcx2FjQ996gvbKxpdSvz7bmOur0wQ6D?=
 =?us-ascii?Q?ltn+MxlRJzWbg4o8qwBQuyL7VH7pKQ56W4JMh2Ue7Y8FRy8jYneT3dwdTxno?=
 =?us-ascii?Q?nEaG7JGzoCJQ36FxVxf4xvVAj3xqdcE/4Y3M9NDjlmVKc6zEpkN1iUIWZT+i?=
 =?us-ascii?Q?TNjfJ+QssC73HQPVjzcZyCfH/wdgPLbEytFbMfbed3FD9jdTfWCXkqMrmrNp?=
 =?us-ascii?Q?WsdZrHO9yv6upltgzaOFhtWhlmEH9y0SEwmvQiqWY7ZoESFXYthcKYPWKJNS?=
 =?us-ascii?Q?yQJYWSYSPfBQ5Hf1CO0AacMb7C8Sj/IWLowHmEv0xtMGgJ+gf2nYGRz+lUg+?=
 =?us-ascii?Q?9vT8y/cCsVkPees4KzlEMPbQM4MOUvF/CnzEGKjxh8kUUdsg9brI7897QkGQ?=
 =?us-ascii?Q?o20U9Lwhx928tJ6ntxav49sebvpareRANLp8Xs4e92dttNNrnjKSJnOsprzC?=
 =?us-ascii?Q?JHroMCQ7ZZUcQsGpaBm7WcOXxSBvwz6Dkz4Mms7692Dv94KQ9XcIY3YwNLsf?=
 =?us-ascii?Q?bJ8OMLhq8GL5Gyp5js+g2mFme1eJ2IzyE8euDpt4KhAh/YE0pmkntmQf2/rs?=
 =?us-ascii?Q?egMPWjmxeEyKyNHN0dZCe3HZ3v0FWcDjjoI1BhhKdtBurlLKXt5LoVAXJqwx?=
 =?us-ascii?Q?Z27idJTjygQgtsOPKSK8/aubkxZRCewMtdy8n2QTr6AqikF8mXsNo05Catsp?=
 =?us-ascii?Q?BLm3/7avpQaPMR4KCTB/KtERs58BKb9MIHix95Ieh4TbZ99KtmipGdJDltuB?=
 =?us-ascii?Q?WqfGxrW6Smsle9v9PkPcun01tRWWGqSSp8iTps2vdE5hkGPKxLNC436NG6kB?=
 =?us-ascii?Q?J1UyYFK7ImZOgNyf54V9M6u4xmQVhNWsTW2c/UaE/qjonGkbchd1nEg6JZnL?=
 =?us-ascii?Q?3KqEV7YJXLFPZGsWT72gagRlfM0Ydb7qWLW+BM9RtX0CAJ3IyiD3fadqDYwP?=
 =?us-ascii?Q?8sGzdSoMFcntG5M+TDdw0skPSpbb4LCxYgmT+n8iMfLBHMLXsvVpMSQfHTIs?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6Q+XycAEaJkClUF5QvX2jPrSOEpFAiT32UCKn7p7EJK+CPI0jmIBo63RMmFx?=
 =?us-ascii?Q?AR2N/Z+Zw2HSABecokc5B5gUM49G9Z4idIwJvPbdJL3erM51TYMRhDzR2uq9?=
 =?us-ascii?Q?TBPZosQZR7SE462TthTTU5aya9V1DsMnofNH+RvnPe7x8SkVF5ZO9feAJnqm?=
 =?us-ascii?Q?PUsM9JBEyJrcr6SLr+vNxkI6dlNoY7Lakw+JIr3OlK5voOtDQwTUw0JK1Jt7?=
 =?us-ascii?Q?4XWvpyJytCzTmYSrRAmZng+YBpa2y/LBGKrxPyE2Tg4jgsmXJ/bgJ9YMom1x?=
 =?us-ascii?Q?OWrmczR03lMkqAyx1UtxomrTC22nGmBUKtuQqbZnLhYrGGcDlPXbUnkqyTtU?=
 =?us-ascii?Q?kn9sONGiMj9PdbP33gd6PcUQ0un8ySus1kWzbMGzcJCZNKa/ywEUs9GUERNn?=
 =?us-ascii?Q?MA0Jr+dtcaDzf26kFNgDWjyethAPXmvgzCNp5yTZTaKnwOoPvXPmLtjVqRHA?=
 =?us-ascii?Q?STcwFk+h/mkc3Lobquwob11iSK+KS3QdMH8fpTITpSX1VcTZMFIlGzJ5sXLO?=
 =?us-ascii?Q?BW70aisL8IK4Tfh7R6+DesLPlz5znRUvuEqi4fcjErORl33uUAzGsRcyhDvz?=
 =?us-ascii?Q?EN2yHGsgY/2pPK+3Rx3iarNdPyn95BxL7f5l/jCzASiNtrrgAC7lPbtTtpga?=
 =?us-ascii?Q?ACV28mDM0dIdC5cQFsw5r4Q+CD1+2kM/QZPxOi3A9VLv587HILDmqpUhlfxI?=
 =?us-ascii?Q?jauYiTloBHuEB2mXveb97+b1rt2jFTzK+CtdVy5yYlxjduErm1mfeUXpFTqL?=
 =?us-ascii?Q?/5AvZGlYS/yBLycABGtrwKgoPm1GcUYW/DiPigfZlEynNu9cwuv5tHfTDDIq?=
 =?us-ascii?Q?hV3X49ab8n4w9zxzUciQru+j5lEa7vlv3KQ7KUo+LDgvWbRq+M5EkYCZLTnZ?=
 =?us-ascii?Q?W5TuaJmIBFT13CJfLgEW1uHTHv3eAvZLLyl4NfN4VcTb14pobFXHUBpDvCr4?=
 =?us-ascii?Q?fAYoD3Kx/OCzSkLPFqjEoNh6NfSdd1IsUOdcPIk26O676SX9jQiS6nz+umvr?=
 =?us-ascii?Q?SV/LJZIShn9x+pDtePdwIS1GfKl21xPX+Byy7k3q+UA5MyeMQZa+/g/Te2S8?=
 =?us-ascii?Q?gUtcbq2dArIEGRa2UZZIohcOt+RekutAn4p1TD41snl1Jh3X6WcPS7vqPoeA?=
 =?us-ascii?Q?D40HDqDD7zljRmCKQ0WVULJ9KGIK5rPsYvduK3p45QGu28gTFX+Tgsd1J5yr?=
 =?us-ascii?Q?+VjV48DlLbRIokHu22A9STLaFPiUvwLNm69/gyu4Q/tg4Z1ftUZT3v0YySw6?=
 =?us-ascii?Q?mOfT9xXyNNUTuWiLASvN4jXojxHSAEtzoRXthdc+InS5MLQrIsUIp/Yrer2q?=
 =?us-ascii?Q?JtB3374Kg0LkCzqD6u362ryfwv9Z6muRJ8DvKaOiwe2CW0ddwx2z5lhRqgP0?=
 =?us-ascii?Q?CQ5opRiQx2PJjGVQPNm+j+GpAWG50+iGtfWBzNk+psWCJwV2lvaEXQD3d+eE?=
 =?us-ascii?Q?EvqJJwWViO4ISrqLR9ELLhunl2rzLHWKuLeuyUN/p9MTg3Gsxe8WHgrijjPI?=
 =?us-ascii?Q?blBML0pj5LEgXwCnPCpRWZ0EEZEL2cgC+Uw3NNB6Kto3u2+MVX/5SfrynA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfe6ba6-7ec3-46dc-d2a2-08dbdfdca28d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:11.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZ8wn1aJg8coheTMpxBuOOGEVpBbfoH2a52kdExw7kmso1y4yMcMKhVY6PNsimqSYBs/hS7foaPwz4MZI+7L7VSuAERkrlgx3/UOyaUGHbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=905 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: 4Rly8C7N-vzok3oHXOf7mNSol9ADZI84
X-Proofpoint-ORIG-GUID: 4Rly8C7N-vzok3oHXOf7mNSol9ADZI84
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 99cf983cc8bca4adb461b519664c939a565cfd4d.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/Kconfig                 | 36 ++----------------------
 arch/x86/Kconfig             |  2 +-
 include/linux/entry-common.h | 10 ++-----
 include/linux/kernel.h       |  7 +----
 include/linux/sched.h        | 10 +------
 kernel/Kconfig.preempt       |  3 +-
 kernel/entry/common.c        | 11 --------
 kernel/sched/core.c          | 53 ++----------------------------------
 8 files changed, 11 insertions(+), 121 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 12d51495caec..3eb64363b48d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1395,41 +1395,11 @@ config HAVE_STATIC_CALL_INLINE
 
 config HAVE_PREEMPT_DYNAMIC
 	bool
-
-config HAVE_PREEMPT_DYNAMIC_CALL
-	bool
 	depends on HAVE_STATIC_CALL
-	select HAVE_PREEMPT_DYNAMIC
 	help
-	  An architecture should select this if it can handle the preemption
-	  model being selected at boot time using static calls.
-
-	  Where an architecture selects HAVE_STATIC_CALL_INLINE, any call to a
-	  preemption function will be patched directly.
-
-	  Where an architecture does not select HAVE_STATIC_CALL_INLINE, any
-	  call to a preemption function will go through a trampoline, and the
-	  trampoline will be patched.
-
-	  It is strongly advised to support inline static call to avoid any
-	  overhead.
-
-config HAVE_PREEMPT_DYNAMIC_KEY
-	bool
-	depends on HAVE_ARCH_JUMP_LABEL
-	select HAVE_PREEMPT_DYNAMIC
-	help
-	  An architecture should select this if it can handle the preemption
-	  model being selected at boot time using static keys.
-
-	  Each preemption function will be given an early return based on a
-	  static key. This should have slightly lower overhead than non-inline
-	  static calls, as this effectively inlines each trampoline into the
-	  start of its callee. This may avoid redundant work, and may
-	  integrate better with CFI schemes.
-
-	  This will have greater overhead than using inline static calls as
-	  the call to the preemption function cannot be entirely elided.
+	  Select this if the architecture support boot time preempt setting
+	  on top of static calls. It is strongly advised to support inline
+	  static call to avoid any overhead.
 
 config ARCH_WANT_LD_ORPHAN_WARN
 	bool
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..ec71c232af32 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -270,7 +270,7 @@ config X86
 	select HAVE_STACK_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
-	select HAVE_PREEMPT_DYNAMIC_CALL
+	select HAVE_PREEMPT_DYNAMIC
 	select HAVE_RSEQ
 	select HAVE_RUST			if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d95ab85f96ba..a382716ea7b2 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -416,19 +416,13 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  */
 void raw_irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
 #define irqentry_exit_cond_resched_dynamic_disabled	NULL
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 #define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-void dynamic_irqentry_exit_cond_resched(void);
-#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
-#endif
-#else /* CONFIG_PREEMPT_DYNAMIC */
+#else
 #define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
-#endif /* CONFIG_PREEMPT_DYNAMIC */
+#endif
 
 /**
  * irqentry_exit - Handle return from exception that used irqentry_enter()
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index cee8fe87e9f4..cdce553479b4 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -101,7 +101,7 @@ struct user;
 extern int __cond_resched(void);
 # define might_resched() __cond_resched()
 
-#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+#elif defined(CONFIG_PREEMPT_DYNAMIC)
 
 extern int __cond_resched(void);
 
@@ -112,11 +112,6 @@ static __always_inline void might_resched(void)
 	static_call_mod(might_resched)();
 }
 
-#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-
-extern int dynamic_might_resched(void);
-# define might_resched() dynamic_might_resched()
-
 #else
 
 # define might_resched() do { } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c5b0ef1ecfe4..66f520954de5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2084,7 +2084,7 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 extern int __cond_resched(void);
 
-#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+#ifdef CONFIG_PREEMPT_DYNAMIC
 
 DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
@@ -2093,14 +2093,6 @@ static __always_inline int _cond_resched(void)
 	return static_call_mod(cond_resched)();
 }
 
-#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-extern int dynamic_cond_resched(void);
-
-static __always_inline int _cond_resched(void)
-{
-	return dynamic_cond_resched();
-}
-
 #else
 
 static inline int _cond_resched(void)
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index c2f1fd95a821..ce77f0265660 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -96,9 +96,8 @@ config PREEMPTION
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
 	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
-	select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
 	select PREEMPT_BUILD
-	default y if HAVE_PREEMPT_DYNAMIC_CALL
+	default y
 	help
 	  This option allows to define the preemption model on the kernel
 	  command line parameter and thus override the default preemption
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index ba684e9853c1..38593049c40c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -4,7 +4,6 @@
 #include <linux/entry-common.h>
 #include <linux/resume_user_mode.h>
 #include <linux/highmem.h>
-#include <linux/jump_label.h>
 #include <linux/kmsan.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
@@ -390,17 +389,7 @@ void raw_irqentry_exit_cond_resched(void)
 	}
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-void dynamic_irqentry_exit_cond_resched(void)
-{
-	if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
-		return;
-	raw_irqentry_exit_cond_resched();
-}
-#endif
 #endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b43fda3c5733..51c992105bc0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6885,32 +6885,22 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 	 */
 	if (likely(!preemptible()))
 		return;
+
 	preempt_schedule_common();
 }
 NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #ifndef preempt_schedule_dynamic_enabled
 #define preempt_schedule_dynamic_enabled	preempt_schedule
 #define preempt_schedule_dynamic_disabled	NULL
 #endif
 DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule);
-void __sched notrace dynamic_preempt_schedule(void)
-{
-	if (!static_branch_unlikely(&sk_dynamic_preempt_schedule))
-		return;
-	preempt_schedule();
-}
-NOKPROBE_SYMBOL(dynamic_preempt_schedule);
-EXPORT_SYMBOL(dynamic_preempt_schedule);
-#endif
 #endif
 
+
 /**
  * preempt_schedule_notrace - preempt_schedule called by tracing
  *
@@ -6964,24 +6954,12 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #ifndef preempt_schedule_notrace_dynamic_enabled
 #define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace
 #define preempt_schedule_notrace_dynamic_disabled	NULL
 #endif
 DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule_notrace);
-void __sched notrace dynamic_preempt_schedule_notrace(void)
-{
-	if (!static_branch_unlikely(&sk_dynamic_preempt_schedule_notrace))
-		return;
-	preempt_schedule_notrace();
-}
-NOKPROBE_SYMBOL(dynamic_preempt_schedule_notrace);
-EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
-#endif
 #endif
 
 #endif /* CONFIG_PREEMPTION */
@@ -8583,7 +8561,6 @@ EXPORT_SYMBOL(__cond_resched);
 #endif
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define cond_resched_dynamic_enabled	__cond_resched
 #define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
@@ -8593,25 +8570,6 @@ EXPORT_STATIC_CALL_TRAMP(cond_resched);
 #define might_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
-int __sched dynamic_cond_resched(void)
-{
-	if (!static_branch_unlikely(&sk_dynamic_cond_resched))
-		return 0;
-	return __cond_resched();
-}
-EXPORT_SYMBOL(dynamic_cond_resched);
-
-static DEFINE_STATIC_KEY_FALSE(sk_dynamic_might_resched);
-int __sched dynamic_might_resched(void)
-{
-	if (!static_branch_unlikely(&sk_dynamic_might_resched))
-		return 0;
-	return __cond_resched();
-}
-EXPORT_SYMBOL(dynamic_might_resched);
-#endif
 #endif
 
 /*
@@ -8735,15 +8693,8 @@ int sched_dynamic_mode(const char *str)
 	return -EINVAL;
 }
 
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
 #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-#define preempt_dynamic_enable(f)	static_key_enable(&sk_dynamic_##f.key)
-#define preempt_dynamic_disable(f)	static_key_disable(&sk_dynamic_##f.key)
-#else
-#error "Unsupported PREEMPT_DYNAMIC mechanism"
-#endif
 
 void sched_dynamic_update(int mode)
 {
-- 
2.31.1

