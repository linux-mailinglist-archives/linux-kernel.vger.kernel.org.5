Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACCC80D9C4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjLKS4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345051AbjLKRla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:41:30 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8301B10A;
        Mon, 11 Dec 2023 09:41:34 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4259295ca72so31504911cf.1;
        Mon, 11 Dec 2023 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702316493; x=1702921293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQER4L9He5ziUc0coS3FYyiMI2AIHk6MmaOBH68Fuig=;
        b=Ka34QiySv4maaCQ01T9M9o8ymGnZSYl6EU9TEHVtS+ivKH0QOxd/oN0qnal528aXs7
         ySKEUk+0gZJ204YEAubl0a4Tv2Lg2xmwYu2VAW2SNdZdItmMEWP1nDEThylxTES2qEhc
         7kTd5Qr3U0yzsoO2WoveK7nloiMuT9UZOIVx6yG8X6XkoXmNgzOUtqskkC1gnKg47L6W
         qLqaaVm3g24YLnydlaLV/wAv3o479Pmah/a1t9teYD+KCU6D+8sz3T/97vVC2F3utOYA
         4fAewQI6lEo3ZVtfyhAxpUQnmqDebDnkRBHPUAzpb7XE/rIZkUD+H2UyA3HIg6H3i2y/
         SgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316493; x=1702921293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQER4L9He5ziUc0coS3FYyiMI2AIHk6MmaOBH68Fuig=;
        b=AXj8D3LuyhoHOVED2TOfQmlBy7/DNvbV4QYnVZW3GxXmTQ79QVeEd2CK2KPA8g8lVt
         B+nYktg0PFz9X2sl/E/ofxeRVSUJDoFA2F20QgIlG3fZdaon7q/bIWQ4fHn0bqT+1See
         fN9T6Ve/i6LzquYNg/S0Qj4fuBygdB0jTKlVwOg+0kTjbNt3SABbR56P67bbz2189BCm
         iLCvAJEGy9DyNjvqbWQZ7udBUfAnPfVk/urXvhEbeMx+FHdFlKOqdGIMs+Nt0zhSp/XF
         dTK/2C/ody6kRoyi8vKifKD3Qq3QELc8bf1W8V2fXSlcjqlVXqe99Ql4Ee4iaWzI4xqD
         rfww==
X-Gm-Message-State: AOJu0YxmQ+wOWXywFn/srNiKHmV47y0x/+/0BhtHZYm1hesZeP+2eYkV
        mzj+FGcy2qZWdWanA5d1sFI=
X-Google-Smtp-Source: AGHT+IFqS4bjOwrFqSq+XpMpRZSaBn+yGT0Z71Cv366hf0cp2FQosWG8TkzJiQy3d0Ze7l9/2RITqw==
X-Received: by 2002:a05:622a:16:b0:425:a021:2dd4 with SMTP id x22-20020a05622a001600b00425a0212dd4mr6349643qtw.132.1702316493315;
        Mon, 11 Dec 2023 09:41:33 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l2-20020ac848c2000000b00424030566b5sm3353981qtr.17.2023.12.11.09.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:41:33 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 66AA427C005B;
        Mon, 11 Dec 2023 12:41:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Dec 2023 12:41:32 -0500
X-ME-Sender: <xms:y0l3ZVF8YLkO-sv-g6b87SwFn8MS1rXmbTNsS4EDgaTJFlSiK-G7mw>
    <xme:y0l3ZaXQZ77peHG8QJluWa_s8Y6Ux8ePqg8bp6mgUCtWJJHtcCfK4cYH4qSK6QObx
    jVN7oiVbXGGnbbysg>
X-ME-Received: <xmr:y0l3ZXJsJL3qxEPsBgqOkwCD0jOb-KqbhK3zj0aXQHKOG2znzxJlp3ED7fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:y0l3ZbEE7Fsme3WQh2fEyK7IUSKFYg84FWZsMVROYdb-OeNrTYvIPQ>
    <xmx:y0l3ZbXJJD35rQwrnc5_vyodQSvxwnU25EOow14ikSQLjSu6s5hIDw>
    <xmx:y0l3ZWMcpX86HUAlmIpRjanGpQrRHRGKQu4LBv67vmpPwxA_HtY2Ug>
    <xmx:zEl3ZR-3iPJr_SGcBmuwyTQbQGxBF2UDVaqHDQeZHanpYUQTBNu0iQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 12:41:30 -0500 (EST)
Date:   Mon, 11 Dec 2023 09:41:28 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     benno.lossin@proton.me, a.hindborg@samsung.com,
        alex.gaynor@gmail.com, arve@android.com, bjorn3_gh@protonmail.com,
        brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com,
        dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH v2 6/7] rust: file: add `DeferredFdCloser`
Message-ID: <ZXdJyGFeQEbZU3Eh@boqun-archlinux>
References: <MjDmZBGV04fVI1qzhceEjQgcmoBuo3YoVuiQdANKj9F1Ux5JFKud8hQpfeyLXI0O5HG6qicKFaYYzM7JAgR_kVQfMCeVdN6t7PjbPaz0D0U=@proton.me>
 <20231211153440.4162899-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211153440.4162899-1-aliceryhl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:34:40PM +0000, Alice Ryhl wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
> > On 12/6/23 12:59, Alice Ryhl wrote:
> > > +    /// Schedule a task work that closes the file descriptor when this task returns to userspace.
> > > +    ///
> > > +    /// Fails if this is called from a context where we cannot run work when returning to
> > > +    /// userspace. (E.g., from a kthread.)
> > > +    pub fn close_fd(self, fd: u32) -> Result<(), DeferredFdCloseError> {
> > > +        use bindings::task_work_notify_mode_TWA_RESUME as TWA_RESUME;
> > > +
> > > +        // In this method, we schedule the task work before closing the file. This is because
> > > +        // scheduling a task work is fallible, and we need to know whether it will fail before we
> > > +        // attempt to close the file.
> > > +
> > > +        // SAFETY: Getting a pointer to current is always safe.
> > > +        let current = unsafe { bindings::get_current() };
> > > +
> > > +        // SAFETY: Accessing the `flags` field of `current` is always safe.
> > > +        let is_kthread = (unsafe { (*current).flags } & bindings::PF_KTHREAD) != 0;
> > 
> > Since Boqun brought to my attention that we already have a wrapper for
> > `get_current()`, how about you use it here as well?
> 
> I can use the wrapper, but it seems simpler to not go through a
> reference when we just need a raw pointer.
> 
> Perhaps we should have a safe `Task::current_raw` function that just
> returns a raw pointer? It can still be safe.
> 

I think we can have a `as_ptr` function for `Task`?

	impl Task {
	    pub fn as_ptr(&self) -> *mut bindings::task_struct {
	        self.0.get()
	    }
	}

Regards,
Boqun

[...]
