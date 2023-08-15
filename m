Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4489477D34F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbjHOTVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbjHOTVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:21:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E962682
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:20:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c0cb7285fso710777666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692127177; x=1692731977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HP5r8l+N/G++84rGRD6TPetR/Ye7KhL9+cTCQpuI0nU=;
        b=lUhNrtoERba3aorZadoUgJp9sCu3IbGKVivMwNrWnTG0yELOzp3fLhGA5srP0IpIxm
         KBoGNzrF/crrZmebYELgHIEkxozcxxtEo3/rzUVJl78TFfL5q+sms/p0Ih6sWJ+yxmH0
         WmIOggw4UWG9gVNckTrS8LMy+qNRpFpYXwv9toqdR3AU/V2kkKYXc6ipFkHJi+GnN+YA
         3BOow5pnOGq74dIyo5z54P1Hbl7aOhsUNecfcx1JoHcYimBY7saJsaYLgWe7FBtoj7V3
         IkqlbQA1sRa6r/wQa1WAPvD9lQm9WsBzLRoXl7pXOnic75zxJubcIxMOafFzX2CF3F8z
         DkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692127177; x=1692731977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HP5r8l+N/G++84rGRD6TPetR/Ye7KhL9+cTCQpuI0nU=;
        b=f6hRkSRi5supqCJxVZYU/8va+lczoQ1Y0FHo7eGvgrj0RS+CHDB7g/uk9iVJpAqCyn
         K6edfwPWl8zSEE0BbCShWtrhv/UlcV2lFLO1QjZ/aqn30hgOu3ouPYCSfCZFS7zUzpPY
         DNo1iFCUacqsfgjwc9OwZCSicCcU0BY8u2WyMA0o2y6CS20ffxG3IPmGlAErnABYcRxe
         owr4z4QAN6G+wcl9jzjH6xHvUALyWi94K3nlxJQYtpU0F3zzqo43+9QChMIyWEBwEh8E
         WvkRFEnY26SYBq2bXKUpQYe4RQyPwryV5dUwTEtPdtFn0aP3BMkHYhGDbSwd1lQVpij0
         vocw==
X-Gm-Message-State: AOJu0YxKKeUd90MPIxuCFq7VE+lWFqABMHFN0nTVKBhu1/+x+k9e4Jg/
        Q35LbeaY5c2arZFuZcT/Gaumpg==
X-Google-Smtp-Source: AGHT+IEamhO+Jl+q7/ydr+FDFDZuF0BIJhDmzs5q+uIy0rMFYS3cNVnuKTzqQrGnKGFA2D7kUp1BAQ==
X-Received: by 2002:a17:906:2215:b0:99c:47a:8bd5 with SMTP id s21-20020a170906221500b0099c047a8bd5mr11216606ejs.65.1692127177101;
        Tue, 15 Aug 2023 12:19:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id ov10-20020a170906fc0a00b00993cc1242d4sm7360694ejb.151.2023.08.15.12.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 12:19:36 -0700 (PDT)
Message-ID: <fb85c288-2ea9-3343-ff19-cd58940b44ec@linaro.org>
Date:   Tue, 15 Aug 2023 21:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/4] Add a property to override the quad mode
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20230815154412.713846-1-hsinyi@chromium.org>
 <202A0C36-D1F6-4BB4-BDEC-F36A76B757A2@walle.cc>
 <CAJMQK-iw7ikyHKPPC8+hnpXuRq-_nq_N+21BKgWxD2nx=vAeJA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJMQK-iw7ikyHKPPC8+hnpXuRq-_nq_N+21BKgWxD2nx=vAeJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 19:21, Hsin-Yi Wang wrote:
> On Tue, Aug 15, 2023 at 11:59 PM Michael Walle <michael@walle.cc> wrote:
>>
>> Hi,
>>
>>> On gigadevice gd25lq64c, the quad mode is enabled after BFPT is parsed.
>>> According to datasheet[1], Quad enable (QE) bit needs to be set to 0 to
>>> use write protection (WP) pin. It also recommends setting default value of
>>> QE to 0 to avoid a potential short issue.
>>
>> So you are using either dual or single io mode. Why can't you use the device tree property spi-{tx,rx}-bus-width?
> 
> I tried setting spi-tx-bus-width and spi-rx-bus-width to either 0 or 1
> and WP still doesn't work.
> For this chip, quad_enable will be set to spi_nor_sr2_bit1_quad_enable
> (QER flag is BFPT_DWORD15_QER_SR2_BIT1_BUGGY)[1]
> 
> spi_nor_write_sr_and_check() calls
> spi_nor_write_16bit_sr_and_check()[2] and the function sets QE bit if
> quad_enable is not NULL.
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/sfdp.c#L575
> [2] https://elixir.bootlin.com/linux/latest/source/drivers/mtd/spi-nor/core.c#L879
> 
> Setting spi-{tx,rx}-bus-width still falls to this function and cases.

with tx/rx bus width = 2, how quad mode is still possible? IOW, why do
you need new property? You wrote here about driver, but I ask about
bindings.

Best regards,
Krzysztof

