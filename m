Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07827E81C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344952AbjKJSdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345850AbjKJScq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:32:46 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED81672B1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:46:53 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77891f362cfso146045085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699598813; x=1700203613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHJDdNWZZ4tIwkHZEN1gC9OcT0HCJr1RVppBH6tmUws=;
        b=d5gTjl5c9wk3h/lnULn5BMuG7FtGiYmygFMeQU/6nDh7PooX51nvSbbKsFutX2MG+0
         47yJlisISclPMm+0tY/ukfiyM8TePKGixWcxPqSESJ65vZA55LXPyrd9urR2KIJ/flQD
         2DE1ZDKtgyHOvm8rlVokhGG2YKEudLbkOOGMu06agNao6UPrOZh0Kgs8HlrF77GFvBL0
         u1lCQp+AEWxulaQ5fsjxhYJ4vIzMpyq/i8bfAJZBJTmUDDfFDedWI9a3LJv4xcAX53qJ
         NioCHWc+Smf6FNYilnBrEGoc1sutpjOxn6xVqLhhFpffwWp0pvHffoQhnHhTWQA9oyen
         XXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598813; x=1700203613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHJDdNWZZ4tIwkHZEN1gC9OcT0HCJr1RVppBH6tmUws=;
        b=HNKhg2qfpgC2R4PZ/g7NHzlj7jXOBaCyPWe6tT3LwrbGGXuigZcHzZ5MI3jZ6aDzUW
         q8Icwwv7/dQVojOz0CLKeLNWCMQugOKxB9xxSofPf4TfLh7px7QRCPNVgx9KAGVJZ07B
         knZddfozVDymwgdr3bu7mR8VYlK/cB3X2hbHfYIo716+RVF44n4TM54T3Aeb46htZRMa
         je+8M6LmVAlbuwlbGYSLuDEyzvE3SqZ8wkfYqVwE8sEibHd4/UVoq4K2s9qAj7y4XlVG
         50e9zOVgX5T1p0sT5Jjqcsrd1uchFv/ENdF5KL04QOGuk0JMDWjgvPhipfwbYfQxnG+m
         E7dg==
X-Gm-Message-State: AOJu0YweJf5HN++4K62MW1j1EQT3TuE45nDnY/jX6futpMs152YtnyRu
        TYy/hjRuhaGhURd5JsQo37QhgpCkGbUtSIBFfv195eWEhG3d2JqiE7Q=
X-Google-Smtp-Source: AGHT+IHV8+0MFbC/VQpqHkvElGy/RL/z/ISeA+lbF9gB7A+2xFrkzHZehvrtNrke+02jjGbQaJXjvKRk/eDFLYB8QzU=
X-Received: by 2002:a05:6102:3d8b:b0:44d:38d6:5cb8 with SMTP id
 h11-20020a0561023d8b00b0044d38d65cb8mr631035vsv.10.1699589171185; Thu, 09 Nov
 2023 20:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-9-almasrymina@google.com> <adde2b31fdd9e7bb4a09f0073580b840bea0bab1.camel@redhat.com>
In-Reply-To: <adde2b31fdd9e7bb4a09f0073580b840bea0bab1.camel@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 9 Nov 2023 20:06:00 -0800
Message-ID: <CAHS8izMrJVb0ESjFhqUWuxdZ8W5HDmg=yRj1J1sTeGoQjDcJog@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 1:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
> [...]
> > @@ -3421,7 +3446,7 @@ static inline struct page *skb_frag_page(const sk=
b_frag_t *frag)
> >   */
> >  static inline void __skb_frag_ref(skb_frag_t *frag)
> >  {
> > -     get_page(skb_frag_page(frag));
> > +     page_pool_page_get_many(frag->bv_page, 1);
>
> I guess the above needs #ifdef CONFIG_PAGE_POOL guards and explicit
> skb_frag_is_page_pool_iov() check ?
>

It doesn't actually. page_pool_page_* helpers are compiled in
regardless of CONFIG_PAGE_POOL, and handle both page_pool_iov* & page*
just fine (the checking happens inside the function).

You may yell at me that it's too confusing... I somewhat agree, but
I'm unsure of what is a better name or location for the helpers. The
helpers handle (page_pool_iov* || page*) gracefully, so they seem to
belong in the page pool for me, but it is indeed surprising/confusing
that these helpers are available even if !CONFIG_PAGE_POOL.

>
> Cheers,
>
> Paolo
>
>


--=20
Thanks,
Mina
