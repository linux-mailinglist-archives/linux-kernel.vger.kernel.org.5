Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1B770DAD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 06:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjHEENQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 00:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHEENO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 00:13:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE5E72;
        Fri,  4 Aug 2023 21:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25AF760301;
        Sat,  5 Aug 2023 04:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59E6C433C7;
        Sat,  5 Aug 2023 04:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691208790;
        bh=B+Hti/ulp/uevcivvv8Im+RHQ75ZRaC0akSks3lId6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDlmdienoVYpj3NlELQW8GVagfLHzJ51d7+mfKFRO64A6nKCDxhFHUCZjbDNGh9Cb
         E4kzS5t3GyTHdJwDvHIukr9dNRj8aNnwtMVnyVmz7QFb931xYPOZdTWcChn6WLIBUV
         bcHmWDSmCmbE6P2eW+AwiYIO5YaPWWtmM48j3kFMx+Pksi4uA19xw7XM54BRLmfOb7
         q9mfiQgfFW12ptFkTN0kbsd+pILyK62r2LZXH3elxeNrXiilBzz0tP+ZYsrlKD0Vkk
         ZjKWFzMZyYdxxtdql0rBcQoe/a6iQ2dmxacf8pBlMmOmlZ7p8QX1slclioAHTVPr7l
         um6YVLGLq5ZGg==
Date:   Fri, 4 Aug 2023 21:16:08 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 06/25] mailbox: Add Gunyah message queue mailbox
Message-ID: <pkgymb7mqsyzpseyizeqxwgwbyqq3o56motbhkrcic3d5bdwvk@7opxedbsfi6j>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-7-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-7-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:34AM -0700, Elliot Berman wrote:
> Gunyah message queues are a unidirectional inter-VM pipe for messages up
> to 1024 bytes. This driver supports pairing a receiver message queue and
> a transmitter message queue to expose a single mailbox channel.
> 

I don't find value in using the mailbox framework to abstract the
message queues. You've split the resource-manager code in two separate
subsystems, with the complexities introduced by the abstraction, while
still being one implementation. Every message sent requires a tasklet
to be scheduled before continuing and you're unnecessarily waiting for
the tx fifo when you're filling the message queue.

You can effectively implement the same functionality, with 10% of the
code if not involving the mailbox framework.

> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  Documentation/virt/gunyah/message-queue.rst |   8 +
>  drivers/mailbox/Makefile                    |   2 +
>  drivers/mailbox/gunyah-msgq.c               | 219 ++++++++++++++++++++
>  include/linux/gunyah.h                      |  57 +++++
>  4 files changed, 286 insertions(+)
>  create mode 100644 drivers/mailbox/gunyah-msgq.c
> 
> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
> index b352918ae54b4..70d82a4ef32d7 100644
> --- a/Documentation/virt/gunyah/message-queue.rst
> +++ b/Documentation/virt/gunyah/message-queue.rst
> @@ -61,3 +61,11 @@ vIRQ: two TX message queues will have two vIRQs (and two capability IDs).
>        |               |         |                 |         |               |
>        |               |         |                 |         |               |
>        +---------------+         +-----------------+         +---------------+
> +
> +Gunyah message queues are exposed as mailboxes. To create the mailbox, create
> +a mbox_client and call `gh_msgq_init()`. On receipt of the RX_READY interrupt,
> +all messages in the RX message queue are read and pushed via the `rx_callback`
> +of the registered mbox_client.
> +
> +.. kernel-doc:: drivers/mailbox/gunyah-msgq.c
> +   :identifiers: gh_msgq_init
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index fc93761171113..5f929bb55e9a5 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -55,6 +55,8 @@ obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
>  
>  obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
>  
> +obj-$(CONFIG_GUNYAH)		+= gunyah-msgq.o
> +
>  obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
>  
>  obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
> diff --git a/drivers/mailbox/gunyah-msgq.c b/drivers/mailbox/gunyah-msgq.c
> new file mode 100644
> index 0000000000000..7f777339278eb
> --- /dev/null
> +++ b/drivers/mailbox/gunyah-msgq.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/gunyah.h>
> +#include <linux/printk.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +
> +#define mbox_chan_to_msgq(chan) (container_of(chan->mbox, struct gh_msgq, mbox))
> +
> +static irqreturn_t gh_msgq_rx_irq_handler(int irq, void *data)
> +{
> +	struct gh_msgq *msgq = data;
> +	struct gh_msgq_rx_data rx_data;
> +	enum gh_error gh_error;

err would be sufficient

> +	bool ready = true;

s/read/more_data/ perhaps?

> +
> +	while (ready) {

Doesn't really matter logically, but what you really mean is:

do {
	...
} while (more_data);

So perhaps reasonable to type that.

> +		gh_error = gh_hypercall_msgq_recv(msgq->rx_ghrsc->capid,
> +				&rx_data.data, sizeof(rx_data.data),
> +				&rx_data.length, &ready);
> +		if (gh_error != GH_ERROR_OK) {
> +			if (gh_error != GH_ERROR_MSGQUEUE_EMPTY)
> +				dev_warn(msgq->mbox.dev, "Failed to receive data: %d\n", gh_error);
> +			break;
> +		}

		if (err == GH_ERROR_MSGQUEUE_EMPTY) {
			break;
		} else if (err != GH_ERROR_OK) {
			dev_warn(...)
			break;
		}

		handle_message();

> +		if (likely(gh_msgq_chan(msgq)->cl))
> +			mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Fired when message queue transitions from "full" to "space available" to send messages */
> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
> +{
> +	struct gh_msgq *msgq = data;
> +
> +	mbox_chan_txdone(gh_msgq_chan(msgq), 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Fired after sending message and hypercall told us there was more space available. */
> +static void gh_msgq_txdone_tasklet(struct tasklet_struct *tasklet)
> +{
> +	struct gh_msgq *msgq = container_of(tasklet, struct gh_msgq, txdone_tasklet);
> +
> +	mbox_chan_txdone(gh_msgq_chan(msgq), msgq->last_ret);
> +}
> +
> +static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct gh_msgq *msgq = mbox_chan_to_msgq(chan);
> +	struct gh_msgq_tx_data *msgq_data = data;
> +	u64 tx_flags = 0;
> +	enum gh_error gh_error;
> +	bool ready;

s/ready/not_full/ or invert the values in gh_hypercall_msgq_send()

> +
> +	if (!msgq->tx_ghrsc)
> +		return -EOPNOTSUPP;
> +
> +	if (msgq_data->push)
> +		tx_flags |= GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH;
> +
> +	gh_error = gh_hypercall_msgq_send(msgq->tx_ghrsc->capid, msgq_data->length, msgq_data->data,
> +						tx_flags, &ready);
> +
> +	/**
> +	 * unlikely because Linux tracks state of msgq and should not try to
> +	 * send message when msgq is full.
> +	 */
> +	if (unlikely(gh_error == GH_ERROR_MSGQUEUE_FULL))
> +		return -EAGAIN;

You're propagating this all the way up to the application.

> +
> +	/**
> +	 * Propagate all other errors to client. If we return error to mailbox
> +	 * framework, then no other messages can be sent and nobody will know
> +	 * to retry this message.
> +	 */
> +	msgq->last_ret = gh_error_remap(gh_error);
> +
> +	/**
> +	 * This message was successfully sent, but message queue isn't ready to
> +	 * accept more messages because it's now full. Mailbox framework
> +	 * requires that we only report that message was transmitted when
> +	 * we're ready to transmit another message. We'll get that in the form
> +	 * of tx IRQ once the other side starts to drain the msgq.
> +	 */
> +	if (gh_error == GH_ERROR_OK) {
> +		if (!ready)
> +			return 0;

The message was committed successfully to the queue, there's no reason
for this VM to wait for the receiving VM to start consuming the queue
before returning from mbox_send_message().

As mentioned above, if you move away from the mailbox framework you can
instead keep track of when gh_hypercall_msgq_send() returned "the
message queue was filled up" and wait for the tx interrupt before making
the next call.

This will allow this instance to continue executing to some natural
point of waiting for resources.

> +	} else {
> +		dev_err(msgq->mbox.dev, "Failed to send data: %d (%d)\n", gh_error, msgq->last_ret);
> +	}
> +
> +	/**
> +	 * We can send more messages. Mailbox framework requires that tx done
> +	 * happens asynchronously to sending the message. Gunyah message queues
> +	 * tell us right away on the hypercall return whether we can send more
> +	 * messages. To work around this, defer the txdone to a tasklet.
> +	 */
> +	tasklet_schedule(&msgq->txdone_tasklet);

Ick.

> +
> +	return 0;
> +}
> +
> +static struct mbox_chan_ops gh_msgq_ops = {
> +	.send_data = gh_msgq_send_data,
> +};
> +
> +/**
> + * gh_msgq_init() - Initialize a Gunyah message queue with an mbox_client
> + * @parent: device parent used for the mailbox controller
> + * @msgq: Pointer to the gh_msgq to initialize
> + * @cl: A mailbox client to bind to the mailbox channel that the message queue creates
> + * @tx_ghrsc: optional, the transmission side of the message queue
> + * @rx_ghrsc: optional, the receiving side of the message queue
> + *
> + * At least one of tx_ghrsc and rx_ghrsc must be not NULL. Most message queue use cases come with
> + * a pair of message queues to facilitate bidirectional communication. When tx_ghrsc is set,
> + * the client can send messages with mbox_send_message(gh_msgq_chan(msgq), msg). When rx_ghrsc
> + * is set, the mbox_client must register an .rx_callback() and the message queue driver will
> + * deliver all available messages upon receiving the RX ready interrupt. The messages should be
> + * consumed or copied by the client right away as the gh_msgq_rx_data will be replaced/destroyed
> + * after the callback.
> + *
> + * Returns - 0 on success, negative otherwise
> + */
> +int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
> +		 struct gh_resource *tx_ghrsc, struct gh_resource *rx_ghrsc)
> +{
> +	int ret;
> +
> +	/* Must have at least a tx_ghrsc or rx_ghrsc and that they are the right device types */
> +	if ((!tx_ghrsc && !rx_ghrsc) ||
> +	    (tx_ghrsc && tx_ghrsc->type != GH_RESOURCE_TYPE_MSGQ_TX) ||
> +	    (rx_ghrsc && rx_ghrsc->type != GH_RESOURCE_TYPE_MSGQ_RX))
> +		return -EINVAL;
> +
> +	msgq->mbox.dev = parent;
> +	msgq->mbox.ops = &gh_msgq_ops;
> +	msgq->mbox.num_chans = 1;
> +	msgq->mbox.txdone_irq = true;
> +	msgq->mbox.chans = &msgq->mbox_chan;
> +
> +	ret = mbox_controller_register(&msgq->mbox);
> +	if (ret)
> +		return ret;
> +
> +	ret = mbox_bind_client(gh_msgq_chan(msgq), cl);
> +	if (ret)
> +		goto err_mbox;
> +
> +	if (tx_ghrsc) {
> +		msgq->tx_ghrsc = tx_ghrsc;
> +
> +		ret = request_irq(msgq->tx_ghrsc->irq, gh_msgq_tx_irq_handler, 0, "gh_msgq_tx",

Wrap your lines to 80 characters, unless there's a good reason. You
don't have a good reason here.

> +				msgq);
> +		if (ret)
> +			goto err_tx_ghrsc;
> +
> +		enable_irq_wake(msgq->tx_ghrsc->irq);
> +
> +		tasklet_setup(&msgq->txdone_tasklet, gh_msgq_txdone_tasklet);
> +	}
> +
> +	if (rx_ghrsc) {
> +		msgq->rx_ghrsc = rx_ghrsc;
> +
> +		ret = request_threaded_irq(msgq->rx_ghrsc->irq, NULL, gh_msgq_rx_irq_handler,
> +						IRQF_ONESHOT, "gh_msgq_rx", msgq);
> +		if (ret)
> +			goto err_tx_irq;
> +
> +		enable_irq_wake(msgq->rx_ghrsc->irq);
> +	}
> +
> +	return 0;
> +err_tx_irq:
> +	if (msgq->tx_ghrsc)
> +		free_irq(msgq->tx_ghrsc->irq, msgq);
> +
> +	msgq->rx_ghrsc = NULL;
> +err_tx_ghrsc:
> +	msgq->tx_ghrsc = NULL;
> +err_mbox:
> +	mbox_controller_unregister(&msgq->mbox);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_msgq_init);
> +
> +void gh_msgq_remove(struct gh_msgq *msgq)
> +{
> +	mbox_free_channel(gh_msgq_chan(msgq));
> +
> +	if (msgq->rx_ghrsc)
> +		free_irq(msgq->rx_ghrsc->irq, msgq);
> +
> +	if (msgq->tx_ghrsc) {
> +		tasklet_kill(&msgq->txdone_tasklet);
> +		free_irq(msgq->tx_ghrsc->irq, msgq);
> +	}
> +
> +	mbox_controller_unregister(&msgq->mbox);
> +
> +	msgq->rx_ghrsc = NULL;
> +	msgq->tx_ghrsc = NULL;
> +}
> +EXPORT_SYMBOL_GPL(gh_msgq_remove);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Gunyah Message Queue Driver");
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 01a6f202d037e..982e27d10d57f 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -8,11 +8,68 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/errno.h>
> +#include <linux/interrupt.h>
>  #include <linux/limits.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
>  #include <linux/types.h>
>  
> +/* Matches resource manager's resource types for VM_GET_HYP_RESOURCES RPC */
> +enum gh_resource_type {
> +	GH_RESOURCE_TYPE_BELL_TX	= 0,
> +	GH_RESOURCE_TYPE_BELL_RX	= 1,
> +	GH_RESOURCE_TYPE_MSGQ_TX	= 2,
> +	GH_RESOURCE_TYPE_MSGQ_RX	= 3,
> +	GH_RESOURCE_TYPE_VCPU		= 4,
> +};
> +
> +struct gh_resource {
> +	enum gh_resource_type type;
> +	u64 capid;
> +	unsigned int irq;
> +};
> +
> +/**
> + * Gunyah Message Queues
> + */
> +
> +#define GH_MSGQ_MAX_MSG_SIZE		240
> +
> +struct gh_msgq_tx_data {
> +	size_t length;
> +	bool push;
> +	char data[];
> +};
> +
> +struct gh_msgq_rx_data {
> +	size_t length;
> +	char data[GH_MSGQ_MAX_MSG_SIZE];
> +};
> +
> +struct gh_msgq {

This is just private data, exposed so that it can be intertwined with
the resource manager implementation.

> +	struct gh_resource *tx_ghrsc;
> +	struct gh_resource *rx_ghrsc;
> +
> +	/* msgq private */
> +	int last_ret; /* Linux error, not GH_STATUS_* */
> +	struct mbox_chan mbox_chan;
> +	struct mbox_controller mbox;
> +	struct tasklet_struct txdone_tasklet;
> +};
> +

Double newlines.

> +
> +int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
> +		     struct gh_resource *tx_ghrsc, struct gh_resource *rx_ghrsc);
> +void gh_msgq_remove(struct gh_msgq *msgq);
> +
> +static inline struct mbox_chan *gh_msgq_chan(struct gh_msgq *msgq)
> +{
> +	return &msgq->mbox.chans[0];
> +}
> +
>  /******************************************************************************/
>  /* Common arch-independent definitions for Gunyah hypercalls                  */
> +

Unrelated change.

Regards,
Bjorn

>  #define GH_CAPID_INVAL	U64_MAX
>  #define GH_VMID_ROOT_VM	0xff
>  
> -- 
> 2.40.0
> 
