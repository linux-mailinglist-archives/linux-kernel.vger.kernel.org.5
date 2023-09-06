Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8867B793E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbjIFOJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjIFOJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:09:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE0FA9;
        Wed,  6 Sep 2023 07:09:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so3183818f8f.3;
        Wed, 06 Sep 2023 07:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694009349; x=1694614149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9W/IcTlMNGZK9Ps/aVx0GxYtJz9nPGjUgurMbWW3dw=;
        b=QJfHpDJnpEUBAaI/6+tZGy1fH1WDgOp3YKCz/n6ngCpUQlV8NvDwgJHuCan5vQG3dk
         WNuS1CJ6pBxFbso16ZncRyipJ6uwHpVO9tvnicwwVSv+0cg8nraZWptPuCUz6zLj5Xuf
         nEC0dnrmyE56BnOYwqWbmtqDWzNZJp7dsqMhr52jFR1zSwP3l09/lWD1Z6ftXSNvOtfU
         UyD8fFFJq2eH8hmfzqom2NX2JvT+QW29clVjOJQnSbRfXjK3dTKYxg5s3++5cDYQMpDw
         S3Rs8lTaDIlAbXrjIbUONrKXZ44NWxmSGbeBFPsUnYTizQuZ3lxy/UkfGMCUub844RkX
         xjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694009349; x=1694614149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9W/IcTlMNGZK9Ps/aVx0GxYtJz9nPGjUgurMbWW3dw=;
        b=ir61yBKoico30vhFVmQQF/ZUvqCw3Ymb2p03x9ISosBMDR0K9YJGTzP+nPR5fEQTYY
         qe3qi0+ufoJfZh8D+s7ipvHg1TiOrznpXILp5jZQBD/FUe6+f+CWZ5cz8XdOZvZRVTUe
         nf+yFXiaD2DcaVr1tkGVpk3qXIoFlKeqTDF7It61eKWkBiWG1UkZJJM2RkjUbLmJ8Js1
         NkjXFu7oLQN9bRVNiZyYr0oK2hKc5kiqLirROwcA+k2m5zW3oaUxJaANgSTAjcHin+3+
         fOs8GEJ00inACiO9o6libjNK0K3Q5HxoVQa2EuVZzu65JAPcpuNd0rwMKrLg8EHsdEUb
         TvgQ==
X-Gm-Message-State: AOJu0Yz+rdbk0zThRXsbI6WxnGPVgPL19lC5IVOlsfnVA2sh0AC6qqx7
        lk63kYFQEjvCg4uq04ll8uMveczg2Ps=
X-Google-Smtp-Source: AGHT+IEyyJOYBjWMd5RqK365SmNrfFzw+bEYRaLE3YHtYnxhlNi1gTmlhpmWYimIiShBesCw0X57nQ==
X-Received: by 2002:a05:6000:184:b0:313:f1c8:a968 with SMTP id p4-20020a056000018400b00313f1c8a968mr2423710wrx.2.1694009348590;
        Wed, 06 Sep 2023 07:09:08 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003179d5aee67sm20483099wrf.94.2023.09.06.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:09:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 6 Sep 2023 16:09:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] x86/platform/uv: refactor deprecated strcpy and
 strncpy
Message-ID: <ZPiH/ds9oeimXDdb@gmail.com>
References: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
 <ZPhsSzHG6YMViOSk@gmail.com>
 <bce762af-0da7-bb5e-1580-b42803c183f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bce762af-0da7-bb5e-1580-b42803c183f6@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hans de Goede <hdegoede@redhat.com> wrote:

> Hi Ingo,
> 
> On 9/6/23 14:10, Ingo Molnar wrote:
> > 
> > * Justin Stitt <justinstitt@google.com> wrote:
> > 
> >> Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
> >> destination strings [1].
> >>
> >> We can see that `arg` and `uv_nmi_action` are expected to be
> >> NUL-terminated strings due to their use within `strcmp()` and format
> >> strings respectively.
> >>
> >> With this in mind, a suitable replacement is `strscpy` [2] due to the
> >> fact that it guarantees NUL-termination on its destination buffer
> >> argument which is _not_ the case for `strncpy` or `strcpy`!
> >>
> >> In this case, we can drop both the forced NUL-termination and the `... -1` from:
> >> |       strncpy(arg, val, ACTION_LEN - 1);
> >> as `strscpy` implicitly has this behavior.
> >>
> >> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> >> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> >> Link: https://github.com/KSPP/linux/issues/90
> >> Cc: linux-hardening@vger.kernel.org
> >> Signed-off-by: Justin Stitt <justinstitt@google.com>
> > 
> >>  arch/x86/platform/uv/uv_nmi.c | 7 +++----
> >>  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > Note that this commit is already upstream:
> > 
> >   1e6f01f72855 ("x86/platform/uv: Refactor code using deprecated strcpy()/strncpy() interfaces to use strscpy()")
> > 
> > Below is the delta your v3 patch has compared to what is upstream - is it 
> > really necessary to open code it, instead of using strnchrnul() as your 
> > original patch did? Am I missing anything here?
> 
> The new version is a result of a review from my because IMHO:
> 
> 	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);
> 
> Is really unreadable / really hard to reason about if
> this is actually correct and does not contain any
> of by 1 bugs.
> 
> Note that the diff of v3 compared to the code before v2 landed is
> actually smaller now and actually matches the subject of:
> "refactor deprecated strcpy and strncpy"
> 
> Where as v2 actually touches more code / refactor things
> which fall outside of a "one change per patch" approach.
> The:
> 
> 	p = strchr(arg, '\n');
> 	if (p)
> 		*p = '\0';
> 
> was already there before v2 landed.
> 
> I also suggested to do a follow up patch to change things to:
> 
> 	strscpy(arg, val, sizeof(arg));
> 	p = strchrnul(arg, '\n');
> 	*p = '\0';
> 
> Which IMHO is much more readable then what has landed
> now. But since v2 has already landed I guess the best
> thing is just to stick with what we have upstream now...

Well, how about we do a delta patch with all the changes
you suggested? I'm all for readability.

Thanks,

	Ingo
