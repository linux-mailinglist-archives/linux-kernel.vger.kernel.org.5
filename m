Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0093A76231E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGYUQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGYUQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:16:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EAA19AD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:16:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so59064415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1690316205; x=1690921005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0G3MJcvlh50tjHIhX84jyKiKeq3oJ9h5jmmEE6B1CY=;
        b=QTohGC6rYWkTAV4tuF6CGONiML+Cx7KlKfmuZFcFK9MHb9VZ3DDF1eUZK/5j0Jxjef
         6bcpULBh1w3W639bS6tHKWd0T9e1MlcuzPG3YI7qFT4OoaEvWbyckhhIAl7OPwnS/Ax8
         20+yeXvazcLawyTjAxgPyK4LPdFZVWApOlNJQZwaRapNgRIHsZIMAOAfkREkVXdlHe2b
         V9tZbdJi7DBFEaEvorgBMpj8nZEJmi9+ypnMMutLG66aSzU4YwwgjlF+0gfUm9WKrJAQ
         RU1XdRXa+Tx0dq+TYqO2vG3pvJaUBbDsAQIgvbaKJJ8MDqsPhrHhBJjPjL77hbsoAo77
         +ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690316205; x=1690921005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0G3MJcvlh50tjHIhX84jyKiKeq3oJ9h5jmmEE6B1CY=;
        b=ciVMRnG0MCfkDeSQf4rZLku4bDnx9eNOLoXZ2lS4B5lcuc0sfZ3zvllJa3rMy5jR/U
         avMRwL723CUG21/MhyzRuCVidAIHw2gM9zUfBaTN11awwN0J4XGGee2L1cjsH6NTslTx
         16/tDk6orouZ4U+RI6/Jb5T9P5HBAdC1VFHAqQ0DVvbfzZ80InWFOk1x5ZzWu/USPvnB
         p++Gyu3beN274TOVAJ1A5rPHRvcTdpOYjIxgSYYpWzRvY0pZsa0LULyc9GdYswqJNtBh
         GQar5Zdtw2lGLvM13kWDChsGTnYytHdZSHh187DYR34tqSRY4CKY5QSsDg4vP5e+6NoN
         21KQ==
X-Gm-Message-State: ABy/qLar8mFb0vx93TEa98mHlNUY2612v8BCXLZKjx3ciphYszvtJIeT
        4wUA1Li+6f0f0aWZqtL2UVaWYg==
X-Google-Smtp-Source: APBJJlHjclw1H8NRkLLLQBSPgEow5S93ysYrG8EVXHAgwzTUXlnElHSPJU1CD+MySrcL0B0ykmZbIQ==
X-Received: by 2002:a05:600c:2315:b0:3fa:8fc2:3969 with SMTP id 21-20020a05600c231500b003fa8fc23969mr11112883wmo.17.1690316204839;
        Tue, 25 Jul 2023 13:16:44 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c028500b003fc04eb92cbsm14210070wmk.44.2023.07.25.13.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:16:44 -0700 (PDT)
Message-ID: <732218bf-9388-e8ce-0913-d681d1302a37@arista.com>
Date:   Tue, 25 Jul 2023 21:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8.1 net-next 03/23] net/tcp: Introduce TCP_AO
 setsockopt()s
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
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
References: <20230721161916.542667-1-dima@arista.com>
 <20230721161916.542667-4-dima@arista.com> <ZL7RdEEz2nH/QFqZ@corigine.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <ZL7RdEEz2nH/QFqZ@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 7/24/23 20:31, Simon Horman wrote:
> On Fri, Jul 21, 2023 at 05:18:54PM +0100, Dmitry Safonov wrote:
> 
> ...
> 
> Hi Dimitry,
> 
>> diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
>> index bae5e2369b4f..307961b41541 100644
>> --- a/include/linux/sockptr.h
>> +++ b/include/linux/sockptr.h
>> @@ -55,6 +55,29 @@ static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
>>  	return copy_from_sockptr_offset(dst, src, 0, size);
>>  }
>>  
>> +static inline int copy_struct_from_sockptr(void *dst, size_t ksize,
>> +		sockptr_t src, size_t usize)
> 
> The indentation of the two lines above is not correct,
> they should be aligned to the inside of the opening '('
> on the preceding line.
> 
> In order to stop things being too far to the left,
> which is perhaps the intent of the current indention scheme,
> the return type of the function can be moved to it's own line.
> 
> static inline int
> copy_struct_from_sockptr(void *dst, size_t ksize, sockptr_t src, size_t usize)

Well, that would be a bit more GNU coding-style alike. Which I don't
mind, I can do that. Albeit it's a bit contrary to an example from
kernel's coding-style, where it seems preferred to keep it on the same
line with function name and rather not to indent argument list, see
(6.1), second example with action().

Yet, I don't feel particularly strong on either of options, so I can
just do as you suggest.

> 
> ...
> 
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
> 
> ...
> 
>> +static inline int ipv4_prefix_cmp(const struct in_addr *addr1,
>> +				  const struct in_addr *addr2,
>> +				  unsigned int prefixlen)
>> +{
>> +	__be32 mask = inet_make_mask(prefixlen);
>> +
>> +	if ((addr1->s_addr & mask) == (addr2->s_addr & mask))
>> +		return 0;
>> +	return ((addr1->s_addr & mask) > (addr2->s_addr & mask)) ? 1 : -1;
>> +}
> 
> Above, '>' is operating on two big endian values.
> But typically such maths operates on host byte order values.
> 
> Flagged by Sparse.

Yeah, the function just has to provide any way to compare keys.
So, it's not very important, but just to silence Sparse I can convert
them to host's byte order before the comparison.

> 
> ...
> 
>> +static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk,
>> +		const union tcp_ao_addr *addr, int family, u8 prefix,
>> +		int sndid, int rcvid, u16 port)
> 
> Same comment about indentation as above.
> 
> static struct tcp_ao_key *
> __tcp_ao_do_lookup(const struct sock *sk, const union tcp_ao_addr *addr,
> 		   int family, u8 prefix, int sndid, int rcvid, u16 port)
> 
> ...
> 
>> +struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
>> +				    const union tcp_ao_addr *addr,
>> +				    int family, int sndid, int rcvid, u16 port)
> 
> Should tcp_ao_do_lookup be static?
> It seems to only be used in this file.

Yeah, indeed. I think, I noticed previously, but probably managed to
forget. Will fix.

> 
> ...
> 
>> +static int tcp_ao_verify_port(struct sock *sk, u16 port)
>> +{
>> +	struct inet_sock *inet = inet_sk(sk);
>> +
>> +	if (port != 0) /* FIXME */
> 
> I guess this should be fixed :)

Fair enough. I think, what I'll do is to remove from these initial
patches TCP-port from uAPI: we've expected that it will be useful to
implement port-matching, but so far none from customers requested it.
So, it was left as reserved member in uAPI, not meant to be used just yet.

Separately, as I've made UAPI structures for setsockopt() extendable,
see copy_struct_from_sockptr() and the extendable syscall ideas
(unfortunately, not in Documentation/):
https://lpc.events/event/7/contributions/657/attachments/639/1159/extensible_syscalls.pdf
https://lwn.net/Articles/830666/

So, as those structs can be extended in future, it won't be any hard to
add port-matching on the top of the patch set. RFC5925 is permissive on
how IP address and TCP-port matching may be performed:

: TCP connection identifier. A TCP socket pair, i.e., a local IP
: address, a remote IP address, a TCP local port, and a TCP remote port.
: Values can be partially specified using ranges (e.g., 2-30), masks
: (e.g., 0xF0), wildcards (e.g., "*"), or any other suitable indication.

I can see some utility of TCP-AO key port-range matching and it seems
most useful/flexible, so I'll add that. Unsure if that will go in
version 9 or rather later (even post-merge).

I probably have to add something on that mater to
Documentation/networking/tcp_ao.rst as well.

>> +		return -EINVAL;
>> +
>> +	/* Check that MKT port is consistent with socket */
>> +	if (port != 0 && inet->inet_dport != 0 && port != inet->inet_dport)
> 
> port is host byte order, but inet->inet_dport is big endian.
> This does not seem correct.

Thanks.

> 
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +static int tcp_ao_parse_crypto(struct tcp_ao_add *cmd, struct tcp_ao_key *key)
>> +{
>> +	unsigned int syn_tcp_option_space;
>> +	bool is_kdf_aes_128_cmac = false;
>> +	struct crypto_ahash *tfm;
>> +	struct tcp_sigpool hp;
>> +	void *tmp_key = NULL;
>> +	int err;
>> +
>> +	/* RFC5926, 3.1.1.2. KDF_AES_128_CMAC */
>> +	if (!strcmp("cmac(aes128)", cmd->alg_name)) {
>> +		strscpy(cmd->alg_name, "cmac(aes)", sizeof(cmd->alg_name));
>> +		is_kdf_aes_128_cmac = (cmd->keylen != 16);
>> +		tmp_key = kmalloc(cmd->keylen, GFP_KERNEL);
>> +		if (!tmp_key)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	key->maclen = cmd->maclen ?: 12; /* 12 is the default in RFC5925 */
>> +
>> +	/* Check: maclen + tcp-ao header <= (MAX_TCP_OPTION_SPACE - mss
>> +	 *					- tstamp - wscale - sackperm),
>> +	 * see tcp_syn_options(), tcp_synack_options(), commit 33ad798c924b.
>> +	 *
>> +	 * In order to allow D-SACK with TCP-AO, the header size should be:
>> +	 * (MAX_TCP_OPTION_SPACE - TCPOLEN_TSTAMP_ALIGNED
>> +	 *			- TCPOLEN_SACK_BASE_ALIGNED
>> +	 *			- 2 * TCPOLEN_SACK_PERBLOCK) = 8 (maclen = 4),
>> +	 * see tcp_established_options().
>> +	 *
>> +	 * RFC5925, 2.2:
>> +	 * Typical MACs are 96-128 bits (12-16 bytes), but any length
>> +	 * that fits in the header of the segment being authenticated
>> +	 * is allowed.
>> +	 *
>> +	 * RFC5925, 7.6:
>> +	 * TCP-AO continues to consume 16 bytes in non-SYN segments,
>> +	 * leaving a total of 24 bytes for other options, of which
>> +	 * the timestamp consumes 10.  This leaves 14 bytes, of which 10
>> +	 * are used for a single SACK block. When two SACK blocks are used,
>> +	 * such as to handle D-SACK, a smaller TCP-AO MAC would be required
>> +	 * to make room for the additional SACK block (i.e., to leave 18
>> +	 * bytes for the D-SACK variant of the SACK option) [RFC2883].
>> +	 * Note that D-SACK is not supportable in TCP MD5 in the presence
>> +	 * of timestamps, because TCP MD5’s MAC length is fixed and too
>> +	 * large to leave sufficient option space.
>> +	 */
>> +	syn_tcp_option_space = MAX_TCP_OPTION_SPACE;
>> +	syn_tcp_option_space -= TCPOLEN_TSTAMP_ALIGNED;
>> +	syn_tcp_option_space -= TCPOLEN_WSCALE_ALIGNED;
>> +	syn_tcp_option_space -= TCPOLEN_SACKPERM_ALIGNED;
>> +	if (tcp_ao_len(key) > syn_tcp_option_space) {
>> +		err = -EMSGSIZE;
>> +		goto err_kfree;
>> +	}
>> +
>> +	key->keylen = cmd->keylen;
>> +	memcpy(key->key, cmd->key, cmd->keylen);
>> +
>> +	err = tcp_sigpool_start(key->tcp_sigpool_id, &hp);
>> +	if (err)
>> +		goto err_kfree;
>> +
>> +	tfm = crypto_ahash_reqtfm(hp.req);
>> +	if (is_kdf_aes_128_cmac) {
>> +		void *scratch = hp.scratch;
>> +		struct scatterlist sg;
>> +
>> +		memcpy(tmp_key, cmd->key, cmd->keylen);
>> +		sg_init_one(&sg, tmp_key, cmd->keylen);
>> +
>> +		/* Using zero-key of 16 bytes as described in RFC5926 */
>> +		memset(scratch, 0, 16);
>> +		err = crypto_ahash_setkey(tfm, scratch, 16);
>> +		if (err)
>> +			goto err_pool_end;
>> +
>> +		err = crypto_ahash_init(hp.req);
>> +		if (err)
>> +			goto err_pool_end;
>> +
>> +		ahash_request_set_crypt(hp.req, &sg, key->key, cmd->keylen);
>> +		err = crypto_ahash_update(hp.req);
>> +		if (err)
>> +			goto err_pool_end;
>> +
>> +		err |= crypto_ahash_final(hp.req);
>> +		if (err)
>> +			goto err_pool_end;
>> +		key->keylen = 16;
>> +	}
>> +
>> +	err = crypto_ahash_setkey(tfm, key->key, key->keylen);
>> +	if (err)
>> +		goto err_pool_end;
>> +
>> +	tcp_sigpool_end(&hp);
>> +
>> +	if (tcp_ao_maclen(key) > key->digest_size)
>> +		return -EINVAL;
> 
> 		tmp_key appears to be leaked here.
> 
>> +
>> +	return 0;
> 
> And here.
> 
> This is flagged by Smatch.

Ouch. Yeah, the change from v7 that got rid of TCP_AO_MAX_HASH_SIZE and
allocated traffic keys with kmalloc(), managed to add a leak as well.
Thanks, will fix.

> 
>> +
>> +err_pool_end:
>> +	tcp_sigpool_end(&hp);
>> +err_kfree:
>> +	kfree(tmp_key);
>> +	return err;
>> +}
> 
> ...
> 
>> +static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
>> +			  sockptr_t optval, int optlen)
>> +{
>> +	struct tcp_ao_info *ao_info;
>> +	union tcp_ao_addr *addr;
>> +	struct tcp_ao_key *key;
>> +	struct tcp_ao_add cmd;
>> +	int ret;
>> +	bool first = false;
>> +	u16 port;
> 
> Please use reverse xmas tree - longest line to shortest - for
> local variable declarations in new Networking code.

Will do.

> 
>> +static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
>> +			  sockptr_t optval, int optlen)
>> +{
>> +	struct tcp_ao_key *key, *new_current = NULL, *new_rnext = NULL;
>> +	struct tcp_ao_info *ao_info;
>> +	union tcp_ao_addr *addr;
>> +	struct tcp_ao_del cmd;
>> +	int err;
>> +	__u8 prefix;
>> +	__be16 port;
>> +	int addr_len;
>> +
>> +	if (optlen < sizeof(cmd))
>> +		return -EINVAL;
>> +
>> +	err = copy_struct_from_sockptr(&cmd, sizeof(cmd), optval, optlen);
>> +	if (err)
>> +		return err;
>> +
>> +	if (cmd.reserved != 0 || cmd.reserved2 != 0)
>> +		return -EINVAL;
>> +
>> +	if (cmd.set_current || cmd.set_rnext) {
>> +		if (!tcp_ao_can_set_current_rnext(sk))
>> +			return -EINVAL;
>> +	}
>> +
>> +	ao_info = setsockopt_ao_info(sk);
>> +	if (IS_ERR(ao_info))
>> +		return PTR_ERR(ao_info);
>> +	if (!ao_info)
>> +		return -ENOENT;
>> +
>> +	/* For sockets in TCP_CLOSED it's possible set keys that aren't
>> +	 * matching the future peer (address/port/VRF/etc),
>> +	 * tcp_ao_connect_init() will choose a correct matching MKT
>> +	 * if there's any.
>> +	 */
>> +	if (cmd.set_current) {
>> +		new_current = tcp_ao_established_key(ao_info, cmd.current_key, -1);
>> +		if (!new_current)
>> +			return -ENOENT;
>> +	}
>> +	if (cmd.set_rnext) {
>> +		new_rnext = tcp_ao_established_key(ao_info, -1, cmd.rnext);
>> +		if (!new_rnext)
>> +			return -ENOENT;
>> +	}
>> +
>> +	if (family == AF_INET) {
>> +		struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.addr;
>> +
>> +		addr = (union tcp_ao_addr *)&sin->sin_addr;
>> +		addr_len = sizeof(struct in_addr);
>> +		port = ntohs(sin->sin_port);
> 
> port is big endian, but here it is assigned a host-byte order value.
> It looks like port should be u16 rather than __bbe16.
> 
> As flagged by Smatch.
> 
>> +	} else {
>> +		struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)&cmd.addr;
>> +		struct in6_addr *addr6 = &sin6->sin6_addr;
>> +
>> +		if (ipv6_addr_v4mapped(addr6)) {
>> +			addr = (union tcp_ao_addr *)&addr6->s6_addr32[3];
>> +			addr_len = sizeof(struct in_addr);
>> +			family = AF_INET;
>> +		} else {
>> +			addr = (union tcp_ao_addr *)addr6;
>> +			addr_len = sizeof(struct in6_addr);
>> +		}
>> +		port = ntohs(sin6->sin6_port);
> 
> Ditto.
> 
>> +	}
>> +	prefix = cmd.prefix;
>> +
>> +	/* We could choose random present key here for current/rnext
>> +	 * but that's less predictable. Let's be strict and don't
>> +	 * allow removing a key that's in use. RFC5925 doesn't
>> +	 * specify how-to coordinate key removal, but says:
>> +	 * "It is presumed that an MKT affecting a particular
>> +	 * connection cannot be destroyed during an active connection"
>> +	 */
>> +	hlist_for_each_entry_rcu(key, &ao_info->head, node) {
>> +		if (cmd.sndid != key->sndid ||
>> +		    cmd.rcvid != key->rcvid)
>> +			continue;
>> +
>> +		if (family != key->family ||
>> +		    prefix != key->prefixlen ||
> o
>> +		    port != key->port ||
> 
> There is a similar problem here too.
> port is host byte order but key->port is big endian.
> 
>> +		    memcmp(addr, &key->addr, addr_len))
>> +			continue;
>> +
>> +		if (key == new_current || key == new_rnext)
>> +			continue;
>> +
>> +		return tcp_ao_delete_key(sk, ao_info, key,
>> +					  new_current, new_rnext);
>> +	}
>> +	return -ENOENT;
>> +}
> 
> ...
Thanks,
             Dmitry

