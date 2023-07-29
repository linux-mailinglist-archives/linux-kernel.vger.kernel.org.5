Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410547682B6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 01:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjG2Xlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 19:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjG2Xlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 19:41:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8CF2D61;
        Sat, 29 Jul 2023 16:41:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bc0a20b54so516132866b.1;
        Sat, 29 Jul 2023 16:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690674097; x=1691278897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0v0jLwnwzDh79wxSK826et8eo4TKKEDlYscJEeAlfEU=;
        b=l+Nw2eJGJRlse4weN+Zg5DIXZNLaRZs5vFgzEiDdgg1NVBpJBPAP8OzwvRbggZoW9D
         6MK/na7e5zNYF59WMdm41sY/wunXt8GSdQzyG//9j/nGqMdIe9f3ieqSRGHjnObEbs3p
         RvwylckQKxUUNifHqKyQZvNuhVEtoDASqluSKX/cSHmrTTsrrqUSAS+QsBzgne4N29HE
         ggliqqsd1AaVRC7CNdnz+d3ySVpggDjQR+1n+RuZS7WOQ5UkVLyh8aI3d9NI6ptsFAw3
         ysggpwzxvF5BItqzHreMz7JvHvLs2wh3MYR4bGsyVSI0DdLdwZQn2QZ6vIZrMDD83545
         0Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690674097; x=1691278897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0v0jLwnwzDh79wxSK826et8eo4TKKEDlYscJEeAlfEU=;
        b=R/vxykTEHd6aRjAbHtuL+7vhLKM7doqvDEnZlJd5nv7ymCG3I4jHM5023EGsJs5vZk
         cCmqj24ai1mxkefCyISRc/B7aZ9Cg0p4hbg3Dyy1mi5dCqLTcrIlfAzQ1U60GB/5AleZ
         PGu+2ELTlaiZoLaik7VKvPKRFcKWyVxCPIpmSuRJkJHBJtqSyj8dbLrBcVzSzcQ1m/+5
         LoaOvo4YN7N0CmD7vxojI3VZandgPC1wNopKZgy4vaIwRwuzWY4BUX3EGK8bugNjoLsy
         e7T1HwVWa1VlwJGsDiD/sQ55rfInwzOaTmdqAKrr2aD7lXvheO+RXbRcj88EILM3Qfzv
         mKxQ==
X-Gm-Message-State: ABy/qLYhoyJbxeuL/cQniPfdV2ucrvkX27vQvD7rlRXCZREJK6biAM3p
        xzXXVus6qZca6T5+QZBMKI8=
X-Google-Smtp-Source: APBJJlFsRKC2mTKeYT3mQLgnmZXIJXKso0YsRWIcZ7kk/uzkfjwxyoLrgvAG0n8G8PGEavbjC6R0nA==
X-Received: by 2002:a17:907:75f0:b0:99b:ca5d:1466 with SMTP id jz16-20020a17090775f000b0099bca5d1466mr3445829ejc.66.1690674097502;
        Sat, 29 Jul 2023 16:41:37 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906490300b0099307a5c564sm3874472ejq.55.2023.07.29.16.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 16:41:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id BD1B127C0054;
        Sat, 29 Jul 2023 19:41:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 29 Jul 2023 19:41:33 -0400
X-ME-Sender: <xms:q6PFZBfJszEaWWIgMPKzoTG09NTAG-nPZX72_AxEDGHizlohjdmJIg>
    <xme:q6PFZPNkYUsosBPzW-5MS7YxAYi9MKhJg6PEKQgOnYL9-9w6qSAmX6MSb4ry40j45
    NMffXdMbDTBfGgerg>
X-ME-Received: <xmr:q6PFZKiljlqD6fdhUJm3Ya8xxsrar4vD2q1KWkcb8MFcCpub_9OQ5mKEHgCinw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieelgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffg
    geelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:q6PFZK_kVGNeU7E628FxxXTtIiGhYvDq3paw3h6g4K1CxQt0ckrUJQ>
    <xmx:q6PFZNtcMmBc6wSjqG6Z8Zo7TMbnloV3Mha7eid70j_qRG8ofM86rA>
    <xmx:q6PFZJHnqDkdfpcWspvkhIU_Pxu-icg15IsvS2axG7tH_FeLQcBwhA>
    <xmx:raPFZBBK0L7MfnWRqOqPqaqKXXAS-8febkhcrbxFfRRbXQiPBy6o8Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jul 2023 19:41:31 -0400 (EDT)
Date:   Sat, 29 Jul 2023 16:40:53 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andreas Hindborg <nmi@metaspace.dk>, stable@vger.kernel.org
Subject: Re: [PATCH] rust: allocator: Prevents mis-aligned allocation
Message-ID: <ZMWjhRyvsWIZal72@boqun-archlinux>
References: <20230613164258.3831917-1-boqun.feng@gmail.com>
 <CANiq72=pb18B6NOcXF03d0ctOP8kv2dqnUeNyEuSvuDb=vs-0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=pb18B6NOcXF03d0ctOP8kv2dqnUeNyEuSvuDb=vs-0g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 04:01:03PM +0200, Miguel Ojeda wrote:
> On Tue, Jun 13, 2023 at 6:44 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Cc: stable@vger.kernel.org # v6.1+
> 
> Applied to `rust-next`, thanks!
> 
> However, should this go to stable? The actual functions being called
> are the `__rust_*` ones (until they get removed in 1.71), no? Thus

Interesting, I wasn't aware of the `__rust_*` "hack" here, so you are
right, this doesn't fix the issue in stable kernels.

> this is not actually fixing the actual functions being called, right?
> 
> If that is correct, then the fix should change the functions below,
> perhaps adding `krealloc_with_flags()` from the other patch (it does
> not need to be a method, by the way), and calling it with a `Layout`
> like the generated ones do. Then I can rebase `rust-next` on top of

Sounds good, however I think it'll be better if I resend this one, and
the other one originally from Bjorn based on the introduction of
function `krealloc_with_flags` (I will name it as `krealloc_aligned`,
since it's a function that returns a aligned object with krealloc). 

Thoughts?

Regards,
Boqun

> the fix that adds the `krealloc_with_flags()`.
> 
> Cheers,
> Miguel
