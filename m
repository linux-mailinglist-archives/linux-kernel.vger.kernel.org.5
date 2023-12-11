Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B280D195
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjLKQ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjLKQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:26:36 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE568E;
        Mon, 11 Dec 2023 08:26:42 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1fae88e66eso95222866b.3;
        Mon, 11 Dec 2023 08:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312001; x=1702916801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAIDey4/RJpew1wYosy/s17kDRCEpYHvKTUhWB5Rkvw=;
        b=IdTvJob8auwMK/WI9suBJdgMxjww90QxPR/YTeoDKWKRDTAO9xWK9O3GFdW5GtNtLB
         jlTW3wOSFMmcx9qHZF7Yw1e8+ckjW5AL9eVs/IyXhQAOldq3iymF5LJxkqPtSGMvm5CN
         74ZNL9G1nmUh/Vow8+r4FnERXKfRMPlETYRvVx+/mPbvRqtNrd2P0m9Eg2y1DC4ctp+f
         ErwwIKcGT/A85W2hCegbJCKJ3kOYBSLJOQDB5iToAY2oDtcUWs777EhKaN/Han+hFGpF
         hKqzgCB6iI29S1kDwoOf0X+cwjhYZZmwrmQZKxdyJ+yeWjde8uCoqnLo3AwiAfvHFNP8
         yo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312001; x=1702916801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAIDey4/RJpew1wYosy/s17kDRCEpYHvKTUhWB5Rkvw=;
        b=XsMzbq47dHBrD4C/v1GBNT2ClO9CSN6BUTHsyQCgnTKn85OISZaqiRwZZ1QYR5eCI4
         d/jYW6GWxLov/Ga+tSHaVukM72XfBhlbkVLt35JbsS3Rrw3oqH+w5LGC+XHBRIitd22T
         mmzkbrSMtBwK6O7/NvwZAo4EMRzydzzhOALPAfeAv5BK0wXUnrukVMx8YylyfFDiuVLY
         WP3oj5/r5xSvuCOgfuvIujn4ou3Um5IKyRESRZbXrcDfmShRhEgR/cGKp8zMWIpDZbP1
         DfNbVcpuMymeCvjVKXXy/LlGc6bau8YCASZ8pNmbIvp6UwKr6v58lasLyKd9pmI6c6BX
         4Xlg==
X-Gm-Message-State: AOJu0YwfuNoxUOQ1ENwtc5lPeDOBouq0xjI0eJQt9GrW78iZNDSPNjF6
        M8wjcpyHHnfMF0iRVRNOP+5ptC7pMQ==
X-Google-Smtp-Source: AGHT+IE8SA+Zfu0wxgDjSfpcJ+DvSrQvEKDAlLcq6l3Sc9LzND6SYsZ2l9I7s4JZ3N/dxoOKrwkucA==
X-Received: by 2002:a17:906:194a:b0:a1d:731b:1ae3 with SMTP id b10-20020a170906194a00b00a1d731b1ae3mr2266030eje.100.1702312000634;
        Mon, 11 Dec 2023 08:26:40 -0800 (PST)
Received: from p183 ([46.53.250.155])
        by smtp.gmail.com with ESMTPSA id vw11-20020a170907a70b00b00a1cbb055575sm4993429ejc.180.2023.12.11.08.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:26:39 -0800 (PST)
Date:   Mon, 11 Dec 2023 19:26:37 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org
Subject: Re: [PATCH v3] ELF: document some de-facto PT_* ABI quirks
Message-ID: <5c50e975-4e57-4feb-8f14-036b7937f350@p183>
References: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
 <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
 <c4233c97-306c-4db8-9667-34fc31ec4aed@p183>
 <87edp7jyu4.fsf@meer.lwn.net>
 <88d3f1bb-f4e0-4c40-9304-3843513a1262@p183>
 <202312061456.2103DA1@keescook>
 <874jgugilq.fsf@email.froward.int.ebiederm.org>
 <57f5aa9d-79c5-4f65-b90f-204600edfb80@p183>
 <87edftbr6d.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edftbr6d.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 04:58:50PM -0600, Eric W. Biederman wrote:
> Alexey Dobriyan <adobriyan@gmail.com> writes:
> 
> > On Thu, Dec 07, 2023 at 09:03:45AM -0600, Eric W. Biederman wrote:

> >> Quite frankly if we are going to do something with this my sense is that
> >> we should fail the execve with a clear error code as userspace should
> >> not be doing this, and accepting a malformed executable will hide
> >> errors, and perhaps hide someone causing problems.
> >
> > Maybe do it for PT_GNU_PROPERTY which is relatively new.
> >
> >> I really don't think having multiple copies of these headers with
> >> different values is something we should encourage.
> >> 
> >> It looks like -ELIBBAD is the documented way to fail and report
> >> a bad file format.
> >
> > It is obvious you don't know how much will break.
> 
> My assumption is frankly that nothing will break.  My quick examination
> of userspace binaries suggests that nothing is silly enough to duplicate
> such headers.

Ha! Non-overlapping PT_LOAD segments is reasonable requirement (why would
you have them?) but it was reverted.

> Do you know of a binaries in userspace that duplicate these headers?
> 
> Without a documented ordering arguably anything that results in
> these headers being duplicated is already buggy, and broken.
> 
> I can think of no use for duplicating these headers other than
> as some kind of gadget in an exploit.  I don't see how such
> a gadget would be useful currently.
> 
> >
> >> For PT_GNU_PROPTERTY perhaps we should accept it anywhere, instead of
> >> silently ignoring it depending upon it's location?
> >> 
> >> I thinking change the code to talk one pass through the program headers
> >> to identify the interesting headers, and then with the interesting
> >> headers all identified we go do something with them.
> >> 
> >> Anyway just my opinion, but that is what it feels like to me.
> >
> > _Not_ checking for duplicates will result in the simplest and fastest exec.
> > which is what current code does.
> 
> Given that I/O is involved taking a pre-pass through the headers is
> in the noise, and it might even make the code faster as it would
> prime the code for the other passes.

Branches will evict other branches from branch predictor.
And it is always more code.

ELF is very rigid format. E.g segment headers can overlap everything
else and it is not a problem. Overmapped PT_LOAD segments aren't
a problem too (for the kernel).

These things should have been rejected from the very beginning.

I'd even argue kernel rejects too much:

		elf_entry = e_entry;
                if (BAD_ADDR(elf_entry)) {
                        retval = -EINVAL;
                        goto out_free_dentry;
                }

Why even check? If e_entry is bad than process will segfault and that's it.

		elf_ppnt->p_filesz > elf_ppnt->p_memsz

Again, why check, just map the minimum.

> The fastest of course would be to have the elf loader only look
> at the first of any of these headers.
> 
> What got you wanting to document how we handle duplicates?

I read ELF code too much and noticed that loops are slightly different,
that's all.
