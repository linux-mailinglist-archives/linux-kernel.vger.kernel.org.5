Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8038768760
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjG3TUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG3TUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:20:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C7C10FF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:20:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bc512526cso604382766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690744837; x=1691349637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEjl0pvg9/j+6XvVJyhaHyc6KXkv2+mncGB6CY2cqjs=;
        b=DYozmKFWKJ242QP+Gyd1w5ixhTzmsRESaKU7tsKWuLc1S3XKsLdDDad4TXj+YQOhcs
         zLuU3oooEtmgLdpEHwBi0cfjmc/dW2/YMuzhUdUyRqrey9OQMXNcXh8MgufNg/g3IIjX
         YXrl7HwJ5mbUm3G8P6Udu7si07Gekyx9jwo/U7b8lr+2QURoxrFbgPwTr7lAR5PbRE5b
         7w/hoI1O8ZFptAz8X61TbBEKXNT07I+XLDrvxcLCeWtEYSS3gKv9uV5tYJN4tqHnETy7
         WA3atvRTG/oXlt9TGtr+1meqWGwc0IEpXZBGSg59ZJIOaczo0UMIlF3Ezj/rjkArFesp
         2g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690744837; x=1691349637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEjl0pvg9/j+6XvVJyhaHyc6KXkv2+mncGB6CY2cqjs=;
        b=lh3yEMpx3DbJAeq7se9tyYNap0L60zQ+2N8XQGVH3L47UGPuuL0sGb+FoDwYZh/oVV
         ZVUsGLtqKAM0xgxx2ux+nW0oUV0Arpo73g7CrX1HvpFZF7a7DL28F3z9bYFLB2mrR+Ut
         1QgvZLrsazmWCW+v8pcXQex6136iGUTWtq0YTFiR7JIhcAL/NP0q62ZcjxmWOSNZbLeM
         gWOkYTGQIT7DUGroQFckXH8ZKj3p6N3ghbRw4U32NEsOTC+67uJPWkzfwpXntLC6uTwG
         3f2vmj5McvxK3v+IhGzWgxoUi3djxB3oLvCzUOX1UUrmdPRg8qOvpCfx++eUnfHjih5F
         oxHQ==
X-Gm-Message-State: ABy/qLa1sZlg0QmuRf4VWeW7yrdpD9m5NAmi0MRi7XSjc3d+N2eZWj93
        1Q0sT8LKeUvcuZ8Eb+Gok9N9Iw==
X-Google-Smtp-Source: APBJJlEs4mVjSoe+3Mo2MTnCJ0aJDjyLdwEIsQ6IxzyYIt+bXokocaJTWvjGA7+d88yJS3nfM+FGRA==
X-Received: by 2002:a17:907:7709:b0:98d:5ae2:f1c with SMTP id kw9-20020a170907770900b0098d5ae20f1cmr5322932ejc.34.1690744837685;
        Sun, 30 Jul 2023 12:20:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906495700b0098748422178sm5028108ejt.56.2023.07.30.12.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 12:20:37 -0700 (PDT)
Message-ID: <ab35b80f-68d7-af96-315d-c4e2b76a609a@linaro.org>
Date:   Sun, 30 Jul 2023 21:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v4] dt-bindings: sound: gtm601: convert to YAML
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, - <kernel@puri.sm>
Cc:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230730191742.117013-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230730191742.117013-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2023 21:17, David Heidelberg wrote:
> Convert GTM601 binding to the YAML format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v4:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

