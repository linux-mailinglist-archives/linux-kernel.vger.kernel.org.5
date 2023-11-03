Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185387E0780
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjKCRfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjKCRfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:35:44 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1824136;
        Fri,  3 Nov 2023 10:35:41 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b3f55e1bbbso1440107b6e.2;
        Fri, 03 Nov 2023 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699032940; x=1699637740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUwsWoeHAo55a1n3qauNOQy9fcQJhbfyl72sCPND1PU=;
        b=PT1fgG7YsNpp9usDusCO4dgMc7yOJWHkU+MLzmWpRPV0alGf+j7x5yfwFOYdKWnPU+
         DntaC8gWL8JOnPfYDf1x/Y1vYl6HBza11w28Aga+/BNgD53yiYvpfByYhpEsjrf9k5dM
         j37nTCKEdFEyGmjPoCJF5c2bBKIA6WAgBmqA5nNT8bo7VAD6Ur5KI0sFe+PyW7S/zqng
         3qBmXTSY55wo+rEbp/XjwC25oJTF8wTKRV9caJmwDYVY/kVop4/qqHpPpeJ99qp3WJw4
         5KPNKCn4dXCdsdB4nw/LNTFyK8oZJT5SNi7mYZ/KnuWzq3dLNFvg6cfHb3wWw4l6cbYY
         UE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699032940; x=1699637740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUwsWoeHAo55a1n3qauNOQy9fcQJhbfyl72sCPND1PU=;
        b=QOKubI8d6FjSsLfPIDclt1e23PWquEqu4xVdOiObE5ah3fTHb5c6mu8ZYG4Tn5j+RZ
         XpQ/QphjgkNhWD+6WbilmnZJiDc3tbxe4sWPAu65FMCDV620QZTdAYVNpxNY3LlYsgZR
         f+iposx9SomGQjNchUDJqfAPwHXkGSk421+pb1hSDXZVvvWk4PJWPJ0ooMmiS+m2dWHA
         Q7HmOY0T0SEpk91mcCcpPRe5FCPZoFlYdtdey0DGR9F/BjRg0H8MYtspAlKeRKjRn7ej
         aTdC8ekcJvIEWOb2eYPAVHHDUmAsio+2PRd67rtCtBlt4OMvesNo59/o+eYcqSLwkWTm
         LIww==
X-Gm-Message-State: AOJu0YxelNrkbqSKRBxXvHLvOBYk/x1BW+8gTp6lrXDxtv8pEfFb7Fzh
        zfDE810YIT0GGlLmPuLVOPw=
X-Google-Smtp-Source: AGHT+IFQ2I3RmOkyhEiO+fRoT4DEDUqtaffOko/ziN69QCFscEtnwzTeK+l+PHxYKHP8i561szQpNw==
X-Received: by 2002:a05:6808:68a:b0:3a8:ccf0:103f with SMTP id k10-20020a056808068a00b003a8ccf0103fmr21522378oig.3.1699032940475;
        Fri, 03 Nov 2023 10:35:40 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 6-20020a05620a04c600b007749dc7881dsm908113qks.48.2023.11.03.10.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:35:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4EED127C005B;
        Fri,  3 Nov 2023 13:35:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 03 Nov 2023 13:35:39 -0400
X-ME-Sender: <xms:aS9FZfy2uIbk6232CNjeP_GDmV4uOXLt3iv9sinL9zkOAiNBwCHzqQ>
    <xme:aS9FZXRtUtENb5myvkyVGrc4OYlxrDALibxmUms-QezAJPcdneoaRTSZ7UE2msjSv
    QWKLU3wQjrjojoRsA>
X-ME-Received: <xmr:aS9FZZUqv6RIw3QoQz1f5KLuL-77Ir3TdedB--zpQk27vW753jwdisza1IM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtkedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:aS9FZZhr5qHY-_aQarg9fd-oieECbBHJXBxo3KCrPTVKXr1WZM9zZw>
    <xmx:aS9FZRAkKjARQtqFDUX1CPl4AkJ2-FGM2oO0G7AGlUUZLskOUStwWw>
    <xmx:aS9FZSJX_v10FVN3qbHDbTO2qBLwaOS4WBYBRgEUYuiG4P5pRTVzOQ>
    <xmx:ay9FZQDYgbOTPKerpYwSyK-2M3Tk5IKh_x5C0r88FU7AztESd-cRng>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Nov 2023 13:35:37 -0400 (EDT)
Date:   Fri, 3 Nov 2023 10:34:27 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Matt Gilbride <mattgilbride@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Matthew Maurer <mmaurer@google.com>
Subject: Re: [PATCH RFC 02/20] rust_binder: add binderfs support to Rust
 binder
Message-ID: <ZUUvI0leuPfhCOfE@boqun-archlinux>
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
 <20231101-rust-binder-v1-2-08ba9197f637@google.com>
 <sRVdoCqLbxM1-EH0iKVlb9eOEU-wt410-WT5rFTQNNYgmiW6EEpKvCCJyVppOmFYhXBcCN3SsXUXULzpmmweYBGDVHW619pjsIZvorv8Fc8=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sRVdoCqLbxM1-EH0iKVlb9eOEU-wt410-WT5rFTQNNYgmiW6EEpKvCCJyVppOmFYhXBcCN3SsXUXULzpmmweYBGDVHW619pjsIZvorv8Fc8=@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 04:30:54PM +0000, Benno Lossin wrote:
> On 01.11.23 19:01, Alice Ryhl wrote:
> > +/// There is one context per binder file (/dev/binder, /dev/hwbinder, etc)
> > +#[pin_data]
> > +pub(crate) struct Context {
> > +    #[pin]
> > +    manager: Mutex<Manager>,
> > +    pub(crate) name: CString,
> > +    #[pin]
> > +    links: ListLinks,
> > +}
> > +
> > +kernel::list::impl_has_list_links! {
> > +    impl HasListLinks<0> for Context { self.links }
> > +}
> > +kernel::list::impl_list_arc_safe! {
> > +    impl ListArcSafe<0> for Context { untracked; }
> > +}
> > +kernel::list::impl_list_item! {
> > +    impl ListItem<0> for Context {
> > +        using ListLinks;
> > +    }
> > +}
> 
> I think at some point it would be worth introducing a derive macro that
> does this for us. So for example:

Agreed.

> 
>     #[pin_data]
>     #[derive(HasListLinks)]
>     pub(crate) struct Context {
>         #[pin]
>         manager: Mutex<Manager>,
>         pub(crate) name: CString,
>         #[pin]
>         #[links]
>         links: ListLinks,
>     }
> 
> And if you need multiple links you could do:
> 
>     #[pin_data]
>     #[derive(HasListLinks)]
>     struct Foo {
>         #[links = 0]
>         a_list: ListLinks,

we will need more discussion on how the derive syntax would look like,
but I'd expect we can reference the field with names instead of numbers
if we use derive macros. In other words type numbering to distinguish
different fields should be an implementation detail.

Regards,
Boqun

>         #[links = 1]
>         b_list: ListLinks,
>     }
> 
> Same for `ListItem` and `HasWork`. I have not yet taken a look at your
> linked list implementation, so I don't know if this is possible (since
> `ListItem` seems to have multiple "backends").
> 
> I think this improvement can wait though, just wanted to mention it.
> 
> -- 
> Cheers,
> Benno
> 
