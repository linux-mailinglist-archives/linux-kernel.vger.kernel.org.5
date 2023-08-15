Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF577C6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjHOE76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 00:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjHOE7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 00:59:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7CCE7E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 21:59:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3178dd771ceso4510087f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 21:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692075548; x=1692680348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9FPPB77R5VGDkpEhLuEblwJ1BfQrVVCDwiIsWbwhIA=;
        b=ibyEzj/ViNZ3VV0SbdqYaaf+Teg3B5IIVBPHIZCkdJNeExyaaMh4vwJDyG5RV5C4LR
         T2uzJTNYQJyBi0zMAD1/MRJjaSab3eW63or+UURYUpuEoEFDrAC3RN43UpyPQJbmESaZ
         KiCttMyBNMFluNkXabGLrEtvkqu7G/yi7NCkBa8ZsIP3QKQvR0o8v89yYb6RcxPN0ZDI
         k4FPC40aFWQgt2wyh0HpqXXZn5JrCq26SybrBbir50DBpFfhi+gCUFeS5Rbdf+D3B/EK
         121Y03ybDH4rKjZ1oixBYahWS7veYgnzXW4NAI2jrpwYc6aI78MQWr4IlpCyzN5xmUQR
         1zvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692075548; x=1692680348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9FPPB77R5VGDkpEhLuEblwJ1BfQrVVCDwiIsWbwhIA=;
        b=ZFzhchR482ksK2jcEav6hRGCZPZN1OMxGZfyguxRIC+B9249z/pk/B1itCWS9mkVue
         c01h7iX5glYGslpHMIs0l8sKgi6L1E6mGQNBVcO+/CCiwRQ3zD7lbmuWi1HpNPZWiLgN
         PJs+FiIPuFixKnFlae14wyPq8q54ZxUWa/1Rp1OEqQwlvTjM+HpQUotcTLQ66QNfbGy9
         42aoysiVWgVi0o0STLC1z5/vNPRb3gUAyoMiAVehwYSlAoChJsraTMEw7oqiCvi4zuWl
         WBLz6QPZ5AYvBgBtmk5sMyIIYcdwsZYE+7FIYCygDqJrNTjd9TymcoVWzSeJcI4o/W8s
         ZrBg==
X-Gm-Message-State: AOJu0YxgB6IrO4N9tYGmqzoNk7pq+kyUSFg+bX4gdc0rZR3shYIdZayq
        z8bQnztTXGrUddiE6Aga75zJxA==
X-Google-Smtp-Source: AGHT+IFoTDmW8n9eQAc1xIDsjCJCRCtu5VAOAFQaRuu5TpkU6GUd+VzNO4uHCokM4ZT/E2JkirGg7w==
X-Received: by 2002:adf:f303:0:b0:317:ef76:b778 with SMTP id i3-20020adff303000000b00317ef76b778mr9202890wro.63.1692075548532;
        Mon, 14 Aug 2023 21:59:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id b13-20020adfe30d000000b003113ed02080sm16358185wrj.95.2023.08.14.21.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 21:59:08 -0700 (PDT)
Message-ID: <c27d68eb-bd7b-6e85-0d7c-d4ff8bb96687@linaro.org>
Date:   Tue, 15 Aug 2023 06:59:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: duplicate patch in the samsung-krzk tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230815120622.528613e2@canb.auug.org.au>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230815120622.528613e2@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 04:06, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in arm-soc tree as a different commit
> (but the same patch):
> 
>   3027df7e739c ("ARM: s5pv210: Explicitly include correct DT includes")
> 
> This is commit
> 
>   8787bc51a7e2 ("ARM: s5pv210: Explicitly include correct DT includes")
> 
> in the arm-soc tree.

Thanks, it was expected.

Best regards,
Krzysztof

