Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB3577E4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344001AbjHPPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242889AbjHPPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:08:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5179E10EC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:08:14 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.goehrs@pengutronix.de>)
        id 1qWI7s-0003IB-HQ; Wed, 16 Aug 2023 17:08:00 +0200
Message-ID: <41c33633-a6ca-4eb4-91ba-f2cd43600e93@pengutronix.de>
Date:   Wed, 16 Aug 2023 17:07:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] spi: stm32: renaming of spi_master into
 spi_controller
To:     Valentin Caron <valentin.caron@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230615075815.310261-1-valentin.caron@foss.st.com>
 <20230615075815.310261-2-valentin.caron@foss.st.com>
Content-Language: en-US-large
From:   =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
In-Reply-To: <20230615075815.310261-2-valentin.caron@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.goehrs@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 15.06.23 09:58, Valentin Caron wrote:
> From: Alain Volmat <alain.volmat@foss.st.com>
> 
> Preparing introduction of SPI device, rename the spi_master structure
> into spi_controller. This doesn't have any functional impact since
> spi_master was already a macro for spi_controller.
> Referring now to ctrl instead of master since the spi_controller
> structure might not be used as a master controller only.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>   drivers/spi/spi-stm32.c | 154 ++++++++++++++++++++--------------------
>   1 file changed, 77 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index d6598e4116bd..5d9439ae1c09 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c

<snip>

> @@ -939,13 +939,13 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
>   
>   /**
>    * stm32_spi_prepare_msg - set up the controller to transfer a single message
> - * @master: controller master interface
> + * @ctrl: controller interface
>    * @msg: pointer to spi message
>    */
> -static int stm32_spi_prepare_msg(struct spi_master *master,
> +static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
>   				 struct spi_message *msg)
>   {
> -	struct stm32_spi *spi = spi_master_get_devdata(master);
> +	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
>   	struct spi_device *spi_dev = msg->spi;
>   	struct device_node *np = spi_dev->dev.of_node;
>   	unsigned long flags;
> @@ -984,9 +984,9 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
>   	if (spi->cfg->set_number_of_data) {
>   		int ret;
>   
> -		ret = spi_split_transfers_maxwords(master, msg,
> -						   STM32H7_SPI_TSIZE_MAX,
> -						   GFP_KERNEL | GFP_DMA);
> +		ret = spi_split_transfers_maxsize(ctrl, msg,
> +						  STM32H7_SPI_TSIZE_MAX,
> +						  GFP_KERNEL | GFP_DMA);
>   		if (ret)
>   			return ret;
>   	}

<snip>

this patch introduces a regression when transmitting large SPI transfers with
a word size != 8 bits. The regression is caused by effectively reverting commit
1e4929112507f ("spi: stm32: split large transfers based on word size instead of
bytes") by changing the call to spi_split_transfers_maxwords() back to
spi_split_transfers_maxsize().

I've sent a patch[1] that fixes this regression by changing the …_maxsize()
call back to …_maxwords().

[1]: https://lore.kernel.org/all/20230816145237.3159817-1-l.goehrs@pengutronix.de/
