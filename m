Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB12C80124F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjLASKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjLASKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:10:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0452197;
        Fri,  1 Dec 2023 10:10:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftgmgVscezrWE+u8oVEcNvG/+vzcseguL6FdX3oAe/nZW5XmWgyK91EghCZUFWnoz0skMvfzzVQQ8460WEdSyiUK0pK08ff6zn9WGOQoqxMFahCiTz0zgvjFxog0dEZmuEDm1jT31sKe1alEkjxXyForIz2uDWYWHdVNC/uT3e4nVOwQlHkvIjedKE4M+nxHiM6gVvI0QxqH5CtIoyyTNbVSLkFENWG1/FlQqUAaO5IjZZcDu5dqq+hmsMpcZjDW3j6cF81poLwwOi5bWkvfk5Cf05A2vL53ZzVXm0soG5WHS+L7qvuwsQvQHBBOSaxPrS2tsfyIzcnbXIXlWdglGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6VMEESb+fJeWIrOX6bLVwqg4HS5tXTX3avrJBfDZHA=;
 b=H5ZUgp2QvA2epxOm5mp3OdqD4jPKx7iZkjiDVZk2QdYwFxlCAGS1sVQjoaDT+IPRilavD0By7P71aa2q865ZrtIMainiNB/Ls1dUojipukfhGCbKGSyzhMIUAD9qfiffZbKAVCiVvrXb2ohceugWOBXNKQWTrNGw7cnDwyVhwcDyU5I49J/ofbyuDfPRR2S1nXcdi/K9UG/u5HdynSyf/EYoAwamFqkmbOBwqk8lW7Ce9o/3WPjGL3UMrvui9508luf67nSnyWohVGUkxWD74UNoki1AA7ihGvkWnvmiMJvOwLzdn7BlikXPwzaZ/oWF3jWU4wrR8eTbSBXdhS+SPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6VMEESb+fJeWIrOX6bLVwqg4HS5tXTX3avrJBfDZHA=;
 b=Kbit95VA/M5njRktZOstBP0oCh8Di9uu+iWryaxhJ4mLt4A1PIJD3p92DqZPI8XfUGK1MdAlkp/PfNIPjXR63l4WMgNRQ1YhpUUCqWw2PciLVYlgpd0PpDqU0te3vvsPBJoEOWscpUDX9tNXQ+dVKCzP73hhQoRJprVFa/zVrXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.27; Fri, 1 Dec 2023 18:10:39 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::dacc:66a0:6923:a5e%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 18:10:39 +0000
Message-ID: <ea2edc6e-6655-47f8-8b6d-242f5a0ef804@amd.com>
Date:   Fri, 1 Dec 2023 12:10:35 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 3/4] remoteproc: zynqmp: add pm domains support
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, ben.levinsky@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
 <20231117174238.1876655-4-tanmay.shah@amd.com> <ZV02P3bHEhPLQHBo@p14s>
 <93487d3c-c324-4b9b-8b25-0b4ea52237b4@amd.com> <ZV+V6V2sEWgsqngk@p14s>
 <a75b22c1-66e3-4fce-ae64-de79e73f3cfa@amd.com> <ZWdwl/8LC2Nn+vCq@p14s>
Content-Language: en-US
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZWdwl/8LC2Nn+vCq@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::17) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0235ff-5611-44a1-dc57-08dbf298d2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dwa/XSJmf72OblEVk7F2tQecamctlOv3dCOyfTneP1o3K87rlxHz+hfvFwfs/Q+4j3JRpqOMgXKOQv06Bgvigjp6J5aVyaYT9pk8QwtY3D6+UNjGMwfBBsrNmXKfL9u2wfLlfOR5cP9ZJnm8ofVbXWZCsSvFb913466zgA+plgqZaLHcpQ64ydf1ClL9XAIUwqXRPQxgA14jV78UmxYngkAEUk9gicf10ijC5604mUM1ga6oyCOM6TAsINZV8lJbQoGqik7o6F7/x5OgxUyIBDUac7IG8tI9hySoOSYEO6TP6gaXWeVePgFKjUTb+pbMGoE1L93QhC8OcrAl5QgEm13xEUlG94ILtl7/XHPaWmI5tpbDoVncJntH1/4rE5/RQRyBVCjRXEgS6KlumAXYzgzZMFqrHAPg1YeHDeEFA3Frm9zNxD8YRYXAcW6sFUiXCx5gpQlrgJwQnOU/x/iYMRKeBwfP8SYNzuc1FXQ6a/ZJ/6G7iF3WZx3DCfXrgBfOZJjCyvyP7Yxn8lpePrh2N5a5Q2xfHWXbf8Ys0Qy1E1PkOjKZSWnAktJXr0WA3ZaHBqug+uU1YforJXqnI//Qbn8yVhJXh+uh+q0+RhbNa3ZI+cWaXA9hQ4+0W4WgLCOpVVSdNQ/q6yi5jMwJ2d8Kyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(86362001)(31696002)(38100700002)(36756003)(6486002)(478600001)(6666004)(316002)(66946007)(66556008)(66476007)(6916009)(41300700001)(26005)(2616005)(6512007)(6506007)(53546011)(5660300002)(44832011)(30864003)(4326008)(8936002)(8676002)(31686004)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alRWNHdwcDZ3d3g3WWxDVXpOaEt0cEJRK3ZMMzl6WW85alZUdjd1N1VQYjV0?=
 =?utf-8?B?OXZValo4aTRpSTZtbThqUnRGUFhUalFpdng5YittR2tuSUdFeGhZRndNZzBR?=
 =?utf-8?B?cExuMVBhMkZEQWkwdStDcjIxLzloL1NNaFJ4SWdkZTBKWWFBakFJb2VYVUVC?=
 =?utf-8?B?UDQ1M0Y5MlpXdGcxMHlzMFlDZmJpTnA0SzN2NEFpMWI0RFQxVWdvWjZoUFQ4?=
 =?utf-8?B?SWZscncwdnNrcU1EOURBeUhKaWtKd0RBUkFUY29nSmQ2bVQvcVlGdU5yQTBv?=
 =?utf-8?B?OS8ySjNOY05DUlRIRXpwVnVaT3pibHQ4N3cwNEcrVGxGWGt0MDk1em9LcXB5?=
 =?utf-8?B?cTRIMTJWZW4vOWFyYVZ5MlQxWCthNHdrVDhPTFFLbHc0M0tTUm5rcENWTVZ3?=
 =?utf-8?B?NU1MWVhTOGdLaUZQRk5UQTN5ZTJXZUI1Tm1PN0ZBMWhqNTVmTlg0U0RjRFdC?=
 =?utf-8?B?WFFrQWNMajlYMlBRd2doejBVOHNPbkF1WWZPMEhKQVJNVzlVNm43OUZna3hp?=
 =?utf-8?B?cURLN3hvdXdSRVhFOWNhSHFSWDFIUWVUZHFvQlF0SnVJTktTOFBOdGxsUjkr?=
 =?utf-8?B?UU1sekN4aDcyWnAxUnlpcHBkMmpiNnp3QThOSXRjQ0dRVm9mVFNENWtTK2V0?=
 =?utf-8?B?VEtCcDY1ZTFiZ3E0enVsUW9uSGhKWlUwcVZBOFczRUh1ejM5VitTeUFuc09C?=
 =?utf-8?B?UTdvVnlXYVp6Q3duT1lQTm9WTnc4YUNtWGRQQmhwMWJoSmxoS2ZCWTJtcXdO?=
 =?utf-8?B?MlNEL2pCdWxTMkJzQUVPQ1JIdVIyOHhFUUExYy9QalBSdEoyMGcxUHBVN2pY?=
 =?utf-8?B?a0VvWFJNdm40MEo1d3NWSGtWU0Q5RXVVdlE5aW1YWDI5SzZWQnBKTGJONGI3?=
 =?utf-8?B?VXkwdnFjNzlwT05UL1hVQlNBc2tyV2dxMXk4S01KRE5LTHZqODhXbmhrN3cz?=
 =?utf-8?B?MFU1NmdtVy9rY1oyZGJqOFdYNGZpM2RDWUJNMnZHNDRjQTMzclVZd0VpQytX?=
 =?utf-8?B?WUNWS08raVQvN01DeE9BUlBwL3lyUGJUVEpZN09QVU5nQU1MNjFJNTZwMTZF?=
 =?utf-8?B?ekZiVnZQMXhNM3lKWUVZeS90UXp1TVJLSzlvdDArQkxpNTlVM0I3OC90N2Iv?=
 =?utf-8?B?b3E1VldrYkNVQ0dIM3pLemVvTlhaREpXK1lPWnRIZ3B6NzE1eWN4d2FNQ0RX?=
 =?utf-8?B?cnMrNFJvYTljZElnMGdVOEIvdlJUNEoxakZLbFk3K0I3cVNEcEFNNnBRWFNW?=
 =?utf-8?B?ZUdmZkJUdmwwSWFUMjF0ZzF1MVAwUEZrZTEyc3JmeDdGaXZWVHVzQURnWmtw?=
 =?utf-8?B?N0RkY1phQTJRR051MzVxVmlGZWFjemZRc1lqdUY2LzNLaUZTaWUvTFgva09O?=
 =?utf-8?B?MG9uaHIyTXV1TytSekVaelkzbDNkK2RiSGk5bnhRWW1Ic0llVHdhRHdZWWsy?=
 =?utf-8?B?a2haWktIbEFSYnJjNFhsM0lzQjNLNG9GRTVvU2E0OVRyRTZFWWpUaXNqNWJl?=
 =?utf-8?B?VUFzQ3lBN2hMY3ZLWTJTUXFTZEN3ZXdHZzg2MlBmUEFoOUVicjcrYlBUOHYv?=
 =?utf-8?B?U3BIcC9QdjY1ZUQrWnR3dlVSbXBJbW4zT0FZVERTMC91ejdndWRZMDAwc21E?=
 =?utf-8?B?V0pWVnBmZElLUnVtYmRTalZkckVSQko2OTJMK2hxbFhzYkVTNTkwZTk4Zkp6?=
 =?utf-8?B?UFBLd2UvOHVhQUloR2Y0TWhPVjMraElQMTFBcS90Smp6NHlmM2dvKzN3VkhS?=
 =?utf-8?B?TlMyVUh4bVNtKzR4c3ZJckFMWGRmbm0rRk5vcEFoYkhsaG82MW9VNzFnN3ph?=
 =?utf-8?B?c1c0Y3RYYWJvNXFZOURSUlJJSFhvdk83ZHkwWS9QeHo0eXFlWko2NnZ3bkxh?=
 =?utf-8?B?QitXc1lDeDZ4NWtsMlRzem5BZVBKUTdVeFU0cCswbkN5M2VnUEp5Z3Rhem9j?=
 =?utf-8?B?YS9pUnk0Mmo3TEUvcS8yQ0JJOXBmRVROZWErOHFOM2VpMHpOS2F3UkJxNkQx?=
 =?utf-8?B?T0RRQUV6NTZ6ZDI5SmxITEZyaUZWVmIrMlE1TTdieG9NWEpydXVSK1FiWi90?=
 =?utf-8?B?TjZrQUJSWi85V256UFMyd05FMURlcHUzU3BwaU5BdE9nZ3h0bnpLQXNQOHhH?=
 =?utf-8?Q?JCCT0Ugq11s3FX7LjxpK2VsJB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0235ff-5611-44a1-dc57-08dbf298d2bf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 18:10:39.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFXzl7y1y5KdsuBdg21j1S8V/JjZ5r9AJKJcmUVf5Awe+FUmTpBDqJcvGDzYcPWr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/29/23 11:10 AM, Mathieu Poirier wrote:
> On Mon, Nov 27, 2023 at 10:33:05AM -0600, Tanmay Shah wrote:
> > 
> > On 11/23/23 12:11 PM, Mathieu Poirier wrote:
> > > On Wed, Nov 22, 2023 at 03:00:36PM -0600, Tanmay Shah wrote:
> > > > Hi Mathieu,
> > > > 
> > > > Please find my comments below.
> > > > 
> > > > On 11/21/23 4:59 PM, Mathieu Poirier wrote:
> > > > > Hi,
> > > > >
> > > > > On Fri, Nov 17, 2023 at 09:42:37AM -0800, Tanmay Shah wrote:
> > > > > > Use TCM pm domains extracted from device-tree
> > > > > > to power on/off TCM using general pm domain framework.
> > > > > > 
> > > > > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > > > > ---
> > > > > > 
> > > > > > Changes in v7:
> > > > > >   - %s/pm_dev1/pm_dev_core0/r
> > > > > >   - %s/pm_dev_link1/pm_dev_core0_link/r
> > > > > >   - %s/pm_dev2/pm_dev_core1/r
> > > > > >   - %s/pm_dev_link2/pm_dev_core1_link/r
> > > > > >   - remove pm_domain_id check to move next patch
> > > > > >   - add comment about how 1st entry in pm domain list is used
> > > > > >   - fix loop when jump to fail_add_pm_domains loop
> > > > > > 
> > > > > >  drivers/remoteproc/xlnx_r5_remoteproc.c | 215 +++++++++++++++++++++++-
> > > > > >  1 file changed, 212 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > index 4395edea9a64..22bccc5075a0 100644
> > > > > > --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> > > > > > @@ -16,6 +16,7 @@
> > > > > >  #include <linux/of_reserved_mem.h>
> > > > > >  #include <linux/platform_device.h>
> > > > > >  #include <linux/remoteproc.h>
> > > > > > +#include <linux/pm_domain.h>
> > > > > >  
> > > > > >  #include "remoteproc_internal.h"
> > > > > >  
> > > > > > @@ -102,6 +103,12 @@ static const struct mem_bank_data zynqmp_tcm_banks_lockstep[] = {
> > > > > >   * @rproc: rproc handle
> > > > > >   * @pm_domain_id: RPU CPU power domain id
> > > > > >   * @ipi: pointer to mailbox information
> > > > > > + * @num_pm_dev: number of tcm pm domain devices for this core
> > > > > > + * @pm_dev_core0: pm domain virtual devices for power domain framework
> > > > > > + * @pm_dev_core0_link: pm domain device links after registration
> > > > > > + * @pm_dev_core1: used only in lockstep mode. second core's pm domain virtual devices
> > > > > > + * @pm_dev_core1_link: used only in lockstep mode. second core's pm device links after
> > > > > > + * registration
> > > > > >   */
> > > > > >  struct zynqmp_r5_core {
> > > > > >  	struct device *dev;
> > > > > > @@ -111,6 +118,11 @@ struct zynqmp_r5_core {
> > > > > >  	struct rproc *rproc;
> > > > > >  	u32 pm_domain_id;
> > > > > >  	struct mbox_info *ipi;
> > > > > > +	int num_pm_dev;
> > > > > > +	struct device **pm_dev_core0;
> > > > > > +	struct device_link **pm_dev_core0_link;
> > > > > > +	struct device **pm_dev_core1;
> > > > > > +	struct device_link **pm_dev_core1_link;
> > > > > >  };
> > > > > >  
> > > > > >  /**
> > > > > > @@ -651,7 +663,8 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> > > > > >  					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > > > >  					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > > > >  		if (ret < 0) {
> > > > > > -			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> > > > > > +			dev_err(dev, "failed to turn on TCM 0x%x",
> > > > > > +				pm_domain_id);
> > > > >
> > > > > Spurious change, you should have caught that.
> > > > 
> > > > Ack, need to observe changes more closely before sending them.
> > > > 
> > > > >
> > > > > >  			goto release_tcm_lockstep;
> > > > > >  		}
> > > > > >  
> > > > > > @@ -758,6 +771,189 @@ static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
> > > > > >  	return ret;
> > > > > >  }
> > > > > >  
> > > > > > +static void zynqmp_r5_remove_pm_domains(struct rproc *rproc)
> > > > > > +{
> > > > > > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > > > +	struct device *dev = r5_core->dev;
> > > > > > +	struct zynqmp_r5_cluster *cluster;
> > > > > > +	int i;
> > > > > > +
> > > > > > +	cluster = platform_get_drvdata(to_platform_device(dev->parent));
> > > > > > +
> > > > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > +		device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], false);
> > > > > > +	}
> > > > > > +
> > > > > > +	kfree(r5_core->pm_dev_core0);
> > > > > > +	r5_core->pm_dev_core0 = NULL;
> > > > > > +	kfree(r5_core->pm_dev_core0_link);
> > > > > > +	r5_core->pm_dev_core0_link = NULL;
> > > > > > +
> > > > > > +	if (cluster->mode == SPLIT_MODE) {
> > > > > > +		r5_core->num_pm_dev = 0;
> > > > > > +		return;
> > > > > > +	}
> > > > > > +
> > > > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > +		device_link_del(r5_core->pm_dev_core1_link[i]);
> > > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core1[i], false);
> > > > > > +	}
> > > > > > +
> > > > > > +	kfree(r5_core->pm_dev_core1);
> > > > > > +	r5_core->pm_dev_core1 = NULL;
> > > > > > +	kfree(r5_core->pm_dev_core1_link);
> > > > > > +	r5_core->pm_dev_core1_link = NULL;
> > > > > > +	r5_core->num_pm_dev = 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int zynqmp_r5_add_pm_domains(struct rproc *rproc)
> > > > > > +{
> > > > > > +	struct zynqmp_r5_core *r5_core = rproc->priv;
> > > > > > +	struct device *dev = r5_core->dev, *dev2;
> > > > > > +	struct zynqmp_r5_cluster *cluster;
> > > > > > +	struct platform_device *pdev;
> > > > > > +	struct device_node *np;
> > > > > > +	int i, j, num_pm_dev, ret;
> > > > > > +
> > > > > > +	cluster = dev_get_drvdata(dev->parent);
> > > > > > +
> > > > > > +	/* get number of power-domains */
> > > > > > +	num_pm_dev = of_count_phandle_with_args(r5_core->np, "power-domains",
> > > > > > +						"#power-domain-cells");
> > > > > > +
> > > > > > +	if (num_pm_dev <= 0)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	r5_core->pm_dev_core0 = kcalloc(num_pm_dev,
> > > > > > +					sizeof(struct device *),
> > > > > > +					GFP_KERNEL);
> > > > > > +	if (!r5_core->pm_dev_core0)
> > > > > > +		ret = -ENOMEM;
> > > > > > +
> > > > > > +	r5_core->pm_dev_core0_link = kcalloc(num_pm_dev,
> > > > > > +					     sizeof(struct device_link *),
> > > > > > +					     GFP_KERNEL);
> > > > > > +	if (!r5_core->pm_dev_core0_link) {
> > > > > > +		kfree(r5_core->pm_dev_core0);
> > > > > > +		r5_core->pm_dev_core0 = NULL;
> > > > > > +		return -ENOMEM;
> > > > > > +	}
> > > > > > +
> > > > > > +	r5_core->num_pm_dev = num_pm_dev;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * start from 2nd entry in power-domains property list as
> > > > > > +	 * for zynqmp we only add TCM power domains and not core's power domain.
> > > > > > +	 * 1st entry is used to configure r5 operation mode.
> > > > >
> > > > > You are still not saying _where_ ->pm_dev_core0[0] gets added.
> > > > 
> > > > So, pm_dev_core0[0] isn't really need to be added for zynqmp platform, as firmware starts it with call,
> > > > 
> > > > zynqmp_pm_request_wake during rproc_start callback. I will document this in next
> > > >
> > >
> > > That is exactly what I am looking for.  That way people don't have to go through
> > > the entire driver trying to figure out what is happening with pm_dev_core[0].
> > >
> > > I'm also not sure about the power-up order.  Logically the TCMs should be
> > > powered up before the R5 in order to put code in them.  The R5s are powered in
> > > zynqmp_r5_rproc_start() but I am unclear as to where in the boot sequence the
> > > TCMs are powered - can you expand on that?
> > 
> > 
> > Sure. Following is call sequece
> > 
> > zynqmp_r5_rproc_prepare
> > 
> > zynqmp_r5_add_pm_domains -> Here TCM is powered on when device_link_add is called via zynqmp-pm-domains.c driver.
> > 
> > . . .
> > 
> > zynqmp_r5_rproc_start -> load firmware and Starts RPU
> > 
> > So what you mentioned is correct, TCM is being powerd-on before we load firmware and start RPU.
> > 
> > 
> > >
> > > > revision. For new platforms pm_dev_core0[0] will be added in future.
> > >
> > > Now I'm really confused - what do you mean by "pm_dev_core0[0] will be added in
> > > future"?
> > 
> > 
> > ZynqMP platform has platform management firmware running on microblaze.
> > 
> > This firmware design does not expect R5 pm domains to be requested explicitly.
> > 
> > This means, during zynqmp_r5_rproc_start when "zynqmp_pm_request_wake" is called,
> > 
> > firmware powers on R5. So, pm_dev_core[0] is not really used for ZynqMP.
> > 
> > However, this design was changed for new platforms i.e. "versal" and onwards.
> > 
> > Firmware of new platform expects pm domains to be requested explicitly for R5 cores before
> > 
> > waking them up.
> > 
> > That means, pm_dev_core[0] for R5 cores on new platform (Versal) needs to be used same as TCM.
> > 
> > Then, we should wake it up on r5_core.
> > 
> > To summarize:
> > 
> > For zynqmp only following call needed to start R5:
> > 
> > zynqmp_pm_request_wake
> > 
> > For "versal" and onwards we need two calls to start R5:
> > 
> > "device_link_add" and zynqmp_pm_request_wake
> > 
> > So, in future pm_core_dev[0] will be used.
> >
>
> Thanks for the clarification on both front.  The problem here is that we are
> keeping R5 power domain information in two different places, i.e
> zynqmp_r5_core::pm_domain_id and zynqmp_r5_core::pm_dev_core0[0].  
>
> Please see if you can retreive the power domain ID from
> zynqmp_r5_core::pm_dev_core0[0].  That way you can get the power domain ID when
> calling zynqmp_pm_request_wake() and zynqmp_pm_force_pwrdwn() and get rid of
> zynqmp_r5_core::pm_domain_id.

Hi Mathieu,

I looked into this. Probably I can't retrieve pm_domain_id from pm_dev_core0[0],

However, I can retrieve it from device-tree when calling zynqmp_pm_request_wake

and zynqmp_pm_force_pwrdwn.

zynqmp_r5_core::pm_domain_id is caching that value during probe, and use it during
rest of the driver lifecycle.

I am okay either way, (keeping it as it is, or get it from device-tree). Let me know your

preference.

Thanks,

Tanmay

> > 
> > > > 
> > > > I hope this meets expectations.
> > > > 
> > > > 
> > > > >
> > > > > > +	 */
> > > > > > +	for (i = 1; i < r5_core->num_pm_dev; i++) {
> > > > > > +		r5_core->pm_dev_core0[i] = dev_pm_domain_attach_by_id(dev, i);
> > > > > > +		if (IS_ERR_OR_NULL(r5_core->pm_dev_core0[i])) {
> > > > >
> > > > > Here IS_ERR_OR_NULL() is used while two if conditions for NULL and an error
> > > > > code are used in the loop for the lockstep mode.  Please pick one heuristic and
> > > > > stick with it.  I have no preference on which one.
> > > > 
> > > > Ok, I think IS_ERR_OR_NULL is more cleaner, I will address it in next revision.
> > > > 
> > > > 
> > > > >
> > > > > > +			dev_dbg(dev, "failed to attach pm domain %d, ret=%ld\n", i,
> > > > > > +				PTR_ERR(r5_core->pm_dev_core0[i]));
> > > > > > +			ret = -EINVAL;
> > > > > > +			goto fail_add_pm_domains;
> > > > > > +		}
> > > > > > +		r5_core->pm_dev_core0_link[i] = device_link_add(dev,
> > > > > > +								r5_core->pm_dev_core0[i],
> > > > > > +								DL_FLAG_STATELESS |
> > > > > > +								DL_FLAG_RPM_ACTIVE |
> > > > > > +								DL_FLAG_PM_RUNTIME);
> > > > > > +		if (!r5_core->pm_dev_core0_link[i]) {
> > > > > > +			dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > > > +			r5_core->pm_dev_core0[i] = NULL;
> > > > > > +			ret = -EINVAL;
> > > > > > +			goto fail_add_pm_domains;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +	if (cluster->mode == SPLIT_MODE)
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	r5_core->pm_dev_core1 = kcalloc(num_pm_dev,
> > > > > > +					sizeof(struct device *),
> > > > > > +					GFP_KERNEL);
> > > > > > +	if (!r5_core->pm_dev_core1) {
> > > > > > +		ret = -ENOMEM;
> > > > > > +		goto fail_add_pm_domains;
> > > > > > +	}
> > > > > > +
> > > > > > +	r5_core->pm_dev_core1_link = kcalloc(num_pm_dev,
> > > > > > +					     sizeof(struct device_link *),
> > > > > > +					     GFP_KERNEL);
> > > > > > +	if (!r5_core->pm_dev_core1_link) {
> > > > > > +		kfree(r5_core->pm_dev_core1);
> > > > > > +		r5_core->pm_dev_core1 = NULL;
> > > > > > +		ret = -ENOMEM;
> > > > > > +		goto fail_add_pm_domains;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* get second core's device to detach its power-domains */
> > > > > > +	np = of_get_next_child(cluster->dev->of_node, of_node_get(dev->of_node));
> > > > > > +
> > > > > > +	pdev = of_find_device_by_node(np);
> > > > > > +	if (!pdev) {
> > > > > > +		dev_err(cluster->dev, "core1 platform device not available\n");
> > > > > > +		kfree(r5_core->pm_dev_core1);
> > > > > > +		kfree(r5_core->pm_dev_core1_link);
> > > > > > +		r5_core->pm_dev_core1 = NULL;
> > > > > > +		r5_core->pm_dev_core1_link = NULL;
> > > > > > +		ret = -EINVAL;
> > > > > > +		goto fail_add_pm_domains;
> > > > > > +	}
> > > > > > +
> > > > > > +	dev2 = &pdev->dev;
> > > > > > +
> > > > > > +	/* for zynqmp we only add TCM power domains and not core's power domain */
> > > > > > +	for (j = 1; j < r5_core->num_pm_dev; j++) {
> > > > > > +		r5_core->pm_dev_core1[j] = dev_pm_domain_attach_by_id(dev2, j);
> > > > > > +		if (!r5_core->pm_dev_core1[j]) {
> > > > > > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > > > +			ret = -EINVAL;
> > > > > > +			goto fail_add_pm_domains_lockstep;
> > > > > > +		} else if (IS_ERR(r5_core->pm_dev_core1[j])) {
> > > > > > +			dev_dbg(dev, "can't attach to pm domain %d\n", j);
> > > > > > +			ret = PTR_ERR(r5_core->pm_dev_core1[j]);
> > > > > > +			goto fail_add_pm_domains_lockstep;
> > > > > > +		}
> > > > > > +
> > > > > > +		r5_core->pm_dev_core1_link[j] = device_link_add(dev,
> > > > > > +								r5_core->pm_dev_core1[j],
> > > > > > +								DL_FLAG_STATELESS |
> > > > > > +								DL_FLAG_RPM_ACTIVE |
> > > > > > +								DL_FLAG_PM_RUNTIME);
> > > > > > +		if (!r5_core->pm_dev_core1_link[j]) {
> > > > > > +			dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > > > +			r5_core->pm_dev_core1[j] = NULL;
> > > > > > +			ret = -ENODEV;
> > > > > > +			goto fail_add_pm_domains_lockstep;
> > > > > > +		}
> > > > > > +	}
> > > > > > +
> > > > > > +fail_add_pm_domains_lockstep:
> > > > > > +	while (--j >= 0) {
> > > > > > +		device_link_del(r5_core->pm_dev_core1_link[j]);
> > > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core1[j], true);
> > > > > > +	}
> > > > > > +	kfree(r5_core->pm_dev_core1);
> > > > > > +	r5_core->pm_dev_core1 = NULL;
> > > > > > +	kfree(r5_core->pm_dev_core1_link);
> > > > > > +	r5_core->pm_dev_core1_link = NULL;
> > > > > > +
> > > > > > +fail_add_pm_domains:
> > > > > > +	while (--i >= 0) {
> > > > > > +		device_link_del(r5_core->pm_dev_core0_link[i]);
> > > > > > +		dev_pm_domain_detach(r5_core->pm_dev_core0[i], true);
> > > > > > +	}
> > > > > > +	kfree(r5_core->pm_dev_core0);
> > > > > > +	r5_core->pm_dev_core0 = NULL;
> > > > > > +	kfree(r5_core->pm_dev_core0_link);
> > > > > > +	r5_core->pm_dev_core0_link = NULL;
> > > > > > +
> > > > >
> > > > > The error path is much cleaner and readable now.
> > > > >
> > > > > I will continue tomorrow.
> > > > >
> > > > > Mathieu
> > > > >
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > >  /**
> > > > > >   * zynqmp_r5_rproc_prepare()
> > > > > >   * adds carveouts for TCM bank and reserved memory regions
> > > > > > @@ -770,19 +966,30 @@ static int zynqmp_r5_rproc_prepare(struct rproc *rproc)
> > > > > >  {
> > > > > >  	int ret;
> > > > > >  
> > > > > > +	ret = zynqmp_r5_add_pm_domains(rproc);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(&rproc->dev, "failed to add pm domains\n");
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > >  	ret = add_tcm_banks(rproc);
> > > > > >  	if (ret) {
> > > > > >  		dev_err(&rproc->dev, "failed to get TCM banks, err %d\n", ret);
> > > > > > -		return ret;
> > > > > > +		goto fail_prepare;
> > > > > >  	}
> > > > > >  
> > > > > >  	ret = add_mem_regions_carveout(rproc);
> > > > > >  	if (ret) {
> > > > > >  		dev_err(&rproc->dev, "failed to get reserve mem regions %d\n", ret);
> > > > > > -		return ret;
> > > > > > +		goto fail_prepare;
> > > > > >  	}
> > > > > >  
> > > > > >  	return 0;
> > > > > > +
> > > > > > +fail_prepare:
> > > > > > +	zynqmp_r5_remove_pm_domains(rproc);
> > > > > > +
> > > > > > +	return ret;
> > > > > >  }
> > > > > >  
> > > > > >  /**
> > > > > > @@ -801,6 +1008,8 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
> > > > > >  
> > > > > >  	r5_core = rproc->priv;
> > > > > >  
> > > > > > +	zynqmp_r5_remove_pm_domains(rproc);
> > > > > > +
> > > > > >  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> > > > > >  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> > > > > >  		if (zynqmp_pm_release_node(pm_domain_id))
> > > > > > -- 
> > > > > > 2.25.1
> > > > > > 
