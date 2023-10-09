Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77BE7BEAF2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378499AbjJITxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378511AbjJITxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:53:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252B1DE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:53:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c63164a2b6so43536205ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881179; x=1697485979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csxmouwm4ofhF5cKOMzE27Rri8PFeo+HUVsFVEvzccY=;
        b=Hz72/ybIP9jC9mxMUf4UTw0Bz5TIm09QLh8Oderyl/tI5IWU7LmDFO23VtiM40zZ3a
         6x0xU4XZzONefqEbO4hFd2eXBLLN41vgGbTWirfGxbTZ9YaiH9PSihBY0con9XQsHMPa
         UbKwdi+elRJS4YyddjSuj+pNpyfB+JruVO8x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881179; x=1697485979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csxmouwm4ofhF5cKOMzE27Rri8PFeo+HUVsFVEvzccY=;
        b=wYTruGOqB5FWjJ9zKlUd5DaRtkyk2+64bTPPV5oK/EmeLzyCyjOHcPiyhbOoGvDUJK
         UBhY6buu1gN0E9HJQe2icKJcNVbiKOdOP0eXwbfwWnD1bhImuHlmtJCY5wg9SARMvckb
         MSx5IVxTH5IYLuRweL7YxXCZbDhScA3POqh0vj9hmYGA3CkRQjd7OZwqmQ12WEnoRfGX
         PXWosLXBzRaWGDtUJ7y/EV8ZO2RiyfTAQ1Fpdbe8A9z97dMQBXJxKbh+CkhapbO9B7LS
         TkbuyJHBwpYi3LfnVXw4HZM4stMaqKxqQRGzoO3t6Ah288DxXxZGdH+qO68AMcfZZ2Sl
         MgVA==
X-Gm-Message-State: AOJu0YynY0ofBoGnM2mD6FeL9ZQhoxGZRs7aMYc8ZivAypyooEkQ2ACy
        odMvHxXLZe+0lGjzRLShpVMdjw==
X-Google-Smtp-Source: AGHT+IH8+Ntc+mkBfEJvhkMQnUhAYyhOXnvDI9W+fGYDOJ7tdwlzxtrOGtqb7aH6TTdMvZXTN2zj5Q==
X-Received: by 2002:a17:902:c404:b0:1c9:9fa6:ce5b with SMTP id k4-20020a170902c40400b001c99fa6ce5bmr4306363plk.16.1696881179581;
        Mon, 09 Oct 2023 12:52:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902e84500b001c3f7fd1ef7sm10043902plg.12.2023.10.09.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:52:58 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:52:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: venus: hfi_cmds: Replace one-element array
 with flex-array member and use __counted_by
Message-ID: <202310091252.660CFA9@keescook>
References: <ZSRJfRdUXQOzagKr@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRJfRdUXQOzagKr@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:42:05PM -0600, Gustavo A. R. Silva wrote:
> Array `data` in `struct hfi_sfr` is being used as a fake flexible array
> at run-time:
> 
> drivers/media/platform/qcom/venus/hfi_venus.c:
> 1033         p = memchr(sfr->data, '\0', sfr->buf_size);
> 1034         /*
> 1035          * SFR isn't guaranteed to be NULL terminated since SYS_ERROR indicates
> 1036          * that Venus is in the process of crashing.
> 1037          */
> 1038         if (!p)
> 1039                 sfr->data[sfr->buf_size - 1] = '\0';
> 1040
> 1041         dev_err_ratelimited(dev, "SFR message from FW: %s\n", sfr->data);
> 
> Fake flexible arrays are deprecated, and should be replaced by
> flexible-array members. So, replace one-element array with a
> flexible-array member in `struct hfi_sfr`.
> 
> While there, also annotate array `data` with __counted_by() to prepare
> for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> This results in no differences in binary output.

Thanks for checking!

> 
> This issue was found with the help of Coccinelle, and audited and fixed
> manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
