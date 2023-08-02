Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B8F76D7F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjHBThe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjHBThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:37:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A34199F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:37:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbea147034so2427595e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1691005047; x=1691609847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ahAlRKVh2qqPAslZ51dpS/DWGGLvZdWXysgAY2PBxWs=;
        b=kHXi2luD3prdey21xgxqSBbpnT13tSSTLJFJSZ8XwEY3EghTbdtyggJtm5Qb7Mqz07
         nyyHNsQJikHRK1TTvv5wb/M6qvjg+8v2LFK0XfmDRF0jz81Gbq8IyTnOWfdhe5aijSlj
         loriS7FaGm9r4Gt+kEnYa0sFCg4J5DVBOfhjvH0hgo8y8XSrGSUXYe0e0nMr7dhKoELr
         qsRhSj0h3E/e60BI8YR3UmMjYRIGf3NHJv9igceVPxJ43bnY3pxD6NwduO2Kk/O1IiDM
         tE5ACLuD3WcDva1LNDgR4d2pB6L/FnoAvztH+lvGKKU4/iowTk3s/IZWjDt0xbQbehEO
         LWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691005047; x=1691609847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahAlRKVh2qqPAslZ51dpS/DWGGLvZdWXysgAY2PBxWs=;
        b=anEsDDOvSIDga0yXViNnYUv3AkjkS1vo1suCHq1QyEZpN9xhRagulIe0JImTIYgL6Y
         4eBJu2JM5R0AkkItv6OZ0KgXeQplVnRxZFi5mlwVnP0pysS553lZCA1rIziT5qgo21Ow
         dF6mB6fevNwW4zpdn0EUEHWN7py3tlrAx6hAwAGZuIPGPxfmtC7GRisof+5Vi01pI9XK
         fDAXCK+19NHons6mRyzT0a1Or+dzcRUYOftZz5RqlnUxyxrKRVan2SdtcQvSewbZB0GM
         +lXTTpjQHElch75BWAKYjqCGNvawzKHdBjISBbAHmdoysZ8F0MJp2ceoiXfp6X+WBD1C
         xaVA==
X-Gm-Message-State: ABy/qLaIqD4ZCGaeRFeuwWJm6tKJI8RcbzVw8//LHyLuNauAtimY2fzV
        PgTEWxvViA/VLT/VPGaX9kecZA==
X-Google-Smtp-Source: APBJJlHDi/3DhZH0eCqhL4+vU3nmScgw5Jce45AovH3P/oAJ2wOXJe7CrrVn8XcSPOeCamhp4RmTgw==
X-Received: by 2002:a7b:c3d6:0:b0:3fb:ef86:e30 with SMTP id t22-20020a7bc3d6000000b003fbef860e30mr5341767wmj.10.1691005047437;
        Wed, 02 Aug 2023 12:37:27 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b003fc015ae1e1sm2465321wmj.3.2023.08.02.12.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 12:37:26 -0700 (PDT)
Message-ID: <0c201b3e-fc3a-4cee-b056-8338da7261b9@arista.com>
Date:   Wed, 2 Aug 2023 20:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 net-next 00/23] net/tcp: Add TCP-AO support
Content-Language: en-US
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <simon.horman@corigine.com>
Cc:     linux-kernel@vger.kernel.org,
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
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230802172654.1467777-1-dima@arista.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <20230802172654.1467777-1-dima@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Simon

I've realized that he wasn't in Cc list, albeit provided valuable
feedback in v8. Sorry about it, definitely going to Cc on next versions.

On 8/2/23 18:26, Dmitry Safonov wrote:
> Hi,
> 
> This is version 9 of TCP-AO support. It's based on net-next as
> there's a trivial conflict with the commit dfa2f0483360 ("tcp: get rid
> of sysctl_tcp_adv_win_scale").
> 
> Most of the changes in this version address Simon's reviews and polish
> of patch set to please netdev/patchwork. I ran static analyzers over it,
> there's currently only one warning introduced, which is Sparse's context
> imbalance in tcp_sigpool_start(). I've spent some time trying to silence
> it, here are my findings:
> - __cond_acquires() is broken: refcount_dec_and_lock() produces Sparse warning
> - tried __acquires() + __releases(), as in bpf_sk_storage_map_seq_find_next(),
>   yet it doesn't silence Sparse
> - I thought about moving rcu_read_unlock_bh() out of tcp_sigpool_start(),
>   forcing the callers to call tcp_sigpool_end() even on error-paths, but:
>   it feels wrong semantically and I'd have to initialize @c on error-case
>   and check it in tcp_sigpool_end(). That feels even more wrong.
> I've placed __cond_acquires() to tcp_sigpool_start() definition,
> expecting that Sparse may be fixed in future to do proper thing.
> Worth mentioning that it also complains about many other functions
> including: sk_clone_lock(), sk_free_unlock_clone(), tcp_conn_request()
> and etc.
> 
> Also, more checkpatch.pl warnings addressed, but yet I've left the ones
> that are more personal preferences (i.e. 80 columns limit). Please, ping
> me if you have a strong feeling about one of them.
> 
> Worth mentioning removing in-kernel wiring for TCP-AO key port matching:
> it was restricted in uAPI and still it is. Removing from initial TCP-AO
> implementation port matching as it can be added post-merge.
> 
> The following changes since commit 34093c9fa05df24558d1e2c5d32f7f93b2c97ee9:
> 
>   net: Remove duplicated include in mac.c (2023-08-02 11:42:47 +0100)
> 
> are available in the Git repository at:
> 
>   git@github.com:0x7f454c46/linux.git tcp-ao-v9
> 
> for you to fetch changes up to c1cf20fddf71a9ae9f07cb04a5a1efcce156c5ab:
> 
>   Documentation/tcp: Add TCP-AO documentation (2023-08-02 17:28:15 +0100)
> 
> ----------------------------------------------------------------
> 
> And another branch with selftests, that will be sent later separately:
> 
>   git@github.com:0x7f454c46/linux.git tcp-ao-v9-with-selftests
> 
> Thanks for your time and reviews,
>          Dmitry
> 
> --- Changelog ---
> 
> Changes from v8:
> - Based on net-next
> - Now doing git request-pull, rather than GitHub URLs
> - Fix tmp_key buffer leak, introduced in v7 (Simon)
> - More checkpatch.pl warning fixes (even to the code that existed but
>   was touched)
> - More reverse Xmas tree declarations (Simon)
> - static code analysis fixes
> - Removed TCP-AO key port matching code
> - Removed `inline' for for static functions in .c files to make
>   netdev/source_inline happy (I didn't know it's a thing)
> - Moved tcp_ao_do_lookup() to a commit that uses it (Simon)
> - __tcp_ao_key_cmp(): prefixlen is bits, but memcmp() uses bytes
> - Added TCP port matching limitation to Documentation/networking/tcp_ao.rst
> 
> Version 8: https://lore.kernel.org/all/20230719202631.472019-1-dima@arista.com/T/#u

[..]

Thanks,
          Dmitry

