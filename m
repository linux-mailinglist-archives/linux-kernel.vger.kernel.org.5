Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2297C7290
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379577AbjJLQ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379584AbjJLQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:29:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD02E5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:29:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso858592b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697128152; x=1697732952; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WE3Jo0Q6R2eDhOXLPAn5fI6nLqGl+yopyVyIxuKQuCM=;
        b=U67ngra9kmwntvFkUCZK4bbeRmOU8mGM5rE7yItBt1leXCkDrOe8lqlY5fl8nqX2Uf
         nPbLnTc4oiTJLgBTtX3hTYyrEyC4hPKqnIbCNqttioRS83pWwS77eVqddLUbIGY4OXMY
         5T4u66py+xVG/9eX4vwonz44d1vF3kAcww5VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128152; x=1697732952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WE3Jo0Q6R2eDhOXLPAn5fI6nLqGl+yopyVyIxuKQuCM=;
        b=JQQXt4haL+IVz6FqiQY5LgnmFZ+RwJx0q8jUOMfhiAaZJFmQrBZMiaFGPWKiUukocE
         wiG3vXfcB/rQVF2NwO27xJEVaImirFxb0rMMq4rc2FWr11FJD1SziFL1bwm1ZdkZYS+p
         40lhYjqtNzrUAE59+xrpeMMgeNrUYKnWVHF44coMR278XGUPofwthSq1uKpDClMKGV89
         r6Y5vHMbnfsAzMV56FE8RPCCxwsR4O89a4QtjsYeM6635zj5T0Z/ruucuDOHLJ7IM+EW
         U8v3bwqTjdrCRmtor0U1HilSqa4irx3nNgG6Li7TmQUoaowkVi6x34Ex0AJNCr7ChEAD
         GZTA==
X-Gm-Message-State: AOJu0Yxd5bICOnNhMAhFcjaRavEXAytfMpDLmQ6D6jEBcJ8LYULTmjg7
        6f8R+vfj2HZQz5UkQGQARbQIcQ==
X-Google-Smtp-Source: AGHT+IGA3dYnTX2gx4tRNTqDSyaFZvdLD9jQ0uv4zzCA9gC04oYWVXvQWjDByBX7oKKZvymQRliLuA==
X-Received: by 2002:a05:6a00:451b:b0:691:2d4:238e with SMTP id cw27-20020a056a00451b00b0069102d4238emr22840850pfb.6.1697128152366;
        Thu, 12 Oct 2023 09:29:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z23-20020aa785d7000000b00690d64a0cb6sm11942071pfn.72.2023.10.12.09.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:29:11 -0700 (PDT)
Date:   Thu, 12 Oct 2023 09:29:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, willemb@google.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        abdhalee@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com
Subject: Re: [Bisected] [1b4fa28a8b07] Build failure "net/core/gso_test.c"
Message-ID: <202310120928.398BF883A8@keescook>
References: <79fbe35c-4dd1-4f27-acb2-7a60794bc348@linux.vnet.ibm.com>
 <20231012095746.GA26871@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231012095746.GA26871@breakpoint.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 11:57:46AM +0200, Florian Westphal wrote:
> Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com> wrote:
> > Greetings,
> > 
> > [net-next] [6.6-rc4] Build failure "net/core/gso_test.c"
> > 
> > --- Traces ---
> > 
> > make -j 33 -s && make modules_install && make install
> > net/core/gso_test.c:58:48: error: initializer element is not constant
> >    58 |                 .segs = (const unsigned int[]) { gso_size },
> >       |                                                ^
> 
> Ouch, I can reproduce this with: gcc --version
> gcc (Debian 12.2.0-14) 12.2.0
> Copyright (C) 2022 Free Software Foundation, Inc.
> 
> gcc 13.2.1 and clang-16.0.6 are ok.
> 
> Whats the preference here?  We could use simple preprocessor constant
> or we could require much more recent compiler version for the net
> kunit tests via kconfig.
> 
> gcc-12.2.0 can compile it after this simple s//g "fix":
> 
> diff --git a/net/core/gso_test.c b/net/core/gso_test.c
> --- a/net/core/gso_test.c
> +++ b/net/core/gso_test.c
> @@ -4,7 +4,7 @@
>  #include <linux/skbuff.h>
>  
>  static const char hdr[] = "abcdefgh";
> -static const int gso_size = 1000;
> +#define GSO_TEST_SIZE 1000

This fixes the build for me too.

Tested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  
>  static void __init_skb(struct sk_buff *skb)
>  {
> @@ -18,7 +18,7 @@ static void __init_skb(struct sk_buff *skb)
>  
>  	/* proto is arbitrary, as long as not ETH_P_TEB or vlan */
>  	skb->protocol = htons(ETH_P_ATALK);
> -	skb_shinfo(skb)->gso_size = gso_size;
> +	skb_shinfo(skb)->gso_size = GSO_TEST_SIZE;
>  }
>  
>  enum gso_test_nr {
> @@ -53,70 +53,70 @@ static struct gso_test_case cases[] = {
>  	{
>  		.id = GSO_TEST_NO_GSO,
>  		.name = "no_gso",
> -		.linear_len = gso_size,
> +		.linear_len = GSO_TEST_SIZE,
>  		.nr_segs = 1,
> -		.segs = (const unsigned int[]) { gso_size },
> +		.segs = (const unsigned int[]) { GSO_TEST_SIZE },
>  	},
>  	{
>  		.id = GSO_TEST_LINEAR,
>  		.name = "linear",
> -		.linear_len = gso_size + gso_size + 1,
> +		.linear_len = GSO_TEST_SIZE + GSO_TEST_SIZE + 1,
>  		.nr_segs = 3,
> -		.segs = (const unsigned int[]) { gso_size, gso_size, 1 },
> +		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 1 },
>  	},
>  	{
>  		.id = GSO_TEST_FRAGS,
>  		.name = "frags",
> -		.linear_len = gso_size,
> +		.linear_len = GSO_TEST_SIZE,
>  		.nr_frags = 2,
> -		.frags = (const unsigned int[]) { gso_size, 1 },
> +		.frags = (const unsigned int[]) { GSO_TEST_SIZE, 1 },
>  		.nr_segs = 3,
> -		.segs = (const unsigned int[]) { gso_size, gso_size, 1 },
> +		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 1 },
>  	},
>  	{
>  		.id = GSO_TEST_FRAGS_PURE,
>  		.name = "frags_pure",
>  		.nr_frags = 3,
> -		.frags = (const unsigned int[]) { gso_size, gso_size, 2 },
> +		.frags = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 2 },
>  		.nr_segs = 3,
> -		.segs = (const unsigned int[]) { gso_size, gso_size, 2 },
> +		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 2 },
>  	},
>  	{
>  		.id = GSO_TEST_GSO_PARTIAL,
>  		.name = "gso_partial",
> -		.linear_len = gso_size,
> +		.linear_len = GSO_TEST_SIZE,
>  		.nr_frags = 2,
> -		.frags = (const unsigned int[]) { gso_size, 3 },
> +		.frags = (const unsigned int[]) { GSO_TEST_SIZE, 3 },
>  		.nr_segs = 2,
> -		.segs = (const unsigned int[]) { 2 * gso_size, 3 },
> +		.segs = (const unsigned int[]) { 2 * GSO_TEST_SIZE, 3 },
>  	},
>  	{
>  		/* commit 89319d3801d1: frag_list on mss boundaries */
>  		.id = GSO_TEST_FRAG_LIST,
>  		.name = "frag_list",
> -		.linear_len = gso_size,
> +		.linear_len = GSO_TEST_SIZE,
>  		.nr_frag_skbs = 2,
> -		.frag_skbs = (const unsigned int[]) { gso_size, gso_size },
> +		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
>  		.nr_segs = 3,
> -		.segs = (const unsigned int[]) { gso_size, gso_size, gso_size },
> +		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE },
>  	},
>  	{
>  		.id = GSO_TEST_FRAG_LIST_PURE,
>  		.name = "frag_list_pure",
>  		.nr_frag_skbs = 2,
> -		.frag_skbs = (const unsigned int[]) { gso_size, gso_size },
> +		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
>  		.nr_segs = 2,
> -		.segs = (const unsigned int[]) { gso_size, gso_size },
> +		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
>  	},
>  	{
>  		/* commit 43170c4e0ba7: GRO of frag_list trains */
>  		.id = GSO_TEST_FRAG_LIST_NON_UNIFORM,
>  		.name = "frag_list_non_uniform",
> -		.linear_len = gso_size,
> +		.linear_len = GSO_TEST_SIZE,
>  		.nr_frag_skbs = 4,
> -		.frag_skbs = (const unsigned int[]) { gso_size, 1, gso_size, 2 },
> +		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, 1, GSO_TEST_SIZE, 2 },
>  		.nr_segs = 4,
> -		.segs = (const unsigned int[]) { gso_size, gso_size, gso_size, 3 },
> +		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3 },
>  	},
>  	{
>  		/* commit 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes") and

-- 
Kees Cook
