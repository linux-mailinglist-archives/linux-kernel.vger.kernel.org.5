Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB49277FAC9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351978AbjHQPb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353290AbjHQPbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:31:16 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE6D2D78;
        Thu, 17 Aug 2023 08:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFZYb6drkL+DvHXRZVghf62opolsHXnznvjJBzJYV0ON2pgEAQCenpc7jyNvtydRdFq3naBRBDgQXlu0/5Zv+puUfmr4x2UYUKDbJo84Z2z7m4w6PXOyDJ7sVoqWn5mncboIX2wbBetpZnsyb88EELLkrFgmww1sXJbGQezuynXm33J88XJwEGuxmD6Hiub0Kjose5jNNPOB6pTA/gBCRK6hYINz5ovTDxmX2hlPKRK47IOunlRPbVFrTcas07dmhr6llPvID8Bt4cIGzKHRR3NfZEWdcDyZrXKiV9sbx8fxrBMmTMxqBKVc1b06tmSfd75tL2LAdrNKwcdLfNTmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KWYN3nnuixr9cPWxBfxlS38ZvNlKXlrRqJAXTvAMn4=;
 b=RoLMSMVmXRAvw8pXf4SPoTZnX5/k1Fyopp2jjFJOIu0btQVLTFai8VZIDkSCTbNnlM9Tb5NC/X98PYDrmuC2uatQ+zEdmuOcMN9R3RFvbsWZKsibiU7yQGg6808LWM/lmhVtWH/UmZEo0DAQJ4eCqH8fiP4sWE44Y13yV3TPUw4voAQE8FntZ4YG/bUiZt9+Tb8303MkIssVhSCUyUEp3+PHxjoKvHMzMQ+MJ5AJ/vWaeXgpm5i22b1pcdju5hJJG/eZWHMaRe14AwygQsxk+J0J0yYEA6xBBh9LpAniv76+zpRzD27/6KgfbgCmQuW5WCuDMCKCwuA2nwjT82JZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KWYN3nnuixr9cPWxBfxlS38ZvNlKXlrRqJAXTvAMn4=;
 b=KzAGkoWqix5o78mGYDPUWvMG3IUNQvEq1fqOqkhJcGnKxNoX+KaXElXthWWRs3GXhTDHEi6x6CXELBLrEC91W4q7fz4sgojv5Bjkjpzq5UReOMF66UXgZqBOsk4jSCxWAhcIKXygcIab2UWF0vW3sn1y4tKNZPWtUQal4LaRTr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB9876.eurprd04.prod.outlook.com (2603:10a6:20b:678::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 15:31:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 15:31:11 +0000
Date:   Thu, 17 Aug 2023 11:30:58 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: return -EAGAIN when
 SCFW turn off resource
Message-ID: <ZN49MnvZ4XWQPGd7@lizhi-Precision-Tower-5810>
References: <20230712210505.1536416-1-Frank.Li@nxp.com>
 <f1d4ed62-8d01-173f-6e41-4671228782fd@linaro.org>
 <ZLGDhOffQwh7xW/n@lizhi-Precision-Tower-5810>
 <7eacc4da-ab14-3df5-2864-44a7262bac27@linaro.org>
 <ZNz5Drb+EVLjWxRV@lizhi-Precision-Tower-5810>
 <dd42952c-4dea-ea57-7ad2-73fa159d265d@linaro.org>
 <ZN0CVa9or/FltHJM@lizhi-Precision-Tower-5810>
 <80324fb7-3d2a-ecd3-f1ca-9745a366eb0a@linaro.org>
 <CAPDyKFp8-XwwHEt9dKeTMj0ZmoS6nzXrUYAFmpzZm16-Uf6=xw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp8-XwwHEt9dKeTMj0ZmoS6nzXrUYAFmpzZm16-Uf6=xw@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::18) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB9876:EE_
X-MS-Office365-Filtering-Correlation-Id: 14075eaf-0b88-4fea-5bba-08db9f36fc95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EGAQvjzrxPxSlO6aMi80pCbV/VYrnn36Uh/4I6CazLUYpLBeZDOm844C3UrEDaHTh6zR4M2kxlinjay9EdgkZGwVT9SPFC4xiTl3eyb8FYJiqNnKzm/8lP3Nf2h4rjttN+kof6PvIND7AdBFcscbFWv+sKiybR+PXzbqBCwJzGOBN6/HeCEJ8ijKrurkMhHcqC0+9DVAD2to4V/PBBDL/TV5RCfC8E4C3ctNwrMmNZ2uHRuufPPb/AXS9dFXZdpsKqCQ215ABaxt3ftvCEME2uNGtgbJwl+/AKYN9s/4Bz3sBrdP1WgwsW0ORroK1m6rmK2Y9XBAdvZ87tebeixr/+RAUcL9txH+wVksGtelByqnsTczEtRARwDPC11rEz7Iq/CI0E1tKBygXNZoYTAFxxHidBwqDDjll7VZhTbVs6DplKw0RF19Mo7Q9XYeA2ajF/OXg5xUpaVi55Krs2v2B2vYLEpkY/OH4y9lUhRzgF9RAYpJ3UwIJP3k3YQUubYFiLyhYCm/+sIjUaWlVlG76d8jZX4EtWaCbLgDxmEmaSXdELo1NboOrB75U2/jfSAdCTAEigz5KPW5J6DBgasMthJx+UwDo1Xipqqf2CIBKaHig/o7M9kCeV0NMORig2H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199024)(1800799009)(186009)(83380400001)(478600001)(6506007)(6666004)(6486002)(26005)(41300700001)(38350700002)(38100700002)(9686003)(6512007)(316002)(6916009)(53546011)(52116002)(66946007)(66556008)(54906003)(66476007)(5660300002)(7416002)(8676002)(4326008)(8936002)(66899024)(86362001)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xAHpVRUFfIIrZnI1KpchH5rV7+KheKhsjvrLUz5fJogrGG5TSob6COb4ZB6r?=
 =?us-ascii?Q?BD8ANyxCfP3wVXUNwS4oZJ4cZo5IoJRUoz0wcUzCssCSRdaJf9la7TuyJiZ3?=
 =?us-ascii?Q?TC05CqDp3vqR2YMTmQo26b9JT7W2knUqy/cyM+osMOK2xbuQVGIUAHyl8Jvo?=
 =?us-ascii?Q?/VKNobydHQ7v/agUVuBKxSV+4x5C/nt2Ylpaz8UzAUujcS11zvECsc1DJTEy?=
 =?us-ascii?Q?wRrgFOX4+2kTNENfvyTxYuS75OM9bx1QqECP85GmGU92J3XDTBf+QBeeETCt?=
 =?us-ascii?Q?YfBjI/xEx+LV8E4T/8aP3EB7MSfJu7qIqvDPcwTYXoFZBUPCOlot31dDwfUA?=
 =?us-ascii?Q?aYjTB09GmJizzHKeVGnt2G8k76wjYyGaQeWyf5gtK153QRuYafonEubOAibn?=
 =?us-ascii?Q?hA0LKewi4r1yompUZB8//mi6IbVOQ8G4dFRnXGQ9BHx/rqBuLC6RaHCpzwZ+?=
 =?us-ascii?Q?2F2NAhViy6APZa/d6pfT/11kzka2pQbdW5C0OSlb5jcf0Jl8jvEDyZl+pNff?=
 =?us-ascii?Q?Uq0cllG+DFkYCQBeGjfQsGXwWUFI6Q4DKMN9vJldgoz+cqVxQrpxc3TFPqSj?=
 =?us-ascii?Q?y+IyZCEUt4HsXp103O1S1omXXNVaiTYKVWzdNaKzIZPlVo2UsnyzcAKDKJTD?=
 =?us-ascii?Q?9wP90MZWWu7DqVOyUjODJdvVnk2gsB/UWEjxX4Uh1zim9iPfxo0lTRCMSD85?=
 =?us-ascii?Q?OTf2YudZRn6xUU1t+qbwTW+7/gQxyNXwF0trYc5RDb4qElCntyI7bi253PDH?=
 =?us-ascii?Q?Nss9CUFjgOeKL8tOisjuCZM8tJ9mrexCU2U6nIPGkjzejyqX1QRM8rvatUp7?=
 =?us-ascii?Q?uwAJ7bzcJKWzzyMi90X8lQBixFJIY7p1u0JR8zSgr060RY/E7GCo3rEhDFAy?=
 =?us-ascii?Q?Aq91SyWZcHE8uS6RoCJgFMKtIyy8kj8LpRzXmRFwkmtjk4d+H7DqcijRAm+U?=
 =?us-ascii?Q?7pE8W+2i+/UyLk0BKAuZd+vLMX6yrydyxSAGQTLGO6hVyidJjG15B0/1UqI4?=
 =?us-ascii?Q?Xin+q7xKWgScMGGkEt4q9LyuM3jAe6HLx4LNcjFLC4HIEddQ7JiXA93lD2LF?=
 =?us-ascii?Q?m4wFXTwbcGesusyTBzZ+KwMVhXgbZGpBFGtq2nX19qYpbXIpGvu1gD9M9i34?=
 =?us-ascii?Q?CHPC0HmUkXt5Zrfp+cvCYDA4QWIry7KtR/NWnK1Qy9OEI4eZ5uUcsOysk1Kv?=
 =?us-ascii?Q?IMZDTK8yig1MY1TdNQUlSUdDjcUEj7ChQPqRqFUklxWy48Odg1/npwvn/ZBK?=
 =?us-ascii?Q?vAtdCsKlm46hcf5SQkHJgptwfc6Ooc/lzUo3rVuH4Lxw31/daVPpEWwfj+8i?=
 =?us-ascii?Q?T0YaHnJTiRPSGoxNGUpsgiAJe6Z3Lvcfuesfano1JSbT8h2FWs7DuM4QaONb?=
 =?us-ascii?Q?8+BeVUSEfCf/WYgOIJUZJjb0vhoGRzDU7Q8whCUKrTYNBSAupVyR/BlDu0pJ?=
 =?us-ascii?Q?+XDHE5ehv9eM8BVDI+tV/P1eMndTi5G4zwPnOvFJFKQA80Hls0ImoAc6m5GM?=
 =?us-ascii?Q?3uaGUxq1b3BIss0wP2eIfiRB8drfi6WtK8qS4i925K1VNxIRVAPrBSJ27uQk?=
 =?us-ascii?Q?QKDfZtUdgd0upSEil1A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14075eaf-0b88-4fea-5bba-08db9f36fc95
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:31:11.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5dIEsRfNModTkIRTWe016X1zgrg4N3niRyNZ3AQ0PFeHLrTMbWak9V1M9PeE/kPzfvaqTJpYMkIJhvprcNkjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 11:23:17PM +0200, Ulf Hansson wrote:
> On Wed, 16 Aug 2023 at 22:46, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> > On 16/08/2023 19:07, Frank Li wrote:
> > > On Wed, Aug 16, 2023 at 06:47:17PM +0200, Daniel Lezcano wrote:
> > >> On 16/08/2023 18:28, Frank Li wrote:
> > >>> On Wed, Aug 16, 2023 at 10:44:32AM +0200, Daniel Lezcano wrote:
> > >>>>
> > >>>> Hi Frank,
> > >>>>
> > >>>> sorry for the delay
> > >>>>
> > >>>> On 14/07/2023 19:19, Frank Li wrote:
> > >>>>> On Thu, Jul 13, 2023 at 02:49:54PM +0200, Daniel Lezcano wrote:
> > >>>>>> On 12/07/2023 23:05, Frank Li wrote:
> > >>>>>>> Avoid endless print following message when SCFW turns off resource.
> > >>>>>>>      [ 1818.342337] thermal thermal_zone0: failed to read out thermal zone (-1)
> > >>>>>>>
> > >>>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > >>>>>>> ---
> > >>>>>>>      drivers/thermal/imx_sc_thermal.c | 4 +++-
> > >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
> > >>>>>>>
> > >>>>>>> diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
> > >>>>>>> index 8d6b4ef23746..0533d58f199f 100644
> > >>>>>>> --- a/drivers/thermal/imx_sc_thermal.c
> > >>>>>>> +++ b/drivers/thermal/imx_sc_thermal.c
> > >>>>>>> @@ -58,7 +58,9 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> > >>>>>>>         hdr->size = 2;
> > >>>>>>>         ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
> > >>>>>>> -       if (ret)
> > >>>>>>> +       if (ret == -EPERM) /* NO POWER */
> > >>>>>>> +               return -EAGAIN;
> > >>>>>>
> > >>>>>> Isn't there a chain call somewhere when the resource is turned off, so the
> > >>>>>> thermal zone can be disabled?
> > >>>>>
> > >>>>> A possible place in drivers/firmware/imx/scu-pd.c. but I am not sure how to
> > >>>>> get thermal devices. I just found a API thermal_zone_get_zone_by_name(). I
> > >>>>> am not sure if it is good to depend on "name", which add coupling between
> > >>>>> two drivers and if there are external thermal devices(such as) has the
> > >>>>> same name, it will wrong turn off.
> > >>>>
> > >>>> Correct
> > >>>>
> > >>>>> If add power domain notification in thermal driver, I am not how to get
> > >>>>> other devices's pd in thermal driver.
> > >>>>>
> > >>>>> Any example I can refer?
> > >>>>>
> > >>>>> Or this is simple enough solution.
> > >>>>
> > >>>> The solution works for removing the error message but it does not solve the
> > >>>> root cause of the issue. The thermal zone keeps monitoring while the sensor
> > >>>> is down.
> > >>>>
> > >>>> So the question is why the sensor is shut down if it is in use?
> > >>>
> > >>> Do you know if there are any code I reference? I supposed it is quite common.
> > >>
> > >> Sorry, I don't get your comment
> > >>
> > >> What I meant is why is the sensor turned off if it is in use ?
> > >
> > > One typical example is cpu hotplug. The sensor is located CPU power domain.
> > > If CPU hotplug off,  CPU power domain will be turn off.
> > >
> > > It doesn't make sensor keep monitor such sensor when CPU already power off.
> > > It doesn't make sensor to keep CPU power on just because want to get sensor
> > > data.
> > >
> > > Anthor example is GPU, if there are GPU0 and GPU1. Most case just GPU0
> > > work.  GPU1 may turn off when less loading.
> > >
> > > Ideally, thermal can get notification from power domain driver.
> > > when such power domain turn off,  disable thermal zone.
> > >
> > > So far, I have not idea how to do that.
> >
> > Ulf,
> >
> > do you have a guidance to link the thermal zone and the power domain in
> > order to get a poweron/off notification leading to enable/disable the
> > thermal zone ?
> 
> I don't know the details here, so apologize for my ignorance to start
> with. What platform is this?

i.MX8QM.

> 
> A vague idea could be to hook up the thermal sensor to the
> corresponding CPU power domain. Assuming the CPU power domain is
> modelled as a genpd provider, then this allows the driver for the
> thermal sensor to register for power-on/off notifications of the genpd
> (see dev_pm_genpd_add_notifier()).
> 
> Can this work?

I don't think. dev_pm_genpd_ad_notifier() need a dev, which binded to pd.

tsens: thermal-sensor {
	compatible = "fsl,imx-sc-thermal";
        tsens-num = <6>;
        #thermal-sensor-cells = <1>;
};

we have 6 thermal-sensor, which assocated with 6 pd, 
	IMX_SC_R_SYSTEM, IMX_SC_R_PMIC_0,
        IMX_SC_R_AP_0, IMX_SC_R_AP_1,
        IMX_SC_R_GPU_0_PID0, IMX_SC_R_GPU_1_PID0,
        IMX_SC_R_DRC_0

We don't want to hold PD on just because want to get temperature. GPU pd
consume much power.

I want to register one callback at thermal-sensor driver, when GPU pd on,
enable thermal-zone. when GPU pd off, disable thermal zone.

we can do more common way. 

	gpu-thermal1 {
                        polling-delay-passive = <250>;
                        polling-delay = <2000>;
	>>>		pd=<&GPU1_PD>
                        thermal-sensors = <&tsens IMX_SC_R_GPU_1_PID0>;

                };

if GPU1_PD on, then gpu-thermal1 enable,
if GPU1_PD off, then gpu-thermal1 disable.

> 
> Kind regards
> Uffe
