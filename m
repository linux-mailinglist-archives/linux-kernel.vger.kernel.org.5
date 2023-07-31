Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D1768D54
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGaHLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGaHLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:11:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8AB1BF2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:09:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bd1d0cf2fso658728666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690787342; x=1691392142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVEDYdCi9VbmjgNaz1k0ZbW7cJme7o0BuWFDpy6Kp8o=;
        b=HoYCq4pbRC9Xi/WlSnZhW0MlQRyagYmSlOqMFxLgD3aB8Ir0Ejp6hFjBn6Nh/e5CVw
         xw9aGepFGsURQZZYLDi5YK2c/jZSh9idnDtqPrDTWYjhA37GK7ydilzF+tjC4YsdE10F
         Drr2Z0mFRA1ksYM4fUl/rnbfM7n4gDyPgqoNlxI60j/h/bAfe/r7SJvM7wO8lCjmt4Bm
         MI3hSkWFvwYz3TLAid6k0N4HAF7NMHf3OiTCwIvfNiBvRnn6Bi5Z9SJt9mxu3bV/49mp
         0J5i0wV01yDjesZ+WZD5levJpcpX5Sp8QI3kk9pwi7IBipnKBRDePQcAWFb44UlPAVeA
         lsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787342; x=1691392142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVEDYdCi9VbmjgNaz1k0ZbW7cJme7o0BuWFDpy6Kp8o=;
        b=id3H6dyrFDcCKQRAAMnIkJkAkBWz5hblR7Oj7vlCHKiKIPnDj1NpZlvs+HmFL/oZ4+
         31mXR0WiD+/FUsh8Hg+I8mnPZ9+y4ACtgNsICmZ85w/J9D+R2f/7Gih71f8iQiXXl0bj
         OH1EzV4mDqYlv2Fik1ECcvAxRJCqRn09STofyxvvtzM4hcf7kio4iWKm3rMZ4prX4xsb
         4w+z/F49RNxOL8qEuGxnt3nQl2bVHzx7R991ySH1ldhNffO2LR/tjQuM5Fhlfbamh5Fx
         UmEe9cjRQxkYhdLk3VEL63vQGDZ3evhx6xqTyk5cPcjx2TVqKb5PVAxFKYninKhm7nLo
         iCJg==
X-Gm-Message-State: ABy/qLY7S4CPSx+Tw++MKw+SiZRW19ev+4+3Nqps7ZSHwBFevnNZ4ulb
        jitsa+pq4rennarLN05JasJZCWabK5pHQg/d4RI=
X-Google-Smtp-Source: APBJJlFhc4pWHIxjCtaIa6VcQ9RmldEFLC1DrbLUHLqPeOaPI6Vp7+hRl0WS6J17PAxe2zY2a9FE7g==
X-Received: by 2002:a17:906:3294:b0:98e:1156:1a35 with SMTP id 20-20020a170906329400b0098e11561a35mr6211758ejw.74.1690787342507;
        Mon, 31 Jul 2023 00:09:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id jj27-20020a170907985b00b00992b1c93279sm5682620ejc.110.2023.07.31.00.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 00:09:02 -0700 (PDT)
Message-ID: <35ca8c66-a14b-8a8f-afda-246347322ae2@linaro.org>
Date:   Mon, 31 Jul 2023 09:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 6/9] dt-bindings: marvell: Document PXA1908 SoC
Content-Language: en-US
To:     =?UTF-8?Q?Duje_Mihanovi=c4=87?= <duje.mihanovic@skole.hr>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, afaerber@suse.com
References: <20230727162909.6031-1-duje.mihanovic@skole.hr>
 <20230727162909.6031-7-duje.mihanovic@skole.hr>
 <08deec6b-870b-d9cb-3ebd-b845340c4952@linaro.org>
 <3246035.aeNJFYEL58@radijator>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3246035.aeNJFYEL58@radijator>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2023 23:18, Duje Mihanović wrote:
> On Friday, July 28, 2023 9:19:52 AM CEST Krzysztof Kozlowski wrote:
>> On 27/07/2023 18:29, Duje Mihanović wrote:
>>> Add dt bindings and documentation for Marvell PXA1908 SoC.
>>>
>>> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
>>> ---
>>
>> This is v2, so where is the changelog?
> 
> Isn't it in the cover letter?

There is no cover letter. And just in case before you pop-up here with
lore link: If you decide not to send it to people, it counts as
non-existing.

> 
>> What happened with Rob's comment?
> 
> I'm not sure where I should move the bindings. I'm considering arm/mrvl/
> mrvl.yaml where MMP2 and MMP3 are currently documented because as Rob said the 
> PXA1908 is very similar to these.

For example.

Best regards,
Krzysztof

