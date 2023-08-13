Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E900877AB07
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 22:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjHMUCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 16:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjHMUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 16:02:11 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F1910F6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 13:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9pPNbaEkkymAYuihFDS6wSSC/oSDCi/sH2O/rS3vDvNo578xZL2bmUhybk1WQVzQ9t0jak1HRb13JfMP/qaYIUBcmDqQUlfsCTWN10QjPMya4+ev/ijHjXqNnneZRGOud2zsDkYorLOS5VwdD1u6OhsOtfqmVYEK1+3Ar5hB3nu0wBGG5NyOrF73TNb/5rXLNkRzM67b5vRaDs+x+UHJr1wd0ITk6PSbMxTXLpc5T0uDAC1o8x/VR/0BWuMpxJtrYIOl3egR2DosjILNRmAgaBWOaVzhZX7bb8OUSp6kGLqKiLvxunKmXbD6gcuSsAxTzboDi5LC3ctB8DIuOy2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY+G2voSLSO0Pr2YB4XgYW7CS1SsLVcwMkzcXSTrwtg=;
 b=QXRDDPi/vYli1Q6tW1e6+86L/8PsSkkpQa6dzk3Xzun2LWwxIF2Et/mHF5arqL6eWfgixhHJTocYA5GgzmVLgdxci9AuXAUYJBqcK+fVt6utkY9UK2W+X+mDpScrMAXzpZ+hW1NRM3z+HwN5YJZpP0vtrobXWBENSND7/bgPMOce9b7FFFb+YwVwLp4b3POjThKn3zAns52hnH/JF05ae0/kuOejKZ8pCbE1igaQvOfTmqAmtIp/ev+njME7SQ6L/d3kWpxRq8jqZGYMBoxkMtMgMH4U1j8XVzjodhnp2YAvRIAIiOx20EbuwEyUy8MxfnvE3yT9n9kCCIDv7QXqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY+G2voSLSO0Pr2YB4XgYW7CS1SsLVcwMkzcXSTrwtg=;
 b=hhAnwKFAM4zDo/DibEtvrYcAQURJY7rTiH94UB/80FJnRxZhuVIWvsDJn+sc/Rn7/afHSGoA8+xKC/T/bpN1wmf3CDVs3GlMi0ED8KgNvqiRyDlb5gd85LasAzrUHThjTi+5ZS0twZe+j+wMbuV8xeegbGTOw9FTJl1dNej3YoH5H/uHF7Kwx3mOFBxrseuMp3GPKyEMIAvTzFaSh+Kjmv8KbXPM+ZPnsK1Rh7A7hUcPRtwjQeGH+VCG2StAwZ2Xvnm22ImbhoPckSOWKccE9vyYm3CVpx5YBSdnGUCg5X4opHrb9Rf+srZxcbuVrvJKI7Zdywugp3JpHwX1P619kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AS1PR04MB9656.eurprd04.prod.outlook.com (2603:10a6:20b:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 20:02:09 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 20:02:09 +0000
Message-ID: <fa1e65d6-5e1f-f58d-1922-0194044d8bdf@suse.com>
Date:   Sun, 13 Aug 2023 23:02:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch V2 26/37] x86/microcode: Clarify the late load logic
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
References: <20230812194003.682298127@linutronix.de>
 <20230812195729.045205660@linutronix.de>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230812195729.045205660@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0103.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::44) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AS1PR04MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: a5feb0a3-fbf6-4e27-bb7d-08db9c382cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kd6FxCJNcI3HFrLfIy+zhlw+oygADSbQresyXjZxoveQgIUpNzu+4FtbblJgU15slBnvqf/zv3eAVnHZw4aVTyBDXYenZcc7ifKjZpLI+TCi0w0FkfyRfXxgCz1bxUwNMpVc8BK25c5y3U6zsr7oFLTytZY0S/G64B6rNoK1TOVGnF5TvETjev3uDvvSxWkwZwZGEUvcFk2GDd2S2giTPK/CfOX88Zz8EcYrQ9QuCU5jamvHzFaH1UWiI/UU6AZNNxsSdz2nJSp44D9EfxM9a9ew9UMYJUgBmtY0vutH4TZYAnQlvaUJxtWoNaTspnxMU9jOgQ1pgKJj3yizNdCPZzL/MGFCrPpfRX6PJTQnPprcV84HiemkcmTOw1lFe1ulUKiHBXUrvN0EuWgiSqTyooYi6jQQRCQZG/SMopu2varyBj3l4XOX2vNgW2eVcl2Obqf724076vG699QLD4hKD/MznMEiqjJRtDBVsGCJyyFhBVK+dnq5QhQ8xcP7E6gMdsX4V2zbBNuxyJKQSHufS3qBjgzPKKdPLJSq5XqX794/fgjT+QI+90LjQG1qGstclTaXJqBgIASb1BgyJ2Z9skjcHtU3BovLMBaoDPGSFd+GPSclwfe20Gcyi6qn7PB4hlVfdfUvrkq7ttOhSmRYoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(39850400004)(396003)(451199021)(186006)(1800799006)(38100700002)(110136005)(54906003)(6486002)(6666004)(478600001)(5660300002)(2906002)(4744005)(36756003)(86362001)(31696002)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(316002)(8676002)(107886003)(83380400001)(2616005)(26005)(6506007)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDZXL1EzSEJLVDFSVG5Gc2pibGpyeUFoZTEvMW1QdCt2ZThka2hrN1BSRzY0?=
 =?utf-8?B?clIrcGE0aTI0VEtiODJjeHZLdG5xWVpvNXAxbnpVVUlmYVRYNGl5bEkyYjNN?=
 =?utf-8?B?Q0FLQm9hS2dkRkRDang2S0p6Zkk1MU5JcyttQWtUZzVZeFlyM2hHUEovQkds?=
 =?utf-8?B?YTlIQm5HTlVZSkJwWGt4aXB3UEVCUE5sZTJYWEZUd2YwbmlWSlFmaVVmcGFY?=
 =?utf-8?B?NklqWXlZb1BKN0FwNkhxZ0pOaHozc0VTM0N6MjVGR1o1Rmt2cVUxdHVDV3Jl?=
 =?utf-8?B?WUFQbkJzZzFTR3RiTDF5K3F6c2Q0MW5VZ1psbGM0cnF6OEF1aThIamlZZHRU?=
 =?utf-8?B?ckVEZmRuZXFXWUJlb3FJaWx5N202bkRpRjlMSXVkZEhoTTczTWJVaFJyU1J5?=
 =?utf-8?B?ZjVZUnE1bHZJL0R5T3dBem9vdmJtOUxIWGVkYWtVU2FMTk9GcG81cFNBb3I0?=
 =?utf-8?B?ZFFBc3J2L0hIRHVycnUyL3Y3NnRmSjQ1SnU2eHNQOVR0WFhrSFp2d3RsTXBT?=
 =?utf-8?B?bkFNSWhsc2llSGI4eERlVFpiTDBTelFubGJmUzN0eHE0VzRkdWpHU1lyVmxq?=
 =?utf-8?B?bDRUdWkvcCs5R2E1cDBFdytiYlplWTk5OXVkcVFaNG9jcjZ1WUNzSklqdFhl?=
 =?utf-8?B?RGxjT3NOYXAxeUlWSFIxWHMyVk05a2dydCs3OThlTHArd0hrRVRSUVRlNjhu?=
 =?utf-8?B?SlFCMTdsbHl2NExXSVpiNzJLMzhtQ1JCVGorL09YT3RWNExvbGlYdHQ1cml0?=
 =?utf-8?B?cnNacHRFZE1YNE5aZDUyaWsvMXlLQ3JEdlJqbGRISUtXQWxiNGtvKzVMZy9u?=
 =?utf-8?B?Q2d6cnhRaXRRQWJEMjRZNnpKL3dMNUszZTR3S2EzYmgwQmFWS3c3TFJRM3FO?=
 =?utf-8?B?WUloUHVGUFhMR00wV24wYmY4NCs1UkFoTU5WMFc0cnNIY0N5Wk16bUZmeVha?=
 =?utf-8?B?Y2tyUzJXcEs3RjZ4MlNDZmkwYjJvblRlNUZwU1RXRWlBd0FDcWhuL0VYWHBJ?=
 =?utf-8?B?b0x1ZVpuZnRUWjN0K2lUMy9SSDhQb0JyRlo5dWV4Yzk4MXRXR3Z4Z0M0WjBr?=
 =?utf-8?B?RUhEckMvVVNwRDRZOGN4SHFDKzh5aTkyeUtlajBiblFFcGkxRTRmTTlnWW91?=
 =?utf-8?B?SUpZRXhvMFlTd3V5YnpTR2FkMW1wdDh2TnZYM1F3NEt1SiszZ0JXMnhJWWxG?=
 =?utf-8?B?Nm5mT1R0djc1YW1IcGh0bjhPdDVPMWhzUnZ2SDNJYS8wMXNTMWJGT09reDlR?=
 =?utf-8?B?eVNGNGdJWUtGclZpbjhQdTlpalcydEJLclRDSFZGVG1ybWhpMGVwUktQamkw?=
 =?utf-8?B?QmM4eXpldk1nNVJqbnptOU15VzBJQ3lYd0NYZGtjVkU4cUJmWXc4dzhpVFhs?=
 =?utf-8?B?WjFhRWx3MFBzdG55V1lwQmFUbnNDRTBEUkxDSk4rT2tsZEUzcGhJU0QvZjI5?=
 =?utf-8?B?Ymh6SGQvYWxzbUdLMU4yaU9nNWg0c3pGNVdUR1hvc244dVA0bTdYRFpWZjRa?=
 =?utf-8?B?eFEwb25YSUNRM3RyVDdma0JIdTlRZm1nZzI5YXEyZERlNDh1RCs5alR0M1Yw?=
 =?utf-8?B?THFxL1hHSlhGKzBVR3dMVi8ySVkvWnB6ODdBeTVHUnBoYzE2UzV5WkZuMFkx?=
 =?utf-8?B?MzRDeTUzQ1dYcXJ5M2RnWmtFVnRWamlVTnhUck1hb0JlVHIyTTkvMFMwU2ND?=
 =?utf-8?B?RDRFWUhjVFVhZS9XdlltNmZZZjBrbktmRVVXb0JRM2JIWkhDZW8xUzVReEl2?=
 =?utf-8?B?WWw5K3hjSUJIeTVDWXU2MU53MnVUd3NMeUJnVGdsdXVGNFZob1BsTHRYSHU1?=
 =?utf-8?B?ZDJUeVRPTllZbzdoQ25WK3Mrb0ZOU1BWT0pCV2VHc3JzUHdyOU1uNGJTcmRR?=
 =?utf-8?B?Rnd6L0xuRlhNc1J4bGNhZjQxMExhWml0NVk5VVNSTDhOblpGNDhsM1JUNGtR?=
 =?utf-8?B?Z09iOVd5Qy9LNHcwQ0REa1dUMDcveVowNVV0VkhkdnNmLzlwNWIvN2V1OGhL?=
 =?utf-8?B?ZGJXSndUMmtHVURVZVEzUFVsWW5VbEdEYVRFQ0VMZ2pweHgwOGJjbWtEbWJO?=
 =?utf-8?B?M3Y4TUxCL2ZxUjVmZXJRWCtycDQwcjBWVGhRREM0Uk1MR2tOSjV4RzZNT3NH?=
 =?utf-8?Q?ObBfUKCZv/Stn9V8UuZUtUkjl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5feb0a3-fbf6-4e27-bb7d-08db9c382cc3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 20:02:08.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdlHG90WZMKv7+fsuxlJI/pAZbxRi5usfL7SnGXRSdNYa4IoKXJ3xIHEymnKwRA81oUczzEFZBvQ9e3G6CzC0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9656
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.08.23 г. 22:59 ч., Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> reload_store() is way too complicated. Split the inner workings out and
> make the following enhancements:
> 
>   - Taint the kernel only when the microcode was actually updated. If. e.g.
>     the rendevouz fails, then nothing happened and there is no reason for
>     tainting.
> 
>   - Return useful error codes
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
