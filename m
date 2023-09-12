Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1641779C99B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjILIRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjILIRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:17:11 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1417DE7F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:17:07 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1d0f967fba8so1110731fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1694506626; x=1695111426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXU+Az+hQHKnh9VEDVMZv8o4CXQVJXkA/YbFwqve5Z4=;
        b=JxwYQGBjTMsUyLC36qTRAsWQwt6NFSy8yUagjZU4SsqgzI6N6ojJPit7QoJL34tU+Y
         O8QkD0q/qDeRRYBPnXE4xxFCzCrrHpeOjrjfhjOmdcOf/raMqVfDf3achlrF9BGIfIKZ
         uL8WBGMpPzrG90ykh9ajmHq8yIqfODAnBfBl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506626; x=1695111426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXU+Az+hQHKnh9VEDVMZv8o4CXQVJXkA/YbFwqve5Z4=;
        b=azI6ZfYIp1xlZotkeGBEnRpL4YQKLKrzORE65+EUxPD8L/Mmt4nRNd5bSaZHxmm6j5
         so70oRI0kFzFAG3PuYM1VGb76muepTvslQeS+lDC0snY9SKcZAsiFCDp2B6xIgHKzR3R
         z2Nki663v4PpLThjxQ/VDxQQjgBFPVZXf6LXqHyJLyepL/pxnkY/LzuFTUT/WfK8qUJH
         HhFVmYHcGkXj+sTFXUBaEQkiEAx59jQMEAwfRANWJ895vGGhBnFk7OXi+eHHnMWsSiz4
         jrZrtVSlcWFkEYpyP1jMtZ+JK5AXgV4st2QL6VHgjGq6c6thVi1coCeXdDvXxxTaEO4T
         v7Rw==
X-Gm-Message-State: AOJu0YyadjXIddbK7QM316z9cU8uIEmln11VKViXQ/PRCywI8DolXg3Z
        hwvvhM0eCq5LMDYpRnx6am+9fcfhGTWihku7KN5+2KhYMNEolngO
X-Google-Smtp-Source: AGHT+IH73ZjXl1JxBUfq9iPq01RsehAlRmnVV7JAFLTQqQFPTFq3qw8XY79jYX2syItET/Es0WqtbTdRyYCVKkdlDk0=
X-Received: by 2002:a05:6871:209:b0:1c8:b870:4e5e with SMTP id
 t9-20020a056871020900b001c8b8704e5emr11309749oad.3.1694506626293; Tue, 12 Sep
 2023 01:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tz=gx2_zrQ2XD8JNwW1dg6b+Byr5FgYAAq+2f29rydcgg@mail.gmail.com>
 <CAHk-=wg7zcmwWwYO=vEVJrTn7fuhpFNmv-6k-MptFYYqFofp4w@mail.gmail.com>
In-Reply-To: <CAHk-=wg7zcmwWwYO=vEVJrTn7fuhpFNmv-6k-MptFYYqFofp4w@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 12 Sep 2023 10:16:54 +0200
Message-ID: <CAKMK7uFZXqykUOAbdu6+vTdm4UukJVKLcNfZFdtxaLUafvoxJw@mail.gmail.com>
Subject: Re: [git pull] drm CI integration
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Sept 2023 at 21:05, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 30 Aug 2023 at 18:00, Dave Airlie <airlied@gmail.com> wrote:
> >
> > This is a PR to add drm-ci support files to the upstream tree.
>
> So I finally had no other pull requests pending, and spent some time
> looking at this, and I see nothing offensive.
>
> I did wonder how this then expands to having more than one subsystem
> using this (and mixing them possibly on the same CI system), but
> that's more about my ignorance about how the gitlab CI works than
> anything else, so that's certainly not a real concern.

I forgot to put this into my write up, but one reason I think gitlab
CI is a notch better than all the others is that it at least tries to
have an answer here:
- each gitlab repo has its own configuration for where to find the CI
files (also out-of-tree if you go really wild for hw testing maybe)
- you can include gitlab CI files

Which together means you can share common stuff like compile testing
or qemu based testing while easily having specific jobs per
driver/subsystem/whatever that do hw testing. So if media also gains
fd.o gitlab support the media stuff could be in drivers/media/ci (and
at that point we probably want scripts/ci for common stuff).

> The other side of that "I do wonder" coin is for when others want to
> use the same tests but using some other CI infrastructure, whether
> it's some AWS or google cloud thing, or github or whatever.

gitlab has a standalone runner, so at least for the sw-only stuff if
you have some other Ci (like distros that want to test everything)
they should be able to reuse the fd.o specific stuff fairly verbatim,
or at least with some minimal adjustements in upstream. So building a
CI-of-CIs should be doable. Worst case one level below reusing the
docker images should be doable in practically anything that can run a
vm.

> Anyway, considering that both of my idle curiosity reactions were
> about "if this is successful", I think me having those questions only
> means that I should pull this, rather than questioning the pull
> itself.
>
> If it works out so well that others want to actually do this and
> integrate our other selftests in similar manners, I think that would
> be lovely.
>
> And if - as you say - this is a failure and the whole thing gets
> deleted a year from now as "this didn't go anywhere", it doesn't look
> like it should cause a ton of problems either.
>
> Anyway, it's in my tree now, let's see where it goes.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
