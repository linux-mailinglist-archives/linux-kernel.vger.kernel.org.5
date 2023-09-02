Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F98790942
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 20:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjIBS6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 14:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjIBS6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 14:58:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34C0ED;
        Sat,  2 Sep 2023 11:58:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c4923195dso27116066b.2;
        Sat, 02 Sep 2023 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693681109; x=1694285909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gl4SU+iR0aYjorFAnHIvqmzFYuhuur+i3elwAKbseyI=;
        b=JRVrF6I6Gqhv1eWDDaz7Ks3fBRLV4evdavSwovClwXF3zhzzBtn4oi2bTlx/uXcaML
         rGQTA5hJ0wRX5BLuY8kkPdEkXKqNW40+hH8Dw213lkuBVmaIrJpEAD44AcC+s8aN2z4P
         JGj+n3UCfJiID5Za82bQqMB8J1ULqDqVifioS15WoUbvMRISepPd8o+lKuZKuLxfmgt5
         XFht2Uo2UjWBNCUR/3Om3BtGvHt7u2vhqWQPPbgrQyDSX1vGJTRwpw4gWz2X5vFiG/Ac
         lURyzIhylCMP6hNleJQ+kEMY1gk9PgFBQ3/hwnmZouzIxkrNxQRS88EIqaIu2LLqFbAT
         KNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693681109; x=1694285909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gl4SU+iR0aYjorFAnHIvqmzFYuhuur+i3elwAKbseyI=;
        b=DTv5J/qXqRYaEmE6WO1pFg2YKbQU+QkO/PE6cM+u5oqTcZu3qjfbkbJy2fIn/JKFhk
         EZi2qYG1aQy7LVaxhnymfyfY2pXsehc1SWi12QWfvemueffvBc2QAMj/Lb+/T/KXCQxu
         ka5CoTMYbKLdU+XlCeoDesCX+quQrgLZfyRSMT/FX3Tv/QTTgXWhbZIXa++BeI1RSO3J
         eVR6KkBIP/4RELv3uq/YzWE7icoygM9MbNFNTdHcOlDjP828SzriOGt5Wi5kaUpriVhG
         mYeJS9+3AOlSTzBXDJyaVD1BPa+5IvHAlZbrx6u6XE0gMd3s7h3ih98IL2kg7Zb/GBeQ
         M2sw==
X-Gm-Message-State: AOJu0YwfQ4pJuQ/EovY5TrAkgHb1+7n15BcshOdfHabs+JoDAjzwntL/
        snS6as9igQsOmyd44fz35H8=
X-Google-Smtp-Source: AGHT+IFODLtoLsf48req917bK98NAE1I+S0Yvh0IcbImIFKunEHUw0bS/eMKsPkoBwjtjAKUsC9jbQ==
X-Received: by 2002:a17:906:3291:b0:9a1:bd1d:61b2 with SMTP id 17-20020a170906329100b009a1bd1d61b2mr3846170ejw.56.1693681108930;
        Sat, 02 Sep 2023 11:58:28 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id dt22-20020a170906b79600b0099d959f9536sm3809066ejb.12.2023.09.02.11.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 11:58:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3262227C0054;
        Sat,  2 Sep 2023 14:58:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 02 Sep 2023 14:58:26 -0400
X-ME-Sender: <xms:0YXzZKjOM7vXfm3HVkUDU0HZFNGkQUgqEExdD0KbIS6uXmG_kIdn7g>
    <xme:0YXzZLAJkLst6hOrR-rTk-s7jVxV8KIIk2Qv2yn-PfjE46KhZt7LSuu5JRyrDauJ6
    2X7bQ6K7CoGvb4V_A>
X-ME-Received: <xmr:0YXzZCGYqMoJhEAtHxHkRKYJgir7PO31NRvXt0peBiDgs-ksSY9lKZNpLwAFDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepueeutdetheelkedvieekjeefveekjedufeefkeduueduffejueegfffh
    hfffkefhnecuffhomhgrihhnpehruhhsthdqfhhorhdqlhhinhhugidrtghomhdpghhith
    hhuhgsrdgtohhmpdiiuhhlihhptghhrghtrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhph
    gvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdr
    fhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:0YXzZDTYxeOmU8jO2ij9xWNjbmq99qNm1HytDpYGvMerrqxShTtQQA>
    <xmx:0YXzZHyKr18TrP9pLU2296aXWyW1QYWcgnRGV2Gt3dYYR9Ovd5o5GQ>
    <xmx:0YXzZB77Xyc7WAlj5_6vZAvBakPp3QpGhEAOUVBgKk4ehLBaI6j7Zg>
    <xmx:0oXzZMqzPXuIdezaISsZkoUXCNcxUR0KUr4fJg13HQz5t57kHdgcmA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Sep 2023 14:58:25 -0400 (EDT)
Date:   Sat, 2 Sep 2023 11:57:22 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/2] MAINTAINERS: update Rust webpage
Message-ID: <ZPOFkpue7MX28bE7@boqun-archlinux>
References: <20230830165949.127475-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830165949.127475-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 06:59:48PM +0200, Miguel Ojeda wrote:
> A few months ago we started a webpage for the Rust subsystem and
> the overall Rust for Linux project [1].
> 
> The current `W:` field of the Rust entry points to the GitHub
> repository, since originally we kept information in a `README.md`
> file that got rendered by GitHub when visiting that URL.
> 
> That information was moved into the webpage and got expanded.
> The webpage is also nowadays the entry point to the project,
> and we pointed the "Website" GitHub metadata field to it.
> 
> Thus update the `W:` field to point to the actual webpage.
> 
> Link: https://rust-for-linux.com [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12601a47c839..7c8088e9a11b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18558,7 +18558,7 @@ R:	Andreas Hindborg <a.hindborg@samsung.com>
>  R:	Alice Ryhl <aliceryhl@google.com>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Supported
> -W:	https://github.com/Rust-for-Linux/linux
> +W:	https://rust-for-linux.com
>  B:	https://github.com/Rust-for-Linux/linux/issues
>  C:	zulip://rust-for-linux.zulipchat.com
>  T:	git https://github.com/Rust-for-Linux/linux.git rust-next
> 
> base-commit: 4af84c6a85c63bec24611e46bb3de2c0a6602a51
> -- 
> 2.42.0
> 
