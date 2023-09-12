Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF37379D2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjILN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjILN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:56:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4210CE;
        Tue, 12 Sep 2023 06:56:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9nJC4021454;
        Tue, 12 Sep 2023 13:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=Hv25ZEtvfHsv+eW926U9fEX/JnAWXoYil4FcSLgeL9U=;
 b=oQJvstQvcIUfLsktSI8lgLoazzi31KV2qgWsScW9uGaxhvOlAc2OAE/YpthFFHW1LaXd
 gv+HOjuCJGGBQ44thx7H7rl930ZW1KNFi2mWbzwPQ456bkct1/KMY39/hPUqFzrNbbVR
 dgUW+xtLZeBA7j/1/8i2hFCKA44BINDm19wCR9iHjacpdK0YtQTWD6JlrIfgUsjfQ8Jy
 6fmD8PTHNWxlSnsZaz8Basy3dLAH69vsA75XPHDwHRjneHuK2/SDvG4j7h8PSJmEhGpy
 ttW39o6dm8lijNTkkXQhTiXeXp3io0gYp3ZUJnMJxE6Fb2FGZVqVGlYhfqXn54fBlaeV Nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1ju1v1nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:56:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CCOuvJ022991;
        Tue, 12 Sep 2023 13:56:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f561am3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:56:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDW0Nc0HuWKyxyR3BjBtYvp7EbNZk5OICfjFAwZNC2qxSoxWNgU5jOFSCPyXG6o73BCJKn/PDs1sx83KibSyY64w4G1pfDpmZvxxv060S+830qre2P4g+X3FoIWxIWFll9X0eODphBs6jKOWdo8XKkZ14lWfl9dv6MdojZkSRRRiClqgFSt5EcBHfbLMeeMGC1BgjsbNxIghYdOzjaIntQnURq89NPoeDoDY8aWMFo+2Q+9WtuP40qm3PD/xyVmTpeRobWyMroCcDArYnuv4E5sBiopaBkF/HxI+5QEY5SPyf2iQOoArWscwvRNcKnXPJmrEHdEgX00VMzro9Ut4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hv25ZEtvfHsv+eW926U9fEX/JnAWXoYil4FcSLgeL9U=;
 b=V3D3NhXD4gAL1KmB1CZcoOU9UVzN30Bd8lCIluG8OcfwcIkI3BNOyQ27iOUV6eB3+emwMPO3kaFTsGxqd/fQ8LozLharfajAXFgvwCNf9mzWxE2oT5uHKfz9/BZngTPrA9h4dsTuOItL+OqseSUH0f2m1K36bJm04WGG6vecGjKyQp3+WoXZoaJ5faJ1pI1LaesKmJTUXsrKLyVU3Trs6cCkUXQpjUF02hJ74Nt9Zi1HvFLRe8Q8uJV9HBuUPLJr7kSX0rNamIYbP+r0P4SQJE9S7VUNBsSAypYgIfBib2Hg/OtbYxNAVRcZWIUPa1zvSLRRpA3T9UHBA/eBHtVbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hv25ZEtvfHsv+eW926U9fEX/JnAWXoYil4FcSLgeL9U=;
 b=DiBLTkQcFD9fNh/dcDeWShsQV6MNKY1wwamSmvtUWi0uvgcUqJ1RIcod//13Tp9FBO/u8C8d1wfisFJcJNB/nh8RhIrq3BSLe/WGbY9lmYXwedr20lh6WvY816n6nx7ijod3GQ4nDG3l0PBuw/xvd7YJprAU8WEGkPcNIWKEhr4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6622.namprd10.prod.outlook.com (2603:10b6:510:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 13:56:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 13:56:20 +0000
Date:   Tue, 12 Sep 2023 09:56:17 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <20230912135617.dnhyk4h5c555l2yg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <20230906152325.dblzauybyoq5kd35@revolver>
 <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0494.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH8PR10MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: b12e53f7-099b-439f-b79f-08dbb3980ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWk5muan3QxNZrysgri/AIISThLmRxc2zMjhSrVvAeUguMQy6QCN050KWjy/twHVxzqYMtBbQAq53rauvrGfgEpFrRSBQueR6OiwtmDm5IlmzNOuX2vN7yo+GAlFh+7BW3lJSnIJBKHATeECBuvutNDZxdz1tWgqkyzf6dU+jBfYRWSwZmT/6lRP7B0Qu5S6tYQBs/KfujnkpdatspJLBfro026OS89BcG1urju4yZjIPmBZsSAG4HefDxyfzRaxORcqI8mA5Rl3yy5zOWTH0Z81NlruyJclckIYyPLCsxVyETP2JSSkdLgo0rKqjXJUzW73+thm0lnZFRrviw36D749GN+cIXgbGKj7pjESZtwM6nLYk2gy3X1EzK2Bd+/xx9ANEuI8xqJKn3i3ViYpL62Au8GL1W2550zYMvTAUQl64wGSOoGgtUFWC39VDXVxWI00sHdkf+Dkxh2GeL1jX0zgCKhr61j+10phaUrLLm7mKE7q3NFn54ejEIcewIBN2X6F4WEXF9dHibmfGkmA9jPTWYKDh4MWj7+AmnZNFy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199024)(1800799009)(186009)(41300700001)(53546011)(6666004)(6486002)(6506007)(9686003)(38100700002)(86362001)(478600001)(2906002)(6512007)(83380400001)(966005)(1076003)(8936002)(4326008)(316002)(5660300002)(8676002)(66946007)(66476007)(6916009)(26005)(54906003)(33716001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFIzUnMzRCtlMUpHc0RDTzNITWVOMFdIS2hlbXhNTlZla0ZycjF5djFIdllT?=
 =?utf-8?B?b0NLd0NndXhVaVhMSUdURFVIcFJneHQ4bXNWSHV5L0t0UnJlcVlpTnpENmxn?=
 =?utf-8?B?dXU0REhHOWVtR0R2WTVLOStHZ0QvSGhXMFgza0xzek9JdXRWN1RycTBwZFN4?=
 =?utf-8?B?SzlFQ0NuZzFUSU1udkNZdTlTczZyODlGakJWZGJPdmFoZFM2THV1WGtlaHRZ?=
 =?utf-8?B?bTZDRlVqbVVOajBjNWNlRGxVeUpTelEvYzAyQWlDOVQ4dW50U29jWGZkaFV2?=
 =?utf-8?B?R3U1eU9lckJVdjVhdVo5UDdwUENIQTdiYkE5YXAwbEhISHJQNTU3U1ZLT3hI?=
 =?utf-8?B?N09CTXJMZ25zSmMwVGhHMkZnNEVUdjNBY0tFL0JlRUQvbTJYT0JsSk1OMDFP?=
 =?utf-8?B?cVNQakFseThHaWtyQ25BTnZaeThDYmFMTGt5Zk1oa0svS3J3NndXTFprSkpJ?=
 =?utf-8?B?OGdTdm1xSjNFVTJRSytBbkpFMzE3a2dPUC8zWVByR3dNNUNyc2xTV25pMTRM?=
 =?utf-8?B?aVgybWxXalpHbDV6eGVITDV1cG5GdWd6QjQ0WW9FV1FjY0RVcFBvdWJxSHRt?=
 =?utf-8?B?Wm5SNlFpdm5pNHBsSmY1YmJFQzFVaW1JWXdJL1BsVGNKZ04xLzhtVVcvT0RG?=
 =?utf-8?B?OGlhZU9kQ05Gc0NNbXFKY1crN28wWU9GaTkzd2FDUXFpVERrZENaYitQeFJn?=
 =?utf-8?B?UVFqTTE1TFo2L2FTczJBbUJacjk0UlNGWEpUQVVnN3ozdHhha1NKUHNDaTF3?=
 =?utf-8?B?c2hjZGhtV0hPeTJ4Tk9yQkdhc1dBLyt6Q3ZRMnd1K1RwTjg0Qmh1MUh5RzhI?=
 =?utf-8?B?aWJaclc4a2hNWU9vL21Vd0pHM2ZoUUxuUkZEdWdCeS9lQkFGakhKb0JBYUho?=
 =?utf-8?B?SmFHN0lpd1BNYkJJRnlVQmFGT0xjRXlyUnBOaThmUkNXbG1JYi90czBmdzJi?=
 =?utf-8?B?a2pFQmY0bmkyN254dmdvUjlEeVMybG83dnZ2aElmQTBic2E4b3NtWTFMT0Qy?=
 =?utf-8?B?UzcybmZCa0ZDbXM5SFVNUEVNdU5ldTdnMXRDbldzV0tteEJobjU0WEdXUDRH?=
 =?utf-8?B?R3ZUdkI5c1c0ZUc2T1c0VFN1WjhEQTFTUWQyOHBkUTZpejl4RUJwLzRFMU9x?=
 =?utf-8?B?S1FGTmViMlUzU2RxbWkwK042SXoyV01XRWNIay9MeGRKRTc4UjMzY0VjcmV1?=
 =?utf-8?B?MWtlV2t0NDh2Q1k3UFZTU0VqdjdhSC9JMzBqNmpSK2c4Y3hCY2ZCNGNkcVF6?=
 =?utf-8?B?VXo3VmtWWjVCNmhTY3VzTURtd2t2djgvTU9YN2xGdGdjNmxkL3hBYXpGMzd2?=
 =?utf-8?B?bHBxejRPbmZkemE2bXNlTUMxeE9tN1RvM0VZb2ZlWUlNRVRxQnl1b3ZMQTlR?=
 =?utf-8?B?dVRrYms4KzFZblJHcDQ3eDR0MWhabVF5Uk5rQUFVaFI2ZUIyS0lDTUJCUUxr?=
 =?utf-8?B?N2xtekttcFRKUTczVTJpNWpCaXJFemZzMmNYcVZIRnY1UkhrQkcrNWxvZG01?=
 =?utf-8?B?S3g5Z00wN3pHSmU1QlBiTGRnUllVbHJWQ2loSUY4NUZUaDcvMXZsc2JuZUlH?=
 =?utf-8?B?bVRpMGFXbDF6VHdnaDNKMlhZVTV1bHhOL3ExSGZqRGtDMnpGSzE1emtXckZ1?=
 =?utf-8?B?U2RtSlh3cDZSNTlVQkRlM1VzYUZWT1FJeWthNTk0c1ppallPWWx6NDJsVDNM?=
 =?utf-8?B?ZGhqTmhIM0poS2hjTy9TVXhWWndETldYUU1yeTMzS2g0WjJualdVS0dFLy9i?=
 =?utf-8?B?ZEN1NTlxUVQ2TVdzTHNUb2plRGxUOU5NSDlIcGlucS9peGpMdGJ3dTJSRldy?=
 =?utf-8?B?ZU8wSENweHAzUFZrNmJHb1o2RDcyb2xDT1NWSytCbXdNaGtRdlBMS2xFaTZZ?=
 =?utf-8?B?WnNGTG0xcENFWnZ3NlZKbjBuRU1xeDBLYkY4M1FWYjNCRzJpa1lQUCtQMFho?=
 =?utf-8?B?MWFMK3Q3am9lZHMvVEpvbWg4dlkvbmY4d1pZTGFCOXFSRFdMMkE5NFVxR25J?=
 =?utf-8?B?WC9ybXgwNlR3TXFiSkk5TitFb3llYmE1UG1lWDkvNHlpazZ2QkRHdG5vV21C?=
 =?utf-8?B?MXdhMjRwc25FcTkxUzc4MFNNK2R0eGQrOEFVbWlXVm1jUGFtNUNDU1RzMEwz?=
 =?utf-8?B?ZkV0V0o5V1VMNTNGaDJPZkdtczJ6NUMwOTMzb3h1SnBmWGN6eWJ1bzVEeFZV?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SDlrUGR4L2w5VFRzTmdrRHMwY0h3YUxuT2NEQWFpUk13MHlFNHdZOVdWazJs?=
 =?utf-8?B?MTRXNTFTZ09GaWJkYThOVm1HWlgyQjFpMnowU3FISGJqMmVVTngxck44ellG?=
 =?utf-8?B?R2w0Ym9wVzlPVW96N0hjaUZkU3ROMWtYQkJqTFlsQ1NkNjFEL2RQMWIyYzQ3?=
 =?utf-8?B?cDBRZFdJckFOV0VEcG8zWVBlakVUTWVkZ3lNek9Wc2QwWityMEYzdjB3R04w?=
 =?utf-8?B?Vks5US9uQ3JPVHd1NUtHUlFQL3JQNE5WcWpRODRXNVJ6eFVYQ20zUDUrVWZy?=
 =?utf-8?B?bVpIandHSDBKamlLY21XaTBhL0prdlFrSk9sL0d0cy9BSkZzTVBzSHo5eW9r?=
 =?utf-8?B?VDFpd2txYWRRMC8xR3NMU0VCNEM5UDFjM0RUek1UWnRQSmVtV2dUMVlCdUI4?=
 =?utf-8?B?ZmxkZ0F0VFJuMDgyNjBRSnFIUVR4Q05ZaStsV1NMSjdxUzNMK1puQUhhZWJn?=
 =?utf-8?B?OXAzVjJIbzNQWFczT2RYbTU3T2Mzbzc1Yko0UE91NndNcHZUQXc3MGtZM1o2?=
 =?utf-8?B?V2g4dDhTL1FhT201NlhwT2grWkJPNDBmd3g1UUh0Uk1JRmowUFBXWUVxb0xH?=
 =?utf-8?B?Y0NZa1RFVE53K3pLQWJXSEVjd2I0RGpjcWRzOWtSTU5helVWdTJUZnZOdUpk?=
 =?utf-8?B?SVphb0hPMXJ2K21UcVkwZ1JDWG9YWmNaZWM4YnAwdE5KMm1tM0xNT0ovb3JQ?=
 =?utf-8?B?V0JwcnlNNlZKZHg1a1BtRDk4TFpXV0JzQ1NLNG1JM1NkWitzQS9KMjFsTStL?=
 =?utf-8?B?dUx4cXd0bnhrQWJPTlhHZWtHR2toOVp6bGtMamo5WUNsLzVZYkVmc2VqTmpH?=
 =?utf-8?B?MWgxbCs2alp2QVlsd3NnOHdFcTZIN1VYYkJ6eDlheFNZNVVZS0RQWXMvNWx3?=
 =?utf-8?B?YlV2Mldsc2c4blJocmF2eWgvTU9SNzFvbS85Mjg2SzZPR29iR3kva1UvOUlG?=
 =?utf-8?B?RzV5U2t0N1pzczhCV2hNU2lJRjA2dlZvRFNwem5hRnhaNkoyYXBuY3dJeXAr?=
 =?utf-8?B?cmpMQnMzaWQ2Q0hxVlprSlkyM2JkK0ZUUm9BdG83ZXBqTHVxNlRHUUVNenpD?=
 =?utf-8?B?ZzgrTXBJRGg5TmJic2l1bHc5cHpiRGE4c3ErNnpUZFVVNkxrZmkwcFYxd2FZ?=
 =?utf-8?B?Qm8xVk9ia2cwdkVXdjQ5Ym15T2V1V0RmZE9Fb1VPZU1kQ0tYbHZwN2ZqbS9C?=
 =?utf-8?B?NkFtdTJvak9HOGFRWG1UQ0lJTkFNTkR6bzZUT1hFOGgyeXJPWGFZRW9DSll2?=
 =?utf-8?B?SnRjcnpPVUdKUXZDWDFxTGJLRnBwR0YwS1ZReTB4QmlpS3J0UG1odkpMVlZ3?=
 =?utf-8?Q?RecJYl+fm44MI2NRzyCfxSoAhT7tps9S2V?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12e53f7-099b-439f-b79f-08dbb3980ade
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:56:20.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGquC8Ck8TRL11cosC2Mc2Wp673261mhtXBfGVItGyFLaVSP1jNw2IGrqqmmvfrx2GnZHA3Hh7tNJOsfjldImg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=657 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120116
X-Proofpoint-GUID: 3NKMgGMMgE4_Bs82JLoCsy2diqI8bQs2
X-Proofpoint-ORIG-GUID: 3NKMgGMMgE4_Bs82JLoCsy2diqI8bQs2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul E. McKenney <paulmck@kernel.org> [230912 06:00]:
> On Tue, Sep 12, 2023 at 10:34:44AM +0200, Geert Uytterhoeven wrote:
> > Hi Paul,
> >=20
> > On Tue, Sep 12, 2023 at 10:30=E2=80=AFAM Paul E. McKenney <paulmck@kern=
el.org> wrote:
> > > On Tue, Sep 12, 2023 at 10:23:37AM +0200, Geert Uytterhoeven wrote:
> > > > On Tue, Sep 12, 2023 at 10:14=E2=80=AFAM Paul E. McKenney <paulmck@=
kernel.org> wrote:
> > > > > On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote:
> > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> > > > > > > On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett wro=
te:
> > > > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > > > > > > > > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howlett=
 wrote:
> > > > > > > > > > (Adding Paul & Shanker to Cc list.. please see below fo=
r why)
> > > > > > > > > >
> > > > > > > > > > Apologies on the late response, I was away and have bee=
n struggling to
> > > > > > > > > > get a working PPC32 test environment.
> > > > > > > > > >
> > > > > > > > > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:=
42]:
> > > > > > > > > > >     Hi Liam,
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > > > > > > > > The current implementation of append may cause dupl=
icate data and/or
> > > > > > > > > > > > incorrect ranges to be returned to a reader during =
an update.  Although
> > > > > > > > > > > > this has not been reported or seen, disable the app=
end write operation
> > > > > > > > > > > > while the tree is in rcu mode out of an abundance o=
f caution.
> > > > > > > > > >
> > > > > > > > > > ...
> > > > > > > > > > > >
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > > > > RCU-related configs:
> > > > > > > > > > >
> > > > > > > > > > >     $ grep RCU .config
> > > > > > > > > > >     # RCU Subsystem
> > > > > > > > > > >     CONFIG_TINY_RCU=3Dy
> > > > >
> > > > > I must have been asleep last time I looked at this.  I was lookin=
g at
> > > > > Tree RCU.  Please accept my apologies for my lapse.  :-/
> > > > >
> > > > > However, Tiny RCU's call_rcu() also avoids enabling IRQs, so I wo=
uld
> > > > > have said the same thing, albeit after looking at a lot less RCU =
code.
> > > > >
> > > > > TL;DR:
> > > > >
> > > > > 1.      Try making the __setup_irq() function's call to mutex_loc=
k()
> > > > >         instead be as follows:
> > > > >
> > > > >         if (!mutex_trylock(&desc->request_mutex))
> > > > >                 mutex_lock(&desc->request_mutex);
> > > > >
> > > > >         This might fail if __setup_irq() has other dependencies o=
n a
> > > > >         fully operational scheduler.
> > > > >
> > > > > 2.      Move that ppc32 call to __setup_irq() much later, most de=
finitely
> > > > >         after interrupts have been enabled and the scheduler is f=
ully
> > > > >         operational.  Invoking mutex_lock() before that time is n=
ot a
> > > > >         good idea.  ;-)
> > > >
> > > > There is no call to __setup_irq() from arch/powerpc/?
> > >
> > > Glad it is not just me, given that I didn't see a direct call, either=
.  So
> > > later in this email, I asked Liam to put a WARN_ON_ONCE(irqs_disabled=
())
> > > just before that mutex_lock() in __setup_irq().

I had already found that this is the mutex lock that is enabling them.
I surrounded the mutex lock to ensure it was not enabled before, but was
after.  Here is the findings:

kernel/irq/manage.c:1587 __setup_irq:
[    0.000000] [c0e65ec0] [c00e9b00] __setup_irq+0x6c4/0x840 (unreliable)
[    0.000000] [c0e65ef0] [c00e9d74] request_threaded_irq+0xf8/0x1f4
[    0.000000] [c0e65f20] [c0c27168] pmac_pic_init+0x204/0x5f8
[    0.000000] [c0e65f80] [c0c1f544] init_IRQ+0xac/0x12c
[    0.000000] [c0e65fa0] [c0c1cad0] start_kernel+0x544/0x6d4

Note your line number will be slightly different due to my debug.  This
is the WARN _after_ the mutex lock.

> > >
> > > Either way, invoking mutex_lock() early in boot before interrupts hav=
e
> > > been enabled is a bad idea.  ;-)
> >=20
> > I'll add that WARN_ON_ONCE() too, and will report back later today...
>=20
> Thank you, looking forward to hearing the outcome!
>=20
> > > > Note that there are (possibly different) issues seen on ppc32 and o=
n arm32
> > > > (Renesas RZ/A in particular, but not on other Renesas ARM systems).
> > > >
> > > > I saw an issue on arm32 with cfeb6ae8bcb96ccf, but not with cfeb6ae=
8bcb96ccf^.
> > > > Other people saw an issue on ppc32 with both cfeb6ae8bcb96ccf and
> > > > cfeb6ae8bcb96ccf^.
> > >
> > > I look forward to hearing what is the issue in both cases.
> >=20
> > For RZ/A, my problem report is
> > https://lore.kernel.org/all/3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m=
68k.org/
>=20
> Thank you, Geert!
>=20
> Huh.  Is that patch you reverted causing Maple Tree or related code
> to attempt to acquire mutexes in early boot before interrupts have
> been enabled?
>=20
> If that added WARN_ON_ONCE() doesn't trigger early, another approach
> would be to put it at the beginning of mutex_lock().  Or for that matter
> at the beginning of might_sleep().

Yeah, I put many WARN() calls through the code as well as tracking down
where TIF_NEED_RESCHED was set; the tiny.c call_rcu().


So my findings summarized:

1. My change to the maple tree makes call_rcu() more likely on early boot.
2. The initial thread setup is always set to idle state
3. call_rcu() tiny sets TIF_NEED_RESCHED since is_idle_task(current)
4. init_IRQ() takes a mutex lock which will enable the interrupts since
TIF_NEED_RESCHED is set.

I don't know which of these things is "wrong".

I also looked into the mtmsr register but decided to consult you lot
about my findings in hopes that someone with more knowledge of the
platform or early boot would alleviate the pain so that I could context
switch or sleep :)  I mean, an mtmsr bug seems like a leap even for the
issues I create..

Regards,
Liam

