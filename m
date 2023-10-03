Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0BD7B7157
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbjJCSwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjJCSwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:52:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC209B;
        Tue,  3 Oct 2023 11:52:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4Nxc004034;
        Tue, 3 Oct 2023 18:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=ecCqijyMaKpwOBdMNLilTp8v9jSd37BhpURjlSon3gU=;
 b=GWbdw8RfUWRgG1VobCzPC1KAvMvXUlrXDrVhHeQYpbHP2UXJXsODDdaYYNG5/MRSVNcp
 KlEi5MzqKcp6uIvrCQ28Z9L7pJIN12e56bhHFDYkOdBS9l28+5zeUIJDJUiFcCwubPIt
 Db+dZ5mr9m5EZBCIIGRYu80ETPdsllpJ/s4/huqgbWeOBySPdREvbbjYOnlChZPxYdHr
 2XWy9U4bhwortbh4cRF0DVqZ8XhR7Gvs516qB9n8VoPDqXMpGkKQuyY90/+8q0AW9jnR
 734pSjf4daHpR3g29Ikd4a4XroxUqSVdu+ppFwitzLz4Vl+6v0bbQnuHIoOCQgZFs4W7 jQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9udfqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 18:51:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393ISI4e000352;
        Tue, 3 Oct 2023 18:51:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46dp22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 18:51:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTIHChKGKYu7HaDtAWZx6v+/GP8dptYTxMBC1mv+mDNBjnOIshNo/JJ06aDTN/sTgER9UXW8DZlSu/0xkIf61ziHoZDp6iZFK8A1iHHuMyPH0DFtMRsNrCppmpAYfD4S5HBspDs7z8zBVlOQx0OG6GPo4C5qJwJb4zIcyoAEfrCo+cxyYMZwwOgNf7oxANzhLc5VX6NDYUPwpDHPiHTJgu0+qjCL0HtlDY3+Um9826NE3U/kgb77lYdWlYrHVoFGhO4/tp9jhUloED/XNw1c4KBDBJ8WpceIEMVoYAkP9mzw3iVotJG3O5sk02ivEhoOjrQIGvBjYxgeN1SHWXiaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecCqijyMaKpwOBdMNLilTp8v9jSd37BhpURjlSon3gU=;
 b=fK5q/LbgjGTgZ0YQp5WXx6mgwuEDUFJWyLSzB4oI8gQ2ARfSO6cj20VyqlLZCQg6v6tTmsESFS8CgiKHEOGZGHrGxrAuN7eVCywaEJ8tdVHEh98QXIHD9LB880HQ8DdQa9kduzJ8OkAx0cOPIk/JJVGJYHbVNUDbTKs2OiK1W0vhjkshr4/cuy43NGB5teOwH3QayD8M+Dg6Dd2nyY5csfBCzizHux881/QvlbNfSlJDg14hdCEgcI7n4/M+0EGZWKpq5KInZJ87/mOUEhexh8cnjPrTCq7H6qSsI6jIpeyvVtlSDTqaMimPUoFs2Yvg1byOPgIrFl+z/CUpz3NEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecCqijyMaKpwOBdMNLilTp8v9jSd37BhpURjlSon3gU=;
 b=cBRqLG10awXRUNi8jFUAkQtdS7iOkx6zUij1l0K4OVeNnu5EtuyHz1WNBDG28JrTcQ+NyK2FqQu1c6nWN1YVeJOv1jUFWDOAuMUWk8Ei3cy5Rkwu4IitimvyizyKEnQtytan+L3xQLgprZbWKDQZ5pxquwSko7iqVmNGRnVXgTI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4126.namprd10.prod.outlook.com (2603:10b6:208:15f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 18:51:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 18:51:53 +0000
Date:   Tue, 3 Oct 2023 14:51:49 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mmap: Fix error paths with dup_anon_vma()
Message-ID: <20231003185149.brbzyu2ivn25tkeu@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-3-Liam.Howlett@oracle.com>
 <CAJuCfpFx3zxv1ZgkLh4dkafOCHvL_674cysJiuQPQhKXX9BuzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpFx3zxv1ZgkLh4dkafOCHvL_674cysJiuQPQhKXX9BuzQ@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0305.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN2PR10MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c51b98-5cee-4c96-f152-08dbc441cf32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n51+/43uVEJM/Lp2X61xTZmXWGWmwwo54N4UsZ8l7VGUmCvr424sLl3qbUBPGpuW85HbdD68WEbiLFgdogD/UdzXeCuVk4l7QDT8Svab7g9MMsjD2vG32vM+UaRXOaTCzAmqpwgsP891wnFK9pyEhPcdGGfnbxAosNhJ6UXc4ZmOXmw86rLavAaYpJGNq2c9+ZXM6AzpCulWbNMxXki89rHiqKaSKX6jE7tYDHxXjazFLPnKyfBW8OJOmN5fpRZg5LwiPf9B9Qy3q6MQRBFjHLVuc7/g4lIbD1l4v54UeytGUZlITLnKb2C94UXBCblafUG8Y6z9jBKIh7uudp/FnLDI4C1JfwY5L8rHyQDmDAakSQLc0u9VoRNjuBX1CMDbm4RZL7RPPvI7IZ0o39PyR4KJ4FuEUM7otUNtNFsq8gPK/7LbQQXQrqGaNAQD0fhdjwq/soFIMNebJetgnM6StWBRSbsd+t4S9Gv4PaYE5VdHEypTc/u8Legfk/uN4ZXH/l3mcYuD7oEYrFzZeqvKF0Cee/Ukjyn3ZS+Pxx6ym9pPvVHpj91Apxioz4/5D2f7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(83380400001)(86362001)(33716001)(38100700002)(53546011)(6916009)(316002)(54906003)(66946007)(66476007)(66556008)(6512007)(6506007)(9686003)(1076003)(41300700001)(6486002)(478600001)(6666004)(8676002)(4326008)(5660300002)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWVPZVVkR0RZYnJ6T2IySlJucDVpTUJBSkd3M3A2RG4wNDF0Q0Y4R2sxQjJj?=
 =?utf-8?B?ZlltODZtRTJWTnBYV1dOeThMK3g1K1dKVkt1M3I2bE1vWUZ4Z0t4c3kzeE5O?=
 =?utf-8?B?KzRnVExaalNYeVd3NnU4U1lOdG9zcTQyVWFOaFNWaENRL3A4eTZWQkt4MXkx?=
 =?utf-8?B?enZWT0dON0UwOHpWZ0xCRTUwNW81MGNWcGdJakZSUGgvNGo5aXgvdU1mK1NV?=
 =?utf-8?B?ZkhWMnFPaGhWei9tc2k1dlpSYzU4VFJGRzZIZ05xa2g5VUlMbEE2cURMOW54?=
 =?utf-8?B?UDgwRjZMQ0cvcjRibUNWQzg1NTJyTXhJMTZSVFJTMzN0ZkhMQjZTVStKMDhj?=
 =?utf-8?B?YlpTRnM5Z3QwMm5zODBUcTMrZEtFdWlnQU1MNXlGRWRxVThnbUthZGRYa3RY?=
 =?utf-8?B?SDVDczBCQnU4WFpNRzJDNmI4aW1BaDFjVEwxalhuUXVLZlNCQW1DUXY5Y21i?=
 =?utf-8?B?VWs0WWw1VThPZWV2dldkaGY0aDIvdlJ5NHpJTE1UQkJtOFVyY3pucVFaNm00?=
 =?utf-8?B?anB0SXNkN09wOWI4eTlkTDh3NnhuMGY5ODFuYzNTLzUwRVFoV0tFYW9WbXpm?=
 =?utf-8?B?VldmV0NuNGNXdDBGRUs4c0I1WkNMNURqNlBMTnJ4UGtKNnVCTXdjTHIvTys3?=
 =?utf-8?B?djJNcWdhYUwzalBOaEFtUEJNTXd1N1FJcDJlNzJDZWw2cmJ5ZGF5VzJ2MS9E?=
 =?utf-8?B?NjVNaWtCSm1xQUVpRk9qc0psNVNCTEd3SEs4UzJ3QTM4bVVjQ2ttQ3kzb2Fk?=
 =?utf-8?B?bUFzQStZdXE0bVlKNzZiK3RZMlIrUXpHTzA5NFR3d3Bpd2JQRmdPNnhDcnpF?=
 =?utf-8?B?MXN6YnI5Y0dlbnVTa0pQQm5NR2NnbU9qdXY0QVMyeGxLWTRqbFhVbXBUcWZB?=
 =?utf-8?B?RGlxdFVkeW81Q3lHeVRyTGcvTkRPbCsraG9MTUdTdnpXRGJaZUFBMnV5VmYr?=
 =?utf-8?B?Rklrc3BtR3FwZDFnVmNtMnRRakxDdmk4eW81WCtQV1pxcXhzVG9IOTFHOGdP?=
 =?utf-8?B?VlRrU2hwd2h3SHl4RUNxQ1VZSG0zR1NhNVBZbGV1UG9zejBkNmllb1RNSXBF?=
 =?utf-8?B?K21vTWFUblVlOVNPL1FoSllQcWlqenRPRlN1U3BEQ1pMalhRLzkrM0hvYU5N?=
 =?utf-8?B?bXkxeENRb1M0YUt3NHU1bE0zMDZRY1VacHFSY2NsVFQwVTA3Z1cvU1lMVGo3?=
 =?utf-8?B?NkljQU95U3gyR0VoNEErWW9iSjNZcWN6VWNxNUJpUTVobXlPMEM0VzREZjJN?=
 =?utf-8?B?RUhDdXNsZmFWUjl6eWUxMUd4T0c3dTIxSTdOR3dIcmYvUmZVeHVpaitITlRl?=
 =?utf-8?B?cVlJaDVtK2JtZzZWeTR1QUFQSVcyRmxaSVBxRkV5azZGUVk1Nk8rVld1NU1G?=
 =?utf-8?B?elpINWJVcVRNS29PYWlWM3lhUVRUYTU2TEFjNGVCeGVkaGhPeEdzYjByQ3VS?=
 =?utf-8?B?ZTlKZzhDcDZBNnEzMnlpSmIzNE80V2FYRThYNFdXaUdaSDJITU1BaVFKRUkw?=
 =?utf-8?B?YUpCTy9Qb1E3YWZnOGVzd2U4L2x6VEZxUTZEVHdxR2w5bEhQVVQzL04rMUNW?=
 =?utf-8?B?Q2x6L0tyMGExTWRyV3YrY3REVlFvSnNJOExCVTU3NlZIODB4dE9vMXF4QnFZ?=
 =?utf-8?B?RC92SDlFdUVYcWtMTTBXcEpNVWFwM0pjNlIvNlBxOXZUU1lOdGxzcjBpVk1x?=
 =?utf-8?B?Y3RySWRBY21DbFFHcWRNT2tvbkxoZ2M0REdpcWVJVEwyWUI1VjhSUytvUzkr?=
 =?utf-8?B?Ny9MSGJGUWpkNjMwN3ZLRTMra29TZG41WkNlREk1RHoveFNRWVg1aXU3aXB3?=
 =?utf-8?B?MWxpNXFPbXBRSnRnK1dqY1d0Z3FHSjB6L2FGZmpueXpQUXFLV2JVQkRndW9q?=
 =?utf-8?B?Ri9UNTBqSFR0akJmNkxtWkNidURTN1AySGZ0ZzR5L0R3NFE0S0VockZydTU4?=
 =?utf-8?B?NkVmcGFyakprZEVUeHB3a2dqK1NaN3orZEVnTFkrdFBja0gzZ2NSMGliQlJE?=
 =?utf-8?B?d1VJMnlyTVZUZmJQTFFJVjJSUHBwam5PSFhJUXRvRU1WRTlHMStlU09HbUdR?=
 =?utf-8?B?dFJQQmRSSVFua1RBMDRQSUJDajUvQVpKeG0vbGowOFFaWkN6WkNER0srdUpG?=
 =?utf-8?B?T09GTFZQaUNuMnBCbUpjVkJCK2U5eS9xdDM0c2dtVlVWMnNQMHR6UzU1emVG?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bjFYZHBsd3RvUnhLc2twZ0dHTkc4YlMyMTFObVNmcUVKM2x6NWZxV1BMZnNI?=
 =?utf-8?B?bnUyZmJlbjhDcXR6U1hWMmhjclZGR3pFTEJtTXgvdUM5M2theDZBSnpreFNQ?=
 =?utf-8?B?cUtSSGpkR1JITWZzYnRCUWY0VTFUbEhqbk9SOGtzNFFRUDJRUFAzVHJzdVNQ?=
 =?utf-8?B?eHhFRGZlditMQi9rKzBMWmdsMUJnL1dQOElUL1ZnZ21jMnhJY0lJdnRUNG1F?=
 =?utf-8?B?bVlEOXBkazRSSERoTXlGZ2svTjhYQ0ZRZXp5bmdJWCtORWdwVitRSkQ1TjVp?=
 =?utf-8?B?WkNmUHJGTkNIZDYxN2x0eXNhTFA1SUVOa0R5WXZKNWZ5SWJ0TnRnamFzYnV4?=
 =?utf-8?B?eVZKQnlyekpydlQ5MHliaG9KcFF5REs5VnhFWmpnMlN1bkJsbVppeXpRQjBE?=
 =?utf-8?B?ZnFnTElVcVZXcE13eGVjVjZPRUFaOUNkaGFoa2lLQW5DQVZqTFpJek5iV2tn?=
 =?utf-8?B?OFJ6NXp0eEVqMW53Tms0YzZ1R2xkWUp2VGZDOGdjei9ubFBiQ2Uzc09VVDFj?=
 =?utf-8?B?QUFtbEUwRjh1SGc0YUJBY1RtWU0zdUpnQ0lNc1U4ZXlOdmVHN3NMTmU4RXlz?=
 =?utf-8?B?dlNOdFZNSVNkUnA4RExCbUlYQVRLZnc5RkovT29BZkVuSi9iK2U2SHIvdVJs?=
 =?utf-8?B?ZkdYT3hqZU8vQTdxQW1NN3ZrT3phNDA4U0o5NEFxcCtadm9Jc1h4OEZIUjFD?=
 =?utf-8?B?WTNaeDFJU2tzRC9wOFpYUTZiVnBXdVNmdDJ3L1dGOUxhbjAzUXZ6V0ZNQVVh?=
 =?utf-8?B?b3FmcVNtOFFyTWJ6bkE1L1BVb0orMGM1cUM1WTA1dUxseGJtaExUYXIzN0I3?=
 =?utf-8?B?YXVmMS9DbHk1c1hySzM4TU9VWEdlMXVRNlJ6R3ZVa3lCVm13Q1laRENnSTk3?=
 =?utf-8?B?OXdoQkMrY2hXeUhONzlWdWhIWkMxZWFrZHhuS0lOcWpOWU5XTHlKQW5hdWhC?=
 =?utf-8?B?UkV2U3J1OGZhWHlyWVcySWV2YWdTMS9VZDhHdWcwdE04Rm5mTEZRVVhKTXhR?=
 =?utf-8?B?b3dEZFdMUTBlakRvVXVJeWFmQmRVSVRYUGEyNk55cEd4UW56YmJKRkdDdUpz?=
 =?utf-8?B?T1ZiR1ZrSGpMTUwwaDIvaGJqcjlDN0lJY3MwV2t6MFNhUjlmZFk3WVoxcWVZ?=
 =?utf-8?B?cjBuTFpkbTVFOTR6SEpsaTVBTmFZR1Z6b3E0MysrOVdLbm13TXM3aWRFM3FY?=
 =?utf-8?B?eFdBVEw1aVc0MUk2YmRudERZNk9vSGpOb1JiWWpqTWpJeVBseHlLdVJ0UFpr?=
 =?utf-8?B?ZEE1MGpSWnVGMVhybjV1RE9UVS8zTHNZaXozMzZLcFJVYnRYQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c51b98-5cee-4c96-f152-08dbc441cf32
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 18:51:53.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/9E1Dl/3nIRwuxSdDD8X8nO4t8FZDFdKs1h0E/uQb5s2xqaAuf8kxsDZHcxOUeuz6uJ6JTmobOJYczdaGY8lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030140
X-Proofpoint-ORIG-GUID: lsDBAZNNlrOjsc6VEtM05iyFbRFd6lIe
X-Proofpoint-GUID: lsDBAZNNlrOjsc6VEtM05iyFbRFd6lIe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [231003 12:21]:
> On Fri, Sep 29, 2023 at 11:30=E2=80=AFAM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > When the calling function fails after the dup_anon_vma(), the
> > duplication of the anon_vma is not being undone.  Add the necessary
> > unlink_anon_vma() call to the error paths that are missing them.
> >
> > This issue showed up during inspection of the error path in vma_merge()
> > for an unrelated vma iterator issue.
> >
> > Users may experience increased memory usage, which may be problematic a=
s
> > the failure would likely be caused by a low memory situation.
> >
> > Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> > Cc: stable@vger.kernel.org
> > Cc: Jann Horn <jannh@google.com>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/mmap.c | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index acb7dea49e23..f9f0a5fe4db4 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -583,11 +583,12 @@ static inline void vma_complete(struct vma_prepar=
e *vp,
> >   * dup_anon_vma() - Helper function to duplicate anon_vma
> >   * @dst: The destination VMA
> >   * @src: The source VMA
> > + * @dup: Pointer to the destination VMA when successful.
> >   *
> >   * Returns: 0 on success.
> >   */
> >  static inline int dup_anon_vma(struct vm_area_struct *dst,
> > -                              struct vm_area_struct *src)
> > +               struct vm_area_struct *src, struct vm_area_struct **dup=
)
> >  {
> >         /*
> >          * Easily overlooked: when mprotect shifts the boundary, make s=
ure the
> > @@ -595,9 +596,15 @@ static inline int dup_anon_vma(struct vm_area_stru=
ct *dst,
> >          * anon pages imported.
> >          */
> >         if (src->anon_vma && !dst->anon_vma) {
> > +               int ret;
> > +
> >                 vma_assert_write_locked(dst);
> >                 dst->anon_vma =3D src->anon_vma;
> > -               return anon_vma_clone(dst, src);
> > +               ret =3D anon_vma_clone(dst, src);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               *dup =3D dst;
> >         }
> >
> >         return 0;
> > @@ -624,6 +631,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
> >                unsigned long start, unsigned long end, pgoff_t pgoff,
> >                struct vm_area_struct *next)
> >  {
> > +       struct vm_area_struct *anon_dup =3D NULL;
> >         bool remove_next =3D false;
> >         struct vma_prepare vp;
> >
> > @@ -633,7 +641,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
> >
> >                 remove_next =3D true;
> >                 vma_start_write(next);
> > -               ret =3D dup_anon_vma(vma, next);
> > +               ret =3D dup_anon_vma(vma, next, &anon_dup);
> >                 if (ret)
> >                         return ret;
>=20
> Shouldn't the above be changed to a "goto nomem" instead of "return ret" =
?
>=20
>=20
> >         }
> > @@ -661,6 +669,8 @@ int vma_expand(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
> >         return 0;
> >
> >  nomem:
> > +       if (anon_dup)
> > +               unlink_anon_vmas(anon_dup);
> >         return -ENOMEM;
> >  }
> >
> > @@ -860,6 +870,7 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
> >  {
> >         struct vm_area_struct *curr, *next, *res;
> >         struct vm_area_struct *vma, *adjust, *remove, *remove2;
> > +       struct vm_area_struct *anon_dup =3D NULL;
> >         struct vma_prepare vp;
> >         pgoff_t vma_pgoff;
> >         int err =3D 0;
> > @@ -927,18 +938,18 @@ struct vm_area_struct *vma_merge(struct vma_itera=
tor *vmi, struct mm_struct *mm,
> >                 vma_start_write(next);
> >                 remove =3D next;                          /* case 1 */
> >                 vma_end =3D next->vm_end;
> > -               err =3D dup_anon_vma(prev, next);
> > +               err =3D dup_anon_vma(prev, next, &anon_dup);
> >                 if (curr) {                             /* case 6 */
> >                         vma_start_write(curr);
> >                         remove =3D curr;
> >                         remove2 =3D next;
> >                         if (!next->anon_vma)
> > -                               err =3D dup_anon_vma(prev, curr);
> > +                               err =3D dup_anon_vma(prev, curr, &anon_=
dup);
> >                 }
> >         } else if (merge_prev) {                        /* case 2 */
> >                 if (curr) {
> >                         vma_start_write(curr);
> > -                       err =3D dup_anon_vma(prev, curr);
> > +                       err =3D dup_anon_vma(prev, curr, &anon_dup);
> >                         if (end =3D=3D curr->vm_end) {      /* case 7 *=
/
> >                                 remove =3D curr;
> >                         } else {                        /* case 5 */
> > @@ -954,7 +965,7 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
> >                         vma_end =3D addr;
> >                         adjust =3D next;
> >                         adj_start =3D -(prev->vm_end - addr);
> > -                       err =3D dup_anon_vma(next, prev);
> > +                       err =3D dup_anon_vma(next, prev, &anon_dup);
> >                 } else {
> >                         /*
> >                          * Note that cases 3 and 8 are the ONLY ones wh=
ere prev
> > @@ -968,7 +979,7 @@ struct vm_area_struct *vma_merge(struct vma_iterato=
r *vmi, struct mm_struct *mm,
> >                                 vma_pgoff =3D curr->vm_pgoff;
> >                                 vma_start_write(curr);
> >                                 remove =3D curr;
> > -                               err =3D dup_anon_vma(next, curr);
> > +                               err =3D dup_anon_vma(next, curr, &anon_=
dup);
> >                         }
> >                 }
> >         }
> > @@ -1018,6 +1029,9 @@ struct vm_area_struct *vma_merge(struct vma_itera=
tor *vmi, struct mm_struct *mm,
> >         return res;
> >
> >  prealloc_fail:
> > +       if (anon_dup)
> > +               unlink_anon_vmas(anon_dup);
>=20
> Maybe a stupid question, but why can't we do this unlinking inside
> dup_anon_vma() itself when anon_vma_clone() fails? That would
> eliminate the need for the out parameter in that function. I suspect
> that there is a reason for that which I'm missing.

It's too late.  This is to undo the link when the preallocation for the
maple tree fails.  So we had memory to dup the anon vma, but not to put
it in the tree.

>=20
> > +
> >  anon_vma_fail:
> >         vma_iter_set(vmi, addr);
> >         vma_iter_load(vmi);
> > --
> > 2.40.1
> >
