Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB17F75FB72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGXQGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGXQGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:06:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2848AE77
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:06:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-314417861b9so3330002f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1690214793; x=1690819593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+ib0MlbVZNBxUgmF97O5Jqag54J/DdLjG5aSWaFJmo=;
        b=IQWtv0aahQOHbWNwqsNZYRpTFUiK68C2D5dU50ZrG6kzrwoDx65mohuskQAp3R8pUN
         LgvVaS8v2FFEDywHb9ZWwUBtXSQdfGpU0CsQv1ShRcHHMT2q4YwC0bXH7D/gAC9ZOsvz
         BC+7txsE4gyRmiZAdUm+cBcwAWKSZmA6UDrq/dQxM3dNXbelegfCt9NMTmlhZjqmmRHy
         KnbSruGGRx8RIf74N2EJIGG0mcm/1V38bAJK0wTSPUn0bWl4IyqZjX6DuS9VtCGbMz1Z
         CaC2jdV7FcpZpk+Jx4MC2KRcGsxG4x5UpNt6ZIMpAJCue8xdzLi0Tez5o7Z5thgolhpo
         HwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214793; x=1690819593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+ib0MlbVZNBxUgmF97O5Jqag54J/DdLjG5aSWaFJmo=;
        b=ElP6is/HlNH6mhE+p8abbu1ZjuyJUrp6hc5zPup51nAAYDMcmwTrX/d+tzbnd/DP68
         Q8UVaM/I7mVjCa17wCFwuUcExaaM/rpYUnhbmd/AQgubBOzvNe42lbmmxEpQBbgcUOI8
         lggsAD7q7UUHxv7NptoRSmrI0Z6zTvEEq8EPjR9ofevT6unIsTyJvNWMdHdhtnJ5YeNE
         Qi6u912YyUgVBEVpvYAdzZOdb/SIKBzI/UN/GvS2/rGnThBCgUPuBAdRh+tMT60KaN8T
         7QnZEjXTBGCbeZRB2qnnc9dOnzqzbzqxaqT+ZCCi9ONdppWhQEhzjlpY87UJESt1ZB2a
         LP8w==
X-Gm-Message-State: ABy/qLZNpJT+bUc1GiidGXjsNo4GHclw6QOdHY06WGcITadOhITGS38m
        WZkuNInA5QojFRz6nz5yKeI3lQ==
X-Google-Smtp-Source: APBJJlH3DUQ6cazT+GTkEMgeVC/zEQzDaoM5k7cPnunAYOxdj1epkPEM28oWBqOkqTdu7DI1j+7IVg==
X-Received: by 2002:adf:f411:0:b0:314:370f:e92c with SMTP id g17-20020adff411000000b00314370fe92cmr7831032wro.67.1690214793552;
        Mon, 24 Jul 2023 09:06:33 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h17-20020adffd51000000b0030fa3567541sm13423686wrs.48.2023.07.24.09.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:06:32 -0700 (PDT)
Message-ID: <db7bc3ce-dea0-9abe-9b06-300c10c37759@arista.com>
Date:   Mon, 24 Jul 2023 17:06:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8.1 net-next 01/23] net/tcp: Prepare tcp_md5sig_pool for
 TCP-AO
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
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
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
        Steen Hegelund <Steen.Hegelund@microchip.com>
References: <20230721161916.542667-1-dima@arista.com>
 <20230721161916.542667-2-dima@arista.com> <ZL54mOdTzX5Z9Fji@corigine.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <ZL54mOdTzX5Z9Fji@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 7/24/23 14:11, Simon Horman wrote:
> On Fri, Jul 21, 2023 at 05:18:52PM +0100, Dmitry Safonov wrote:
> 
> Hi Dmitry,
> 
> some minor nits from my side.
> 
> ...
> 
>> +/**
>> + * tcp_sigpool_start - disable bh and start using tcp_sigpool_ahash
>> + * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_ahash()
>> + * @c: returned tcp_sigpool for usage (uninitialized on failure)
>> + */
>> +int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c);
>> +/**
>> + * tcp_sigpool_end - enable bh and stop using tcp_sigpool
> 
> nit: as this is a kernel doc, please document @c here.

Thanks, yeah, I also noticed that on netdev/kdoc and there are some
other nits on the patchwork that Intel's build bot didn't report to my
surprise. Will address them in v9.

>> + */
>> +void tcp_sigpool_end(struct tcp_sigpool *c);
>> +size_t tcp_sigpool_algo(unsigned int id, char *buf, size_t buf_len);
>>  /* - functions */
>>  int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
>>  			const struct sock *sk, const struct sk_buff *skb);
> 
> ...
> 
>> @@ -1439,8 +1443,7 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
>>  			const struct sock *sk,
>>  			const struct sk_buff *skb)
>>  {
>> -	struct tcp_md5sig_pool *hp;
>> -	struct ahash_request *req;
>> +	struct tcp_sigpool hp;
>>  	const struct tcphdr *th = tcp_hdr(skb);
>>  	__be32 saddr, daddr;
> 
> nit: please consider using reverse xmas tree - longest line to shortest -
>      for these local variable declarations.
> 
> 	const struct tcphdr *th = tcp_hdr(skb);
> 	struct tcp_sigpool hp;
> 	__be32 saddr, daddr;
> 
> Likewise, elsewhere, when it can be done without excess churn.

Yeah, fail enough, I usually keep it Xmas-like, but sometimes they slip
in unnoticed. I'll take a look over the patches.

Thanks,
            Dmitry

