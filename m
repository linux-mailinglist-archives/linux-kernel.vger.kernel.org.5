Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653587DC649
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbjJaGKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjJaGK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:10:29 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501DF7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:10:26 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1e10ba12fd3so3528164fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732624; x=1699337424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/S8bL/PW+OULKVk4TUEtn6xyrgMH3q6hQoGIN5H6Rug=;
        b=a+OpBEhFH7InqMrLIHVCglyvl2WZ8jRFmWdKLTNkOQTylFkRqNUdey1c/ZS/a4W0hc
         uGtkG/nL5KTLwYNdYZxvkEyvpcCqalFf1QAnyRLW1sSW06idAkxvKE5xFT/77qpYRBd9
         qMGAAZ64BydeScSjkl1DjboAa6uuQWYUIIxSCKPBupjzS9sS8CoSKvSGVLXVZisD7/8Z
         WFFIUpfTXW5o/MVO65s7zZd1By1ed0P89KqqX9v7Rr5+yTCKj0UCewKKlvYWAOT9HqTd
         WNvtKtUnkux6vYtMdVHcSLoLZNfJpRS8HOpFubEXfOnMya+01v3Qd+Smyl3p6hHhFADo
         2KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732624; x=1699337424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/S8bL/PW+OULKVk4TUEtn6xyrgMH3q6hQoGIN5H6Rug=;
        b=UHEOUUtIQyF2QXrOxPL2yiiL48T1zSnWuvAlXH0DmhN1mWyAuRJiewA2t6fCosm8UN
         NtyETJx36Tu/Twm8Qh8Ao47VKQWnn0YpGL4L2vlLrCHmv9vqN0pSyGyzAoL5QtD2TJCg
         hv9lZ8onZ5C6kxwdPR2me9PCoFSGZ5oNHRYdORywU9f7K0cTJnFbhqIC8Jp9asHNZX4w
         qVbrpAeLmbOR+I8gULUVc+EGEC6n3EMzn+T8ImH/5Ncg6GKNvhljG6YN42IVEmOB6bV3
         wyngPnh1pDVIW3PPvbOogx3ZirT46Zi6sNHVzGXJNQOolA8Ei980Xumi3tdqNovsxuoQ
         NgdA==
X-Gm-Message-State: AOJu0Yx9XEb2yu+WuzcHAGyzXitOqthtFkklhZnuvHgcq8pok1Mk7BZI
        zY8MY88cwkTjaUeD9Gss3O1k+FqVKXU6ew==
X-Google-Smtp-Source: AGHT+IHolX+jISwQUN4bORpacho7ZCaCpMy5yAIhXDyOw03NSeOivnnNb5tXnC9lBCXqBO6fIlbF+w==
X-Received: by 2002:a17:903:20d4:b0:1cc:2dad:7ae9 with SMTP id i20-20020a17090320d400b001cc2dad7ae9mr9049442plb.32.1698732095979;
        Mon, 30 Oct 2023 23:01:35 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902da8100b001cc307bcdbdsm464552plx.211.2023.10.30.23.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 23:01:35 -0700 (PDT)
Message-ID: <cb2f4d8e-727f-4f07-82c7-52071ffd7135@gmail.com>
Date:   Tue, 31 Oct 2023 11:31:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: BeaglePlay driver needs CRC_CCITT
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org
References: <20231031040909.21201-1-rdunlap@infradead.org>
Content-Language: en-US
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <20231031040909.21201-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 09:39, Randy Dunlap wrote:

> The gb-beagleplay driver uses crc_ccitt(), so it should select
> CRC_CCITT to make sure that the function is available.
>
> Fixes these build errors:
>
> s390-linux-ld: drivers/greybus/gb-beagleplay.o: in function `hdlc_append_tx_u8':
> gb-beagleplay.c:(.text+0x2c0): undefined reference to `crc_ccitt'
> s390-linux-ld: drivers/greybus/gb-beagleplay.o: in function `hdlc_rx_frame':
> gb-beagleplay.c:(.text+0x6a0): undefined reference to `crc_ccitt'
>
> Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ayush Singh <ayushdevel1325@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> ---
>   drivers/greybus/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
>
> diff -- a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
> --- a/drivers/greybus/Kconfig
> +++ b/drivers/greybus/Kconfig
> @@ -20,6 +20,7 @@ if GREYBUS
>   config GREYBUS_BEAGLEPLAY
>   	tristate "Greybus BeaglePlay driver"
>   	depends on SERIAL_DEV_BUS
> +	select CRC_CCITT
>   	help
>   	  Select this option if you have a BeaglePlay where CC1352
>   	  co-processor acts as Greybus SVC.

Thanks.

Reviewed-by: Ayush Singh <ayushdevel1325@gmail.com>


Ayush Singh

