Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013D47BBABB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjJFOsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjJFOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:48:18 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2EFA6;
        Fri,  6 Oct 2023 07:48:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 88F625C0227;
        Fri,  6 Oct 2023 10:48:12 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Fri, 06 Oct 2023 10:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696603692; x=1696690092; bh=4V
        blRyotvtaEmuGZNgu/850TJH7a2cu9QgvqPV238h8=; b=oZAe9P1EB6qokdFhcr
        q7tE3kHXokqn3ELOG5/NmYUllULo4EDJXwbAf4wIznJcqfDAlSZCaBbU6aLiE/8T
        dj/GWDKdKYodg/4bZVVWfH6fY5cGIISOXdVDL6DBB1aFj7QDgi1ZocapWj84Kwo5
        Pb8Ews2MbwPOJlMf0VZklP9yg3Xiuofzs/vaFL1k9rg8myMWh/e8bPeF6rghASJa
        poKfM/WCCRdHJYXSLI2Lj1xF80EhjKrCSgOdTBQ9Zj9Kd0fk2L2m7BSQpKjWV1Vw
        oV79d2sh1pDRkr2C/r+0u1TwHxjqtXdIJ4r53uZcXu37JRVpKIIsWdC2i42tmN2T
        MdyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696603692; x=1696690092; bh=4VblRyotvtaEm
        uGZNgu/850TJH7a2cu9QgvqPV238h8=; b=gfUpGBl4rKLaXY4o42RoM+S1fZ/VP
        hB8UZM/7afg8gZg78RCR+7kgME3Zp4JypfnICLc8QXRfgdLQXSbYhhZe8yMD4ntG
        EkRaZujeKXfzzRKkRItiIhKu2NEKmpQIieilOM+77BDWIgdAMfSMoXr7ENnGy5ug
        dkhnhLEVbfPjlx6WWYbTSAjYez3CB83UM8Xmz5jRipbcYhkq1QgKlWHtE0jOQnyk
        IFxUfLB2XU7JHZ5uQvhnn/4LKv8sUWIDXP5xiL2hL478f5GRKSMpujajdVsng8Yq
        cRvuaOB79nrH1VRoGwWiTYEfWEfAesLC7oOwGvgSvdHbIFkhqamfSoqTw==
X-ME-Sender: <xms:Kh4gZf6AoVsAH9KX8TnlnySp1kIUvlCw5-CrFNrwOm5EykNkZRKxRg>
    <xme:Kh4gZU48xpOMbkTYo8UCnc7U1GVsYvlRMs6VrqRave0FxmDmOtbgPGhv8FCszla2X
    RX42VZaCui57p5e3V8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeliedvtefgudfffeekkedtvdellefffeeviedvudektdekudehvdfgkeefkedt
    veenucffohhmrghinhepghhithdqshgtmhdrtghomhdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvg
X-ME-Proxy: <xmx:Kh4gZWcZ3jhXV02iU4h8C-oqwmQehrUAMhkBAIoeShO9e9NdlWGdXA>
    <xmx:Kh4gZQLHOsNoW-Qv64eDUZgQA8YiCt3B6X0Nf5EEI7w4W8lYi4cdbw>
    <xmx:Kh4gZTJM7lx4Z4WVjMcYZAo9o8BqTmyy151Kgv9jprbBezoZlEmVUg>
    <xmx:LB4gZU55HvHgA7OIddAgjSQkTYFgYw823Wb79sDop0lzKPpaVc_PvQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 96C451700090; Fri,  6 Oct 2023 10:48:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <86db0fe5-930d-4cbb-bd7d-03367da38951@app.fastmail.com>
In-Reply-To: <202310050726.GDpZbMDO-lkp@intel.com>
References: <20231004161038.2818327-11-gregory.clement@bootlin.com>
 <202310050726.GDpZbMDO-lkp@intel.com>
Date:   Fri, 06 Oct 2023 16:47:50 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Paul Burton" <paulburton@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        "Vladimir Kondratiev" <vladimir.kondratiev@intel.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Chanho Min" <chanho.min@lge.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Russell King" <linux@armlinux.org.uk>
Subject: Re: [PATCH 10/11] MIPS: generic: Add support for Mobileye EyeQ5
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023, at 02:08, kernel test robot wrote:
> Hi Gregory,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on lee-mfd/for-mfd-next linus/master v6.6-rc4 
> next-20231004]
> [cannot apply to lee-mfd/for-mfd-fixes]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]


> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> https://lore.kernel.org/oe-kbuild-all/202310050726.GDpZbMDO-lkp@intel.com/
>
> All error/warnings (new ones prefixed by >>):
>
>    drivers/tty/serial/amba-pl011.c: In function 'pl011_sgbuf_init':
>>> drivers/tty/serial/amba-pl011.c:380:30: error: implicit declaration of function 'phys_to_page'; did you mean 'pfn_to_page'? [-Werror=implicit-function-declaration]
>      380 |         sg_set_page(&sg->sg, phys_to_page(dma_addr),
>          |                              ^~~~~~~~~~~~
>          |                              pfn_to_page

I discussed this with Gregory on IRC, and prototyped a
possible fix. The issue was caused by the use of coherent memory
for the buffer and passing that into a scatterlist structure.

Since there is no guarantee that the memory returned by
dma_alloc_coherent() is associated with a 'struct page', using
the architecture specific phys_to_page() is wrong, but using
virt_to_page() would be as well.

An easy workaround is to stop using sg lists altogether and
just use the *_single() functions instead. This also simplifies
the code a bit since the scatterlists in this driver always have
only one entry anyway.

Fixes: cb06ff102e2d7 ("ARM: PL011: Add support for Rx DMA buffer polling.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 0667e045ccb31..a3d92a91ff17d 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -219,8 +219,9 @@ static struct vendor_data vendor_st = {
 /* Deals with DMA transactions */
 
 struct pl011_sgbuf {
-	struct scatterlist sg;
-	char *buf;
+	dma_addr_t		dma;
+	size_t			len;
+	char			*buf;
 };
 
 struct pl011_dmarx_data {
@@ -241,7 +242,8 @@ struct pl011_dmarx_data {
 
 struct pl011_dmatx_data {
 	struct dma_chan		*chan;
-	struct scatterlist	sg;
+	dma_addr_t		dma;
+	size_t			len;
 	char			*buf;
 	bool			queued;
 };
@@ -369,18 +371,11 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
 	enum dma_data_direction dir)
 {
-	dma_addr_t dma_addr;
-
-	sg->buf = dma_alloc_coherent(chan->device->dev,
-		PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
+	sg->buf = dma_alloc_coherent(chan->device->dev, PL011_DMA_BUFFER_SIZE,
+				     &sg->dma, GFP_KERNEL);
 	if (!sg->buf)
 		return -ENOMEM;
-
-	sg_init_table(&sg->sg, 1);
-	sg_set_page(&sg->sg, phys_to_page(dma_addr),
-		PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
-	sg_dma_address(&sg->sg) = dma_addr;
-	sg_dma_len(&sg->sg) = PL011_DMA_BUFFER_SIZE;
+	sg->len = PL011_DMA_BUFFER_SIZE;
 
 	return 0;
 }
@@ -390,8 +385,7 @@ static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
 {
 	if (sg->buf) {
 		dma_free_coherent(chan->device->dev,
-			PL011_DMA_BUFFER_SIZE, sg->buf,
-			sg_dma_address(&sg->sg));
+				  PL011_DMA_BUFFER_SIZE, sg->buf, sg->dma);
 	}
 }
 
@@ -552,8 +546,8 @@ static void pl011_dma_tx_callback(void *data)
 
 	uart_port_lock_irqsave(&uap->port, &flags);
 	if (uap->dmatx.queued)
-		dma_unmap_sg(dmatx->chan->device->dev, &dmatx->sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
+				dmatx->len, DMA_TO_DEVICE);
 
 	dmacr = uap->dmacr;
 	uap->dmacr = dmacr & ~UART011_TXDMAE;
@@ -639,18 +633,19 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 			memcpy(&dmatx->buf[first], &xmit->buf[0], second);
 	}
 
-	dmatx->sg.length = count;
-
-	if (dma_map_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE) != 1) {
+	dmatx->len = count;
+	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
+				    DMA_TO_DEVICE);
+	if (dmatx->dma == DMA_MAPPING_ERROR) {
 		uap->dmatx.queued = false;
 		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
 		return -EBUSY;
 	}
 
-	desc = dmaengine_prep_slave_sg(chan, &dmatx->sg, 1, DMA_MEM_TO_DEV,
+	desc = dmaengine_prep_slave_single(chan, dmatx->dma, dmatx->len, DMA_MEM_TO_DEV,
 					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
-		dma_unmap_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE);
+		dma_unmap_single(dma_dev->dev, dmatx->dma, dmatx->len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		/*
 		 * If DMA cannot be used right now, we complete this
@@ -813,8 +808,8 @@ __acquires(&uap->port.lock)
 	dmaengine_terminate_async(uap->dmatx.chan);
 
 	if (uap->dmatx.queued) {
-		dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(uap->dmatx.chan->device->dev, uap->dmatx.dma,
+				 uap->dmatx.len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
 		pl011_write(uap->dmacr, uap, REG_DMACR);
@@ -836,7 +831,7 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
 	/* Start the RX DMA job */
 	sgbuf = uap->dmarx.use_buf_b ?
 		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
-	desc = dmaengine_prep_slave_sg(rxchan, &sgbuf->sg, 1,
+	desc = dmaengine_prep_slave_single(rxchan, sgbuf->dma, sgbuf->len,
 					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	/*
@@ -886,7 +881,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	if (uap->dmarx.poll_rate) {
 		/* The data can be taken by polling */
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = sgbuf->len - dmarx->last_residue;
 		/* Recalculate the pending size */
 		if (pending >= dmataken)
 			pending -= dmataken;
@@ -911,7 +906,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	/* Reset the last_residue for Rx DMA poll */
 	if (uap->dmarx.poll_rate)
-		dmarx->last_residue = sgbuf->sg.length;
+		dmarx->last_residue = sgbuf->len;
 
 	/*
 	 * Only continue with trying to read the FIFO if all DMA chars have
@@ -969,7 +964,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 	pl011_write(uap->dmacr, uap, REG_DMACR);
 	uap->dmarx.running = false;
 
-	pending = sgbuf->sg.length - state.residue;
+	pending = sgbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1015,7 +1010,7 @@ static void pl011_dma_rx_callback(void *data)
 	 * the DMA irq handler. So we check the residue here.
 	 */
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
-	pending = sgbuf->sg.length - state.residue;
+	pending = sgbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1074,7 +1069,7 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	sgbuf = dmarx->use_buf_b ? &uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
 	if (likely(state.residue < dmarx->last_residue)) {
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = sgbuf->len - dmarx->last_residue;
 		size = dmarx->last_residue - state.residue;
 		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
 				size);
@@ -1123,7 +1118,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		return;
 	}
 
-	sg_init_one(&uap->dmatx.sg, uap->dmatx.buf, PL011_DMA_BUFFER_SIZE);
+	uap->dmatx.len = PL011_DMA_BUFFER_SIZE;
 
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
@@ -1200,8 +1195,9 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
 		dmaengine_terminate_all(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
-			dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-				     DMA_TO_DEVICE);
+			dma_unmap_single(uap->dmatx.chan->device->dev,
+					 uap->dmatx.dma, uap->dmatx.len,
+					 DMA_TO_DEVICE);
 			uap->dmatx.queued = false;
 		}
 
