Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B914C758037
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjGRO4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjGRO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:56:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73997A4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:55:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-997c4107d62so286518066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689692158; x=1692284158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pw8f3PCozhVO8mCD5Kz+F70idLqyfuW+XhCY0Pgna2w=;
        b=ry8PGhL0WICBLDKPxE0+dFrj2Apbz3aumRy7c3WR7ni4r8Azlv6+KgSYIeassFDCv8
         kbWpicaXkhPG0UiJivN21+pAKF+SZNQ3EQ4D/dcPLvTmrKPOPppY5eud0egRr9+BONiI
         mJAfTdeIcU9Un9nVa2HjABj4DK1NVl5i3+/McZPkCcx351sLrHYTZ7KwQ1ZYhqG5oeL6
         Pe3ieP7BCm2CmCee2uaGBh1LUQngqr8Mg3TbtjUC8ZqlPIie5K0ht6h+dnCfaGfaxjW2
         xefDeuYSMMrO/fC/lut7pfSDfVFJcCYiLAxwFSsV2acb+oUtdryDP4QfCRKRta4sEZ75
         iA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689692158; x=1692284158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pw8f3PCozhVO8mCD5Kz+F70idLqyfuW+XhCY0Pgna2w=;
        b=GCNCM7t5+I4es1uNDUJUJpIbtiCmZuVKuB2fGRVXcmPAYNSfoudvWhff6uReuW0CHK
         FGc0eR0amcsyzjODLr7XF+dn5xqkfzfPCMusbvwv9W/kR9PbbVTaKYOdo8jzWzWfrEFh
         L9v5fLwMiKPZwzuSxnRxyAgOF53nLDBgEbJ2WB57n4MVnBR+Xx/442i2DsQ1EkSNIw4Q
         YlsLoLOeaBgCHGgnUsqo5npVQLuWs3fkrKX17rop0JfAoIoRx0/lUDSburHQDCyOcd06
         GHbROug+wRGM7LmpEXIJvR8kSLd9Zi9VnEogHQth5aUTYJpDiLsoAjSRweylsa1khomH
         ysqg==
X-Gm-Message-State: ABy/qLa96Mmrtji8CjbAnZGOIYikX5k2AsQ142yIP5tR8OehTVBwJbNa
        snSbR97x2Qbtv+oCpJd1U2k3Pg==
X-Google-Smtp-Source: APBJJlEwRdrmoPHlHAu/PJZX/ODuVvf6e5FG7oKjANKlwDKsUrxOp+I4Vb9EeLTdvWpYZYQbUwhv5g==
X-Received: by 2002:a17:907:2ccc:b0:992:a90a:5d1f with SMTP id hg12-20020a1709072ccc00b00992a90a5d1fmr95221ejc.68.1689692157902;
        Tue, 18 Jul 2023 07:55:57 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id lh5-20020a170906f8c500b00985bdb7dd5fsm1091012ejb.201.2023.07.18.07.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:55:57 -0700 (PDT)
Message-ID: <e155a4bf-46b7-c07a-f3e0-80fae8108f56@linaro.org>
Date:   Tue, 18 Jul 2023 15:55:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] nvmem: core: clear sysfs attributes for each NVMEM
 device
To:     Daniel Golle <daniel@makrotopia.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <ZLaZ03PzkbPNJQ3b@makrotopia.org>
Content-Language: en-US
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ZLaZ03PzkbPNJQ3b@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Daniel,

On 18/07/2023 14:55, Daniel Golle wrote:
> Set nvmem_cells_group.bin_attrs to NULL in case of an NVMEM device not
> having any cells in order to make sure sysfs attributes of a previously
> registered NVMEM device are not accidentally reused for a follow-up
> device which doesn't have any cells.
> 
> Fixes: 757f8b3835c9 ("nvmem: core: Expose cells through sysfs")

These patches are dropped out of nvmem next branch as it was breaking 
some existing users.


--srini
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/nvmem/core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 6c04a9cf6919f..70e951088826d 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -458,9 +458,10 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
>   
>   	mutex_lock(&nvmem_mutex);
>   
> -	if (list_empty(&nvmem->cells))
> +	if (list_empty(&nvmem->cells)) {
> +		nvmem_cells_group.bin_attrs = NULL;
>   		goto unlock_mutex;
> -
> +	}
>   	/* Allocate an array of attributes with a sentinel */
>   	ncells = list_count_nodes(&nvmem->cells);
>   	cells_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
