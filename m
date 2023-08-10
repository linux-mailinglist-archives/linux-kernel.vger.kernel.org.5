Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA8C777584
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjHJKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjHJKMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:12:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5579C5;
        Thu, 10 Aug 2023 03:11:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A7QmQG022704;
        Thu, 10 Aug 2023 10:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4b63/UZJ3rnw3qonTUqe6F2Z4sowrA12V7N+38usyoE=;
 b=l2GyW5NyMECTgHI/XsBes2QIt0ciKeaoIjs3KlT72kI1kqR6ITt4tdylfJdY1BVC7m4S
 G87P5N6WwYyyaXR45TcPFGViTcWTNmRY63kqFPXisy2lwtyxL4dTNglEodcIzYYNvJCA
 Oym9b3vN8OTUrw/7XYd/5E/wwH6gWmUQCROfH+cvvW1btqx1E1m4vVX7D98JPKGVBrx0
 KNvgdnUqAurmOCggas1AELI+sCE1WPxGLJDR5FNrxTZ4Fr1wbrBje7bqCTiBg4kTOMZJ
 SG3mHl1vrQzLj2rSDnx3WICayRs4kUb7AZR+Q2iqk+V/AcbM48Yn4tapNxKPVG//ghMJ JA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d73jtsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 10:11:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37A9YUl8039666;
        Thu, 10 Aug 2023 10:11:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cveqxac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 10:11:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX8KKImv2gY3ftIvMe1aHpmW9aHgiWWOoJcZWfGrIMMT/AgyGHZkAshFGk+8Ngz5bBnQDU0Jq1XjJ7af3+e40Qd+oK3hKScvW8qmqGJnnlsI28JhvxhRFDSjwGX+YKg5y6B2xcz4/hHmMDhFvHiySMuGK9EjV+6oqB3iGixo6RkL8El1rBV2mSDg64OYdpAb9wgNebetKWRt9OojVIQ82rGxZOg7g2/vD2fUsFLBLNMkNqA51p8h4+K9UlOSM/1PnM1B46lK3Qdq2JTNgHTP8F2U0wXM7UzfVaWyxoMMIEYQSpxkbw5rgysf6w48VWTAoM1zNTf0KqW5WrGnrP35WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b63/UZJ3rnw3qonTUqe6F2Z4sowrA12V7N+38usyoE=;
 b=FUd2EemyW9obvxtnkfj/cT1pJDag0ZVqZxhOhUV6lyUJAkUWLrHR0OWlOynt3zi4wPAIAG69NeEvNJJs1Awv35C+EgpQ35L/+oOE/vph2OjMs6ojPH0l3AcFs2Wsmm3scDn0m1aLcUTNSp/7o5DnGritUFniwXaQ7wsaiKDrT4lRyOyW5WL4++QjGXf5NDjRkk61uC+zbLFmDxKxLfBCdKtMWC/7kLrmzVYvq1+K/lJXKpbsX1Xt+oItj3cDYx0U1wKl1rUQMk2xyhmhYxG2H026fLGZning5kD33Dh1rK4qYoWqr35L1YZxCEwJCb7yjLm+CuwkAFOye1BMvHBAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b63/UZJ3rnw3qonTUqe6F2Z4sowrA12V7N+38usyoE=;
 b=egzaGUSUFiEkwBOLItYNsKAGaph/shRgYkxBhwRUgRa11aDTny3WXDx1ZEjXv5sPP+J+3GyY39PtM2Pv6kGZzaJbUGtq0Wg9DK6QY8SXR/gCD8rrN1M378fnQ2XfWnAhwPgAA9KU1MS3zJulo+nCJce/atqY9O7smCFcgJ2K7K8=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA0PR10MB6428.namprd10.prod.outlook.com (2603:10b6:806:2c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:11:15 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:11:15 +0000
Message-ID: <0d93f1c7-0520-0a12-b43c-8977fe3cd294@oracle.com>
Date:   Thu, 10 Aug 2023 15:41:03 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 4.14 000/204] 4.14.322-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20230809103642.552405807@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0268.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::13) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA0PR10MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: b435fbef-88f1-41cd-4e54-08db998a217f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fkNG966WESOXvZHAmg6YlWHqnl83ph0vt37L05JXQpELNFjfnDp0fOpvqx97sj2/aGoNkQPJKXvUi2dY/+u1Lts9qSGvdTBCAzjIJl7peRnngbtQOgKfH1CmkJcUr+TPfLZPASg4R5r+ZHFwGNy7APCLIHcU6sRCr8MSuMjdmbxOG07TvjUIUTJVGmvPpHXgkI5oYdp/B7UpaPCSrD7XxegztYr2+T4xcsZsI7AoxVOP62SYqx4SEjcIlguI2xQTJY2pQbj9n/rFYDgAbUawG8YPiaBwUo9tKUebj3Ez6qSHnqWuWHV5zLZEv947+VlbNhdONqNoisOfVldtdq/tYoPQCXNiSRfvcuoBVWAScNZjzYEVuGnbhGtSzywNcHmZmyrTulluez5gz63ppK2VhNMeATIO/6k5zXmO84kc6HlgMkxKRM1qnQo6bh/Ki5z97DCu5WYbUKPBM2RHRNLiGnrRH6rNUU55LPUoYoFxnka61RnSrawzcxtawiijbDwJ8YLQAIb/uNzEnlEqrqeFXUzA8rkKSVhWmgg17VLbQNSHpDHOG9xc0kkIwLfCXwHAK+HT4WCAHaTzo+OCx4q/JN6zhjrvsQ2GtJQx+tivadg3E2M+mXYU57YE36fgzPp4wPmAsZwqdo1wR+C3WYUiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(366004)(346002)(186006)(1800799006)(451199021)(31686004)(54906003)(38100700002)(26005)(6506007)(53546011)(6486002)(8676002)(8936002)(2616005)(478600001)(86362001)(107886003)(31696002)(66946007)(66476007)(4326008)(66556008)(6512007)(41300700001)(316002)(966005)(2906002)(36756003)(7416002)(5660300002)(4744005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1JUdWk5WU1rdFBaVjJBSWVyaXpyZkpIRkF1SmFqbEFNK2lvVFBqRVoxOU1M?=
 =?utf-8?B?WlBCS3JpbUJjYUpQc2I1Y1ZZZ2xvaWVHcUJiUGt1WVZCc1FkeFN0dWRQdXQ4?=
 =?utf-8?B?YjRHa2hEMGVCemRaOVFWd2x6NHRMekxobE9ia3dubE8rMTJvOVpaZ0U2blBQ?=
 =?utf-8?B?TkpySkdST29ucGdRSFVVeUlieWpSOW1sZitaKzlGSVNMZjVRWVd2c1JXUkV0?=
 =?utf-8?B?MXluOG9QaFlrT0dLZzNpaGhkTDVXT2c1Sjgxdy9oNmR4ZXFhRHlMWk9LN012?=
 =?utf-8?B?WVpQdzJvdERZU0JDOURiUG5wTWh0Wm9BYkxoL0JsSW05azg5VTlTQ2lBR295?=
 =?utf-8?B?allQSjJkcnh2RkF2aWRNSWFVZ01jUTZ1WnVaWm91UnlkQ0ZMeXpxbEo3bDJJ?=
 =?utf-8?B?VE5XWUpRenNDME1HTUpvTXo0a3NEMk0rT2wvOVlWQnEwYkNicEJNWjNid01u?=
 =?utf-8?B?bnpTMnhZQVVCN1dneWFOMmVOY2x6RHZPczMzNVczT2pXQmprL2FhYThXbSt1?=
 =?utf-8?B?L1Nid2dabG9ndTUrOHBoUnNteFhMVXdzV24veGlYSlpEaTVXTk91aTZibnlP?=
 =?utf-8?B?TkgxTG5iMXdMME1rWEErcVAxemZuMlZMWFdoajlCVmlBMGF6N2RHUEl3QnFr?=
 =?utf-8?B?MWx4VW8rbEt5VnRCWm9wc3BNYVZCVGMwWlBSRkFaVkNxdElxT1FzMW5JeGF0?=
 =?utf-8?B?TlJWNkxBczUxMlVVazNVNjh6M3IxMEFFWFR2SGNKcWdhTGFxcGs1YWxHaHQ2?=
 =?utf-8?B?QU8vNW03S053U2hUeVB0Tnd2TnVBZ0tIOGxkNTJIZkNaK21odi9RZlpCUG5J?=
 =?utf-8?B?cUNEM1dLbDhaMFQzVG1zeDBkTXBoUW8xL0FoWk10NTVabytlSk5XZWlYYlhX?=
 =?utf-8?B?TVZhYXBXU2p1MEhYZjBzTmhLZUo3R2YzMHFmVDIrRytZU1VHOERqKzFjRGJF?=
 =?utf-8?B?bEYxR1FXclJ0MjAwK01jbHhRcm9wU0NXOXJ1OVJwQWo3a0ZBQmdRUjU5STgy?=
 =?utf-8?B?ZXNabHRIcjNvYy81MnVYdFkrcUp2OWdVamUvN0ZvSnJPMFZqc3V1dWRYbGhC?=
 =?utf-8?B?ekYxZ0ZTdGRpVVY0MjhndUJLdTI3eVV5ejN0TkttL0VrY2lqdGw2azFaNlVH?=
 =?utf-8?B?SU9uQnpPUnNQUjhWRkdVNUw4d2p0M0JzUGxmRVBKdlRNRWlOQzl2eXdSQlBp?=
 =?utf-8?B?bkRDRGo5MFFRWG4zL3hMWm1qeDZ5REFza1RDU3NyTURsRGhCOGQ1TzJzcStm?=
 =?utf-8?B?cm5WZzgxVHlLLzJ4a2NCSi9QSDFBaHo1TmUrUytkOGlNVFIzNmsvVlJyRXFH?=
 =?utf-8?B?TTRPNGhzRG9hTElRdDN2OWhPNlNpQUFjejY3ckpVSnpkYm5FcXdxazBjRHcw?=
 =?utf-8?B?Z3NFV081Z1FOOEtJRkxqMHM2bzFRRU1lWk9jalNUajR1dWVLSFRlQmNGd29M?=
 =?utf-8?B?WDNFV2d5Q0x3cFA1Z1FFRktubjZOTUdBWkNId1NsOW1hQi9oUXMrV2hxWEZK?=
 =?utf-8?B?aHVyZjUya0tXUnh5MXpNTmxNMGREbStic0kvaGJLYjBoYTM3VzJXN3RVN3Y3?=
 =?utf-8?B?TzBvbUtaVzJoRC90OVNpckN2d0ptOWRuNTArRkJqQjV5Q05WZ1RTYWhJS3ky?=
 =?utf-8?B?T0ZqQ3BhZks0OGdEckdqNDM3OXYzaFNWU1F3VTZCNFd1SUNMUEVuUG92T2FY?=
 =?utf-8?B?THovMGVrWGN2dVZ1YnR2QktSNVBxc0xyQnF5bnJEOWgxOXNmaWg5RUNpSVk4?=
 =?utf-8?B?eG9xKzlNdTM0ZVVNY1paKzVZOFA3SytMQ0VXVDA0dDNpUEttNDI4L1VQN216?=
 =?utf-8?B?SzdQeC9UUytwbHhZWHpTb0VtZm94SUh0RlNwenkyRG1BNVlSaHVsUzlLNXNl?=
 =?utf-8?B?V0x2OWM0NWcrUUJQNlBZOHlRaldvN25lMmRRK3FibTlNU1hPZnFKM1h6VkNZ?=
 =?utf-8?B?YmVZTWhGWnI0elZTcTdTYzQvaG9ZanBuVEVZUTFPVFI4WGpwZmlCUHg0YlhD?=
 =?utf-8?B?L1N4V0d1WVYza3ArOTVjcUZIREY4Sm9YVXorSU9tOTIrdGQ3OWlRamJBUEd0?=
 =?utf-8?B?aDE0UE9BYnlORWJUeUVha2xqZGtEU25BRVYxRWRvcndOK1FZNVFmdCt0clVH?=
 =?utf-8?B?VEVoZFhRNllwdkJDdzBwZ0s3OVVxR0taTFhEZ3BEU0Jqa2MxZWZ6RFFsVGNk?=
 =?utf-8?Q?L9wg8Hay7QhiAMsG8aUjYko=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K3R4YlpuZGpxYTRjVGxXUmNhSUV4ajJnem1SYktNUVJsRXVoOTZ5V3dJMmVa?=
 =?utf-8?B?WllHa0Q1ZXF1OWNVYytKMlExdFNIYm5SaU9KSXdDMUs0ZzR2aGpRREpIZXFm?=
 =?utf-8?B?aFpqOFkzVnVFTy9mVzVyOURUOWg1Wk1TaHZDdE1oemUxOFEycDh0MUdUZm9V?=
 =?utf-8?B?dUIzWlAranpKZmFLUXptcllCMStDZVlPK2xHWG95cXdkNG5EUjlEMUYvWTNm?=
 =?utf-8?B?d3FRdFJHNVV6WGJGVis2bElRdmNvQjdJamlEK084Q2NxWDRscGtxdGwveUtE?=
 =?utf-8?B?ZlhCQ1VKeEpETW9Ia0ZKK1Q2cndLWlg2dDZtQTJQczBOQWJuRS96OTJSMXhl?=
 =?utf-8?B?U0F2Sk5BMW9BRWRqcnN3YWZWRlA2NVNISXd3Q1ZCR1JrZ1N3TVJ2bWMxKzRD?=
 =?utf-8?B?T2k2c1RkMENCcmFFbFRuUStrWGZOb1UzbndaQWZOVmNQalZrSjlmNXJBbi90?=
 =?utf-8?B?aXRXck1mNWg5czlYQmtXanJnQWp3NFlremxnL1haRHc3cElnNW9pOWVBbTRF?=
 =?utf-8?B?OHA5UE1ldUR5VCtoMG5QMWxHS2h2Q0NBdW1QRGlxOXM1UUIrV3M5SU44cTl3?=
 =?utf-8?B?U0laMVNFZGxSRTkvMkxoWGdrNS9PQU9CbEJKVnpmZndzTGo1TEtFTThQU0lE?=
 =?utf-8?B?L3E2bEVQK29zMHltT09EekREY2E0TTFZQ2VBVGViRks5NjhMakhpdTUwMGFX?=
 =?utf-8?B?alZsSE1wV2hsaFplTGJBek53dTA5SzZLb0pnd2NsRFVIcTU4UXFDY0JoRHhH?=
 =?utf-8?B?Snh6K2pWMUpteHhtYzZndTFrNkl5cGdsY3l1R0JRYXZQQ1JaK2RmOTFYYUFa?=
 =?utf-8?B?NWZHSUIyRDRBU2NSU0hOWFlQdHAycWovanV5Z0tDUGRqa2drU1liNThQd3lj?=
 =?utf-8?B?M1NnbEQwcG1ENDk2UFRzVjVOYTMxaHA3QitLOGVCN2k4WFIrQk1tdG9OeFZO?=
 =?utf-8?B?VFpqSFUxNnVHQXhIUmR4Y1lHUEozczlFTmxhS085NFRtVW1aVW5pc09YdjlW?=
 =?utf-8?B?V1kwRkFyMHFQK3dUVExxek5UZTJQcXJ4UFhQS0VCa2YxVEV6TUl4L0NXQlB1?=
 =?utf-8?B?TndxcitxUWNubXgrRzd4KzlLdDNCVjlEZVVmZ3RDMVl5cC9iWjhENjJ6UElI?=
 =?utf-8?B?aHdnbVppOUtiM0FaZHJSLzRWVTJ0ZUZxcVRHTzJLb01ySjJTZ3hIaGh2V3Np?=
 =?utf-8?B?ejZ0RHlaZWdtaEZrYXJMS05aKzZlRTF4MEhWWkRYcWhnL0JpbXNWNDZvV3Jh?=
 =?utf-8?B?b2YwNXV2aTBrUEJBSHFvTmlZVlN3NlVvMzdmL3Y1VG54NUQ3aW82UXhlOVQ3?=
 =?utf-8?B?cFRyUUtEVGJtWXlYb1U1eE82ZnhjSDVxMENscnJ0Z2gyTG9lWG9lUlUvcnZG?=
 =?utf-8?B?SjdiREVqcU5CS1E4SzJpR3NTWTNzL0F2eGZReW9VTk4yNEE1U2E4TSt6ZHZi?=
 =?utf-8?B?dHk4SjJueTVrV2xOcHZOS1JtTHoweTJzeW9VblBudUV5WTB6VEVVWXhTY0pS?=
 =?utf-8?B?UkQzWllCQ3NlZmEyRUZ0aUpPdVBGWkJEMityNjVMb2k3cjhtTm96MFdjRjh5?=
 =?utf-8?Q?fEt00IfFMTe/zn4qxitwtRquHn07La+0T/ZV/qMGtctr3S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b435fbef-88f1-41cd-4e54-08db998a217f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:11:15.2258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOjrL75gDgYYpEz/u9Sx0xxKf1KLHHGX/BNVk3n1Q/V/e285cHbFvuDW5lPP2mcFr4MTZYe8vmxSBggVUGjIy1Prk5UUQMe9Kb88fL5ceOPmNZ4CsDTqHCZKK/bfxJWP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=975
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100086
X-Proofpoint-GUID: UKV8nWWFvnRG0yoFnNZkHIfYKWFtxyBx
X-Proofpoint-ORIG-GUID: UKV8nWWFvnRG0yoFnNZkHIfYKWFtxyBx
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 09/08/23 4:08 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.322 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.322-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
