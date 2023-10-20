Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405777D0872
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346978AbjJTGZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjJTGZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:25:06 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65143D55;
        Thu, 19 Oct 2023 23:25:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 85F2D5C0BCA;
        Fri, 20 Oct 2023 02:25:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 20 Oct 2023 02:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697783100; x=1697869500; bh=a8
        6LnDRuk28PigZ4CQHO6r+juEkdcI+21r+nqmdw2G8=; b=KHBkVaokj/3gMEVhdx
        JHIT9hQU8Y6sZQAX5H8Hg1zaPgQgtXZogD++y0XDlc9ue46YCdF8ozPFr1OiNmh7
        rvRt23iMrDcJrlxcUr9N+PmMeg2660qzHm6fnKgilO5O86smhTc8+QhFbgT6J8pE
        o9x1bzfDO7p9ZlkrYyC+/3+cLYW1E1SqLxpHMD5oQnzswxZXLppf55krYJNew7cA
        K0XS3hH1P9F+uUe8beslmnomGFfBWCLINEqyY9qc+BqqxQCwIXNii+5l30uF2tc9
        O/0/QsDKPvQBN6PgS0bCKhmZCi67NttlPTVjO8j4fjVjotoHbWJRw9FCf8FAZGUd
        eS4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697783100; x=1697869500; bh=a86LnDRuk28Pi
        gZ4CQHO6r+juEkdcI+21r+nqmdw2G8=; b=IMcIBLgi7/eAgvampo9Yuyf/Owe7z
        SsjCq/GNbMySXyjAheEZ+MgI8t9a77FcHYVWct2MY5PIQC1uDn4/ymlZ+Umts6qP
        U0+W7omXFPUkBPowJge5uIlTQGwZU+w5PxYdjx4rzlnAOZOoEHdJDrK3eytTwS9q
        ORV5/o22yjaa7mugSAki0IhIJ5vSjBi7aZedwgcCekj4QrTrVRUQSAyh8WL89u/f
        GH7U6Uk2UCdkLgKJ77Tx1zfvG1yAMF/GhejP0khV6UOdoU/4+k/YSORgvFGiV/IR
        CIGj6zgmTlqceApZKm0rwsf6aK6zM0awZSDw9yxLMBtYzTD8I1IZEZwRw==
X-ME-Sender: <xms:Oh0yZRn5qL7HM7mkM9cv0U9NwlW6bkZ6BX23inCg7TvmTf0Un4iQ9w>
    <xme:Oh0yZc2hwJYYZU9HpiGF5MPj5KdL6O4JDIENSABDyf80czrL0Yc_olis6Rw3PpudC
    09BruipHvUkAODQFXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeejgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Oh0yZXpqvyf_qyFYqF-vg4HI-fWCzYKA4-HGbkNASB5z4JaPPAESMQ>
    <xmx:Oh0yZRlehR_g2u1ZgxunQv9TWhJvn9L0bnHi6MXGOIdfYmeqDn2lHQ>
    <xmx:Oh0yZf1Ko-e4m4YGrGHluKOdK5fHqdf03ek2Zg8KhKN99NnN3muWgg>
    <xmx:PB0yZW3FwOotApXKRKJxg9Su5pgNNVVqD3iU0gJd6GxcxrqU3UEdkQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D44F0B60089; Fri, 20 Oct 2023 02:24:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <a07d417f-c2b5-4418-b788-ec37ccad513a@app.fastmail.com>
In-Reply-To: <20231020034921.1179-3-jyanchou@realtek.com>
References: <20231020034921.1179-1-jyanchou@realtek.com>
 <20231020034921.1179-3-jyanchou@realtek.com>
Date:   Fri, 20 Oct 2023 08:24:37 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jyan Chou" <jyanchou@realtek.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>, jh80.chung@samsung.com,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     riteshh@codeaurora.org, "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Conor Dooley" <conor+dt@kernel.org>, asutoshd@codeaurora.org,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Brian Norris" <briannorris@chromium.org>,
        "Doug Brown" <doug@schmorgal.com>,
        "Tony Huang" <tonyhuang.sunplus@gmail.com>, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
Subject: Re: [PATCH V3][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
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

On Fri, Oct 20, 2023, at 05:49, Jyan Chou wrote:
> We implemented cmdq feature on Synopsys DesignWare mmc driver.
> The difference between dw_mmc.c and dw_mmc_cqe.c were distinct
> register definitions, mmc user flow and the addition of cmdq.
>
> New version of User Guide had modify mmc driver's usage flow,
> we may need to renew code to precisely follow user guide.
>
> More over, We added a wait status function to satisfy synopsys
> user guide's description, since this flow might be specific in
> synopsys host driver only.
>
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>

>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 159a3e9490ae..894b89a396bb 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -762,6 +762,19 @@ config MMC_DW_PLTFM
> 
>  	  If unsure, say Y.
> 
> +config MMC_DW_CQE
> +	tristate "Synopsys DesignWare Memory Card with CQE Interface"
> +	depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST

Why do you need these specific architectures? For a generic
driver, it should not make a difference which architecture it
is built for, and it seems silly to exclude e.g. RISCV here.

Maybe just use 'depends on OF'.

> +DECLARE_COMPLETION(dw_mci_wait);

I'm worried by the use of all these blocking and busy-waiting
primitives in the driver. In addition to the completion, I see
a tasklet, a timer, various readl_poll_timeout, and more.

In an ideal block device implementation, none of these should
be needed, as the block requests should get queued up from
the blk_mq logic and completed when an interrupt happens.

In mmc, this is traditionally a bit more complex, but I would
hope we can avoid most of the additional deferral in new
drivers, and explain why the other ones are needed when this
is not possible.

Let's have a look at them individually.

> +#if defined(CONFIG_DEBUG_FS)
> +static int dw_mci_cqe_req_show(struct seq_file *s, void *v)
> +{
> +	struct dw_mci_slot *slot = s->private;
> +	struct mmc_request *mrq;
> +	struct mmc_command *cmd;
> +	struct mmc_command *stop;
> +	struct mmc_data	*data;
> +

You should not need an #ifdef around the debugfs helpers, if you
use the registration interface correctly, it all gets dropped
by dead code elimination.

> +static int dw_mci_cqe_start_command(struct dw_mci *host,
> +				    struct mmc_command *cmd, u32 cmd_flags)
> +{
....
> +
> +	host->int_waiting = &dw_mci_wait;
> +	end = jiffies + msecs_to_jiffies(DW_MCI_TIMEOUT_Ms);
> +	mod_timer(&host->timer, end);

This is just a timeout that happens when the command does not
complete within the expected time, right? If so that is probably
fine.

> +		spin_lock_irqsave(&host->irq_lock, flags);
> +		mcq_writew(host, CMD_R, cmd_flags);
> +		spin_unlock_irqrestore(&host->irq_lock, flags);
> +
> +		wait_for_completion(host->int_waiting);

This is odd for a couple of reasons:

- an MMIO write is not serialized by a spinlock because the
  bus fabric between the CPU and the device has no concept
  of locking, so if you actually rely on the lock to do something
  here, that is likely broken

- Using spin_lock_irqsave() implies that this function can be called
  from both atomic and non-atomic context, but then you have a blocking
  function right after it, so you could have used the much cheaper
  spin_lock_irq() here, if the lock is in fact useful

- The function is named ..._start_command(), which to me implies
  that it just pushes an operation to the device, but does not
  actually wait for it, so the wait_for_completion() seems
  misplaced here.

> +		if (xfer_flag == 1) {
> +			ret = readl_poll_timeout(host->regs + SDMMC_NORMAL_INT_STAT_R, 
> status,
> +						 (status & SDMMC_XFER_COMPLETE) ==
> +						 SDMMC_XFER_COMPLETE, 10, DW_MCI_TIMEOUT);
> +			if (ret) {
> +				/*error interrupt detected*/
> +				if ((mcq_readw(host, NORMAL_INT_STAT_R) & SDMMC_ERR_INTERRUPT) &&
> +				    host->tuning)
> +					dev_info(host->dev, "Tuning error ... keep tuning\n");
> +				else
> +					dev_err(host->dev, "Timeout waiting xfer complete, status = 
> 0x%x\n",
> +						(status & 0xffff));
> +			}
> +		} else {
> +			ret = readl_poll_timeout(host->regs + SDMMC_NORMAL_INT_STAT_R, 
> status,
> +						 (status & SDMMC_CMD_COMPLETE) ==
> +						SDMMC_CMD_COMPLETE, 10, DW_MCI_TIMEOUT);
> +			if (ret)
> +				dev_err(host->dev, "Timeout waiting cmd request complete\n");
> +		}

And these appear to defer the operation even more: regardless of
the xfer_flag, you always end up in an expensive poll loop
that starts a timer. If these are expected to not need the timer
in normal operation, please add some comments to explain the logic,
otherwise this may need to be restructured in a way that waits for
an interrupt instead of a slow timer.

> +
> +static int dw_mci_cqe_wait_status(struct dw_mci *host, struct 
> mmc_command *cmd, u32 *status)
> +{
> +	struct mmc_command wait;
> +	u32 cmdr;
> +	u32 cur_state;
> +	unsigned long timeend;
> +	int err = 0;
> +
> +	/* According to Synopsys userguide, we need to send wait command after
> +	 * stop cmd to check current status
> +	 */
> +
> +	wait = host->stat_ready;
> +	memset(&wait, 0, sizeof(struct mmc_command));
> +
> +	timeend = jiffies + msecs_to_jiffies(500);
> +	do {
> +		wait.opcode = MMC_SEND_STATUS;
> +		wait.arg = 1 << 16;
> +		wait.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
> +		wait.data = NULL;
> +		cmdr = (wait.opcode << 8) | SDMMC_RESP_LEN_48 |
> +			SDMMC_CMD_CHK_RESP_CRC | SDMMC_CMD_IDX_CHK_ENABLE;
> +
> +		mcq_writew(host, XFER_MODE_R, 0);
> +		mcq_writel(host, ARGUMENT_R, wait.arg);
> +		err = dw_mci_cqe_start_command(host, &wait, cmdr);
> +		if (err) {
> +			dw_mci_cqe_reset(host);
> +			break;
> +		}
> +
> +		dw_mci_cqe_read_rsp(host, &wait, wait.resp);
> +		*status = wait.resp[0];
> +		cur_state = R1_CURRENT_STATE(wait.resp[0]);
> +		err = -DW_MCI_NOT_READY;
> +		if (cur_state == R1_STATE_TRAN) {
> +			if (wait.resp[0] & R1_READY_FOR_DATA) {
> +				err = 0;
> +				break;
> +			}
> +		}
> +	} while (time_before(jiffies, timeend));
> +
> +	return err;
> +}

My first impression here was that this is a 500ms busy loop,
which would have been crazy, but I now see that it actually
blocks in the dw_mci_cqe_start_command() function I commented
on above, so it probably does the right thing here.

This would still be clearer if you changed the ..._start_command()
function to just start the command without blocking and then had
the waiting bit in the function called ...wait_status().

> +static void dw_mci_cqe_submit_data(struct dw_mci *host, struct 
> mmc_data *data)
> +{
> +	u32 dir = 0;
> +
> +	host->sg = NULL;
> +	host->data = data;
> +
> +	if (data->flags & MMC_DATA_READ)
> +		dir = DMA_FROM_DEVICE;
> +	else
> +		dir = DMA_TO_DEVICE;
> +
> +	host->dma_nents = dma_map_sg(mmc_dev(host->slot->mmc),
> +				     data->sg, data->sg_len, dir);
> +	host->sg = data->sg;
> +
> +	host->using_dma = 1;
> +
> +	dw_mci_cqe_submit_data_dma(host);
> +}

I think this is based on what the mmc layer expects
you to do, but I would point out that dma_map_sg() is
a fairly expensive operation on some chips, so it would
be nice to be able to map the buffers in advance and
not at the time when they are about to be submitted.

> +static void dw_mci_cqe_request(struct mmc_host *mmc, struct 
> mmc_request *mrq)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +
> +	WARN_ON(slot->mrq);
> +
> +	/*
> +	 * The check for card presence and queueing of the request must be
> +	 * atomic, otherwise the card could be removed in between and the
> +	 * request wouldn't fail until another card was inserted.
> +	 */
> +
> +	if (!dw_mci_cqe_get_cd(mmc)) {
> +		mrq->cmd->error = -ENOMEDIUM;
> +		mmc_request_done(mmc, mrq);
> +		return;
> +	}
> +
> +	down_write(&host->cr_rw_sem);
> +
> +	slot->mrq = mrq;
> +	host->mrq = mrq;
> +
> +	dw_mci_cqe_start_request(host, slot);
> +
> +	tasklet_schedule(&host->tasklet);
> +
> +	up_write(&host->cr_rw_sem);
> +}

The tasklet function pretty much only calls mmc_request_done(),
which I think can be called from any context, so why do you
need to defer to a tasklet here?

> +
> +/* Register access macros */
> +#define mcq_readl(dev, reg)                     \
> +	readl_relaxed((dev)->regs + SDMMC_##reg)
> +#define mcq_writel(dev, reg, value)                     \
> +	writel_relaxed((value), (dev)->regs + SDMMC_##reg)
> +
> +#define mcq_readw(dev, reg)                     \
> +	readw_relaxed((dev)->regs + SDMMC_##reg)
> +#define mcq_writew(dev, reg, value)                     \
> +	writew_relaxed((value), (dev)->regs + SDMMC_##reg)
> +
> +#define mcq_readb(dev, reg)                     \
> +	readb_relaxed((dev)->regs + SDMMC_##reg)
> +#define mcq_writeb(dev, reg, value)                     \
> +	writeb_relaxed((value), (dev)->regs + SDMMC_##reg)

The use of _relaxed MMIO helpers is probably a bug here, as this
skips the serialization against DMA and leads to incorrect data.

Anything that is not performance critical or that interacts
with DMA should use the normal readl/writel functions instead
of the relaxed ones.

> +#define dw_mci_get_int(dev)    \
> +	do {    \
> +		dev->normal_interrupt = mcq_readw(dev, NORMAL_INT_STAT_R);   \
> +		dev->error_interrupt = mcq_readw(dev, ERROR_INT_STAT_R);   \
> +		dev->auto_error_interrupt = mcq_readw(dev, AUTO_CMD_STAT_R);     \
> +	} while (0)

You only have two callers of this, so I think this would
be clearer when you open-code it.

> +/*clear status register, we always keep the card interrupt*/
> +#define dw_mci_clr_int(dev)                                            
>  \
> +	do {                                                            \
> +		mcq_writew(dev, ERROR_INT_STAT_R, mcq_readw(dev, ERROR_INT_STAT_R) & 
> 0xffff); \
> +		mcq_writew(dev, NORMAL_INT_STAT_R, mcq_readw(dev, NORMAL_INT_STAT_R) 
> & 0xffff); \
> +	} while (0)

Same here.

> +/* Board platform data */
> +struct dw_mci_board {
> +	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
> +	u32 caps;       /* Capabilities */
> +	u32 caps2;      /* More capabilities */
> +	u32 pm_caps;    /* PM capabilities */
> +
> +	/* delay in mS before detecting cards after interrupt */
> +	u32 detect_delay_ms;
> +
> +	struct reset_control *rstc;
> +};

This looks like an artifact from pre-DT days, just fold this into the
dw_mci structure directly.

     Arnd
