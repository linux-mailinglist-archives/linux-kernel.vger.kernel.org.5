Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77DF7768F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjHITkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjHITkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:40:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE42130
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:40:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4b95c371so862475e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691610002; x=1692214802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0MWZFCqfx/bjsXZM126ESB1rX8vz7btWukyZvMmYhE=;
        b=bU/x6GLlXAyQ4Gaf+J4l4ZL7IP9cLCP8vrQypkDa+MQq4V8AVozvS1yCQ1SbD4Cecs
         /O0AJ9rtwEvpZxcickiEctbAIL7IbIXfwl1qcGFYr2tz3DqUtNqjsfIi694ZggDSJQjK
         56BwH4fos0NoYx/wWTXY9OPOv9BLZsRCY0p3iGWIxVODeEEHYkf+KKdEajfber/EaXdP
         +aiahjGvuMSw/EkEqVFmUa3w7x5C+xZ5Vio+j6f1LwkNCh5+qVSXM+2V311GYPDJQveE
         dtlBfoG48CAh4xSFC8Jb+OX47SAgDYKEpRXuNFeomWeojrlw3nYob/4JJbTLm4TQX7cM
         t1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691610002; x=1692214802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0MWZFCqfx/bjsXZM126ESB1rX8vz7btWukyZvMmYhE=;
        b=FZTQar2PCqyIePv7E/QiE4r/5IlrLpf7QKu4bHfpfdUhtOB/cmfa1Nmp28yVdOvlI0
         Iq1VdZEdGAXH8u8Ne8/AAzvfqsAydRAyi1SrXSuyekZ4rwa0SY2Gt/6nuk+oNL9bi5PH
         QlFMDBaD6960wgKR72yONVzPd26H6pHC82TSN3LucHpXwKjhTPyEd7892ZjFr96vFG7y
         8cjQ1Wz8/WFNIHBvQhMdLIDYC28W6kviMAkJ8sRuPzYJw/osFUkBNGgXzPc5td9tEULl
         jWkW/qj0ihD4oMZdHLM2Bf5o3Tn/YFzCjw6lP8TXMzNU939JtDO//FbSLhZiF6pkfSS1
         zrAQ==
X-Gm-Message-State: AOJu0YxdRE24khTAsRwtBLXYRWtgzVt4Zk0NqjaseQx4YLblCTchrp+B
        idRsAr1Wh4ASiDVRuJNJdWIdlg==
X-Google-Smtp-Source: AGHT+IFzxETQwp3zarbyF6opul9wAOg3gyCVMzKze6pDmDH12Tn4tuRyHeXKvy+JB7RhOor/Zi8Ifg==
X-Received: by 2002:a05:600c:3d08:b0:3f7:ecdf:ab2d with SMTP id bh8-20020a05600c3d0800b003f7ecdfab2dmr310815wmb.20.1691610001729;
        Wed, 09 Aug 2023 12:40:01 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z1-20020a05600c220100b003fc01f7b415sm2798855wml.39.2023.08.09.12.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 12:40:01 -0700 (PDT)
Message-ID: <e3b3b347-88b5-ab58-b7d4-3963e2c3b726@linaro.org>
Date:   Wed, 9 Aug 2023 20:40:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RESEND] tty: serial: qcom-geni-serial: Poll primary
 sequencer irq status after cancel_tx
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, bjorn.andersson@kernel.org,
        konrad.dybcio@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, bartosz.golaszewski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com
References: <1691583100-15689-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1691583100-15689-1-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 13:11, Vijaya Krishna Nivarthi wrote:
> While at it, also remove a couple of redundant lines that read from IRQ_EN
> register and write back same.
> 
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
> Signed-off-by: Vijaya Krishna Nivarthi<quic_vnivarth@quicinc.com>

The "while at it" should be put into a separate patch.

I wonder if the read/write cycle is there to ensure an io-completion ?

Either way please break this up into two individual patches. One thing 
changing where you poll and the other removing the read/write cycle, so 
the changes may be evaluated individually.

---
bod
