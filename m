Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F53811C14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379326AbjLMSPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjLMSPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:15:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B64B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:15:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcd44cdca3so778729276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702491315; x=1703096115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=blvS/vSMP5wGXcIzzo9Bxe4pmP25PsC7/K8dybntrXg=;
        b=g+yrA8Mfg6goxn3eK0IeQIAef/SB81WKRvOAU9basbrL3SvJfGjR9Hh+PZj1lfg/1a
         +nEXbap7dAoDFVI3VIL9MBY7/SIFSfdZ2HoBNujd6dNFghHPI9f/+ZsMJZTZ39aslPHp
         AA+UAxijsA96WJXJ4lFn5DXS+DvAVTs5RsuL8deviqj8Vt1ezltOChUJ8BDO3WzzTlTW
         UXYik3PIsqVuxgqJYuYqSv1UB5/e8vORnVUZ2bkm5QpIPe2vgqbU2JcGokAVMLvXMD7I
         C+B+S1xcmfb8DepfK4ehxXgjwn9w2+MfNZjD5kV2POa+432AXdY9MVcyBa71U79sTCD4
         GKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702491315; x=1703096115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blvS/vSMP5wGXcIzzo9Bxe4pmP25PsC7/K8dybntrXg=;
        b=A48YCjtYp3SB+rtztjZF01DsXRrBW3iZS8ydGlT4Oj7Eo97PkEgfRIGXk2xhnf+1Wo
         uo/TgQ4nJhAgHeDYqMYPrnTrHCXohRLi7YSegqUC3hU3wspzhhxYmW0k5BQ4j9q7uWk+
         H6RVdTQmQ1tMdkqbhppS6D66v9ORB5uFa2qilD9hbx+iPFgn1bOcFc6XDKg86kmwhybf
         FcUCtgIGWHg9qEF6XdH79fBZ25lgITzifmfKIOHoXYXqXQ/cjOsxbScqTQ8EIlMQqjFv
         3hnvl0ew7MZF/ZQWpEvc/qga+1MoVInOqg6cfTFw7Im/HStE/XkAXUG3K4P2sXqYx9Ao
         6YTg==
X-Gm-Message-State: AOJu0YyJIb0ZjJ9W9szXe+7vhWUa/meiF3fBmHgpmmRrfA+nGl7Xso+c
        /vnJ1I6BE2VcVDmnlgFzHNZ6AI//1Pk=
X-Google-Smtp-Source: AGHT+IGFZeUrJrNyb9PFJw/6+D7tjY6iEaOBrvsPZLWtjmp8gFpRySGHdxgk85AyIfxdxLa5ETqGrWwR6y4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:1e46:0:b0:db5:4a39:feb8 with SMTP id
 e67-20020a251e46000000b00db54a39feb8mr64580ybe.8.1702491314920; Wed, 13 Dec
 2023 10:15:14 -0800 (PST)
Date:   Wed, 13 Dec 2023 10:15:13 -0800
In-Reply-To: <84ad3082-794b-443f-874a-d304934a395b@redhat.com>
Mime-Version: 1.0
References: <20231208184628.2297994-1-pbonzini@redhat.com> <ZXPRGzgWFqFdI_ep@google.com>
 <184e253d-06c4-419e-b2b4-7cce1f875ba5@redhat.com> <ZXnoCadq2J3cPz2r@google.com>
 <84ad3082-794b-443f-874a-d304934a395b@redhat.com>
Message-ID: <ZXn0sR6IyzLzVHW-@google.com>
Subject: Re: [PATCH] KVM: selftests: fix supported_flags for aarch64
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shaoqin Huang <shahuang@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023, Paolo Bonzini wrote:
> On 12/13/23 18:21, Sean Christopherson wrote:
> > On Tue, Dec 12, 2023, Paolo Bonzini wrote:
> > > On 12/9/23 03:29, Sean Christopherson wrote:
> > > > On Fri, Dec 08, 2023, Paolo Bonzini wrote:
> > > > > KVM/Arm supports readonly memslots; fix the calculation of
> > > > > supported_flags in set_memory_region_test.c, otherwise the
> > > > > test fails.
> > > > 
> > > > You got beat by a few hours, and by a better solution ;-)
> > > > 
> > > > https://lore.kernel.org/all/20231208033505.2930064-1-shahuang@redhat.com
> > > 
> > > Better but also wrong---and my patch has the debatable merit of more
> > > clearly exposing the wrongness.  Testing individual architectures is bad,
> > > but testing __KVM_HAVE_READONLY_MEM makes the test fail when running a new
> > > test on an old kernel.
> > 
> > But we already crossed that bridge and burned it for good measure by switching
> > to KVM_SET_USER_MEMORY_REGION2, i.e. as of commit
> > 
> >    8d99e347c097 ("KVM: selftests: Convert lib's mem regions to KVM_SET_USER_MEMORY_REGION2")
> > 
> > selftests built against a new kernel can't run on an old kernel.  Building KVM
> > selftests requires kernel headers, so while not having a hard requirement that
> > the uapi headers are fresh would be nice, I don't think it buys all that much.
> > 
> > If we wanted to assert that x86, arm64, etc. enumerate __KVM_HAVE_READONLY_MEM,
> > i.e. ensure that read-only memory is supported as expected, then that can be done
> > as a completely unrelated test.
> 
> selftests have the luxury of having sync-ed kernel headers, but in general
> userspace won't, and that means __KVM_HAVE_READONLY_MEM would be a very poor
> userspace API.  Fortunately it has "__" so it is not userspace API at all,
> and I don't want selftests to treat it as one.

Wait, what?  How does double underscores exempt it from being uAPI?  AIUI, the C
standard effectively ensures that userspace won't define/declare symbols with
double underscores, i.e. ensures there won't be conflicts.  But pretty much all
of the kernel-defined types are prefixed with "__", e.g. __u8 and friends, so I
don't see how prefixing with "__" exempts something from becoming uAPI.

I completely agree that __KVM_HAVE_READONLY_MEM shouldn't be uAPI, but then it
really, really shouldn't be defined in arch/x86/include/uapi/asm/kvm.h.
