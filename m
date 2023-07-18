Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05BA757399
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjGRGFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGRGFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:05:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC91704
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:04:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e6113437cso7131200a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689660293; x=1692252293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pi+9LyUJ5THFqcDKma4bfg7WT28WRPLEB3mh8U0f0MM=;
        b=OeTntWAywOZKB1oNuN09bvqBfrZtjS7cc7QIGJUknhN1nhL5lJ19pe39McNGzMdVZ/
         2baIcWl7oPCdNbURAO1uTmv1RiinIAN8PD7B6ag1lzndSNUxt+R+DfH4iCBqadpKtgbT
         3ctxeomdyA4m8WhUz1xdkGGou33FcCh55XLyHljmBFlCjG80tHLFeuVIJm9+edvSr6tj
         UIG4vzNTFil5SzLheRy5E0gYrOoOWarkETcV/fzkG3Y5Rkp5iVDifUEUNYDHtriW6iAS
         cg3hy1a/wmMLo5oVFovpfF9nRDIAFXg/O22Ckfv1LiEb0a5smXVleZ1SnmiWHzF2tZ34
         PmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689660293; x=1692252293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi+9LyUJ5THFqcDKma4bfg7WT28WRPLEB3mh8U0f0MM=;
        b=V5Dvkh+9Wfxp8MwNEuUT9tygHFJNViaU6g0AhfUjG2VRdDidyGZsv6pj4PN0u6pCkc
         hLywcJtwb/5t45Pzwo2s1s9UWh2zpBVIKDfmCUWu8ev1S2wKp0oPE2FA14+0+P0Dch+d
         0oZrzvGIGaljBhp8C3cA++FLLU562S6e7cxySZ59YoW8bPJJxCIX9BwMBgciWhPNOmvI
         zJYjypFJ4Ujklngg1UKRp7XO5hN49lpDzE26KUVL5NvoAfUQLm6fC2ym6KeKlAMQhLN0
         NkJBpNpCrcPIfHnvD3CiHkfhTJk74fmPQD7lzg3TWs70Bj55/7LXi36KJ88GyxsKzdFe
         DNDQ==
X-Gm-Message-State: ABy/qLZM1rZHC6PwAt+GZTdksQeImfhRXWViQuBL7TkfI6OSytmONQo6
        HuH+H31vooVq1kGqo81URvKBew==
X-Google-Smtp-Source: APBJJlHRVmfQeCVSCe7SzkfH922H82pL93UZ8ds+SivT/bPyeVwzM25IpfuKTfhihInE7zgo7TD1mg==
X-Received: by 2002:aa7:d896:0:b0:521:8ca5:6070 with SMTP id u22-20020aa7d896000000b005218ca56070mr4088823edq.33.1689660293228;
        Mon, 17 Jul 2023 23:04:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i19-20020aa7dd13000000b0051de3c6c5e5sm657685edv.94.2023.07.17.23.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:04:52 -0700 (PDT)
Message-ID: <4e546dbf-8f10-a27e-dd8b-052151ebf00a@linaro.org>
Date:   Tue, 18 Jul 2023 08:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/2] dt-bindings: pwm: samsung: add exynosautov9
 compatible
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230718034201.136800-1-jaewon02.kim@samsung.com>
 <CGME20230718034723epcas2p3913ad208c70659965b4ec204570aa0a1@epcas2p3.samsung.com>
 <20230718034201.136800-2-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718034201.136800-2-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 05:42, Jaewon Kim wrote:
> Add samsung,exynosautov9-pwm compatible string to binding document.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

