Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B48578D9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjH3Sej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244386AbjH3NIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:08:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25BAC3;
        Wed, 30 Aug 2023 06:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sgpi49FYSiMSHh5mmKH2ufiUwEKy030mClbcrmllOlUmHXxNNrkCmsPsWIQ200Kfg3Q7MfZSM5X58wbauyY4LsfJteNeAvgzAMjarLC235l6uBYBj9/R1zk+3DbS4+G5AF2fH7Vpz5DEK9cZMENmiwNCTyK8WZZse/mArTz0v0Uv+wUJv6ARoEy69gwFVYavx/9JYgIeTgj53ihff2C0thzFjASzf5x43ExZHzeHns4lHLOp07A7HpDLVnmwHA29WoG+w0GC+bsjmhfLGKww4/EUrmp5JMe/Bz8LLaKe79hINB0VD5UP2Vjv7oxtksoKoifW+yKJJhB72PwQ8+ZkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBX/Sw8bCDf1yhswBIvr7Qs4Vj1r9EA8ZnvcU8mgRqo=;
 b=e0zuOIAj+c5ZVYN5dpMN/miv5BSHm/VZM9py94P6PF8OpwqQeBZQA/9MKOjGCNb7Z+O5qCKtY9jJ218yGqr1ymKoC8MqUofubF1mniFjIUwhAERhlASxn7h70nu/NwO7d8yDuYeNXqhXwAU3tcT/NGd/IkoTF/XXQVXEqdSLSZM0Eg23Ro07bY2GjpDfL9Ee7RF2d89S9sp6y8SS4Mi65YI68Bh99mJFKBviFM4X8M/I3vVqj9AVn5Ux6nketksA38j6HuteX8t/VcTnYH/ovUnZfFrxk7pcJLT8o2SGSJnRlqzqPihHZrKtHo+vDjveCadf4357tNfi+gWWmMJxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBX/Sw8bCDf1yhswBIvr7Qs4Vj1r9EA8ZnvcU8mgRqo=;
 b=XV02kKWfPOVWVaBAjmsKQzU+e0SnfTYczum3XlHBqI/zPg4neKJQlp7UpwjTNT4rMUInWkwCMdKlycQyzips4swEq92knXWeDRvfXzjTp60w3KQRirGBjaKcqv25X+kDP4sqhi9dusG2LCTZEaTCGm1orLgKEMiVX8TmDcID/Lb9+HfUmvMeSsSYuS9GIH2xPOm+aNsMmU6p4fIf37qklBBP359shvZ5SZWjMseuopM5xXQuaxYwF5JBGT+wU0ZtD97wJmIs4674RtqQhdMwM1+Lp/stJv+M9VWQobFdG8y8G3zdpoAWkAc7urow2ngLBal/UGF6A3ls498XHDN7og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 13:07:59 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 13:07:58 +0000
Message-ID: <9841c4f5-614e-bfff-e725-2398fad4e927@suse.com>
Date:   Wed, 30 Aug 2023 16:07:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     heikki.krogerus@linux.intel.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Anthony Iliopoulos <ailiopoulos@suse.com>
References: <0da9d8a4-1761-20a3-ebd6-a47fe48b94f8@suse.com>
 <04e8de7a-55e3-4d12-921d-537750fe6217@suse.com>
Content-Language: en-US
Subject: Re: [RESEND] USB PD broken on Lenovo P15gen2
In-Reply-To: <04e8de7a-55e3-4d12-921d-537750fe6217@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0098.eurprd09.prod.outlook.com
 (2603:10a6:803:78::21) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa7e7a9-b7f2-469e-98b9-08dba95a21eb
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAd/IlhYb2UoscmSvjVDHjMTYb65kkPKwxQ8Z2moJWioe+FrkWvRgTyGp8YDFvnEH9WZVaC1FWdiEGTLEDcUUekT4GsQujPzeVNiVtQET+F/+MUVpqaFPbnKqF29oYw39/FlVCujdibWiF0l0DQGA033SuFxCQl65zvgOglCCbWdipGf2WExorGvdIstHCAoIvAapf4pR15NhD3IRWznoOUN62sn3adiiWer1htxsWQSb5IVG+cuLB+/+V9/pgZTYUA1ToJZIpDY4hURcXlVmZC0jHWzQqK1z0d2Ahv1s8wtfcZydWGXWUSfc7D79VrK8psvTb+M3XOYwoiTKGUwz37WLcNpx6X4YHYbDMUw1xuxMf9DCn2tdKablacnr1aE4xoqlD0wfFH4qiZfnm+5eNWDQAFBOc3wcKtdHz/Dtxfqdmc6AZYiuKCfOb49K2b2G7hmK/LVaDDqo+5Lecd7jNpzIHqksn8Cz6aupwli2YQfCiz9L16sL0h7sr7D+w02QQU//1ZugYJkgeTYhTbTHVpv4c8pWWOYNsYy2RTvdQUYRgVPkCXHuG/fLXvfwmWl9vManuKclsLT8cvRRD/JT3p2Fs6cF2POPPaQXFaBzVTQZNpTbEwGpuzzfiDjjhe80Ynv+r/tAN5WAQoEp6aydw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199024)(186009)(1800799009)(26005)(107886003)(31686004)(6512007)(6486002)(6506007)(6666004)(5660300002)(4326008)(8676002)(8936002)(478600001)(31696002)(86362001)(83380400001)(2616005)(38100700002)(66946007)(110136005)(66476007)(2906002)(316002)(66556008)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V21xcnE1bTJXNkxTZDlaRzVpdmJpWlFodWNGeUk3RGlUMURPYkNucmJzU1Jl?=
 =?utf-8?B?SE1oazhWYWFkSW5udDAvUlJyeWxwUmpLazYrZUVkdEsvWmxDZXl1ODdmRENa?=
 =?utf-8?B?YjdZVHZ6TEFOMTBhRHpUaFg2K1hQeWlZYS9XYmVJV3lvLzVSWnVtZEpHQjdL?=
 =?utf-8?B?RTd1M09xMFBpVWZCK1lIdHBtUVFhRi82dnh5WDVRNGdhVXlPWTdaVzVUV1l0?=
 =?utf-8?B?dEdKTjBTZ3RmSmEvb0xpMk5CVVVQWk5Hb0hMcnlmVm1iQ1E4aTFJcHVZR2p6?=
 =?utf-8?B?c3dCOEROUnpKMW04d3pXRXROY1JwMlc0YW5UZHhrdFpnNTlvbENPbFNkSzA2?=
 =?utf-8?B?UkZLSVNkMkQ0cnBZL1VhRXlRQ1FqeXJHY1hYQmt5bkNGMlRjbm0reFlBN0FR?=
 =?utf-8?B?aGlWQlJNOEFPTit0amNyaWZXRTJDUkRZTnZvTGkzTDdZbS9reFZ6TUVHMVpB?=
 =?utf-8?B?Y3Zzem52eVBZcVA1TGV3S1pMVEY4YU1SQ3NPMmxrNjNqczh1L2RJYjU4MXpm?=
 =?utf-8?B?VU50SG5rb3NGczRBMXVwOUFpRDNocWNKVDU4SGlFT1RZNUR1cktGcnJGZWl4?=
 =?utf-8?B?OUtYL3A1Ti9wckJzMVNHcGkyYS9EQTYrS3p3TWlWMWo4TTJqVkhFN1RkS3pM?=
 =?utf-8?B?ZXRaUW5lUm52elBya3Y1cXdac3NMZnMrOUFOUWVBNnZXK2FGcEc4VUttV0R4?=
 =?utf-8?B?dDdiRDdJU29LYU5BU2RydWpiYlNSajlER1E4U3pnUXpGN0puM0NSVXZjL3NY?=
 =?utf-8?B?QjZNcVBJN0swd2h0RG9wb0x1V1lJZXNuVWlLQ1A2MzQ5ZHE4VitpU3JzVVZG?=
 =?utf-8?B?czFRZUdtc1V6QlVFclpZLzlseExQM3VaZlNCMDYwOWs3VzRFeElMdUNyODE2?=
 =?utf-8?B?ZDBWMWR0VmwyVy94d0hmNCtUbTNPdFNielJySXBBQ1AxR085NUlPMVJNY0pr?=
 =?utf-8?B?b0FuNGlsclBCRVNkb2pJU1lTTEZRSHRlN1R2T0c0dGIwaFRXNGp6NTZQQ0gy?=
 =?utf-8?B?TnB1MzNZUWw1ZzRUV2NMVEM1aVRYK29wNmhDV1c2eHFHSHpia1ozZEdXUnZw?=
 =?utf-8?B?WmJOalZkZ080NzNKaUF4aGtGS2NxdnFRZzBaV25TRGNIenJXdmxQT2gxR1VN?=
 =?utf-8?B?d1BUT3k5MHBieUNRMkg5MFFOeXNiekpxaVFlR3c0N0xmOXlxcWUvNnNKVVZK?=
 =?utf-8?B?RlJNVG8zL3UxUEJDWnoybGRKV1dmT0hlS0g1MTMxaFhkaXk3Ym11cTNwS0tV?=
 =?utf-8?B?bEQ2U0dtMkYvN1ArdTBGcHFWc3hNZTQ2eTNPM2tpU1Jxa0Q5MGdOc3VjYU5P?=
 =?utf-8?B?OHpWdnIrUW1oRUUyZGZ3TG02dGdSTkJ3NFhKZnYvK1dUVjBMWDBETkhBemE4?=
 =?utf-8?B?K3g0cDd3QUVEYXh0TGlRZGdrNUNzcmZSNHJSYUtKU2JoemhmQ3JWUWlqbTQy?=
 =?utf-8?B?L2FhdytzQkFTSk5yWEVoZHZZODF6UUR2WjFLbW1aRHpGdC9YdGtCeGxSMXAx?=
 =?utf-8?B?NFV6Uk8vTzBTNTc3WFBKZXIvMHdNQy9DWDFuanR3M05YVDZ1eWo2emh3RTk4?=
 =?utf-8?B?TW16OTlkVUxsWGwvTDdqVzZVQW9IRXgrbHQrRWJHdDBtTy9FcnlNcnFPNWFT?=
 =?utf-8?B?UDE4ekUyZXArV1hLa0FxM21DRTVXSlVlR09vSXk0R29WdWZZSEJWMkIxcm5N?=
 =?utf-8?B?dmsyRWtTU1h6Qk1ZSUVldUloclNWaU1oVi9WQStLbEpiV216RlhzN2NWdkZy?=
 =?utf-8?B?UkJmc2o3NmlyT29GdzREa01nKy9keTVWVlFUUDRBOHlLa2xNajRCSS84SXgy?=
 =?utf-8?B?VzR6R1J6L3dHbmFxWFZXTTVMNUJsRjduUzl0VC9OOTNiUmdsTUcxRnBaejdj?=
 =?utf-8?B?Y0MwTjd4dVpmelV4QURvdDh4OEZwdnc4RlhzWUFvOFloR1VSeVFnZFVYZjBt?=
 =?utf-8?B?THY2ZCthSG9IK2dWdDJYTlJNV2FWMHRwNjdzeTNJMEpreEk3MVNKbXpucHp0?=
 =?utf-8?B?Z0RxNGV3RGtvTkE3NWsrM3ZUREFhOHhEODlVczNxSjBOY1p3RkF3MElValhR?=
 =?utf-8?B?REFKTUlyOW5YWHZPSVhYaW8rZVRseVdLSHRkVThzT2RuMlFuL3JPL25PRnpt?=
 =?utf-8?Q?eXrNAplewcFnOnsJpe6nqPB9f?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa7e7a9-b7f2-469e-98b9-08dba95a21eb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:07:58.6165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJebBG1SWN0T4Jl0rgaNGN7tWnF90TXmekSiaZtW9GkUA/belcul9aljjDJWCAagb8Y0EXEX7pCfxzPqdLj/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.08.23 г. 17:52 ч., Nikolay Borisov wrote:
> 
> [Resending as I had initially attached  a full acpi dump and it got 
> bounced from the usb mailing list]
> 
> Hello,
> 
> I'm not able to use usb PD on a Lenovo Thinkpad P15gen2 laptop. It's 
> equipped with 2 thunderbolt ports and a usb 3.2 gen2 usb port, all of 
> which are supposed to support PD 2.0:

<snip>
So I've been debugging this and what the PPM reports is the following:

modprobe-529501  [004] ..... 33507.058332: ucsi_register: Supported UCSI spec: 100
      kworker/4:0-524223  [004] ..... 33507.486591: ucsi_init_work: Connectors supported: 3
      kworker/4:0-524223  [004] ..... 33507.486592: ucsi_init_work: GET_CAP: USB_PD: 0 TYPEC_CURRENT: 1 POWER_VBUS: 0, POWER_OTHER: 0, POWER_AC_SUPPLY: 1, BATTERY_CHARGING: 0 bcVersion: 0x102 typec_version: 0x100 pd_version: 0x200 PDO_DETAILS: 0
      kworker/4:0-524223  [004] ..... 33507.682726: ucsi_init_work: [Register port 1]: OPMODE: E4 flag:1
      kworker/4:0-524223  [004] ..... 33508.850438: ucsi_init_work: [Register port 2]: OPMODE: E4 flag:1
      kworker/4:0-524223  [004] ..... 33509.986672: ucsi_init_work: [Register port 3]: OPMODE: E4 flag:1


So all three ports support DRP/USB2/USB3/ALT_MODE and they can be a provider.


I find it strange that USB_PD is reported as 0 yet pd_version is reported as 2. I contacted Lenovo's support and they confirmed that this particular model indeed supports PD 3.0 on all USBC ports.

I see a couple of problems with the current upstream code:

1. It assumes that USB_PD is valid because the PD version from pd_version is being propagated to several places (like in ucsi_register_port() cap->pd_revision = ucsi->cap.pd_version;)
2. When typec_register_port() is called from ucsi_register_port() cap->pd is 0 hence the port->pd = cap->pd; assignment in typec_register_port is a noop. In fact I don't see where cap->pd is being initialized since we initialize con->pd when we call usb_power_delivery_register in ucsi_register_port().


Is it mandatory that GET_PDOS is supported if PD is supported, the UCSI spec doesn't say anything other than GET_PDOS is optional and signaled by bit in the GET_CAP call ?
