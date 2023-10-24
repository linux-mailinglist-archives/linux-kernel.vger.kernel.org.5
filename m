Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C887D4CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjJXJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjJXJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:46:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D092
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:46:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-408002b5b9fso35123195e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698140783; x=1698745583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxL8IXJxK6nZZcgY+jbWAe4cJBK0AaStast6oXjM8uc=;
        b=JBFbsdHMLjiHsJfN23h/bL5/bZRN5STqMmEVkurOvghVyYdEICgOCzcvTWXIEVGybU
         jxlJ28SP2aXJvetZ/UhRPTqZOlungmIj1DnPAHPInpxAC7i+BktNQoKpZQfy9mU1egfD
         KQQljiW/f0enPiiwJEilVXpjL6BA3TPIR/+1xcpFl4vyecgxX7QnfvY4jEAWK2Ts71Wp
         RoRWVy8Z2IlYjqeAo/ITtV+9dQyxBSNX11T9+TI2aFoDgqarFQ2m/PeEUBwOLW0fDLNK
         OSgTH3w34Jsqk8kmrhJLTFvSfn8HruEI5QFtEjWWHWXlyIMFqi5xicYAOVP0rzYO2LGO
         LcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698140783; x=1698745583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxL8IXJxK6nZZcgY+jbWAe4cJBK0AaStast6oXjM8uc=;
        b=dr6Qku+aqGRcF6e4Qi6ttpcXe2py2xBmqzyjQjz0F2JVVYQgl5UlHmv2KCP0tZxBiU
         ccJgLl6huQAERgHEMeiSdUpnjNNOE49CQkYKx5zKHjnmT6AF1q0a64penN8Bj4BdrMnt
         8LvQckM+fu8g1M1xKh9gEyV1ury860CL2XOuigD3sZm/xdd+qbLqd2RG2XfDjRLSh6n3
         C8ksnCaLZSQ5lpfcVqCOzRemtjxlk/Ogd5BSYiy8tMjqIzMnpFnrC9vijqlWW22Bf2p8
         tEJEW0Z4CEX4xLgNIDWOqrwHdBHEQaZT+CYLbRh2yUeFMmSZMmpwvFvhrBu0xLsO3s6m
         VBXA==
X-Gm-Message-State: AOJu0YwWJn3Kq5pFkj3re/1ZM0FHiDnfgLLpvkG/AZ2Bj/8gjP5gxMMi
        1dYEP+klFp2oLXQS3z6CsTD5ew==
X-Google-Smtp-Source: AGHT+IGuXGfq4qBu5yB+kGBPSeAFqqYtQZB3elN3KJ3fMidrIDYRjfHKeVHnH6iQcYfviEGedXATNw==
X-Received: by 2002:a7b:c8c2:0:b0:409:101e:235a with SMTP id f2-20020a7bc8c2000000b00409101e235amr901405wml.28.1698140782643;
        Tue, 24 Oct 2023 02:46:22 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id r8-20020adff108000000b0032db1d741a6sm9602052wro.99.2023.10.24.02.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 02:46:22 -0700 (PDT)
Message-ID: <314a5b37-bdc4-41d1-a3de-c6d557628be9@baylibre.com>
Date:   Tue, 24 Oct 2023 11:46:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231023083839.24453-1-jason-ch.chen@mediatek.com>
 <20231023083839.24453-5-jason-ch.chen@mediatek.com>
 <a1846955-e6d9-4217-8c9f-1f20be166f4b@baylibre.com>
 <CAGXv+5Gdr4DuiGAZFdVdqjj8Rv2Onq78k+=Mmu0MOe=rxQkr3A@mail.gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <CAGXv+5Gdr4DuiGAZFdVdqjj8Rv2Onq78k+=Mmu0MOe=rxQkr3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2023 11:36, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Oct 23, 2023 at 6:55 PM Alexandre Mergnat <amergnat@baylibre.com> wrote:
>>
>>
>>
>> On 23/10/2023 10:38, Jason-ch Chen wrote:
>>> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
>>>
>>> MT8188 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
>>> and 2 CA78 cores. MT8188 share many HW IP with MT65xx series.
>>>
>>> We add basic chip support for MediaTek MT8188 on evaluation board.
>>>
>>> Signed-off-by: jason-ch chen <Jason-ch.Chen@mediatek.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>>>    arch/arm64/boot/dts/mediatek/mt8188-evb.dts | 387 ++++++++
>>>    arch/arm64/boot/dts/mediatek/mt8188.dtsi    | 956 ++++++++++++++++++++
>>>    3 files changed, 1344 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-evb.dts
>>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>>> index e6e7592a3645..8900b939ed52 100644
>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>> @@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
>>>    dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb

..snip..

>>
>> Order:
>>
>>
>> #address-cells = <1>;
>> #size-cells = <0>;
>>
>> pinctrl-0 = <&nor_pins_default>;
>> pinctrl-names = "default";
> 
> I think pinctrl-names before pinctrl-* makes more sense. We declare the
> names and by extension how many pinctrl-N entries are needed first. The
> vast majority of the arm64 device tree files have pinctrl-names before
> pinctrl-N. The only platform that exclusively has pinctrl-N before
> pinctrl-names is amlogic.
> 

AFAIK, people have it own logic explanation to justify order.
Personally, I use the dumb and generic one: pack related properties and 
alphabetical order.

Anyway, I don't have strong opinion of that

> If there's a preference for a particular order platform-wide or tree-wide
> then it should probably be documented somewhere?
> 

I'm agree

>> status = "okay";
> 
> I think #address-cells and #size-cells belong at the end of the list,
> even after "status", just before any child nodes. They describe
> properties or requirements for the child nodes, not for the node they
> sit in.
> 
>>> +
>>> +     flash@0 {
>>> +             compatible = "jedec,spi-nor";
>>> +             reg = <0>;
>>> +             spi-max-frequency = <52000000>;
>>> +     };
>>> +};
>>> +
>>
>> ..snip..
>>
>>> +
>>> +&pmic {
>>> +     interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
>>> +};
>>> +
>>> +&scp {
>>> +     memory-region = <&scp_mem_reserved>;
>>> +     status = "okay";
>>> +};
>>> +
>>> +&spi0 {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&spi0_pins>;
>>
>> Order:
>>
>> pinctrl-0 = <&spi0_pins>;
>> pinctrl-names = "default";
>>
>> Please apply this to other nodes
> 
> See above.
> 
> ChenYu
> 
>>> +     status = "okay";
>>> +};
>>> +
>>> +&spi1 {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&spi1_pins>;
>>> +     status = "okay";
>>> +};
>>> +
>>> +&spi2 {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&spi2_pins>;
>>> +     status = "okay";
>>> +};
>>> +
>>> +&u3phy0 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&u3phy1 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&u3phy2 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&uart0 {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&uart0_pins>;
>>> +     status = "okay";
>>> +};
>>> +
>>
>> ..snip..
>>
>>> +             };
>>> +     };
>>> +};
>>
>> After that:
>> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
>>
>> --
>> Regards,
>> Alexandre

-- 
Regards,
Alexandre
