Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700407C5DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346466AbjJKT0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjJKT0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:26:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C5590
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:26:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405524e6768so2782685e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697052397; x=1697657197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+gO0mSqDg4QcIxRFz2gaAfqVGzM5xR2uCtXj7Go17g=;
        b=brCOFB3IvobTXtT9+5AIdqfaaIn/h8BnwDMZIr4QXkfJYKxzfvpxrhmA38SKqhw39x
         2g5sE/JbBJpr0MwiYaylm99ZrvP8/JUB0fknE2H3WPwiT432roRwC9xXoxpajkkDX1yR
         b482KF0NVkFC/Lvr1zQVwebSDafBcRYojiIEwvVHGOCGXVTf2cXcxstB8f4MTslJgF/W
         /4/eYRQmQURp4/8htFmvBLs70NmTLI4Qq+ILJP3onBKrvhEF+h6AiaA5P0IrADyQHcE5
         kcAZ2GCG5Eu3/q0GoE7/GhYuF7nSSTIEz+bm5lavjJSWC8Y3+5akh3FTWUGZhZYL2smW
         WUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697052397; x=1697657197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+gO0mSqDg4QcIxRFz2gaAfqVGzM5xR2uCtXj7Go17g=;
        b=d9hRgKmexzU5AuK6ChRgLCgjFGVFMztw1O5FMxa3F/0f9u2bwtldbZ2oqrAV1qz9BN
         tUSmD3viyqi4MtzIU5fhARpYD6KfajMGoS55P7jKZq5+BYncZUSdysj9JrJXE6JUbP8S
         u8Nu89KhxTw0l99koPeNTBO+xCXINM054mqH6i7dY1IC1ZB2moQH2OTz4r0L/bMYDNgx
         UVEtkich08Tx7357W1oJ4DmqZLJ2QPWMufC4BDfTqVinTzOaLdL6x91JGkiiVAa6Mvpj
         I5Q6K6N+9eUPl+DzakCFH+q6Ml357lGilSMJ8OS9OePsGAHCjxWFwVsL3eMzbYDF6CCH
         5Zsg==
X-Gm-Message-State: AOJu0Yw/a5IOOaUPQNGhZvVpMjfDUs3wflDkDHhfH5UFMNM5uwQXoV3x
        CUioAkde5fhuGIn7+lmq0Z0EQA==
X-Google-Smtp-Source: AGHT+IGVTItGcrefYtBoo/699f/08MHZ4RycfQIrEArC8+mialu1KWxKMnQ1J1lh+WVeCHzvIi8Luw==
X-Received: by 2002:a7b:c5c9:0:b0:403:272:4414 with SMTP id n9-20020a7bc5c9000000b0040302724414mr19441809wmk.0.1697052397010;
        Wed, 11 Oct 2023 12:26:37 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k14-20020a05600c0b4e00b003fe1fe56202sm17602323wmr.33.2023.10.11.12.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 12:26:36 -0700 (PDT)
Message-ID: <4bde3c5d-7c58-4e78-a3fa-8f7c5f71a9bb@arista.com>
Date:   Wed, 11 Oct 2023 20:26:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 09/23] net/tcp: Add TCP-AO sign to twsk
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
References: <20231009230722.76268-1-dima@arista.com>
 <20231009230722.76268-10-dima@arista.com>
 <CANn89iLD=ySFfPYkrb+oN2fuMhimxXfHrhs4Pv9_60f912rzmQ@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iLD=ySFfPYkrb+oN2fuMhimxXfHrhs4Pv9_60f912rzmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 19:10, Eric Dumazet wrote:
> On Tue, Oct 10, 2023 at 1:07 AM Dmitry Safonov <dima@arista.com> wrote:
[..]
>>  static inline struct tcp_timewait_sock *tcp_twsk(const struct sock *sk)
>> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
>> index 629ab0365b83..af2caf7e76fc 100644
>> --- a/include/net/tcp_ao.h
>> +++ b/include/net/tcp_ao.h
>> @@ -85,6 +85,7 @@ struct tcp_ao_info {
>>                                 __unused        :31;
>>         __be32                  lisn;
>>         __be32                  risn;
>> +       atomic_t                refcnt;         /* Protects twsk destruction */
> 
> This needs to be a refcount_t

Sure, sounds good.

Thanks,
           Dmitry

