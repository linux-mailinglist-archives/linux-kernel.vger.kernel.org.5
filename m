Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01CF8123F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjLNAgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjLNAgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:36:01 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B688410A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:36:05 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4258b6df295so140131cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702514164; x=1703118964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh/JIPLuSc5XTJsnIXetpV5afhDLqc5qWgt+ZxYeVCQ=;
        b=zugocgvmf1lxu84yfv4X9DbDntLR0AzZNqnReBvdS2ZE8OIoEw93XOQHmlvBQ0TZUn
         857KK9j5mIUY3RRJspg+5g/UO/nyZR4x0W7oBG53ARP+Th6LvdCQhNm3lVTD14GqjNhW
         VkGFrYefsMSFtfiQjVsFypCX4azcnrMif+HBWhdbf9p6wk8LqkBDBIFPj/qhvI07TsTW
         XwodgsLBUWbZMpE4ZlglFfU0eQApAafb1wh4721RL7hl/pFxr8HTSCO7AqKeo3b4LLXf
         BxIlqususmWl76ubddE7o8dq48aSKph0oKJxDUX9aKBeu3Buy0fqyi97CNfhoQJSG14G
         KSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514164; x=1703118964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rh/JIPLuSc5XTJsnIXetpV5afhDLqc5qWgt+ZxYeVCQ=;
        b=czKyBD+QFHmvHJoFl+o+Eubc0bnviTjI5qePoDUFa3F/vxjLolkStQpxeD+Twkn2Mb
         NhballUymVPJJbieN3+FBgsPVtJTQPrUl2aYNaPeS85K/mWZkruM9a6eTwyhy0jGulU0
         J11Js06FkFtzaigV5EwcoL6L/kJBAqQl5QRaHPRjolR+nQ3bGG2w3gTXeIuL7WFMXeKx
         A1fh+vQL62UUU20xOB9Dhbl05cHT3a+d6SHRdWq5EWOKRJ+mybA5/uBtvd9p9caCNEb2
         4bzGCxV1TFrFxUWU0Qph/fvVK1nfJMVxY53651vUgQZsvETS98y0cZifj6bRkGfG4fuF
         apJQ==
X-Gm-Message-State: AOJu0YwbrpML2DQLO1sQaDs5bRzTubKNPN++61GdXfiJAuoYoc2NBCj4
        HfZECjaaAapkd9s9KMSmmu3AxT5gS3titkzdi26ndntoiQxZdQK775jZBpgx
X-Google-Smtp-Source: AGHT+IFV9mswBOSTplU3GbpxbWwY83oDLBB8lfMgKwsXIlFx4/MATC30VcWkHbqFp7WCIuN5thSLGmaeWN2qqtvo+f4=
X-Received: by 2002:a05:622a:1a15:b0:425:47fc:e6e6 with SMTP id
 f21-20020a05622a1a1500b0042547fce6e6mr1655213qtb.4.1702514164149; Wed, 13 Dec
 2023 16:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
In-Reply-To: <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 13 Dec 2023 16:35:26 -0800
Message-ID: <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 4:39=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Dec 2023 at 15:17, <jeffxu@chromium.org> wrote:
> > +
> > +**types**: bit mask to specify the sealing types, they are:
>
> I really want a real-life use-case for more than one bit of "don't modify=
".
>
For the real-life use case question, Stephen R=C3=B6ttger and I put
description in the cover letter as well as the open discussion section
(mseal() vs immutable()) of patch 0/11.  Perhaps you are looking for more
details in chrome usage of the API, e.g. code-wise ?

> IOW, when would you *ever* say "seal this area, but MADV_DONTNEED is ok"?
>
The MADV_DONTNEED is OK for file-backed mapping.
As state in man page of madvise: [1]

"subsequent accesses of pages in the range will succeed,  but will
result in either repopulating the memory contents from the up-to-date
contents of the underlying mapped file"

> Or when would you *ever* say "seal this area, but mprotect()" is ok.
>
The fact  that openBSD allows RW=3D>RO transaction, as in its man page [2]

 "  At present, mprotect(2) may reduce permissions on immutable pages
  marked PROT_READ | PROT_WRITE to the less permissive PROT_READ."

suggests application might desire multiple ways to seal the "PROT" bits.

E.g.
Applications that wants a full lockdown of PROT and PKEY might use
SEAL_PROT_PKEY (Chrome case and implemented in this patch)

Application that desires RW=3D>RO transaction, might implement
SEAL_PROT_DOWNGRADEABLE, or specifically allow RW=3D>RO.
(not implemented but can be added in future as extension if  needed.)

> IOW, I want to know why we don't just do the BSD immutable thing, and
> why we need this multi-level sealing thing.
>
The details are discussed in mseal() vs immutable()) of the cover letter
(patch 0/11)

In short, BSD's immutable is designed specific for libc case, and Chrome
case is just different (e.g. the lifetime of those mappings and requirement=
 of
free/discard unused memory).

Single bit vs multi-bits are still up for discussion.
If there are strong opinions on the multiple-bits approach, (and
no objection on applying MM_SEAL_DISCARD_RO_ANON to the .text part
during libc dynamic loading, which has no effect anyway because it is
file backed.), we could combine all three bits into one. A side note is tha=
t we
could not add something such as SEAL_PROT_DOWNGRADEABLE later,
since pkey_mprotect is sealed.

I'm open to one bit approach. If we took that approach,
We might consider the following:

mseal() or
mseal(flags), flags are reserved for future use.

I appreciate a direction on this.

 [1] https://man7.org/linux/man-pages/man2/madvise.2.html
 [2] https://man.openbsd.org/mimmutable.2

-Jeff



>                Linus
