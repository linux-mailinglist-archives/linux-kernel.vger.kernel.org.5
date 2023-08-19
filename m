Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502807819A2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjHSNGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjHSNGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:06:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31581A28E;
        Sat, 19 Aug 2023 06:04:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37J4aBC6005053;
        Sat, 19 Aug 2023 13:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QG3CVi5w1JeEZ53bdN4ipWZ+QP2uldbxiD4p42bjmMg=;
 b=TmOuRseooNwX5FI5GAbbJG5EIoWxfEj12lAcssaWLdoqrraHtvWMgcqwvk4EE9xQ8g9n
 8+0UTf6itXj4s3seH1T9qIQzJvBObn3TjNo/yCf4QfxCQHppvNrRi75G0NoWh0Ajvr4m
 oR3zMNwrYf8d5H8mfE6/XfLz8RqICKT0hcusKXibDokA7Th2YweKB22nCvFsrp1Ua3QX
 zXxNnNmGzbnQFmg+jMg9nbEpo+ljkDCMHwrdwiAAH/emXDaB26uJDplxsR68DQ2VG7GL
 CYznBG32WlIxW3fezng5WVKe2NM2XqNUEdPXGPBqEyN6kE/8/iCyWFb3FfkbUfttPmYm lw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnma0ekj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Aug 2023 13:03:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37JBvvTF007705;
        Sat, 19 Aug 2023 13:03:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm61uw18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Aug 2023 13:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTPW+S5dMKW/+KQUSW9kH3XN5JJIZIpA8y6Oa+dxGhO1i9CXCmx/xKN6WEHfctoLYn91z5CKy6L+dMf5LlsQF5zN14sEWq91tEftSMjh4vqoGBjxDznH6ZLt4Z4/yJPToHa+xOVING5BoIEBOBtnWtHH/1I5hkQCvqIbHzpeojr9IsTHCLqg4cZBSGN/+fDPv6zcLKaSyq14GGSSbSDuY9j4oLDz5nplwt+PHvcVTCeAOtLKYYXe/mMzjiZxOeEdU5Qie+AwP/KZhZQgIpEtvRBP7L7zoQH3TrLYCexXtvM53PVAgWY3nbFOpeBRx4zibUZ7RtGz1M7zklTTuuwrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QG3CVi5w1JeEZ53bdN4ipWZ+QP2uldbxiD4p42bjmMg=;
 b=gnhhUMP6oiYmmh3WwrHehQ7ubaE6MTIlYPBdPPexwU6mIm4AwvDWxrykOQ8SApwC2xvKMFjQgFEhkw6NLZgwj8R3e2njFqEfQ+DqnI8fubgwu2pr/l6cc9kB4uLBr6PERr9DBLB9SvIaqlK427YRK54q17V64B2m/0MeElw5kaKL4Xne/0ssnDSyp/K5X2b6i0pKjs02M55q9AlQ885dIUla3XZSJfSNgbFn/dBkz1WIhE9JhW0RBa2y6peNV1sGgF42Xugt5qLFZDlKTYrrS0n7ae6VrW7nSDoZhc6XZBBqWH00OrVTdbNIgEpkoLT9MvlTvupTyikpwMCVlxYJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QG3CVi5w1JeEZ53bdN4ipWZ+QP2uldbxiD4p42bjmMg=;
 b=wKq78clKLAdV+7J2czuIkvV+Z+tYa+y5nbkvypa8uqWHFdVTqfnCGTfFuS0Zh8IrydU5l69tazSylxHcngJ6Gh3nsjP29LvpfyJtGp83ZWnBh3ki5H0jaxzhNiZdq2sK6J2/YDLaS0QzImeLVoigSS4ZeRKH/v1eecVeVED4yBo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7537.namprd10.prod.outlook.com (2603:10b6:208:457::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 13:03:36 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 13:03:36 +0000
Message-ID: <4c6cda5e-4cdc-6c4a-891e-162ec3ba0210@oracle.com>
Date:   Sat, 19 Aug 2023 08:03:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [BUG resend next-20230818] error: 'prepare_elf_headers' defined
 but not used
Content-Language: en-US
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Cc:     sfr@canb.auug.org.au, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, sourabhjain@linux.ibm.com, hbathini@linux.ibm.com,
        bhe@redhat.com
References: <08fc20ef-854d-404a-b2f2-75941eeeccf8@paulmck-laptop>
 <4a991983-da2e-4fcd-965c-5b65de6700da@paulmck-laptop>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <4a991983-da2e-4fcd-965c-5b65de6700da@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0102.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::17) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: d6987d96-51a9-4316-c4c7-08dba0b4b312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaabkjL9oTzlsdMZVTRzc8BsG9a5HJiY4obE8qFOjsUQd6I3T7neclKj/ttNQDmOilTorONjeZ89k6pimUADisQCbPJ+CR6C7CTm/CbcK2hqKaCu6tihLTw3RKNHKD7DK+tiZq2R7RTI8wRlRhKKNstp8HLRX9C1JYVdWlKsQjwPJVoXYEt2rJmxKImCKFY2pqIYHfS27uMYbY3z2PZAVf46VPTV0nNj+xz+v+oisYNC0mNymrVyAMZQTQPEVsO3dniC4q9NGv6yyD4vSWwk0cmZgEIk0bM9zsZ53jPl0g2Qu/ZfoSkChg6aYzb7yjNZRp6GSMpG0lfG5zOhp9nNiutF5431zbTc7R3I6kRKyFAy5Vt03cUxTfOM7gc9iJcG5UiN3W51JkOae5YdoX/hlFGjLVOvL/OCjHfqMFSq3G7u0sJh/miev8wKDzzOM4EFu2jIj2fHxhCJ56Q1czO9Ye7PnXQPHmDfhFNjbmhsz/IhlMz862ndzEg+uua2hJxxkDEkGGOxcTTFgDFBUFJ38l27TqQ+iG/yJzR9orH1CbaRxdM84gToeEjNNYY6hFUB/Iyz30JPVdXBQwI1C9F9YcFbEp+8IM4vnLpoA1yTBAi6p/rx7Jg+BcjgIoDVQkIoVdnuWzM4N/UtDohH2WqhTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(66476007)(66556008)(66946007)(316002)(6512007)(8676002)(8936002)(2616005)(4326008)(41300700001)(36756003)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(2906002)(7416002)(86362001)(31696002)(31686004)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDNEWS9XeDVDckJjSlc3SVNpOU5seEZZdktVVldTeXZ3cmdVd0V0eElMd2p6?=
 =?utf-8?B?YUF3eDhxeG5rb2JCSjkwV2dtUDB1dTY2cFRiQXZDOHVTVUhkM0Q0cWFVTHIv?=
 =?utf-8?B?anVNU1VYSUhMU1ZpRHNZcXh0dFpsbVp3WDVpWGdMS3VsdmNndSt5TEdzaUk4?=
 =?utf-8?B?RVdFUWV2RnFQS2hJM2JjRjdkdmthU0NSYzVGckd0Yk94cFNycW5xREN6ZXRp?=
 =?utf-8?B?Y0thOU9NZXQ3RUQ2RWF1dDB3SWtQeS9rUzV5U0JTTm5NaWlKM1B5NVFpcGEz?=
 =?utf-8?B?STc5ZUpQaWdnRy9WQ0Qwbm1lYi9IWDhTVDJRUUFZeHlHLzRtZzNnOEhETWZ3?=
 =?utf-8?B?YXE5SXdiN0I2SUxPZmJrL2V0dkZ0YlY1SktKaUQyaUJRbVpyTEtxRUtjV2o5?=
 =?utf-8?B?dW1sVGNIajl3b1dvMk5lR0xrTlJrUDZyQVRTWnZJakdNSzE4SVgvMEVKbzg1?=
 =?utf-8?B?S0tzWVZJSFoxdGlEMEtwRHF0SEVwSGUySGJYblhCWS83eTZ5bkdqMW5ObTVR?=
 =?utf-8?B?c0EvbFM2Y0x4SnUveGtubVV2a05QMlBYTEhCZExjN3VOSHFVTjVrSzVaZ09Q?=
 =?utf-8?B?UnkyNHJvc0pJOVd5Sk1tWFd4aW5Dd3FvczB2VFNtYzcvckJ2U3h5VStHY2xZ?=
 =?utf-8?B?RDN4UHVtNEoyUi9mRmJZYkJhVFFhMFh6RXMzWW1KUmorRzlGUFhUK0VwWmx6?=
 =?utf-8?B?bE9NcFJNdFBZWWExalNRd253MlhXOG9sdHNhcisyWHQ0aXhxRjBySVNSUDNF?=
 =?utf-8?B?QTh5aWNBMHk0RElNdjBKdDlrcmw2TGlmTGJBTS83NGl1Q0I2SHJHcFk4R1JL?=
 =?utf-8?B?WW5weHV4OE5MbG5NdWdFZ29RajAvbHV1MjMxTDBMWFFtR3lmdEVEL3ZZVzMz?=
 =?utf-8?B?OW4vSDZ5NnZrVkRZaHBwYXk5S0dsU0Q2ekgvUHE5L1Q0eWN5UWVUM016Wlpq?=
 =?utf-8?B?TmZhUFJrdmlYT2ZMWDZEajRkRTZDcjlLd01hckNweVNobDAvbThqeG1KWGFr?=
 =?utf-8?B?WUlZUGVPZDE5SUc0TFJaOGtySzlDWUJXUWNyaEJoWVNyREVTSnBVU3JvMkRp?=
 =?utf-8?B?MllZTEsvbk9ZK0QyWlFOU2hVREJyL3QzaEFRSHVqckh4Si9mZlpkSHNva0F1?=
 =?utf-8?B?NVhsQzRLSkc0anpOUnVYYVRCMUdUZTV3ODFPNi9PUS9rbTNVUTJvV0dDMWlV?=
 =?utf-8?B?Yi9tWFNFNlBqZGlFM0xaVGd6c1o4cUhTcFZ2NHB3Wm5UTVRIOHZhT2NMT2FD?=
 =?utf-8?B?NlpUcGZDNDB5ZVZSMnZUNTcvZjBvTk1LNHY0SllQK2tna1hJdVVSNy9WNHZw?=
 =?utf-8?B?ZjlKUm93ZmZ1OWxSMHczWWVibnh5TTV0WU1STWJtU3l1RHdEckJjV2Zjdmta?=
 =?utf-8?B?YjRzZlhaYlA5cHRTdkt3cFR5U050Tk1yV0Vwd0ZiM2F3MVJLRXF1UTlzUWEz?=
 =?utf-8?B?MHhsNTJrRXZmbFdHRExqWnB1VXl1ZDVkSFdZMGltUmozUDVVSWl5bWw0aWVS?=
 =?utf-8?B?V3BRbUFGaGI4bW5mREp5bk1ob2dybXpUeFJyUlFGem1SSlJSRUNuQ09UVE1R?=
 =?utf-8?B?VzFPTTA2QXM4MlVHcjNrbzl4Wlc4QnVZZlZCWWVmM1JSMzNiMlV3c3U5NHEv?=
 =?utf-8?B?cFNTcnVXNHUremRXayt3aEpqZHRlTU9nZDRBcFVKTUVjUlRCVEVjYWpncHlh?=
 =?utf-8?B?L05MZkQ3cE9QSEVPZHQzYnBNd2hMSXllZTl3OWNtcVB1eW9ZcnZ0bnVyc0dp?=
 =?utf-8?B?RzZqV0lTdUFLbytYSktHck1rcHpjdHRuT2FhY0tHS0Z4VW1wWjMxaDh5aldz?=
 =?utf-8?B?ZlFXZEdLQWliaWxOcEFGWVJvdExwK2xvVm9LL2ZLTEx0Y0xyeTVSWlh2YjBu?=
 =?utf-8?B?blR6ZlArS0p2bW9DdmlMaE05NGIxOTFyYWtVRlVrZndTSndsNW55STBBblk3?=
 =?utf-8?B?WTR0bjhwUFVna1kzNzJPT3FWcWQrZ0ozbEI5emtRQ0xydDZEN0Y3TTNiYjdw?=
 =?utf-8?B?SytmS2RmTi9YUWxXSGpvd0Y2OEM2RytpUnQzbk4zdW0zcU1KYzRGS2VTVzNt?=
 =?utf-8?B?bzNENTEyS29WREdNVzNzNCtqVXhaV1JreWM2Q2hJcFlWMVJ5RmZpTU1sc3JR?=
 =?utf-8?B?bUxCNXptR1lsb0p5WEV2UXRrK1RNdEVBL1NXYXRqYTUwTnY2VEo0RkVSejA5?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T3owUENLUDU0bjd5RU83bWZTSkFJTFFldDhTb25KQ2c4enJYSWpzd3AvT3VH?=
 =?utf-8?B?VVg0TEI1aUUwNkNydjMvWHc3MnYwUktoeUZRTnhBc25UUHprSXh1REZoM1dG?=
 =?utf-8?B?amw3Rk4rS1U0cTRxMk5BZW5jSS8xTnFMOGt6Z0doT1dJV09nMWFJKzBwWEJt?=
 =?utf-8?B?R1RLRENiWmg2SXBNa1h1VFFMVWNtaDl5UTJHZUd4ajVwYUlra0d0cU9Xbith?=
 =?utf-8?B?eEt5em9TbWtRQWdwTVF4elpwOVU2cnRRSVhNejNEOURzNWRUQmZScm9yN0tm?=
 =?utf-8?B?TFppTWs1ZjFsNFJPTkRmUndxMm81Ykc4RUVsSDJYOEtnL3l3TzZvRkZzUFFn?=
 =?utf-8?B?YmVzRldib1dna0VXV0lrek5kVUhTQlNzR2NZYlVmM05oaU5CU0FFV2dXL3I1?=
 =?utf-8?B?NlFzUzROMWE1OFNKanpEem5vZnptWnBnZUN6clhsa1h6RERaVVBqSlpoRldi?=
 =?utf-8?B?WGtpVEovVUJXZTlZT3BsSFpISUx0ak9tblBzOWZkWUxEM3ByNThlUzVCNzJX?=
 =?utf-8?B?U2NBTkNNVFpqY0JiZExtWTRaZWFQaWZTRklKQnVCMWVuMEhnYjA1VzRBUWsv?=
 =?utf-8?B?Q2pKVjJyWHVhZE9oZlpNWXN3eG5CRlR4eEhraTZKT21VRFovYWxmYlNZMkFB?=
 =?utf-8?B?NThLdUlmQ3phU2ExdmwwYWd0MVFRZVFWb3NnZXNKTWF1Ukp0UlVWRENlQWc2?=
 =?utf-8?B?d25udWFEdnU5Mnk2dGhqelFDS2JhZnNEZktrMm1vNVhjV2o4Nis0a0tYTnM0?=
 =?utf-8?B?ekYyU0tGZVJKUDlNaDdZUTZMZ2plMjBoS3JGWTNMMHlWbnJOQ0QzMzhaRjg4?=
 =?utf-8?B?ejNUcHgrRUk1ZXo5K1Zjc2VwMTlJUzIzQWl4cG5zaGh0SnlxUW04aWt0eUEv?=
 =?utf-8?B?MDRFYkJzOHUxV2NMZWgybnlha3pPbUVoK2hTVHlVd0U3dllOYmNuRFBvcUg2?=
 =?utf-8?B?bGU1OUxZS3d3cUhUSFc5OWZjeWlieVZncnM0VUFFbFNsd2ZSUGlxUlhkRWM3?=
 =?utf-8?B?Z25nb3VjNEZraEgxbHlmZEtYMGN5N3o5eVlXMUxFYjFteUFpV0xvZGNHRnJE?=
 =?utf-8?B?YmpOc0hjL0VUcHRBUENrNDBxekRjODFoeXhHTzBzUGNzbDh4eU9TZkNNcmJM?=
 =?utf-8?B?ZmF2VVNMZ0Y0ZjhlK3lrSThwdVl2MUlzTFJMYkZzWGVMenBtSlV5VGU5Qm5j?=
 =?utf-8?B?bnV3c01lclFhWlJJVFZ6aS9kdkFRU29zOHBGZ05aY0MrVDNvb2wrZkpkWjl0?=
 =?utf-8?B?S041dGM0c3hpclFjeTRKQVB6MGxjRDJzVHNRSHJ0c2VYUkNueHk2ajdSa05U?=
 =?utf-8?B?SUxOVGkxSFNtRmlPd1VjYkFPN2ZQN3dvakk2MmhhL2hMNVoxcjBwVXNmYVJF?=
 =?utf-8?Q?6ynmlflCkG7VK6QH+aETEdnaVBjWgOLM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6987d96-51a9-4316-c4c7-08dba0b4b312
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 13:03:36.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGnkNMxoQckgTsLR8qxwnZKM+deCdXVTMjagbJT8Mq7hcf9wkzf+l57Tu7mELOVwXwKd4yFhdu21pn3XLeR7cQ5e3rNcY1sxWvwhNczUjLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-19_13,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308190125
X-Proofpoint-ORIG-GUID: cTq5SvLBVfCmX5dPX5nPu-LAlhr_rslq
X-Proofpoint-GUID: cTq5SvLBVfCmX5dPX5nPu-LAlhr_rslq
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/23 21:28, Paul E. McKenney wrote:
> Hello!
> 
> This morning's rcutorture testing on next-20230818 complained about
> prepare_elf_headers() being defined but unused on several rcutorture
> scenarios.  The patch below makes rcutorture happy, but might or might
> not be a proper fix.
> 
> This is a resend adding a few more people on CC, given a possible
> relationship to 9f1f399ca999 ("x86/crash: add x86 crash hotplug support").
> 
> Thoughts?
> 
> 							Thanx, Paul
> 
Paul,
Any chance I could get a pointer to one of the failing
kernel .config files for the rcutorture case?
Thanks!
eric

> ------------------------------------------------------------------------
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 1d0f824559fce..926c39e22387b 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -127,7 +127,8 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>   	crash_save_cpu(regs, safe_smp_processor_id());
>   }
>   
> -#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)
> +#if (defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)) && defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
> +
>   static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>   {
>   	unsigned int *nr_ranges = arg;
