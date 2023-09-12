Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6C79D547
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbjILPtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjILPti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:49:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9756010E9;
        Tue, 12 Sep 2023 08:49:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9na3r006478;
        Tue, 12 Sep 2023 15:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=hrOJQdC438lP0bCNXYTe/SkFNQDZmqkDBtWOJ0Ceu08=;
 b=d5Rg0wxxAuCh5aTj177B315YJ0PzpDDd/I8Cm4+RBkj00FjG2hYhOI60sPfKkrlvo15S
 hv/cK9bWXn5+ks2ZELilwKwkCdGhjCxT5QoLDrvkLEIZTKWMD5yZuu8Hu78KwO0wcumR
 V/nyC2JyUGIHRCNzIrks0773Bya3AN4ce3SSAaPao4l0qJLgKhzi0q9BZHs6xMLdcnFK
 b9BqmzOcA1OyWIe5j7qtSxbxJdSnjL/x/cqbhDwuIvF0XI5ZLHhO/Rp9sOp3Jx+jipFY
 7g71XqRM9IaVoTR7Jh2wF0ZSTFTG460+UtqYO3KIgDjBuqx1TuyQHM1L5C6t05zXAXTH 9g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jwqv9sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 15:49:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CFetSY007564;
        Tue, 12 Sep 2023 15:49:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f55y56x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 15:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b93ddmhqf2gPym+7etrXkgoyhlZgs4cusp3YJIuUNo4Zf7aT90Gs+PRouEoJkORFGCTqmx6LuiE2R6XygicpGq7z5oNtyCsWJEBj0lMRYSBjxtM5f64pAUAyVdkoaMo2QPNT4UM8nmVQeAfTVIQip+XIfQOsYBX/dcYOT7AK0zq5cxSirotCMihF/smY4dsX8LDX8cPGwjQaCvoH1Z/REwlrtDNbAMFUUMs5m8aOs9vXvAE9lhxQzsgikNxzH7HqvJsPIk2OFh5U0K+N/CvIEdvFQsh0E4x1mb9j0gl/50GBf/gvXTmiGdvDSy/E7OfNM4gBAHSjanZaYIXJFKoKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrOJQdC438lP0bCNXYTe/SkFNQDZmqkDBtWOJ0Ceu08=;
 b=O4JxLjLpC09HUMlAfA5dTQ/mOjijn1Bs2PdiiIF1srpwZNBy+6CMLnCapK13p0XHlOZ5s/QYF/wh5kxEEpNBnHPhlW24mAJUySBq0qDsQSsW7oeQMMYbx5A6Dq2CIYTItfIyqZ2UdH7BUa7MMysSmBWktmJu+FHH9lDmvU4mWt1+0DmowktFH+6T9c7chMdaDc+ALeddAyFnf0UNA+eVFEvF0tk56bgq4FxJ9MvhUlQDscv1esLll1EDQHK2PWUCr8n9Q7lxQ1TQypCgRjJXqeE+TLgFbZPRKbqvcjF292jSKjrsv6FPZV9czjksgzZsf5POnlxjw98d7qaW4reBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrOJQdC438lP0bCNXYTe/SkFNQDZmqkDBtWOJ0Ceu08=;
 b=jrhYwqGdeMyoqH8U4apaqJlIMdNmtzkXjk6RYRbnmRo5WtmFcWaHcN3vbbVervfTyKrUaWXnXM4fiFlaBBybmOZtjG8BGSN97UZWlESdl7+3Hwo8iQiPMlCd8iHd23SGE+2ZS4+8FBfHluYHYRJ30fD6HVZdal4Jz9VsydGXAfE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5599.namprd10.prod.outlook.com (2603:10b6:a03:3dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 15:49:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 15:49:11 +0000
Date:   Tue, 12 Sep 2023 11:49:09 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <20230912154909.o5qvq7hcsx5j5ksa@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
 <20230912135617.dnhyk4h5c555l2yg@revolver>
 <20230912142930.xdautl7cabb67nap@revolver>
 <3f2e6497-ac8d-4da0-b677-c8a3975b6189@paulmck-laptop>
 <93aadecb-3c9b-6b0a-9c8c-2cc46bdd3955@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <93aadecb-3c9b-6b0a-9c8c-2cc46bdd3955@csgroup.eu>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0212.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d2cc1a-07c0-4641-bb8a-08dbb3a7cef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NhdyqOud4WG66OadzZlSLE7TBTr/E+7NcES0sVCKJM97stgJM6H2BXmSZvx/JGbPQTn7+Uy0F2NqPgXe7mo4NftOBEJymMnAr752+v6t66+WAKA6mCarZaEAz9mlfY+zc4HmlrwEpbUPyjNosXOaLase9eRHAh5BqDGG4Oxq7goiqxGduFRIiNdidmgmxSlq5nNrnB2HxgQGAvnoe2DUWwEzcowRKxY55N4LKROjp46wj43/WctG8Fb1woRB5fxj+VvKxm8VGnbVsWflgyIrV8lD3VyDojXgh9ZVt1bahnEA0CwRL710lWGHRo2aBYp/y5Q2b2Q2xXMKedMfCi+BXuRlKLVyY44WzUPIs2CudgeOy7u28LCNjzAiRDZJ9AEA048LoY4QQjG/ajmJhOttbjfqLjfusr6CSlySN2wsnR4VYywAMC46ci5gOoM44tCU2sj8kNYBlC1ywVrtwVXvafsVClASW1qavkEyimrGrYqtXj+1Y6nYzrCerDNvzP8v0J7xf94RJ62wnk8vNUulj7q5uAsxl8uwdourtU44ytudU4TbzGYZs7pwkno6BPZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(366004)(39860400002)(346002)(186009)(451199024)(1800799009)(26005)(1076003)(2906002)(6506007)(53546011)(9686003)(83380400001)(6512007)(7416002)(6486002)(66574015)(38100700002)(33716001)(478600001)(86362001)(5660300002)(8676002)(4326008)(8936002)(66946007)(66476007)(316002)(6916009)(66556008)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0NrY0I1NFJLNzhtazVaRGlxZGo5YXgwVmpNVmZUc3UyMGdZYVZoa1JLbXFR?=
 =?utf-8?B?RnNTZFVrWnJadzUwUkYvbkkwS1d3VjhrTEFpamYrTzVHUUJCM0VyNXJwS2tr?=
 =?utf-8?B?UjNObVR0dHFROXphMEp5WW8zUGM1Y3pCenI4N3dZelkyODZxVDZGeExJNGdV?=
 =?utf-8?B?cDJyUGs4RVIyUU9LVHl6anZSNEJad1lvVkdhV0xodXUyUnpNMmtXYklSU0I2?=
 =?utf-8?B?MFp1UHlXVGEycHU1NWdQRGR0OUw1bjVabmVKNDFUNTREalJiNFBUR3ZzR0Ji?=
 =?utf-8?B?bkYxRkI2dU1hUjdZKzU4WnByNVFoVStHendFdTlBMDUrU05wVnBwWG5mNXdN?=
 =?utf-8?B?TFAxK0RQQVhlLzhsckV4VDFyZmI3TXZHYnNPUnZyZ3cvL3BCb2hCVTlxWVp4?=
 =?utf-8?B?aGtGdUpMLzFpSG9kdjJ3ajlHUlVxYWE4TFdrWnRBQmo0Y0g5d1ZQYXZUZTZv?=
 =?utf-8?B?RkNKcVk1VHFiOE1RbzBEZUVLNHc5bXlveG9aSWsxVHB0bjZmb2ZhTnpqUXpz?=
 =?utf-8?B?UEtyc28xa0txemswN0s4b1F6Q0R6eUl2VlJQcVFFbHJWU21wYTNnNkhxZkJL?=
 =?utf-8?B?Nit6YmE0blJ1ajhDY0VuQWYxajh0ZzNPdzZST3VoNm4rS2p3emorN1J3MzdU?=
 =?utf-8?B?dmVGN29KOWk4cEQ3UThXUDJMZVBvWGRqYzJGZSswVzhibHdhd2JCcWZqZjlE?=
 =?utf-8?B?aVAvd1VRRkxVNXJvWG9WTHNhbE8zYTFzVUVGck93UGJqVHc0akZHbzdlTTI1?=
 =?utf-8?B?eTRZUUlpNUdnOUcxbGVDTDNXMnYweFgvMlIwRFlxRHRGemNVdU8rU2tLbWZv?=
 =?utf-8?B?TE4yQ2VLZS94Y0VIcUo5SUd2dVg3MERvdnJPTmZhR1o4UElwTFN2YTZVdmxv?=
 =?utf-8?B?RHBNUCtQbDRMU25ZZ0tjdnQyYjZ2ZmFDUWoyOEJwait4cE5oeE1LNllpVzhB?=
 =?utf-8?B?U2ZSUUFmbi9kNzlqenVrckZUV0F4SGlHY3dJc2crdkFGYjFjcG9EVUNZVDZ4?=
 =?utf-8?B?bmVGZVpUSEROR2wxOTkxYWJkUVBaZ2hVdkRiaVlJTDFZcTNEZHdQRTdvU05K?=
 =?utf-8?B?a04yclJBUWJLVjhkcXJGaHJzS2hBeElXYUlKMHZQbVNQQVFETWlibXRrMVhL?=
 =?utf-8?B?RUg0RWh5VWo0Z1VFQmtnQlNnRDcySHFKQTNYQ1RnTSt0NEl4MC9rNWNEVlFR?=
 =?utf-8?B?SGRFUGpzOXQrK2Q0UVNXVUFlaTltbHA3ODEvRVJ2dmZXVGN2YldwcmJKdUJ6?=
 =?utf-8?B?Wmd3Ynh5N3Avckc4VDlJUkZ3REpiQXVwcTY4VWFDUUhpcHlEbFcvSmNkcWdu?=
 =?utf-8?B?Slp1ZEtBdTFaamFxbG45UzFGR2p2NlVUKzBlVG53U2JKTHJsdERFVm45YkF1?=
 =?utf-8?B?N2pZa1RFdXB1Tmp6UU5vbXZ6RVdjTlI1cEhsYmoxeTc0M0IvUmx2R0J5OVR3?=
 =?utf-8?B?Sm9aKzlyTWJaVzNCUzAyajBTVGxKcUV3M2tjZE9Qdm4vODI2MmsxeUdhOXZh?=
 =?utf-8?B?QjdpKzU5WGF3Z3BSMldRRUNvZTk0VThlOE9MR0VETDNQSzFvUXY1MXMreW9h?=
 =?utf-8?B?cGpPdWZEaDlzRHhPMy9rM3BaWWVFOEEvMm51ait4S2RkVHBSTmxseVhzZGs4?=
 =?utf-8?B?NmtFN2RES25RbklBY1A5ZjJUNWRmUi9PbS9nSi93ZERiWkZ2SHF6UzJYZFNY?=
 =?utf-8?B?eENjTjJXQStieEJUdE5FcytjcTd2QXZvQTFlQmY5czVYbWE1NzhEWUFOL3lo?=
 =?utf-8?B?aGtHR3FnWlJiZGw5ZEFMamgxc0RSMGN0Tlg0azNSK1U5dkJPN3l4YVlaeDdm?=
 =?utf-8?B?V2Qyd1VuS2pNZGZrbFdFcUJ5T2ZtQzR4bm9tYzdjZnRSRlA2cVo5VjJJMzNv?=
 =?utf-8?B?NGh4L3NDOVVHRVlJeksvL1MxdGVzdk9NSk9TS29RRlRkRWU2d1B5MXJLM0RR?=
 =?utf-8?B?SGJRQTBJTFR1NlFmNWcxUHBaVERhcmVha1IycW9ZRTVYbk5BNUtxOXcvSnBV?=
 =?utf-8?B?M0ZwWnBYYXdpV1NSdkNnbTQvdzVJZUtsaFpzOHRmL0RuV2VQcVUzaXVVTFBj?=
 =?utf-8?B?STBxWWtsbGdHWWVJY2txelVhTVdPWGYvS3pTU1dBMTBHbXdCQXl1cUp0NzF6?=
 =?utf-8?B?Z2I5VVRDWm0rdVhOa0xmMlhPbEp1WUVPdGNYVEhPOHdnSVN4WmI3ZzkyY1FZ?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a1VHeXpkQTA3TkptRHlsZVpldGZOV3lVRWJ4Tm5RcjBXQkVRUWNMMHl3N2Ju?=
 =?utf-8?B?ZjRYSTJjZUV5OHBPajFOUGU5WlBHSTViVjMyNXJBZ09PL3ZmZmNzZDVjekZB?=
 =?utf-8?B?SjRUN1I4Q0JWZ0VuZGVwdFhJUmxyM3hEQ0VubENiYTE3QUNQRForNmpKbno5?=
 =?utf-8?B?b0svY0FyVElscElqdnhFWFpzNno1L0hBV0pHSjh1dmRPbml4OXI0NFVlREhK?=
 =?utf-8?B?N2VaeGhwaFFXYU1VQndLUGtYZjNmTjNKRXc0aVUyT2JVVDR0M1RydlVSb2Ft?=
 =?utf-8?B?REdyNzcvSGpPdGp4d3NHazBYNFJyKy8rNUhVSk5NU2VJTFpGd0xlcnVwUk1O?=
 =?utf-8?B?clRrdHBmc20wVVlLY2h5bjNnMGRGbWhQaGovK3lKTUVmZGJRcVRsd2U3cTE2?=
 =?utf-8?B?bTJrVlhaQWcrenNpMmNFZ3lxYXJ0V2ZkamVPUHdOYmcvaDE2clhqT0lyNHIr?=
 =?utf-8?B?S25Tc3pRY3l1MHVoWjZmd0VEVkNDUWlUUDVCTmNBQkkrTG56dFVtUWdBd1Ru?=
 =?utf-8?B?djh3TlZkSG5MSFpJZVBDcmpIRkw4dlZnWGN3b3lYcllRbytjeU5sUGVHZEx3?=
 =?utf-8?B?bXJ1N3FIZGY4b0REelpuVHVsdm5QM0Vic2tLT1Q0WmJSMjY4cVZHcEhCM0Ry?=
 =?utf-8?B?ZmNpZW5nZ2RNUTFoVXl5WEdJbHRheXJ3M2tzWnhucG5LVnNhallJbWpPNEY0?=
 =?utf-8?B?aTVVbk1CT0pzQU52NitTcEhjNENmZnFUTnV3K2w5K3d4YytWMVRkTmp5NGRL?=
 =?utf-8?B?MDdWMk9nL1BFZjlvOTIvYklET0pGK3JnOTlITDQyMGpHcFdtREpjRkprWGZB?=
 =?utf-8?B?aUFnOEVibkJTeHRyd1NlOURLSzM3R1lzVE5mUFhrTGE3VHE1MWtCZjBLSVhZ?=
 =?utf-8?B?MkkvRFlxb0d4eS9zUTNQUjV6cGFCTU9NdVEzcFpaaUpud083aXZ3YTh4Y05X?=
 =?utf-8?B?VWh2Ump6UG15bGFNQ3h3K0tCNTczUGFUWUF3aWdiSjluZzF1UjgrYXdEdmZn?=
 =?utf-8?B?dWEzNDRSZFlrWURhQkhKYWhYemwvcFVMVCtIMC8yRGVrOUM4Z0ErZWw0cXgz?=
 =?utf-8?B?WjZlV3lJVUtSNWdTWXdYamFmMFlnTzZPdFAzbFpvSlBHMCs0STljcDRWYndm?=
 =?utf-8?B?MlcvVXo3VjVOZm1RNHJwVnAxcVlFNExhVjZHaHdvR2l4eDZMcVJLMkVZejVV?=
 =?utf-8?B?c3A2STBJL05LVXFsdVhqMndyWldPa1Nnb3VpTUZLQUNveHpLRGhVOXBpcktj?=
 =?utf-8?B?bk11ajhZNXR3UEsrODdxVVFvODFvVUFXSzM2V3g2MS9zb3JFSHlOYTVINXVm?=
 =?utf-8?B?ckI0R0FkaGJQK0NsN2kvd1I2TlFhZ2Uzd3pFdk5ZWnR0R2luUi9WNkhHQjBv?=
 =?utf-8?B?M2M4bW1aOGVCV2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d2cc1a-07c0-4641-bb8a-08dbb3a7cef0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:49:11.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GLZ5ZMeS1moI24E8t/1j/v0B0K0rylmVF3/5ktacXJJJIb1wCAcWdttVrvSZ3g5/s3uew6jAL0rb9kX9VAPzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=662 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120131
X-Proofpoint-ORIG-GUID: uRJVHhmNAlASUnCBZ66Ir7PRXN-ws-jI
X-Proofpoint-GUID: uRJVHhmNAlASUnCBZ66Ir7PRXN-ws-jI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christophe Leroy <christophe.leroy@csgroup.eu> [230912 11:27]:
>=20
>=20
> Le 12/09/2023 =C3=A0 17:08, Paul E. McKenney a =C3=A9crit=C2=A0:
> > On Tue, Sep 12, 2023 at 10:29:30AM -0400, Liam R. Howlett wrote:
> >> * Liam R. Howlett <Liam.Howlett@Oracle.com> [230912 09:56]:
> >>> * Paul E. McKenney <paulmck@kernel.org> [230912 06:00]:
> >>>> On Tue, Sep 12, 2023 at 10:34:44AM +0200, Geert Uytterhoeven wrote:
> >>>>> Hi Paul,
> >>>>>
> >>>>> On Tue, Sep 12, 2023 at 10:30=E2=80=AFAM Paul E. McKenney <paulmck@=
kernel.org> wrote:
> >>>>>> On Tue, Sep 12, 2023 at 10:23:37AM +0200, Geert Uytterhoeven wrote=
:
> >>>>>>> On Tue, Sep 12, 2023 at 10:14=E2=80=AFAM Paul E. McKenney <paulmc=
k@kernel.org> wrote:
> >>>>>>>> On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote:
> >>>>>>>>> * Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> >>>>>>>>>> On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett wrot=
e:
> >>>>>>>>>>> * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> >>>>>>>>>>>> On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howlett wr=
ote:
> >>>>>>>>>>>>> (Adding Paul & Shanker to Cc list.. please see below for wh=
y)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Apologies on the late response, I was away and have been st=
ruggling to
> >>>>>>>>>>>>> get a working PPC32 test environment.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:42]:
> >>>>>>>>>>>>>>      Hi Liam,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> >>>>>>>>>>>>>>> The current implementation of append may cause duplicate =
data and/or
> >>>>>>>>>>>>>>> incorrect ranges to be returned to a reader during an upd=
ate.  Although
> >>>>>>>>>>>>>>> this has not been reported or seen, disable the append wr=
ite operation
> >>>>>>>>>>>>>>> while the tree is in rcu mode out of an abundance of caut=
ion.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> ...
> >>>>>>>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> ...
> >>>>>>>>>
> >>>>>>>>>>>>>> RCU-related configs:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>      $ grep RCU .config
> >>>>>>>>>>>>>>      # RCU Subsystem
> >>>>>>>>>>>>>>      CONFIG_TINY_RCU=3Dy
> >>>>>>>>
> >>>>>>>> I must have been asleep last time I looked at this.  I was looki=
ng at
> >>>>>>>> Tree RCU.  Please accept my apologies for my lapse.  :-/
> >>>>>>>>
> >>>>>>>> However, Tiny RCU's call_rcu() also avoids enabling IRQs, so I w=
ould
> >>>>>>>> have said the same thing, albeit after looking at a lot less RCU=
 code.
> >>>>>>>>
> >>>>>>>> TL;DR:
> >>>>>>>>
> >>>>>>>> 1.      Try making the __setup_irq() function's call to mutex_lo=
ck()
> >>>>>>>>          instead be as follows:
> >>>>>>>>
> >>>>>>>>          if (!mutex_trylock(&desc->request_mutex))
> >>>>>>>>                  mutex_lock(&desc->request_mutex);
> >>>>>>>>
> >>>>>>>>          This might fail if __setup_irq() has other dependencies=
 on a
> >>>>>>>>          fully operational scheduler.
> >>
> >> This changes where the interrupts become enabled, but doesn't stop it
> >> from happening.  It still throws a WARN after init_IRQ(). I suspect it
> >> is not the way to proceed as there are probably many places that will
> >> need to be changed in both common and arch specific code.  As soon as
> >> TIF_NEED_RESCHED is set, then all the checks will need to be altered.
> >=20
> > Thank you for trying it!
> >=20
> >> I think we either need to set the boot thread to !idle, avoid call_rcu=
()
> >> to set TIF_NEED_RESCHED (how was this working before?  Do we need rcu
> >> for the IRQs?), or alter the boot order (note this is NOT arch or
> >> platform code here).
> >>
> >> I don't like any of these.  I'd like another option, please?
> >=20
> > My favorite is to move the interrupt enabling later, but Michael Ellerm=
an
> > would know better than would I about the feasibility of this.
> >=20
>=20
> I digged into it a bit more, looks like IRQs get enabled by the call to=20
> cond_resched() in the loop in vm_area_alloc_pages(), which is called=20
> from powerpc's init_IRQ() fonction when allocating IRQ stacks.

This is another location where the process will enable IRQs because
TIF_NEED_RESCHED was set.

>=20
> And IRQ stacks definitely need to be enabled before IRQs get enabled, so=
=20
> there's something wrong here isn't it ?

