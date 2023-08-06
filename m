Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB977153E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjHFNXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHFNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:23:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458E0B3;
        Sun,  6 Aug 2023 06:23:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68706d67ed9so2532007b3a.2;
        Sun, 06 Aug 2023 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691328232; x=1691933032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFy9i322sOQx8+EXEqZM+C720OychdWRKaaq1jrom80=;
        b=rg99jTykmU8n71TW8MC0uuJCkF9j+nfsXHa68Xgi/5oWP4osaY2bB9Y8TIOurLkATP
         RN1zzM9xh5wOptdRe/IXBf6W7YnDedngX3T4OtlZFBvxuz/8InwwdNqLUc8shamxgVJN
         Vaa7sLEkzWwgFvvQB44JuGaoYgw7eWGpsjWDho/Ngd2tttgwkCBNkUYA9PcAxMtzzWG8
         2EM3Ci36cRHFZI/Blf/vPiMnMHvsX/NX3n+MIJ5zSz3b7ESspmxp9x/mhgYMdYFyQCbw
         8hP+1Lc23lrj15QiLqD4LgP2i7nrcUL4tt6KawJ97UijmEEqwwEBAZ2Sc35ifUezcY1F
         hKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691328232; x=1691933032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFy9i322sOQx8+EXEqZM+C720OychdWRKaaq1jrom80=;
        b=UBaACxCXd4Wg2ysHTiXR/Af0sFiaYrcb772FKTH79eF61s58gcDcJJgXafou7Msgcm
         e7VqVzicUGCD4Apb70ScrL8s89AV+AiGI3NPZA70tNjFepX3wg34biBOYO8PivsA1ygS
         2UkfJlm8NxYU+Bleu7BLFJiYdcVArIxu4dFT2aAizaY61So9uwYdMDZ7yrXVyqrJ4Hs4
         ElaOrzf40hasj+k1G7GpVl/G9uRWqVad8blHpBaMrL5hTNSk9WY8cqK43HZJEatSWXfD
         PLonSx19AEBp7PYyuXzhFA+6TpUNqh0ih7JoAnjLIk/ih+cygpW32CjC+Mz9qpRZQRPv
         3UMQ==
X-Gm-Message-State: AOJu0Yw/22Knz9q4pS0SQ/unFoZ7SgW/VBKGSLMscmTCfWIxLemIL2rr
        +97eDM0r+IndVuFFJVJMGVhlJTwbL+8=
X-Google-Smtp-Source: AGHT+IGG4bJjl2qs/xmtMNiubyrhoVTb2A+J7ESIY7IyVMZv1WvoEETR9KRW25E2C1dXWZgL7b0jIw==
X-Received: by 2002:a05:6a20:1008:b0:13f:7c0e:dc6c with SMTP id gs8-20020a056a20100800b0013f7c0edc6cmr5710750pzc.38.1691328231665;
        Sun, 06 Aug 2023 06:23:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c4-20020a631c44000000b005646e6634dcsm3644145pgm.83.2023.08.06.06.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:23:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Aug 2023 06:23:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     rentao.bupt@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, taoren@meta.com
Subject: Re: [PATCH v2] hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK
 for pfe1100
Message-ID: <b14cb363-e232-4251-8ecb-1393634dfcda@roeck-us.net>
References: <20230804221403.28931-1-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804221403.28931-1-rentao.bupt@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:14:03PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Skip status check for both pfe1100 and pfe3000 because the communication
> error is also observed on pfe1100 devices.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Changes in v2:
>    - improving comments.
>    - removing unnecessary {}
> 
>  drivers/hwmon/pmbus/bel-pfe.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/bel-pfe.c b/drivers/hwmon/pmbus/bel-pfe.c
> index fa5070ae26bc..7c5f4b10a7c1 100644
> --- a/drivers/hwmon/pmbus/bel-pfe.c
> +++ b/drivers/hwmon/pmbus/bel-pfe.c
> @@ -17,12 +17,13 @@
>  enum chips {pfe1100, pfe3000};
>  
>  /*
> - * Disable status check for pfe3000 devices, because some devices report
> - * communication error (invalid command) for VOUT_MODE command (0x20)
> - * although correct VOUT_MODE (0x16) is returned: it leads to incorrect
> - * exponent in linear mode.
> + * Disable status check because some devices report communication error
> + * (invalid command) for VOUT_MODE command (0x20) although the correct
> + * VOUT_MODE (0x16) is returned: it leads to incorrect exponent in linear
> + * mode.
> + * This affects both pfe3000 and pfe1100.
>   */
> -static struct pmbus_platform_data pfe3000_plat_data = {
> +static struct pmbus_platform_data pfe_plat_data = {
>  	.flags = PMBUS_SKIP_STATUS_CHECK,
>  };
>  
> @@ -94,16 +95,15 @@ static int pfe_pmbus_probe(struct i2c_client *client)
>  	int model;
>  
>  	model = (int)i2c_match_id(pfe_device_id, client)->driver_data;
> +	client->dev.platform_data = &pfe_plat_data;
>  
>  	/*
>  	 * PFE3000-12-069RA devices may not stay in page 0 during device
>  	 * probe which leads to probe failure (read status word failed).
>  	 * So let's set the device to page 0 at the beginning.
>  	 */
> -	if (model == pfe3000) {
> -		client->dev.platform_data = &pfe3000_plat_data;
> +	if (model == pfe3000)
>  		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
> -	}
>  
>  	return pmbus_do_probe(client, &pfe_driver_info[model]);
>  }
