Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F333D784031
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjHVL4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjHVL4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:56:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758D8CD4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:55:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M1FLvA027410;
        Tue, 22 Aug 2023 11:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=z793RJLgYmLOE3K88axZAD6pxtygwqDgBwMjQ0lmuvE=;
 b=q82haVqA4HO1MIs0dkcXigFKGUV+j3CPqLgWXBTFBR4uMRS3c/YJJc94vcZa9rpV3Cnv
 DjLjj71zPuFiU+/n+pewx6T4yVDfCPw3EZZJZr+6KCN0HrNNZm0CnAP5eD0ASCCW8oDg
 +r1IIWs8CnWxDOZIh+PagqU6XcT+TqjLvkwo85juYopCzudYRupYDOjueOrtdW0VWX/M
 +EC7LYwwqPJrGi9+3YrPE9CViPg+KOJHlXBYUhusLpOhlxLjoR5FvFNaWW/zOQcSPyhu
 rVhO/UOJXcP1Mm63J5tn8BCKmymXPrnP+ju8mHfgf1mmb4nofTuw3eP0ilM0bHnhZfvn dQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmh3d52d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 11:55:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37MB0AB4030368;
        Tue, 22 Aug 2023 11:55:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm64rwmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 11:55:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg5Oj6nQvWDPR3tJls+ktjD/Nky3ItPqL0HXSeM/1DQPgfi7Mu55kv9lSu8fdk4SSBQa6orfWf/VN1YGkhDBqMGGwkdeYCyd0cHYphkMtJ/h0tRkSfhjT0SMGBo4aQ88NdqLswra/zJqi0njzLUL4YXuipaUdmLwZVNWaoC2yf8tUq1zvsf6e8POpmCWaRZqWXz+t9IGNdgAoTlemZF98b9+OU2HzMidrlVe8on8XlMLuwMDalYTshGkXA6a4Yv6Y6bzKuqExoOJTBOpTSPmuFeose8X3Dw6ZR8MXmcPFZ1Ulbm9brwEOmDAAv2hLJqVqOdFlPY34KMdJ1uywV+Uzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z793RJLgYmLOE3K88axZAD6pxtygwqDgBwMjQ0lmuvE=;
 b=kUBWH1A9K9QMVKUxTvH7yW2jhJX8Wyh2lplAgnk3KjLAfmR3foLAebCReQz0YeFDXxz5Kst44m2sFni4YfoB4lgKnLaCZrYbClQtvSyxX7EhsDEzHxXMDjhv/ZRLI8L3CrORDtXdzvAGZtL/zQMtFNuwQTbAIHQx4dl2pjVIHupidrwGS3w4AMt+5XENnoMnR1GwQ5wB0DKLz84kV6/n4Fw50Rs9ve/kAAITDHJU1O5fr8KirS9B68k02x8AEB3tl48MV2bFG45RRegOJJuO1xPnkGP2TXTe8l10fVIMJC8lQ0hEPtc3ZvqVVGTw5dpfXIUZ1UcfaUT68OYMBzgyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z793RJLgYmLOE3K88axZAD6pxtygwqDgBwMjQ0lmuvE=;
 b=YN+gHN9QQvHRapCk9VrXjXKQqcA73FETDYSLswWN91KQXey3RTxGEtgHG75hCVUU4+L758jSQZPgWr3LiOVfFSRwcDONc8TlHc3oR2/ggDdzxZ0RQUZLEuLO0+/4evh53UhBbpLTWXFHMunLCVmqlMNQvMoOEAaMc/zgz/7tINU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BY5PR10MB4291.namprd10.prod.outlook.com (2603:10b6:a03:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 11:55:40 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6699.025; Tue, 22 Aug 2023
 11:55:40 +0000
Message-ID: <e74ff009-4357-4718-3857-ec8920cf3ed3@oracle.com>
Date:   Tue, 22 Aug 2023 12:55:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Alan Maguire <alan.maguire@oracle.com>
Subject: Re: Dumping a struct to a buffer in an strace like style using BTF
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZN1pveIr5W1ulPHh@kernel.org>
 <372712cd-d825-e5f2-bd02-b2210c6ecf61@oracle.com>
 <ZN5ioUt7yxnctBnW@kernel.org>
Content-Language: en-GB
In-Reply-To: <ZN5ioUt7yxnctBnW@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0016.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::29) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BY5PR10MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: ea408003-bf51-48ac-d387-08dba306b4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGzbRHYFM+R/z1uSZaBU9agIcMjnjt52uwTrLQOtfBvMugbNYLm9rgQ5rDTqJSL8vu84ZV+S6yHo2xcLgqe98djoK4eroH/VWVv1pqtYBt7rdgxRJxghxu2Oz/4Q3ZglyiydH5STIg9Gy09jkpEDQxAZgdKTTxhRRX8JTU8o6NY5FZjtl8U707+6WWzxwpqBX37HLmM3fUb1w5kjvtjRIqkua1gRy2Lhh7OuZ7TVo2WcaNa/V2c8ET+myNwsy0fmb5iOuUEQLvBx0ZQtvq++jBIo1CRa77XvZtyhzUxACxiECGy333tUJP90hbL2/KMItc26owWV2Px2akrZr0ux6EXMeVK1LJbe4unqorAD09KZj1yiAY5T/R8AFNaSwbU4vv6SQRsHzaNA1yHkvCKGz1VeG61/sx9B/zfGgDc6Uz72GGo5z4Wui2fmfRBAcWZmRsKqK4vIoWGHRjjUK4EGtFrbaKkaluRckA9fhMadxtp1LiUWYgNKZsYk96aMHL4ZAC/ss4aXGjQ6PKS08/6Fqn6Ra8bUWAowtbxtA4ZSsJjeLFIEka965B9810azeU7R1bsD12ZbOWq3o0zsCy/2N2IHyIgKAkhxoCItzNkjV9ZWeLnLb37QSnu1c7Pnme+3pS7I4XjlURwozRwblO0UTZJb5S++EPfU09i506nMEflqc9Z2gh7zR+x8cE7QL4dS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(966005)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6486002)(53546011)(6506007)(83380400001)(30864003)(2906002)(86362001)(31686004)(31696002)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1kxcDN5VHJia0xyMlRXdmREc09NLzNhaGxTYWdScFFZbEExSHBKcjdrcTh1?=
 =?utf-8?B?LzQ3SnJIaGlXNlBQNnkrSjBIUWgzV3VHNE1xcnZZT05BNkIvYWo5T213Q1pZ?=
 =?utf-8?B?MnR4N0JqOTZFeXlOdDQyMzNGaFFCTm9VTkFPcUlVOHhscW5KSEtpWkNZbFdx?=
 =?utf-8?B?UXByaENORCt0MW40V0Y4TGxneU4vUDJzQjgzWVJ5eU1vbmd3SS9Rb2lKbTFL?=
 =?utf-8?B?eFFlVVltNW9uSlYwVkc5VWZNdTNJcDcvM094cFpaWVV4U3N1SlJ1ZkhkeWUz?=
 =?utf-8?B?VWdMM0xQcUxDS1VUcFV1VEYrS1ZyMHpzMndub2w1MzJjbFVmWHA2Umh2KzJT?=
 =?utf-8?B?L082dkZVbFRtdWQwQ09ONEtTdVp3UGp0T2JtaUNoTU5Eb3NjQkdmRHI1dDlj?=
 =?utf-8?B?MVBrYUVsMzk5cTZ5V3F5NVJnNDIzM0pFaGdORTBqSU1zV0JyTFZnNFZMdGF1?=
 =?utf-8?B?VE1xNlFvMjhDZjY5R2VaQVBQZEZxRnliK0R3Q2VPL3gvTGh4N1ZQdGxyUGVj?=
 =?utf-8?B?Mjk1eDh3OVBrcTMzTU5RODM0dy9ydU1za1FRSFVnN3hqU1c3TUtMSFlVZERj?=
 =?utf-8?B?dkUzRFR1a3M0QkNYYkVJS2c5cjMwQm5LL1Rzb2M2bjZYOStMR2xOMmRBT2lO?=
 =?utf-8?B?Z0JrOVl2KzkzT1lXUVFaY054KzJqSkRETHVRd0hQNElrSVVjQWlTeHNYa2lL?=
 =?utf-8?B?WnJzc3ZBMm5xeDMzR0lXMVo1L1d4WjlGMUFiRlFrM1dLMTQvclpBTzU4RnBB?=
 =?utf-8?B?ZkQvU2tIbmxYbGVJaVdTZGNuQmhyWWRndnlSUHpCVkhENklPVGNaV3FNeHZP?=
 =?utf-8?B?ZnZZWE5OYStyZEt0djE1RXVGNGFjdlgzQjRkS3lwZm5QRmhrTlAzTjV5NVJ6?=
 =?utf-8?B?bDZpSENwdlZhM2orM3RQRWdrS0o5QnBMeGduWGJ6eE0renh5VXE5YkdJYzZY?=
 =?utf-8?B?RnZFUXM0RnBRb0cvekloVTcxNDF0TnFLVW4wQzl6M0JRdmIvM3ViWlVUTW91?=
 =?utf-8?B?c1U5V3pjdEFQbGdHTzlFdmMyNUcrZDQwbW9jN3RWak1zcGhvYWdId0N1V1o4?=
 =?utf-8?B?bXZNajdoWFRNRDVvRlhBcEhlaHk3Qyt1SGt3b1JFTVJ3MEdjMkNJalFjbnV0?=
 =?utf-8?B?c1g5V1YrTGdEdng3NXJMU3ZBYXNiWGc2czQwK3Erc211N1l0WHBjN2VISldK?=
 =?utf-8?B?RVcwdnZoSlYxVjBCUU1rYjF5QXR4Zyt6RDN4UzBWZ2EvNzVzaERJVHFoUCtw?=
 =?utf-8?B?Q3RjSTJHVlNieTVhSjY4Zk80UW44M0wzdEJNbE8yWTQvNG8xTmJKcnRYMlBa?=
 =?utf-8?B?QmwzYVZKRmowWVI4Yzhuaks2QnlmNUMrVXVyOVo4em9Mb1JJMlpaQjdZRTky?=
 =?utf-8?B?UjNJL3Bub0hTTHVMYUJpWXQ5MnFrT3RwSkk5bGl0TUFNOVYvSkU3czgrMDda?=
 =?utf-8?B?dTZCYjB5VVZPWUp5aExPZGd3QjBIMXlRdTVmMm9pRFZ6emdicnlFZ2JNSURR?=
 =?utf-8?B?RjVYd3FYOE1rblJ3THZ5ekZRTld4MW8rTFVDbzY2Y0dkQVR6K0FKQmhSVkZ2?=
 =?utf-8?B?MjF3NHAxamU5WU9PekZlbkhJTTZQbmdCdmR5UVkxSXQvaXM0ZlVtelgvMlpq?=
 =?utf-8?B?WThjdUR4ZW9UdmtHYnlqNk9NWVBZemJxc2dQRGFGbUt4a1IrVkxDMXkrVkcx?=
 =?utf-8?B?SXRSQkRCb3lkZmJBUUJoNUpmNW1ncW14YUozdGpBdHl5bzRyL29XQlhEdUxm?=
 =?utf-8?B?VU9hRFp2a1pWbmJycXp3bmVlOHE5WEhuN1hBeDdrU0ZSMUU4L0FKbzJYbGNE?=
 =?utf-8?B?TllKeVo5ZHBDdndRMlUwTE5Vb3JQNFBmT1BVKzFHVGdoYWlnVWMyMXFQbG51?=
 =?utf-8?B?UnZnYlkyenBFRnpQQkdodnBJcE9NYVFSaE9oMThPRUE4Umd1UGJ3Y1VCSFUy?=
 =?utf-8?B?WmltSHNZR1dOclFjdi9sbGVPUlR4R0tNZUdUWURrTWlnRlVTZU5HOVJLd3Fs?=
 =?utf-8?B?VWhua3haRzRHYkNtTVNIYXBOOXN5L0M1ZlNSVDdueXRSZnhxNXdlclBKa0lC?=
 =?utf-8?B?R2MwcFFxMHBDUkZkNzVNOEZJWDNIdVB0aGtYUWF0QzBFZ2VhOVRMNFJ2RDV0?=
 =?utf-8?B?QzNjaFplalVid3lNK1A4d29aeVZ1MFdLMmZKd2VPMmY3YVQ0cm1FajY0VWlz?=
 =?utf-8?Q?25xxlJN4If2SXBxk2YQ2D6c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W9zgJqlJbG83FNghzna22QpkjIwrRLoR0ItKGiTnfWkFBCZiBSlmqGiyeTmq4UqtFlpRat+A5eM6Ic0DltzafEI4dCYGMEPZSEjWhR66Z5IxONj5ujimHsUT/nh4NIsSNheTcIFdyRFkf4hBZVDgaH7f0PcXZ8iuazlaf2ARxcLTPyYve8Os73tLnYqTuI10If7K3rgRjBMz/80G04TPZ+oFgSC9wg7Ou6PaLDmYh8oKKnH+K/82Nav2M7urQisR2knhJR0alG+loG81dpsdC6B/T0gLLX9cWd/mJNnsllSNg6UH8Mu3lWCv9x3BLIM36L+YUlqR4VwuKUM2I3NJrek13+8V4umVsSoMaJFJz8c/asmAK2iZDStN/kLAT4aleub89SlMeP8t9WKLEx77pE7oOoe/zSEWoxdZUhhmfOGowQDyRhFEFbxz92NVoJXpBWD2CzjExPSITZ4NdS/ogIH6H/J+mqG/Q81wObPrredMIPAWSZWUfpmflrn91n0Cfit85OFGxFKkcNiIt9/LVfRe2HTO8fc0givF2QvIgcDbwzpok/06ZRnnmAGQwiEYiOaA+jRWwtGU3G1FKzy2FPHcuCT16mOQvbc75w4P/6YSyHk0SMtVLfbRJrMXKW+3kCmFdv4lT94Qt55xg1m+p307WpzYakw83meYBJZNo79/Nun6Nd9KgoiLFHYuW4EeP/kCI6lGkB4waqSySIrVdneoWZPD1wnCPOSAiqVW3T9X5LNkwjIK4gDUwfAR+mNVMwECd5ZORWuo0BE35xTB0l7hX44dKCwjl62+e6CuMiDtZDgeu4poX0tRizMnt5n6ODaERqpwUt0dspWHvr2SoEZj7E0z3Y6LQwCEMU6WLiQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea408003-bf51-48ac-d387-08dba306b4b3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 11:55:40.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgFT4UaXdOb6ZbFW5ah4//gYmY1zd9jwjjN+RPz7DWgs/AEtOREzX6k3s25xMDhTGtd87sTnqeJpWWj52xG3Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_11,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220090
X-Proofpoint-ORIG-GUID: ufft32FvAXsZAD9WWKB5zUv12wJx-xNB
X-Proofpoint-GUID: ufft32FvAXsZAD9WWKB5zUv12wJx-xNB
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 19:10, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 17, 2023 at 09:57:31AM +0100, Alan Maguire escreveu:
>> hi Arnaldo
>>
>> On 17/08/2023 01:28, Arnaldo Carvalho de Melo wrote:
>>> Hi Alan,
>>>
>>> 	Something I planned to do since forever is to get the contents
>>> of syscall args and print in 'perf trace' using BTF, right now we have
>>> things like:
>>>
>>> [root@quaco ~]# perf trace -e connect* ssh localhost
>>>      0.000 ( 0.342 ms): ssh/438068 connect(fd: 3, uservaddr: { .family: INET, port: 22, addr: 127.0.0.1 }, addrlen: 16) = 0
>>> root@localhost's password:
>>>
>>> in perf-tools-next when building with BUILD_BPF_SKEL=1 that will hook
>>> into that specific syscall and collect the uservaddr sockaddr struct and
>>> then pretty print it.
>>>
>>> That is done manually (the last leg) in
>>> tools/perf/trace/beauty/sockaddr.c:
>>>
>>>   syscall_arg__scnprintf_augmented_sockaddr
>>>      af_scnprintfs[family](syscall pointer contents collected via BPF)
>>>
>>> which leads to struct sockaddr_in or sockaddr_in6 specific pretty
>>> printers, I wanted to do what these two struct specific pretty printers
>>> do but using BTF.
>>>
>>> I guess this is already available, but from a _really_ quick look at
>>> libbpf I couldn't find it, ideas?
>>>
>>
>> This would be great! If you take a look in btf_dump.c, there's
>>
>> int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
>>                              const void *data, size_t data_sz,
>>                              const struct btf_dump_type_data_opts *opts)
>>
>> This will dump a typed representation of the data, presuming it is of
>> the BTF type specified by id. You get output like
>>
>> (struct net){
>>   .passive = (refcount_t){
>>    .refs = (atomic_t){
>>    .counter = (int)2,                                       },
>> ...
>>
>> You need to call
>>
>> struct btf_dump *btf_dump__new(const struct btf *btf,
>>                                btf_dump_printf_fn_t printf_fn,
>>                                void *ctx,
>>                                const struct btf_dump_opts *opts)
>>
>>
>> ...first to get a struct btf_dump *; as you can see above you supply
>> your own print function. There are options to control indentation (tab
>> versus spaces), compactness, etc. If there's something else you need
>> from the perf side let me know and we can try and add it to libbpf.
>>
>> I coded up a proof-of-concept example using this stuff to dump kernel
>> function arguments; it's called ksnoop and is in bcc:
>>
>> https://github.com/iovisor/bcc/blob/master/libbpf-tools/ksnoop.bpf.c
>> https://github.com/iovisor/bcc/blob/master/libbpf-tools/ksnoop.c
>>
>> ...so that will probably help with the details. You probably want a
>> similar approach; something like
>>
>> - foreach syscall
>> 	- populate BPF map with vmlinux BTF ids of args/return types,
>> 	  and associated sizes of data to store + whether it is a
>> 	  pointer (since in that case we need to copy memory at pointer
>> 	  address)
> 
> Right, I think I tried this approach at some point, using the type info
> in the tracefs events format file, but had problems with the verifier. 
>

I can empathize; reassuring the verifier is where I spent most of my
time with ksnoop, and it turned out to be really tricky. Your idea of
starting with the userspace side first makes perfect sense, and maybe
once that's working we can see if we can generalize the syscall handling
in BPF context.

If you hit any issues with the libbpf interfaces, do let me know. They
haven't been exercised hugely so there's likely bugs lurking, and you
might have different needs in terms of data display that aren't
supported yet.

> The way it works now is that you craft one BPF prog per syscall
> signature, make it work, then 'perf trace' will look at all the other
> signatures, using the tracefs tracepoint type info (should move to BTF)
> and if they match, reuse that BPF prog:
> 
> [root@quaco ~]# perf trace -v --max-events=1 |& grep Reus
> Reusing "open" BPF sys_enter augmenter for "stat"
> Reusing "open" BPF sys_enter augmenter for "lstat"
> Reusing "open" BPF sys_enter augmenter for "access"
> Reusing "connect" BPF sys_enter augmenter for "accept"
> Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
> Reusing "connect" BPF sys_enter augmenter for "bind"
> Reusing "connect" BPF sys_enter augmenter for "getsockname"
> Reusing "connect" BPF sys_enter augmenter for "getpeername"
> Reusing "open" BPF sys_enter augmenter for "execve"
> Reusing "open" BPF sys_enter augmenter for "truncate"
> Reusing "open" BPF sys_enter augmenter for "chdir"
> Reusing "open" BPF sys_enter augmenter for "mkdir"
> Reusing "open" BPF sys_enter augmenter for "rmdir"
> Reusing "open" BPF sys_enter augmenter for "creat"
> Reusing "open" BPF sys_enter augmenter for "link"
> Reusing "open" BPF sys_enter augmenter for "unlink"
> Reusing "open" BPF sys_enter augmenter for "symlink"
> Reusing "open" BPF sys_enter augmenter for "readlink"
> Reusing "open" BPF sys_enter augmenter for "chmod"
> Reusing "open" BPF sys_enter augmenter for "chown"
> Reusing "open" BPF sys_enter augmenter for "lchown"
> Reusing "open" BPF sys_enter augmenter for "mknod"
> Reusing "open" BPF sys_enter augmenter for "statfs"
> Reusing "open" BPF sys_enter augmenter for "pivot_root"
> Reusing "open" BPF sys_enter augmenter for "chroot"
> Reusing "open" BPF sys_enter augmenter for "acct"
> Reusing "open" BPF sys_enter augmenter for "swapon"
> Reusing "open" BPF sys_enter augmenter for "swapoff"
> Reusing "open" BPF sys_enter augmenter for "delete_module"
> Reusing "open" BPF sys_enter augmenter for "setxattr"
> Reusing "open" BPF sys_enter augmenter for "lsetxattr"
> Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
> Reusing "open" BPF sys_enter augmenter for "getxattr"
> Reusing "open" BPF sys_enter augmenter for "lgetxattr"
> Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
> Reusing "open" BPF sys_enter augmenter for "listxattr"
> Reusing "open" BPF sys_enter augmenter for "llistxattr"
> Reusing "open" BPF sys_enter augmenter for "removexattr"
> Reusing "open" BPF sys_enter augmenter for "lremovexattr"
> Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
> Reusing "open" BPF sys_enter augmenter for "mq_open"
> Reusing "open" BPF sys_enter augmenter for "mq_unlink"
> Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
> Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
> Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
> Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
> Reusing "open" BPF sys_enter augmenter for "symlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
> Reusing "connect" BPF sys_enter augmenter for "accept4"
> Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
> Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
> Reusing "open" BPF sys_enter augmenter for "memfd_create"
> Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
> Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
> [root@quaco ~]#
> 
> [root@quaco ~]# perf trace -e access*,clock_nano*,connect*,perf_event* -a --max-events=40 perf stat -e dummy sleep 1
>      0.000 ( 0.007 ms): perf/470570 access(filename: "/etc/ld.so.preload", mode: R)                       = -1 ENOENT (No such file or directory)
>      9.319 ( 0.008 ms): perf/470570 access(filename: "/etc/selinux/config")                               = 0
>      9.826 ( 0.007 ms): perf/470570 access(filename: "/home/acme/etc/perfconfig", mode: R)                = -1 ENOENT (No such file or directory)
>     10.213 ( 0.019 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/software/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     10.786 ( 0.006 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/power/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     10.794 ( 0.004 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uprobe/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     10.800 ( 0.004 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_imc/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     16.520 ( 0.008 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/cstate_core/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     17.072 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_cbox_2/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     17.645 ( 0.008 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/breakpoint/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     18.058 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_cbox_0/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     18.626 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/tracepoint/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     19.040 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/cstate_pkg/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     19.673 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_arb/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     20.187 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/kprobe/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     20.636 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/i915/cpus", mode: R)  = -1 ENOENT (No such file or directory)
>     21.497 ( 0.008 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/msr/cpus", mode: R)   = -1 ENOENT (No such file or directory)
>     22.060 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_cbox_3/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     22.620 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/intel_pt/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     23.318 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_cbox_1/cpus", mode: R) = -1 ENOENT (No such file or directory)
>     24.483 (13.009 ms): perf/470570 perf_event_open(attr_uptr: { type: 1 (PERF_TYPE_SOFTWARE), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 470571 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
>     38.183 ( 0.005 ms): sleep/470571 access(filename: "/etc/ld.so.preload", mode: R)                       = -1 ENOENT (No such file or directory)
>          ? (         ): pool-gsd-smart/3641  ... [continued]: clock_nanosleep())                                  = 0
>     38.717 (         ): sleep/470571 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd966420b0) ...
>     38.717 (1000.132 ms): sleep/470571  ... [continued]: clock_nanosleep())                                  = 0
> 
>  Performance counter stats for 'sleep 1':
> 
>                  0      dummy                                                                 
> 
>        1.001968793 seconds time elapsed
> 
>        0.000853000 seconds user
>        0.000795000 seconds sys
> 
> 
> [root@quaco ~]#
> 
> As in some cases BTF nor the tracefs format file can help, as in write,
> that has "const char *" as the type for its "buf" arg, that has the size
> as the third argument, so we need to craft the BPF program for it.
> 
> I'll try first to work on the userspace use of BTF to pretty print the
> payload collected.
> 
>> Then the bpf program can use that info to copy the right amount of
>> memory to the associated buffer and dump it to userspace for display.
>>
>> This would allow you to have a generic augmented raw syscall BPF
>> program; it would just need a way to look up the appropriate map entry
>> describing its arguments etc. ksnoop does this by storing the map
>> entries by function address, and in kprobe context it then looks up the
>> instruction pointer to get the right map entry.
>>
>> There's more info at
>>
>> https://blogs.oracle.com/linux/post/kernel-data-centric-tracing
> 
> All cool stuff! I'll try and use it in 'perf trace'.
> 
> ksnoop is really great, made me remind of something I did a long time
> ago, before BPF/BTF/kprobes (and then using kprobes), that produced
> this:
> 
> http://vger.kernel.org/~acme/ostra/callgraphs/sock/0xf61bf500/
> 
> Not centered on collecting function arguments and pretty printing them,
> but on integer types in a particular class that one wanted to see how
> evolved over its lifetime.
>

Very nice! A diff-style output is something that we could think about
adding to the BTF dump interfaces if it's useful (diff the data
structure on entry/return, showing only changes). Thanks!

Alan

> - Arnaldo
