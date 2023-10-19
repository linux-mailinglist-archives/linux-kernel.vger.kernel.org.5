Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10647CFD3B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346257AbjJSOtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346184AbjJSOt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:49:26 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D3F138;
        Thu, 19 Oct 2023 07:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6YlrP3K79d2KwmchZHeZs5kGHcqn1jXQDdZUbnb/j7LQx0rPN5wO9xjvWuHfsmU0maOqaOlmzK2fYt+4lfluoabAfr0rZacCchH8ypk3aXPw5hqcm1Jeh5D5+Y/uDjhrRpN1wii2vFhbn3KXUTtyWh4jOJecuZZbvHYVkPKlPrTNKgXoWRzuEupOseBmT6oRIG00U3PR/y7eosBvzdqnyzLMGu/1kPDSCNIwz1vZxP9HcLlHx9zMpWR4e01Pu/dILnM26Y5xFMl1wsx4ReRlFRWk2vXeLA1ZNWTjfj8Wo/mi9WkLCS9Agjn0kZ3zF5KXbqr6u6f2rBll+9Lg+0SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYPBvOQb0bjeMdTm7cP9ZNXQ8DLFJMByprb7HzQbWTE=;
 b=LVdbF1KthnFkk4L9CSKuW9bgspZWhdVIfQTaNo+Oqc0B/LcT6+iCnuhXj/4A0WQ2VcoreP+Nwo1JdR7E3HbemGytg2rXrZhxliothWMxD3C6D+MA0+lzBRdn/+rupEZ8SIeUSXpuny09SoNo4rL75g3twbmAO9nM7DZL+7y2L/dKTYf1Bkv/uO0ANyhoQNqgliDg2waM5tYwTfJOtzfsJJkcdE3rfYmE2g9f7KAc7oP4s5mFSp09tO1NSXRFIUGoqcUFo+v9jHxt+kZkYEXJN3xUT6tELucGkgxXyPpEkKuvyIWdL/K3u/eusx1fD7vuqq7gG8/09GA5TR67eM1+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYPBvOQb0bjeMdTm7cP9ZNXQ8DLFJMByprb7HzQbWTE=;
 b=f/xA8zihBrD7t64v3B1hnBd/yRn5og5nB3Jo1AkFyzP487jtbCA3QhT9vt+/tMWjVBCBf4+P7z/Z78E4ETTygUfravBLoWjBKFz5qinBFo6tXW2h+S+4I0tat+xIv6frONRvdeyE5+NLmASXB8S/q4qOWJA21Fusj+qgGRaoK0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8703.eurprd04.prod.outlook.com (2603:10a6:102:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 14:49:15 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 14:49:15 +0000
Date:   Thu, 19 Oct 2023 10:49:08 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TTY LAYER AND SERIAL DRIVERS" 
        <linux-serial@vger.kernel.org>, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH 1/1] tty: i3c: add tty over i3c master support
Message-ID: <ZTFB5FZiPBaguhlO@lizhi-Precision-Tower-5810>
References: <20231018211111.3437929-1-Frank.Li@nxp.com>
 <caa8d113-3182-4f5f-affa-e5f8037498db@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa8d113-3182-4f5f-affa-e5f8037498db@kernel.org>
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be938fc-814f-4ab9-a7f2-08dbd0b29089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rl0JbeyV7Z0VN1dl0YayAMR+kcWRUZxN9Yy+npXR0Qn6VeNFVg7b7ZSEqZ6u/78wyofnkHktCEg/L9K+3g41m13eZlb7wTvhqa+E9KaiC0AZvbMnc3KcRyQPan7EiMmrGM8icP4PezYeeymsraNkc3sJvbhsKomEPWW3GB6sym5wckdyuOKlCrbeb6BAd9fRZYybun+gryA0246PtH2zwOUV3Q2eWj4tEpAyg1XHKCaCb2uXwf0ocKc6Gaho0aPAWPVJNbT2ogDFZeoPjeNTPAjUNG2O/2MFEcx2oBKidm+0PsfzdMh4i9bELpM0q1c+OxJ3ySCdLgOFHmQZyPPYLwqxYBB9t1tWwpuvC3HX7DvuAxJPhGERpv7IWu1oUaarS708wvqqQ6MFfqhFq/pqo5EkilrSpgfgooGGiddrOGMWspo/ru5paqxyIyRQtXSPYEk2wkp02wV+v64WzYvQ3yBa37VQlcxlGICoNINRbYrnyjCELpZnj2I3Rgx3nKAIVItrh9MHdnatVpcktYTvlO5UKTtUtcPFce5sSqNuf8sNLac2z5gRIUrig1JDIUlUK43hqHlBU8aaw3YWwc8QK/j3FqhnUDbSbjWXPi2ZybZ2pIOPu66lPaD/GlkS2eXUFj23eLvhsCRh294XcfzagbZ9XY/XC54QHKCDWVyzo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(5660300002)(4326008)(30864003)(6916009)(54906003)(66476007)(66946007)(8936002)(66556008)(966005)(316002)(6666004)(478600001)(6486002)(8676002)(41300700001)(7416002)(86362001)(38100700002)(52116002)(6506007)(83380400001)(26005)(9686003)(6512007)(38350700005)(33716001)(42413004)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DdPIviXuaobD7R95nurkvO+6BULJ4jscg8faValeE6ip24Bu6EHjfKLqROpQ?=
 =?us-ascii?Q?Or8tt7fHH95ZW7VycfXut/8oCTX/KS7v8S4DFiYzb2f6niZ0tNxxDtofq+V8?=
 =?us-ascii?Q?4Dt3Y9U+oj1qX+kA25/X81ql+RagZ0pbXa8gR9pbuUmiEIOMWAONlnBO0V6N?=
 =?us-ascii?Q?TYRxJmN/KM4OLlrTODbNvUaTeD5xtnduWm4vyd06GoViF8y55D4n+Ubvs+GX?=
 =?us-ascii?Q?qPzHx8w86BpS1RWLYy1OgneaI8CaITQb1GgfMqDGlcKR4Ji6iHwUhGY6lAMv?=
 =?us-ascii?Q?0bNnexpffBUAB2ubVnSKZ4B68Yivv5Cauvu+UVTSlJdJMCbV1YyAWHIOItvy?=
 =?us-ascii?Q?RmViAAYCVAaZ+5e+0F74bG0UKnaimgV133JlpJZieA7aQC4Vgou3PBE4jz3A?=
 =?us-ascii?Q?4K+Zh2g0m547Mo/BQ0szsNrD41IM1KyJnHE0aYPmqDDCqkh/83rvCHFta/Vn?=
 =?us-ascii?Q?ji8ClR1HdRbgF9Te42w9uu8p8zx2BVd2JDc8mhW6FTkpgMORcMspSgDQsRvn?=
 =?us-ascii?Q?Cq8LBnXYXr9ncy9hQwxN10oYNlLKGKYIQsHQvK9KEMM0/sgbV5/6qlx1ryUG?=
 =?us-ascii?Q?+mFy+TI1oql+/czYfEotxf4kZ5bvcOb6B4SQQKMU1j1VPpsmW0pZwH/HHW0A?=
 =?us-ascii?Q?BsqJF121GJvJ89Ur65fstUEkPfHOpe9CeIAirbXBuCH4JkpiZEV+a3yZIYRl?=
 =?us-ascii?Q?lh9+Ka/UcyrwITz0/FRUCXVVzYF8s8bLAOt2r1aa1GpP4cmHPHtD57nYJkq1?=
 =?us-ascii?Q?iIOhvwMPl4SidQtul0Qq+hLecToOxK/kIGKXIy8IX/AsU4Xc3xdKCAufAUwM?=
 =?us-ascii?Q?OD9N7iFxa2ueE5lIt59f81oVyvOqv4t4A0PNrKNK0n+tQcEBkhHxR2uEWQeY?=
 =?us-ascii?Q?kxKI3L4BoBlAxZCnwrVSoknXDjiB70c+I5LbRpmdaTA+21paiDVQYFfkPLVc?=
 =?us-ascii?Q?hszFeL92nJeJJpWq0HHbAIXiDrhxYIMx//PORNZRBx3dM8xddv0yVg82/l0k?=
 =?us-ascii?Q?WdOpTsS/pce14CTYtBuBcS/TjTpqSRrb6u4k95ggfuOdmxpc1gFocBXa3tnt?=
 =?us-ascii?Q?cpqdz7Ui4zrk2k9Ogbi8nrP5F+KMkxr2xakyreterz5b9AXbYjo8837UYoIO?=
 =?us-ascii?Q?pNmQMpf1Mp8ks3GycncMTL4QpH4vcckHHlt5ie4+2Qe+sgwGEzlgeU9k9By5?=
 =?us-ascii?Q?l0EsBBS0osoOqZCMz/zggC0/dM1nh2j+AlT9WNgbcqUPV7uUTvRK/viUEK8b?=
 =?us-ascii?Q?1F/5RpTcUFW7BpAZo50cs2oHduCx0enJwerPnbIT4gdv7HWl5TL+GIJv+/9H?=
 =?us-ascii?Q?NIc4uYN2dX4sugcAfzZ4BVRdfOmZ9x6DaFDkfn1v5YCVBU+eEYosPNMJprP0?=
 =?us-ascii?Q?dwAPYiuhI9Ir5JECrEutbGTiLZx7p9OeVpGkYLUud6s6ZIGKhrInFqXMeB7I?=
 =?us-ascii?Q?w4T7PmAUlguv/PeTsea/D0mGRN3+62kkfiV0t6DYtuOiOZJPzxcjdaQ/1zbj?=
 =?us-ascii?Q?RD5vAvCbXA0gKodM1W/23FmILR/6DaNiod1Dh0N8CiNyp/JxE9dwT57sEyVs?=
 =?us-ascii?Q?wKBj0Qmn5br9JEzAOhs9TdUe62/35d+lfZxmhxRT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be938fc-814f-4ab9-a7f2-08dbd0b29089
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:49:15.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e82TZtHe4Yvk6e/XPQtmTcVdHsKW03NAUjB7fhMW2vycwgdl/tHm2qocrkCVo0E9PDWF7I1dgne/U/Ppr5GAhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8703
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:12:58AM +0200, Jiri Slaby wrote:
> On 18. 10. 23, 23:11, Frank Li wrote:
> > Add new driver to allow tty over i3c master.
> 
> What is it good for? Why we should consider this for inclusion at all?

UART console at least need TX/RX two pin. If we can use I3C as linux
console, the board will save two PAD because we always use I3C to connected
into some sensor or PMIC chip. 

Some small chip package, PIN is very valuable.

> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >      This patch depend on
> >      https://lore.kernel.org/imx/20231018205929.3435110-1-Frank.Li@nxp.com/T/#t
> > 
> >   drivers/tty/Kconfig   |   8 +
> >   drivers/tty/Makefile  |   1 +
> >   drivers/tty/i3c_tty.c | 466 ++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 475 insertions(+)
> >   create mode 100644 drivers/tty/i3c_tty.c
> > 
> > diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> > index 5646dc6242cd9..6d91fe6a211a1 100644
> > --- a/drivers/tty/Kconfig
> > +++ b/drivers/tty/Kconfig
> > @@ -412,6 +412,14 @@ config RPMSG_TTY
> >   	  To compile this driver as a module, choose M here: the module will be
> >   	  called rpmsg_tty.
> > +config I3C_TTY
> > +	tristate "tty over i3c"
> 
> "TTY over I3C"
> 
> > +	depends on I3C
> > +	help
> > +	  Select this options if you'd like use tty over I3C master controller
> 
> TTY and add a period.
> 
> > --- /dev/null
> > +++ b/drivers/tty/i3c_tty.c
> > @@ -0,0 +1,466 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2023 NXP.
> > + *
> > + * Author: Frank Li <Frank.Li@nxp.com>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/i3c/device.h>
> > +#include <linux/i3c/master.h>
> > +#include <linux/slab.h>
> > +#include <linux/console.h>
> > +#include <linux/serial_core.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/tty_flip.h>
> > +
> > +static DEFINE_IDR(i3c_tty_minors);
> > +static DEFINE_MUTEX(i3c_tty_minors_lock);
> > +
> > +static struct tty_driver *i3c_tty_driver;
> > +
> > +#define I3C_TTY_MINORS		256
> > +#define I3C_TTY_TRANS_SIZE	16
> > +#define I3C_TTY_RX_STOP		BIT(0)
> > +#define I3C_TTY_RETRY		20
> > +#define I3C_TTY_YIELD_US	100
> > +
> > +struct ttyi3c_port {
> > +	struct tty_port port;
> > +	int minor;
> > +	unsigned int txfifo_size;
> > +	unsigned int rxfifo_size;
> > +	struct circ_buf xmit;
> 
> Why can't you use port.xmit_fifo?
> 
> > +	spinlock_t xlock; /* protect xmit */
> > +	void *buffer;
> > +	struct i3c_device *i3cdev;
> > +	struct work_struct txwork;
> > +	struct work_struct rxwork;
> > +	struct completion txcomplete;
> > +	struct workqueue_struct *workqueue;
> 
> Why do you need a special wq? And even, why per port?

You are right! Do you any 'common wq' perfered? 

> 
> > +	atomic_t status;
> > +};
> > +
> > +static const struct i3c_device_id i3c_ids[] = {
> > +	I3C_DEVICE(0x011B, 0x1000, NULL),
> > +	{ /* sentinel */ },
> > +};
> > +
> > +static int i3c_port_activate(struct tty_port *port, struct tty_struct *tty)
> > +{
> > +	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
> > +
> > +	atomic_set(&sport->status, 0);
> > +
> > +	return i3c_device_enable_ibi(sport->i3cdev);
> > +}
> > +
> > +static void i3c_port_shutdown(struct tty_port *port)
> > +{
> > +	struct ttyi3c_port *sport =
> > +		container_of(port, struct ttyi3c_port, port);
> > +
> > +	i3c_device_disable_ibi(sport->i3cdev);
> > +}
> > +
> > +static void i3c_port_destruct(struct tty_port *port)
> > +{
> > +	struct ttyi3c_port *sport =
> > +		container_of(port, struct ttyi3c_port, port);
> > +
> > +	mutex_lock(&i3c_tty_minors_lock);
> > +	idr_remove(&i3c_tty_minors, sport->minor);
> > +	mutex_unlock(&i3c_tty_minors_lock);
> > +}
> > +
> > +static const struct tty_port_operations i3c_port_ops = {
> > +	.shutdown = i3c_port_shutdown,
> > +	.activate = i3c_port_activate,
> > +	.destruct = i3c_port_destruct,
> > +};
> > +
> > +static struct ttyi3c_port *i3c_get_by_minor(unsigned int minor)
> > +{
> > +	struct ttyi3c_port *sport;
> > +
> > +	mutex_lock(&i3c_tty_minors_lock);
> > +	sport = idr_find(&i3c_tty_minors, minor);
> > +	mutex_unlock(&i3c_tty_minors_lock);
> > +
> > +	return sport;
> > +}
> > +
> > +static int i3c_install(struct tty_driver *driver, struct tty_struct *tty)
> > +{
> > +	struct ttyi3c_port *sport;
> > +	int ret;
> > +
> > +	sport = i3c_get_by_minor(tty->index);
> > +	if (!sport)
> > +		return -ENODEV;
> > +
> > +	ret = tty_standard_install(driver, tty);
> > +	if (ret)
> > +		return ret;
> > +
> > +	tty->driver_data = sport;
> > +
> > +	return 0;
> > +}
> 
> You don't need this at all. (Watch for XXX marks below.)
> 
> > +static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
> > +{
> > +	struct ttyi3c_port *sport = tty->driver_data;
> > +	struct circ_buf *circ = &sport->xmit;
> > +	unsigned long flags;
> > +	int c, ret = 0;
> > +
> > +	spin_lock_irqsave(&sport->xlock, flags);
> > +	while (1) {
> > +		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
> > +		if (count < c)
> > +			c = count;
> > +		if (c <= 0)
> > +			break;
> > +
> > +		memcpy(circ->buf + circ->head, buf, c);
> > +		circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
> > +		buf += c;
> > +		count -= c;
> > +		ret += c;
> > +	}
> > +	spin_unlock_irqrestore(&sport->xlock, flags);
> 
> With kfifo, all this would be one line, right?
> 
> > +
> > +	if (circ->head != circ->tail)
> > +		queue_work(sport->workqueue, &sport->txwork);
> > +
> > +	return ret;
> > +}
> > +
> > +static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
> > +{
> > +	struct ttyi3c_port *sport = tty->driver_data;
> > +	struct circ_buf *circ = &sport->xmit;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	spin_lock_irqsave(&sport->xlock, flags);
> > +
> > +	if (sport && CIRC_SPACE(circ->head, circ->tail, UART_XMIT_SIZE) != 0) {
> > +		circ->buf[circ->head] = ch;
> > +		circ->head = (circ->head + 1) & (UART_XMIT_SIZE - 1);
> > +		ret = 1;
> > +	}
> > +
> > +	spin_unlock_irqrestore(&sport->xlock, flags);
> > +
> > +	return ret;
> > +}
> > +
> > +static void i3c_flush_chars(struct tty_struct *tty)
> > +{
> > +	struct ttyi3c_port *sport = tty->driver_data;
> > +
> > +	queue_work(sport->workqueue, &sport->txwork);
> > +}
> > +
> > +static unsigned int i3c_write_room(struct tty_struct *tty)
> > +{
> > +	struct ttyi3c_port *sport = tty->driver_data;
> > +	struct circ_buf *circ = &sport->xmit;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	spin_lock_irqsave(&sport->xlock, flags);
> > +	ret = CIRC_SPACE(circ->head, circ->tail, UART_XMIT_SIZE);
> > +	spin_unlock_irqrestore(&sport->xlock, flags);
> > +
> > +	return ret;
> > +}
> > +
> > +static void i3c_throttle(struct tty_struct *tty)
> > +{
> > +	struct ttyi3c_port *sport = tty->driver_data;
> > +
> > +	atomic_or(I3C_TTY_RX_STOP, &sport->status);
> > +}
> > +
> > +static void i3c_unthrottle(struct tty_struct *tty)
> > +{
> > +	struct ttyi3c_port *sport = tty->driver_data;
> > +
> > +	atomic_andnot(I3C_TTY_RX_STOP, &sport->status);
> > +
> > +	queue_work(sport->workqueue, &sport->rxwork);
> > +}
> > +
> > +static int i3c_open(struct tty_struct *tty, struct file *filp)
> > +{
> > +	struct ttyi3c_port *sport = tty->driver_data;
> 
> XXX Here, you can simply do:
> 
> struct ttyi3c_port *sport = container_of(tty->port, struct ttyi3c_port,
> port);
> 
> tty->driver_data = sport;
> 
> 
> > +	return tty_port_open(&sport->port, tty, filp);
> > +}
> > +
> > +static void i3c_close(struct tty_struct *tty, struct file *filp)
> > +{
> > +	struct ttyi3c_port *sport = tty->driver_data;
> > +
> > +	if (!sport)
> > +		return;
> 
> How can that happen?
> 
> > +	tty_port_close(tty->port, tty, filp);
> > +}
> > +
> > +static void i3c_wait_until_sent(struct tty_struct *tty, int timeout)
> > +{
> > +	struct ttyi3c_port *sport = tty->driver_data;
> > +
> > +	wait_for_completion_timeout(&sport->txcomplete, timeout);
> > +	reinit_completion(&sport->txcomplete);
> 
> Does this work in parallel?

I am not clear! What's your concern? txcmplete should be by tx work thread.

> 
> > +}
> > +
> > +static const struct tty_operations i3c_tty_ops = {
> > +	.install = i3c_install,
> > +	.open = i3c_open,
> > +	.close = i3c_close,
> > +	.write = i3c_write,
> > +	.put_char = i3c_put_char,
> > +	.flush_chars = i3c_flush_chars,
> > +	.write_room = i3c_write_room,
> > +	.throttle = i3c_throttle,
> > +	.unthrottle = i3c_unthrottle,
> > +	.wait_until_sent = i3c_wait_until_sent,
> > +};
> > +
> > +static void i3c_controller_irq_handler(struct i3c_device *dev,
> > +				       const struct i3c_ibi_payload *payload)
> > +{
> > +	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
> > +
> > +	queue_work(sport->workqueue, &sport->rxwork);
> 
> Doesn't ibi provide threaded irqs? Oh, wait, i3c_master_handle_ibi() is
> already a work!

Yes, but I need stop rxwork when i3c_unthrottle and start rxwork at
i3c_throttle. 
I am not sure if throttle/unthrottle allow sleep. I refer other drivers,
most just wakeup or disable some simple works.

> 
> > +}
> > +
> > +static void tty_i3c_rxwork(struct work_struct *work)
> > +{
> > +	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
> > +	struct i3c_priv_xfer xfers;
> > +	int retry = I3C_TTY_RETRY;
> > +	u16 status = BIT(0);
> > +
> > +	do {
> > +		memset(&xfers, 0, sizeof(xfers));
> > +		xfers.data.in = sport->buffer;
> > +		xfers.len = I3C_TTY_TRANS_SIZE;
> > +		xfers.rnw = 1;
> > +
> > +		if (I3C_TTY_RX_STOP & atomic_read(&sport->status))
> 
> Hmm, why not much simpler (and yet atomic) {set,test,clear}_bit()?
> 
> > +			break;
> > +
> > +		i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
> > +
> > +		if (xfers.actual_len) {
> > +			tty_insert_flip_string(&sport->port, sport->buffer, xfers.actual_len);
> 
> This can fail.
> 
> > +			retry = 20;
> > +			continue;
> > +		} else {
> 
> "} else {" uneeded.
> 
> > +			status = BIT(0);
> > +			i3c_device_getstatus_format1(sport->i3cdev, &status);
> > +			/*
> > +			 * Target side need some time to fill data into fifo. Target side may not
> 
> "needs"
> 
> > +			 * have hardware update status in real time. Software update status always
> > +			 * need some delays.
> 
> "needs"
> 
> > +			 *
> > +			 * Generally, target side have cicular buffer in memory, it will be moved
> "circular" all around.
> 
> > +			 * into FIFO by CPU or DMA. 'status' just show if cicular buffer empty. But
> > +			 * there are gap, espcially CPU have not response irq to fill FIFO in time.
> 
> espcially
> 
> > +			 * So xfers.actual will be zero, wait for little time to avoid flood
> > +			 * transfer in i3c bus.
> > +			 */
> > +			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
> > +			retry--;
> > +		}
> > +
> > +	} while (retry && (status & BIT(0)));
> > +
> > +	tty_flip_buffer_push(&sport->port);
> > +}
> > +
> > +static void tty_i3c_txwork(struct work_struct *work)
> > +{
> > +	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, txwork);
> > +	struct circ_buf *circ = &sport->xmit;
> > +	int cnt = CIRC_CNT(circ->head, circ->tail, UART_XMIT_SIZE);
> > +	struct i3c_priv_xfer xfers;
> > +	int retry = I3C_TTY_RETRY;
> > +	unsigned long flags;
> > +	int actual;
> > +	int ret;
> > +
> > +	while (cnt > 0 && retry) {
> > +		xfers.rnw = 0;
> > +		xfers.len = CIRC_CNT_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
> > +		xfers.len = min_t(u16, 16, xfers.len);
> > +		xfers.data.out = circ->buf + circ->tail;
> > +
> > +		ret = i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
> > +		if (ret) {
> > +			/*
> > +			 * Target side may not move data out of FIFO. delay can't resolve problem,
> > +			 * just reduce some possiblity. Target can't end I3C SDR mode write
> > +			 * transfer, discard data is reasonable when FIFO overrun.
> > +			 */
> > +			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
> > +			retry--;
> > +		} else {
> > +			retry = 0;
> > +		}
> > +
> > +		actual = xfers.len;
> > +
> > +		circ->tail = (circ->tail + actual) & (UART_XMIT_SIZE - 1);
> > +
> > +		if (CIRC_CNT(circ->head, circ->tail, UART_XMIT_SIZE) < WAKEUP_CHARS)
> > +			tty_port_tty_wakeup(&sport->port);
> > +
> > +		cnt = CIRC_CNT(circ->head, circ->tail, UART_XMIT_SIZE);
> > +	}
> > +
> > +	spin_lock_irqsave(&sport->xlock, flags);
> > +	if (circ->head == circ->tail)
> > +		complete(&sport->txcomplete);
> > +	spin_unlock_irqrestore(&sport->xlock, flags);
> > +}
> > +
> > +static int i3c_probe(struct i3c_device *i3cdev)
> > +{
> > +	struct ttyi3c_port *port;
> > +	struct device *tty_dev;
> > +	struct i3c_ibi_setup req;
> > +	int minor;
> > +	int ret;
> > +
> > +	port = devm_kzalloc(&i3cdev->dev, sizeof(*port), GFP_KERNEL);
> > +	if (!port)
> > +		return -ENOMEM;
> > +
> > +	port->i3cdev = i3cdev;
> > +	port->buffer = devm_kzalloc(&i3cdev->dev, UART_XMIT_SIZE, GFP_KERNEL);
> > +	if (!port->buffer)
> > +		return -ENOMEM;
> > +
> > +	port->xmit.buf = devm_kzalloc(&i3cdev->dev, UART_XMIT_SIZE, GFP_KERNEL);
> > +	if (!port->xmit.buf)
> > +		return -ENOMEM;
> 
> You allocate two pages even if you never use the device?
> 
> > +	dev_set_drvdata(&i3cdev->dev, port);
> > +
> > +	req.max_payload_len = 8;
> > +	req.num_slots = 4;
> > +	req.handler = &i3c_controller_irq_handler;
> > +
> > +	ret = i3c_device_request_ibi(i3cdev, &req);
> > +	if (ret)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&i3c_tty_minors_lock);
> > +	minor = idr_alloc(&i3c_tty_minors, port, 0, I3C_TTY_MINORS, GFP_KERNEL);
> > +	mutex_unlock(&i3c_tty_minors_lock);
> > +
> > +	if (minor < 0)
> > +		return -EINVAL;
> > +
> > +	spin_lock_init(&port->xlock);
> > +	INIT_WORK(&port->txwork, tty_i3c_txwork);
> > +	INIT_WORK(&port->rxwork, tty_i3c_rxwork);
> > +	init_completion(&port->txcomplete);
> > +
> > +	port->workqueue = alloc_workqueue("%s", 0, 0, dev_name(&i3cdev->dev));
> > +	if (!port->workqueue)
> > +		return -ENOMEM;
> > +
> > +	tty_port_init(&port->port);
> > +	port->port.ops = &i3c_port_ops;
> > +
> > +	tty_dev = tty_port_register_device(&port->port, i3c_tty_driver, minor,
> > +					   &i3cdev->dev);
> > +	if (IS_ERR(tty_dev)) {
> > +		destroy_workqueue(port->workqueue);
> 
> What about tty_port_put() (it drops the idr too)? And free ibi?
> 
> > +		return PTR_ERR(tty_dev);
> > +	}
> > +
> > +	port->minor = minor;
> > +
> > +	return 0;
> > +}
> > +
> > +void i3c_remove(struct i3c_device *dev)
> > +{
> > +	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
> > +
> > +	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
> > +	cancel_work_sync(&sport->txwork);
> > +	destroy_workqueue(sport->workqueue);
> 
> The same as above.
> 
> > +}
> > +
> > +static struct i3c_driver i3c_driver = {
> > +	.driver = {
> > +		.name = "ttyi3c",
> > +	},
> > +	.probe = i3c_probe,
> > +	.remove = i3c_remove,
> > +	.id_table = i3c_ids,
> > +};
> > +
> > +static int __init i3c_tty_init(void)
> > +{
> > +	int ret;
> > +
> > +	i3c_tty_driver = tty_alloc_driver(I3C_TTY_MINORS,
> > +					  TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> > +
> > +	if (IS_ERR(i3c_tty_driver))
> > +		return PTR_ERR(i3c_tty_driver);
> > +
> > +	i3c_tty_driver->driver_name = "ttyI3C";
> > +	i3c_tty_driver->name = "ttyI3C";
> > +	i3c_tty_driver->minor_start = 0,
> > +	i3c_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
> > +	i3c_tty_driver->subtype = SERIAL_TYPE_NORMAL,
> > +	i3c_tty_driver->init_termios = tty_std_termios;
> > +	i3c_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL |
> > +					       CLOCAL;
> > +	i3c_tty_driver->init_termios.c_lflag = 0;
> > +
> > +	tty_set_operations(i3c_tty_driver, &i3c_tty_ops);
> > +
> > +	ret = tty_register_driver(i3c_tty_driver);
> > +	if (ret) {
> > +		tty_driver_kref_put(i3c_tty_driver);
> > +		return ret;
> > +	}
> > +
> > +	ret = i3c_driver_register(&i3c_driver);
> > +	if (ret) {
> > +		tty_unregister_driver(i3c_tty_driver);
> > +		tty_driver_kref_put(i3c_tty_driver);
> 
> Use goto + fail paths. And in i3c_probe() too.
> 
> > +	}
> > +
> > +	return ret;
> > +}
> 
> 
> regards,
> -- 
> js
> suse labs
> 
