Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227407AC15A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjIWLqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 07:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIWLqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 07:46:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01562199
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:46:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-986d8332f50so449492466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695469574; x=1696074374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38HTal4f4sXppv8oLqqAylKmEA9yjUTc4W6rtp1s3qw=;
        b=bR4F/CJXaDrRO73kPTdk75S6knjhpkVarRbKE6QbyAmkyfN2wrWcbKenECJD5hBmlY
         CZI4vmn/wBFZYxT/Rbqp44WWrrhVDGJXdRi7toH1qeizPx3IyOrbvZD4KCseblgkSTMt
         CH2PxqZA839uY1Kq65Ci69EFBRq94HiJ0QmbEJSgOhFpQuxquPFueLKf4uu23i8Pe99f
         YzzxaABn/TniOtfZKsYiVCQDnouH86oMcHkJaaQuQ+z11MkVt/Idxx+qJBHd8l+ZJ6vu
         Gzc42qKVkmt3MgmEgCnw00G1l28IZsk6TErSK3E8vuhTMQDOcldjjlpPpSAgZy/RSIlu
         AWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695469574; x=1696074374;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38HTal4f4sXppv8oLqqAylKmEA9yjUTc4W6rtp1s3qw=;
        b=va1HgpfwWxHDfTpyEOiUcJU8n2gZ91GRfzWYAPEnzHvj4JsjyEFk73Rs15jse1TyD/
         KZU4jHeMCf7G8FNAmaCcFP1KnKhUgTdCf80wb0VKtWqjdhKhiCVR2Bw9a418JkxIr8iB
         825IWr3lgVAghEAsjZyv8YgyYWaYJn9HzReWPp/5p/q/7mHM7oUN56Jt8JR4pqyRHgoh
         u915MUvIBdeCWfWKNM2Tfh5WPaF/hPycPpybb60tNf+XNjKIanoq57P27jzZcJKLirJf
         Tyz1ciCyS9RaTayAXa467VeSo5QFprfpPIMbuK55wah8+OeFtxOneqVP6LZjKUC0/NMT
         uFug==
X-Gm-Message-State: AOJu0YxSR8ktfEkfIoDZnbzgb/o/OzG2Agl8ZLDiPwBtYFlQJV58rGhC
        4xCcBODQBc9BDfb+fikUzuFWQJ7nKab9M29UPLsluw==
X-Google-Smtp-Source: AGHT+IFDTTWMl5LfD8ts0lIxg/ZnEsVdvLyl7AspAxapn77Cf42Oh5qIo0YQDFfD8whAi2yr/C3HJQ==
X-Received: by 2002:a17:906:9c2:b0:9ae:5492:640 with SMTP id r2-20020a17090609c200b009ae54920640mr1472224eje.32.1695469574497;
        Sat, 23 Sep 2023 04:46:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id j19-20020a170906051300b009937e7c4e54sm3879169eja.39.2023.09.23.04.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 04:46:13 -0700 (PDT)
Message-ID: <fea4b205-a0d8-9c40-4fa8-29340c41aed1@linaro.org>
Date:   Sat, 23 Sep 2023 13:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/2] dt-binding: usb: ci-hdrc-usb2: document Nuvoton
 NPCM supprt
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     peter.chen@kernel.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, xu.yang_2@nxp.com,
        peng.fan@nxp.com, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230918165958.2659-1-tmaimon77@gmail.com>
 <20230918165958.2659-2-tmaimon77@gmail.com>
 <b7a337f2-a810-d14c-e7cd-15e33a9ecb5d@linaro.org>
 <CAP6Zq1gSJYsNUuD-bexFW_1VpAUuF_WZkicNzZms6hVdo9LnMQ@mail.gmail.com>
 <e0d42d13-b307-9915-97c8-948261b39ce1@linaro.org>
 <CAP6Zq1g0=-h0PFg2a8bqao+XjdNHoxGMdYSRRPAnfY_6WdemAw@mail.gmail.com>
 <20230919162837.GA4051010-robh@kernel.org>
 <CAP6Zq1hJPPAtKw8auC22wViHGQHTi0SufPJoBiqYtGWomnNUYQ@mail.gmail.com>
 <CAP6Zq1iUj8UfLZutyOVxbKgF42rMoF9ig3dViy7ApTHcqVoP7g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1iUj8UfLZutyOVxbKgF42rMoF9ig3dViy7ApTHcqVoP7g@mail.gmail.com>
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

On 21/09/2023 15:17, Tomer Maimon wrote:
> Hi Rob,
> 
> Again thanks for your suggestion I took a look at the
> drivers/usb/roles and I am not sure it answers NPCM ChipIdae case.
> For example, in the NPCM845 we have ten UDC ChipIdea modules (UDC0-9).
> Only UDC8 and UDC9 are muxed with USB host0 and USB host1.
> NPCM UDC and NPCM USB host are different HW modules therefore different drivers.
> 
> The ChipIdea driver uses its own internal USB role function to switch
> between ChipIdea UDC and ChipIdea USB host and we can't replace it
> with a unique NPCM USB role function also we need to set the mux only
> at the probe stage.
> 
> This is why I have added nuvoton,sysgcr property to the NPCM ChipIdea driver.
> 
> With the above do you think I should do it differently?

Your entire rationale above explains drivers, so it is not proper
justification for bindings. How your probe stage has anything to do with
bindings? If drivers do not work or miss something, change them.

Best regards,
Krzysztof

