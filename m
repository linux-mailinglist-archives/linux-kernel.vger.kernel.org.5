Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58DD78CB44
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjH2RaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbjH2R34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:29:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C076CD7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:29:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCCZYx002221;
        Tue, 29 Aug 2023 17:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8LnJVaKB9e0oyy/Cpv1kRnDk2etfnmDHGHaJTW7j48s=;
 b=tc4EtQABhrHWOerEN0t6wqa/iOOYB+tZWap/z+w5bg8IaZzr9cNEyI5pa3YY+yB0o66k
 tPNe8q20LlmBZLxcm0lNKfsd8L1FSdqHSdU3mw86vQ7r3kTUUA6ZSQ0806S8zjYlq8OU
 bE3V5lodKxc5JB6ptnejAXKG3g17cceH5q75dPwJwTuNbV5fh4qyrTlOPFFWqowt+PBz
 PZR7bBm/0gt5iJGTx/EfJoofjSvEg5o1G7jXVm1UqdiHFVdFOuokQYcbbcCwfPmqs6qC
 Ebfs9eEQ51Q1I2N8U3OBtND/VXDsxgb3O8PSsqZNbXnHArzYjdJkjWViOxQCvkHn+B5/ yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcnj0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 17:28:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37TH57CR040663;
        Tue, 29 Aug 2023 17:28:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6mnehxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 17:28:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZYT0uLc7wA4OLFMVFgjt7BjMZL1KfcEcYy3EqWPaSfUsYIlRXaFEKBp0xIjrx1uT0c6jB3QUOUTqaSbelQPcssiwqqZqsMh/B4Bs+ADEfMdvo7K75Tu0vo3ZO9sVCuFeqm+SbeKviZF31Q7YxgCSo2rH/38i4/XXeNpCrqofy3qGbBa/W1z6bJs/BJqO/bIcH31P78veGMavEFtzMupfkwbmnlvaF5MOIrDLaOj1ytSW6S/YGNJR4DksL4URjUHA3p3WSgonTH62SgHXyL2+vvPwh4LxDSOQ0AYCWs31a59rgb9zXwVgx4OG/bLPAdRr/jdn6o4uQ5OC00Tz2dM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LnJVaKB9e0oyy/Cpv1kRnDk2etfnmDHGHaJTW7j48s=;
 b=YD8Dy7SClpVJx3mdSLGc/UMLJ49uu8XbTKYTAtf+Z1lQR0ZJfHylKSH7U5zmG0JO6S1RGPN0C9YYPkjzUiYUqUluwqOmYif9F2q5NDqg3j1KkjQ59dnXHzfCpSVJY84sd5ybdjdFZTaGmMM4tE5MIKyfMbsw1v0lpP98lXbWMBGSv+ySQhjIOkY4ZWehI9FGB69/w2xxvw42JVgwwK1ChpU1Gmz6WWC4VNVcoGB5NqmSxEI4jOybJ12YukjYCu+KBK5lf7tjbv12zkvk4i5dDUIC5ykDEEyoe0YEEFDNZ2n/w6Yx5G/MZQRokhd4kX7gpA6GDO2ZxANrCLxgxQJl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LnJVaKB9e0oyy/Cpv1kRnDk2etfnmDHGHaJTW7j48s=;
 b=k9ohV/c8gzH8DdgtsxAbjWOpZ/zkSW0g2orDOXtjuhwNizEWyePEHzCGFTUnacPwfJCTO+/UoOWI7mDLH52/rrjXvTUN1wO7Cbqdci6XGKLlnY3AvhBnT4oiRSjRdtkvBjpyWa4/yi+ohgni1bAcZMh+xwjWoEysDuvVATTZ6gA=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DS7PR10MB4973.namprd10.prod.outlook.com (2603:10b6:5:38d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Tue, 29 Aug
 2023 17:28:17 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 17:28:17 +0000
Message-ID: <630d22d2-3bd3-4a91-b559-2d65a9df8bc5@oracle.com>
Date:   Tue, 29 Aug 2023 12:28:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] jfs: validate max amount of blocks before allocation.
Content-Language: en-US
To:     Aleksei Filippov <halip0503@gmail.com>, gregkh@linuxfoundation.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
References: <2023072336-seventy-untangled-cbba@gregkh>
 <20230819173216.6098-1-halip0503@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230819173216.6098-1-halip0503@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:610:e5::27) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DS7PR10MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bc5d28-aa3a-45b4-be7c-08dba8b55518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeYEauB9fEMZPFutDxTvbWInemClQKxlNfVlZ968rQGkw09OsYMn6Atpl4mwmR7SFm/37/2s0tv7D+jJa9nzyd93b53nlC3cZ2wB42qGi+bjZx5s9TpHfYyzg8i1gHMkAHzR2bhM5xUmaYmANj38DZcBULOJCWWXCngeZqWAgzb9zsJxKULadxdNd2t0dF4XDCp2WKf6Udu+s4qmjEdHOCviQW1zBWcGe5481ld5enwzZpoPVdV94DCMSdWu6/AYpw9PXBKxyOx+h/4+S1PMuJV/sTXgt9ZWOBINALBtpL+VZfKw7qngjAZHH26sJsL7CZfkteoyKByoNtLg2OzvpCWTQDBmQAbVB415aq/taKH9XDzACXJeQ4s5EdRFx6exuIVDBLTGHiTMblK7lZSfQbuexJqITrfbzpI6FtU+rvu+2Udu5iYaY+m7sHW5DZT9XxfWiW/DlTZmGvHgNwNW+AOP3Zr510Lpnd9VbUmIhdK/cJaMgEs1WnIbxttv1hN4GSzKb7DeH5uIsLUVxaeOHMm5dl+sre2rpNjqW1XF4X8409CHI/rP6unS4VALKHWf4HQgBWBPTgWvx3UR3zI/7a7xk/sSrfXexptHu9g7pNGZH8HtkNoiZHm/YnyYfmDenidaouw/f/Dney53ZTHjXqZI6dJPBTWRywb5XPwhpUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(478600001)(31686004)(6506007)(66556008)(66476007)(66946007)(6486002)(966005)(316002)(38100700002)(41300700001)(6512007)(36756003)(26005)(44832011)(5660300002)(8676002)(83380400001)(31696002)(2906002)(2616005)(15650500001)(86362001)(4326008)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnhRRW81OGoxY1NSVW1QTnUrbkZBRDJHWXRoRk90Rkx5MkhUZFZwdmFSYmZt?=
 =?utf-8?B?M1EyS2czdmQ4V3JuNEx3QmdpNlV6OG8xZmJoZUprZUd6N28rR0hzOWlZUGRZ?=
 =?utf-8?B?WWg1Q2dYY2FUbkFjV256dnFQeTRiQ1d2Y01zbkRwUURyb2U4L0JFNUViRytS?=
 =?utf-8?B?YUpQSlhKd0p1b3V4Z0ZLdHRTVWlyTVRGaTl5UTB6YTFlb2xmbWpyM2lCay9C?=
 =?utf-8?B?VE5VVTZKQnhJYVNXcm9kNUg0TTNmZCt5d3hrNjlFYUZ5Y2NSYWxvVENvSmpi?=
 =?utf-8?B?YzF6M25JVngxMkVhZWVNZXl5YTZYa2R4a3FrUzZBakZINlF1dFNEazJETkZ3?=
 =?utf-8?B?am44UXZLQXRjeTB5LzBBcFEwYmhadU1XMytVRGVscHI3MTBEYTJlZDJ0MjZG?=
 =?utf-8?B?enEwMWVBOURaNFFlOTBtT0VObkpqMUJSbUNYbEwrLzArdjFmV3hSRlNnanBT?=
 =?utf-8?B?R21GekFGV3BSQzkyeFhsa2ZSeVVCc25MMDM3RFg2S2dvcVRJeVpXZUoyYmhO?=
 =?utf-8?B?L1VDWkFpSEU5WHE5cS9jeVBCd3VZbWJDZ1cvUmQ1aUhDeWFSMFQvbzZMY2Jy?=
 =?utf-8?B?MUJTYkNPUUVacVdvYkdZdVozSnJSS1F2dUYyVk81MXRYblRsYU0weGVPa3lv?=
 =?utf-8?B?WUJNclMvZnk0QmZTd0VaZS9IWGtBREwreTZOTWxueWZLSE5mdUxNdkZhbHVz?=
 =?utf-8?B?NTBVWFRwSW1pcmFYUXg2MVZYNWppMEtsaCtzNWVjcVFaQ011L05ZK3VzOFhY?=
 =?utf-8?B?anY4N3lYdHdpUHMxZE82WGR5emJUeUJibFhYTlZVSDc5VGptcm5yMElzb1ZP?=
 =?utf-8?B?SVdyRi8xVFJobnpzRmNndzlyUjU4Y0hIT0czSnpCL1NlVDZqS0RlaFNoRlRr?=
 =?utf-8?B?WXYrSTBuV3Z2SjJZUG1KMU93VkpKWUtuRkZNOUxQaFV5N09wSFRFblpKd3Jy?=
 =?utf-8?B?ckdlZkVhYUlIYjVjY010TnVBYWlLZEtXVklUeHN2dnJHSlV5K3VhVFJTUlZY?=
 =?utf-8?B?cWRUZFU2S3djZ1pKMFU2Yy9XcnVPVEg0NG5BQUd2ZW9kV2M0MnliQ1RaRjNS?=
 =?utf-8?B?Q0YwMGpobSthWU9QY2VpVmhDdHV0anpZd0tDbXFUM2JQa3lkeTZCRTJWNWtx?=
 =?utf-8?B?VjJVeHlsWWlMTS9vU25aSDRIWFp1cVFja05rdHZNaGhRMEFXMHArUG5DUVpp?=
 =?utf-8?B?dkxNR25XaktUcTkrdUpyWTI4MVZHeDBlUXdvZmpQOE1sSHpESmtMTU4vUTNY?=
 =?utf-8?B?Z285eVRiTGc1Y2pLQm5uanNRMkwyZ1Y0TXpNY28yNERhZlA2RGRQVTJnMit5?=
 =?utf-8?B?VHo1aG5vTHNCcy9ydktBUDZycVQ2RXNzRk8zVWYrNUd2eXVLZnNDOVpBcmdz?=
 =?utf-8?B?RGtINk9jbGdsMFU0YTBqNlM4SVRzNjlLU1hOai9jMlU2S2RCMnFmV3BaMUVi?=
 =?utf-8?B?ZTVBcWlTajNsVWlnd2t5OVBJMXdPdmdybFZIdFQ0ZkF2K0FURStBZzRRMllm?=
 =?utf-8?B?TnptWkVFY1JkV3hXanBpODMySTlZVEhDaTIyeC9oTlR1NlFiZkZrVmxlR2J3?=
 =?utf-8?B?L1dBd1dQU0VEMWZ0em1JNGxKSmwvcVZTUDF6Q2RXZ01jU0FubGxzOGJGcjJW?=
 =?utf-8?B?N1JCdzhFL2xBMjU5Zk0rOWVrSlI3dExFUUF6b1lSbVVnd2xJT1BWVzRJOVUr?=
 =?utf-8?B?MnBRMTJ5MWNJTElwQnFrLzJuampUS1Y0aURaT0hmSjhoODlYQjljcWp2dVhI?=
 =?utf-8?B?RTRaTkxYUFN0d1U2VjVtLzZWbDVTekIrSk9YZ0p0SStrQjNkVlVLLzJqcjR4?=
 =?utf-8?B?d1JGWHVRT1dBMkV3WlJ5T2pGamNRYzdKN29RM2RXa1hSUE4rdGl4NHZrM1Js?=
 =?utf-8?B?dDVMNUVVSDNtZlpBZzhDTXA3ang3SFBQalVncHJEZW1tMzFnb0JySituRTRu?=
 =?utf-8?B?bGxSTW9rUGw2Q3lkellxRHZHRXlqSDNMMGpjdFZtNWZjVXREZzRsWTg2SkxF?=
 =?utf-8?B?bHJERkhLQXJzYllBUlpVRlRqdkJsNmFNRFJNVEh1U1lKR0RKZ3dld3RPMWpt?=
 =?utf-8?B?WWZFTnlrQ09rMldVTWVBQ3VsUUxVSUFvSzRhZ1pBUUFUaG90QTJwRWxRb3Fh?=
 =?utf-8?B?bHZVK3VkVWliZThFN0RoakkreHk3VUVqL3U2ZEdGamM0YTVCMGlxNmhEbUkv?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UDJQL0JxZmFZZXV0L2JGYkNnajFhU2h5UVorSUVzbi9nQkJJSTZIQndsdk9X?=
 =?utf-8?B?bGZ3Umx0YWV6Qkg4US9qdUYxdVo5T3c3eVQ5cE9ITU5FczY2YmNkdzRwaWdH?=
 =?utf-8?B?a2RZcFJ6QXF1d1YxSGYvN0JnaXdOYkFVZDFvM0YwR2JXRXJ6eDdLMHlkdmxU?=
 =?utf-8?B?bEl4YWdnWE5GRXdHN3I1NWhydGtuQVdhQjBORWxWUzdkWjY3RmJ0RDB1b1lH?=
 =?utf-8?B?eXczWTJ5ZVdSc2FBdXluZ3lEM0pOQWN5OFVTTFphRk5qUTJBanQzbzBoaGl1?=
 =?utf-8?B?T3NkZVdPZ1VQQW0zeW9rVDhsMDFFV2toTW5hUFFpWkpoWlFyZyt5Z0JGSHRT?=
 =?utf-8?B?ZVdoTGdhNnlieC90NmxiamFOUXBVdGRJQUpUZlJHaHpVR29wZ3JjMTVneith?=
 =?utf-8?B?UnRtcm5ubzJSNEZJWVcxVmxKMFlIaWM3ai9GZHUwZS90OE1vMHBVeDFzWTMv?=
 =?utf-8?B?Z0F0UkJEKzQrckJ3ckhNdE9lNXpNbkdyL0NDNUllMXpYVG1VSW9sUXB5eUlt?=
 =?utf-8?B?NVF0bFJ0TU5hR3FWNFJFeU1nNmtkWklrVm5QNDE3elhEQ09aN3lTUUFKaEpY?=
 =?utf-8?B?cUx5Z2pjU09KelozWXE2aUNzTVFLdElhSjU3V3Y5SW5zOHJ2VklVTTVFbkE3?=
 =?utf-8?B?eGFCY1k5Y2M2ZmUwazA3bnZRWjBZZVBlR3paMU9KOXllVlFZUTBaaGFZVDF6?=
 =?utf-8?B?cC84bVRUQWFKSkNLa2ZYLytCNklvVWlUOWphT1FQa2t2d0dMVk93U0NjVFA4?=
 =?utf-8?B?YnRNUVhXaTN6MVhiaU1tYnBuSmJUUzQ0bWsrNTcvQU0wUy9Ra2xRN3FHaStl?=
 =?utf-8?B?Y2JKdTVyQ042NTYwTGg2SWRLU2paOHBZaGIvTXd3cU5YTld0SWpqTk1RS3JI?=
 =?utf-8?B?U2ptcEM4ZjJhZUJvNGQrS21seXZjMUdZNFRteWpwN0R2c1hKRnlxNW0zbVg5?=
 =?utf-8?B?VzdQZDl6bExjS0FBaldhSTltbWd4Umk2Zzh5clhWOG5zdWxjSHJJMHczTXN5?=
 =?utf-8?B?TjQzVjc5WFF1bStHMjRMK290M1RmK1pwd2RUazBOMk5ZYWVmUG5ONm9uMUJN?=
 =?utf-8?B?SkFGM0gxRkxDd0dlaCtlNjNxd0JGRUJwcXQ4SDVFeWlpdzlybkt1UGNJVncr?=
 =?utf-8?B?aUFBcVhBRHlidkdNbTVtMkFrbG9UMWhYMHdtZTRFTFc4SUl3dGtjcDVneHVJ?=
 =?utf-8?B?UlJQUC92dnlsOGljaXFwYjY0bzFGWG9rUmVKMFdHL2tNbzJZdjFZMEZWTTlC?=
 =?utf-8?B?YjgySnc5dUx1djd4OGRsQVlHYjE3NStGblNHZFRlclBtaFl0dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bc5d28-aa3a-45b4-be7c-08dba8b55518
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:28:17.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rucOqVeIiONnQ5JooyZfjwA+CQ6ADwg2hH+E4Nyjq0LLAH/60JfTiN9dyra/W6g39zlLAgiR2iSWml6QX+3cdnHcUOkd3CUwnvrdZD9YoQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290151
X-Proofpoint-ORIG-GUID: T_Iin7LzNSKxU1DAUCer4tBj7ABk-b57
X-Proofpoint-GUID: T_Iin7LzNSKxU1DAUCer4tBj7ABk-b57
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/23 12:32PM, Aleksei Filippov wrote:
> From: Alexei Filippov <halip0503@gmail.com>
> 
> The lack of checking bmp->db_max_freebud in extBalloc() can lead to
> shift out of bounds, so this patch prevents undefined behavior, because
> bmp->db_max_freebud == -1 only if there is no free space.

Thanks. Applied.

> 
> Signed-off-by: Aleksei Filippov <halip0503@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-and-tested-by: syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=01abadbd6ae6a08b1f1987aa61554c6b3ac19ff2
> ---
> 
> Changes since v1:
> 	-Commit message fix. Add Fixes line.
> Changes since v2-v4:
> 	-Commit message fixes.
>   fs/jfs/jfs_extent.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
> index ae99a7e232ee..a82751e6c47f 100644
> --- a/fs/jfs/jfs_extent.c
> +++ b/fs/jfs/jfs_extent.c
> @@ -311,6 +311,11 @@ extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
>   	 * blocks in the map. in that case, we'll start off with the
>   	 * maximum free.
>   	 */
> +
> +	/* give up if no space left */
> +	if (bmp->db_maxfreebud == -1)
> +		return -ENOSPC;
> +
>   	max = (s64) 1 << bmp->db_maxfreebud;
>   	if (*nblocks >= max && *nblocks > nbperpage)
>   		nb = nblks = (max > nbperpage) ? max : nbperpage;
