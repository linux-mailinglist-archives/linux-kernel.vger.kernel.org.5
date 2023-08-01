Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD276C0C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjHAXUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjHAXUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:20:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3316F2139
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:20:50 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58456435437so72424607b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 16:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690932049; x=1691536849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nv6qBYunsdbsTaY6uXRci7C8TLoIW4Rt5jSeXwXm3B0=;
        b=0WAX2Ee9BLU4qIuUs/nXNN+WnktvhdNXDhANhGIA0E7TCaOO8AUZTaC0pdJuS6oelr
         xxXSUJtlB6LvUqF2xLZSDNFWHzOX2RNU8XlZu7kZytHv4EXt1EjIl4ornACC7j0LhAr9
         FQAMVB2WHFjOxTwfCEFM7vn/aq5msRRiE/kCbbHgrMEJ/SAZ7XcdjQv1EFm+/TbplCGo
         RH5HKanfN8U/6B/KV/F5IAKfyvu0H0PzYOEKg790w7RojxoLSeScG4vT1dgCvPtS1kRj
         jtvvJKb345Z2KWxRDthMpHwI55xP4L8bt97wJ/1hQWP9moVOtMRFTbwjHV1r/sQJ0O2Q
         NIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932049; x=1691536849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nv6qBYunsdbsTaY6uXRci7C8TLoIW4Rt5jSeXwXm3B0=;
        b=kc8BRJGDtRuA5hLczbw8rac+HBCHQ7aboV6i75kVVjf0BJ2EUxqg/KX6JvoNI9ZmhD
         K+ZDLoihPCTBZnminHYVFjN3Dj4AInbQYLgO/jJYgzpvxVyNKfzkzUSIUvIu42V7oo9l
         oTu26NOtIFTliZRfbkcmemRh/KWO3Zj8BjQTROOjrYjAGcMgrsk1rDUxr1ysWR/l8ZSp
         s3LU4MYcF8+fwe989pko/BSo8Cjc84s9m7hUYdFB8/RtdqTPbGGrwJNTRonxUf8o2RBI
         g1YhVnMjpAo3hsbrGpwU9kfYu819Qa6QC8BLU5tgIYVPiw79qmJ9fYFhgBJQHbrhbcS8
         VT/g==
X-Gm-Message-State: ABy/qLbsr5AGzhT3vx/LlcR5hB14PSMQw+sY07bbdWJgTK+mR7m+JYBZ
        N5ioxHNivJZdx1EFgoLanlQjLV6IQHo=
X-Google-Smtp-Source: APBJJlEiNeh2xNttaLa7aT9PniWfJxmo8CFVd0xxEs+x1xQ7MP5B8c56Ko5NniauI1a16uttVXZVajZwXcQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ac07:0:b0:583:5471:1717 with SMTP id
 k7-20020a81ac07000000b0058354711717mr131891ywh.10.1690932049480; Tue, 01 Aug
 2023 16:20:49 -0700 (PDT)
Date:   Tue, 1 Aug 2023 16:20:46 -0700
In-Reply-To: <ZMhjYo8bOsmsWcCL@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230729013535.1070024-1-seanjc@google.com> <20230729013535.1070024-7-seanjc@google.com>
 <ZMhjYo8bOsmsWcCL@yzhao56-desk.sh.intel.com>
Message-ID: <ZMmTTlHXnm3ywvvj@google.com>
Subject: Re: [PATCH v4 06/29] drm/i915/gvt: Explicitly check that vGPU is
 attached before shadowing
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongwei Ma <yongwei.ma@intel.com>,
        Ben Gardon <bgardon@google.com>
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

On Tue, Aug 01, 2023, Yan Zhao wrote:
> On Fri, Jul 28, 2023 at 06:35:12PM -0700, Sean Christopherson wrote:
> > Move the check that a vGPU is attacked from is_2MB_gtt_possible() all the
> typo: "attacked" --> "attached"
> 
> > way up to shadow_ppgtt_mm() to avoid unnecessary work, and to make it more
> This commit message does not match to what the patch does.
> The check in the patch is in ppgtt_populate_shadow_entry().
> 
> What you want is like below?

Yeah, I completely botched this and forgot to actually change the code.  I'll send
a replacement patch in-reply (or rather, I already sent it; I missed up again and
forgot to hit send on this one earlier in the day...).

Thanks yet again for the review!
