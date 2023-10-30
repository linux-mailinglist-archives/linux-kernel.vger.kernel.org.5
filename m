Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD67A7DBF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJ3RpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjJ3RpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:45:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9FCC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:44:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40839807e82so28416515e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1698687896; x=1699292696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7al2b/2zhByEaCyFJyvoG/06fDJKEZg/ESJAS5x0TA=;
        b=VGqYZiGZzmjyix7uT77D06o16aWVjTl1Gz5QqNMwSwQ/gZEWEGox5RbWZQRASCmB+8
         X1NRklyAHeFaHjaRPvzvek5tSRTZtUIPVpxU3LK4rS1QwQmK93yvCuj5fBmBI/z9rBQh
         cxebdeDTIXPNNwRBOwcFh4IOj+sMiGWPk8FhYEy7wRYecT/2lVHluyfNmHC9pYIpiI8Z
         7FDRDWA/G+00cerbq4C17nOfNvfMgFoUomNIEOBlzDBhdedyI+qCGnE70lWBAVROiZCM
         XB0xktEgT+joSxF3UVdr+QLJNuu+VVucVA2IgYIi0iITQ53J7IFPQeaYVIC6RHzD2Frg
         BeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687896; x=1699292696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7al2b/2zhByEaCyFJyvoG/06fDJKEZg/ESJAS5x0TA=;
        b=SaOFUONatvsMSKt29ZiAZUO5gzh4EOwO1FBQJJafwNH/ZrZCosty5Ov8SmV0F6JKNr
         xs8MaGlJghQTdqh8LGsWSx6FB0U7NSIzrE6fC/L5M1CzHJrYLhLpBPyP9PHQ5Tows9zP
         yFtp5rLRH4Jxc496BQsMjS3Q3j6j0o/RGnY5L52r85O1JLLUcIah8qtYSOzxF1tarOH7
         u0PiiRlOKEMqqAIoT+OdQzkbLu7Yz+/CRgm3gtVVQ4c+/FJhRMnP65THwZ8qu0oivFOW
         wlLi+pn0ZqHeo0OjUkZheihhxMUMHCxhMUyDa83qtDgOs7rVLWE5rN9Sopa7yv5Lz4dS
         NyXA==
X-Gm-Message-State: AOJu0Yy1rnFsBxpNVV95Qb/OUkXSmOyK6339LNGc9DbiPcb0edOvRzM2
        dk8/yiZYf591WicVnrivRtwTDw==
X-Google-Smtp-Source: AGHT+IHjVsfeQaLVAw8QRYpPOrXmkuIn9PR0bd/WaTnyVSvIBK/qVIcRCXGKCUX/5vQZrKyO2idimw==
X-Received: by 2002:a1c:7405:0:b0:405:29ba:9b5c with SMTP id p5-20020a1c7405000000b0040529ba9b5cmr381850wmc.16.1698687896491;
        Mon, 30 Oct 2023 10:44:56 -0700 (PDT)
Received: from ?IPV6:2a02:8084:2562:c100:228:f8ff:fe6f:83a8? ([2a02:8084:2562:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b004064ac107cfsm9931435wmq.39.2023.10.30.10.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 10:44:55 -0700 (PDT)
Message-ID: <cd025d15-4e2b-4727-a10b-a6da98af4058@arista.com>
Date:   Mon, 30 Oct 2023 17:44:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the crypto tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Salam Noureddine <noureddine@arista.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <20231030155809.6b47288c@canb.auug.org.au>
 <20231030160953.28f2df61@canb.auug.org.au>
 <ZT896a2j3hUI1NF+@gondor.apana.org.au>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <ZT896a2j3hUI1NF+@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/23 05:23, Herbert Xu wrote:
> On Mon, Oct 30, 2023 at 04:09:53PM +1100, Stephen Rothwell wrote:
>>
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Mon, 30 Oct 2023 15:54:37 +1100
>> Subject: [PATCH] fix up for "crypto: ahash - remove crypto_ahash_alignmask"
>>
>> interacting with "net/tcp: Introduce TCP_AO setsockopt()s"
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>>  net/ipv4/tcp_ao.c | 6 ------
>>  1 file changed, 6 deletions(-)
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Reviewed-by: Dmitry Safonov <dima@arista.com>

> If we simply apply this patch to the netdev tree then everything
> should work at the next merge window.  But perhaps you could change
> the patch description to say something like remove the obsolete
> crypto_hash_alignmask.  It's not important though.

Thank you,
           Dmitry

