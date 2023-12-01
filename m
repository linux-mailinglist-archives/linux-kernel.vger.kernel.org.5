Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB807800490
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377711AbjLAHTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjLAHTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:19:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AAE10FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:19:10 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-286447abfbeso933019a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701415149; x=1702019949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4gjmXzJwfkZpfXVaiVKGn9kscrEqPPEn8et/1JxxBI=;
        b=kaUkfIeI4tpE1dITHQVPisSpZaZPRclkn6CGLXNVqr6xQ71WAirKsmFIhg2dH0H7l3
         R3xxN1KU/YF4AkoNHfeHxyBtPk//Cb7bXF45VeRdAQKaUKgfMXpb5Ka4/wk8X8h5Uqfm
         g0mdvNPFs5w0LcXxffewa0la9wz3OLojJPQXtPaNLyambKd/CHDbaLQcIqImKUNh8yeZ
         uS6MG/BWcCvWap8566kI4jkCch0L6cKghoVe/l1EFi2V07ln7qpY9fRa6DK2uE45n8BL
         PfeQENzXmuRJy1IpMwgLEoWfAcOjybZXuNuEKt4seNiwHLsUlHslEulz7Rv/deMvPG9B
         bjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701415149; x=1702019949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4gjmXzJwfkZpfXVaiVKGn9kscrEqPPEn8et/1JxxBI=;
        b=hzjFdr6eSls8GtXspGl4Hhs7w2kUovWzd3du7DYlF49GPlYQQyISnykZoGbqPKJGZH
         LHmdpDeCGTtbZKMroOdCWKKc19A/CfNdZk9cuRUUu3Eb/ILsp4dMFyJhPFdicxuPXh8r
         scnbPiPbfFjGAJpMb7NtDTbgDoYPcA0dn0a6LeOkutV0I8M4Ds7/PMW839AOoI5+U8bh
         9aW1B9jvKMPBAeMtk/+oPMMm72lmQ3QnOphJ9h77ZOQyLF4Pj94xFMxQlv9KSMk/AeU9
         SztZg/2P92zyHNReGMdjWWLI3EcNqeRrS+gk/HpGPZO9zQX++wtD6gCA950GOj6FRniX
         o8Fg==
X-Gm-Message-State: AOJu0YyBlvNGiW3wSrogAqJb5RdS0AkNjlOGXVr643g7gdfqxAr85hPg
        BFt5GUicMBI1GrKOawRMYGkduQ==
X-Google-Smtp-Source: AGHT+IFFXGFh0NfgZqE3NMe9QNS4wdzbEv5zae83ZTBI4ZQYdVHxqFgJ4YNDAOOZU0NJfP7hPBZH7w==
X-Received: by 2002:a17:90b:3ecb:b0:286:1e90:fe2f with SMTP id rm11-20020a17090b3ecb00b002861e90fe2fmr11007696pjb.15.1701415149380;
        Thu, 30 Nov 2023 23:19:09 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902684600b001cf5d4f8f26sm669493pln.248.2023.11.30.23.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:19:08 -0800 (PST)
Date:   Fri, 1 Dec 2023 07:19:05 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
Subject: Re: [PATCH 16/21] binder: refactor page range allocation
Message-ID: <ZWmI6QxlDuV-Miyr@google.com>
References: <20231102185934.773885-17-cmllamas@google.com>
 <20231107090835.260342-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090835.260342-1-aliceryhl@google.com>
X-Spam-Status: No, score=-13.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:08:35AM +0000, Alice Ryhl wrote:
> Carlos Llamas <cmllamas@google.com> writes:
> > Instead of looping through the page range twice to first determine if
> > the mmap lock is required, simply do it per-page as needed. Split out
> > all this logic into a separate binder_get_user_page_remote() function.
> >
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> One nit, otherwise looks okay to me.
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> Carlos Llamas <cmllamas@google.com> writes:
> > +		unsigned long index;
> > -		size_t index;
> 
> You're changing the type of index to unsigned long here, but it seems to
> me that size_t is the correct type.

Perhaps size_t made sense before the addresses were also moved to
unsigned long. I think this is a better fit now.

--
Carlos Llamas
