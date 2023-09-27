Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831397AFC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjI0HrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjI0HrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:47:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C071ABF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:47:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4053cb57f02so93915985e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695800821; x=1696405621; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=aKQmixWBkQbfwrPWW4Kcl6BhuNloeHKy7RaNCIpQr2w=;
        b=RXX7PgNJaFediTXV0bNyeIN7D/4LArLxXLTGh/Xh8Oa7VDg2aicJs3p0Q8K+CGKrWy
         WFH4N1ONX4EMpZDc+BWGvpRCTstkLb/+FF17JMlYXcdRBnCrXYuiA6M2U9l4oA8waukq
         jYIXR57Gjg0XnHs9otSxQcFhhGWXyRHpIcO8gbUpoiVe7w7nOwqB/sEYPTgTbM8KF1MB
         LUz8IFeog2iA8z+uBMT0Hyx6LBdihddKPdyo1yzC2tM4MFbPSDiz98Rjx/OOuaGpJKni
         DaqMCDh7T2XaLd5OxF6IwN/w499ogncdn2XJHdf0XaWzBEmN4gJtwxr8tW/B5i50uAnT
         KSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695800821; x=1696405621;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKQmixWBkQbfwrPWW4Kcl6BhuNloeHKy7RaNCIpQr2w=;
        b=eLan0xcvpWLShrdM1hjPBnO+pi8l8yWW7Bji90HIT9lsBg4do/Ak7V1TxlBt6SjrSS
         aiKSZg5vMz+cbYvEHpmjGwAgm5hktGDRr6/fiKZY8c8PwN/sLRcy6/YFHkKXCeFhyKQd
         gZNqtfwX8v8MMyqSQAejXnTyAS4Eyc4inW3elbkolRCVye+MwEKJCQMlm3v1LOj303ve
         w58jdws5ZI6lLfkFdZjW5bjgqbYM1OMXKi/b/U/sR6vmvyDsJVf/e5Cc79yGyz7YgXwV
         PB3TL/vmdaoBxkXnUNZI/6nsSJvOW1oEiHkXAaUjZqto34PpUtb0zxqeSu5QHT4LqQSa
         74Qw==
X-Gm-Message-State: AOJu0YzN0TdvPjmpxZ3AKPbAuOKpuDurOqzs/WcJwnbli1RZNnKpC0uj
        QBEB7HmYzWGKgYh4uaAFcCZIMQ==
X-Google-Smtp-Source: AGHT+IGGmLNmRtPyNVhH3suncTUw2D0Z9IxkXxlJ+RvD02DQWvi3FRSkVOacLNW/OVVCbN0M32WHeA==
X-Received: by 2002:adf:f285:0:b0:323:1d06:38e5 with SMTP id k5-20020adff285000000b003231d0638e5mr936747wro.55.1695800820675;
        Wed, 27 Sep 2023 00:47:00 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:99be:56aa:a730:ad2d])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d50c4000000b0031fa870d4b3sm16429083wrt.60.2023.09.27.00.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 00:47:00 -0700 (PDT)
References: <20230927072544.764285-1-Rong.Chen@amlogic.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     "Rong.Chen" <Rong.Chen@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
Date:   Wed, 27 Sep 2023 09:43:57 +0200
In-reply-to: <20230927072544.764285-1-Rong.Chen@amlogic.com>
Message-ID: <1jr0mkkqh8.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s
On Wed 27 Sep 2023 at 15:25, "Rong.Chen" <Rong.Chen@amlogic.com> wrote:

> From: Rong Chen <rong.chen@amlogic.com>
>
> Setting bit CMD_CFG_ERROR has non effects on previous controllers.

Which previous controllers ? v2, v3 ? Can you list the SoCs please ?

> However, it will cause an IRQ and stop working on latest controllers,

Isn't it desirable to stop on error ? seems like a sane thing to do.

> This bit is used for selecting SG LINK of data address.
> Don't set the bit CMD_CFG_ERROR anymore to resolve this issuse.

I'm not sure I understand the actual issue being resolved.
Could you provide more details please ?

>
> Therefore, remove this setting.
>
> Signed-off-by: Rong Chen <rong.chen@amlogic.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 9837dab096e6..c7c067b9415a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -801,7 +801,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  
>  	cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
>  	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
> -	cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
>  
>  	meson_mmc_set_response_bits(cmd, &cmd_cfg);

