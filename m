Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905817818FF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjHSKmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjHSKmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:42:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A0E1659C1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 03:16:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c136ee106so220106166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692440159; x=1693044959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdIuirefSx1BPzTeUZTmUG2GheoNdWtbM86n1SoSEV0=;
        b=r6QSLYT+OQuj79GrZJTT9vJZwVwFWNyiYLS35jM8XQAzls4ZidjKqo3XE7B37q7xY0
         aVTpm5XiZpK/P/KDRZvqEGx1clFnesPMRQKHDKTE3zY9PY9B4nNMwZmaRLt56Seu6ab2
         26cs+1hrFHx4hAqTDnFClI9Udcg8Y9TVnwjxI2fiqZzI40/fO82fKeXFRfp74Rdp5B/g
         gXNPhLAXPDmeQbceL/lbhh0zcXqp8lrOkLalPT+CN/w94BUIX9Ccc/Q5ZRPmRoJQyh4s
         cG5Be6REVcucqZMHr7bBg44F6lmS9J+YUdo6mjyFr3CYTLC0J71p/n7T+OHcT7IO3eh5
         Ca0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692440159; x=1693044959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdIuirefSx1BPzTeUZTmUG2GheoNdWtbM86n1SoSEV0=;
        b=BCWkj5uL/hTQ/HIjB2fkD4yTC3UqtJHDSwNf5lf49/Qb0i5NGJkhYGddS7Oums9FN+
         VBKgsoPpZcyNn0QFXmVVnHsxZgeqcuoowKsEfOxE+jy4ffxWX+DyRD1iBrnCq7BeQjjH
         y0YQq1UMyAj29WWic0R1GvqL9nilA3LAqOKZL+fyJWNcXU2gx7wb1DbUlOyek8OieVr8
         HPzDG5V0WYoV7sh2vZEvVwDIYgSNeAOG443WnG/Zx293GDNp1HFjATnh3pyFpPPMaNT6
         cyi7HGv9se17bolpenP4R9jkl/jd4IdLO5QDGJTOCOe7JtVocyZwdRDiPmkLrqJeJ/vG
         fdhQ==
X-Gm-Message-State: AOJu0Yx6KrXNfeyA9O3v0n01Q1mQjyQK2eGq68zTiyqEIoOTY07CbMf7
        97z174/Pjn0qbQTpYjNX/D43Fg==
X-Google-Smtp-Source: AGHT+IGe8g81n1uQKahgkBJPCWcocD1AFWqZDAUIlbISlaV75NpgBM8WNKA8nPtS9Uqat3y/fgm7LQ==
X-Received: by 2002:a17:906:30c3:b0:99b:f3ef:f084 with SMTP id b3-20020a17090630c300b0099bf3eff084mr1178608ejb.66.1692440159140;
        Sat, 19 Aug 2023 03:15:59 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id a6-20020a170906368600b0099bc038eb2bsm2452762ejc.58.2023.08.19.03.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 03:15:58 -0700 (PDT)
Message-ID: <7ec61967-c899-4ebf-abde-3c1c5576d54f@linaro.org>
Date:   Sat, 19 Aug 2023 12:15:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: pinctrl: aspeed: Allow only defined pin mux
 node properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230819010907.916061-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230819010907.916061-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2023 03:09, Rob Herring wrote:
> The Aspeed pinctrl bindings are missing an additionalProperties/
> unevaluatedProperties schemas on the child pin mux nodes which means any
> undefined properties are allowed. In addition, using
> 'additionalProperties' for child nodes with any name works better than a
> pattern matching everything with an if/then schema to select nodes only.
> 
> With 'additionalProperties' added, 'pins' and 'bias-disable'
> properties need to be added as they were not defined. A $ref to
> pinmux-node.yaml which defines the common property types was also
> missing.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Really 'pins' should have some constraints, but I don't know what the
> possible values are. Happy to add if someone can tell me what.
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

