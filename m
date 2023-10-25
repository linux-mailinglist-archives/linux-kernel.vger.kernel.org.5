Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205D97D71E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjJYQvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYQu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:50:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC021137
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:50:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32db188e254so4070200f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698252652; x=1698857452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZYImk/mXSSi+o4l71ADu1/FnBpFWcH0X2+sMWjIFRg=;
        b=fqU0ebeOVrFibfPJP3j0RdJ+BWZ9RpRksNhJXIkjJi5xdbeGxAAaZBMokHGiTIl129
         c6XXHHC2crBd0H/qbVKCvH7Y7wxWLu+6ek/IPrIU4+/oFZdhvdhZX3U68VdQGSiwS4Cl
         7TNcaFlp5FNs8aWD2XTxDbPCugGUZaMXe2ujJnxvHWJ4XEEzDiMFA1Q2ymsQRS5sMbug
         u85Vitqbm3mTodoLZ8qyVdCqcsUB2WLu7wsFl/+SkvY6huv5FLLXvggY7W8GXkYZbHf+
         7tYA06jY97v1X+GjSVxdcRH5p61780TupB7cj/6DmWzANmCLvkaZRbzDVfe8bJgFiriE
         p9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698252652; x=1698857452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZYImk/mXSSi+o4l71ADu1/FnBpFWcH0X2+sMWjIFRg=;
        b=cnuzyoP7cO4Ifro3lkPSRc4Mq6qaGt25JMSnAhy3+ABlaLIIPtB4vFHgx3S/OE3+nU
         4vYmD88ozTV88+d3Q3tel58sMbSECx4lpeHhgJexgMb56dMvdeRzgBPAI7GKHcRqbSw5
         rBeArY0vDJLzvqPCSsxR0dNoKBQx1kesOg2iowG9r9XJh77YzEdrbcANA6V/KSKcdyZ2
         nhx/y3A1xd4EHzgGaI0cxcgoOt2k1YfKCPBT1nVYM+ODZlGr3CsVwcPX7q+rvjspYfxu
         D9YnDFB+kbCd2NOfDrf7/6QNOY08WU4oJu5VzF8ih22cdhb70UfJtWnlhbM696eBsnqt
         0xVw==
X-Gm-Message-State: AOJu0YwdXJ68hr//0/geHWiGXEv4ltQLdFM6S58vMGVdRsyPfIgAQgYf
        ypxVAHoNi69kChXHdxs9LZl0ig==
X-Google-Smtp-Source: AGHT+IEQCFBk5Dxw5dhzmiY5H20nvQe5QOzfRpA8EQpGFtUhVqOtnnudYdGdu3Qw92qf1Qf1whdYXg==
X-Received: by 2002:adf:e58f:0:b0:31f:a0ab:26b5 with SMTP id l15-20020adfe58f000000b0031fa0ab26b5mr12193613wrm.8.1698252652187;
        Wed, 25 Oct 2023 09:50:52 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id a3-20020a5d4d43000000b003196b1bb528sm12374109wru.64.2023.10.25.09.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 09:50:51 -0700 (PDT)
Message-ID: <03f6d583-8324-4ea2-ac6d-5e20987133e9@linaro.org>
Date:   Wed, 25 Oct 2023 17:50:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: llcc: Add configuration data for SC8380XP
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, neil.armstrong@linaro.org
References: <20231025134632.10363-1-quic_sibis@quicinc.com>
 <20231025134632.10363-3-quic_sibis@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231025134632.10363-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 14:46, Sibi Sankar wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Add LLCC configuration data for SC8380XP SoC.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

LGTM

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

