Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A647E4B63
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjKGWDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbjKGWCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:02:39 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C1E2D7F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:17 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJwFt020749;
        Tue, 7 Nov 2023 21:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=z22EkTdon0g5V3YJu1mEM8J/zKtqGRodk90GYRkYj74=;
 b=FFdpB0S6nziF8tQe76iwBOZK4El65rDLvoxjoi1SXSrVhG9FGVR28bTCIRQHlYrwmmld
 M9cj3TVVtyqmDI0ARowRxeIZDBMF4Vd/+1Z4mVsM9fLx/YmZUmNzql5LokAhT6sm1dMh
 jco00G0nuIwFR99VUW15YTrgy2ngjzgTgCNVQ4TL0s9bkdRyW6Z83txg6Tnlpo6/oWdG
 a7jnVgIAVR5+m4jOECNx0iGiBD4N+O2WRWoRyHPCBCP0GNeF639UsQOBdnOaazFstTnK
 /oi/4MAHwx5YTDLyhi50kifTtluoi+FfW46sNk2gZQsJfcNFkXH7Kzvc64B2ZSS6JjPJ jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2202re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJBP4031966;
        Tue, 7 Nov 2023 21:59:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w221gj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNLoeAVD2DRi8zixoPMAspdcYkZbB1ZTfcahWbvA2HI8AdVD7pXr+jRzrDPq756N6UCdYZMGA+BvGNPvHmza0eqGS4IPFrZsKEfancsgV9zyx7/0Dx64ynYpZG/KITxKdBdFjHL20Obp3BZZX1tpm0MkXLT4sv5ZC4ayH1xbl7VksG2sS1nHSQD49an5NU/ZyIspsWrs2FagtvKiFejxwaSyjF+brGlAs+JsHdISlFW0yPxNyiaZT3VdobuYPj4fQMBIIsuVeISLOiuYo+OkfvG3pDhcxBfDprtTs5ZtBb5E68dj7l7GLalPUxpd2zkUT+UvKcefz9uxCbFOgwRTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z22EkTdon0g5V3YJu1mEM8J/zKtqGRodk90GYRkYj74=;
 b=PWCHsjs9IV//z9R1TCYNO9LKx+AiL4gD3dSJGbmk8F+xmyVamQI6ITkxTckGrKUhjX2AqheeiyEG3857arq12Nx8LE5zhsngb63OsdKR36h6T+29/VFRfhEdBbXRBG8fUq/9GqyyOVO97/mSFpvDIpBnru2OOIo5oMo4/v7WdRCAbEdLExObGRT5mT0qcbWJFVEjfKYxg3Hh/YZFY6D2/8q854fLuFqFntdHp5eTnR+zh2QAlRNEVm/twRtIc2lcwu+cLAZn3e+nJ/iEWVWDTBWKzJyD9u/lwxQuCcCVegzvmJps3ICua3fyurl8h+b9ciyKWp7dTEVHvX3/ntXWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z22EkTdon0g5V3YJu1mEM8J/zKtqGRodk90GYRkYj74=;
 b=RVXNSbW3oIB+lf1IakqO8y6twnZYRo0WnbcRmZa395DF+E4A7mP1Ek0xnnti/LFX8JV3pcqqXpks6uQVuaOFyxs9p6EvmAuKTA593wgp6tUkLeg316jiITT21aIoO4MwmU4VjhEWCefYpU1kWls15LFv5b4nsyd3fSmAR8AYgGk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:18 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:18 +0000
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
Subject: [RFC PATCH 31/86] x86/thread_info: add TIF_NEED_RESCHED_LAZY
Date:   Tue,  7 Nov 2023 13:57:17 -0800
Message-Id: <20231107215742.363031-32-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9172bb3b-b07d-4c9b-2fee-08dbdfdcca1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZT4IyBBIRtlcFMjE1DQC7VjQ8JISx6OcW35KM5S7HNeXRPzZHDxd2yZWPsEj7CqmdquxlplCVezFprhfKFClm0T3PUu56CJp1WO1UQAqLlaiyfyAgdG5b4HbgGIvo02lUNCIzHR12REDimKgTuBnHOqmqf3mgZOm7fIUJJqIyoA6A85+dDpw+ukUgCdj82fUnsQmxT4ZpZOIRi+O0gWuorCsrkw/HTuj73+AN1Rod80RQbFmfwvTw3+QkSZt69hUo1T8djZIq01pRL9u/H3OEZM7dGR6UAwYNJ7a2Vn7186pB6edxiIQcQyFBTrxQc8ic2uSWl6dz1txE93wgis2/wVXuK4Z+eO4Prd10x7fJ1/5828+YGVqODxwdFkRGgwiuixtjpW3FqW38gs32jkzq/4AWtnd9dSMIyEI336menHV6EzPxlP5zBiTK8Cg0BSq0TL23KcbciHqN5RhOPdv3xI8p2c09G2qu4HjIwLpk4fokTbvA6bx1OZOHYNvPaeI3DTYAP0/32dxjal3dL2mQNrna6E80JzQFj2BHeIVa6/NOKygcVs/MIkIlej7k2FQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rorD45yJTGB2LgLsaIkU0wzocT5YjWLScW2k1IA+GfvQafO2DmIqotiRfXIl?=
 =?us-ascii?Q?oTweAW/EVzrUffr3VZJEG0wmV0d9jQIp+ID1AAyt47tcdPmCQ4m57Go05Uz5?=
 =?us-ascii?Q?OaNluMqf63ooWjcis8LZ/3R1BsXIPvpnmqSmPG7Pt2aYSGib6B70UV88f3yI?=
 =?us-ascii?Q?xQQj23WcQOMX3DdxJxcc5Sm0fSgsTX7Az1r7UhihswH7W3Z+8l1ShFsnuw7a?=
 =?us-ascii?Q?fUW8JboPC4Cw3YFBXFwKbN6zRkUEbf/rc8+UgSqzimP+QJj7mMxXAiOrMTrK?=
 =?us-ascii?Q?vCTFhyjnI6AHMXu9oRMy1QsEjv0iMmvOhdc1Oj2vYcclXYQ3uIjXQ4TE/6aa?=
 =?us-ascii?Q?BMJnMRn6BbQMtVcqDihiJG5gCHGBcvWz/17+yBI7NZrKiq2L3WnxGxlB9oAG?=
 =?us-ascii?Q?TgBeNyCj+FiuGJgaYaIbHtOp+HBjTpEpj6NflBo1yr+MpkaXSipsJf7jo1SI?=
 =?us-ascii?Q?uIpwkeysYRmilRk2rfPAt05HWxpubNIMbqloDzk+/pNsrrkjcTIweaAknX23?=
 =?us-ascii?Q?hpIGmbKApiCGajQbWm++yTtBluNLARKS9f/GkjtGxdn5MMFymUJL45SbNiYR?=
 =?us-ascii?Q?UlzgE+qQf9RtyjNN/alDgjlTVGXetIIjEGW5bjbcuydbOkHR3cm3gRtTzFMt?=
 =?us-ascii?Q?So9487GIDic8feOGaqoxJ3pzbWFeo5Z7/5h7Ew+EfeN7Yb6m8rKqN4o3H8Ad?=
 =?us-ascii?Q?sriOIgeg6rn7iErFi0xhJb/QqCc3BvFTvyctRUBC8e68NQ09jh2xOdCznJaP?=
 =?us-ascii?Q?mrnd/p2a7j7EYP2tlzEag1q2/wwlShrr9DVVt4lgBmOLulllrd3uFBjYw3Tb?=
 =?us-ascii?Q?AMK+cV7PpZkZnWp93hyQ7LmVdhA28xzzDTfLFba6w6cRwhpCpiw6FR4gTIW8?=
 =?us-ascii?Q?Fp2Lcs70JdXnR0xKs6J8jOmTuE/elj0wdLA9LvsETGUAGCpOk10PcTZP7OFQ?=
 =?us-ascii?Q?yvwETXef+cMMdC3kY6zj4LNtkrpK6X2RBoECiug2BPEm77jbMllyW2jZ4uP4?=
 =?us-ascii?Q?PtHjqEs95++QTTSkeHZ5zXmJzJru11oKog26JNmDdDSncsjkmu5C57o3ABTS?=
 =?us-ascii?Q?KRYxJiZnxRUravKjUgqQCAvjnP82ii8k0oU1APqWd8Rj4QNSEDZBLEcQBBrm?=
 =?us-ascii?Q?oRJSp1PcsQRpWCOUm75QAYt/2lzoBiJKmw5R4tYDQk+rAq/7tcsxwHMppmy1?=
 =?us-ascii?Q?Viitk/SjkCKW2I/G2J4hHfad3ahgW+gbrA733P2PKQYc13O0DvqKjuV+CMjp?=
 =?us-ascii?Q?AHYHIYtEiTHENGu9Snd35U2AtnDjdgklKg1HXeNlxQZQoVxIQweeRm+laGOz?=
 =?us-ascii?Q?s9njSn/Q6UG2PLFoLCbirsRf+epjw6IXgLQb9/6nTcmN6wFJYmBfndLKwDGZ?=
 =?us-ascii?Q?jDAEcHztDOBeFeLpJtBh2HCdMps8Yi85qwaNtP5Ez3/RATNWVOEkRVNFVCOY?=
 =?us-ascii?Q?shxz9G+OoFf/bNMn7ILdEU4JzWNShMOP8sTvLf/IbFKsm9ajDVMlhS5bDz5G?=
 =?us-ascii?Q?72NNH0KYwdyqxOQbes1DAfrgLC1CeSDS5GAXocZY8MB61VAgvrGnDfuibR5S?=
 =?us-ascii?Q?y6nHBXyamCG4UyY7tiMGkSeTksyGlGJQoka0uJq9uf4Z8wu7+7cYUjzLTBFo?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iShYkeQcpbsU4cN0K+NpaV3b5t5yob3awZq8cTJdE2jCnPxVCUEdVE2ZcazU?=
 =?us-ascii?Q?z1L4XUvEVs1czWyrtGtxo44YAGZO2sg7vhOcqMoSm9EvQfV3DM5TqODyLEmm?=
 =?us-ascii?Q?dp7QOheD9EuMlWBGVjhXHd9j7YxYL7E65tL6EeDiJnW99EoShL8Hzosnng4s?=
 =?us-ascii?Q?IqTrmGy9GIxx8haUmk3r/mnKGHkfeypJdKv+Ymxml9BOCglQUd8Zjlgcm2qm?=
 =?us-ascii?Q?MEYgA5lXHI2ARaGktRCw5cNOZah66p2Tjm9t/Ite5/qOaJBX9fcwDsM/uuWt?=
 =?us-ascii?Q?uJE4KDRU16sKlbE38UXq/oqX6cRfUO3CUz+3B0BqhpfY7cN3pEcUbQpzmR9e?=
 =?us-ascii?Q?NII+H/Z18lGHsIPZ0FCuJoCFxPI9ehxNgoG2d1B0VAorPwfdip/CWWdrWFru?=
 =?us-ascii?Q?cFPf6HkanLE9NCjxTfS2rnM7gvAfnSzlas39Q3T4GbYXqsV0LeQn1ZrTyVky?=
 =?us-ascii?Q?eZowJDT01HxqbTp+w4AQNZUdyys+YZWP0uLfJ1YiHHWIPQwbTTrOQb1PvAcZ?=
 =?us-ascii?Q?utmqrQty3CAmRKlHtFkodiHn5W6NGNxjEOLpKf9uMf8JmLX5j4hAna0D5gLB?=
 =?us-ascii?Q?19rVXZcYYK2VMyv6NWULxD7wlelFtR9QdMH4vKrlCTidkPbCyc09CG3xsJOg?=
 =?us-ascii?Q?F716lgJ3S37XEbJEMRdePb9GhPje6UACYbbLoHMudMc8ijPrKvAAp2b1nGG/?=
 =?us-ascii?Q?JPjLPsfYMBgdUvsWtbbDBOyMuX6WTqSxqilo2X6efVXAuvou362A8h3pOasT?=
 =?us-ascii?Q?+Firo3RyhM8WHfegSDS/2IByY0OqclUkfrUMA29NCZjJ4qI9jkVyit1/3fZV?=
 =?us-ascii?Q?AyA3uRjuRRmrWT0PPx0CT/4NHEmPU/uC2O8TINWqRRZku2ZZtVD1We1Xtorp?=
 =?us-ascii?Q?wYnWczi9CPSk6JGcgkbOTtYSk0woKMR9LYYMyg6/PFZwzA6ofm80UDIfzNOV?=
 =?us-ascii?Q?bOT/EtYrbxNVP1qxs1QOpabstRn08GyRTMm5A/WkB3DOUqXWKM7tMBNYtAp8?=
 =?us-ascii?Q?HqL3UZlV3EtDm272FOvBV2uBPcODRU7w53PPQeoFxsRKF2m62YKrwpXLbs6r?=
 =?us-ascii?Q?VCZkzKTHaK4aGxDy8lXPHcWenrpgEHDzJDNpsqt7B+C6KOkiMJ6b8qSIutKt?=
 =?us-ascii?Q?RsPw2XHBjtMkNVwGXq7Rtutym17Wr3BiA/GQ7tL0nz+lJ2w1vY8oXzXAoatK?=
 =?us-ascii?Q?ztSNOuspIB84vb6DqMLGQhiPrbTxrZi1/nPTGCvPXtq7IY05savOduc5qUnS?=
 =?us-ascii?Q?L855AnXTReFxcTMl/HUTRPHzoF3DFo8RBLhgo53/u9WHSUWXTyhT2hhwv914?=
 =?us-ascii?Q?PXrhvH2FsQr7EcRuE+Kg05D8qqA95vOagvmZBw1GrDlqAOsVNRdbmWu7/Lln?=
 =?us-ascii?Q?EOaKj/wZXsXHU2ClaByMiM7QaZiGT27vO7yGhz7+Dh4W1xaF8NALG9zBDBtd?=
 =?us-ascii?Q?HuAU3vQLEylIc9IZpMieOGKA2jmwf5U9SwftYNUiYohljwMOIHG12gtkR6nE?=
 =?us-ascii?Q?f2Isp29AQwqrANypTT5PkJNGFLw+Q4xuuy7BhpFoDZonc5SMt+jpgKeTnQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9172bb3b-b07d-4c9b-2fee-08dbdfdcca1c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:18.1078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3EirQ0RilBqA3JT42anADPP34gCqYyCJrlp9iBcpzag3bliSpduFzqc5MR1LU45C5cvQuU8iBW1fw917X7EDGUuu8enAs5XEukK9LMmoL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=831 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: fyAO-9DTqy6A0oC-6bMXHmkUqVJJ89UK
X-Proofpoint-ORIG-GUID: fyAO-9DTqy6A0oC-6bMXHmkUqVJJ89UK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new flag, TIF_NEED_RESCHED_LAZY which with TIF_NEED_RESCHED
gives the scheduler two levels of rescheduling priority:
TIF_NEED_RESCHED means that rescheduling happens at the next
opportunity; TIF_NEED_RESCHED_LAZY is used to note that a
reschedule is needed but does not impose any other constraints
on the scheduler.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/thread_info.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d63b02940747..114d12120051 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -81,8 +81,9 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
-#define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling */
+#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
+#define TIF_SSBD		6	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -104,6 +105,7 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-- 
2.31.1

