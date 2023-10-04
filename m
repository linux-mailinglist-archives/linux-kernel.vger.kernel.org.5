Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821DC7B8CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244984AbjJDTND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245671AbjJDTLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:11:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CB2199D;
        Wed,  4 Oct 2023 12:10:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4066241289bso1510365e9.0;
        Wed, 04 Oct 2023 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696446650; x=1697051450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTfZ0jAUK4N4Sk3VAwhje24Zb8gHtlaGWhfpDbGXJfs=;
        b=Dz5wGefEStr0F0+2IuAPbVW+rW4moWydvtXFU2lDMCnlc4VTL5AS5RI3Nm6t3DCPrT
         VO+7/pcxCWFiTCo6hIb6x88t0CbGz2DNKi8WUF+udK6i0Tr4RqRN7+QwdJHVKlUJIBcU
         +28883nQxrgGXPbnWWGPmXIBC1O7Z0I1liTu5xRZ4NYleLwp/Yj85H1ibwko0d3KbhhF
         pT/oxi8z/LO2BuwAcyCeDSYc8S1hbrYG4GwSh7NXQH/fOtIHlHV3xRy0ti3DEMbDxObY
         qzSFPmtGw5d4k9vm1/MbhaoquHc5TJ36sLdwO6XY0//8DJ9K01RTuQthKSr8QekZVhrz
         aAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696446650; x=1697051450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTfZ0jAUK4N4Sk3VAwhje24Zb8gHtlaGWhfpDbGXJfs=;
        b=WcEJZTpdAG+k5CxYAYmZISRjJKGvz159Cg83ye2vTvBfCrYt/RWpXHgs8UpnY8G+jO
         fONLYKdomAEn8ub5cIZEYreUUHz/zZ0y44me5/OJgvB8L9zD7DCNwoqETDVBi3t2pev3
         SrFTA6KBmij3lml9XDjM2sj7MOpCpDZhs0HsA5vPbtcM71n1nqM40WrD1JKVqFg4xbue
         Mr4PJMeyaBgIuq2qH2mtP4fXGXc+NSd9PBPQH497TjibEJplnlqUfhMRzaDws9rrfcC/
         DlNGA+2oxi83hMDg5yjYFuiKRMcETjwYUZmQsnW2pd6jcqnOvRAHNiwB9xl4euH1SDq7
         OlpA==
X-Gm-Message-State: AOJu0Yzr3p2jzbeVQ2ipDzX5W2Un9+bfA3ADMwKoXyHlGWyExqIRlhNK
        E4xGnYqM51QeRkJh4yqSEWo=
X-Google-Smtp-Source: AGHT+IFMNzPekvjGkugECc2AlNI4n9INyxPua5xpX8Fgx52IuCkzeF8SstaPUeXyg7/COCzk8cdBjA==
X-Received: by 2002:a5d:6091:0:b0:317:5747:b955 with SMTP id w17-20020a5d6091000000b003175747b955mr2576936wrt.17.1696446649516;
        Wed, 04 Oct 2023 12:10:49 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b004051f8d6207sm2221281wmo.6.2023.10.04.12.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 12:10:48 -0700 (PDT)
Message-ID: <25ba48de-2ab6-4a4e-a290-891398710931@gmail.com>
Date:   Wed, 4 Oct 2023 21:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: qseecom: add missing include guards
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20231004185732.98621-1-brgl@bgdev.pl>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20231004185732.98621-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 20:57, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The qseecom header does not contain ifdef guards against multiple
> inclusion. Add them.
> 
> Fixes: 00b1248606ba ("firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Oh, thanks for spotting and fixing that.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

PS: I haven't forgotten about your SHM Bridge patches. Testing those is
now next up on my kernel TODO list. Unfortunately, it might take a
couple more days until I can get around to do it properly.

> ---
>   include/linux/firmware/qcom/qcom_qseecom.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux/firmware/qcom/qcom_qseecom.h
> index b531547e1dc9..5c28298a98be 100644
> --- a/include/linux/firmware/qcom/qcom_qseecom.h
> +++ b/include/linux/firmware/qcom/qcom_qseecom.h
> @@ -5,6 +5,10 @@
>    *
>    * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
>    */
> +
> +#ifndef __QCOM_QSEECOM_H
> +#define __QCOM_QSEECOM_H
> +
>   #include <linux/auxiliary_bus.h>
>   #include <linux/types.h>
>   
> @@ -44,3 +48,5 @@ static inline int qcom_qseecom_app_send(struct qseecom_client *client, void *req
>   {
>   	return qcom_scm_qseecom_app_send(client->app_id, req, req_size, rsp, rsp_size);
>   }
> +
> +#endif /* __QCOM_QSEECOM_H */
