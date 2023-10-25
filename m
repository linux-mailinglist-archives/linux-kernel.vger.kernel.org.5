Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1CE7D6254
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjJYHX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjJYHXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:23:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FDE90
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:23:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b6559cbd74so809116566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698218601; x=1698823401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SnNqjmTumDhS9QjbNc2fsxDzSTTZE7f6qzo4FhoEWiY=;
        b=Ofxr20scyQX8OmE/lhgFZest3nmgobuf/U7oVW6mmrSONt8Ce1RKLCqHH+/hE7jAjf
         ew2SEL0AnzSc2LNRiNPKDIKJOtx5H6779NIN1F6+ri4fU+CWaUyIUEuhK9425XaEsVko
         6pFgALtYtjmRehgGVLzjkWjv0We9q6swURQXu4oaPKcWEqm3CxREiPZMt53JFVevjlV7
         lv8CTAaU6OAyaaUz+fNIwnJmjuhIf2nD47tgQcFlQN2/PGT9od6Y8i0xVQTdB+mQlgtI
         mTBD+jLgZLIn/MTZ+8BYb6DA2biw8EmuNxFgjWsXjN8w+U6JbZ4EJkfT7vJxye4fOK1R
         cTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698218601; x=1698823401;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnNqjmTumDhS9QjbNc2fsxDzSTTZE7f6qzo4FhoEWiY=;
        b=EoYzjhMOIuKkiKjJ6MSDF99KSEIIPx5xUDcjgQhkxJXHcpD6Pf4EEm+Jw2HlRxOkS2
         OR630j1l0nCWFKlZfLYqI0UExEMHLDBO1c4qJL7rHla9UF3wCs4o9Bu9L7FyPS5oZVhX
         sn/TGwGRNriJhxS1aCjFucKW8tz4VX6gLCqtS0a1LqbkI7E50tuHXk3BnRWPc/XhyRJj
         QC9RkqlAQUZfw1ik3g8hppgFcRCpct70x5B/m8eAo3uE8nfUdiIJvpP0czjl0l9lfrgV
         2kh+w4aPN4hvPj5CNxzZBT7As3iDXUD6TJZ+xv2aycp0qzyDT9Wqqh/Pdlne+CMVyjJA
         9/yQ==
X-Gm-Message-State: AOJu0YwTv1kPw0UeoYJgarqeny/Zs7u5A0ziWmlqHZAh1Hjv1FmcYRbd
        pkTFe01Mpy1vxnWMuzDhNucRFA==
X-Google-Smtp-Source: AGHT+IGDzPdEPaKGrNOsr1qlrTkceEf3aDuIWmsxOt658eqmx0JDzDRBplXTPhd2sIMHpXKUFjspNw==
X-Received: by 2002:a17:906:7310:b0:9c6:724:fa1f with SMTP id di16-20020a170906731000b009c60724fa1fmr12387261ejc.66.1698218600947;
        Wed, 25 Oct 2023 00:23:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id jg36-20020a170907972400b0099d798a6bb5sm9403230ejc.67.2023.10.25.00.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 00:23:20 -0700 (PDT)
Message-ID: <32edfc3c-321e-4816-b634-7b9540ab8c47@linaro.org>
Date:   Wed, 25 Oct 2023 09:23:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KASAN: slab-use-after-free Read in nfc_llcp_unregister_device
Content-Language: en-US
To:     Abagail ren <renzezhongucas@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
References: <CALkECRjyG8AtbUunWFYErQethdyCfiNC2-ZHP6oVtO3+GHxahA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CALkECRjyG8AtbUunWFYErQethdyCfiNC2-ZHP6oVtO3+GHxahA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 08:27, Abagail ren wrote:
> Good day, dear maintainers.
> 
> Since the email system replied that it refused to accept the email because
> the text contained HTML, I sent it to you again in the form of shared files.
> 
> We found a bug using a modified kernel configuration file used by syzbot.
> 
> We enhanced the probability of vulnerability discovery using our prototype
> system developed based on syzkaller and found a bug "' KASAN:
> slab-use-after-free Read in nfc_llcp_unregister_device." I'm still working
> on it to find out its root cause and availability.
> 
> The stack information:
> https://docs.google.com/document/d/1gdHebCRsvVsSPKfilcoXVu3Pctvoj2FSZCACcVYZXns/edit?usp=sharing
> 
> Kernel Branch: 6.4.0-rc3
> 

Hi,

I received two emails from you, so I am not sure if these are separate
issues or not.

Anyway, there were fixes to these paths and you are testing quite old
kernel. If you have the reproducer, it should be straightforward to test
new kernel, so please do so. Test on linux-next.

> Kernel Config:
> https://docs.google.com/document/d/1WIM0btqS2dex18HQYaL2xyoW6WdX2TsaNguTnWzHMps/edit?usp=sharing
> 
> Reproducer:
> https://docs.google.com/document/d/1LrgGdOgZwO8wz0opusZ7flP9QSFZa32GdozvoxGysyY/edit?usp=sharing


Best regards,
Krzysztof

