Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC0785CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbjHWQIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjHWQIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:08:36 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6F110EC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:08:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-790b9d7d643so20216939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692806902; x=1693411702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sb52mdox+dxM4N+wk+fee/xI7Qx4pJ5fTYbUhKVf9+k=;
        b=TlDAQvplzdqtLJFPkI8as/6C9fy9eb/kSOpNC7wTlOzLmqZtgg603CVY/rG71UJO2D
         LZ7sqEROTzz5EWKG0UTiCG5MxtTiWP5fZC/oGuwKvryp9bsOk4mK4NyWi7bLfw3n3dhR
         oBnWqbvaOEeSsMcHePOommrz4Ad3dr63ZywUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692806902; x=1693411702;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb52mdox+dxM4N+wk+fee/xI7Qx4pJ5fTYbUhKVf9+k=;
        b=kY1hcyUrEEjcL9Il36bBm/I7FAJSnJGvtJ0EqJ34Ej0NUeVtJUT39nqv53BFhLDTAT
         rMoWN+d5veqA2OzaqBQJQDksIqCZa32O5ERbhF3NA8xTZ+R/+iB/SlPbzbg83dw5Uh/X
         mNfQZO4+N2OHtUwjkJTqjvSNKzJeTSqG/Lk7kZxIfJwwtuO4P1EwnRnFZlr4xxutHVm9
         oNCtCjvlgGKlP3OGWPdDaZvpOYPOBvH9ECaOCtw7UIuEKHqMkv4M2Hb4IBvPM5P3xhLF
         NeMqNmygacXl9KrTCqAKYMfznxhIRy3tzhMDSJrJFDfTesSguSe5ROI4A+Gahr3wtv7c
         lAeg==
X-Gm-Message-State: AOJu0Yz8kYNe3pfmoqXIVssgG2sxHrxAbnOPqzQ/tpTdfuKWSv715xTs
        S0H3bFlLXtqKtztCySn7VLIM9w==
X-Google-Smtp-Source: AGHT+IFNkatJy67nHdGfFWVliWpegjni2uMd3WdPbbbhhhK5rCwzoqEI/p+eWbVxhoH1ujMzEVqPoA==
X-Received: by 2002:a6b:c90d:0:b0:790:f2c3:2fd with SMTP id z13-20020a6bc90d000000b00790f2c302fdmr14958059iof.0.1692806902636;
        Wed, 23 Aug 2023 09:08:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l26-20020a02cd9a000000b004311d1cdef1sm3741679jap.169.2023.08.23.09.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 09:08:22 -0700 (PDT)
Message-ID: <c954b4aa-9bf7-9583-0b9d-05f33bb0a595@linuxfoundation.org>
Date:   Wed, 23 Aug 2023 10:08:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: manual merge of the rust tree with the kunit-next
 tree
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230822162333.752217fa@canb.auug.org.au>
 <CANiq72=DA1A5YyrWAPHEr+by_pac4R0-GemurbLWYNrSAUNSzw@mail.gmail.com>
 <20230822222036.3462aa57@canb.auug.org.au>
 <CANiq72nvbkYQ0bPb0aRs0jNZGgFwg8TMek4b0n3jrgxd2X4h3A@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANiq72nvbkYQ0bPb0aRs0jNZGgFwg8TMek4b0n3jrgxd2X4h3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/23 09:17, Miguel Ojeda wrote:
> On Tue, Aug 22, 2023 at 2:20 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Thanks for the explanation.  I have updated my resolution for tomorrow.
> 
> My pleasure & thanks!
> 

Is there anything I need to do on my end when I send kunit pull
request?

thanks,
-- Shuah

