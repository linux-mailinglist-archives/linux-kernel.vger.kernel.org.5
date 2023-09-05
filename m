Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79418792F79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbjIEUH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjIEUHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:07:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C73AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:07:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so29418205e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1693944441; x=1694549241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=spuMELZAIK25d9LF4p1nwmtF1Z+Tv/kzkeUVaMdUjGk=;
        b=Cke1oE+NHumFTd/QMXVEw+nwznxEltZXbEcGcYoVZqAgI53tii3YSoRX/PGd80G2XO
         xuiWv8pJL/kKt8ESlvfB3dB+Q2pINDBcpPWbI29q1Ncly4L/llczZLcdpVC7zXlwLjQi
         1vhBRU/G875Xj8hnOmb72qyARwDNwP3/vJMWWmUZSwBSBiXe1FYoHQED0w3sCQpvr1Oy
         kppKPSzDD/vy0tf0ZhTt4rjNMvRSstmKRmKuGHB+tjfiM6kMzmm1xpwIF3zDGolF0Tyt
         l5AWR6TEFXOPrBwUBxEtD/Iny+UTdXCzBeVV26AYUKk8KyZx4uQbRM9aXHz5NbpAfLMx
         +E+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693944441; x=1694549241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spuMELZAIK25d9LF4p1nwmtF1Z+Tv/kzkeUVaMdUjGk=;
        b=X/N/PtGkRiXA9K//kgfqImAfJs6vqdqYZjZ4w72SFJY6dnGhKudy3o473B+WPSNw/U
         tje47yVu34A5wHrDjFODaoevWu+fP2ETO80mqi7UxQFrHj00fzacs8fUHJOlAJn2aJcv
         17un8380ijgHt27v34vZGl0/i3ed+h3v7C3RskzKTI86Ko2T0ph/B2ECZfeyqkgDqIbE
         OPVjeOfkGFZiGRGOoJ1P6tXdrVsLyvN3/lSFkNJU6cWKZkbU7SXmzbS4wlm+zZAqBNPp
         yHm/aV0WXTqZShjj65WuUBnX7eVrQvRDE0gG8xx4YPjkHRXIDBSXeGuc7zsxX0puO+Ty
         xs9g==
X-Gm-Message-State: AOJu0Yxvzq1MphXcdszMWfShUpx1L9lM16iRx8oHTH6VcJwo3Z7voj+a
        qr8gQX4EuzZ1CEkLBq1V4PfIuw==
X-Google-Smtp-Source: AGHT+IFuAK9xqudXSSiNQNp2+PdZSC2Sh6T0PSGyQ357ScwCvVeLtVGFD8Hgd4zd2DNLWPQAMUwOYw==
X-Received: by 2002:a05:600c:2409:b0:3fa:97ad:2ba5 with SMTP id 9-20020a05600c240900b003fa97ad2ba5mr626043wmp.31.1693944440998;
        Tue, 05 Sep 2023 13:07:20 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00317ab75748bsm18411054wrr.49.2023.09.05.13.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:07:20 -0700 (PDT)
Message-ID: <c522dfe0-207e-a005-452c-552d3663d413@arista.com>
Date:   Tue, 5 Sep 2023 21:07:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 net-next 09/23] net/tcp: Add TCP-AO sign to twsk
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
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
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
References: <20230815191455.1872316-1-dima@arista.com>
 <20230815191455.1872316-10-dima@arista.com> <ZNy7A17n3BrMuh1b@vergenet.net>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <ZNy7A17n3BrMuh1b@vergenet.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/23 13:03, Simon Horman wrote:
> On Tue, Aug 15, 2023 at 08:14:38PM +0100, Dmitry Safonov wrote:
> 
> ...
> 
>> @@ -1183,6 +1216,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>>  			ipv6_get_dsfield(ipv6_hdr(skb)), 0,
>>  			READ_ONCE(sk->sk_priority),
>>  			READ_ONCE(tcp_rsk(req)->txhash));
>> +			NULL, NULL, 0, 0);
> 
> Hi Dmitry,
> 
> This seems to add a syntax error.
> 
> ...

Rectified by "net/tcp: Wire TCP-AO to request sockets".

Likely, an artifact from the rebase over READ_ONCE() for txhash.

I will correct it in v11, thanks for noticing!

-- 
          Dmitry

