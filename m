Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F67792F70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242303AbjIEUEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbjIEUEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:04:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB61FA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:04:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so2375324f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1693944256; x=1694549056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rAHXFSmpuYMwhbTe94DCn7ImjiGtbOJCwz/57HmnOlE=;
        b=jM/lXP4BRz61PD4Y8IlEAj/GMUfPeiVKwjIyA2CHB7bcONsW8b0x+XuVmi/8kQwSVQ
         ZYSvZ1pS3H2Ug3uAjSwmza4zezY/ZXmYJnnFUjs0ObE3mAV+An/tTsPl2mmALxD8GOKk
         HOIVPNMZz3YbhGHziCLh/mFxAWaoD//65DHU60DrRybHUHLdnp34mwuzWnJa/C878hRT
         Z2yvRYY8nzJQFZIzHZeTf33GLdR4Hb1beVCyDi4vZIEObOLgVEgn7DF2WzSm45Qoul33
         T1pq4t1QvefRulVRgE+hj1nw9m/jTSQbS5Bte0fwccBqdm9wSNa1p6igcKNmfAopZEq3
         gk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693944256; x=1694549056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAHXFSmpuYMwhbTe94DCn7ImjiGtbOJCwz/57HmnOlE=;
        b=O6lhDQ+/3lYTmtxPhRVln6KAO+CRabcOoQwL2f6yp28+gCZk33sFuKNJWV+MuGg6y1
         YDLBJy9cWBMGbT9dCraHEVVGSqobpYVnowBvNc/uiJToZMolmj7NvQYl5ATvnbDTMuUg
         yNs0sHKp6x7J/8rjLGt+I8QHl99Z+SsxrJjuRMkd6Sve5AZJyZNPVNYVd4/3uH0Umuy0
         +3Ac75J1JE32Shb2MXUJAQcERFDJhmXbwC1C+4HMm+VsiE2rMg16o1RMZTUsDCK0iE2I
         pNp220yieXbB0kwCcJCK74+y6AF516qQaKgtH2nyk0Qh32coRDBkrlItK9HimvCt8Je8
         7xoQ==
X-Gm-Message-State: AOJu0YwU8ksRrTxDB/YpiIaCPqZdOzoxirA06MopmraZ4aoScqrFwZLa
        L2GmLfsGWVnLj7Z8Mzn8eXD6rA==
X-Google-Smtp-Source: AGHT+IHelAJ8rhTH2NaDH74hFo3y+fgZsyTP3gVU0H1zG3eGW4P05qp7T1e/T0gSXJZN2+HinXwBvQ==
X-Received: by 2002:adf:dec1:0:b0:317:731c:4d80 with SMTP id i1-20020adfdec1000000b00317731c4d80mr638853wrn.24.1693944255699;
        Tue, 05 Sep 2023 13:04:15 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id i16-20020adfefd0000000b0031c5d74ecd8sm18401955wrp.84.2023.09.05.13.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 13:04:15 -0700 (PDT)
Message-ID: <973ddaf6-0725-8bae-f90b-7921e0104e24@arista.com>
Date:   Tue, 5 Sep 2023 21:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 net-next 08/23] net/tcp: Add AO sign to RST packets
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
 <20230815191455.1872316-9-dima@arista.com> <ZNy3+f6ZtDKfsQ5C@vergenet.net>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <ZNy3+f6ZtDKfsQ5C@vergenet.net>
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

Hi Simon,

Sorry for the delayed answer, I went on a vacation.

On 8/16/23 12:50, Simon Horman wrote:
> On Tue, Aug 15, 2023 at 08:14:37PM +0100, Dmitry Safonov wrote:
[..]
>> +	if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, reply->seq,
>> +				 &key, &traffic_key, &allocated_traffic_key,
>> +				 &keyid, &ao_sne))
> 
> Hi Dmitry,
> 
> The type of the 4th parameter of tcp_ao_prepare_reset() (seq) is u32,
> but here a __be32 value is passed.

Yeah, it gets converted in patch "net/tcp: Add TCP-AO sign to twsk".

> Also, it seems that parameter is unused by tcp_ao_prepare_reset().

And only gets used in "net/tcp: Add TCP-AO SNE support".

Hard times when you keep changing the patch set, eventually some nits
and bits get introduced in earlier patches only to be modified by later.

What's worse, I can see that seq is getting used as ntohl(seq) and
tcp_v6_send_reset() does htonl(seq). So, it's better be u32 argument,
introduced by SNE patch, rather than gets converted to-and-back.

Thanks for noticing!

[..]

-- 
           Dmitry

