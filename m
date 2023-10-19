Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ADF7CF0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344845AbjJSHNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjJSHNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:13:05 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F71D123;
        Thu, 19 Oct 2023 00:13:02 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-507bd64814fso3780188e87.1;
        Thu, 19 Oct 2023 00:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697699580; x=1698304380;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWXfyH8FGqvnOIek52mhG0htl7FqtqHIc3KruWDdYmM=;
        b=vV5clfyXMaBmtBowgrCxcINz9kGFRqkYef/yzGGmxgADHCUhBuS+Q3NBQ1909sDsna
         et1ISHBe3XPAsbXZwhTULC1ncCFBveG3nL0SLkfvQnMKI8lNjFcCA1qg7wKKc0GlKG5g
         JHwLs8+FEk/6wqqlFNGhvxvFphYT+Ro1Am/OikA5DA7FV7yYEVhCuNIU2JmSXdozTtWN
         OnQ0zL/9GS4Kdq04QbSuwe8SQAYLfqQhnrFkUNvTnDWpempgnOJeJC029QCNZf9COjby
         V51PFggCujzGOdcwKkVo4E9MDtr07y3wNtZQHtxBBVHxieUtyuHg4jldCVDeFRBYC0Fk
         axjQ==
X-Gm-Message-State: AOJu0YxbViTW8YCLw/OUKjDpFeVuQ3beRZdnL2w3ba8lF4iuago4RC8Q
        jbDUkkrA6hrR4TCYx+Pt8Ng=
X-Google-Smtp-Source: AGHT+IG85RSo1VX8pq+tMx9JkCYwNHRym6Q+NqIGKm8vyNhKQVOrtg3/iAnFydUAlHaRVjrN3GVVGg==
X-Received: by 2002:a05:6512:2820:b0:507:a04e:3207 with SMTP id cf32-20020a056512282000b00507a04e3207mr977906lfb.6.1697699579936;
        Thu, 19 Oct 2023 00:12:59 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b00402d34ea099sm3636925wms.29.2023.10.19.00.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 00:12:59 -0700 (PDT)
Message-ID: <caa8d113-3182-4f5f-affa-e5f8037498db@kernel.org>
Date:   Thu, 19 Oct 2023 09:12:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tty: i3c: add tty over i3c master support
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:TTY LAYER AND SERIAL DRIVERS" 
        <linux-serial@vger.kernel.org>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, miquel.raynal@bootlin.com
References: <20231018211111.3437929-1-Frank.Li@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20231018211111.3437929-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 10. 23, 23:11, Frank Li wrote:
> Add new driver to allow tty over i3c master.

What is it good for? Why we should consider this for inclusion at all?

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>      This patch depend on
>      https://lore.kernel.org/imx/20231018205929.3435110-1-Frank.Li@nxp.com/T/#t
> 
>   drivers/tty/Kconfig   |   8 +
>   drivers/tty/Makefile  |   1 +
>   drivers/tty/i3c_tty.c | 466 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 475 insertions(+)
>   create mode 100644 drivers/tty/i3c_tty.c
> 
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 5646dc6242cd9..6d91fe6a211a1 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -412,6 +412,14 @@ config RPMSG_TTY
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called rpmsg_tty.
>   
> +config I3C_TTY
> +	tristate "tty over i3c"

"TTY over I3C"

> +	depends on I3C
> +	help
> +	  Select this options if you'd like use tty over I3C master controller

TTY and add a period.

> --- /dev/null
> +++ b/drivers/tty/i3c_tty.c
> @@ -0,0 +1,466 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2023 NXP.
> + *
> + * Author: Frank Li <Frank.Li@nxp.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/slab.h>
> +#include <linux/console.h>
> +#include <linux/serial_core.h>
> +#include <linux/interrupt.h>
> +#include <linux/workqueue.h>
> +#include <linux/tty_flip.h>
> +
> +static DEFINE_IDR(i3c_tty_minors);
> +static DEFINE_MUTEX(i3c_tty_minors_lock);
> +
> +static struct tty_driver *i3c_tty_driver;
> +
> +#define I3C_TTY_MINORS		256
> +#define I3C_TTY_TRANS_SIZE	16
> +#define I3C_TTY_RX_STOP		BIT(0)
> +#define I3C_TTY_RETRY		20
> +#define I3C_TTY_YIELD_US	100
> +
> +struct ttyi3c_port {
> +	struct tty_port port;
> +	int minor;
> +	unsigned int txfifo_size;
> +	unsigned int rxfifo_size;
> +	struct circ_buf xmit;

Why can't you use port.xmit_fifo?

> +	spinlock_t xlock; /* protect xmit */
> +	void *buffer;
> +	struct i3c_device *i3cdev;
> +	struct work_struct txwork;
> +	struct work_struct rxwork;
> +	struct completion txcomplete;
> +	struct workqueue_struct *workqueue;

Why do you need a special wq? And even, why per port?

> +	atomic_t status;
> +};
> +
> +static const struct i3c_device_id i3c_ids[] = {
> +	I3C_DEVICE(0x011B, 0x1000, NULL),
> +	{ /* sentinel */ },
> +};
> +
> +static int i3c_port_activate(struct tty_port *port, struct tty_struct *tty)
> +{
> +	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
> +
> +	atomic_set(&sport->status, 0);
> +
> +	return i3c_device_enable_ibi(sport->i3cdev);
> +}
> +
> +static void i3c_port_shutdown(struct tty_port *port)
> +{
> +	struct ttyi3c_port *sport =
> +		container_of(port, struct ttyi3c_port, port);
> +
> +	i3c_device_disable_ibi(sport->i3cdev);
> +}
> +
> +static void i3c_port_destruct(struct tty_port *port)
> +{
> +	struct ttyi3c_port *sport =
> +		container_of(port, struct ttyi3c_port, port);
> +
> +	mutex_lock(&i3c_tty_minors_lock);
> +	idr_remove(&i3c_tty_minors, sport->minor);
> +	mutex_unlock(&i3c_tty_minors_lock);
> +}
> +
> +static const struct tty_port_operations i3c_port_ops = {
> +	.shutdown = i3c_port_shutdown,
> +	.activate = i3c_port_activate,
> +	.destruct = i3c_port_destruct,
> +};
> +
> +static struct ttyi3c_port *i3c_get_by_minor(unsigned int minor)
> +{
> +	struct ttyi3c_port *sport;
> +
> +	mutex_lock(&i3c_tty_minors_lock);
> +	sport = idr_find(&i3c_tty_minors, minor);
> +	mutex_unlock(&i3c_tty_minors_lock);
> +
> +	return sport;
> +}
> +
> +static int i3c_install(struct tty_driver *driver, struct tty_struct *tty)
> +{
> +	struct ttyi3c_port *sport;
> +	int ret;
> +
> +	sport = i3c_get_by_minor(tty->index);
> +	if (!sport)
> +		return -ENODEV;
> +
> +	ret = tty_standard_install(driver, tty);
> +	if (ret)
> +		return ret;
> +
> +	tty->driver_data = sport;
> +
> +	return 0;
> +}

You don't need this at all. (Watch for XXX marks below.)

> +static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;
> +	struct circ_buf *circ = &sport->xmit;
> +	unsigned long flags;
> +	int c, ret = 0;
> +
> +	spin_lock_irqsave(&sport->xlock, flags);
> +	while (1) {
> +		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
> +		if (count < c)
> +			c = count;
> +		if (c <= 0)
> +			break;
> +
> +		memcpy(circ->buf + circ->head, buf, c);
> +		circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
> +		buf += c;
> +		count -= c;
> +		ret += c;
> +	}
> +	spin_unlock_irqrestore(&sport->xlock, flags);

With kfifo, all this would be one line, right?

> +
> +	if (circ->head != circ->tail)
> +		queue_work(sport->workqueue, &sport->txwork);
> +
> +	return ret;
> +}
> +
> +static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;
> +	struct circ_buf *circ = &sport->xmit;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&sport->xlock, flags);
> +
> +	if (sport && CIRC_SPACE(circ->head, circ->tail, UART_XMIT_SIZE) != 0) {
> +		circ->buf[circ->head] = ch;
> +		circ->head = (circ->head + 1) & (UART_XMIT_SIZE - 1);
> +		ret = 1;
> +	}
> +
> +	spin_unlock_irqrestore(&sport->xlock, flags);
> +
> +	return ret;
> +}
> +
> +static void i3c_flush_chars(struct tty_struct *tty)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;
> +
> +	queue_work(sport->workqueue, &sport->txwork);
> +}
> +
> +static unsigned int i3c_write_room(struct tty_struct *tty)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;
> +	struct circ_buf *circ = &sport->xmit;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&sport->xlock, flags);
> +	ret = CIRC_SPACE(circ->head, circ->tail, UART_XMIT_SIZE);
> +	spin_unlock_irqrestore(&sport->xlock, flags);
> +
> +	return ret;
> +}
> +
> +static void i3c_throttle(struct tty_struct *tty)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;
> +
> +	atomic_or(I3C_TTY_RX_STOP, &sport->status);
> +}
> +
> +static void i3c_unthrottle(struct tty_struct *tty)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;
> +
> +	atomic_andnot(I3C_TTY_RX_STOP, &sport->status);
> +
> +	queue_work(sport->workqueue, &sport->rxwork);
> +}
> +
> +static int i3c_open(struct tty_struct *tty, struct file *filp)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;

XXX Here, you can simply do:

struct ttyi3c_port *sport = container_of(tty->port, struct ttyi3c_port, 
port);

tty->driver_data = sport;


> +	return tty_port_open(&sport->port, tty, filp);
> +}
> +
> +static void i3c_close(struct tty_struct *tty, struct file *filp)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;
> +
> +	if (!sport)
> +		return;

How can that happen?

> +	tty_port_close(tty->port, tty, filp);
> +}
> +
> +static void i3c_wait_until_sent(struct tty_struct *tty, int timeout)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;
> +
> +	wait_for_completion_timeout(&sport->txcomplete, timeout);
> +	reinit_completion(&sport->txcomplete);

Does this work in parallel?

> +}
> +
> +static const struct tty_operations i3c_tty_ops = {
> +	.install = i3c_install,
> +	.open = i3c_open,
> +	.close = i3c_close,
> +	.write = i3c_write,
> +	.put_char = i3c_put_char,
> +	.flush_chars = i3c_flush_chars,
> +	.write_room = i3c_write_room,
> +	.throttle = i3c_throttle,
> +	.unthrottle = i3c_unthrottle,
> +	.wait_until_sent = i3c_wait_until_sent,
> +};
> +
> +static void i3c_controller_irq_handler(struct i3c_device *dev,
> +				       const struct i3c_ibi_payload *payload)
> +{
> +	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
> +
> +	queue_work(sport->workqueue, &sport->rxwork);

Doesn't ibi provide threaded irqs? Oh, wait, i3c_master_handle_ibi() is 
already a work!

> +}
> +
> +static void tty_i3c_rxwork(struct work_struct *work)
> +{
> +	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
> +	struct i3c_priv_xfer xfers;
> +	int retry = I3C_TTY_RETRY;
> +	u16 status = BIT(0);
> +
> +	do {
> +		memset(&xfers, 0, sizeof(xfers));
> +		xfers.data.in = sport->buffer;
> +		xfers.len = I3C_TTY_TRANS_SIZE;
> +		xfers.rnw = 1;
> +
> +		if (I3C_TTY_RX_STOP & atomic_read(&sport->status))

Hmm, why not much simpler (and yet atomic) {set,test,clear}_bit()?

> +			break;
> +
> +		i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
> +
> +		if (xfers.actual_len) {
> +			tty_insert_flip_string(&sport->port, sport->buffer, xfers.actual_len);

This can fail.

> +			retry = 20;
> +			continue;
> +		} else {

"} else {" uneeded.

> +			status = BIT(0);
> +			i3c_device_getstatus_format1(sport->i3cdev, &status);
> +			/*
> +			 * Target side need some time to fill data into fifo. Target side may not

"needs"

> +			 * have hardware update status in real time. Software update status always
> +			 * need some delays.

"needs"

> +			 *
> +			 * Generally, target side have cicular buffer in memory, it will be moved
"circular" all around.

> +			 * into FIFO by CPU or DMA. 'status' just show if cicular buffer empty. But
> +			 * there are gap, espcially CPU have not response irq to fill FIFO in time.

espcially

> +			 * So xfers.actual will be zero, wait for little time to avoid flood
> +			 * transfer in i3c bus.
> +			 */
> +			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
> +			retry--;
> +		}
> +
> +	} while (retry && (status & BIT(0)));
> +
> +	tty_flip_buffer_push(&sport->port);
> +}
> +
> +static void tty_i3c_txwork(struct work_struct *work)
> +{
> +	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, txwork);
> +	struct circ_buf *circ = &sport->xmit;
> +	int cnt = CIRC_CNT(circ->head, circ->tail, UART_XMIT_SIZE);
> +	struct i3c_priv_xfer xfers;
> +	int retry = I3C_TTY_RETRY;
> +	unsigned long flags;
> +	int actual;
> +	int ret;
> +
> +	while (cnt > 0 && retry) {
> +		xfers.rnw = 0;
> +		xfers.len = CIRC_CNT_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
> +		xfers.len = min_t(u16, 16, xfers.len);
> +		xfers.data.out = circ->buf + circ->tail;
> +
> +		ret = i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
> +		if (ret) {
> +			/*
> +			 * Target side may not move data out of FIFO. delay can't resolve problem,
> +			 * just reduce some possiblity. Target can't end I3C SDR mode write
> +			 * transfer, discard data is reasonable when FIFO overrun.
> +			 */
> +			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
> +			retry--;
> +		} else {
> +			retry = 0;
> +		}
> +
> +		actual = xfers.len;
> +
> +		circ->tail = (circ->tail + actual) & (UART_XMIT_SIZE - 1);
> +
> +		if (CIRC_CNT(circ->head, circ->tail, UART_XMIT_SIZE) < WAKEUP_CHARS)
> +			tty_port_tty_wakeup(&sport->port);
> +
> +		cnt = CIRC_CNT(circ->head, circ->tail, UART_XMIT_SIZE);
> +	}
> +
> +	spin_lock_irqsave(&sport->xlock, flags);
> +	if (circ->head == circ->tail)
> +		complete(&sport->txcomplete);
> +	spin_unlock_irqrestore(&sport->xlock, flags);
> +}
> +
> +static int i3c_probe(struct i3c_device *i3cdev)
> +{
> +	struct ttyi3c_port *port;
> +	struct device *tty_dev;
> +	struct i3c_ibi_setup req;
> +	int minor;
> +	int ret;
> +
> +	port = devm_kzalloc(&i3cdev->dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->i3cdev = i3cdev;
> +	port->buffer = devm_kzalloc(&i3cdev->dev, UART_XMIT_SIZE, GFP_KERNEL);
> +	if (!port->buffer)
> +		return -ENOMEM;
> +
> +	port->xmit.buf = devm_kzalloc(&i3cdev->dev, UART_XMIT_SIZE, GFP_KERNEL);
> +	if (!port->xmit.buf)
> +		return -ENOMEM;

You allocate two pages even if you never use the device?

> +	dev_set_drvdata(&i3cdev->dev, port);
> +
> +	req.max_payload_len = 8;
> +	req.num_slots = 4;
> +	req.handler = &i3c_controller_irq_handler;
> +
> +	ret = i3c_device_request_ibi(i3cdev, &req);
> +	if (ret)
> +		return -EINVAL;
> +
> +	mutex_lock(&i3c_tty_minors_lock);
> +	minor = idr_alloc(&i3c_tty_minors, port, 0, I3C_TTY_MINORS, GFP_KERNEL);
> +	mutex_unlock(&i3c_tty_minors_lock);
> +
> +	if (minor < 0)
> +		return -EINVAL;
> +
> +	spin_lock_init(&port->xlock);
> +	INIT_WORK(&port->txwork, tty_i3c_txwork);
> +	INIT_WORK(&port->rxwork, tty_i3c_rxwork);
> +	init_completion(&port->txcomplete);
> +
> +	port->workqueue = alloc_workqueue("%s", 0, 0, dev_name(&i3cdev->dev));
> +	if (!port->workqueue)
> +		return -ENOMEM;
> +
> +	tty_port_init(&port->port);
> +	port->port.ops = &i3c_port_ops;
> +
> +	tty_dev = tty_port_register_device(&port->port, i3c_tty_driver, minor,
> +					   &i3cdev->dev);
> +	if (IS_ERR(tty_dev)) {
> +		destroy_workqueue(port->workqueue);

What about tty_port_put() (it drops the idr too)? And free ibi?

> +		return PTR_ERR(tty_dev);
> +	}
> +
> +	port->minor = minor;
> +
> +	return 0;
> +}
> +
> +void i3c_remove(struct i3c_device *dev)
> +{
> +	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
> +
> +	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
> +	cancel_work_sync(&sport->txwork);
> +	destroy_workqueue(sport->workqueue);

The same as above.

> +}
> +
> +static struct i3c_driver i3c_driver = {
> +	.driver = {
> +		.name = "ttyi3c",
> +	},
> +	.probe = i3c_probe,
> +	.remove = i3c_remove,
> +	.id_table = i3c_ids,
> +};
> +
> +static int __init i3c_tty_init(void)
> +{
> +	int ret;
> +
> +	i3c_tty_driver = tty_alloc_driver(I3C_TTY_MINORS,
> +					  TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> +
> +	if (IS_ERR(i3c_tty_driver))
> +		return PTR_ERR(i3c_tty_driver);
> +
> +	i3c_tty_driver->driver_name = "ttyI3C";
> +	i3c_tty_driver->name = "ttyI3C";
> +	i3c_tty_driver->minor_start = 0,
> +	i3c_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
> +	i3c_tty_driver->subtype = SERIAL_TYPE_NORMAL,
> +	i3c_tty_driver->init_termios = tty_std_termios;
> +	i3c_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL |
> +					       CLOCAL;
> +	i3c_tty_driver->init_termios.c_lflag = 0;
> +
> +	tty_set_operations(i3c_tty_driver, &i3c_tty_ops);
> +
> +	ret = tty_register_driver(i3c_tty_driver);
> +	if (ret) {
> +		tty_driver_kref_put(i3c_tty_driver);
> +		return ret;
> +	}
> +
> +	ret = i3c_driver_register(&i3c_driver);
> +	if (ret) {
> +		tty_unregister_driver(i3c_tty_driver);
> +		tty_driver_kref_put(i3c_tty_driver);

Use goto + fail paths. And in i3c_probe() too.

> +	}
> +
> +	return ret;
> +}


regards,
-- 
js
suse labs

