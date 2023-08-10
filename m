Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AB8777718
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjHJLdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjHJLdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:33:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDEB2694
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:33:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso7267455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691667185; x=1692271985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCTwr/RVCGoszSXddEUdfx1O0WifeiqiEgEcr9ECasQ=;
        b=IIHGWbSZ1ejCYiSRvqGh4bfzAois9X59DkIZVAKv14+kXyl2KDFmmEjo4vXZYjkw2k
         0ZwchPRpqzPnvNH6rRdm1WH6fOyEtC7l4jFjGmzgrBhECAh68++mZU3ho8g7fos8hnlW
         2yb1Y9A2aQCTlgx57GtTMuIjuzLlY1ZG9fTFI0spKWajE7tbDGESP/C3EsWLj9swEUzF
         T172l/DHuQAqfIuD277B3oDhJEh78nPSdVBoZtjHBAaB52Y1d9nmxoAqKxejmJRN/AcO
         eordFPLHl5hn9i7ulD5c3yGSJVwPIZxNGkn12WFvF5GLlM7GilhhFiPg8ikjZUKjsALt
         K+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691667185; x=1692271985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCTwr/RVCGoszSXddEUdfx1O0WifeiqiEgEcr9ECasQ=;
        b=AnepmEeVDePjRluE25vrYjle5R3pOezLhM4hwzFTWEQr5VPjNKLsLle3YYccUvQbdM
         4ecRkRAeF5SnyHODX6pBcceg5x85j0XIeOKZ/rcZvtFTDEmdVGp8aay2GeANg26ZZtTK
         wX13Hhd8vOOVWta2bBUbqwuLQjKhzkads4OF2BTUKCHPPdwxkGkjPotjLh49iis2gMII
         N+CpcQiy8ztUMNXQIruuFZL8hoAneRrB0q/FqDArif7UHq5zKWQfYhFfKrxhJ5aNyhTK
         Kjq9QvN4cmjFNj1d3Xaes21lSxRhS/kD4xb0up55Ex/vIviiCnE5BM17VPz3LTtnvKp/
         dHVA==
X-Gm-Message-State: AOJu0YxUbb9BM6Rh95q7OGo3Ju/Ypq4Hyi2BdGx9atiubamT2M7NdwE4
        /dJ1Ih1C2/EYPvBOBW4+hbl7hQ==
X-Google-Smtp-Source: AGHT+IGSkS/oszYotJ3+uTNE38wjfUZxnENSkluTysbX1quYhadAuP5DDYRYmMs7uFKh09EBJFBpzw==
X-Received: by 2002:a5d:4683:0:b0:317:5182:7b55 with SMTP id u3-20020a5d4683000000b0031751827b55mr1925007wrq.42.1691667184827;
        Thu, 10 Aug 2023 04:33:04 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d6b8b000000b0031417b0d338sm1868735wrx.87.2023.08.10.04.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 04:33:04 -0700 (PDT)
Message-ID: <fec4a8c7-206f-7af8-4ea9-c919a677bf7e@linaro.org>
Date:   Thu, 10 Aug 2023 12:33:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/4] venus: hfi_parser: Add check to keep the number of
 codecs within range
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, tfiga@chromium.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-5-git-send-email-quic_vgarodia@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1691634304-2158-5-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 03:25, Vikash Garodia wrote:
> +	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
> +		return;
> +

Shouldn't this be >= ?

struct hfi_plat_caps caps[MAX_CODEC_NUM];

---
bod

