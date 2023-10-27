Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E812D7D9AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346103AbjJ0OPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbjJ0OPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:15:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7C4DE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMlRTU3Fk/zLSn0U8tBPWmGgMBhmlpwvd41yg1g0HAXX4suTYV8OyVm2Qok/BNXoVqKv4hv5zsCgzvHEY0u/iqCZdnVVp+ppE2nuo3MTZkRDVDiyS0AFDnkwHyNR6upC5a2h5X1dxO8UawJSHykbmxu0qNE6o6lQRmCe2CoUYYKwycx/9h2G/mXJmeVOvgtkVx8tAJtYwCJPNVuOn9YGvpq5KJYdL25ejKMQQ0TRTHJDgUSiUfwLeFIB49ly791k0NFCeIxqQKMpL8hdnTQAYBA60CZ/A4ZXQhdTww+O6SPLxNH1PAo6Uv8IRy887g09R8BzfhPaIddjMV+5EgB7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvYjuCtxZmGtgMAo3F4ED0HRxXqvn6Y33Z/UbkZ7PpI=;
 b=L0of0JAF4pxwMwZxGUExdA93vecZbUH7RU0Yd5tJ/IB8jHGwNhtr+DPU2mc9IqGP3fvpvKbhuo982xy6qSoSDtuyvgVpnZuK042ef+fzllmaA/SzEZiF3vu6n5aYSZlQ9MYK2Wg+QcFXcs+etFEaAsgcJeDWAC8+WJSCUbzhpArQOsoEcM4F8pT1FVl1xBUvzL4STywaNqHbDf0MiqwWLpIdKYvN0R7I+y/XntzGDdvtAJCy1mUK3DzZHBkJojVLY+sFN7tm4NeZ2O+7WCSQF9luxdo1MgMQeuM32zLAA1JiUrMt7rBR4rPqnY29E5o4ooX0+HHGddYAn5n6Nq66zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvYjuCtxZmGtgMAo3F4ED0HRxXqvn6Y33Z/UbkZ7PpI=;
 b=Qe8PyFkuz/FDqiECO0saSt1Cj/feiEr9mj6RR79VZV5C8ogRjHKwfRP/bpOJZxh8pqG0RdaBLC66aXYj60uTMAEvwhvDDSyPYHxhstOd40mbQEUWsi7iqVo64ktlgXWfSQ7j5g7SodydpK9MdP3I0a/5E/ynUp+AsuKDN/eeWdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 14:15:34 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::facb:a35e:45b3:cbb1]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::facb:a35e:45b3:cbb1%4]) with mapi id 15.20.6933.023; Fri, 27 Oct 2023
 14:15:34 +0000
Message-ID: <b25aa859-c5da-4408-938c-b3994cfb5458@amd.com>
Date:   Fri, 27 Oct 2023 16:15:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: xilinx: Move EXPORT_SYMBOL_GPL next to
 zynqmp_pm_feature definition
Content-Language: en-US
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        tanmay.shah@amd.com, mathieu.poirier@linaro.org,
        nava.kishore.manne@amd.com, ben.levinsky@amd.com,
        roman.gushchin@linux.dev, marex@denx.de, ronak.jain@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <1698348238-2320426-1-git-send-email-radhey.shyam.pandey@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1698348238-2320426-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0098.eurprd04.prod.outlook.com
 (2603:10a6:803:64::33) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 37afde23-c5b0-4cce-3cb6-08dbd6f72f28
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaTA1jwmlQtuzL1e+oma0T9652jgcJuO67knx92WwLvdPwzL1MJ/GpQv5EYEs3julkNmlRMLyKykPT4GuJE7Y/91YvMVU/b81I6pIucvHNmdXZJZmhrZ0ToDxH0HSo6MM1HqR/xOW7n+/ivGMXrQmMNLjmiVf10qu0R8hDfCaOennjNV+bWI02u48Wg6iw7wPN3o5dA1hcPG3Ysr5zxzPVGUvqGDDMViwmfw2aDqLCxlgaxXUp47BO2aeRQzq2c1hUdPFKhmdG4yhcYoPbMCKhAqTxZwldN5TJ7R1nciErwmP/Ubinu5kcTKzZ6x+Kms8LwZHEZUYs1r/q9unWHJ54YHLBpbtpdEv4mI3TpvVIs47na7EJNYXO98K6k+n/7Vss7vIh2u7LfQxLA3cU9pz0MqN9GIM0zy5Q53r+xMrdJdOv8Rn6T8PgKEf5hbY0jJfav+r1EkEmyjEi9z3oJKhDOI++eOXU8gMBMZTvLwdkiywBUl0wFF9lmKTh7F9SuKAG22NwaZyTncjXmo7whdP1Jh8NuSpMMtiwyhjtYFTge9PbW3I+66YFrSDkCF9dAlivDiNSGpvsg1zKazgnWkHulyLf2bTwojcmbHs+Jdhj1S6AgGdPpJ7X1nfF6CmHFwvGlBSGDG9Vf+Y/p+AB+Ti9GRl7UhDVzGkVhMCTJrfqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(53546011)(6506007)(6666004)(6486002)(478600001)(83380400001)(26005)(2616005)(2906002)(5660300002)(66556008)(66946007)(8676002)(44832011)(8936002)(41300700001)(316002)(4326008)(66476007)(921008)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpwQVlRZTNoS0RwS1NRUmhrZWhrbGNyU2pTOVB4Nng5NDNQT1E3dFdPeFFt?=
 =?utf-8?B?cmFmVEM2dXVvMVN2VE1EZ1M3ckhyeExxajQyNnhLYkZ1L3h4VzNCOXBVOEgv?=
 =?utf-8?B?c3pwa2ZaS0c4ZFA4WG1RME5HdUFIR2ZTR3BjbllaQmZ2S1Flbjh0cTIwVG1y?=
 =?utf-8?B?U09nZkt5ckU4S2JndzZoTFRTWVg4REZpdUx4a0tTVU9Sam43MzgyU2YzV3d2?=
 =?utf-8?B?Z09TOXQ1VjFaMHZvSHd2c1hJK01MUXJGSmoyQStZU2VYZXNQVkJaQm9idGxh?=
 =?utf-8?B?MW0vQTFFazNEZ1ZKMGo0bUdGeVVSYXRxQnhCVGRFSkEvVGRoKzlqTGVYNkVP?=
 =?utf-8?B?WDZsTGpSR1RzNWdHTXVhWCtubStnTU1UekxtRTFWSEJpLzB6UWVjK2E2eUxr?=
 =?utf-8?B?SUl4QnNUSmtrSXE2SVRLQnZaRnNGWmF3SGlFRkdtY1VQODVXcFlyNmNwOG1s?=
 =?utf-8?B?a2pGcDdtWnRmS1VkK3JwK1JyRXdZYUhtc0RVNlUxN2Z5VEl0NFJRY0FrNHJr?=
 =?utf-8?B?NHpBL3NBblgvYWdXQkNOQ3lTOXRFcVR6NDdvN3Z1akRyaVRwWkRmM3FRLy90?=
 =?utf-8?B?RXBhTDJnMkhpM3NqVFh2NHZEUnp5MkphcUFVZGcwdWc1Wm9uZXJvTXo2MVUz?=
 =?utf-8?B?MHJkU3RVM3lpZVJvalRJU1cxZGVIbzYrZEkyNlpkeDFIRkwyOFRDYnZOYVlh?=
 =?utf-8?B?VFl1dHB1ZTQ0NEFUR1E1YVhKTVluZ05zOFluMS9yNWM1NmVTUGZ3RERaMStG?=
 =?utf-8?B?RHhpaE8xTGJRVzNqNnNtY04vQjBKaytwZDNYY1FqRFVwaUQxaTV6SDVnK0Yv?=
 =?utf-8?B?cFhHTStPMEJFL2dSTkp2VjlDeFB1bUNlMElUZ0E5ODBPdHVWRGt6ZklmcVlh?=
 =?utf-8?B?ek1JQnNVQThFeWp6YnRPM3Izak50SnNoNWtFdW1tZDEzUTM2QWxtKytMWmE0?=
 =?utf-8?B?VnI4YlEyUENhZEphdjRlQm1weXpYOENzeVE3TElQSVBwSGgzVlBWSFdWNFN3?=
 =?utf-8?B?K3A0SDdLWDdySGJpQzI2L3UxSEErR09mTU5idUNJZG9lVE9sWVE4Y2VzYjZW?=
 =?utf-8?B?VU1MNFVGNUU0ejhIUGVhMmx1Sy9PUFRKdGN4Q200aW44WWRQS3kwS3pCZDQ4?=
 =?utf-8?B?eGtESnQ3aGNQVTFNd2VZNWJyTGdFd3RucVJkbWx0NVdVWU9Pem5zMHNkM3dp?=
 =?utf-8?B?L1RWTEczMHp0S2dtZVhOZzlCQTF4S2gwczBsR2QrR3hnckVZM1FYS1RVZGFP?=
 =?utf-8?B?YkZSckJ3QmhCWWRWVitudzZaVWtRN1psa3BpcEo5Y2s4amUwVEZETUhxUHJW?=
 =?utf-8?B?TTZpRGlDTTAyRXVBU09LRjFMOVhHUmRKT0lNZ2Z2TVNub01GbVVNZTBRT01U?=
 =?utf-8?B?MlZvWk5NSXl4dG4xdWVBQlZudS9ReWhkdUI5MGllUk5MZU1aQTFzNHBPVisz?=
 =?utf-8?B?cHcyclc1UkVBWjJQQW85OVJuNDQ1cFJtMXhZQkxMdzJhdTNXQTJreklKWjZy?=
 =?utf-8?B?TFpSVlFSc3BwMVYxTW9WMmo4TG1tY2oyT0R2OFNsZzgwcHBabHA2WDlQcFB4?=
 =?utf-8?B?Qi9RZWJHZkY5WURUdmswSUVJRjZMOUdrZW1hMkhQVkhReXlOMmwxdGtXUGJY?=
 =?utf-8?B?TXdSTUo1Y2JuU2htZHpmVlcra1puRG5RYlljZ2prL1FDelNFdnN5NENqR3ZQ?=
 =?utf-8?B?ZWFhbkRCYnZNbXVoZE9hUmxvZlUxYUVscjlCcXlpVHhSR0hVRXlxQWFUR25S?=
 =?utf-8?B?czZJS0RiWlZHYmV0RU5JUHBvM1JEY0hwTVI3NmlOSkZ6OGpEWUliN0dlK1dW?=
 =?utf-8?B?eFE4bnBWUWdYc0pIdW1CSnFaUnA5Wkc0VlFBYXRrSDRuaVNjT09BTzZUMC93?=
 =?utf-8?B?R0VnRnBGK005QzFuUU8zbXRXKyszK3pESUNlejdxM2NEMFMvbFpRMWpvUitZ?=
 =?utf-8?B?Rms4MWJWanp6VThiUmprMFBwV3hYMGV5TkhMNDZ0aUpidWcxdkkzUmNoNjg0?=
 =?utf-8?B?Nnk0cHVSc291VTROWWxvcVpIQjBmalRmSTVoTHFrVzd3Q1B3bWxOeXZYMHFm?=
 =?utf-8?B?WjZjNkxRNThLQ1oxemNlZVh3dlkzcTFCaUVGL2VFZElZTnJhcHZuaUxQNUFy?=
 =?utf-8?Q?AHWaTYQhtco+1IqTSeu9QNZgO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37afde23-c5b0-4cce-3cb6-08dbd6f72f28
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 14:15:34.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mdf1FVviOPQVJn5jziAfhGu33ZOTGlnbFY6x5qShZIrLAVE42/CRM8fiYVKp28hr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/23 21:23, Radhey Shyam Pandey wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> As mentioned in Documentation/process/coding-style.rst:
> In source files, separate functions with one blank line. If the function
> is exported, the **EXPORT** macro for it should follow immediately after
> the closing function brace line.
> 
> So inline with guideline move zynqmp_pm_feature export symbol after its
> definition.
> 
> Fixes: 218f01a80aea ("firmware: xilinx: always check API version for IOCTL/QUERY")
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 4cc1ac7f76ed..b0d22d4455d9 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -226,7 +226,6 @@ static int do_feature_check_call(const u32 api_id)
>   
>   	return ret;
>   }
> -EXPORT_SYMBOL_GPL(zynqmp_pm_feature);
>   
>   /**
>    * zynqmp_pm_feature() - Check whether given feature is supported or not and
> @@ -246,6 +245,7 @@ int zynqmp_pm_feature(const u32 api_id)
>   
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(zynqmp_pm_feature);
>   
>   /**
>    * zynqmp_pm_is_function_supported() - Check whether given IOCTL/QUERY function

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
