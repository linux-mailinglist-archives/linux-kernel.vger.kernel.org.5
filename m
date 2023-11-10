Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22757E83EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346411AbjKJUhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbjKJUgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:36:45 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEF738EBE;
        Fri, 10 Nov 2023 06:33:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+a6Wl9c+E/jFLIGtq74Zaz6gYNACvh9MIRRmX93SZFdI5iHaFmSd3M57QEUFkuUdcsJNjvyqOAYqKtEwaY57lung11PjBbQP6PSTkpUv1KnyPxE/DcqJJ2P+C+PJY0euYn86voInmXpzsMY9VgAgOMsR0wQcgzrA/4ZVmUOhbIfe7/yt17k5xABFTHC5+FyD2J4p5Mh6Kr9UJ8f9D9lboAB594K8Kj0hukAsN/cd05JnRZQuPPFtLqRuGfepshU/cuwK8/Q3MBIUq3UrMrjQCZuZxn5i/sp91Yifo7SjJi+6k3eFfQeF2+M3FxiyF0pYdLxdYmOY8KwgzF7p2bA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5mm/cfLURsvfIFkDBAOFR9a83Dvniqyx6o7xS2f+t8=;
 b=ezwL/AQeLHQRJN3Tu3aRF4oC4PeHyxGfg14Ctg3x7DRGbYR8y58rEHrSO6JZwTyLCoSEMT2IvA/zhJOaRpIEURwZQbNfskIAuZrA6mKGE9PLoctESpSHoQCryL9yI0YWL7KU9qbELDSUc1wGJzEUmuZW7Acn21rNU03KVmZOqVfE4JjR/zcnkV8XfMe31cHpUptNMIajAWNACzfRnFWSEMLue4cHIEDwdXsvsp77k0X6lUGTotBzCskMjhVLYApciJ7pNbOVlWsuBWwG1Si5eKSBIvqA3mkF7x3UmzrqKkTA7+Dq5SHWZc22G0DyDbc5eIKeZX2lIw0n7wjqA6k/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5mm/cfLURsvfIFkDBAOFR9a83Dvniqyx6o7xS2f+t8=;
 b=ZWULn38UOT/7SHGuJ7mO86CnoaQeLfHvuX8IgZAmrYNCVTWx5N+SwUqLJ2edpvRFfctqw0A3YRfSPSUZsYxofSI1nG8MMDnGhR90uBB1qhysuHjEjweasgI/BZt/+eol0iRDgKlrtGzDJErcDHNGA7FAf9XFO9V4DnYU6aSAZ+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DU5PR08MB10677.eurprd08.prod.outlook.com (2603:10a6:10:529::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 14:33:37 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::79a1:5ad6:b221:ad%4]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 14:33:37 +0000
Message-ID: <4f9bc04b-81af-49ee-9818-d4cd281504e7@wolfvision.net>
Date:   Fri, 10 Nov 2023 15:33:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Content-Language: en-US
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
 <bcc0b84f4a6a8cf4c007cfe25025060b22627408.1699460637.git.mehdi.djait@bootlin.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <bcc0b84f4a6a8cf4c007cfe25025060b22627408.1699460637.git.mehdi.djait@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0048.eurprd09.prod.outlook.com
 (2603:10a6:802:1::37) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DU5PR08MB10677:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb6612e-5357-4261-0d0c-08dbe1fa06a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/ZG1zEKa/EvrnaTVvKVjzx8LUCQED/iWVIeyRc/AdsHQ+dEYBjG7BEV+jh13xBITsFAMBWRdcaN5W4UQ4ysNW+Rx9b/iQMfUCSn+Ju7/jmivLgnxRvOHE+iZBs/NEK5wKeK1lmCJRQ24NQptSecGcTrk7nBjB0v3YfTOnekQ62/PiSRSXxQv/nP/6twK6+nu9WRlzisuME7pGq6Srfn4BRv+DDogbV8Bo8cSbGb8l5PfYIv3iYTd7MP/MVw2rCbH7fmiegJGwNFuFRaiLvs6YH8jixCAZLTWb9P2PJvixwelbednDtIBZ7buQ0fMHgxOkArS/bieUWMdNHEixrtxFCxChGxDMXiO5tyTouvHGivz7NdkunoMBZY3h45lhS1dapqc73zx8QTxPs2hbACM/zRryL0WTlBy+HT4gXb90CHM3F3xpxJuWkeCsMHcXNHjHtA/fE7qC7vRSt34axkExvYzxSt7MDCBae06wOOnZZzIkRxOvHmD0RlGOG05MSCZLI0taQW6wwTiVsO5IUhoUXX1JubbRFvNlT9JBGxEyXD6RPwgiU3lYwVilkG+B1Mp5teiMHRwg65SUhtonAjiCvDppktQmYlEmHNGNAWEsS+BQ5tOz41Eb2r8UJ1QL1dv+xIYBeHUYO16hJo6HBWRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39850400004)(366004)(396003)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(26005)(2616005)(83380400001)(66946007)(6666004)(6506007)(36916002)(478600001)(66556008)(53546011)(6512007)(31696002)(2906002)(8676002)(4326008)(36756003)(8936002)(41300700001)(5660300002)(38100700002)(7416002)(86362001)(44832011)(66476007)(316002)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTh1VW1sc3FuRy83VlNETkNmT1RNZDBJQU93QnYzVVcvY3M3K1duZ0dIbklo?=
 =?utf-8?B?TERleXNleUdxQnd5Y0Q1azV0MHRQUzFuaFhjWDhQeXpnQUREeS9udHVwQ0hv?=
 =?utf-8?B?ajRLOEprMC83MlF0bDNWbGt0OWRuRE5Fcmx5YlZ5TzdiU2dFdWFlanBNV29y?=
 =?utf-8?B?N0d2Rldhb1BwR3ArRTdVOEMvakZONno4L0dRUmhHZUFESWh4dWtUTlRyU2pq?=
 =?utf-8?B?bnJJZmI1R0thTEVUSnFLcWdnUGdUQ0MwbHZGcksyUGkxUzRLZXdHNmtTZmZM?=
 =?utf-8?B?dXFXMXRrNDdXQ3pyNS9BY0pRWkpkK3pQL3l0RCtkRWlXQXZDbjZVSGhVUDFL?=
 =?utf-8?B?OElDVlBwZDFjTDMzR3hGVFR4ZGQ3TlhQRlRvc2t3RE9VdVhUdFVVZC9hMHFF?=
 =?utf-8?B?L3JicmFlczhZY2s5NjlNbi9yZkt3U2kzWGUxbndwZnpTTlNoQVZBYllWSmpM?=
 =?utf-8?B?ZC9HalJvSDh0SFdTNS9LT0R3SU1JTlFsQ0pOVWV3NmFjRUt4LytsN2wvRmVR?=
 =?utf-8?B?YnNxU1NWZTVoekVWUGNWNFNob0ZDS2dxOGdHeVhjU2U1YVB2bllualAxUll1?=
 =?utf-8?B?Szg2ZC9lb3BYYUdEcHVPRCtnUXRDUzhmS2Rva1lhTm1rZ1BrS1kwQzRhVHZT?=
 =?utf-8?B?QWlHT29ZOTVRMGZCUkRLYjZlN0JuemNFWTJYQzlXNFRXY0tiRGtSR04zY1hV?=
 =?utf-8?B?NHN5MnRoOVZLTkk4YUQraURzZHIzR00rbU1Zb1hENU1WQ1Vxa3d4aGszNXg2?=
 =?utf-8?B?c0NWNzRMT0JnVHJMRGovVnNLZnQvTFdqcGt4clZ3TXROK3JRU29BN2ZlUHd3?=
 =?utf-8?B?UGVpSnk4U0FOWFJ3ZDhxY2cvT0RJSWlFU0c5LytQTDQ0Mi82UUxlWkRFMzFJ?=
 =?utf-8?B?L29zWndrKzIzK1NBaDg2ZUpreFJBekRscUhMUEhkYVgzZDNUYzJ6NHY0K01m?=
 =?utf-8?B?dzFuM1IxQU9IU3ArTTdsMEt1ck9tQUdadG9JOUUwTXA4NElFMHVQdDBhcmpm?=
 =?utf-8?B?WTUwV0lLRElQUjNYcU14RFNKY2d6TXgxQnFZb2l4eUxhVVYwUjRCRGZzTnl2?=
 =?utf-8?B?NHIvN3ZTOWlHanljZHZYdTQzVXdCVTJVL0hnUVIySmIrb1J0MlQ1QzlNb1JF?=
 =?utf-8?B?WTRaUzFOa0plMzV4bFlMU1oxVHMxajlWUU9mUU5yZXdzdW9vQlhzRDMxWXJq?=
 =?utf-8?B?WHMzckVLdVJsWkNKZ2NDT09yN04zV3FiUE80U0FzRlZBSjdKUFU0NzBscURU?=
 =?utf-8?B?S3IzMFNYeHhwQ1FuUGRKSnEwc2tHSk5UbFpGTGpGVVM2VWtVd3Q5MVdLdTU5?=
 =?utf-8?B?Sk0wQ2tZbVE4VXpsdThBTldOcWFGWjdRUEthMDdBQmN0L2hIYWYzQVFzbTRk?=
 =?utf-8?B?c213UGw4b2x3UjJDWmlCS0IzQ2dJbEFlcEx4ZFJFV0N2Mk9ieG44UXdrOUky?=
 =?utf-8?B?M3BCWUlqMGRJUEJ6UXkva3ZDTU01NmFDUEVYYVlYZGNCYnVsV3o1Y0liT1Ex?=
 =?utf-8?B?ZDZNNnVLM1hXdHc1eHlYSmpPK095UFl1Qm5Ga1hsc1dENDg0UW1iWkNLWmhX?=
 =?utf-8?B?b3JkTkVEUG56YVJ2anNhWTZEczMrdzl6L0hoRFpPYkpWQjU1V2pHclo4QlBq?=
 =?utf-8?B?WVE1MGJJSVU3SGFyazJTeTEydjNFTDJUNlN3TyswRTJYaktUbzJ6b2hNMkZr?=
 =?utf-8?B?Y3RHSzFLclpoRUMvM0ZSSFowK3NQeFRRMlR2UXFJNkZ2bWdYSWthWnkzNGFT?=
 =?utf-8?B?V1dCbGdicXlLbjdNeklDdzVtRk9KQ0NmVmVuOHdTUjgwczNFNmdGMi93RHcy?=
 =?utf-8?B?LzlTNzBWQnBrNjBuYzVmR3pTN2IxUHZMZVlmczFGbXJMT2VHZjVDamJ4cDZv?=
 =?utf-8?B?dGQ0MzE2aHlicmh4MlpFQkd1OUJSdEErRitGN0x5OGRlWjJpcktReVNhQkNE?=
 =?utf-8?B?cDJaVTUyeHUvMm9BVDFvQVJKM1ROM3hFMjNhaHlpN3FtMjhRNlhyN1dld3Bh?=
 =?utf-8?B?YW95NVZMMDNoL2phc2daRmN4M080YURWYkRyRXFadUp2RndHTEhNTGttOHRk?=
 =?utf-8?B?MFREZEZOY2lnRlp4WUN4b0gzMitwbk5XZlFDL3pSZDFNSm0walNHajllZ2I4?=
 =?utf-8?B?YWdHTnk3V2lrOUFiV1hjcHZTUVF1UWd1MUI1bnprYTRJSVdaZXVRNlN4bkha?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb6612e-5357-4261-0d0c-08dbe1fa06a1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:33:37.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXPprwWSmNOEixHr23wPCEire6VXPn8ZHyaet6ZsQn2tNpiuOhKDtZUrHdQ0j7jhpfZVAldzyqRad7NUsi/tBsOMUmwlR8H4R2EEu9uo07E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10677
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

Sorry, forgot one thing:

On 11/8/23 17:38, Mehdi Djait wrote:
> [...]
> diff --git a/drivers/media/platform/rockchip/cif/dev.c b/drivers/media/platform/rockchip/cif/dev.c
> new file mode 100644
> index 000000000000..f7d061a13577
> --- /dev/null
> +++ b/drivers/media/platform/rockchip/cif/dev.c
> @@ -0,0 +1,289 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip CIF Camera Interface Driver
> + *
> + * Copyright (C) 2018 Rockchip Electronics Co., Ltd.
> + * Copyright (C) 2020 Maxime Chevallier <maxime.chevallier@bootlin.com>
> + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> + */
> +
> +#include "linux/platform_device.h"
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/reset.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <media/v4l2-fwnode.h>
> +
> +#include "dev.h"
> +#include "regs.h"
> +
> +static int subdev_notifier_complete(struct v4l2_async_notifier *notifier)
> +{
> +	struct cif_device *cif_dev;
> +	struct v4l2_subdev *sd;
> +	int ret;
> +
> +	cif_dev = container_of(notifier, struct cif_device, notifier);
> +	sd = cif_dev->remote.sd;
> +
> +	mutex_lock(&cif_dev->media_dev.graph_mutex);
> +
> +	ret = v4l2_device_register_subdev_nodes(&cif_dev->v4l2_dev);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = media_create_pad_link(&sd->entity, 0,
> +				    &cif_dev->stream.vdev.entity, 0,
> +				    MEDIA_LNK_FL_ENABLED);
> +	if (ret)
> +		dev_err(cif_dev->dev, "failed to create link");
> +
> +unlock:
> +	mutex_unlock(&cif_dev->media_dev.graph_mutex);
> +	return ret;
> +}
> +
> +static int subdev_notifier_bound(struct v4l2_async_notifier *notifier,
> +				 struct v4l2_subdev *subdev,
> +				 struct v4l2_async_connection *asd)
> +{
> +	struct cif_device *cif_dev = container_of(notifier,
> +						  struct cif_device, notifier);
> +	int pad;
> +
> +	cif_dev->remote.sd = subdev;
> +	pad = media_entity_get_fwnode_pad(&subdev->entity, subdev->fwnode,
> +					  MEDIA_PAD_FL_SOURCE);
> +	if (pad < 0)
> +		return pad;
> +
> +	cif_dev->remote.pad = pad;
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_async_notifier_operations subdev_notifier_ops = {
> +	.bound = subdev_notifier_bound,
> +	.complete = subdev_notifier_complete,
> +};
> +
> +static int cif_subdev_notifier(struct cif_device *cif_dev)
> +{
> +	struct v4l2_async_notifier *ntf = &cif_dev->notifier;
> +	struct device *dev = cif_dev->dev;
> +	struct v4l2_async_connection *asd;
> +	struct v4l2_fwnode_endpoint vep = {
> +		.bus_type = V4L2_MBUS_PARALLEL,

This is surprising. I had to set this to V4L2_MBUS_UNKNOWN, otherwise
v4l2_fwnode_endpoint_parse would yield -ENXIO, which indicates a bus
type mismatch. Does this really work for your (BT.656, right?) setup?

I think we should get the bus type from the device tree, right?

Thanks and best regards,
Michael

> [...]
