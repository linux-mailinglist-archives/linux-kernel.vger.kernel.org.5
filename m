Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787C4758D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjGSGGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGSGGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB88A1BF2;
        Tue, 18 Jul 2023 23:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A54F60CFB;
        Wed, 19 Jul 2023 06:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E259AC433C7;
        Wed, 19 Jul 2023 06:05:59 +0000 (UTC)
Message-ID: <1fe12cc2-0a9f-2a55-7c4d-95f49241c3c0@xs4all.nl>
Date:   Wed, 19 Jul 2023 08:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] media: dvb: remove spaces before '['
Content-Language: en-US
To:     sunran001@208suo.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230714080514.14297-1-xujianghui@cdjrlc.com>
 <ad3e13dcf101ff613c7fc72c99db8dd2@208suo.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <ad3e13dcf101ff613c7fc72c99db8dd2@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ran Sun,

On 14/07/2023 10:06, sunran001@208suo.com wrote:
> Remove spaces to clear checkpatch errors.
> 
> ERROR: space prohibited before open square bracket '['
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/media/dvb-frontends/tda826x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/tda826x.c b/drivers/media/dvb-frontends/tda826x.c
> index f9703a1dd758..7f17efe17d11 100644
> --- a/drivers/media/dvb-frontends/tda826x.c
> +++ b/drivers/media/dvb-frontends/tda826x.c
> @@ -38,7 +38,7 @@ static int tda826x_sleep(struct dvb_frontend *fe)
>  {
>      struct tda826x_priv *priv = fe->tuner_priv;
>      int ret;
> -    u8 buf [] = { 0x00, 0x8d };
> +    u8 buf[] = { 0x00, 0x8d };

This patch is corrupt: TABs have been replaced by spaces.

It's not just this patch, but all 7 patches you posted to linux-media.

Also, please mention the name of the driver you fixed in the subject.
So: "media: dvb: tda826x: remove space before '['".

Regards,

	Hans

>      struct i2c_msg msg = { .addr = priv->i2c_address, .flags = 0, .buf = buf, .len = 2 };
> 
>      dprintk("%s:\n", __func__);
> @@ -65,7 +65,7 @@ static int tda826x_set_params(struct dvb_frontend *fe)
>      u32 div;
>      u32 ksyms;
>      u32 bandwidth;
> -    u8 buf [11];
> +    u8 buf[11];
>      struct i2c_msg msg = { .addr = priv->i2c_address, .flags = 0, .buf = buf, .len = 11 };
> 
>      dprintk("%s:\n", __func__);
> @@ -130,7 +130,7 @@ static const struct dvb_tuner_ops tda826x_tuner_ops = {
>  struct dvb_frontend *tda826x_attach(struct dvb_frontend *fe, int addr, struct i2c_adapter *i2c, int has_loopthrough)
>  {
>      struct tda826x_priv *priv = NULL;
> -    u8 b1 [] = { 0, 0 };
> +    u8 b1[] = { 0, 0 };
>      struct i2c_msg msg[2] = {
>          { .addr = addr, .flags = 0,        .buf = NULL, .len = 0 },
>          { .addr = addr, .flags = I2C_M_RD, .buf = b1, .len = 2 }

