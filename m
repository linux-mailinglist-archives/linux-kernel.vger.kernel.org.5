Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C387D031C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346531AbjJSUVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjJSUVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:21:51 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD2A124;
        Thu, 19 Oct 2023 13:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAUufaZBLeURv+UJXxKgeQsfbxytUhq53fu4sL6iTc0XecRS64NdDxZALz5uWXX6V5wp9/k/QSgEeBD6DDyUcOa7q0eYMy1f4/UywVzVJ8r3X4UZ2wehi1uDgyH/ELck50gjlfWKYi4EmLYiljmMh6Uc+QLceqxne5X9SYOwvsruILEkHnyDn0TR5R8rZ2rZ4N2KlzCY6zEYdE4d37yrFf1nDoi92OrkQ+FBrY+xY9GfZZX+4Oy/EyiKCx1qiVfM4uqchQeKFYZobAq5N/Bw2Hl7/PDwD6D/f8tI1okekhLCsYWE7+yYlz34nR1ikS3XzKOqAPbBNkEO2J06AdRpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7zo6KAz+juvymJpkz/Rs+lXtx2pRU3PfZnuOyD+++Q=;
 b=CxIt3rltND6y37oVFHFWBtnHT/pa5k8HqkAMGtJcpaOn4nGEX4nMyiKahXW81eCJW9q5W+wTPHE9AAGK+5MPLkKMDGT0HnPtx5l+gQkeVtNnu4UoziF2FZ510rOlbiQW724Stn1HlPEpnufKmTBF9H9ykAI1Rd5o6XH/q2z4bT+NCDdczcCTf4bv7Pn3KJIR4AWgKFYfR7g1U8dwEKrvibXazhtjk6Q2EILbhXWaYCQpULJyt0mSRwNpGpUslS1lxzvG26YPfgk3dpOErqNxukKZWTMT55+qdf+BxYJUr4t2MjKIDEbHspuNiV6p4oDk3rEtQSFRppUtOGDeqJOyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7zo6KAz+juvymJpkz/Rs+lXtx2pRU3PfZnuOyD+++Q=;
 b=EWdoZSxsGm/gD1YeFK2ZxUvZTiiV2zUdPNIFjxyEHJixTMQsnJWPEbR3lSXUSfx113qDHL3+sx/UjBFr2bS6V9PnuPkpIl71C8CjimwdQeU1K1Z5xadKIodhTKK4rF5AEsfBw0iLskYpQTCLQuaJo8urODTvrNM28VWknFkLngs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8775.eurprd04.prod.outlook.com (2603:10a6:10:2e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 20:21:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 20:21:42 +0000
Date:   Thu, 19 Oct 2023 16:21:34 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TTY LAYER AND SERIAL DRIVERS" 
        <linux-serial@vger.kernel.org>, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH 1/1] tty: i3c: add tty over i3c master support
Message-ID: <ZTGPziszYR6xd8Ee@lizhi-Precision-Tower-5810>
References: <20231018211111.3437929-1-Frank.Li@nxp.com>
 <caa8d113-3182-4f5f-affa-e5f8037498db@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa8d113-3182-4f5f-affa-e5f8037498db@kernel.org>
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 5820b028-8f57-45ab-3fa2-08dbd0e101c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLgTXzlR5HKBaE/KgtfKUtYqp/UHImaK7u6EnGGZigqB0B8uXWUPV96gIut4nPieTute23kAdDRUkrq8Bv6IrZ1lWZS/87ydcKn8/Cvj7lyR1SPo9dJrD1VqWj++yNOXCNtW/AnH74a/1Ule2YXR2RXWVwzBn2mEFAu3zibflIo8brzwd5KGFxsx4nTEqa7kbP8WHHdr0Rqt9n51qeCcv9p5PLXFmrDvqwhi0/yIwScIF1bxu3sGiZB0PtZ+Ak8GB6PO/DSdLaiaTs0927Y6diNZJ3jQrlhPG8nKifscC336+aVKwVi8hpKywoQrhvIGEVrjrkiNr94orl6zxyHT0YRyoTj4w+tPv/oTkuGScrvjxZ702/0ZhFbHXXeHJGNvK1mUeUzYSDTfgbQGybMuF/CgouIkHU/RhzAIbYPBcu3KJlCtLLbY/5fgVXoXMMu5uFdkhOlxcmohmD9SCTiOZZhdkwKuzRvkfThTZ6KpGmyhCgk50BZTGBa5ee7JFiIvwrWb0ThxWyds939ZAy3AtFhBnV4p6nJywpdPHylZBNO5ZgVP9rVwu6Iwf3CKC72fgTy9p8ZrvDmYCwB+Ir9ORrwgNtgzxSoQ3+Y5Rh2757lFZW635UL4C4XKtCi0cK7vBmaabXP23+IBb4VWxddJs8TFvveV7Xl2i984b78VVs0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(5660300002)(8936002)(4326008)(8676002)(7416002)(2906002)(30864003)(33716001)(6506007)(6666004)(6512007)(9686003)(52116002)(38100700002)(26005)(83380400001)(38350700005)(6916009)(86362001)(316002)(54906003)(66556008)(66476007)(66946007)(6486002)(966005)(478600001)(42413004)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WwBTN8AzAEvgSyy+Na9M6EYydBSyn+aXE46mkCsfgpTGzprmnD8cOU8BdIyP?=
 =?us-ascii?Q?Qf0EZ6I/tqkmZge9UHO+LsXRLJkMrPul8AZbj9el+Qi07OJ4b2nBNSqpOyAb?=
 =?us-ascii?Q?29GyaWkNZv77kMVQy8umQf9OBbOCVAK6yslSpJwchTvWDutaiVYfKs4vrxKO?=
 =?us-ascii?Q?iBJDrIdorSTyl5RXsdbjt87k559vHssKBSlABDyLyXNLziihKuPGuRul4c+r?=
 =?us-ascii?Q?1qJWi6j1dMxJn54lmlS/Whbv95jSXu34Cv0I6vJx7UqX0kMhiHhA0cU6lt9O?=
 =?us-ascii?Q?F30qbR+UMxmISTcgisSBWnPwK8vkv1PVruENxql8cwSdXNbj14jv9gS14peB?=
 =?us-ascii?Q?l+AW5jHruLQc+XkueDEkgKEOLNamEaacCjwPH+7V8b2JEkJJZxyYw3rGYvbJ?=
 =?us-ascii?Q?SPe6163//Ir9ip3P259wOL0p7o5HvR3A7GAuaHbiZW9LbgFsR4UmFEnyYwik?=
 =?us-ascii?Q?yTcRIG/KJ7rng0tf4TMQPsxLllOibGlZ5BQiklEF9+w9u2rkiyZVZmislMMQ?=
 =?us-ascii?Q?Pg9nSNtNhkvLwQ12lG/bLS+KxVCMXHSlGgtzinjMH/daSXUpzkZinQswbGE7?=
 =?us-ascii?Q?VGc21MrzJ0zhNqioImWZTYH0qbMQqCZnNVbOOcl7c16xFYkfciOUe3xrJjnI?=
 =?us-ascii?Q?OTVsg/8XQLDmvsnnHmtK6uaO2ELATen29Hi93gYvUGgPU4GxGrS7qHov8AT2?=
 =?us-ascii?Q?RdTJBBzIfnuuAGexoWefUELDf7yZV5459ZAwOQkL8XPF1hqUTpPADQ4jL13c?=
 =?us-ascii?Q?BQ14k0DXSmefYqAqvho99iusinZ+ouoZAb8GCJXqVSNk6Nq5AqQLcSmZwKFA?=
 =?us-ascii?Q?ryJkJUNYwlBpMZWANgOt54ix/I8GCKNitFTBkQAcPsDqkx+mwvoWLl6z/NdB?=
 =?us-ascii?Q?zcrWul3Ck41n9dkovHhcdD/gvRFzBhiDl8l+abd0VaRRudFc7++UJRWLi/dm?=
 =?us-ascii?Q?TNOYfxwH106WXOVfIyeF/NIx5efAmAbWA8jcZOyPD5LPydavW1fAkPPtLqPB?=
 =?us-ascii?Q?SSjpP7MrsBzhI6CHMk57a9mdlyRaOEfPzwD1Tvr3VUCoCXwc+ld0bGKK6nz9?=
 =?us-ascii?Q?nQdepS2gZbkPLeNmaYTDAAy0gkPrs4TdpJKSPC6KIe/oldvnUs2QWEmW8ORL?=
 =?us-ascii?Q?vBPIF400egDSv9oTc0KatF23on3oJJz5QVAXQWvIJ9tNgIeEB956alWMMubt?=
 =?us-ascii?Q?mnoRfaMhPPJFzISdS2yseOlooGKGllTBAh6hATa8EnrkH58qfozC5jUgEYxX?=
 =?us-ascii?Q?aMVeXO2kuf7oaOdFyzKpGqhfD7wOSEY5FXg/2CdXSGAaa7dNB6sSx0zz/5h1?=
 =?us-ascii?Q?ff7UZcVfxLiYGCvs2XstURpKd6WHUpYlbaw4Xxa0BZzkywUVtJmvaEbsZ++5?=
 =?us-ascii?Q?+u13K5COy/nebP+jICKQecyfQZNEsZcYI3dJun4V3lxZKuFayDehiMqcMjLY?=
 =?us-ascii?Q?aQLPOpwb+S3gi7TlDDEz8BSFc0aqERBeQP1sdqlC+xDz19sOWGFyDpcGKgDC?=
 =?us-ascii?Q?81ZdfIEsYiDcWKifGYqtAGL8TEecAol8kY9YQP+a4/Q127TcZPLl+4VwaEFj?=
 =?us-ascii?Q?XixCXaBoIg51bprAL+o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5820b028-8f57-45ab-3fa2-08dbd0e101c5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 20:21:42.2906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w21bep8CS+KJKF9/hU58xqDGGsrszhsq2vizHHSu4ffCGxieRy2KIMKTDGGi5znKjzSwGGKI+vlgWb8cfo8W9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

rxwork need be trigger by two sources: one from IBI irq, another is from
i3c_unthrottle(). 

If unthrottle just clear flags and IBI irq already missed, so rx will stop
work util new IBI coming.

I hope rxwork can continue to fetch left data. i3c_tty driver can't issue
a fake IBI here.

So using sperate rxwork. both IBI and unthrottle to trigger such work, make
rx can get all data from slave side.

Frank

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
