Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE477E667
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbjHPQ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344703AbjHPQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:29:04 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2044.outbound.protection.outlook.com [40.107.14.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2546110EC;
        Wed, 16 Aug 2023 09:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/nAZwvhz82lbf0C6+ZvIZ/Xe6Mj+MIxVEGCsy4yN2g7ztezdN0xBOmNRB9862BlW+4qAmSo5FxaGWIZIVQ9PIUQzIDvxIlvG23yhsN7DFi4Jmq/UQS4MxSYxRhE0xQ4C77lDgpBZQxSZqZXQw9ue5PEIicUqc74BYdXoUwUmMUP0FaHRIRIc8C4efj9BP5PaK3+R2Vx+ioum39DAwDRwUxdyoVFff3Dxstgzq54sia0+itYD3MNir2cPH/TFkmdg2O1HFKLDze5O5HouYh3LUNVEL9okMsKoOM/v60WHwed+Je/6f7texil31ORnj9djZWtjZfv15H2MEkWFq5TLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbrMgCfBEWNZsDhEUnapzHTgtTC7Qj++VrDEx5Fr/Us=;
 b=C992SfKi/dd411hGZKd3XQSFpqYvD0++WDNyXAZwUX5tRdp0XZP5omyfqJwlhfeGLC0TSj//5nUBHIkCoFMuCK3VLN5gLuvqyZmcDf55OzMDR3EQfvdaBxGAGJGI2WVEBWsVJK4W5KXLkrloZ6o29cuNUpakKrWkZbKCYtp60ZOwiF0M3kPnkigJB/NN0x9OSa5v7TrIIjt61d416M8BmSBmVOuibsTE5M06b2bCbaCEGBVT0cd0M0derVlOqfI5CcQ2RzJlyOQfzsw005PkRICs19VMfk1YWtnli2s6GbTh7UcYoJ5XEoCVV9r6XcZBUn2RhjMubsBqH46oHq7NGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbrMgCfBEWNZsDhEUnapzHTgtTC7Qj++VrDEx5Fr/Us=;
 b=GXVDEKAw4Ettn47cdJZI8n/nYha5x8SeInbw1KDzj3A4FCK0zsaapoPd6Mb1AGaGGCxqCiOKfBdjg+NW1b0DI0ICHupC49ISqs7/C7J7ZAZB4amJ9NlmKbBdD85OzOvETd42j45aszAJFyKSd9zilydPQWl/ZIbL9Pidu28dE0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9502.eurprd04.prod.outlook.com (2603:10a6:20b:4d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 16:28:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 16:28:59 +0000
Date:   Wed, 16 Aug 2023 12:28:44 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: return -EAGAIN when
 SCFW turn off resource
Message-ID: <ZNz5Drb+EVLjWxRV@lizhi-Precision-Tower-5810>
References: <20230712210505.1536416-1-Frank.Li@nxp.com>
 <f1d4ed62-8d01-173f-6e41-4671228782fd@linaro.org>
 <ZLGDhOffQwh7xW/n@lizhi-Precision-Tower-5810>
 <7eacc4da-ab14-3df5-2864-44a7262bac27@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7eacc4da-ab14-3df5-2864-44a7262bac27@linaro.org>
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9502:EE_
X-MS-Office365-Filtering-Correlation-Id: 2123201e-fb7b-4361-09a9-08db9e75e50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKbMp+EgcL/7OYG9ROFQCYq0b8+KIK1su/0vLFT3Vx6EeOoUzW6UK7ntnwPdxaSTTPjRRihZy/vcSPbu9izKpySzuHvuFLNixva7xtQUYhxkpsT473ayI3hlDq4nEwwaurjw7sbM9NXy/gp2Al3wDcGGWtYurI42hNsZ5OD3pvhNeKOuoWLuSKnH5TYHSdiYJa7ISKVwThVNG6Lm3XrsOeShkYetyhzH2PjZHNO/A0POwMw8hUi/3Akwmlj5hIbua+uU4nt/DH/9iHvUSPc6QekHqeTvdW+pBHcUb1oyYVPEfJvk7/WE0+iK/w+ULBIpjVIXGTypwoCSNz60eGUdHDa1ng3tlTH8I8YnoxiqHgTI0O4p/T8K141O78jFnbswJKVWWnf5ShqTGqcGnfFo2K9ReATMMsqjQSiC7ywP7jh6z3dtJhEOuqXmGnjgdqEtfhDQDpL7U0wlAfWdg9yT50tcDAm+a6MSFVuQ9HcFu4T4jiBau2lky8ZG7tcdnLJjdIEfbhvtmmZkEoxCXtBZT1Rh4cBbxEFgeCRowpBp0QGdVlXd3rPFEEw/5fhtKCVGUWLrzbw9Oc3621StU6t7Y3HXYJeCOYK/usH/nBU66c5Rxd1MKIqvV9i2XNZku4ul
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(4326008)(8936002)(33716001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(9686003)(6512007)(53546011)(52116002)(6506007)(6666004)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCthV2lyd3MxU0RGbU9kejU5emtvWExTWUpUZEVjWEFMd1VwR0Z0dnRSY1Jl?=
 =?utf-8?B?KzcvNytZblB6Z0pBM3pOVFpwdVlSNWtmNFJtWXBxRUZyRmIzMkdoYUplTkJX?=
 =?utf-8?B?S2dROW8va0NKSGxoZDFlQUVRdXNKY1BkcDVrajQwK1ZZN0c0N3J3T1JGUFl3?=
 =?utf-8?B?WGREOXB6MXJTTE5oSjVLVTBEcUUxLzhMeVdlY2h4OUUyUTN0MDZTNWFnWUFz?=
 =?utf-8?B?Q0Zwb3YxWWtNd1Iybm5DN1J5THZpV1BhTFdaa0NIM0pYZTlTY2NkWExLeDkr?=
 =?utf-8?B?TUtnaWNFN3FFa01IVTVZNFNlenl2U0dnUk5ONldTd0FuR1krR2xkQ2gyRlJF?=
 =?utf-8?B?d1dKT2c2T3lHay84TllIQmNtQm83WkNTNHNqbkZaV2wvYnhhRXBYZmZlY1Vi?=
 =?utf-8?B?bDZpUDY5REpVRk02U1o1a3BJM1JOZUNwd1JmVjNSMWJNU3ViOVdXc1FTSEhx?=
 =?utf-8?B?QVo0djJEQXZSNXpFY3FMR2FlUHFJY1dxR1VQVmlzbW9EVzJldWdZa1dmZ2FF?=
 =?utf-8?B?VWJ3bEx0T0FlMm5nZmZVRjZ5cDlBSjZ5U0Rvc3B5Vmgyc1ZpYXBCR2hJRllz?=
 =?utf-8?B?MFBISjQwMmlmUFhVL2E1VW9VdlN5UFQzQk4vWER5NEdmWGpaeGxLcUttb3pl?=
 =?utf-8?B?dnlkbWhaN2dEeU9vejJ6SWFoSEhEQjZyaHFHazg0eCtxaG5aQmoxTVlLcUkz?=
 =?utf-8?B?dnRkUTFIaWFIWlR6c2t1bUErSjV1ZkFteGdXcU1WeURtaGpNYXUxNTVZSGhO?=
 =?utf-8?B?cDVVWlpDMEJtYzV2UnJNdTZlaFYyU1BXSFR5eHZTWTFXMHpEMzh3b293ZFI1?=
 =?utf-8?B?cW9xVnNlQzNyTTh2R0tSWitPaUxWbUJycncxSm5mOS84bkVJcCtqQVVZZlFO?=
 =?utf-8?B?Wm9mTnBsdEJFZlRMVllhM0NrTnFqMGUwM3kxZzlDdXYyd1BRenZxN3k2WUNx?=
 =?utf-8?B?U2NoV1ViRVpGMHFXMUhZYjVmNWY1cE02eWRpSUExYkNTNkdiT2VjditXdUd6?=
 =?utf-8?B?K0JyRXRxRG16QU9tTFJrTndXTmxDdW54ZVZNS3dPa2NDT2s5c1FmRTZWbHdx?=
 =?utf-8?B?Z25tcTFlVWdPQnZCWGxveWtTS1hKQzdJWGZTOVBnN2R6S3FHR3Q3YWhHNzRv?=
 =?utf-8?B?aWRxUGFCZ1FOWU5lQmszZjFHMWVuY3NWZXVQS0lkMmdwQU41c2IrNG43ZjY4?=
 =?utf-8?B?ZG9Pa043aU15S2dBR3NvSUJEVGROZ243TVc0ZWd0dTROK2F5c21mUnA3YzZl?=
 =?utf-8?B?T0t1dFpRQ0FSYjNSOU1nZ0RoV2Z3QWdkeENhempzY0J3dHRDbENzU09NbjdM?=
 =?utf-8?B?V01CcWRYaUErcnZ3Zmd0anVwQkZ5WjRwUTNLL0hjVTBhOFM1UExPeHBBd3dC?=
 =?utf-8?B?b3RxTWFDdFQrQy9hUU1hOWE3UGg1VS9KZEVjSDY3Wm5ZZWJ4dkhncEtCSTBz?=
 =?utf-8?B?MkxsN1dZYnUzR00rQ0hYbWRPWG8zeko3YW43UGtZUG5hQzBoNC9waVBUZWdh?=
 =?utf-8?B?TE5ZNVIzYUNibTZwcnRjRkhTcW4wdHdCWmJicFRCL2ZZY0RIQ2xucXNoUTV2?=
 =?utf-8?B?R292dE9VSkE0dmRMRDYrZ01LcG02QnBoWGtqeVlFVnlVclNxSHhXRGZUVmpD?=
 =?utf-8?B?MDgrTk5Jam1QbFNmZTEvdzdEcUd4TEZjakNlS3o2V0U0TGM0c25BTVk1b1cw?=
 =?utf-8?B?NWVGaDNjTUw4Qmc2c29obzJ4MUsvVWtCZmxiRDNjTUhxOVVJMHhZUGRpZEJC?=
 =?utf-8?B?d1ZIa1hTdnpUaEx5Z0RVcC85WTQ4L1B6MkM0UTJ1U21PamZGd21MNGlNVG5V?=
 =?utf-8?B?QXFBZGlNRE1jSS9UOFlqN3RxSXgyZ1lyWE1aVEVsSDRNaVl2WnpKbUlFaTRt?=
 =?utf-8?B?MTQvRitkb1lOVDRwV3ExTkFBT0ZxdHdYNFNFM285OGZRTXR6VXFHUTQwRzBz?=
 =?utf-8?B?V3l3aCttVWhpQ1d4NzdJcVNHL3V6cjg4MWQyTHdYRHl2ZUVwUEF1Skl0WmN4?=
 =?utf-8?B?eWdPRnhyTVdYSDZ3RVhOaVY2VXZlcFZJQlRNVVg0RW0zdDBHSTVUc3ExYmhm?=
 =?utf-8?B?bUwrdWhlS1dGYzNFL0s1UkxMTUNEd2tIbE85TkxMOGhjQ202bmpPcFlSMXZu?=
 =?utf-8?Q?5gJE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2123201e-fb7b-4361-09a9-08db9e75e50d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:28:59.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLDwyy0FDWSaGqBltd2HNWXTMa7HdmLsFbcqp/ymKXxnRsltH0KIxewlwXWah0QN9KpOtKxlEZWnf52M6G0MLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9502
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:44:32AM +0200, Daniel Lezcano wrote:
> 
> Hi Frank,
> 
> sorry for the delay
> 
> On 14/07/2023 19:19, Frank Li wrote:
> > On Thu, Jul 13, 2023 at 02:49:54PM +0200, Daniel Lezcano wrote:
> > > On 12/07/2023 23:05, Frank Li wrote:
> > > > Avoid endless print following message when SCFW turns off resource.
> > > >    [ 1818.342337] thermal thermal_zone0: failed to read out thermal zone (-1)
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >    drivers/thermal/imx_sc_thermal.c | 4 +++-
> > > >    1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> > > > index 8d6b4ef23746..0533d58f199f 100644
> > > > --- a/drivers/thermal/imx_sc_thermal.c
> > > > +++ b/drivers/thermal/imx_sc_thermal.c
> > > > @@ -58,7 +58,9 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> > > >    	hdr->size = 2;
> > > >    	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
> > > > -	if (ret)
> > > > +	if (ret == -EPERM) /* NO POWER */
> > > > +		return -EAGAIN;
> > > 
> > > Isn't there a chain call somewhere when the resource is turned off, so the
> > > thermal zone can be disabled?
> > 
> > A possible place in drivers/firmware/imx/scu-pd.c. but I am not sure how to
> > get thermal devices. I just found a API thermal_zone_get_zone_by_name(). I
> > am not sure if it is good to depend on "name", which add coupling between
> > two drivers and if there are external thermal devices(such as) has the
> > same name, it will wrong turn off.
> 
> Correct
> 
> > If add power domain notification in thermal driver, I am not how to get
> > other devices's pd in thermal driver.
> > 
> > Any example I can refer?
> > 
> > Or this is simple enough solution.
> 
> The solution works for removing the error message but it does not solve the
> root cause of the issue. The thermal zone keeps monitoring while the sensor
> is down.
> 
> So the question is why the sensor is shut down if it is in use?

Do you know if there are any code I reference? I supposed it is quite common.

Frank

> 
> 
> 
> > > 
> > > > +	else if (ret)
> > > >    		return ret;
> > > >    	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;
> > > 
> > > -- 
> > > <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> > > 
> > > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > > <http://twitter.com/#!/linaroorg> Twitter |
> > > <http://www.linaro.org/linaro-blog/> Blog
> > > 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
