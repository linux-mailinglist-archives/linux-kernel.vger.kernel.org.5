Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E5D808B57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443163AbjLGPEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjLGPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:04:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324911AD;
        Thu,  7 Dec 2023 07:04:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54dcfca54e0so927030a12.1;
        Thu, 07 Dec 2023 07:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701961451; x=1702566251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5knuLR3hM6+9ZriPn9ZfBxLpEJULe7zgg0r8B9LwBQ=;
        b=egdvm1duQ5tReHHJzNPEU4eMC48Fj6r9Ttj/feZwBDAxSoB+UC+rN9hmT3D3hCgu0T
         XuT0m19pTrUM4BT0r9HUhEqLkjV4qvyghJ7+JbQn8o7F+hL+upbeOpp2z8yhXxFItZxn
         FAz0TZQHk+Ko3hk3v/U9Pvppa6AuZspRhbvJOnD01Twbv2Wie8zpnMAt7tgCZBixaUFO
         w5hNUfmYgYOybFPJ8eizV6Nt53f1E2vWN+NpbAbA5U5TAEcEeuCHsa3jLYvAMp34VgX+
         gmPimQXYPuRw/w9H4K684w+b0YT+a/oJOxEzOGmK8NrD/NHqOMOLumcWeMnjsoh1Gfe6
         bnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701961451; x=1702566251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5knuLR3hM6+9ZriPn9ZfBxLpEJULe7zgg0r8B9LwBQ=;
        b=r0/UIFEv/pYZFbEnFhO9W+6UAKGzQGTXh6rZHrfHIR1armj7u1wwUHngB96z3HKxGH
         bqCuv4P5/NzVKIonm2PA04Fi640xfpLaWwKiKIaFd3M7gOcdUAxNl7xAw73K0ucc/3iG
         HSDcZQA2McrR48Gts5jD1V867zUUqki/tjUiJT/wad8IQIbtzNqvu4ul7dAqVZWGvx1n
         1IvbQzvxsd/XPuaydgo2uoq/IpZdOOZiJLtP/Scsr4vBo7sN7k5K90sNEADZVon1fmn5
         t/xPGlEqSya8W3TKcwG5eFl1h2rzwTWjJqCqz+13PLXwrx62+MiauPctoKdep6UsrELK
         8coQ==
X-Gm-Message-State: AOJu0YzNCTfoeuwczG3n5uql4fT9mABGZ6X2F5IDvqFHpSc5j4N/Qc6N
        VHbw3qYYyIVBxBEGBkS35A==
X-Google-Smtp-Source: AGHT+IFzPn+Tpl0Dqjf9pYisVW6PQ3UPQIxV3FhkfzAPQYNjlrEhYEQunjqGN+M9/uWTk8nn3EcnPQ==
X-Received: by 2002:a17:906:1cd3:b0:a1d:7178:161d with SMTP id i19-20020a1709061cd300b00a1d7178161dmr1829704ejh.23.1701961451493;
        Thu, 07 Dec 2023 07:04:11 -0800 (PST)
Received: from p183 ([46.53.254.107])
        by smtp.gmail.com with ESMTPSA id q1-20020a1709066b0100b00a1d511c5c48sm926885ejr.152.2023.12.07.07.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 07:04:11 -0800 (PST)
Date:   Thu, 7 Dec 2023 18:04:09 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
Message-ID: <bb7fdb53-6917-44aa-8118-a8b357583c50@p183>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
 <202312061236.DE847C52AA@keescook>
 <87edfzavof.fsf@oldenburg.str.redhat.com>
 <202312061308.630C56CCA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202312061308.630C56CCA@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:09:01PM -0800, Kees Cook wrote:
> On Wed, Dec 06, 2023 at 10:05:36PM +0100, Florian Weimer wrote:
> > * Kees Cook:
> > 
> > > On Tue, Dec 05, 2023 at 07:01:34PM +0300, Alexey Dobriyan wrote:
> > >> Report available page shifts in arch independent manner, so that
> > >> userspace developers won't have to parse /proc/cpuinfo hunting
> > >> for arch specific strings:
> > >> 
> > >> Note!
> > >> 
> > >> This is strictly for userspace, if some page size is shutdown due
> > >> to kernel command line option or CPU bug workaround, than is must not
> > >> be reported in aux vector!
> > >
> > > Given Florian in CC, I assume this is something glibc would like to be
> > > using? Please mention this in the commit log.
> > 
> > Nope, I just wrote a random drive-by comment on the first version.
> 
> Ah, okay. Then Alexey, who do you expect to be the consumer of this new
> AT value?

libhugetlbfs and everyone who is using 2 MiB pages.

New code should look like this:

	#ifndef AT_PAGE_SHIFT_MASK
	#define AT_PAGE_SHIFT_MASK 29
	#endif
	unsigned long val = getauxval(AT_PAGE_SHIFT_MASK);
	if (val) {
		g_page_size_2mib = val & (1UL << 21);
		return;
	}
	// old 2 MiB page detection code

It is few lines of fast code before code they're already using.
