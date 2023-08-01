Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4673C76BBB7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjHARxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHARxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:53:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B455B1BF6;
        Tue,  1 Aug 2023 10:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F05461651;
        Tue,  1 Aug 2023 17:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F40C433C7;
        Tue,  1 Aug 2023 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690912415;
        bh=6zn7B+X9EKomLgs7vP1NQZpukGu6QMSoZShFNEZ12JU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g1vlSfu7nUrCLeSuZwoOJEom1imVZTRzjOuTma0XlTKCMMxWrR+ZYMERuoGghKRF7
         ZSIgUn3MooR257jkdQVKAyCidON9oDgsSAkor5f4S7T/y3aYbttwrDTS76yVohDZkY
         msW+4yRWeW5ZdlCYfKpRRQnf4B3WrXVmG345o64z5XGJnvvBXzbZnXelNTxWcWL9bZ
         f052zvMzmpveUlYGN/v4IJoyK8skoko8a2o23Xr0tjA0Z2UZDuWq208556NtYwfMo1
         B5/CMcEI5rA53bjpnAX1CdCb6API9ijU1gCqy8CM6dKHS+uIGromK7D3B06eaSwoxP
         4RE8piudZ7J8A==
Date:   Tue, 1 Aug 2023 18:53:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] iio: mb1232: relax return value check for IRQ
 get
Message-ID: <20230801185328.49dab901@jic23-huawei>
In-Reply-To: <9e18cf49a8bb581a84c3fa548ea577e2a3eb840d.1690890774.git.mazziesaccount@gmail.com>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
        <9e18cf49a8bb581a84c3fa548ea577e2a3eb840d.1690890774.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 15:02:10 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> fwnode_irq_get() was changed to not return 0 anymore.
> 
> Drop check for return value 0.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
Applied fiddling above so I don't ack and sign off on it because
that confuses me :)

Applied to the togreg branch and pushed out as testing for all the
normal reasons.

Thanks,

Jonathan



> ---
> Revsion history:
> v5 =>:
> - No changes
> v4 => v5:
>  - drop unnecessary data->irqnr = -1 assignment
> 
> The patch changing the fwnode_irq_get() got merged during 5.4:
> https://lore.kernel.org/all/fb7241d3-d1d1-1c37-919b-488d6d007484@gmail.com/
> This is a clean-up as agreed.
> ---
>  drivers/iio/proximity/mb1232.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
> index fb1073c8d9f7..614e65cb9d42 100644
> --- a/drivers/iio/proximity/mb1232.c
> +++ b/drivers/iio/proximity/mb1232.c
> @@ -76,7 +76,7 @@ static s16 mb1232_read_distance(struct mb1232_data *data)
>  		goto error_unlock;
>  	}
>  
> -	if (data->irqnr >= 0) {
> +	if (data->irqnr > 0) {
>  		/* it cannot take more than 100 ms */
>  		ret = wait_for_completion_killable_timeout(&data->ranging,
>  									HZ/10);
> @@ -212,10 +212,7 @@ static int mb1232_probe(struct i2c_client *client)
>  	init_completion(&data->ranging);
>  
>  	data->irqnr = fwnode_irq_get(dev_fwnode(&client->dev), 0);
> -	if (data->irqnr <= 0) {
> -		/* usage of interrupt is optional */
> -		data->irqnr = -1;
> -	} else {
> +	if (data->irqnr > 0) {
>  		ret = devm_request_irq(dev, data->irqnr, mb1232_handle_irq,
>  				IRQF_TRIGGER_FALLING, id->name, indio_dev);
>  		if (ret < 0) {

