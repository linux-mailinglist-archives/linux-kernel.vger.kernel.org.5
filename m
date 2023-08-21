Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59607782899
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjHUMJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjHUMJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:09:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546C690
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:09:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso32302905e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692619780; x=1693224580;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6RRbku+um9BPidbI3JS8qYiM0ec7QcpxCg+H92mZiek=;
        b=Bwcuac0mqiL0ycIHa8IMAT13sLz9AjzTETSv+JFOm4qqJiBUWW9IqRimKb5e3nL+Qo
         62I6SIjsnyrDpU6ITbwJj27puhwsnWoGXWV8PeXmE/26Few4pGNJ9qvsYzmKafjcnVh6
         4wu7l1xQLA9kinxoPBnd0aRrabn2lP97fQw9FpJ/iqxr2egnV7sKK4kRUk/SAtbEQFtG
         R+V5fa/u83P3q5OIu7pkHh3PuP3cZrEHZHj82sU63UGhk5Vk4/7oTuDJ21eLKzioUvFQ
         PQiXsYgd3F0p/DQ4fLI/ap5gOkYuiZyPbxewjKK9gzySZqiT0yRNZg1YOq3nl27ewOes
         eKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692619780; x=1693224580;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RRbku+um9BPidbI3JS8qYiM0ec7QcpxCg+H92mZiek=;
        b=dl9O6I+KTNxcqUNVSTybe8THoEM80zYIW2Q4gj/dYTCJSaEtlnk4OAZDki41fUn1sX
         SAv9jq3PuA5y9tz23d8FxTUgGnP2Pu2DTIXmiLlX+lNIXCzSIOuwKdZm0fBcVzCQ1/00
         j41Mcg5OwNLPhSW2oBFQ6oC7k8UCKNhcgsLvdxqhk18iUPEkuQVOqChUfk9JEr9DTX55
         kF8pRDwHRUMG9Tt1xBZBU4iy15YhnvSKnVxE6Z4Fr9C4RBk3rG0881RLRXcMYyBkZbZU
         P0PUR3cF1ZAROE4atZ0y1kZrRWrrxUEUgsTe5ncJ+b5LZEYw8NPegkqK65gzYLHCw4+G
         Srgw==
X-Gm-Message-State: AOJu0Yz9JvdHtBtfMeoRFDSL0pCEb/Ppiw26nqKkTyfX93aUCfYGupO9
        gLob62gBa2Jm+wnEiPvKCgJQAQ==
X-Google-Smtp-Source: AGHT+IGiKz/y8fbAoFMU/+ftzIAiVWxl/iXnOdICg6Krz7A/ocSadX633hzp4/vigJLBcg5ZtcUOAA==
X-Received: by 2002:adf:f9c4:0:b0:311:3fdc:109d with SMTP id w4-20020adff9c4000000b003113fdc109dmr4311184wrr.1.1692619779693;
        Mon, 21 Aug 2023 05:09:39 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc454000000b003feee8d8011sm4923534wmi.41.2023.08.21.05.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 05:09:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------AZ06I92EvQmoPokb1tbiIOKA"
Message-ID: <679ddff6-db6e-4ff6-b177-574e90d0103d@tessares.net>
Date:   Mon, 21 Aug 2023 14:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Content-Language: en-GB
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230821110633.432a1599@canb.auug.org.au>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230821110633.432a1599@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AZ06I92EvQmoPokb1tbiIOKA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stephen,

On 21/08/2023 03:06, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   include/net/inet_sock.h
> 
> between commit:
> 
>   f866fbc842de ("ipv4: fix data-races around inet->inet_id")
> 
> from the net tree and commit:
> 
>   c274af224269 ("inet: introduce inet->inet_flags")
> 
> from the net-next tree.

Thank you for this conflict resolution!

I had the same issue on our side with MPTCP tree when syncing -net and
net-next and I resolved it a bit differently. Here my comment on the
patch you used:

> diff --cc include/net/inet_sock.h
> index 491ceb7ebe5d,acbb93d7607a..000000000000
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@@ -218,12 -218,12 +218,12 @@@ struct inet_sock 
>   #define inet_dport		sk.__sk_common.skc_dport
>   #define inet_num		sk.__sk_common.skc_num
>   
> + 	unsigned long		inet_flags;
>   	__be32			inet_saddr;
>   	__s16			uc_ttl;
> - 	__u16			cmsg_flags;
> - 	struct ip_options_rcu __rcu	*inet_opt;
> - 	atomic_t		inet_id;
>   	__be16			inet_sport;
> ++	atomic_t		inet_id;
> + 	struct ip_options_rcu __rcu	*inet_opt;

I first put "inet_opt", then "inet_id" here to avoid a hole of 4 bytes.
So just switching these two lines.

Here is the output of pahole when using your patch:

> struct inet_sock {
>         struct sock                sk __attribute__((__aligned__(8))); /*     0   768 */
>         /* --- cacheline 12 boundary (768 bytes) --- */
>         struct ipv6_pinfo *        pinet6;               /*   768     8 */
>         long unsigned int          inet_flags;           /*   776     8 */
>         __be32                     inet_saddr;           /*   784     4 */
>         __s16                      uc_ttl;               /*   788     2 */
>         __be16                     inet_sport;           /*   790     2 */
>         atomic_t                   inet_id;              /*   792     4 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         struct ip_options_rcu *    inet_opt;             /*   800     8 */
>         __u8                       tos;                  /*   808     1 */
>         __u8                       min_ttl;              /*   809     1 */
>         __u8                       mc_ttl;               /*   810     1 */
>         __u8                       pmtudisc;             /*   811     1 */
>         __u8                       rcv_tos;              /*   812     1 */
>         __u8                       convert_csum;         /*   813     1 */
> 
>         /* XXX 2 bytes hole, try to pack */
> 
>         int                        uc_index;             /*   816     4 */
>         int                        mc_index;             /*   820     4 */
>         __be32                     mc_addr;              /*   824     4 */

And now when "inet_id" is placed after "inet_opt":

> struct inet_sock {
>         struct sock                sk __attribute__((__aligned__(8))); /*     0   768 */
>         /* --- cacheline 12 boundary (768 bytes) --- */
>         struct ipv6_pinfo *        pinet6;               /*   768     8 */
>         long unsigned int          inet_flags;           /*   776     8 */
>         __be32                     inet_saddr;           /*   784     4 */
>         __s16                      uc_ttl;               /*   788     2 */
>         __be16                     inet_sport;           /*   790     2 */
>         struct ip_options_rcu *    inet_opt;             /*   792     8 */
>         atomic_t                   inet_id;              /*   800     4 */
>         __u8                       tos;                  /*   804     1 */
>         __u8                       min_ttl;              /*   805     1 */
>         __u8                       mc_ttl;               /*   806     1 */
>         __u8                       pmtudisc;             /*   807     1 */
>         __u8                       rcv_tos;              /*   808     1 */
>         __u8                       convert_csum;         /*   809     1 */
> 
>         /* XXX 2 bytes hole, try to pack */
> 
>         int                        uc_index;             /*   812     4 */
>         int                        mc_index;             /*   816     4 */
>         __be32                     mc_addr;              /*   820     4 */

I noticed that in Eric's patch for the net tree -- f866fbc842de ("ipv4:
fix data-races around inet->inet_id") -- he moved "inet_id" above, I
guess for a similar reason.

Just in case you are interested by taking my version, I attached the
patch I used and the Rerere cache is available there:

https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/e63f34f8

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--------------AZ06I92EvQmoPokb1tbiIOKA
Content-Type: text/x-patch; charset=UTF-8;
 name="47fe53ec8c3d4381989f0541eb0a0abd31b8cbee.patch"
Content-Disposition: attachment;
 filename="47fe53ec8c3d4381989f0541eb0a0abd31b8cbee.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIGluY2x1ZGUvbmV0L2luZXRfc29jay5oCmluZGV4IGFjYmI5M2Q3NjA3YSw0
OTFjZWI3ZWJlNWQuLjJkZTBlNGQ0YTAyNwotLS0gYS9pbmNsdWRlL25ldC9pbmV0X3NvY2su
aAorKysgYi9pbmNsdWRlL25ldC9pbmV0X3NvY2suaApAQEAgLTIxOCwxMiAtMjE4LDEyICsy
MTgsMTIgQEBAIHN0cnVjdCBpbmV0X3NvY2sgCiAgI2RlZmluZSBpbmV0X2Rwb3J0CQlzay5f
X3NrX2NvbW1vbi5za2NfZHBvcnQKICAjZGVmaW5lIGluZXRfbnVtCQlzay5fX3NrX2NvbW1v
bi5za2NfbnVtCiAgCiArCXVuc2lnbmVkIGxvbmcJCWluZXRfZmxhZ3M7CiAgCV9fYmUzMgkJ
CWluZXRfc2FkZHI7CiAgCV9fczE2CQkJdWNfdHRsOwogLQlfX3UxNgkJCWNtc2dfZmxhZ3M7
CiArCV9fYmUxNgkJCWluZXRfc3BvcnQ7CiAgCXN0cnVjdCBpcF9vcHRpb25zX3JjdSBfX3Jj
dQkqaW5ldF9vcHQ7Ci0gCV9fdTE2CQkJaW5ldF9pZDsKKyAJYXRvbWljX3QJCWluZXRfaWQ7
CiAtCV9fYmUxNgkJCWluZXRfc3BvcnQ7CiAgCiAgCV9fdTgJCQl0b3M7CiAgCV9fdTgJCQlt
aW5fdHRsOwo=

--------------AZ06I92EvQmoPokb1tbiIOKA--
