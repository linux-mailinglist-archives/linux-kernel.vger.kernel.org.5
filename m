Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE19803AD5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjLDQvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjLDQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:51:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0855FAC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:51:32 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Gl1Lm012196;
        Mon, 4 Dec 2023 16:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=eGycmsyAkbp15dB8gMWM9p8yoAEK5SgJEu+tPlr/rtE=;
 b=WsxhiME6G/uF3pKcVimMusBY4yf8mAfkffMpPWpwDKTzqSKUPes2o1xYkH/LJ9T71x+0
 PCnA2BTW5mZ6S/p74TVdvkVupKfInJGrxzuuxKWEgqv0u1nR1XH14wPPuMOMsQZQg1fe
 DK7cK4MRZGTth1vtE6hRSXyhFkA8dmxupD5kcWc1iqMKyriaurW4EkGtWnmZvABybfyd
 kyW5I7JOWS99QKCk2EGT4U6oQugqgs5OdtraMOJw3zBHS1b/orc413Y7K4RuyUj+9lkO
 o5whhbXVjqWB4LBvRf7kv0Pd5Rpa6tioH5wVaDahYKnQyx30W1I6TprgqyrmNBLfGRif KA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usjkd00hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 16:50:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4GWhMY014418;
        Mon, 4 Dec 2023 16:50:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu161m8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 16:50:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hurSRg0iBVzQX7oPFsUm6b6aBaLFCMX0yrevOxyyeY/L39z/l6xUVDasvVEU3ZKVqaHjlMBY2FGMzpc18bzF13M7eTIiQcIVsIgif6TFZFBSQFsf+C9Aioc5RTTRAblCk4kXFLzDbodqrfODz/EDzqauAu4XDkc7HMSW3HlQq+hq5fXarKUhz3OgdEhjQs8EMvthLvys1ySzH9UpBxuuRx4BfXO9j3FpLKDdSqYbjx3OLfu1lbhF8PWx1a4KJeTPsid4CVEIjYfYx4pBOvT2ANOPyX5Nb04fIiiim8IO2Fys9/F4s+Ugn5ep2GTM/p447y+DzPq442C2cNHbnVueeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGycmsyAkbp15dB8gMWM9p8yoAEK5SgJEu+tPlr/rtE=;
 b=fryQ6+NTkHXLZjf77hnV8AKcr+b75G6O2sayJUeeVr1ZF+s9/gZDf1iuqe9tHLIlvvjX3zDCq1QCSjBIoFOcM0ZG7L6aXWIttrd3jgTSR8vT2Y/cOawrMuCXJMFlKIQRpOaSXX3s63CST1jkELdiCgL5myKnOxWF6V+ufgr9MlwyHZuraejgbIqrSierdePdnQcHpfmUpVAYVwKbLBT80Wq6g+trFbPUofoptZkfGHrApm46bJcZu8L7t9Mr+4eN5hqBjJJbX831l2rODExZtXv70F3GHIgHc8Fupw7kxCVEB9/CZxHRqdgvMjRumSbWaQG78ZniPDnr6c8VkxRktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGycmsyAkbp15dB8gMWM9p8yoAEK5SgJEu+tPlr/rtE=;
 b=Fw4gsrLwk3zBGS/60VAmULEZPXSqAQj7ulte8MROrN+UBWZQ3QmZquWrYK0Kd+F8dhMKf2iL5PamutxU2d+wcONRkKExnoJQJAvgC0ujNCKNefUINGDwkZFHOtbvzcCjspwLrBPywXlX5bBEnDqqOG1AASO2S/4yGuDPnlouT34=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4195.namprd10.prod.outlook.com (2603:10b6:a03:201::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 16:48:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 16:48:13 +0000
Date:   Mon, 4 Dec 2023 11:48:09 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [fork] 6e553c6bcb:
 will-it-scale.per_process_ops 94.7% improvement
Message-ID: <20231204164809.y7wehmtr6kfcgg65@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Mateusz Guzik <mjguzik@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        kernel test robot <oliver.sang@intel.com>
References: <202311282145.ff13737b-oliver.sang@intel.com>
 <4240e03a-ab43-4bf3-85cf-86a18fa9ba19@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4240e03a-ab43-4bf3-85cf-86a18fa9ba19@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::35) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: ec383575-2ea5-4bc8-a7c1-08dbf4e8cdcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i37VVu3qbmlP7XfVd7/bYres+CvmHUk/GDrvwqQJc+Y99pybf1nC2Ddq+vnRjVKG3SPB0TFSZv6tPI3AWt0vu/sZ3z0kibMK7O+6JMHtuZeoghbVF3vF6eMvhLCGYhbhQp9PaWIgCud/2hCyQgEDSHsplvMV0LAITA9O8jrmV3zROon0BxosNXxzHbKyb9iByjYyB3vWxfw4H2krJIRD7kQgOnw6ooTrTKumtbL/0ra3eZm8XHVcuOEfzzD/BL8J0I9LHRKjb+K3i3+FnkB+StzicpqGJFANq47wafenasu4dsuxNx6JqF0LTq1gisNszanqEDVQeE9N3P79aV2Qf67ZBLobv+0hVrfv8fbaKz4Sfh0EsvXwnFeeer+fH8SgUQxE0kQ6H7c+SmEl5NC/RYKGzdxZ9NobGwfZObHOgYa1TLk8YNKG+L1jwbIuEb4ywt58sPAegsOWGXHHXFAQy9SspMpOTbqy3q8f4MfUjVeg/wnCGqWdVJeUYVaGBKgeSYuDloyLgMY2WQmVEQZFRVqWx6cxJVgDdhR54Jo7Bz2L847VneEOGNhOgvZf9ti+YisoFL0NQv/IxT3DhhjHZ+2inW2IDIc8CBz0S8x21aPEUJ0u9JN+Fi22R4ioMWtg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(230373577357003)(230473577357003)(64100799003)(1800799012)(186009)(451199024)(1076003)(4326008)(8676002)(8936002)(9686003)(6512007)(6506007)(83380400001)(26005)(6486002)(966005)(478600001)(6666004)(66899024)(66476007)(54906003)(66946007)(66556008)(316002)(6916009)(2906002)(33716001)(41300700001)(38100700002)(86362001)(7416002)(5660300002)(30864003)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdkbVB0RUllcnMvQmdBUGRQZk9FR1NZTTJrdHB4NmpwckFLTnBkMzZxQ1Ew?=
 =?utf-8?B?Rm4vWnBvZ3JBYUt3aFp2eFFERDZmbUhpb1I3Y2JOQnpsTFI2aGRUZkhHQnRG?=
 =?utf-8?B?WnFidU1IcXluYWNUd1F6Wnd6YmtNSk9pRWxQTkxDUXY1NHIrOGNrSDNPcmll?=
 =?utf-8?B?cEZzK29OQkdwOHJSMkNOem5wUE9ZTm1UK1owQTlkdFhBRjQwSXlxNzNubDVL?=
 =?utf-8?B?QjhCY0w4Ym1kUFhvWGhuVVlubG1Ld1Vud1NGN2t5WlovY1doTnBPOUxuZjB4?=
 =?utf-8?B?Q1VqL003N2ROZENMTFRqSVBodHU2RUNNY2FkOFoyN2sra05CUmh4Y3l0NUNx?=
 =?utf-8?B?ZDRKOFdQekRWZlR5dmJEampVQitwWjNQTHdqMUM4NWtld0NxSDhQWWx1NE1a?=
 =?utf-8?B?czM2TEhMYmpHS2ZtTXRpY2N0Y003NUtlQ0dibEs3Y2NqRWRCSGJJbUZ1Tkln?=
 =?utf-8?B?OEl5dmpsbVAwOXNPQkJJRmorU2ZmUUc4a21jTGd2bnpDdnZCWnBqS0lLSmpa?=
 =?utf-8?B?K1RtZGRkVWdZMEloWlZ1N0ZzQmNRRFpkenpSOXowcU4za0pOcW53SVdwOUhm?=
 =?utf-8?B?NVkxbDNBNHc2T2p2L055c1hSb0dVTjlVemZtWWdnT3VYWTRpUm01SmJFV1JL?=
 =?utf-8?B?bGRaNVljRG1kN0lJbDR1Q3ZSMEZ3T25aRkJ4Z2tXRnAxNEZGTzBtb250dERN?=
 =?utf-8?B?dk53dzhLSHpXZ2JBRCtPOUd6bE15NlMxR3ozQXFzMlNiR3dFd1hoYm05Ukd3?=
 =?utf-8?B?djUySUwrbWhBNEpDMGxJbDRRQVhSZ04vYXdoMnZZRGVkK05zNkRNUVc5SGln?=
 =?utf-8?B?cExGeXBjL3EybDR4U3RJcTcwWHZkZnF0V3BybXZNWmJpUlhxdDB4ZFlnVm1q?=
 =?utf-8?B?Q2N1Q2ZrMGlYamNmcy9wMnQxc2Era3hJWURLNXJnNDh2clJkQkpEbU13Slk2?=
 =?utf-8?B?QndFT3JOSnNUU2VNb1BZczJ3MWs0b0lEcjNESEI4SmtXZFZ5Z2pzNTBRVld4?=
 =?utf-8?B?V1hiUDdvZHptYWJUbm5PeFRQb2ZWQmpuR0FmU0FNaVhZVEtGVzdnQ3h6WHhF?=
 =?utf-8?B?elRuRWI0RVRCUHdJV1oxOEg4U3ZEWUFIVnJxdXBIRzZ4ZlhvY0xEVlJnZ0s4?=
 =?utf-8?B?VDZOUnBKeWU2V1o2S0VEc1Nlc2o1a0NVVXJGaVI0cDJnc2NNL0JJakJYcHhL?=
 =?utf-8?B?VGR0RjYxdnJCSThHenczbStMTW1TeFBUWjFQRzFCQ3RjUnE0d2QwbzdhUDdu?=
 =?utf-8?B?QTV0U2xsY1R6SFY1NHo3VktJcmE2ZG9ya25KVENVVnhEZTBUWTl4Nm4xaURx?=
 =?utf-8?B?cFFCQ3lRdTVOZGcwQnhhbWlGZVVTR1RnYTEwbkZTWjFSamFESzNVUDNCV3VI?=
 =?utf-8?B?bWZudEkxM1V6TDhIUFB1M1JlY3N5Vnd3VGZlUk9YT1ZBbHdHbWdOQ3NYRmV2?=
 =?utf-8?B?UkxKcXYwaFY2Y1NUQjhwUXBXVkZndzhSVUpIWFJ2TTc3RXY1eHBjT3hsS0N5?=
 =?utf-8?B?RHhKVVFvTnNEQ01oNjExL284YUdSeW54V1dyM2Z5ejQ1MmV4Qyt5RnEyZ3FW?=
 =?utf-8?B?MHI4OTA5eUhyK3h3Znd0bUtIWjlPd3B3UVJVUFVYN0VLWGhKQzBEbzZOTEdp?=
 =?utf-8?B?SWJPUFpXWTNsZFZkZWFQbVVvbzVOQXlmRkdnM3RINlduejhQVTViTXdOZHEr?=
 =?utf-8?B?eHJJT1RLS0M2Wml5eHUwZVcrcFNHMFdSY0JLako5Y3Nvd2dhOTB0NmwySFpR?=
 =?utf-8?B?aEpxMTQ4aDNndFFJcDZXYnZOTEprcXFhOEYwSUFkWE1xMU16WHZZR2doRUdL?=
 =?utf-8?B?Mm95MnBia3RLdzM5b3Jna2tPTnRMOE1kc2RmNDk0dm5uUkhlUWpsT2tUWDBF?=
 =?utf-8?B?NFBDeU92NmZDMDFJYittM1FDNjBkZW5NeWZ3dzV0T09UdkE0YkxsK1B4ZTVN?=
 =?utf-8?B?UzVSY0k1NzR2QXU0QlZoVXVQK2FnVkdZSjNITkpnSE5tNzBiSlZVV3NVbmgw?=
 =?utf-8?B?OEFhSzhRRmkxMit5dnhPdExHd3BzR3JyeG9JNWtFZnZGWm05eElLamtZV1ZL?=
 =?utf-8?B?cTFza1JRSXAvTElkOEZFTXhRSDI3MVJ4bmhWRWNtYW4rNGx6YVNtL0Y3NHVH?=
 =?utf-8?Q?II3qvS7P9Qp+cIbZBc3rcoD7n?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dStteXNvOTZtY1l1RVVhZC8xRW82OWNOU2ZnR0grV05CYzJmZGN6OXdGNjQx?=
 =?utf-8?B?cUhrVStFUExIQkx0VkNiVXdYbDJJSFBFZkozRjhzSWN0S2JHZmFtODgzczBE?=
 =?utf-8?B?NmFVR1RST0ZPU1NwbWJUSStBc2ZmZWQ0amtaWVRaVTRmdVJFcXBkQ0ZSUlZK?=
 =?utf-8?B?ZExNc2I5U2d1OHNBam5QSTQ5aTlTdlFZTWloQ0x3VFFxaGZpVm8ya2dwcTlD?=
 =?utf-8?B?b3hBU1dqWnlhUDlIeGF4RHhxVXU1eDVrU0hTMTFwaTV6a3daemorNzlOSnAx?=
 =?utf-8?B?RnBVem1xNktWNUpFSkQ4ZWJhMUNHa0ZiNmhCUzF0czRqcE90S2J4d2pMMGJo?=
 =?utf-8?B?N2xqSTBCaVl5M1FVaG5JTklRVlcrYkE3dldCRFZqblVhVGJJcFhqT3BTUmlp?=
 =?utf-8?B?Wnp1dTkrUkhqTE1lL1ZkemxlV2N5dTlvOTlUK3A0dm80TXRPUjYwNkV5M3Bz?=
 =?utf-8?B?bm9EZ1NRUkY3Wk5ZenhNd0dZdXB5c08xQmpFYzRsNzZvaWRGaVRMbHN2N3oz?=
 =?utf-8?B?UUg0R0dKUzRKVmppcytUcnpENEd2SitjREFYWmNYUGtLWDJYK0hSRVh1a3hN?=
 =?utf-8?B?Qzg4RUZud1Q2cFRrRXp6eFA0MW5pRWNBRk5IQ2xKTENMUU5UZ3RadXVHSkY2?=
 =?utf-8?B?bEszOWZkaTI4YmUyRmhZK3I0T1cwYlladDFlZmc0cFU2cXdFL0o2Z2phTVpZ?=
 =?utf-8?B?ckxycDNEaUl1bXAyOGliejZIOWZrUDFqQU9jL2VYSERLbUxsbWh1RXdRYUtr?=
 =?utf-8?B?TW13YUVINWtFdkdySXR4SU13R0xzbGxCRUQ1WktWNTJETEJGbmk0T1R0ZXlm?=
 =?utf-8?B?RDBzZ2xUb1JWVThmNTl5aCtXRnB0RG5MRmxidXhWTjJ4L3RLc0hhSlFPQ2tz?=
 =?utf-8?B?MmcxYzVVU1psdWhVWHdrV1BOcFBoQjEybUxNWG0wY2k2TitmUitTbk13UGRj?=
 =?utf-8?B?NDFEZXBwK0RwQ2pNUkNOMmRjaEVsUkVGa0pHT2dodktvNERjTHppQnJnMEps?=
 =?utf-8?B?Qk1VZlJNUnlVc1FSVDdQdUxGUithdDdnK0wwa2g2c00xVGJ5ZDlOcHBXZERN?=
 =?utf-8?B?NzdzWFNuTW13eVV1SW9pZ2w0WjBmMGFraytrdWNrNlp6Kys4VGthL2p2bldm?=
 =?utf-8?B?Rmc4T2E1VmJOMCsyOWNCR3E3RE55ZnpWcDNMU1hqZUtzcWh2ZmlsR1lWbUhC?=
 =?utf-8?B?RHRRazNwdkx1bG12dWtrZXgyYVgvYXlDbnk5cjJGS2U2TlUyM0hkakxkMUNQ?=
 =?utf-8?B?N0ozZnoyMzVPSEdCak9SMkRnc3FuMFpZZ042bHhVTHMrY3pQcE1HTnM2SG1Z?=
 =?utf-8?B?b1dCQXpIUlRrN0Zwb2Vldkd4WnFHR3RIeUpPcnRJR3M1WGt5TWpqUG41ZmxW?=
 =?utf-8?B?Q2pqTUtDQkIwaFN6bGMrWmxENDJURkdFd1hPODdJdE1iOXpkdW5vZ0l5NHNm?=
 =?utf-8?B?SEt5OTJaOFJwQWtDejVJQUVKVnJaRVgwZkdmNWJCYVRDUHpEZWl0dERpeE82?=
 =?utf-8?B?c2JxTitjSy9LVUwyL3FrN3J4TEJMU3hNcXNySDcrUmI2dk1nc09MUDRZcUQr?=
 =?utf-8?B?SHk5dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec383575-2ea5-4bc8-a7c1-08dbf4e8cdcf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:48:13.3157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfvvQligIZYoldUe8Tb70QJ8QEY4ts9IvGyiIxzAnWkDA8p/ErkDn93/p2wpNZ5UzIgOh8Qw11+RHkDfwzpUvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_16,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040128
X-Proofpoint-GUID: 5jSmAxUA-5ETA4hymSvzmeOpQQhzDcv2
X-Proofpoint-ORIG-GUID: 5jSmAxUA-5ETA4hymSvzmeOpQQhzDcv2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [231204 02:15]:
>=20
>=20
> =E5=9C=A8 2023/11/28 21:55, kernel test robot =E5=86=99=E9=81=93:
> >=20
> >=20
> > Hello,
> >=20
> > kernel test robot noticed a 94.7% improvement of will-it-scale.per_proc=
ess_ops on:
> >=20
> >=20
> > commit: 6e553c6bcb7746abad29ce63e0cb7a18348e88fb ("fork: use __mt_dup()=
 to duplicate maple tree in dup_mmap()")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >=20
> > testcase: will-it-scale
> > test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > parameters:
> >=20
> > 	nr_task: 100%
> > 	mode: process
> > 	test: brk2
> > 	cpufreq_governor: performance
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > Details are as below:
> > -----------------------------------------------------------------------=
--------------------------->
> >=20
> >=20
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20231128/202311282145.ff13737b-=
oliver.sang@intel.com
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/t=
estcase:
> >    gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-11.1-x86_64-2=
0220510.cgz/lkp-skl-fpga01/brk2/will-it-scale
> >=20
> > commit:
> >    ec81deb6b7 ("maple_tree: preserve the tree attributes when destroyin=
g maple tree")
> >    6e553c6bcb ("fork: use __mt_dup() to duplicate maple tree in dup_mma=
p()")
> >=20
> > ec81deb6b769dc1b 6e553c6bcb7746abad29ce63e0c
> > ---------------- ---------------------------
> >           %stddev     %change         %stddev
> >               \          |                \
> >       24.47            -7.2       17.29        mpstat.cpu.all.soft%
> >        8.76            +7.6       16.36        mpstat.cpu.all.usr%
> >        8.80           +85.5%      16.33        vmstat.cpu.us
> >        7732           -18.3%       6318        vmstat.system.cs
> >    13467005           +94.7%   26223847        will-it-scale.104.proces=
ses
> >      129489           +94.7%     252151        will-it-scale.per_proces=
s_ops
> >    13467005           +94.7%   26223847        will-it-scale.workload
> >   1.792e+08           -13.6%  1.549e+08        numa-numastat.node0.loca=
l_node
> >   1.793e+08           -13.6%  1.549e+08        numa-numastat.node0.numa=
_hit
> >   1.867e+08           -12.6%  1.631e+08        numa-numastat.node1.loca=
l_node
> >   1.867e+08           -12.6%  1.632e+08        numa-numastat.node1.numa=
_hit
> >   1.793e+08           -13.6%  1.549e+08        numa-vmstat.node0.numa_h=
it
> >   1.792e+08           -13.6%  1.549e+08        numa-vmstat.node0.numa_l=
ocal
> >   1.867e+08           -12.6%  1.631e+08        numa-vmstat.node1.numa_h=
it
> >   1.867e+08           -12.6%  1.631e+08        numa-vmstat.node1.numa_l=
ocal
> >      122.70           +43.4      166.10        turbostat.PKG_%
> >       56.67 =C2=B1  2%      -6.8%      52.83 =C2=B1  3%  turbostat.PkgT=
mp
> >      376.36            +1.3%     381.14        turbostat.PkgWatt
> >       45.03            -5.8%      42.40        turbostat.RAMWatt
> >      121103            -2.7%     117803        proc-vmstat.nr_slab_unre=
claimable
> >       68338 =C2=B1  7%     +24.8%      85281 =C2=B1  6%  proc-vmstat.nu=
ma_hint_faults
> >    3.66e+08           -13.1%  3.181e+08        proc-vmstat.numa_hit
> >   3.659e+08           -13.1%   3.18e+08        proc-vmstat.numa_local
> >   7.155e+08           -15.6%  6.038e+08        proc-vmstat.pgalloc_norm=
al
> >     1025781            +2.6%    1052377        proc-vmstat.pgfault
> >   7.131e+08           -15.5%  6.028e+08        proc-vmstat.pgfree
> >    12305161           +10.3%   13578139        sched_debug.cfs_rq:/.avg=
_vruntime.avg
> >    12419603           +10.6%   13739004        sched_debug.cfs_rq:/.avg=
_vruntime.max
> >      122981 =C2=B1  5%     +41.3%     173809 =C2=B1 12%  sched_debug.cf=
s_rq:/.avg_vruntime.stddev
> >      376.33 =C2=B1 43%     -53.5%     174.89 =C2=B1 34%  sched_debug.cf=
s_rq:/.load_avg.avg
> >       85.75 =C2=B1  9%     -59.1%      35.08 =C2=B1 16%  sched_debug.cf=
s_rq:/.load_avg.min
> >    12305176           +10.3%   13578151        sched_debug.cfs_rq:/.min=
_vruntime.avg
> >    12419621           +10.6%   13739007        sched_debug.cfs_rq:/.min=
_vruntime.max
> >      122979 =C2=B1  5%     +41.3%     173810 =C2=B1 12%  sched_debug.cf=
s_rq:/.min_vruntime.stddev
> >       13056           -15.6%      11025        sched_debug.cpu.nr_switc=
hes.avg
> >        9228           -22.3%       7174        sched_debug.cpu.nr_switc=
hes.min
> >        0.28 =C2=B1  7%     -63.7%       0.10 =C2=B1 10%  perf-sched.sch=
_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
> >        0.08 =C2=B1  5%     -27.0%       0.06 =C2=B1  8%  perf-sched.sch=
_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
> >        3.56 =C2=B1 45%     -79.6%       0.73 =C2=B1199%  perf-sched.sch=
_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_fr=
om_fork_asm
> >       10.02 =C2=B1 62%     -70.0%       3.01 =C2=B1  2%  perf-sched.sch=
_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
> >       11.16 =C2=B1 29%     -48.2%       5.78 =C2=B1 45%  perf-sched.sch=
_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
> >       41.80           +25.8%      52.58        perf-sched.total_wait_an=
d_delay.average.ms
> >       37576 =C2=B1  2%     -21.0%      29680        perf-sched.total_wa=
it_and_delay.count.ms
> >       41.73           +25.8%      52.50        perf-sched.total_wait_ti=
me.average.ms
> >        4.50 =C2=B1  2%     -16.1%       3.78 =C2=B1  6%  perf-sched.wai=
t_and_delay.avg.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munma=
p.__do_sys_brk
> >        4.61 =C2=B1  6%     -18.0%       3.78 =C2=B1  2%  perf-sched.wai=
t_and_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_s=
yscall_64
> >        4.26 =C2=B1  7%     -11.7%       3.77        perf-sched.wait_and=
_delay.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_prealloca=
te.__split_vma
> >       32.16           +53.0%      49.20        perf-sched.wait_and_dela=
y.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fo=
rk_asm
> >       63.20           +35.4%      85.56 =C2=B1  2%  perf-sched.wait_and=
_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
> >      735.00 =C2=B1  2%     -68.0%     234.83 =C2=B1  4%  perf-sched.wai=
t_and_delay.count.__cond_resched.down_write.__split_vma.do_vmi_align_munmap=
.__do_sys_brk
> >        3090 =C2=B1  6%     -93.8%     190.50 =C2=B1  4%  perf-sched.wai=
t_and_delay.count.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_sy=
scall_64
> >      975.67 =C2=B1  3%     +61.5%       1576        perf-sched.wait_and=
_delay.count.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.=
entry_SYSCALL_64_after_hwframe
> >      298.17 =C2=B1  4%     +54.6%     461.00 =C2=B1  4%  perf-sched.wai=
t_and_delay.count.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preal=
locate.__split_vma
> >      524.33 =C2=B1  4%     +56.2%     819.17 =C2=B1  2%  perf-sched.wai=
t_and_delay.count.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preal=
locate.do_brk_flags
> >      402.83 =C2=B1  2%     +54.2%     621.17 =C2=B1  3%  perf-sched.wai=
t_and_delay.count.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.d=
o_vmi_align_munmap
> >      265.50 =C2=B1  4%     +28.7%     341.67 =C2=B1  2%  perf-sched.wai=
t_and_delay.count.__cond_resched.remove_vma.do_vmi_align_munmap.__do_sys_br=
k.do_syscall_64
> >      661.33 =C2=B1  7%     -27.6%     478.83 =C2=B1 10%  perf-sched.wai=
t_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.re=
t_from_fork_asm
> >       66.33 =C2=B1141%    +310.3%     272.17 =C2=B1  7%  perf-sched.wai=
t_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
> >        1517 =C2=B1  4%     +72.0%       2609        perf-sched.wait_and=
_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit=
_to_user_mode.asm_sysvec_apic_timer_interrupt
> >        6322 =C2=B1  3%     -41.1%       3725 =C2=B1  4%  perf-sched.wai=
t_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_=
exit_to_user_mode.do_syscall_64
> >       14299 =C2=B1  2%     -25.3%      10677        perf-sched.wait_and=
_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
> >       19.65 =C2=B1 25%     -38.8%      12.03 =C2=B1  7%  perf-sched.wai=
t_and_delay.max.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munma=
p.__do_sys_brk
> >       20.07 =C2=B1 27%     -42.3%      11.57 =C2=B1  8%  perf-sched.wai=
t_and_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_s=
yscall_64
> >       18.62 =C2=B1 28%     -32.5%      12.56 =C2=B1 12%  perf-sched.wai=
t_and_delay.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.=
do_vmi_align_munmap
> >       71.03 =C2=B1 10%     +44.2%     102.39 =C2=B1 36%  perf-sched.wai=
t_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.r=
et_from_fork_asm
> >       23.72 =C2=B1 26%     -33.5%      15.79 =C2=B1 12%  perf-sched.wai=
t_and_delay.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
> >       14.70 =C2=B1 21%     -33.3%       9.80 =C2=B1  2%  perf-sched.wai=
t_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
> >        4.50 =C2=B1  2%     -16.1%       3.78 =C2=B1  6%  perf-sched.wai=
t_time.avg.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.__d=
o_sys_brk
> >        4.61 =C2=B1  6%     -18.0%       3.78 =C2=B1  2%  perf-sched.wai=
t_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscal=
l_64
> >        4.26 =C2=B1  7%     -11.7%       3.77        perf-sched.wait_tim=
e.avg.ms.__cond_resched.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__=
split_vma
> >        4.26 =C2=B1  9%    -100.0%       0.00        perf-sched.wait_tim=
e.avg.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_prealloca=
te.__split_vma
> >        4.61 =C2=B1  3%    -100.0%       0.00        perf-sched.wait_tim=
e.avg.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_prealloca=
te.do_brk_flags
> >       32.13           +53.1%      49.19        perf-sched.wait_time.avg=
.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_as=
m
> >       63.12           +35.5%      85.50 =C2=B1  2%  perf-sched.wait_tim=
e.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
> >       19.65 =C2=B1 25%     -38.8%      12.03 =C2=B1  7%  perf-sched.wai=
t_time.max.ms.__cond_resched.down_write.__split_vma.do_vmi_align_munmap.__d=
o_sys_brk
> >       20.07 =C2=B1 27%     -42.3%      11.57 =C2=B1  8%  perf-sched.wai=
t_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscal=
l_64
> >       18.62 =C2=B1 28%     -32.5%      12.56 =C2=B1 12%  perf-sched.wai=
t_time.max.ms.__cond_resched.kmem_cache_alloc.vm_area_dup.__split_vma.do_vm=
i_align_munmap
> >       16.69 =C2=B1 36%    -100.0%       0.00        perf-sched.wait_tim=
e.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_prealloca=
te.__split_vma
> >       16.03 =C2=B1 17%    -100.0%       0.00        perf-sched.wait_tim=
e.max.ms.__cond_resched.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_prealloca=
te.do_brk_flags
> >       70.43 =C2=B1 10%     +45.4%     102.38 =C2=B1 36%  perf-sched.wai=
t_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_fr=
om_fork_asm
> >       23.72 =C2=B1 26%     -33.5%      15.79 =C2=B1 12%  perf-sched.wai=
t_time.max.ms.__cond_resched.unmap_vmas.unmap_region.constprop.0
> >       17.57 =C2=B1 34%     -29.3%      12.43 =C2=B1  7%  perf-sched.wai=
t_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
> >        8.69 =C2=B1  9%     -20.8%       6.88        perf-sched.wait_tim=
e.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
> >        2.62           -12.2%       2.30        perf-stat.i.MPKI
> >   2.471e+10            +5.8%  2.614e+10        perf-stat.i.branch-instr=
uctions
> >        0.82            +0.1        0.90 =C2=B1  3%  perf-stat.i.branch-=
miss-rate%
> >   2.032e+08           +14.1%  2.319e+08        perf-stat.i.branch-misse=
s
> >       61.39            +1.3       62.74        perf-stat.i.cache-miss-r=
ate%
> >   3.567e+08           -14.2%  3.061e+08        perf-stat.i.cache-misses
> >    5.81e+08           -16.2%  4.871e+08        perf-stat.i.cache-refere=
nces
> >        7695           -18.5%       6271        perf-stat.i.context-swit=
ches
> >        2.04            +2.6%       2.09        perf-stat.i.cpi
> >      249.60           -26.8%     182.76        perf-stat.i.cpu-migratio=
ns
> >      780.53           +16.7%     911.09        perf-stat.i.cycles-betwe=
en-cache-misses
> >        0.05            +0.0        0.08 =C2=B1  4%  perf-stat.i.dTLB-lo=
ad-miss-rate%
> >    15775916           +75.7%   27724344        perf-stat.i.dTLB-load-mi=
sses
> >    3.43e+10            +5.8%   3.63e+10        perf-stat.i.dTLB-loads
> >      459336 =C2=B1  4%     -18.1%     376380 =C2=B1 10%  perf-stat.i.dT=
LB-store-misses
> >   2.189e+10            -2.7%   2.13e+10        perf-stat.i.dTLB-stores
> >    31159069           +37.1%   42716400        perf-stat.i.iTLB-load-mi=
sses
> >      456253 =C2=B1  4%     +83.6%     837671 =C2=B1 31%  perf-stat.i.iT=
LB-loads
> >   1.364e+11            -1.9%  1.337e+11        perf-stat.i.instructions
> >        4379           -28.5%       3131        perf-stat.i.instructions=
-per-iTLB-miss
> >        0.49            -2.1%       0.48        perf-stat.i.ipc
> >        1327           -23.4%       1017        perf-stat.i.metric.K/sec
> >      783.30            +3.4%     809.81        perf-stat.i.metric.M/sec
> >        2733            +2.7%       2807        perf-stat.i.minor-faults
> >     4668970           -23.7%    3562283 =C2=B1 12%  perf-stat.i.node-lo=
ad-misses
> >    44341556           -21.0%   35024109 =C2=B1  2%  perf-stat.i.node-lo=
ads
> >        2.44            -0.5        1.91 =C2=B1  9%  perf-stat.i.node-st=
ore-miss-rate%
> >     2146790           -44.9%    1183052 =C2=B1  2%  perf-stat.i.node-st=
ore-misses
> >    85964398           -24.9%   64569512 =C2=B1  2%  perf-stat.i.node-st=
ores
> >        2733            +2.7%       2807        perf-stat.i.page-faults
> >        2.62           -12.5%       2.29        perf-stat.overall.MPKI
> >        0.82            +0.1        0.89        perf-stat.overall.branch=
-miss-rate%
> >       61.39            +1.4       62.83        perf-stat.overall.cache-=
miss-rate%
> >        2.04            +2.1%       2.08        perf-stat.overall.cpi
> >      780.25           +16.6%     910.13        perf-stat.overall.cycles=
-between-cache-misses
> >        0.05            +0.0        0.08        perf-stat.overall.dTLB-l=
oad-miss-rate%
> >        0.00 =C2=B1  4%      -0.0        0.00 =C2=B1 10%  perf-stat.over=
all.dTLB-store-miss-rate%
> >        4376           -28.5%       3130        perf-stat.overall.instru=
ctions-per-iTLB-miss
> >        0.49            -2.0%       0.48        perf-stat.overall.ipc
> >        2.44            -0.6        1.80 =C2=B1  2%  perf-stat.overall.n=
ode-store-miss-rate%
> >     3051945           -49.6%    1539638        perf-stat.overall.path-l=
ength
> >   2.462e+10            +5.8%  2.605e+10        perf-stat.ps.branch-inst=
ructions
> >   2.025e+08           +14.1%  2.311e+08        perf-stat.ps.branch-miss=
es
> >   3.555e+08           -14.2%  3.051e+08        perf-stat.ps.cache-misse=
s
> >   5.791e+08           -16.2%  4.855e+08        perf-stat.ps.cache-refer=
ences
> >        7668           -18.5%       6250        perf-stat.ps.context-swi=
tches
> >      248.68           -26.7%     182.19        perf-stat.ps.cpu-migrati=
ons
> >    15739140           +75.6%   27640979        perf-stat.ps.dTLB-load-m=
isses
> >   3.418e+10            +5.8%  3.618e+10        perf-stat.ps.dTLB-loads
> >      458389 =C2=B1  4%     -18.1%     375627 =C2=B1 10%  perf-stat.ps.d=
TLB-store-misses
> >   2.181e+10            -2.7%  2.123e+10        perf-stat.ps.dTLB-stores
> >    31053977           +37.1%   42572874        perf-stat.ps.iTLB-load-m=
isses
> >      454414 =C2=B1  4%     +83.8%     835372 =C2=B1 31%  perf-stat.ps.i=
TLB-loads
> >   1.359e+11            -1.9%  1.333e+11        perf-stat.ps.instruction=
s
> >        2730            +2.6%       2802        perf-stat.ps.minor-fault=
s
> >     4653258           -23.7%    3549888 =C2=B1 12%  perf-stat.ps.node-l=
oad-misses
> >    44203348           -21.0%   34917073 =C2=B1  2%  perf-stat.ps.node-l=
oads
> >     2139791           -44.9%    1179122 =C2=B1  2%  perf-stat.ps.node-s=
tore-misses
> >    85677729           -24.9%   64357015 =C2=B1  2%  perf-stat.ps.node-s=
tores
> >        2731            +2.6%       2803        perf-stat.ps.page-faults
> >    4.11e+13            -1.8%  4.038e+13        perf-stat.total.instruct=
ions
> >       33.52           -19.0       14.50        perf-profile.calltrace.c=
ycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame.brk
> >       17.05           -14.1        2.93        perf-profile.calltrace.c=
ycles-pp.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
> Hi, Liam
>=20
> From the performance data shown above, we can see that there is a
> significant variation in the overhead of mas_store_prealloc() within
> the do_brk_flags() function. I speculate that the maple tree duplicated
> through __mt_dup() has a different structure compared to the maple tree
> duplicated through bulk store. In this test case, the maple tree duplicat=
ed
> through __mt_dup() triggers a fast path for maple tree store operations,
> thus avoiding memory allocation. It also avoids the slow path for maple
> tree store operations.
>=20

Hi Peng,

Thanks for the analysis.  I would expect such a difference to be
equalised the first loop - the maple tree would be expanded to make
space and then contracted, but each new loop should cause a node store.

If your speculation is correct, then we were causing a contraction
followed by an expansion; effectively 'jittering' after a fork.  I will
add this to the work items to investigate and see if we are not hitting
this in other scenarios.

This speculation looks correct considering we see a reduction of
spanning stores and associated allocations/cleanup.  I'm guessing we
filled the nodes too much and the brk VMA was the last entry in a node,
and so we end up rebalancing to relocate that entry and constantly hit
our worst case.  It's probably never fixed to avoid causing a larger
rebalance event.  Hopefully this only shows up in the old fork method.

There is also a lot of down_write and __split_vma delta, which is odd.
Perhaps the __split_vma could be explained by the jittering during a
split.  Maybe the down_write is due to the excessive time in allocations
and thus potentially triggering a timeout that ends up causing a
rescheduling.

Either way, this is a welcomed result.  Thanks for having a look at
these numbers, and for the patches that caused them.

Apologies for leaving all the benchmarking data in the reply, but
perhaps there is more to add that I've missed in this data.

Regards,
Liam


> >       11.58           -11.6        0.00        perf-profile.calltrace.c=
ycles-pp.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_al=
loc_nodes.mas_preallocate
> >       10.92           -10.9        0.00        perf-profile.calltrace.c=
ycles-pp.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_preallocate.do_brk_flags=
.__do_sys_brk
> >       10.60           -10.6        0.00        perf-profile.calltrace.c=
ycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk.mas_alloc_nodes.mas_=
preallocate.do_brk_flags
> >       10.54           -10.5        0.00        perf-profile.calltrace.c=
ycles-pp.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma.do_vmi_al=
ign_munmap
> >       10.26           -10.3        0.00        perf-profile.calltrace.c=
ycles-pp.mas_wr_spanning_store.mas_store_prealloc.do_brk_flags.__do_sys_brk=
.do_syscall_64
> >       11.70            -9.9        1.78        perf-profile.calltrace.c=
ycles-pp.mas_alloc_nodes.mas_preallocate.do_brk_flags.__do_sys_brk.do_sysca=
ll_64
> >       12.19            -9.2        2.97        perf-profile.calltrace.c=
ycles-pp.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
> >       69.63            -9.1       60.49        perf-profile.calltrace.c=
ycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
> >        8.93            -8.9        0.00        perf-profile.calltrace.c=
ycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.vma_complete.__split_vma
> >        7.42            -7.4        0.00        perf-profile.calltrace.c=
ycles-pp.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_=
alloc_bulk.mas_alloc_nodes
> >        7.32            -7.3        0.00        perf-profile.calltrace.c=
ycles-pp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_prealloc.do=
_brk_flags.__do_sys_brk
> >       12.16            -6.0        6.13        perf-profile.calltrace.c=
ycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.__=
do_sys_brk
> >       12.28            -5.9        6.43        perf-profile.calltrace.c=
ycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_sysca=
ll_64
> >        6.38            -5.6        0.73 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.mas_destroy.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_s=
yscall_64
> >       15.46            -5.0       10.49 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
> >       15.44            -5.0       10.48 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from=
_fork
> >       15.44            -5.0       10.48 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_fro=
m_fork_asm
> >       15.47            -5.0       10.50 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.ret_from_fork_asm
> >       15.47            -5.0       10.50 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.ret_from_fork.ret_from_fork_asm
> >       15.47            -5.0       10.50 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
> >       15.44            -5.0       10.48 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
> >       15.42            -5.0       10.46 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thre=
ad_fn
> >       74.20            -4.5       69.66        perf-profile.calltrace.c=
ycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
> >       20.44            -3.4       17.09        perf-profile.calltrace.c=
ycles-pp.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_S=
YSCALL_64_after_hwframe
> >        3.84            -2.5        1.34 =C2=B1  4%  perf-profile.calltr=
ace.cycles-pp.__slab_free.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
> >       76.40            -2.4       74.03        perf-profile.calltrace.c=
ycles-pp.entry_SYSCALL_64_after_hwframe.brk
> >        4.90 =C2=B1  2%      -2.0        2.86 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.rcu_core.__do_softirq.irq_exit_rcu.sysvec_apic_timer_int=
errupt.asm_sysvec_apic_timer_interrupt
> >        4.89 =C2=B1  2%      -2.0        2.84 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.irq_exit_rcu.sysvec_a=
pic_timer_interrupt
> >        2.88            -1.9        1.03        perf-profile.calltrace.c=
ycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.__=
do_sys_brk
> >        3.53            -1.3        2.22        perf-profile.calltrace.c=
ycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_sy=
scall_64
> >        0.95 =C2=B1  3%      -0.2        0.71 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.__do_softirq.ru=
n_ksoftirqd
> >        0.71            -0.1        0.62 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__do_softirq.run_ksofti=
rqd
> >        0.74 =C2=B1  3%      +0.2        0.94 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.__unfreeze_partials.rcu_do_batch.rcu_core.__do_softirq.i=
rq_exit_rcu
> >        0.67            +0.3        0.97 =C2=B1  3%  perf-profile.calltr=
ace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.__do_softirq.run_ks=
oftirqd
> >        0.56 =C2=B1  2%      +0.4        0.97 =C2=B1  5%  perf-profile.c=
alltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic=
_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64
> >        0.56 =C2=B1  2%      +0.4        0.97 =C2=B1  5%  perf-profile.c=
alltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.as=
m_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode
> >        0.58 =C2=B1  2%      +0.4        1.01 =C2=B1  5%  perf-profile.c=
alltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_=
mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
> >        0.58 =C2=B1  2%      +0.4        1.01 =C2=B1  5%  perf-profile.c=
alltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interr=
upt.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me
> >        0.00            +0.5        0.51        perf-profile.calltrace.c=
ycles-pp.mas_pop_node.mas_wr_node_store.mas_wr_store_entry.mas_store_gfp.do=
_vmi_align_munmap
> >        0.00            +0.5        0.52 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.__pte_offset_map_lock.zap_pte_range.zap_pmd_range.unmap_page_=
range.unmap_vmas
> >        0.00            +0.5        0.53 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.mas_pop_node.mas_wr_node_store.mas_wr_store_entry.mas_store_p=
realloc.vma_complete
> >        0.00            +0.5        0.54        perf-profile.calltrace.c=
ycles-pp.mas_update_gap.mas_wr_node_store.mas_wr_store_entry.mas_store_prea=
lloc.vma_complete
> >        0.43 =C2=B1 44%      +0.5        0.97        perf-profile.calltr=
ace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap=
_region
> >        0.00            +0.5        0.55        perf-profile.calltrace.c=
ycles-pp.arch_get_unmapped_area_topdown.get_unmapped_area.check_brk_limits.=
__do_sys_brk.do_syscall_64
> >        0.63 =C2=B1  2%      +0.6        1.18        perf-profile.calltr=
ace.cycles-pp.get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64=
.entry_SYSCALL_64_after_hwframe
> >        0.00            +0.6        0.56 =C2=B1  3%  perf-profile.calltr=
ace.cycles-pp.kmem_cache_free.mas_destroy.mas_store_prealloc.do_brk_flags._=
_do_sys_brk
> >        6.03 =C2=B1  2%      +0.6        6.62 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.__unfreeze_partials.rcu_do_batch.rcu_core.__do_softirq.r=
un_ksoftirqd
> >        0.71 =C2=B1  2%      +0.6        1.31 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL=
_64_after_hwframe.brk
> >        0.00            +0.6        0.63 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.mas_update_gap.mas_wr_slot_store.mas_wr_store_entry.mas_store=
_prealloc.do_brk_flags
> >        0.73 =C2=B1  2%      +0.6        1.36        perf-profile.calltr=
ace.cycles-pp.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_=
after_hwframe.brk
> >        0.00            +0.7        0.68        perf-profile.calltrace.c=
ycles-pp.obj_cgroup_charge.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_=
align_munmap
> >        0.00            +0.7        0.69        perf-profile.calltrace.c=
ycles-pp.___slab_alloc.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.do_=
brk_flags
> >        0.74 =C2=B1  2%      +0.7        1.46        perf-profile.calltr=
ace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi=
_align_munmap
> >        0.00            +0.7        0.72        perf-profile.calltrace.c=
ycles-pp.___slab_alloc.kmem_cache_alloc.mas_alloc_nodes.mas_wr_node_store.m=
as_wr_store_entry
> >        0.00            +0.7        0.72        perf-profile.calltrace.c=
ycles-pp.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.__split_vma.do_vm=
i_align_munmap
> >        0.00            +0.7        0.74        perf-profile.calltrace.c=
ycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc.vm_area_dup.__split_v=
ma
> >        0.72            +0.7        1.46        perf-profile.calltrace.c=
ycles-pp.memcg_slab_post_alloc_hook.kmem_cache_alloc.vm_area_dup.__split_vm=
a.do_vmi_align_munmap
> >        0.00            +0.8        0.76        perf-profile.calltrace.c=
ycles-pp.userfaultfd_unmap_complete.__do_sys_brk.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe.brk
> >        0.00            +0.8        0.78        perf-profile.calltrace.c=
ycles-pp.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe.brk
> >        0.00            +0.8        0.80 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.__do_sys_brk.d=
o_syscall_64
> >        1.00 =C2=B1  5%      +0.9        1.89 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.as=
m_sysvec_apic_timer_interrupt.brk
> >        1.00 =C2=B1  5%      +0.9        1.89 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic=
_timer_interrupt.brk
> >        0.00            +0.9        0.89        perf-profile.calltrace.c=
ycles-pp.mas_wr_slot_store.mas_wr_store_entry.mas_store_prealloc.do_brk_fla=
gs.__do_sys_brk
> >        1.03 =C2=B1  5%      +0.9        1.94 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interr=
upt.brk
> >        0.56            +0.9        1.48        perf-profile.calltrace.c=
ycles-pp.kmem_cache_alloc.mas_alloc_nodes.mas_preallocate.do_brk_flags.__do=
_sys_brk
> >        1.04 =C2=B1  4%      +0.9        1.96 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.brk
> >        0.00            +1.0        0.98        perf-profile.calltrace.c=
ycles-pp.___slab_alloc.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_alig=
n_munmap
> >        0.25 =C2=B1100%      +1.0        1.24 =C2=B1  2%  perf-profile.c=
alltrace.cycles-pp.mtree_range_walk.mas_walk.mas_find.__do_sys_brk.do_sysca=
ll_64
> >        0.75            +1.0        1.74        perf-profile.calltrace.c=
ycles-pp.mas_walk.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe
> >        0.55            +1.0        1.57 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.__call_rcu_common.do_vmi_align_munmap.__do_sys_brk.do_syscall=
_64.entry_SYSCALL_64_after_hwframe
> >        1.13 =C2=B1  2%      +1.1        2.18        perf-profile.calltr=
ace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.=
perf_event_mmap.do_brk_flags
> >        0.95            +1.1        2.03        perf-profile.calltrace.c=
ycles-pp.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe=
.brk
> >        1.30 =C2=B1  2%      +1.2        2.49        perf-profile.calltr=
ace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.=
__do_sys_brk
> >        0.00            +1.3        1.28        perf-profile.calltrace.c=
ycles-pp.kmem_cache_alloc.mas_alloc_nodes.mas_wr_node_store.mas_wr_store_en=
try.mas_store_gfp
> >        1.50            +1.4        2.90        perf-profile.calltrace.c=
ycles-pp.__entry_text_start.brk
> >        1.62            +1.5        3.08        perf-profile.calltrace.c=
ycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags=
.__do_sys_brk
> >        1.78            +1.5        3.28        perf-profile.calltrace.c=
ycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.__do_sys_brk.do_syscal=
l_64
> >        0.00            +1.5        1.52 =C2=B1  2%  perf-profile.calltr=
ace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_wr_store_entry.mas_st=
ore_gfp.do_vmi_align_munmap
> >        0.00            +1.5        1.52        perf-profile.calltrace.c=
ycles-pp.mas_alloc_nodes.mas_wr_node_store.mas_wr_store_entry.mas_store_gfp=
.do_vmi_align_munmap
> >        0.00            +1.5        1.53        perf-profile.calltrace.c=
ycles-pp.__call_rcu_common.mas_wr_node_store.mas_wr_store_entry.mas_store_p=
realloc.vma_complete
> >        0.00            +1.7        1.74        perf-profile.calltrace.c=
ycles-pp.mas_wr_store_entry.mas_store_prealloc.do_brk_flags.__do_sys_brk.do=
_syscall_64
> >        0.00            +1.9        1.90        perf-profile.calltrace.c=
ycles-pp.entry_SYSCALL_64_safe_stack.brk
> >        2.35            +2.2        4.51        perf-profile.calltrace.c=
ycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do=
_syscall_64
> >        2.30            +2.4        4.65        perf-profile.calltrace.c=
ycles-pp.kmem_cache_alloc.vm_area_dup.__split_vma.do_vmi_align_munmap.__do_=
sys_brk
> >        2.62            +2.5        5.10        perf-profile.calltrace.c=
ycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
> >        3.12            +2.6        5.70        perf-profile.calltrace.c=
ycles-pp.unmap_region.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_=
SYSCALL_64_after_hwframe
> >        2.74            +2.8        5.53        perf-profile.calltrace.c=
ycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.__do_sys_brk.do_syscal=
l_64
> >        4.28 =C2=B1  3%      +2.9        7.16 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_pag=
e_commit.free_unref_page.__unfreeze_partials
> >        4.38 =C2=B1  3%      +2.9        7.31 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_pag=
e.__unfreeze_partials.rcu_do_batch
> >        4.41 =C2=B1  3%      +2.9        7.35 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.free_unref_page_commit.free_unref_page.__unfreeze_partia=
ls.rcu_do_batch.rcu_core
> >        4.43 =C2=B1  3%      +3.0        7.38 =C2=B1  4%  perf-profile.c=
alltrace.cycles-pp.free_unref_page.__unfreeze_partials.rcu_do_batch.rcu_cor=
e.__do_softirq
> >        3.44            +3.5        6.99        perf-profile.calltrace.c=
ycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame.brk
> >        3.91            +3.8        7.74        perf-profile.calltrace.c=
ycles-pp.syscall_return_via_sysret.brk
> >        4.63            +4.3        8.91        perf-profile.calltrace.c=
ycles-pp.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry=
_SYSCALL_64_after_hwframe
> >       83.68            +4.7       88.36        perf-profile.calltrace.c=
ycles-pp.brk
> >        0.00            +4.8        4.76        perf-profile.calltrace.c=
ycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_comple=
te.__split_vma
> >        0.00            +5.5        5.54        perf-profile.calltrace.c=
ycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_=
vmi_align_munmap
> >       32.01            +6.3       38.28        perf-profile.calltrace.c=
ycles-pp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe.brk
> >        0.00            +6.4        6.35        perf-profile.calltrace.c=
ycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_gfp.do_vmi_align_mu=
nmap.__do_sys_brk
> >        0.82            +6.7        7.53        perf-profile.calltrace.c=
ycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk.=
do_syscall_64
> >       29.25           -20.1        9.14        perf-profile.children.cy=
cles-pp.mas_store_prealloc
> >       33.60           -18.9       14.67        perf-profile.children.cy=
cles-pp.do_brk_flags
> >       27.84           -17.3       10.50 =C2=B1  2%  perf-profile.childr=
en.cycles-pp._raw_spin_lock_irqsave
> >       27.53           -17.1       10.38 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.native_queued_spin_lock_slowpath
> >       13.75           -13.7        0.00        perf-profile.children.cy=
cles-pp.mas_wr_bnode
> >       13.22           -13.2        0.00        perf-profile.children.cy=
cles-pp.kmem_cache_alloc_bulk
> >       12.52           -12.5        0.00        perf-profile.children.cy=
cles-pp.__kmem_cache_alloc_bulk
> >       15.06           -10.7        4.36        perf-profile.children.cy=
cles-pp.mas_alloc_nodes
> >       15.78           -10.5        5.29        perf-profile.children.cy=
cles-pp.mas_preallocate
> >       10.28           -10.3        0.00        perf-profile.children.cy=
cles-pp.mas_wr_spanning_store
> >       12.34            -9.9        2.40        perf-profile.children.cy=
cles-pp.___slab_alloc
> >        9.30            -9.2        0.09 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.get_partial_node
> >       69.68            -9.1       60.59        perf-profile.children.cy=
cles-pp.__do_sys_brk
> >        8.99            -9.0        0.00        perf-profile.children.cy=
cles-pp.mas_split
> >       27.56            -8.0       19.53        perf-profile.children.cy=
cles-pp.rcu_do_batch
> >       27.59            -8.0       19.56        perf-profile.children.cy=
cles-pp.__do_softirq
> >       27.58            -8.0       19.55        perf-profile.children.cy=
cles-pp.rcu_core
> >        7.37            -7.4        0.00        perf-profile.children.cy=
cles-pp.mas_spanning_rebalance
> >        7.54            -6.5        1.02        perf-profile.children.cy=
cles-pp.mas_destroy
> >        5.92            -5.9        0.00        perf-profile.children.cy=
cles-pp.mas_topiary_replace
> >       12.39            -5.8        6.61        perf-profile.children.cy=
cles-pp.vma_complete
> >       15.46            -5.0       10.49 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.smpboot_thread_fn
> >       15.44            -5.0       10.48 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.run_ksoftirqd
> >       15.47            -5.0       10.50 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.ret_from_fork_asm
> >       15.47            -5.0       10.50 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.ret_from_fork
> >       15.47            -5.0       10.50 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.kthread
> >        8.32            -4.6        3.78 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.__slab_free
> >       74.27            -4.5       69.76        perf-profile.children.cy=
cles-pp.do_syscall_64
> >       15.32            -4.2       11.08 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.__unfreeze_partials
> >       20.53            -3.3       17.27        perf-profile.children.cy=
cles-pp.__split_vma
> >       12.15 =C2=B1  2%      -3.1        9.09 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.irq_exit_rcu
> >       12.47 =C2=B1  2%      -3.0        9.42 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.sysvec_apic_timer_interrupt
> >       12.50 =C2=B1  2%      -3.0        9.46 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.asm_sysvec_apic_timer_interrupt
> >       76.50            -2.3       74.18        perf-profile.children.cy=
cles-pp.entry_SYSCALL_64_after_hwframe
> >        1.91 =C2=B1  4%      -1.8        0.16 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.get_any_partial
> >        1.09            -0.9        0.14 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.memcpy_orig
> >        1.72            -0.7        1.05        perf-profile.children.cy=
cles-pp.mas_pop_node
> >        1.14            -0.2        0.98 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.mas_prev_slot
> >        1.71 =C2=B1  2%      -0.1        1.57 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.rcu_cblist_dequeue
> >        1.10            -0.1        0.98        perf-profile.children.cy=
cles-pp.mas_next_slot
> >        0.32 =C2=B1  2%      -0.1        0.22 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.inc_slabs_node
> >        0.60 =C2=B1  2%      -0.1        0.52        perf-profile.childr=
en.cycles-pp.rcu_segcblist_enqueue
> >        0.48 =C2=B1  2%      -0.1        0.40 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.rcu_nocb_try_bypass
> >        0.47 =C2=B1  2%      -0.1        0.40        perf-profile.childr=
en.cycles-pp.alloc_pages_mpol
> >        0.38 =C2=B1  3%      -0.1        0.31 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.get_page_from_freelist
> >        0.18 =C2=B1  2%      -0.1        0.11        perf-profile.childr=
en.cycles-pp.__list_del_entry_valid_or_report
> >        0.44 =C2=B1  3%      -0.1        0.37        perf-profile.childr=
en.cycles-pp.__alloc_pages
> >        0.27 =C2=B1  2%      -0.1        0.22 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.mt_free_rcu
> >        0.25 =C2=B1  3%      -0.1        0.20 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.rmqueue
> >        0.20 =C2=B1  6%      -0.0        0.16 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.__rmqueue_pcplist
> >        0.15 =C2=B1  3%      -0.0        0.11 =C2=B1  5%  perf-profile.c=
hildren.cycles-pp.discard_slab
> >        0.16 =C2=B1  4%      -0.0        0.12 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.rmqueue_bulk
> >        0.08 =C2=B1  5%      -0.0        0.06        perf-profile.childr=
en.cycles-pp.__list_add_valid_or_report
> >        0.24 =C2=B1  2%      -0.0        0.22 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.__free_one_page
> >        0.19 =C2=B1  2%      +0.0        0.21 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.update_process_times
> >        0.44 =C2=B1  2%      +0.0        0.46 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.setup_object
> >        1.00            +0.0        1.03        perf-profile.children.cy=
cles-pp.shuffle_freelist
> >        0.20 =C2=B1  3%      +0.0        0.24 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.should_failslab
> >        0.09 =C2=B1  4%      +0.0        0.14 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.strlen
> >        0.06            +0.0        0.11 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.__kmalloc_node
> >        0.06 =C2=B1  8%      +0.0        0.10 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.__init_rwsem
> >        0.05            +0.0        0.10 =C2=B1  3%  perf-profile.childr=
en.cycles-pp.__kmem_cache_alloc_node
> >        0.00            +0.1        0.05        perf-profile.children.cy=
cles-pp.memcg_account_kmem
> >        0.00            +0.1        0.05        perf-profile.children.cy=
cles-pp.testcase
> >        0.06            +0.1        0.11 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.memcg_alloc_slab_cgroups
> >        0.05 =C2=B1  7%      +0.1        0.10 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.__pte_offset_map
> >        0.00            +0.1        0.05 =C2=B1  8%  perf-profile.childr=
en.cycles-pp.flush_tlb_batched_pending
> >        0.00            +0.1        0.06 =C2=B1  8%  perf-profile.childr=
en.cycles-pp.__free_slab
> >        0.02 =C2=B1141%      +0.1        0.08 =C2=B1 18%  perf-profile.c=
hildren.cycles-pp.machine__process_mmap2_event
> >        0.07 =C2=B1 13%      +0.1        0.13 =C2=B1  5%  perf-profile.c=
hildren.cycles-pp.may_expand_vm
> >        0.05 =C2=B1 50%      +0.1        0.11 =C2=B1 18%  perf-profile.c=
hildren.cycles-pp.perf_session__process_user_event
> >        0.05 =C2=B1 50%      +0.1        0.11 =C2=B1 18%  perf-profile.c=
hildren.cycles-pp.__ordered_events__flush
> >        0.00            +0.1        0.06 =C2=B1  6%  perf-profile.childr=
en.cycles-pp.memset_orig
> >        0.12 =C2=B1  3%      +0.1        0.18 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.anon_vma_clone
> >        0.08 =C2=B1  4%      +0.1        0.14 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.vma_dup_policy
> >        0.07 =C2=B1  6%      +0.1        0.14 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.free_pgd_range
> >        0.03 =C2=B1100%      +0.1        0.10 =C2=B1 20%  perf-profile.c=
hildren.cycles-pp.perf_session__deliver_event
> >        0.00            +0.1        0.06 =C2=B1  7%  perf-profile.childr=
en.cycles-pp.mas_prev
> >        0.11 =C2=B1  3%      +0.1        0.18 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.mas_node_count_gfp
> >        0.01 =C2=B1223%      +0.1        0.08        perf-profile.childr=
en.cycles-pp.tlb_batch_pages_flush
> >        0.11 =C2=B1  6%      +0.1        0.18 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.unmap_single_vma
> >        1.17            +0.1        1.24 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.mtree_range_walk
> >        0.09 =C2=B1  5%      +0.1        0.17 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.up_read
> >        0.02 =C2=B1141%      +0.1        0.10 =C2=B1  6%  perf-profile.c=
hildren.cycles-pp.vma_prepare
> >        0.06 =C2=B1  6%      +0.1        0.14 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.can_vma_merge_after
> >        0.10 =C2=B1 10%      +0.1        0.19 =C2=B1  6%  perf-profile.c=
hildren.cycles-pp.kfree
> >        0.08 =C2=B1  6%      +0.1        0.16 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.strnlen
> >        0.10 =C2=B1  4%      +0.1        0.20 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.lru_add_drain_cpu
> >        0.18 =C2=B1  2%      +0.1        0.27        perf-profile.childr=
en.cycles-pp.tlb_gather_mmu
> >        0.09            +0.1        0.19 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.refill_obj_stock
> >        0.00            +0.1        0.10 =C2=B1  4%  perf-profile.childr=
en.cycles-pp.mlock_drain_local
> >        0.10 =C2=B1  5%      +0.1        0.20 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.unlink_anon_vmas
> >        0.11 =C2=B1  4%      +0.1        0.21 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.khugepaged_enter_vma
> >        0.10 =C2=B1  5%      +0.1        0.20        perf-profile.childr=
en.cycles-pp.current_obj_cgroup
> >        0.10 =C2=B1  6%      +0.1        0.20 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.syscall_exit_to_user_mode_prepare
> >        0.12 =C2=B1  5%      +0.1        0.23 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp._raw_spin_lock
> >        0.14 =C2=B1  4%      +0.1        0.26        perf-profile.childr=
en.cycles-pp.cap_mmap_addr
> >        0.15 =C2=B1  6%      +0.1        0.27        perf-profile.childr=
en.cycles-pp.exit_to_user_mode_prepare
> >        0.10 =C2=B1  3%      +0.1        0.23        perf-profile.childr=
en.cycles-pp.downgrade_write
> >        0.14 =C2=B1  3%      +0.1        0.28        perf-profile.childr=
en.cycles-pp.remove_vma
> >        2.56            +0.1        2.70        perf-profile.children.cy=
cles-pp.kmem_cache_free
> >        0.00            +0.1        0.14 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.mas_is_err
> >        0.14 =C2=B1  3%      +0.1        0.28        perf-profile.childr=
en.cycles-pp.lru_add_drain
> >        0.08 =C2=B1  5%      +0.1        0.22 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.__vm_enough_memory
> >        0.15 =C2=B1  3%      +0.1        0.30 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.__x64_sys_brk
> >        0.15 =C2=B1  3%      +0.1        0.30 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.vma_adjust_trans_huge
> >        0.22 =C2=B1  2%      +0.2        0.38 =C2=B1  3%  perf-profile.c=
hildren.cycles-pp.rcu_all_qs
> >        0.06            +0.2        0.24 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.mas_prev_range
> >        0.16 =C2=B1  4%      +0.2        0.35        perf-profile.childr=
en.cycles-pp.mas_wr_store_setup
> >        0.24 =C2=B1  3%      +0.2        0.42        perf-profile.childr=
en.cycles-pp.tlb_finish_mmu
> >        0.22 =C2=B1  3%      +0.2        0.41        perf-profile.childr=
en.cycles-pp.security_mmap_addr
> >        0.20 =C2=B1  3%      +0.2        0.39 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.cap_vm_enough_memory
> >        0.17 =C2=B1  5%      +0.2        0.36 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.percpu_counter_add_batch
> >        0.14 =C2=B1  6%      +0.2        0.34 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.strscpy
> >        0.01 =C2=B1223%      +0.2        0.24        perf-profile.childr=
en.cycles-pp.mas_wr_append
> >        0.19 =C2=B1  4%      +0.2        0.43 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.mas_nomem
> >        0.25            +0.2        0.50 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.security_vm_enough_memory_mm
> >        0.26            +0.3        0.51 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.entry_SYSRETQ_unsafe_stack
> >        0.27 =C2=B1  2%      +0.3        0.53 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.__pte_offset_map_lock
> >        0.27 =C2=B1  2%      +0.3        0.56        perf-profile.childr=
en.cycles-pp.arch_get_unmapped_area_topdown
> >        0.35 =C2=B1  2%      +0.3        0.68        perf-profile.childr=
en.cycles-pp.obj_cgroup_charge
> >        0.36 =C2=B1  2%      +0.4        0.72 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.mod_objcg_state
> >        0.39 =C2=B1  3%      +0.4        0.78        perf-profile.childr=
en.cycles-pp.up_write
> >        0.44 =C2=B1  2%      +0.4        0.85 =C2=B1  2%  perf-profile.c=
hildren.cycles-pp.free_pgtables
> >        0.35            +0.4        0.77        perf-profile.children.cy=
cles-pp.userfaultfd_unmap_complete
> >        0.38 =C2=B1  2%      +0.4        0.81        perf-profile.childr=
en.cycles-pp.down_write_killable
> >        0.56            +0.4        1.01 =C2=B1  2%  perf-profile.childr=
en.cycles-pp.down_write
> >        0.53 =C2=B1  2%      +0.5        1.00        perf-profile.childr=
en.cycles-pp.zap_pte_range
> >        0.31 =C2=B1  2%      +0.5        0.82        perf-profile.childr=
en.cycles-pp.mas_wr_end_piv
> >        0.56            +0.5        1.10        perf-profile.children.cy=
cles-pp.mas_leaf_max_gap
> >        0.89            +0.6        1.45        perf-profile.children.cy=
cles-pp.__cond_resched
> >        0.64 =C2=B1  2%      +0.6        1.20        perf-profile.childr=
en.cycles-pp.get_unmapped_area
> >        0.72 =C2=B1  2%      +0.6        1.32 =C2=B1  4%  perf-profile.c=
hildren.cycles-pp.syscall_enter_from_user_mode
> >        0.48 =C2=B1  2%      +0.6        1.08        perf-profile.childr=
en.cycles-pp.entry_SYSCALL_64_safe_stack
> >        0.73 =C2=B1  2%      +0.6        1.37        perf-profile.childr=
en.cycles-pp.check_brk_limits
> >        0.77 =C2=B1  2%      +0.7        1.50        perf-profile.childr=
en.cycles-pp.zap_pmd_range
> >        0.94            +0.8        1.77        perf-profile.children.cy=
cles-pp.memcg_slab_post_alloc_hook
> >        0.68            +0.8        1.52        perf-profile.children.cy=
cles-pp.mas_wr_walk
> >        0.00            +0.9        0.90        perf-profile.children.cy=
cles-pp.mas_wr_slot_store
> >        1.22            +0.9        2.17        perf-profile.children.cy=
cles-pp.vm_area_free_rcu_cb
> >        1.14 =C2=B1  2%      +1.1        2.20        perf-profile.childr=
en.cycles-pp.perf_event_mmap_output
> >        0.91            +1.1        2.02        perf-profile.children.cy=
cles-pp.mas_walk
> >        1.32            +1.2        2.54        perf-profile.children.cy=
cles-pp.unmap_page_range
> >        3.44            +1.3        4.69        perf-profile.children.cy=
cles-pp.__call_rcu_common
> >        0.33 =C2=B1  4%      +1.4        1.74        perf-profile.childr=
en.cycles-pp.mas_update_gap
> >        1.63            +1.5        3.10        perf-profile.children.cy=
cles-pp.perf_iterate_sb
> >        1.79            +1.5        3.30        perf-profile.children.cy=
cles-pp.unmap_vmas
> >        1.60            +1.6        3.19        perf-profile.children.cy=
cles-pp.mas_find
> >        1.85            +1.9        3.73        perf-profile.children.cy=
cles-pp.__entry_text_start
> >        2.39            +2.2        4.60        perf-profile.children.cy=
cles-pp.perf_event_mmap_event
> >        2.62            +2.5        5.12        perf-profile.children.cy=
cles-pp.perf_event_mmap
> >        3.15            +2.6        5.79        perf-profile.children.cy=
cles-pp.unmap_region
> >        2.75            +2.8        5.55        perf-profile.children.cy=
cles-pp.vm_area_dup
> >        3.46            +3.6        7.04        perf-profile.children.cy=
cles-pp.syscall_exit_to_user_mode
> >        3.94            +3.9        7.80        perf-profile.children.cy=
cles-pp.syscall_return_via_sysret
> >        4.68            +4.3        9.03        perf-profile.children.cy=
cles-pp.mas_store_gfp
> >        3.74            +4.7        8.40        perf-profile.children.cy=
cles-pp.kmem_cache_alloc
> >       83.90            +4.9       88.80        perf-profile.children.cy=
cles-pp.brk
> >       32.12            +6.4       38.51        perf-profile.children.cy=
cles-pp.do_vmi_align_munmap
> >        0.24 =C2=B1  2%     +11.0       11.20        perf-profile.childr=
en.cycles-pp.mas_wr_node_store
> >        1.38           +13.6       14.95        perf-profile.children.cy=
cles-pp.mas_wr_store_entry
> >       27.53           -17.1       10.38 =C2=B1  2%  perf-profile.self.c=
ycles-pp.native_queued_spin_lock_slowpath
> >        4.60            -0.8        3.76 =C2=B1  2%  perf-profile.self.c=
ycles-pp.__slab_free
> >        0.94            -0.8        0.12 =C2=B1  4%  perf-profile.self.c=
ycles-pp.memcpy_orig
> >        1.52            -0.6        0.94        perf-profile.self.cycles=
-pp.mas_pop_node
> >        0.79            -0.5        0.30        perf-profile.self.cycles=
-pp.___slab_alloc
> >        0.31            -0.2        0.12 =C2=B1  3%  perf-profile.self.c=
ycles-pp._raw_spin_lock_irqsave
> >        0.28 =C2=B1  3%      -0.2        0.09 =C2=B1  5%  perf-profile.s=
elf.cycles-pp.__unfreeze_partials
> >        1.68 =C2=B1  2%      -0.1        1.55 =C2=B1  5%  perf-profile.s=
elf.cycles-pp.rcu_cblist_dequeue
> >        2.14            -0.1        2.02        perf-profile.self.cycles=
-pp.kmem_cache_free
> >        0.37 =C2=B1  2%      -0.1        0.28        perf-profile.self.c=
ycles-pp.rcu_nocb_try_bypass
> >        0.30 =C2=B1  2%      -0.1        0.22 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.inc_slabs_node
> >        0.52 =C2=B1  2%      -0.1        0.46 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.rcu_segcblist_enqueue
> >        0.17 =C2=B1  2%      -0.1        0.10 =C2=B1  4%  perf-profile.s=
elf.cycles-pp.__list_del_entry_valid_or_report
> >        0.26            -0.0        0.21 =C2=B1  4%  perf-profile.self.c=
ycles-pp.mt_free_rcu
> >        0.15 =C2=B1  3%      -0.0        0.11 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.discard_slab
> >        0.17 =C2=B1  2%      -0.0        0.14 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.get_any_partial
> >        0.08 =C2=B1  5%      -0.0        0.06        perf-profile.self.c=
ycles-pp.__list_add_valid_or_report
> >        0.15 =C2=B1  3%      -0.0        0.13 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.__free_one_page
> >        0.10 =C2=B1  3%      +0.0        0.12 =C2=B1  4%  perf-profile.s=
elf.cycles-pp.rcu_segcblist_pend_cbs
> >        0.08 =C2=B1 10%      +0.0        0.10 =C2=B1  4%  perf-profile.s=
elf.cycles-pp.should_failslab
> >        0.08            +0.0        0.12 =C2=B1  3%  perf-profile.self.c=
ycles-pp.strlen
> >        0.06            +0.0        0.10 =C2=B1  6%  perf-profile.self.c=
ycles-pp.vma_dup_policy
> >        0.08            +0.0        0.12 =C2=B1  3%  perf-profile.self.c=
ycles-pp.anon_vma_clone
> >        0.06 =C2=B1  9%      +0.0        0.10 =C2=B1  6%  perf-profile.s=
elf.cycles-pp.may_expand_vm
> >        0.00            +0.1        0.05        perf-profile.self.cycles=
-pp.mas_prev
> >        0.03 =C2=B1 70%      +0.1        0.08 =C2=B1  5%  perf-profile.s=
elf.cycles-pp.__init_rwsem
> >        0.09 =C2=B1  8%      +0.1        0.14 =C2=B1  4%  perf-profile.s=
elf.cycles-pp.kfree
> >        0.00            +0.1        0.06 =C2=B1  6%  perf-profile.self.c=
ycles-pp.__vm_enough_memory
> >        0.07 =C2=B1  6%      +0.1        0.13 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.mas_node_count_gfp
> >        0.03 =C2=B1 70%      +0.1        0.09 =C2=B1  7%  perf-profile.s=
elf.cycles-pp.security_vm_enough_memory_mm
> >        0.15 =C2=B1  3%      +0.1        0.21 =C2=B1 11%  perf-profile.s=
elf.cycles-pp.setup_object
> >        0.00            +0.1        0.06        perf-profile.self.cycles=
-pp.memset_orig
> >        0.07 =C2=B1  5%      +0.1        0.13 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.security_mmap_addr
> >        0.00            +0.1        0.06 =C2=B1  6%  perf-profile.self.c=
ycles-pp.tlb_batch_pages_flush
> >        0.06 =C2=B1  7%      +0.1        0.13 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.free_pgd_range
> >        0.08            +0.1        0.15 =C2=B1  2%  perf-profile.self.c=
ycles-pp.check_brk_limits
> >        0.08 =C2=B1  6%      +0.1        0.14 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.khugepaged_enter_vma
> >        0.09 =C2=B1  4%      +0.1        0.17 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.unmap_single_vma
> >        0.00            +0.1        0.08 =C2=B1  6%  perf-profile.self.c=
ycles-pp.vma_prepare
> >        0.07 =C2=B1  5%      +0.1        0.15 =C2=B1  4%  perf-profile.s=
elf.cycles-pp.up_read
> >        0.06 =C2=B1  7%      +0.1        0.14 =C2=B1  5%  perf-profile.s=
elf.cycles-pp.strnlen
> >        0.16 =C2=B1  2%      +0.1        0.24        perf-profile.self.c=
ycles-pp.tlb_gather_mmu
> >        0.07            +0.1        0.15 =C2=B1  3%  perf-profile.self.c=
ycles-pp.unlink_anon_vmas
> >        0.09 =C2=B1  6%      +0.1        0.17        perf-profile.self.c=
ycles-pp.lru_add_drain_cpu
> >        0.00            +0.1        0.08        perf-profile.self.cycles=
-pp.mlock_drain_local
> >        0.04 =C2=B1 44%      +0.1        0.12 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.can_vma_merge_after
> >        0.14 =C2=B1  2%      +0.1        0.22 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.get_unmapped_area
> >        0.01 =C2=B1223%      +0.1        0.09 =C2=B1  5%  perf-profile.s=
elf.cycles-pp.__pte_offset_map
> >        0.06 =C2=B1  7%      +0.1        0.15 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.remove_vma
> >        0.08 =C2=B1  4%      +0.1        0.17 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.syscall_exit_to_user_mode_prepare
> >        0.09            +0.1        0.18 =C2=B1  3%  perf-profile.self.c=
ycles-pp.refill_obj_stock
> >        0.08 =C2=B1  4%      +0.1        0.17 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.current_obj_cgroup
> >        0.09 =C2=B1  4%      +0.1        0.18 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.__pte_offset_map_lock
> >        0.00            +0.1        0.10 =C2=B1  4%  perf-profile.self.c=
ycles-pp.mas_is_err
> >        0.09 =C2=B1  6%      +0.1        0.19 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.mas_nomem
> >        0.11 =C2=B1  4%      +0.1        0.21 =C2=B1  4%  perf-profile.s=
elf.cycles-pp._raw_spin_lock
> >        0.24 =C2=B1  2%      +0.1        0.35        perf-profile.self.c=
ycles-pp.mas_destroy
> >        0.12 =C2=B1  3%      +0.1        0.23 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.cap_mmap_addr
> >        1.02            +0.1        1.13        perf-profile.self.cycles=
-pp.mtree_range_walk
> >        0.15 =C2=B1  4%      +0.1        0.26 =C2=B1  4%  perf-profile.s=
elf.cycles-pp.rcu_all_qs
> >        0.12 =C2=B1  6%      +0.1        0.22 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.exit_to_user_mode_prepare
> >        0.09            +0.1        0.20 =C2=B1  2%  perf-profile.self.c=
ycles-pp.downgrade_write
> >        0.13            +0.1        0.25 =C2=B1  2%  perf-profile.self.c=
ycles-pp.__x64_sys_brk
> >        0.22 =C2=B1  2%      +0.1        0.34 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.unmap_vmas
> >        0.13 =C2=B1  3%      +0.1        0.26 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.vma_adjust_trans_huge
> >        0.12 =C2=B1  4%      +0.1        0.25 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.entry_SYSCALL_64_safe_stack
> >        0.16 =C2=B1  3%      +0.1        0.30        perf-profile.self.c=
ycles-pp.tlb_finish_mmu
> >        0.12 =C2=B1  4%      +0.1        0.26 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.mas_wr_store_setup
> >        0.14 =C2=B1  4%      +0.2        0.29 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.syscall_enter_from_user_mode
> >        0.14 =C2=B1  2%      +0.2        0.31        perf-profile.self.c=
ycles-pp.free_pgtables
> >        0.12 =C2=B1  4%      +0.2        0.28        perf-profile.self.c=
ycles-pp.strscpy
> >        0.00            +0.2        0.17 =C2=B1  4%  perf-profile.self.c=
ycles-pp.mas_prev_range
> >        0.14 =C2=B1  4%      +0.2        0.31 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.percpu_counter_add_batch
> >        0.18 =C2=B1  2%      +0.2        0.35        perf-profile.self.c=
ycles-pp.cap_vm_enough_memory
> >        0.18 =C2=B1  3%      +0.2        0.36 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.zap_pte_range
> >        0.15 =C2=B1  3%      +0.2        0.33 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.zap_pmd_range
> >        0.27            +0.2        0.47        perf-profile.self.cycles=
-pp.unmap_region
> >        0.00            +0.2        0.20 =C2=B1  2%  perf-profile.self.c=
ycles-pp.mas_wr_append
> >        0.00            +0.2        0.20 =C2=B1  3%  perf-profile.self.c=
ycles-pp.mas_wr_slot_store
> >        0.18 =C2=B1  2%      +0.2        0.39        perf-profile.self.c=
ycles-pp.vma_complete
> >        0.34 =C2=B1  5%      +0.2        0.55 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.vm_area_free_rcu_cb
> >        0.22 =C2=B1  2%      +0.2        0.44 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.entry_SYSRETQ_unsafe_stack
> >        0.45 =C2=B1  2%      +0.2        0.68        perf-profile.self.c=
ycles-pp.mas_alloc_nodes
> >        0.20 =C2=B1  2%      +0.2        0.43 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.down_write_killable
> >        0.20 =C2=B1  3%      +0.2        0.44        perf-profile.self.c=
ycles-pp.perf_event_mmap
> >        0.18 =C2=B1  3%      +0.2        0.42 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.do_syscall_64
> >        0.24            +0.3        0.49        perf-profile.self.cycles=
-pp.arch_get_unmapped_area_topdown
> >        0.27 =C2=B1  3%      +0.3        0.54        perf-profile.self.c=
ycles-pp.obj_cgroup_charge
> >        0.36 =C2=B1  2%      +0.3        0.66 =C2=B1  3%  perf-profile.s=
elf.cycles-pp.down_write
> >        0.30 =C2=B1  2%      +0.3        0.62        perf-profile.self.c=
ycles-pp.vm_area_dup
> >        0.32 =C2=B1  2%      +0.3        0.64 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.mod_objcg_state
> >        0.35            +0.3        0.68        perf-profile.self.cycles=
-pp.mas_walk
> >        0.34 =C2=B1  2%      +0.3        0.68        perf-profile.self.c=
ycles-pp.perf_event_mmap_event
> >        0.33 =C2=B1  2%      +0.4        0.68        perf-profile.self.c=
ycles-pp.up_write
> >        0.44 =C2=B1  2%      +0.4        0.80        perf-profile.self.c=
ycles-pp.perf_iterate_sb
> >        0.58            +0.4        0.94 =C2=B1  2%  perf-profile.self.c=
ycles-pp.__cond_resched
> >        0.30 =C2=B1  2%      +0.4        0.68        perf-profile.self.c=
ycles-pp.userfaultfd_unmap_complete
> >        0.51            +0.4        0.88        perf-profile.self.cycles=
-pp.mas_next_slot
> >        0.44 =C2=B1  2%      +0.4        0.82        perf-profile.self.c=
ycles-pp.unmap_page_range
> >        0.58            +0.4        0.96        perf-profile.self.cycles=
-pp.mas_find
> >        0.26            +0.4        0.68        perf-profile.self.cycles=
-pp.mas_wr_end_piv
> >        0.48 =C2=B1  2%      +0.4        0.90        perf-profile.self.c=
ycles-pp.brk
> >        0.45            +0.4        0.88        perf-profile.self.cycles=
-pp.mas_prev_slot
> >        0.49            +0.4        0.94        perf-profile.self.cycles=
-pp.mas_leaf_max_gap
> >        0.34 =C2=B1  2%      +0.4        0.78        perf-profile.self.c=
ycles-pp.mas_store_prealloc
> >        0.20 =C2=B1  3%      +0.4        0.65 =C2=B1  2%  perf-profile.s=
elf.cycles-pp.mas_update_gap
> >        0.41 =C2=B1  2%      +0.5        0.92        perf-profile.self.c=
ycles-pp.mas_store_gfp
> >        0.64            +0.6        1.23        perf-profile.self.cycles=
-pp.memcg_slab_post_alloc_hook
> >        0.59 =C2=B1  2%      +0.6        1.22        perf-profile.self.c=
ycles-pp.__split_vma
> >        0.44 =C2=B1  2%      +0.7        1.10        perf-profile.self.c=
ycles-pp.mas_wr_store_entry
> >        0.66            +0.7        1.35        perf-profile.self.cycles=
-pp.mas_preallocate
> >        0.59            +0.7        1.33        perf-profile.self.cycles=
-pp.do_brk_flags
> >        0.58            +0.7        1.32        perf-profile.self.cycles=
-pp.mas_wr_walk
> >        1.03            +0.8        1.81        perf-profile.self.cycles=
-pp.do_vmi_align_munmap
> >        0.78            +0.8        1.57        perf-profile.self.cycles=
-pp.__do_sys_brk
> >        1.79            +0.9        2.66        perf-profile.self.cycles=
-pp.__call_rcu_common
> >        1.02            +1.0        1.98        perf-profile.self.cycles=
-pp.perf_event_mmap_output
> >        1.33            +1.4        2.74        perf-profile.self.cycles=
-pp.kmem_cache_alloc
> >        1.64            +1.7        3.30        perf-profile.self.cycles=
-pp.__entry_text_start
> >        2.26            +2.2        4.50        perf-profile.self.cycles=
-pp.entry_SYSCALL_64_after_hwframe
> >        3.23            +3.3        6.58        perf-profile.self.cycles=
-pp.syscall_exit_to_user_mode
> >        0.21 =C2=B1  2%      +3.6        3.82        perf-profile.self.c=
ycles-pp.mas_wr_node_store
> >        3.93            +3.9        7.78        perf-profile.self.cycles=
-pp.syscall_return_via_sysret
> >=20
> >=20
> >=20
> >=20
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are pr=
ovided
> > for informational purposes only. Any difference in system hardware or s=
oftware
> > design or configuration may affect actual performance.
> >=20
> >=20
