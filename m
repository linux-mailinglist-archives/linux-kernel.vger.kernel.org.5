Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2B789BFA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjH0H70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjH0H6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:58:55 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBD2DC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:58:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so4715568a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693123130; x=1693727930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzHei1g5YcSQyHI7e3WpJcQQ0IiVSLaR8OHizgTz2sU=;
        b=NuyQFG2dWALVm9IlA6RPXxpye1iubdJRrWzysgAFBx/BVK3KOKkV7hAN92wbVpswjS
         h6qSMZVbNdpWu7sBmD6Dj/G9W+Vmy9qCIEel4JiPHTrNt4SlRp4sRkGE7ErztcOzvhG9
         ivW3te4QF6anSPrsQlxZeenilLkT2V2Q8Rh4216XeEWQevJ4LfGGmithk41G1MKqHSja
         WEUC0pSDTGBY/fDKYpa2pnAvASbelWfKc0XhgDos3S520RvgG66nBoQZnNcMndoHYckD
         pcuGIZdFOvha3da1TrwAzEHiDYABiP/5ypp03pqMeCJMQwAqo7vFXNSL9hCXLmOci03Y
         5DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693123130; x=1693727930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzHei1g5YcSQyHI7e3WpJcQQ0IiVSLaR8OHizgTz2sU=;
        b=ZtrTKPvbmtLhZdm5r+iSqcNZWZ45W9Ilhu4hzlhB+irCALSUKj2NmfPlIw0B59M+sf
         3t/Pi4H0qLoLTazgguc65xJ1Jxf6N34OgJW48TTuuKBhuXUbEJruXeL4B4lf5V7+yEMe
         oRBPPVjRHGyOWn+HEb5Kvfojo2vZml+GenM4Ps4Qn/Qgpq+7wVGF8UsFa3LA9+kPwkAN
         HCZEicmWNTO/bFr1fTFMLtUeGcgZxczstFveOSeikKqKbCQYGPf7OjcnTOS0Awqvck0y
         Cjf9lys+6a3ozxqwLHEXa1WpGA0u8nx4VpD6qTfiOaHtBqjWi2ooBL2oOhuGPPQ73Qvg
         Errw==
X-Gm-Message-State: AOJu0YyCHZPnBa/A6GRMVOb0x7xPFZYNQnX30eYNHPiNBW6tWGPAXbQO
        MtK45RcOMxCsTuL62mo9vw9AjA==
X-Google-Smtp-Source: AGHT+IEScLBkcO8pNEPy/rMoZr5psWXGID4i8adwolALGUX2Z3hUeYCGx1OSe5h3fjCoxnJc0gD8KA==
X-Received: by 2002:aa7:de12:0:b0:522:3149:159b with SMTP id h18-20020aa7de12000000b005223149159bmr26594190edv.2.1693123130231;
        Sun, 27 Aug 2023 00:58:50 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id n25-20020aa7c459000000b005259dd903e5sm3023822edr.67.2023.08.27.00.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 00:58:49 -0700 (PDT)
Message-ID: <f425912e-e2de-2015-cc16-0631a1fd8abd@linaro.org>
Date:   Sun, 27 Aug 2023 09:58:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V2 1/3] ASoC: dt-bindings: fsl_easrc: Add support for
 imx8mp-easrc
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230827023155.467807-1-aford173@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230827023155.467807-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2023 04:31, Adam Ford wrote:
> The i.MX8MP appears to have the same easrc support as the Nano, so
> add imx8mp as an option with a fallback to imx8mn.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

