Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0075769BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjGaQLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjGaQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:11:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806501713;
        Mon, 31 Jul 2023 09:11:30 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-790aeee9928so29127039f.2;
        Mon, 31 Jul 2023 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690819889; x=1691424689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9iuJhq/36gCoOCCdsYtCIZ6rv3DZuQfNvhN+0POUpQ=;
        b=CyFa9Y/8RTYcGZujl2crRafJPcB+RNWsS2OR+GiLYm0ncsMdmfcSULm4OBKgXSuMKY
         pWVzd43SJ8yxme5ox7VYOjFuAlNNcOfdxIiIYKfTbczkiU1kaTU4tSUT3ZLY8Yp7hfAb
         5qn9UXb6tJyXOyTaZN8VKwSuPIsMxSWA2Z9QgULUDi549DS8f5e4vz/NFNqKh5UqDUtM
         cnwaA4HmMMhxwz/21wekDVcUUE1TcEDUI73kX6ZkNMTDRN9jJRLRLo3XNt5aQTZimrhO
         FYsh8CgYcZgedTYBPWRUv1y8QisO/b/3TJ+fj5wG480p5gpUY2p9YVVHUGdSV6B+TF0K
         0HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690819889; x=1691424689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9iuJhq/36gCoOCCdsYtCIZ6rv3DZuQfNvhN+0POUpQ=;
        b=lFzsaZjFyp85EdpmhOYuMgypX+KJJQfVvYBGytkVLaaYZz36Fg+tKeom9id31rdICY
         K7sJXV6yOppoUR8G92RWTBCv2CV6rRR1MYMhdkY3a3d4kd1xnGRU68iYv5ac0Tfre5Cg
         nBduUQ9e33fIlyiu/ynraosETjSixywnIxsiDi2PoeAR2cT+3Kgy6Y5RdErdf9f58bTT
         jspYqWoYipnPV6+MBSKYv9DkzYpGLYrS3ukqtT3nmFsdDcPE86hV0x2xQsvlLzyhS4kM
         mNSYKQ/dLwzhxIcQFCP6Z6XtJDm8I3Dx7DFATLla50DMYIecUZ4AQscXsSr3mYtIxeHn
         s0Ug==
X-Gm-Message-State: ABy/qLYYdWbd+XLn0okyU0Yq7BKa+gRuDhwgWMryGtNAhezux8tD8LWW
        84i5b14eQ5xPSgv82X3c8J4=
X-Google-Smtp-Source: APBJJlHIipyHVtbyZJsyi9r7LQoaAh+v2WarC2Clpl8pvA2SCnMNdywJBGZyEdnddRGTpMFrKkBpBQ==
X-Received: by 2002:a6b:f80c:0:b0:77e:3598:e516 with SMTP id o12-20020a6bf80c000000b0077e3598e516mr8593859ioh.2.1690819889456;
        Mon, 31 Jul 2023 09:11:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y3-20020a02c003000000b0042b320c13aasm3167751jai.89.2023.07.31.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:11:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 31 Jul 2023 09:11:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>, vadimp@nvidia.com,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD
Message-ID: <0a332f45-35e0-4db3-9545-0a8f7e9bd435@roeck-us.net>
References: <20230731092204.2933045-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731092204.2933045-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:22:04AM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> MP2973 & MP2971 returns PGOOD instead of PB_STATUS_POWER_GOOD_N.
> Fix that in the read_word_data hook.
> MP2975 might be affected but needs verification.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied, after rephrasing description to indicate that MP2975 is likely
not affected. Also added Fixes: tags.

Guenter

> ---
>  drivers/hwmon/pmbus/mp2975.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> 
> base-commit: cb7022b8976e3c4d12cea2e7bb820a2944e2fd7b
> 
> diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
> index 28f33f4618fa..27bb39370662 100644
> --- a/drivers/hwmon/pmbus/mp2975.c
> +++ b/drivers/hwmon/pmbus/mp2975.c
> @@ -297,6 +297,11 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
>  	int ret;
>  
>  	switch (reg) {
> +	case PMBUS_STATUS_WORD:
> +		/* MP2973 & MP2971 returns PGOOD instead of PB_STATUS_POWER_GOOD_N. */
> +		ret = pmbus_read_word_data(client, page, phase, reg);
> +		ret ^= PB_STATUS_POWER_GOOD_N;
> +		break;
>  	case PMBUS_OT_FAULT_LIMIT:
>  		ret = mp2975_read_word_helper(client, page, phase, reg,
>  					      GENMASK(7, 0));
