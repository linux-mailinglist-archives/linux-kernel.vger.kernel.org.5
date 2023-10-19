Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A332C7CEE47
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjJSC4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJSC4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:56:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD6812F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:56:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9daca2b85so2498775ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697684198; x=1698288998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qt9gf/PL1lYOKgkfcbXZbv81GPGQPWNj0cKuLdM0ILI=;
        b=WEoka8c6zBOnqKMmDonTXDBDsb43+5rBMZTsz0KlEC+C9EcrB0SzA6XWCA/ayJWTwf
         GtJZCGNDbA8pqZ0k82RKwgugV/IvbkDg9doYoIV500FiDHxS0+TNngEIhaflI2PhgzeI
         YGFwibItCDRKIaD1MCiv+ysK5+DMFOfJSFkM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697684198; x=1698288998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qt9gf/PL1lYOKgkfcbXZbv81GPGQPWNj0cKuLdM0ILI=;
        b=VtE0vAMMqcX/tggjljobHOLhQBbJ6w5JaoyRaStyQL6woO55rkboqFxlM0brTQy8WO
         v1Nn1ULU/1FT0WCpEpoX/67j7MAHj5NWEIa3dMtQ1nWX+WDuxOB4lrFEy6b4G4kjQSom
         cETBoBqUedCq/Hd+odRNSQwijBRpcQM0JbK0nMgRfBbJooELUIMgJLAID/JgwCHN2w1N
         DijMKUFbXX7tDE0uCE1Eb7wYGNY5FhTfsbuGmRgblzd1yr2NEq9DWa8XGCgj3Z1z1Dzf
         XXx45/WVR5SVYPMbhnG+rWWvQy9+U7Q94WsyxGEQvekTT3otI10Zpr0PX/EdZ8DwNWnT
         9QAQ==
X-Gm-Message-State: AOJu0YzPTwMa+6+p3ZVQjqPi6dvioYPRS0Dyg4NX/rJS3fMs/nRDmPXg
        juhIUUWwtvAjfEGn1D3y8f7TUQ==
X-Google-Smtp-Source: AGHT+IEc2jx80SzCj1LSDYEO0e1q5M/K/F9blgFerLPDuJHdZ4SWawnrbmkbg4WP9tsfR56n7VHi3w==
X-Received: by 2002:a17:902:ce88:b0:1c0:cbaf:6954 with SMTP id f8-20020a170902ce8800b001c0cbaf6954mr903068plg.25.1697684197815;
        Wed, 18 Oct 2023 19:56:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ix11-20020a170902f80b00b001b7fd27144dsm656690plb.40.2023.10.18.19.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 19:56:37 -0700 (PDT)
Date:   Wed, 18 Oct 2023 19:56:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        James Dutton <james.dutton@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Calvince Otieno <calvncce@gmail.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: Is strncpy really less secure than strscpy ?
Message-ID: <202310181929.BCC265C@keescook>
References: <CAAMvbhG40h6pqSf91BurDHQqeoKfP30bwnpvSDRHBN4Hoygqew@mail.gmail.com>
 <ZTCLLinnaqIILXsJ@debian.me>
 <cf6950bc-32c8-459c-a4b1-ca0a291fc2f8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf6950bc-32c8-459c-a4b1-ca0a291fc2f8@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 07:27:20PM -0700, Randy Dunlap wrote:
> 
> 
> On 10/18/23 18:49, Bagas Sanjaya wrote:
> > [Disclaimer: I have little to no knowledge of C, so things may be wrong.
> >  Please correct me if it is the case. Also Cc: recent people who work on
> >  strscpy() conversion.]

Here are the current docs on the deprecated use of strncpy:
https://docs.kernel.org/process/deprecated.html#strncpy-on-nul-terminated-strings
which could probably be improved.

> Also Cc: the STRING maintainers.
> 
> > On Thu, Oct 19, 2023 at 12:22:33AM +0100, James Dutton wrote:
> >> Is strncpy really less secure than strscpy ?

Very. :)

> >> If one uses strncpy and thus put a limit on the buffer size during the
> >> copy, it is safe. There are no writes outside of the buffer.
> >> If one uses strscpy and thus put a limit on the buffer size during the
> >> copy, it is safe. There are no writes outside of the buffer.
> > 
> > Well, assuming that the string is NUL-terminated, the end result should
> > be the same.

Note the use of "If" in the above sentences. :) This is what makes
strncpy so dangerous -- it's only "correct" if the length argument is
less than the size of the _source_ buffer. And by "correct", I mean
that only then will strncpy produce a C-string. If not, it's a memcpy
and leaves the buffer unterminated. This lack of %NUL-termination leads
to all kinds of potential "downstream" problems with reading past the
end of the buffer, etc.

One of the easiest ways to avoid bugs is to remove ambiguity, and
strncpy is full of it. :P

Almost more important than the potential lack of %NUL-termination is
the fact that strncpy() doesn't tell other maintainers _why_ it was used
because it has several "effects" that aren't always intended:

- is the destination supposed to be %NUL terminated? (We covered this)
- is the destination supposed to be %NUL padded?

strncpy pads the destination -- is this needed? Is it a waste of CPU
time?

> > 
> >> But, one can fit more characters in strncpy than strscpy because
> >> strscpy enforces the final \0 on the end.
> >> One could argue that strncpy is better because it might save the space
> >> of one char at the end of a string array.

At the cost of creating non-C-strings. And this is a completely bonkers
result for the "C String API" to produce. :P

> >> There are cases where strncpy might be unsafe. For example copying
> >> between arrays of different sizes, and that is a case where strscpy
> >> might be safer, but strncpy can be made safe if one ensures that the
> >> size used in strncpy is the smallest of the two different array sizes.

The CONFIG_FORTIFY_SOURCE option in the kernel adds a bunch of
sanity-checking to the APIs (some of which can be determined at compile
time), but it doesn't remove the ambiguity of using strncpy. We want the
kernel to have maintainable code, and when it's not clear which of a
handful of side-effects are _intended_ from an API, that's a bad API. :)

> > 
> > Code example on both cases?
> > 
> >>
> >> If one blindly replaces strncpy with strscpy across all uses, one
> >> could unintentionally be truncating the results and introduce new
> >> bugs.

Yes, of course. That's why we're not blindly replacing them. :) And the
diagnostic criteria has been carefully described:
https://github.com/KSPP/linux/issues/90

-Kees

-- 
Kees Cook
