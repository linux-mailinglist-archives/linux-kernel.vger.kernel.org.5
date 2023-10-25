Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935F37D6F51
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbjJYOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjJYOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD0B13A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698243356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=/81fA64FEiSflbLmuEAcmfGAj2PLCOIEQJxZMC9ru3U=;
        b=MEBXQUc3hLAlI0Js0sTRctL/OTvh27XYIUdcCr6yh9zPS/kpQoly4t/lKt8BbbBSOYupvb
        N871KxpSkALzMkeuoy26ciFSjV7ixADzzUhj73KUrbVeQZSMDJ1SlusMf83f26XYH7yTt8
        W4CY/CPwB9Q1UqbVjdTFZlZ9zORL/fg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-zoDBZ58yPPOaVt_-wq5SOQ-1; Wed, 25 Oct 2023 10:15:34 -0400
X-MC-Unique: zoDBZ58yPPOaVt_-wq5SOQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77892f2ee51so752874685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698243334; x=1698848134;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/81fA64FEiSflbLmuEAcmfGAj2PLCOIEQJxZMC9ru3U=;
        b=iBxOVR7YHjWHnbfGOdK5mYAKdAwkRN2aTNWNhOG7dN214deNtGB868Di59I4Q1m4ta
         EAdFuvEaLXeSTs3Ej/tpBm5+6U9fMBYhzdec8MIcGCxxi5SmlFne3WJpDN6rd6jnbSU3
         1U/CNUUI261rh56c2q7rqvcnzHoich4k40zeVQqQgLOoJtA3sMDH/LbyGfaSSrPZXKfw
         Nd1bdhNW8cn54OxZOuqg2pX4/kDRXK8bMNYGBIK2zXTJdDT5yebi2rL6B80eeD2rz1oE
         o5+b/5Yi0SIrj8laWXOKmQ4+poWlHjzBv4C4LtgBQO07dIjZfLto6a9Aepb3ngDhgtRh
         xlzg==
X-Gm-Message-State: AOJu0YwD7HAP3yRHXdMKDAGVJQNy8UZq7Gl1Vt2Z1RlpfsziyLhh5q3h
        fWn3chhe+kHOE4Hs9i6XgVFnL/M7XhPOoEHR4P52ECZQlAKKNiYDQdqilC723Neii02Bd0YoyYR
        NDsarlmtuTo3WqpUBY+m+U22r
X-Received: by 2002:a05:620a:22b0:b0:778:8bad:662d with SMTP id p16-20020a05620a22b000b007788bad662dmr14325292qkh.18.1698243334511;
        Wed, 25 Oct 2023 07:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfE1VnLuzVl6E6EdvQNDTyIsiizJgc29Rhv6SU3AInZ2/AsqpNr4cVN/tUZP3SFyiWPzMDwA==
X-Received: by 2002:a05:620a:22b0:b0:778:8bad:662d with SMTP id p16-20020a05620a22b000b007788bad662dmr14325275qkh.18.1698243334254;
        Wed, 25 Oct 2023 07:15:34 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-238.web.vodafone.de. [109.43.176.238])
        by smtp.gmail.com with ESMTPSA id bk6-20020a05620a1a0600b00775afce4235sm4189754qkb.131.2023.10.25.07.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 07:15:33 -0700 (PDT)
Message-ID: <8af7e036-1be2-4bb3-9ae8-3ee4aa49b00a@redhat.com>
Date:   Wed, 25 Oct 2023 16:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hexagon: Remove unusable symbols from the ptrace.h uapi
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        linux-hexagon@vger.kernel.org, Brian Cain <bcain@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>
References: <20231025073802.117625-1-thuth@redhat.com>
 <5e5e3e9b-dc16-428c-bd7f-d723960beb3c@app.fastmail.com>
From:   Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5e5e3e9b-dc16-428c-bd7f-d723960beb3c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 15.59, Arnd Bergmann wrote:
> On Wed, Oct 25, 2023, at 09:38, Thomas Huth wrote:
>> Kernel-internal prototypes, references to current_thread_info()
>> and code hidden behind a CONFIG_HEXAGON_ARCH_VERSION switch are
>> certainly not usable in userspace, so this should not reside
>> in a uapi header. Move the code into an internal version of
>> ptrace.h instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   I've compile tested it now with a hexagon cross-compiler and the kernel
>>   compiles fine with this change, so I think this should be good to go.
> 
> I've applied this to the asm-generic tree, thanks for the
> patch.

Thanks!

>> +++ b/scripts/headers_install.sh
>> @@ -74,7 +74,6 @@ arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_16K
>>   arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_4K
>>   arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
>>   arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
>> -arch/hexagon/include/uapi/asm/ptrace.h:CONFIG_HEXAGON_ARCH_VERSION
>>   arch/hexagon/include/uapi/asm/user.h:CONFIG_HEXAGON_ARCH_VERSION
>>   arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
>>   arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
> 
> Would you like to send another patch for the other hexagon
> file? It looks trivial enough as we can just drop the #if
> portion there and keep the #else side.

Looks like we have at least to look carefully at 
arch/hexagon/kernel/ptrace.c first ... pad1 is still used there and the of 
offsetof(struct user_regs_struct, pad1) results in different values 
depending on the CONFIG switch ... but sure, I can have a try to come up 
with a patch.

  Thomas


