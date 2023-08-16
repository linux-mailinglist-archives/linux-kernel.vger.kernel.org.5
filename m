Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3E77D9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 07:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbjHPFfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 01:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241890AbjHPFfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:35:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E521FCE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:34:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe4b95c371so36214295e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692164096; x=1692768896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5ksSrfoQhUw1ZEBLOq6q8yMh3Ah7S6SGizLhXtxXU4=;
        b=edpuAYQXEQ9OEdOp2KZdnwWqRhLG0RH8xS8zwxGuc6hPqsw3/tTqD43TISmtxNI3zY
         3NqNqIX5YOpcIke3Yb9LLrVuErwNXKBLXFqBPe1R30V59HZaSwm1LfiSZK/AMLkgDZBb
         kk+CaQsjS32+fhWiplRVwcYSAo6N9sFNCTCQ0e82fBAfZdgvPoBS8Qg/MlSzV2lO0dTU
         2hN149zs2tA0+Uv0eBRa1xQ4trlAoaI2FV5JDeiN9p/dm17XRLiSYbxPo7bol2zx0/+Z
         cipG8ZIOEnGz79d/KpNobRcQb78NFmG0XB+x8xeY5zBmax8TxuMy+/u4hofd27tm78fG
         OEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692164096; x=1692768896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5ksSrfoQhUw1ZEBLOq6q8yMh3Ah7S6SGizLhXtxXU4=;
        b=AvMgsT8JPk5sR2kBdEMVV1NNbgnlajgaIm+YKbRsesOk0q2hCOWKYEYLs8em5M9TY8
         2diR3kc8e5FNXRCA4TBxdJ1T6LKfwqxjINTzxkvT7WYpH9bRCV+nY9jkdOxeSI8b1coi
         inAS0bsMkD1EOvhXPdpf9STf+6bII4Yc3NzNQAqZ4WioIWVtDC1Hni1FFVVzvQvJLDpz
         oOaSuIrwwP/dG8gSaisfc8yy4NvwpllAZIEuQG67HhzOKVltB38reQWAFUX4jVgpgRxB
         0UdG01i54pJTIqdBfuuICVtgt/L2ikRSnWUVmyAzIUUyCDGVAH6xg/MS//DGlenHq+9S
         1neQ==
X-Gm-Message-State: AOJu0YzT/yYjTAYL+V+tdgToO26owtm41Q+5D3lFxnt81VXwicNqsRnx
        OiNXNzPHaIPz4g3SwkWK9SgivA==
X-Google-Smtp-Source: AGHT+IGLA5lowKwKuCnX8UwxKBq+NtEWMT+CcurCefj4vhebQX0LZ+LoJXhsNlYcgDdsDgX6fzbbWQ==
X-Received: by 2002:a7b:c7c7:0:b0:3fd:2e87:aa28 with SMTP id z7-20020a7bc7c7000000b003fd2e87aa28mr695024wmk.15.1692164096117;
        Tue, 15 Aug 2023 22:34:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c218700b003fe3674bb39sm20034014wme.2.2023.08.15.22.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 22:34:55 -0700 (PDT)
Message-ID: <1c4aa5ce-df78-b69c-0dc2-2859b0c1c3df@linaro.org>
Date:   Wed, 16 Aug 2023 07:34:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] mtd: maps: fix -Wvoid-pointer-to-enum-cast warning
To:     Justin Stitt <justinstitt@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230815-void-drivers-mtd-maps-physmap-versatile-v1-1-ba6fc86d5e4e@google.com>
 <a7956e13-7b94-fb65-8b43-f2c9fd014353@linaro.org>
 <CAFhGd8rTU0o8uiGT1qUKbsOZTgqLR7Sw5h-+07y4SJ6QOd9KsA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFhGd8rTU0o8uiGT1qUKbsOZTgqLR7Sw5h-+07y4SJ6QOd9KsA@mail.gmail.com>
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

On 16/08/2023 01:06, Justin Stitt wrote:
> On Tue, Aug 15, 2023 at 2:15 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 15/08/2023 23:11, Justin Stitt wrote:
>>> When building with clang 18 I see the following warning:
>>> |       drivers/mtd/maps/physmap-versatile.c:209:25: warning: cast to smaller
>>> |               integer type 'enum versatile_flashprot' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>>> |         209 |                 versatile_flashprot = (enum versatile_flashprot)devid->data;
>>>
>>> This is due to the fact that `devid->data` is a void* while `enum
>>> versatile_flashprot` has the size of an int. This leads to truncation
>>> and possible data loss.
>>
>> Cast does not solve truncation. This part of commit msg suggests that
>> you actually fix real issue... and that is an issue, because then
>> AUTOSEL will grab it. This is just compiler warning silencing and rather
>> coding standard correctness, no real fix, so please drop the sentence.
> OK, makes sense about this not technically solving an issue and thus
> AUTOSEL may pick it up. Can you elaborate, though, on how the cast
> doesn't solve truncation. 

Because that is no how the C language work?

Casting UINTMAX+1 to unsigned int, does not magically change the
unsigned int into something else...


> Is the initial implementation not a
> pointer-width down to int-width cast?

These are different widths, so cast cannot solve truncation.


> Surely we're losing the top half
> of bits. 

If we are losing top half then how is the truncation and data loss solved?

> I'm still not saying there's data loss, to be clear. Just
> that the compiler is warning because of the truncation.

Sorry, what truncation? The one which will happen always regardless of
the cast and warning?

Best regards,
Krzysztof

