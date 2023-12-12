Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB3D80F696
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376734AbjLLTYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjLLTYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:24:23 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA2AD;
        Tue, 12 Dec 2023 11:24:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm8OBcs0mtAAKahdtz9Ea0KnRA59f9obijFgxyuS2KvfN2Xg4YTV38jN5Wx9KbmMg0r8YzB9Ztw3xRHc/N6OeDDNeTIkSomCSWWES+eohL8YUnY7hOvFfrQRW+yOGYnfHVsIekKOo7D7f5cIvACL9cgmgg0Xcnao6XA+baZ1j5Oz5Jn0APdF6VZ8Ew4FpXvE1kqh158JB5L+fdV6R4m/2szHbduKLMuTyHqnoUKVLHr4ThFlLziZ5eTg048CCCKqNEELCNfTixKSSQWJgCixnSCfk4HHiaOe/KYlhlw+JLNwcRwT5QZpRIJtCY5l/cyta3/GTLun+FUb0DcdYG3/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W1m88smBGwaG5Zda4VGyqjsGH3zi36nZO9GiCDnYy8=;
 b=dmks+Ovhb6GEq9ftGd0X8bwCOtqoYjcie11H7pUeQ3cq/oyIUBwsW2VxfoBQY77KuZyAoGUxM8nDJQ47aIGbpHPa6Tx8lqu1i2SHRJtA/cVJtjt//Z3X7vCT61tDULJhlFH8Cz/NAzaROXsIJCfYULqBP6inVi8HMtCwcITftoh6GY6mrfSC8pNxKqQST+DzVYl8ouOsnX1j8CJuAVZWJ5qou5RZHyj3CzH/08u6UYdq57oYDAUWkGpIitkG+Uwaassb0jRnpkcYYRWuFLYqN+dkPsssgsBDUIOCM27tnOTM7FQdUqS/pNQVOdr+6PsdKzKEsu66zaw1sYhuhsOd7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W1m88smBGwaG5Zda4VGyqjsGH3zi36nZO9GiCDnYy8=;
 b=zO7hEQ1x4lMeRqyplOc5ZPQdrg/+pqcDVpT4mvgL9KgDSOhEYLi9EWkDHkC7DPOBX+czL/Biey6usGjBp1snVyiLPKFPIMicz13utcXjxGo0z2eOAtc4/7IcqL85SdLy2abSxuc6z3M29ETd13s68hg9myunzK1CC2zkJ1tOEmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 19:24:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 19:24:25 +0000
Message-ID: <ef5c74ce-d794-4b80-8d37-4a88de5db3f2@amd.com>
Date:   Tue, 12 Dec 2023 13:24:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Content-Language: en-US
To:     Sanath S <Sanath.S@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231212191635.2022520-1-Sanath.S@amd.com>
 <20231212191635.2022520-3-Sanath.S@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231212191635.2022520-3-Sanath.S@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0059.namprd05.prod.outlook.com
 (2603:10b6:803:41::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 9398a680-588a-4a81-1263-08dbfb47f38d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LU05GT8TmCpJzUPEi35/rUfaw+qo+2rl16V8zKFEc2/CSIblT33K7H93HdkiIZxHxijMWPnKxUkKFX1By82W76BqqqASVziuW4ejOqya9FsrgG1af7FcRmBDobcLkpCkhLiosSsp/AnPQhrSodswS67lOrR1SIEijWNJ0eQwCGzsJjRF6UxIUgrv3gV5z7Vl7GFoPziLXKeKgJtYIulNaUKCSdBHsIYrdQvvh8Bm6cpyvDbYBOCa2G5EkBrEgcWuBVWOQr3NItc6Hyitsgi3Q8wgW0INgR9cErd4iZMhlyoTQ0K4uD/HRPVXJ/8aTQnv4pRsSsacpmNgPaM+kdSNcStQwCinWo56WqvUe9Hcm3FWAk2cAmF7+4VrMsopz4wSMxhRI0qUhxhgdcUq3pRqhvqsmzUr1qmwGCOy282BFEbedWYFqaXt1rqoeDeCh5Vt45rx9ZbQmJzjiokaylh4dDPi3dHDB7OvO8o3RBW1bDc01WcgV8tp3F+3ng3qPUc5JVDXlx/4gidqGIdFwbJpx3wzbfyXcbbdOQSwHSaoEjh9e4n5ifSnXsn6FEUAe40Wvg7NR8TZUpkzsJ1h8cDIvGfU9gNhNLzm4YpPyjjyUPP80hKi/Vcbi0IbPgZzM0DuhLHHNJruvvLo8bZt6l4dZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(41300700001)(478600001)(86362001)(31686004)(66946007)(66476007)(66556008)(6486002)(6666004)(316002)(38100700002)(8676002)(8936002)(31696002)(53546011)(6512007)(36756003)(6506007)(44832011)(5660300002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG1NY1BHSnE0dUdhK0pudzFmYy9zVTZYbUdpelNvR1dLRS9OM0VMQ3FkT2Fk?=
 =?utf-8?B?aEFEYTcyVlFvd2hLeDNYcW9aSW14c0dvM3dxa3g2UUg2WEI0Q01EY0VwUDE5?=
 =?utf-8?B?VDgvbVBCaldROGpLb2ZCK2JPV3k2NlFveC9ZUEVtbjlmbWsrUUEvZG5GOW5a?=
 =?utf-8?B?cnNkKzc0RTY4MzVMN3Z0eW1pTmE3STJmQThvbC9tYXBFeTgrQWg5bjFJNk4w?=
 =?utf-8?B?T0k3SkFEYVF5NzhKY1BXRWlQNHJMeEVjWGt2ZkZGdkdWZXQ3c095UldlNVVW?=
 =?utf-8?B?M25IWTdsbkRJU1ZkWXdJdHZNbWFaZHNraUlaM1JqOVh5YVZCbDJjakNNZGls?=
 =?utf-8?B?cVZKOHZVWHJ6aHIyV1BpYVZ1ek41WDNHRnJBbnNQS2xCbzFwRjhvanAyNGJH?=
 =?utf-8?B?aVlnRUxMWlZvOGhrRmdhMit6cjBhdHkyYmVJT2dLclBzbHhPbDkrbjFSV0py?=
 =?utf-8?B?ZkhTZFdaemhUeWJDRmtQUWlLcmloOEtnSVJONTVRcjBrSklhU1VMbUtoZDk5?=
 =?utf-8?B?VXFuVGVmYkkvTm5QZElJamhvc0U5THdIa1BBOWNzNFpSOEE2R3BTS3BTbGxi?=
 =?utf-8?B?cjloME9FaVo5cXh3dW0vbEpUZHRTV1hzWTl3WkxYY3NudjhHbER0LzJDVDEv?=
 =?utf-8?B?bEl3U2l4Zi9rWThBQlRWVk54bWEzY0x3cU9FY3NTbTczMzNyak9rREk3cDVL?=
 =?utf-8?B?OWZKTzlHYTBlQ092MlRPNGtFc0Y3azlDbm4xSGFzclI5MTF1aHd6bU12Sk5w?=
 =?utf-8?B?c2xWbGIwWnJHN0N0NXN2K3FhQUVUOVEwNVk2Vnpyci9BY0ZoNC9tQzJMYWN3?=
 =?utf-8?B?andFaGwrc0hGcEpMYzNxRm51dGppRXU0QUNvQ2NOR0ovdU1LZ2xRamdrOHJn?=
 =?utf-8?B?SDQzamFBZ3R1V0VIR1cydmJkcGVEMWkyeE91ZDYvVlFlbEtLa0RCdWFWVXBD?=
 =?utf-8?B?VVBaOG9EbzZMVytPUDRtMVZHVDV5NXFNMlVHbko2aDRVejdySlBjSmd2S2pj?=
 =?utf-8?B?YW5NakpKMUNoZmtWTGcrb3ZCUnUxSUltNGtPbnl6d3FCZElDWXU0N0NVVGND?=
 =?utf-8?B?Um5wYjhRZzZjaCtFNDN6RkhZYkM2YW0rRU1xQ2dUUW9xamVSZUVFTVpwdjI5?=
 =?utf-8?B?N09vQnYrY1B0eXdRRnlyUTNJRjJNMFF0RFIzbXJ5R04rMGdBaW9UdHBhMEI5?=
 =?utf-8?B?cW9HanNCR083VmNLeVorQXB2bTFBdUJUYml0U095U2pOOXZoK0xwTjdndTd5?=
 =?utf-8?B?Z2tYcGNqbmR1SmRoOEZkTmg1Z2N1M25weFlTR1lzYmhFaGtsc0FJblFDaU84?=
 =?utf-8?B?NXlJVzVQODJFQUxOZUwzZzYwbWgvY2srUDhYakNtREJhNnlVYVpOSm5CbDEz?=
 =?utf-8?B?RHhNVElHazZOZG1VVDNMWkNWd0hQc3MyQVFaMkRFcldHeWRzRFFqaWxNNC9S?=
 =?utf-8?B?WWNxbC9HZ0h5Q0xSVlB5Z3dyYXAwWHlTMG5seXBEZ0JUSVBrcC9wZGN4R3Qr?=
 =?utf-8?B?ditwckZRcjZnWHRReCsvcTV6OWdBeTFmeGtKVjRuQlI4a2RsaDQ5RXNlNVo5?=
 =?utf-8?B?VWdwbUxPanVLaFFySlVkaHBnakxETkdLbEJZUU9oeTJNY3NEZ2NGT2o0N2NT?=
 =?utf-8?B?OTBaK1BjOXBYV1RIMUFmQko5UkVRRDZyUUZFS01KWlJwSGZ3V0FNekxIZFY0?=
 =?utf-8?B?eElIVHh3Zi9RanVoTVh4dnhBNitSbjBIWHMvY1Fhazg4Q3V0T1ZQU1dJc2tn?=
 =?utf-8?B?NG5kNDNJdGVROXlidXJzVGZRdVpZOXdMK1l1WEpuOWl0NGR6U0NhS1RxWE5V?=
 =?utf-8?B?NzR5RmFYRmZaeFM1Tmc4a0FESytJbjhqS1NOOTZIQ1FXMmdRdzkyaCswTnBr?=
 =?utf-8?B?cWNuWk1scytzdXRid3lSdktBQW9ha29YbXNRVkMrUnRXRWI1THFMemNNV2hs?=
 =?utf-8?B?OGtHV0lrdVR2RDl2SVk4QXVTa2M4WWoxQldxWnlucmZrbDY5b014a2RsQmVi?=
 =?utf-8?B?S3NiNC9GZHBhNy9id2xRVG5QVXV0aUVPQzV5Tlk4c3dQSStnUmYzbGRnTGE0?=
 =?utf-8?B?WW5ZZEFOR3JNTkFHcWVTeko3YzYwcmdnNDRtVzJTc0FoandHU09PMHBma1Fz?=
 =?utf-8?Q?8cHKk5um3SfWs5TP0c6C72+hh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9398a680-588a-4a81-1263-08dbfb47f38d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:24:25.2101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCKKMcyJDawFSNB8HkarX7kRw5CVcacmrznFVqWrVsxiGURZS8zE/2NyJNHgaIUqziLvRSe4HQzFppv4gTSS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 13:16, Sanath S wrote:
> Boot firmware might have created tunnels of its own. Since we cannot
> be sure they are usable for us. Tear them down and reset the ports
> to handle it as a new hotplug for USB3 routers.
s/3/4/

> 
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
> ---
>   drivers/thunderbolt/tb.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index fd49f86e0353..febd0b6972e3 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -2598,6 +2598,17 @@ static int tb_start(struct tb *tb)
>   	tb_switch_tmu_enable(tb->root_switch);
>   	/* Full scan to discover devices added before the driver was loaded. */
>   	tb_scan_switch(tb->root_switch);
> +	/*
> +	 * Boot firmware might have created tunnels of its own. Since we cannot
> +	 * be sure they are usable for us, Tear them down and reset the ports
> +	 * to handle it as new hotplug for USB4 routers.
> +	 */
> +	if (tb_switch_is_usb4(tb->root_switch)) {
> +		tb_switch_discover_tunnels(tb->root_switch,
> +					   &tcm->tunnel_list, false);
> +		tcm->hotplug_active = true;
> +		return tb_switch_reset_ports(tb->root_switch);
> +	}
>   	/* Find out tunnels created by the boot firmware */
>   	tb_discover_tunnels(tb);
>   	/* Add DP resources from the DP tunnels created by the boot firmware */

Doesn't this cause the following to not run and thus break hotplug?

tcm->hotplug_active = true;


I think it would be better to do this like this flow:

	if (tb_switch_is_usb4(tb->root_switch)) {
		tb_switch_discover_tunnels(tb->root_switch,
					   &tcm->tunnel_list, false);
		tcm->hotplug_active = true;
		ret = tb_switch_reset_ports(tb->root_switch);
		if (ret)
			return ret;
	} else {
		/* keep existing tunnel flow */
	}

	tcm->hotplug_active = true;

	return 0;

That makes it crystal clear that hotplug isn't enabled until it's done 
being setup, which means either getting the existing tunnels or doing 
the reset.
