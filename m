Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDFD7E4D31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbjKGX0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjKGXZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:25:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CF3211F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:24:20 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJLHn031834;
        Tue, 7 Nov 2023 23:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=X3Wi/HeUYF+nze8MT+y61r5lTM6ncazJ1YoQXFIb8xU=;
 b=DNwDlhA2mGG0U080JoLqVoSKUUsXayF4B1mSfd1qsD9STCTeEXYMX+1vrzZzSkzBqDt5
 g/1mwMq/XRZsPyEU/KjAhmtHFmTPsSW8uXlMJHK3Vr+dPkrdLDSjBOqladErku+A1eby
 5WsjdxcJ5UwyZHEM9mqllHiQK5pWjDxHWQq9r+GkOlGn00CiTx9vCGu260277aFnSpOG
 STVHZT70G2dhXGyLVXOWAYEnccoQCkFVeECGvwNzfC/jWFQN2yIsh3NioMF8H1pO0PZc
 yyLxj/a/TtLH5tsUGzY+KX7rS9JPH9TfxwcZfA4pkfkZoxLdUvRNb8eFzzNi1+qm1Ujq Yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g6kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:23:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N24Of011049;
        Tue, 7 Nov 2023 23:23:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tvpyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:23:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIXSadGJwRyfp1Xf5u+2Dfd3YF0UYvJvfjvjv5CHsr2L1+BqoMLG0f6zq4sXM2jTh3XnQutEeEDYsJO02OilNpnGHEzv92Xj9uFimSdYQPVI5EdyJ1gpsM6jvl3tfoz3KEu/7f4srUeuIotZ18mH9h4j0czOrXB7Fj+ff6ed194mLH9zgxhVFVP9o7qpKb3U4AVpSnhc+lrW/Wzu9c6bwDNg2FTHSSLAm1Nkp8K15vdpP7jotGIp7+7aTAqCHyTVc5dZ18AEuSb0omi0jCtttbK9CcR2g1Mwa+pTZhfwqLicxlfJ/N9rvA6J+NoSZnI5qLqlRL4DCmOZjE2+enAuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3Wi/HeUYF+nze8MT+y61r5lTM6ncazJ1YoQXFIb8xU=;
 b=fZfnPLpnfyE9eyz/ItWzTeDwTNkbDgV/TyZl5xww4dOEuURVvPD2biB36ZagwxdwUxR9rMx1mZ+3qtiRsUI6MnZZfRPGcHoaRDge+sRjEaAOF8R8BsxmJwP4D3TZ0keuk9LZpmYljxqGRBfHwFFweNx/V89ANCftc5U1HdomDEJgEZ6N7aEQ6D12IpcxY4dYZjSlOyqWAZodni4WICbUMv3FTwstTvp4iGmKtVRVSOQyxy7x7kOb3xVFzkJmJw2xMiDvfQeac/0InmMsW2Sgj2ejyN08K7JD5g2Bi/bik0V9jOlnIWMvodlbln4eD22TSIiNER2LPQIWtcN7BAMCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3Wi/HeUYF+nze8MT+y61r5lTM6ncazJ1YoQXFIb8xU=;
 b=YQ/tfw4f1styI9v5N1+rctHgZMbjXpRodqfCY+3SNpIx/bE1rvPmMS6iZPL1XwS0/SSac3SJVVPdc3atdkwyC8JnghDC8PIs2FxDGthAH3Nv2QsEg3lf3EXybMbFapprRh34vabRgegwcyg7i9gFaDYdU3XMNycuiITr3sMnUeI=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 BLAPR10MB4932.namprd10.prod.outlook.com (2603:10b6:208:325::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Tue, 7 Nov 2023 23:23:08 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:23:07 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-4-ankur.a.arora@oracle.com>
 <20231107181057.334c815f@gandalf.local.home>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
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
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 03/86] Revert "ftrace: Use preemption model
 accessors for trace header printout"
In-reply-to: <20231107181057.334c815f@gandalf.local.home>
Date:   Tue, 07 Nov 2023 15:23:05 -0800
Message-ID: <877cmtywpy.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:303:83::29) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|BLAPR10MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: d9beafd0-41ef-4557-6714-08dbdfe87fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1fWKp4HL165e0GhUdBZ5DklpU4MAx7d3p84gLKiaOcmnu2+DHnApwLC9bFl2XZFNgtugsb2xVg//zkr4g1OSZKtzYrW8Du1HtdSzTLAbvt0GVehdZeRoau0E9lr9X1CsIvOKK0qJeRp2tLNPmPN10vnh+td/jhVcr4eIUjqToLMnxDJkW6K1i+iGKDBg7UCezvA4P3R4qzBOi3a3iejbeGDhaTcYfcd1vurLcr5GkEHKIdki9REAkL6u6yjGtzbFK2DoBxJ9U2+CNppiN2SwXVWZcuUmEWjPSJ9HQ8Nb5K+ntk0VJv3wNBQREQ2xeGPmKtE7XOn4VIIbqnSOawVgIs69AOoqSIrBqsv69BC40+nrKki3LuWWFmBrk3Lwsou8upHGYc7WHQpgNPgksfCk2C3eENn2s1TS+MwMJnmpRXAs5LGXcCwKnkYi2N3Yp/ZsrnMb28pn8c0sb+4HGeLptm/I7Zq0P9VahyuD5qCCjlsbgAMnbLABoKCTvhrqiYbJC0ftGqt649zVpSlk1w7SLrM35PHl748MATjgY2bsMb+Q71cVLrAyz5m7LjazQJD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(38100700002)(83380400001)(5660300002)(2616005)(478600001)(6486002)(6506007)(6512007)(36756003)(66476007)(66556008)(316002)(66946007)(6916009)(8676002)(4326008)(8936002)(86362001)(7416002)(7406005)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hk2tbdMnHwAYVezQCpAa8E3mlGDZiLJC1pxPr8FeMLDFPmSFNkmezqSYejFO?=
 =?us-ascii?Q?Ut6ZIGMcr4evrUrgtrFGrWnR0+8zLryXcg6Yr884Vpen+eUYdayQfPAOt1A3?=
 =?us-ascii?Q?vClRTQgliPv0j7kbXgBFo2JpchB8PSEGNRaWGrizk9Y5YjlrYsSSBKVJKhue?=
 =?us-ascii?Q?0/2KphpI3vHUKG/XVQ4eJAG4pwAQJ+650TtonK3SKDkHi1auFZN4vCoPyxdB?=
 =?us-ascii?Q?gKuC1Kn48PV078O+RWaNLunBh9WxmgpUkUz2snbFb9NRxDRW3UpRCIkxCGyR?=
 =?us-ascii?Q?dg41OzPGQlX0kSH64Ah98ec7PUM1mXDLRDCNr2DHkagWgV5QPxR67A/Ka/Iz?=
 =?us-ascii?Q?r+EuwHu/qazFioJrrwNtugOKcoBnezYtyc6X0SgAoYn9GWGRWf46wrDjJumL?=
 =?us-ascii?Q?DlPr5kowOkbbHtPz7oPHkdkgzFV0ddrv/MRv0r/XH8JNT+JsRHyzIefmHD4g?=
 =?us-ascii?Q?XvU3OlIgerLtgQ+ldIDxfAEudu1aa2t/hxKpzBFH5cB7kLgufxCvT0xjpwhc?=
 =?us-ascii?Q?cf04nNmcJ9TifkRhJa6yxsGVjxwrtGeGXl+52rb887QM4XNoM5khtUQdKF96?=
 =?us-ascii?Q?EPZT+G2Cg7Zq/Uw0Cmi7johmyM/qp7dbzITRMN7U3PVl2RvaRcaWCWBPTD53?=
 =?us-ascii?Q?CoyYQPkW0imOUwLhYZlFAXwd2L9s8kRUqk2Dm2BtQZ6gT2+4KHqpMW5jzQp8?=
 =?us-ascii?Q?6DnsNW1DXca9JGTQWJ9jDZzVbLxRjObtQdvwtp/qFyL7+oKhOtdP1zTO+0WV?=
 =?us-ascii?Q?p8RbOg7MXhQuVxmetWv8IK2Sa3fMtIKu92+ZeyIL/pEkIG+TuQ/65FdeMXsE?=
 =?us-ascii?Q?FUf+kR9NsU5Dzlhe7cXQdZuQKCJHRHHTlLHojY3iXma15aStDMF0vsh4UkdW?=
 =?us-ascii?Q?PoyU3lfBgCiZurT75hSndKZUdmIcZFhb+5ZXKBQsX+g8oLSE7mHPJVXxpgC7?=
 =?us-ascii?Q?d6gKtW+y1Ty4BJ2F12ehOAH8JrW2qU0g9rwt576UdJFdZZVuw4NWKKMlstta?=
 =?us-ascii?Q?Q/hpuY5RF8geMOZh35ap+NfeUN5KLxxRQP//DnBm2fVqbDT3tl2rG5h4lwte?=
 =?us-ascii?Q?GB//gF7thZ4ZpRoKYte1Biipa9IkM5Dc4Ddt+hm39gBgk28Csl/3UZfR/Fcf?=
 =?us-ascii?Q?ThXI7LL8qgYN9iJW1FaDZoWyiVDqtnCSdm/1V9luh2J4Dp9FV5PglC2P22Rs?=
 =?us-ascii?Q?LXJ6aquA4gXn1o7zI91Od/gycubYaiy2VpTbhP0MQGkeE/3NQc7ca8UBK2hq?=
 =?us-ascii?Q?NBXqo/gUQ8WCF5XDkMV0f8SxkuuHyGVLYNaASvdqnX1wsEiP+5puNbS9r0vY?=
 =?us-ascii?Q?Ud98VKF+EVvZtwffkv1fvXaJidJaF0aw2aXVX0cJwoAa7OrglSqtHKKzOFkU?=
 =?us-ascii?Q?uov5tbYxHiw5Cv0bBndL3+YCnqIXgkSmkwGEMz0oT/u6dcrO4wIrGk/H7wd0?=
 =?us-ascii?Q?VwRAu33FCqMk9GmpGO2cLxWVR2OUl4JkR6BQndHgKyb/+A/49T1J8GhT2Rib?=
 =?us-ascii?Q?7FJZnTw1bncm66Qh/QuG80LpuhlQ3qdJzAnDL7ZtvgqHeuycs2pFj6rinell?=
 =?us-ascii?Q?CE8H6FAfAoVR+RIY99bg3ipK38gaSXees9kaBAjYvh6SI25DZ2Epqfgpv+3Q?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YuYOnepzmrNWSWiuMFNE6UAGhHoYu1n4h2r5rZpVzS6F2gU7vul6pnwWPp68?=
 =?us-ascii?Q?S9wf+uY4ZPpfHDPWNGhB7h2GfCss//JZY4dmOGRf4WraCW55N+c8Kg2mvuik?=
 =?us-ascii?Q?vgDEx95iEd6d1HBANMcqYtsSUP4RwodqJX3CGhFAExfpwARswPcM9kt9x4NK?=
 =?us-ascii?Q?S7Xj/UaDPygLUkO1GhqhMMp62i5iCq8vHnYx4fiWb5Xttt+0oHpP7I1pipP0?=
 =?us-ascii?Q?q0juI1k2ViJhEjrmo12IuR1hFwUiezwK57VfrDQRoUfDYGn8wzi+lCNt5pjz?=
 =?us-ascii?Q?6ThLSZbhCH7rOglweMHFtaB9QQ5lFoZDnCOGbptyFxVHQ12RLELkcXHEevAg?=
 =?us-ascii?Q?Y/fUSx5jWvw6CYVBId5TFMd/VA3PydY+A9bp+zhsYWbVrLD9hzs5Hnj2RPVj?=
 =?us-ascii?Q?RpBwYkfB5trZOYD/+j5Wd3iL7cBu2JmsuGfURYu2lL2vvlxpl11+WODQAzyd?=
 =?us-ascii?Q?f5uDAuf1eA51mWZeouChXZGniJzoJAR4Pue25g5xqNOhS5CepkxPFp20UgSy?=
 =?us-ascii?Q?WIKazGjOhe1Pl8hcUWpRbCPk7CTTGnMpVuYYlskrWTzdkekvHSuywx9hYw0n?=
 =?us-ascii?Q?sxoqYg0V6tU9uCUug7PB0l68f840iXPiQlCMyE9/iyGKuVyI9Cn7Q81O+uGB?=
 =?us-ascii?Q?Ig1AOjCIcUsHNpHz6tXne2E0UUAPxXGcbRK5CAUTBUvseEddBceuv2aOQFgW?=
 =?us-ascii?Q?mRAFkervGAEyYPOvhQKwDrTiMFn0qCuMCxk/BjYwCD5i64ywRcjmVphwUKvW?=
 =?us-ascii?Q?Nw4ERWx1wpaPd/c3rUARNnsHtdYSsyxP0+qSlkr174MqQKliIaUgw5xUPOnt?=
 =?us-ascii?Q?gR+RpUGlSH4tzVglIt58yWclKva4LJ4CV77Tc0LXd1edSBUhApnpEEIYoBPm?=
 =?us-ascii?Q?mM0Q000n58sFuaCRVxPqWK5mgOQP0/Wlx+HV9wpJ/P7bTD/WybgbbMsoqFML?=
 =?us-ascii?Q?xrqc/mGhUrqfc4DzEunfRYkMJBpmrXrDP8P54fSNpXxwf7N7J2fc9Ru/XYmC?=
 =?us-ascii?Q?KMkKIeNPgEvM1CO1EhWjQIJaBqLawvwpWaEZQXO9xpJUhdBE4GEJAM9vWDb3?=
 =?us-ascii?Q?3JEaxVTnSzYEBJ16GJTMBLRi2lA/2WEVAO942CgE6Ec4cM2zDtZzHDhdmnyI?=
 =?us-ascii?Q?d307oUWr/E3gs0ZOl4+2mozH/ta7Z+IxNfU/pf+oGzNqGPNc0IQsp8Mr657K?=
 =?us-ascii?Q?BIVrq5Z5Z2r3xNUb/goZ6cRnG+FZYuq+LCAwlwhjLIKrxY1F2Jw+sFsuz0WX?=
 =?us-ascii?Q?RU76GQzn1+S10MWQEMttyJFJgPNVs509NlndDWdNkfkVOZnuQILTzgs0awww?=
 =?us-ascii?Q?0TzA7KKVS1aX3SsXfJooMdN7SQArOW5ctGldf1LgejrG27VpBKxp7VMHqcQn?=
 =?us-ascii?Q?cd+DXiB420ehmBdeqLvs9XSjagrZYtEYWbC1pcTZz5se9SzGn86Ccp/Yia2c?=
 =?us-ascii?Q?XW6NhMfDQiKYHbOOrVxDMP8GkXbitHPPHdbrsPiKgrxdeLUxfLFeVwzXZqwS?=
 =?us-ascii?Q?KP7OuuhSfJMfU9HeIhu/lNdVAQQi7RavVRe5/EAIsJ5HAxwy/avokENsCA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9beafd0-41ef-4557-6714-08dbdfe87fd6
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:23:07.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/VhzVlinMH3mXWSZBYNMWpDMntrIla+nhNV05uiW5eovdoukoexRhIGB5AG8BF8bWm2vPL8s2ISRb8BiKIcHZxih4Dd+HEukM5ndSPHnVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070192
X-Proofpoint-ORIG-GUID: JVpdLMC8mrAG9Ya5YWdYjaOycNaFJHpv
X-Proofpoint-GUID: JVpdLMC8mrAG9Ya5YWdYjaOycNaFJHpv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue,  7 Nov 2023 13:56:49 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> This reverts commit 089c02ae2771a14af2928c59c56abfb9b885a8d7.
>
> I rather not revert this.
>
> If user space can decided between various version of preemption, then the
> trace should reflect that. At least state what the preemption model was when
> a trace started, or currently is.
>
Oh absolutely. As I mention in the cover at least these three patches
would be back:

       089c02ae2771 ("ftrace: Use preemption model accessors for trace header printout")
       cfe43f478b79 ("preempt/dynamic: Introduce preemption model accessors")
       5693fa74f98a ("kcsan: Use preemption model accessors")

The intent was (which I didn't do for the RFC), to do the reverts as cleanly
as possible, do the changes for the series and then bring these patches back
with appropriate modifications.

> That is, the model may not be "static" per boot. Anyway, the real change here should be:

Yeah, I intended to do something like that.

Or would you prefer these not be reverted (and reapplied) at all -- just fixed
as you describe here?

> Then this way we can decided to make it runtime dynamic, we don't need to
> fiddle with the tracing code again.

Yeah, that makes sense.

--
ankur
