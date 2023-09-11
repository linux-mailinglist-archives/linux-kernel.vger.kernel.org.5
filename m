Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04F879A37B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjIKG0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjIKG0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:26:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB06126
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:26:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so5288570a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694413568; x=1695018368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=602xwMxmXuh7pmF89QMiFJmde3kiK+7O6M1QlBanRF4=;
        b=WQA8WO5Wj/Pz2uJXnchLwwk41f81pWfbMN59eDO4xDviZySGjjmrxpeQsEqavIHaaD
         7XfgP/Usoj9033kG15W3O/PFZBCmxmJ+4AYoShpgoAGNWKOblmqeOHkcFWemStqyW9Rr
         oGdZ5wv0dv3uoUN3hG//bsU54FCQfZ0KJ2puFRSQBw1JlRNIiopVoMDnVX/IELzaRExX
         eonafZoj6DldfCl9y+gspMzGASllw6v8yrI/v0wF3wNs+C+8IvTR9wFMS0YwAJbonjhk
         nVKMgh5aaHZJNju3r+tCKdBFLJSgLcNbauhF7QBaNprpLOlOdUAlcl805atGIO8XsBsf
         ynOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694413568; x=1695018368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=602xwMxmXuh7pmF89QMiFJmde3kiK+7O6M1QlBanRF4=;
        b=w9zpGLjoQr4lV9xtEe8YHl6dwiSbdEOn6h2LQQyjDzhzmckOGVwROmxS83nNKPasKK
         05uL8euvRg4LJ4dm+4TRYLvacuYNSb0GCSHQeRXQQHWXM0ECWylxM+7zEBp9UbB8MdNj
         uOFdaOC6bobOo/9RdWlUMw/P8qJhEz5hEXooWSVc0ASEENGTb7zYl+Q2iiWxQLN2LUnX
         8EHWScojExKaTjOgioQ1C6dtGLlbFJhTrYnSqHc0MWE26Y3FQVYKEYPE9xzPleALa//o
         BKf/85iSwat+7v6dx+oBDbGgwMbWbQx4uIo1V1X43qVj2csn7YjShiGC+cua0A7riCZj
         /uQQ==
X-Gm-Message-State: AOJu0Yz5MndID9hocJ332SWVPZinOofihorw0Nyacyt+F0wbxg50med5
        7B3Pj9ojrVHy5oLiCT916hJEuA==
X-Google-Smtp-Source: AGHT+IGEC+tOirQCReCMY1VVEPGCqzzXXwp2ylU3JczCrMaopcxpe+paYOVVe47RO8jX2TctjEdeyQ==
X-Received: by 2002:a05:6402:31e6:b0:52e:d08f:af79 with SMTP id dy6-20020a05640231e600b0052ed08faf79mr7012458edb.41.1694413568582;
        Sun, 10 Sep 2023 23:26:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id p26-20020aa7d31a000000b005222c6fb512sm4185312edq.1.2023.09.10.23.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 23:26:08 -0700 (PDT)
Message-ID: <34ede760-d612-4628-17e6-600c133ee878@linaro.org>
Date:   Mon, 11 Sep 2023 08:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add mps,mpq2286
 power-management IC
To:     Saravanan Sekar <saravanan@linumiz.com>, sravanhome@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20230911034150.181880-1-saravanan@linumiz.com>
 <20230911034150.181880-3-saravanan@linumiz.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911034150.181880-3-saravanan@linumiz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 05:41, Saravanan Sekar wrote:
> Document mpq2286 power-management IC
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. It's: regulator: dt-bindings:

> ---
>  .../bindings/regulator/mps,mpq2286.yaml       | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
> new file mode 100644
> index 000000000000..d00d887870a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mps,mpq2286.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Monolithic Power System MPQ2286 PMIC
> +
> +maintainers:
> +  - Saravanan Sekar <saravanan@linumiz.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mps,mpq2286
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +
> +    properties:
> +      "buck0":

You did not test it... Sigh. Anyway, there is no need for entire
regulators node for one regulator. Can the device do anything else than
being a regulator?

Best regards,
Krzysztof

