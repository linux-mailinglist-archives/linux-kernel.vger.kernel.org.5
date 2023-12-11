Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D080C2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjLKIXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjLKIXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:23:39 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06FBD5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:23:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so2897018a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702283025; x=1702887825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SGMAohI1bI080siIkPTaq7KnlqYCY8ucsxsXTXtBIQ=;
        b=r6xf+iJQQBao2+2QuLGFBT6ysxoN2/o4W96/K6c0U2FKKuET66to4MpA0wpCSK8fO1
         sOCtPN9DE/xRk/y0FQchypmp229KDq7qF+YBs457x45NLBvQj8oPCp6EgDMhMxfpF21o
         6hnHxbeSSmxRQg7u+kzk5ygd2jbp5DnmztZj1E1Ry63HzVz/IXF5XDjDvBOcT2fEeJks
         nCcOR/qhKyfuE/wkMXSsJzLD3Ds7VT852VEMfbt+dgyVlUdsAlXZv28k5TF2HeauoXVB
         eBOt5Ybt2IIgpIdwAGBWEDfYyJzfN8s6BF4SCzXzYi8JhHofrLmqwuOwzLEPrta8Wrex
         FbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702283025; x=1702887825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SGMAohI1bI080siIkPTaq7KnlqYCY8ucsxsXTXtBIQ=;
        b=ZOVpBZF3FncqBzxXIsA+8RupmUeJEltTQiIDXYxX0JPjA/35xcUCUGFRJcxJ6Abktv
         q5aLlnndn+G2nNtqjXefmPzkgX5RhuBclnzq7OGtVMIffJpDmO2oeRrBIHVHu+uopZzh
         b+tOU2aS4wXTrQiUl7TmEt3i7s32IJuTRFQ5T2bef8kTeZFHUN7W5lpPBncn5ijla8yP
         az3wxCV1B6JhCTkTIBvTcPA3hX1jdNOu9dbM4uaCTikIoI4j7rZgrIqzHcj83Eiap3nx
         uNB6gCBMVoP1kEGGU/K2HnPxzdUVWP6TyV3ITGKMm2sxhqPr3bwjk0HblTRVbKPyMQwg
         m7Ig==
X-Gm-Message-State: AOJu0YyFooFjH6UgMOWGgIpeN+9xC7Jr7fhPk9Yaktl1CvdFCKUyvDuy
        nCgjaDc4w2Uvt/bgDj4lrFcLJw==
X-Google-Smtp-Source: AGHT+IHUybRnAug3nsceifCVm05j+nlMJJ89oCKo2V9GgwS0YbdYklk/h05eKA9tfXjZHnUAxCL7Mw==
X-Received: by 2002:a17:90a:df86:b0:28a:464d:5ecb with SMTP id p6-20020a17090adf8600b0028a464d5ecbmr1681094pjv.36.1702283025392;
        Mon, 11 Dec 2023 00:23:45 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id c11-20020a17090a020b00b00286d75e10e4sm8527933pjc.37.2023.12.11.00.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:23:44 -0800 (PST)
Date:   Mon, 11 Dec 2023 13:53:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Benno Lossin <benno.lossin@proton.me>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: rust: Clarify that 'rustup override' applies to
 build directory
Message-ID: <20231211082342.dkcnlamsyaqxaylg@vireshk-i7>
References: <bf0d4ff21bc25d1ba3a31e49a32bde06dcaf6e44.1702030679.git.viresh.kumar@linaro.org>
 <4738ad1c-eb54-4ad6-98c8-3852de3e8fc3@proton.me>
 <20231211064742.63l4cmvxe4uso5us@vireshk-i7>
 <87h6kpf9am.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6kpf9am.fsf@metaspace.dk>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-23, 09:09, Andreas Hindborg (Samsung) wrote:
> 
> Thanks for fixing this Viresh!
> 
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
> > index f382914f4191..dee787f92d26 100644
> > --- a/Documentation/rust/quick-start.rst
> > +++ b/Documentation/rust/quick-start.rst
> > @@ -33,14 +33,17 @@ A particular version of the Rust compiler is required. Newer versions may or
> >  may not work because, for the moment, the kernel depends on some unstable
> >  Rust features.
> >
> > -If ``rustup`` is being used, enter the checked out source code directory
> > -and run::
> > +If ``rustup`` is being used, enter the kernel build directory and run::
> >
> >         rustup override set $(scripts/min-tool-version.sh rustc)
> 
> How about just specifying the path here:
> 
>          rustup override set --path=<build-dir> $(scripts/min-tool-version.sh rustc)

Hmm, this sounds good too. In that case the above line can be changed to:

"If ``rustup`` is being used, run::"

Looks okay ?

-- 
viresh
