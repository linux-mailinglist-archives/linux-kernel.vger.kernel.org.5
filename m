Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9C67B3A40
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjI2Sw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjI2Swz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:52:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114A019F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:52:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c62d61dc96so58527985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696013573; x=1696618373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzdCDgqRjuyIGpHmaR9Azk80J00BBZTlSEkRESoXfhQ=;
        b=gRYCQfyue2HOkrNKQXh+SDKrMBQbgRjw4K8UKCMusaqHYTkiU4YM0PmWVwVIkppfBO
         MAVirEXb9dMjXkV10N0x6fXxKiBPNJVNDkxtk1NlflvPE1ly7o/iL9zkM/sYKnFHRucV
         RxPqyNPswzW6VL+6N6xmp9AHH0TuKWR1kPhAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013573; x=1696618373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzdCDgqRjuyIGpHmaR9Azk80J00BBZTlSEkRESoXfhQ=;
        b=bZFP+JOBX50rZ9vT3alnVUbERYLSvzKERTJ0jzPJHOw4zrCVhQ7qNIjMfcXkYpZ/BU
         UH3KAHRFqhBpv/8VVGUVWTb1TEuGcPGDvf2NvoCtDZI/knQcCdFi2McSULGHCIjZ3x80
         JPAzeQEYz53F5g+pedacVlXrE/lqMloFqDstB9whjt8CCQW+u2K0ZzaUiikKzHfkusHC
         tloPkm/X9FjiM3Ljro/bCdqAxwivKHGrjU82/mTil8ENaYSDu5vLcj721HaUYmnx/IdK
         MNNJh6MxNuAfZuHCT5wCMozlOjTu/JmEaJonvbbFKyp9fvoqq6X4frw/J0XsrZOClHsq
         l6hA==
X-Gm-Message-State: AOJu0YwilD6vIrr053u6fGVhK3LzT7kagfjQ/aJkhismcBUoslW+kCWy
        EwCbDKHGrChWyfEPeeroCydKXA==
X-Google-Smtp-Source: AGHT+IENEEnMjhVkasG2A9B4/nMon9HuhFU3IIPi76rU6zOburdOWJMnX9N1jfa2EOABWMIx9iDMnA==
X-Received: by 2002:a17:903:32c7:b0:1c3:f764:8428 with SMTP id i7-20020a17090332c700b001c3f7648428mr6177351plr.0.1696013573528;
        Fri, 29 Sep 2023 11:52:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902db1200b001c72c07c9d9sm4829458plx.308.2023.09.29.11.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:52:53 -0700 (PDT)
Date:   Fri, 29 Sep 2023 11:52:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Rheinsberg <david@readahead.eu>
Cc:     Justin Stitt <justinstitt@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: uhid: refactor deprecated strncpy
Message-ID: <202309291151.11AFC5F83@keescook>
References: <20230914-strncpy-drivers-hid-uhid-c-v1-1-18a190060d8d@google.com>
 <202309142206.60836CE@keescook>
 <98d981a1-4e4c-4173-b8eb-09b4245bca60@app.fastmail.com>
 <202309151342.DFA6CA5C7@keescook>
 <72b7c13a-5f82-498b-84a3-b6e9b61c0e3a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72b7c13a-5f82-498b-84a3-b6e9b61c0e3a@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 09:37:53AM +0200, David Rheinsberg wrote:
> Hey
> 
> On Fri, Sep 15, 2023, at 10:48 PM, Kees Cook wrote:
> > On Fri, Sep 15, 2023 at 09:36:23AM +0200, David Rheinsberg wrote:
> >> Hi
> >> 
> >> On Fri, Sep 15, 2023, at 7:13 AM, Kees Cook wrote:
> >> >> -	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
> >> >> -	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
> >> >> -	strncpy(hid->name, ev->u.create2.name, len);
> >> >> -	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
> >> >> -	strncpy(hid->phys, ev->u.create2.phys, len);
> >> >> -	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
> >> >> -	strncpy(hid->uniq, ev->u.create2.uniq, len);
> >> >
> >> > ev->u.create2 is:
> >> > struct uhid_create2_req {
> >> >         __u8 name[128];
> >> >         __u8 phys[64];
> >> >         __u8 uniq[64];
> >> > 	...
> >> >
> >> > hid is:
> >> > struct hid_device { /* device report descriptor */
> >> > 	...
> >> >         char name[128]; /* Device name */
> >> >         char phys[64]; /* Device physical location */
> >> >         char uniq[64]; /* Device unique identifier (serial #) */
> >> >
> >> > So these "min" calls are redundant -- it wants to copy at most 1 less so
> >> > it can be %NUL terminated. Which is what strscpy() already does. And
> >> > source and dest are the same size, so we can't over-read source if it
> >> > weren't terminated (since strscpy won't overread like strlcpy).
> >> 
> >> I *really* think we should keep the `min` calls. The compiler
> >> should already optimize them away, as both arguments are compile-time
> >> constants. There is no inherent reason why source and target are equal in
> >> size. Yes, it is unlikely to change, but I don't understand why we would
> >> want to implicitly rely on it, rather than make the compiler verify it for
> >> us. And `struct hid_device` is very much allowed to change in the future.
> >> 
> >> As an alternative, you can use BUILD_BUG_ON() and verify both are equal in length.
> >
> > If we can't depend on ev->u.create2.name/phys/uniq being %NUL-terminated,
> > we've already done the "min" calculations, and we've already got the
> > dest zeroed, then I suspect the thing to do is just use memcpy instead
> > of strncpy (or strscpy).
> 
> If you use memcpy, you might copy garbage trailing the terminating zero. This is not particularly wrong, but also not really nice if user-space relies on the kernel to treat it as a string. You don't know whether a query of the string returns trailing bytes, and thus might expose data that user-space did not intend to share.
> 
> I mean, this is why the code uses strncpy().

Justin, can you respin this patch (with an updated Subject and commit
log), and add BUILD_BUG_ON() to verify the sizes are the same in addition
to what you already had in the original patch?

I think that'll give us the right balance between correctness,
readability, and future-proofing.

-Kees

-- 
Kees Cook
