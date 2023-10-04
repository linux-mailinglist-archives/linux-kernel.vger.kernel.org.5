Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669377B8C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbjJDTJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245553AbjJDTJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:09:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB20100;
        Wed,  4 Oct 2023 12:07:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so32254666b.1;
        Wed, 04 Oct 2023 12:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696446440; x=1697051240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+NB0/fXI36YUbBB/KSMfWzVc1LficR5CBF7SRFmUNc=;
        b=DuOZg+MhjOI8CIukatGFo6nC9NvWn/nr+A9+f6mXBzMb9/q2cCxEJHoXb4MVX7aRCr
         wIvd5OUMrX7yZ5a0XGxHhOHZTq1i+XLzhwntLDApMV9xBx0m/yVUmzBelUevilDN2VeF
         nxdAVRKyhvU1xq6HmQEeqxeFQzxxX+6+miubIMH5X+cCpEQLvXzm8/ojsIPs5krDtkt3
         qbUDUADdSF1iDHNQtqkBDCYVXJAGRpltnSSLKr5CQIOJe86Z6lzjJhexBsDvKpdJL1n6
         0sUw/Gp1BOgO0EaW5KOFYyK6EqCFg/i2dCyg662EmZQ1D1dDZ1tgsZRX90fHFAqMX/10
         03/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696446440; x=1697051240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+NB0/fXI36YUbBB/KSMfWzVc1LficR5CBF7SRFmUNc=;
        b=dwUJeAOBHY3Ddgtlh6PgJRf1k36bLJA5+8bcf45Nxfow6ZXDcMxRANrl1D7nfYgmlq
         r/QsgyKvFcqr4daw8Zv3dn2rZoA9oUVJR1q/xiTD4jyY2VHrELIJs+C+rwnhzLaMiAT9
         YMk286Ze1EHAZ/zueWBCnqDgG0Rd9yYCy+bJOC9Xr2R+wYSt/OAKVVt0MGVzfvsfCRcr
         ZJKYHb1xWCb6IXIKiEFXPFyAlivAsxwnjDLUy2rQz9TmjWv93YmT1os02xGEr0vjkDMm
         SJuiG8Di7/kHqpua5RNv4MKtHbVbLvz0M4SCIq//+2pxCH5HnUwuCv6q7mDop5W7VKFN
         ik6w==
X-Gm-Message-State: AOJu0Yza2J3YerOKjgb7wZ0e7QJxLIkv4AlGu1zmpM0bJcKrz34Ivpjf
        ZtEccBeeiBrybE3yc18o8dY=
X-Google-Smtp-Source: AGHT+IGVNtEMmtiJBtuni1GTlcP/kqhQdjFnRkM4A+PYad68xhWjY0PMwLP46ZiQatuoSAHtkRQjqw==
X-Received: by 2002:a17:906:1dd:b0:9b6:582e:be6a with SMTP id 29-20020a17090601dd00b009b6582ebe6amr2591079ejj.33.1696446439906;
        Wed, 04 Oct 2023 12:07:19 -0700 (PDT)
Received: from ?IPV6:2003:c5:8703:581b:3b3f:c775:ae24:aaef? (p200300c58703581b3b3fc775ae24aaef.dip0.t-ipconnect.de. [2003:c5:8703:581b:3b3f:c775:ae24:aaef])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709063e5a00b009b2f2451381sm3208512eji.182.2023.10.04.12.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 12:07:19 -0700 (PDT)
Message-ID: <f9beb373-a6c8-ba07-f3d1-c72ecc058806@gmail.com>
Date:   Wed, 4 Oct 2023 21:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron
 eMMC Q2J54A
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20231001194943.658299-1-beanhuo@iokpp.de>
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <20231001194943.658299-1-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

Any comments on this version?

Kind regards,

Beam

On 01.10.23 9:49 PM, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
>
> Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
> operation be allowed only after a write has occurred. Otherwise, the
> cache flush command or subsequent commands will time out.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> Cc: stable@vger.kernel.org
>
> ---
> Changelog:
>
> v3--v4:
>      1. Add helper function for this quirk in drivers/mmc/core/card.h.
>      2. Set card->written_flag only for REQ_OP_WRITE.
> v2--v3:
>      1. Set card->written_flag in mmc_blk_mq_issue_rq().
> v1--v2:
>      1. Add Rafael's test-tag, and Co-developed-by.
>      2. Check host->card whether NULL or not in __mmc_start_request() before asserting host->card->->quirks
> ---
>   drivers/mmc/core/block.c  | 5 ++++-
>   drivers/mmc/core/card.h   | 4 ++++
>   drivers/mmc/core/mmc.c    | 5 +++++
>   drivers/mmc/core/quirks.h | 7 ++++---
>   include/linux/mmc/card.h  | 2 ++
>   5 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 3a8f27c3e310..dfa67d9c80bb 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2381,8 +2381,11 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>   			}
>   			ret = mmc_blk_cqe_issue_flush(mq, req);
>   			break;
> -		case REQ_OP_READ:
>   		case REQ_OP_WRITE:
> +			if (mmc_card_broken_cache_flush(card) && !card->written_flag)
> +				card->written_flag = true;
> +			fallthrough;
> +		case REQ_OP_READ:
>   			if (host->cqe_enabled)
>   				ret = mmc_blk_cqe_issue_rw_rq(mq, req);
>   			else
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 4edf9057fa79..b7754a1b8d97 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -280,4 +280,8 @@ static inline int mmc_card_broken_sd_cache(const struct mmc_card *c)
>   	return c->quirks & MMC_QUIRK_BROKEN_SD_CACHE;
>   }
>   
> +static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
> +{
> +	return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
> +}
>   #endif
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89cd48fcec79..47896c32086e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1929,6 +1929,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>   	if (!oldcard)
>   		host->card = card;
>   
> +	card->written_flag = false;
> +
>   	return 0;
>   
>   free_card:
> @@ -2081,6 +2083,9 @@ static int _mmc_flush_cache(struct mmc_host *host)
>   {
>   	int err = 0;
>   
> +	if (mmc_card_broken_cache_flush(host->card) && !host->card->written_flag)
> +		return err;
> +
>   	if (_mmc_cache_enabled(host)) {
>   		err = mmc_switch(host->card, EXT_CSD_CMD_SET_NORMAL,
>   				 EXT_CSD_FLUSH_CACHE, 1,
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 32b64b564fb1..5e68c8b4cdca 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -110,11 +110,12 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>   		  MMC_QUIRK_TRIM_BROKEN),
>   
>   	/*
> -	 * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
> -	 * support being used to offload WRITE_ZEROES.
> +	 * Micron MTFC4GACAJCN-1M supports TRIM but does not appear to suppor
> +	 * WRITE_ZEROES offloading. It also supports caching, but the cache can
> +	 * only be flushed after a write has occurred.
>   	 */
>   	MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
> -		  MMC_QUIRK_TRIM_BROKEN),
> +		  MMC_QUIRK_TRIM_BROKEN | MMC_QUIRK_BROKEN_CACHE_FLUSH),
>   
>   	/*
>   	 * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index daa2f40d9ce6..7b12eebc5586 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -295,7 +295,9 @@ struct mmc_card {
>   #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
>   #define MMC_QUIRK_BROKEN_SD_DISCARD	(1<<14)	/* Disable broken SD discard support */
>   #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
> +#define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
>   
> +	bool			written_flag;	/* Indicates eMMC has been written since power on */
>   	bool			reenable_cmdq;	/* Re-enable Command Queue */
>   
>   	unsigned int		erase_size;	/* erase size in sectors */
