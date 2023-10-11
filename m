Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8276D7C573A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjJKOpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjJKOpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:45:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570F90
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czP63s0b62Mrq1FqPb/mkC+x0vI3pu0p6mdblV0LTwKeCgGFGFZ6phK8zEKkKV5fsFrpvc3zvv0bXeJ05wltf9Hh5ETsWlCD6rLjYqRDZME2kX3BFusjK3s1RCzKwmUaYYe49DORb3BvvyCwkqnIk2+AC8lFkKi4hxliZ4FbJMll2hAEVL5Sm8wa03C2Obg1BIOKxmSijxmT4yb2dVsqCTCa8ZBuxK5E7DQRaF0mYv6bo8a0/4KLV21HGtMLKZ14q0ezLJWbuYkclspU7+pZGfyn6FpwC4YSRVvg/+aKpUknpo/hDtBfKKvvmOkcroVr4EVmVovqPbCiox9ntzhkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdKMvPY6y7UtotWj9BU5sRKk/8EyqXg3EQ/ASnKlSJM=;
 b=fnXMnTLOQVMFXl3+5T5gFdG2+dcwdlWsD9STnrrX40iDoa2smfR7alf74hdV3iIU3u66hTayWd9rUodJYiQWPv5jvX138e38hoNnR294n0DMIMtvHfWluxofM6kmw5kg70ZoulYkPyR2y518SAZWDtRSxWWFJ3F1oCK/YWpi2QLzFfwcoXCpyEXGM9qsDdzWbr7wMWcLmztmA1S0PtyeDfsLDo5lvJSOyZ+T4Oknqq+OswStel657SMhSvjF+qW0jyzlMZPojc1n1YwcAcrGiOS6ZHYCUkzTw/GCnCKwEgwKkRX+SIAZqVyfSTBxGKhZdgDOjSIACeRW/28inegtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdKMvPY6y7UtotWj9BU5sRKk/8EyqXg3EQ/ASnKlSJM=;
 b=AwAVGzFpBzR9txhT/5h/b30vEQjxab3S3GGN7cWFimNrLd4bzv2JKPtC4VT/hHDoJlLu7t7dFB/mG5V2J3iMfYD7/w6t7urbJYFoRpAG+7rlBaQD3f7w+nQbd3nRAw3+eKlWMoYwc7mjTSSFNeIIiNfF0ifn+NK4u7El74DywTBRoK+G/vKWVxnsvi76Vetkbw86+0lNXPWC1xvpQrhp4gDEltHfMVksBH/Sb7Xl2bGvsvfh1fa287ymzkX2VvdLWsHc79ES4v/0ju1v6lJ7jQOCJj8dMM70tfMyjfhSmbM0RxdPzg3zlJ6JA9bv3FRsTPwQe0D7VnM+r/uuboVqaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8107.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Wed, 11 Oct
 2023 14:45:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 14:45:32 +0000
Message-ID: <a9515560-32bc-4f3b-a36c-87f7242081a9@siemens.com>
Date:   Wed, 11 Oct 2023 16:45:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tee: optee: Fix supplicant based device enumeration
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org
Cc:     jens.wiklander@linaro.org, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>
References: <20230728134832.326467-1-sumit.garg@linaro.org>
 <CAFA6WYP7hgRWS_gp2AFEWDs27aOeUndB6+1dh95TtW2s1N+5Ag@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFA6WYP7hgRWS_gp2AFEWDs27aOeUndB6+1dh95TtW2s1N+5Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ecb8e7d-936e-4a69-1b68-08dbca68b845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12qakA3V1CXF6fraGnyHwgF/9sPn01Frdxi+USULqfrbAESmTOUKFzupyKKXtTIc4urSS+07p/Ao4ZsNlKg2Z0rHNM2wwTNw4n36yO6xDgN5+GRuiufvLsv2g5X8jKzs0YAA/Z4P0EXFVVGVXiWBORsHp1J3SkqrHW/y9Mngkjy+ZcuzDCYZTLlvUFsZpGTDigk3scVXXSlC6pnhmG3BqBpPZjpYQnlkAEuFP1sLH/LlsEXNMjDB8iR2uYgTuZh39upvWh4s4A9cZ7YoKaB+V9d9S+zEIa7xol/ajBCHROhTxxsA0BuKnq9fZC20/Wq0x9kYXVQoRm3zXd4An3T5mcL1LZCR5rmKsANCeobCHpxlfCWzvdJ7OE9CCApZGXuarZzUpoS2ONZpbyPhzroeS96/ISEgcyngTgiJOnSKy1IEWJxFZO+fUAfFMzk9CQ6Y1kUXAFLA9lQ6ZAMvg4Beg6X3BORvGJW3bLG8jp74zEVBr5XNrPpObFX2xX8dxSB0UMETxPrX49IsV+K6MobY2kfxXh8MMyQwdRdxpfpr7RiQ8mqxsEFsL6nJhqvI8BQFsLJMGtXnk12fI9ejRplcImW0g9K2R43o3fSFnnqedlM+D4vdVygKmwKe1T5jLCAq+wupU76cUCcpe967RS4KNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66556008)(66946007)(66476007)(31686004)(316002)(4326008)(8936002)(8676002)(41300700001)(36756003)(38100700002)(82960400001)(5660300002)(7416002)(6512007)(2906002)(44832011)(6486002)(966005)(26005)(2616005)(478600001)(6666004)(53546011)(86362001)(31696002)(107886003)(83380400001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDFuVitQWTZ1em1tT0NDQ1Qxb1BoMHV6eTVjdUU3OXdPS1RDT0dNbXBaSHY0?=
 =?utf-8?B?RXRkMkZBbVBvcU5rL3F1YldWdVRUdHF6OXN6QVRLUS9rV0xxKzBhWERzU2s0?=
 =?utf-8?B?ejg2N3ErajliQXFpSWpnWkk1aEJ0aDZOLzQrZXlLUGFCWXd4UHo1UDBRaGgx?=
 =?utf-8?B?aTBSb0hVRUwvWkh1ck1wbUJoSHhjTzRBZXNPaDFiaktvY1Y4TjdNcWpXY0xs?=
 =?utf-8?B?T2NFOXNuUytLUXFPanJSQm5WSmpmUE93TzBHSFcxejZ2ZkhrRnpmSkNPbTFq?=
 =?utf-8?B?aG95bFBKTE9iT1R5SmV4TndKNlMrVlZTWVVJTk5lcHdXbUxQcmdWN2lGOWtx?=
 =?utf-8?B?cEVaZmVSd2hrc2VINHpOR3hZbjZONitKaUJqR00wM0VMb3VwZlg1UUNEcXdv?=
 =?utf-8?B?SE9oS3A2YURuY2t5UUxNS0pHd3VSbGxKZUxyRHFDMnZmQmcxanZvbDRLSUU1?=
 =?utf-8?B?elQxbEZJSWJkWE1MaVUxVG1WaTVHOEczbXppUVNuTUhFdjhJZXZ1UmRzSzA0?=
 =?utf-8?B?Z2pseVczWjVURjhIakJQTUl2MmJkOGdhSGFUYlkyOTdnTHZFelplTWk0VUdB?=
 =?utf-8?B?TWU2enZHYmM4K0pGbUJqdXJYdXlwY0V4RkkxcHZtVzVxWVhQZGhvWVRMV1JV?=
 =?utf-8?B?TWFWUW1zNFhxM0hWVTJCUEliU05LbzdjcG5aZCtsay9OdlhiL2ZOOGJQNzdj?=
 =?utf-8?B?VEljTGkyek1ZeFROczJFSUQ0NkZEY2ZrMDdJUWRYOVQ2V3J4TWRTekJaWjZi?=
 =?utf-8?B?dWcwdUViaC8vOEpOTlVxMStvZzJkaFhoUVlXT24rMXRPOGpnQWhQS1FiWS9w?=
 =?utf-8?B?ODVGUGdaRkRNVy9nVjdQaHVIMmsreW9EOWhMUk55Q2liYnBoVVgxSXhBNTFh?=
 =?utf-8?B?bFNTRkpOZ3JvWUQrMEVxSXdTamptak56VmlRaFI5ai9kYXV0bk1ReDg4eE1J?=
 =?utf-8?B?aU9MM0RNaFVCRXdlcmx2b2FoU0pSNmUwMVN3elBjMU16dEVpdk1WeGhhOGtV?=
 =?utf-8?B?MXcrN3gwN21FbUswdHgvaFczSVgxZXd0NitPdWQvYlVJVjZlbUgzMmFJZ01U?=
 =?utf-8?B?Qng4SEZLWFZwc2I4akl1UDVObWphZFFNZ00vV0tXOWk4angwUEtQU3FCOUxT?=
 =?utf-8?B?R0ZaWkNVb1ZKUXFycWFNQjZYc3h1L3dmWlpQVFJwUjFpRUgrUkw5N09SL2Qx?=
 =?utf-8?B?VWlWVWNqZlRXRDZ5RVJsa2RlZWF1U2RNY2tISW95SW14b3NLVURtMzh4b0ZT?=
 =?utf-8?B?aTgxZXF0VVpRYnZaOW9WTVJOVFhTcnNqTUE4YmR4bnYxMms2S25oTzRnUCti?=
 =?utf-8?B?eU5zT21oVVFFNnhLQVdvQzVvQ2NrcVJGeGVEeTFxZDF6ME1DdzdkZWFHQkh4?=
 =?utf-8?B?elRsRnBoeEVwN283WUpXYndXbmJ5MFIzSjVGekFyZ2w3dHMrNUZwT0Q0NlVE?=
 =?utf-8?B?L1diUW5PZXhTNlpqUmxaTXJmenJOeHBoOEg5TGFUaEVDcWhSTWpIbmtuOCt3?=
 =?utf-8?B?WXFYTFNCMWVyZXVlRm9wQ3RGdVlRKzlGTWc0VjYzZlFiNlJYaStlcU5NUVc5?=
 =?utf-8?B?L2hyNDkvcVR3eFg3THRhejdhMDVidHVDUTdGLzY4YnYwd1VOUXpac3J1UTE1?=
 =?utf-8?B?bmdlQVJNdk9FNi82SzAxZnhjSWE2c2x2dVdpQXN1Z0lRMGVKbk83cHVpS3lm?=
 =?utf-8?B?THNJWmV5VUJKYThaWFI2SGRFV2QzanBSMkF3cUpLU0Z1UFpQdWZDc1ZzdnFI?=
 =?utf-8?B?UTVlaUpaREN1bkNYNzBKM05PRHVYejdMWlZVVXh2NDFGS3U3bWVEZjEreXBt?=
 =?utf-8?B?RWd0NDNmR1g1ZWJFN1NkdzVxYk9BNVhBYlBLOEZtSXZQWjBreTFESmk5dE01?=
 =?utf-8?B?Q1BMYWZHQVhoR3U0N0s5WUZqdUwzcXhtQ00zRFhhQ2I1ek5wMTFvck1BbURk?=
 =?utf-8?B?R05SQm9Ya3RsbjJvWExpRzhXM3RBRlVEYy9qTERjTVJIOTR0bnk3WG9PVmlt?=
 =?utf-8?B?RDUvdDFqdDFmNkxWK1daMTE1YmE2eEYrb2RXbWtZV05LeE5zdWhSTjFNUEhm?=
 =?utf-8?B?OFExODJ0ejJabTA2d3lha1A4aFF0dXI0OVNLV3libnVMMzNURHg2NlMzUDF6?=
 =?utf-8?B?clNOdTRYZVNPenVubS9CU3NHYmNraHA4ZGtPTC9iV1JzYmxuMCtsMHRCS09M?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecb8e7d-936e-4a69-1b68-08dbca68b845
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 14:45:32.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJLE/lVlcvfJUQHE4XG5VAlU4QPKv7GGd9SgyuS9j4AmwMIsm/6SYlm64huuMmEVkntWA2rU/cZ9zhzH9pBGeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8107
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.23 13:03, Sumit Garg wrote:
> Hi Jan,
> 
> On Fri, 28 Jul 2023 at 19:18, Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> Currently supplicant dependent optee device enumeration only registers
>> devices whenever tee-supplicant is invoked for the first time. But it
>> forgets to remove devices when tee-supplicant daemon stops running and
>> closes its context gracefully. This leads to following error for fTPM
>> driver during reboot/shutdown:
>>
>> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
>>
>> Fix this by separating supplicant dependent devices so that the
>> user-space service can detach supplicant devices before closing the
>> supplicant. While at it use the global system workqueue for OP-TEE bus
>> scanning work rather than our own custom one.
>>
>> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Link: https://github.com/OP-TEE/optee_os/issues/6094
> 
> I see you have marked this issue as resolved. It would be good to have
> your tested-by tag if it works for you.
> 

Sorry for this very late reply. We finally validated that this works
fine for us, though only over 6.1, our current test target. I hope we
can enable tip of tree soon as well. But I think I can still add my

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Technology
Linux Expert Center

