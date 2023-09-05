Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E42792FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjIEUYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbjIEUYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:24:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FDC127
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:24:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c3df710bdso2290780f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1693945479; x=1694550279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgbF9uOxTZjSH/uNRsPozuzPS7Kjt3TnMWh+9q/pH2w=;
        b=X519hhwlLKj7fJEZvhwaIDgcSxcBE87XglBs+/xfqimOPY2N+HdoDFQjCsUDoBKk6R
         JmD/8zGmlqVplDdPFILYkivf9EGoovrHQI4aGszngNbcJkgVOhc6gUsVhWcUYCMJAiU2
         OaKb5cGSm3ufAbUANXcp6q7fiLOyKjU8OujOu/U3U/JLL1+7kRbZ3S/LmSaR48iROt5U
         hviOtvFyzV1HAKRvCZbdAwSMMCxeYEKUexMHy/iO5zeAGhK3NdrvTALNqA5XdOtVCaXM
         cYWB5YVUGffg5w1axdbpk7SNVYPlC1BumqxZaZRam7LgOcWiO51Y/649euZelgGfePoK
         AcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945479; x=1694550279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgbF9uOxTZjSH/uNRsPozuzPS7Kjt3TnMWh+9q/pH2w=;
        b=WiuRFw675k7VK2GQAGqoCf27c7Q0E31Aa3CQ6o8upzFiIZBMdRTgdZ70dHVvZgltHZ
         l1N0ZCxOj2aA5HhbieqevQm4jBn33duYTTmXD/qrexUTSTKDUhJ+wSAJvCx0vbeTrbm6
         Yx7wHqUHl4Oen6nCmxVn0ysC3MuCWkb7TkSBkzUf8cvxOznlwl+cOPwY9Hgh6uRzIzqO
         Lf921u6mP0UfHhvJMiID7DVQR37MB5RrFIL7mVP/Y2lvHhDvoJMbfMHHr7yV1nj5/kb2
         DIQtihrMqQj0dYhbboabjh9PRVbTAmmNHTtrd0OYDIAsdfl/vOequ3O5tv4SbaoHVv/n
         7HJQ==
X-Gm-Message-State: AOJu0YzXsmp9E1Ek3uy4wBd73N6spMtllN0RM4ADHz0urLRX8eC1UoOw
        9I8N9lo2xvjWJb1MVIoy9TlB6SaJEhFLxeLTiyM=
X-Google-Smtp-Source: AGHT+IH53IUU3JFOTw9CAL5+eP3zFCWyMGbbYGxItDGp2qv+H6hwIqnHfRh4YPGocX979pKSeTexfA==
X-Received: by 2002:adf:e648:0:b0:317:50b7:2ce3 with SMTP id b8-20020adfe648000000b0031750b72ce3mr680842wrn.51.1693945479151;
        Tue, 05 Sep 2023 13:24:39 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm18121138wro.43.2023.09.05.13.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:24:38 -0700 (PDT)
Message-ID: <ed11d178-0762-4f87-804d-034b9715727c@arista.com>
Date:   Tue, 5 Sep 2023 21:24:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 net-next 10/23] net/tcp: Wire TCP-AO to request
 sockets
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
 <20230815191455.1872316-11-dima@arista.com> <ZN0nQqIwXp5cQJTR@vergenet.net>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <ZN0nQqIwXp5cQJTR@vergenet.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/23 20:45, Simon Horman wrote:
> On Tue, Aug 15, 2023 at 08:14:39PM +0100, Dmitry Safonov wrote:
[..]
>> @@ -1194,9 +1198,51 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
>>  static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
>>  				  struct request_sock *req)
>>  {
>> +	struct tcp_md5sig_key *md5_key = NULL;
>> +	const struct in6_addr *addr;
>> +	u8 *traffic_key = NULL;
>>  	int l3index;
>>  
>>  	l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
>> +	addr = &ipv6_hdr(skb)->saddr;
>> +
>> +	if (tcp_rsk_used_ao(req)) {
>> +#ifdef CONFIG_TCP_AO
>> +		struct tcp_ao_key *ao_key = NULL;
>> +		const struct tcp_ao_hdr *aoh;
>> +		u8 keyid = 0;
> 
> Hi Dmitry,
> 
> keyid is declared and initialised here.
> 
>> +
>> +		/* Invalid TCP option size or twice included auth */
>> +		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
>> +			return;
>> +		if (!aoh)
>> +			return;
>> +		ao_key = tcp_v6_ao_do_lookup(sk, addr, aoh->rnext_keyid, -1);
>> +		if (unlikely(!ao_key)) {
>> +			/* Send ACK with any matching MKT for the peer */
>> +			ao_key = tcp_v6_ao_do_lookup(sk, addr, -1, -1);
>> +			/* Matching key disappeared (user removed the key?)
>> +			 * let the handshake timeout.
>> +			 */
>> +			if (!ao_key) {
>> +				net_info_ratelimited("TCP-AO key for (%pI6, %d)->(%pI6, %d) suddenly disappeared, won't ACK new connection\n",
>> +						     addr,
>> +						     ntohs(tcp_hdr(skb)->source),
>> +						     &ipv6_hdr(skb)->daddr,
>> +						     ntohs(tcp_hdr(skb)->dest));
>> +				return;
>> +			}
>> +		}
>> +		traffic_key = kmalloc(tcp_ao_digest_size(ao_key), GFP_ATOMIC);
>> +		if (!traffic_key)
>> +			return;
>> +
>> +		keyid = aoh->keyid;
> 
> And reinitialised here.
> But is otherwise unused.
> 
> Flagged in a W=1 build with both clang-16 and gcc-13.

Thanks, will be fixed in v11.

Seems to be another rebase-artifact.
I'll also take a look how didn't I notice this on tests, they probably
need a new selftest for this.

-- 
          Dmitry

