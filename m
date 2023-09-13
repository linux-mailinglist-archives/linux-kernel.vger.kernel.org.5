Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875CF79EFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjIMRJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjIMRIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:08:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A62680
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:08:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27405bafa2eso45502a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694624904; x=1695229704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ihId+82HD26SjvNufvLy8at2aoRO48c9rDf8oEccLw=;
        b=NH+35ieV5I21W1NWcBjrpFrIPZiI/Rrp5wRiFL2nSAFhyJppHGLkkHVMKjamdHep/3
         Re0Y0MUyqUwuMfPp01jFfDriRjLQrfo9kV7TAY+uwNMxNdCzxrtYb3qDij5MdXu/dTKD
         FFrROH3NXo86y5uZoMXr8k8c+AQ7ltbtgdO1CYn8qPdIe0IPLtJjAjc5mTgtXAIxZEyz
         jioRIg7aXfif00FSqgyEYzb3KLGz4QL7u2s0j89/H+CfUWOytr4Z+O8idlUjL2zWfQ3u
         y7j3xyNjJSlvFmAPoSTZN8AVziuJ6i1ognTWP8WAxZcLlgaR5CkQWdSvTngSf2tmv5c/
         kQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624904; x=1695229704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ihId+82HD26SjvNufvLy8at2aoRO48c9rDf8oEccLw=;
        b=w0S9fjCDZ2mo3/A29CaYm7uhXWM8RGXipCak0H/DIWeppyIbAMwoCYBuk/EiZIK8ak
         nduOfA/PwNXxR+97V6aUFzulIBYscVy9Th7PZigG56hRVwvm9/JgA3vcAV9rf0gzgQui
         fuJF42fhBhSq4ICo3vkuidheIgCGUy8goRyLCpOHO+JepMXi8prIsBV8KbFWZxrWeaxx
         qKcuy80pBDXB+G2+Iy35uw4SU+s2UFRMAOUJF83yTFrfWuoqY1PMsbSVAqlVvfpdozGd
         i7ypOCPssWx8gYhekD097zvIumfpLf9G4PtWfCpMP7RYpKDcMNw0YrOLC8tnJNL8Yvo8
         ZjDQ==
X-Gm-Message-State: AOJu0Yxe0rITuAacEoK1Q0RYZnavmIzs1oNoBXfHlX7mrL+G1Eti4gSS
        IIJEGJpakaCm9HWcXokc2W2sogwhuJR0EVApkT0=
X-Google-Smtp-Source: AGHT+IHgiQ8z5tN0ALwsvGlsUSCEXYg0ZH0auo5wSXDXFlo7mzqgdWX5va8aVRhWMLnkBf8b6BXXgxzoyfzz+TMcHIQ=
X-Received: by 2002:a17:90b:357:b0:269:2682:11fb with SMTP id
 fh23-20020a17090b035700b00269268211fbmr2891842pjb.8.1694624903831; Wed, 13
 Sep 2023 10:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <f7ab7ad4013669f25808bb0e39b3613b98189063.1693328501.git.andreyknvl@google.com>
 <ZO8OACjoGtRuy1Rm@elver.google.com> <CA+fCnZcAuipLKDiNY6LJAs6ODaOG9i6goVLQSdbALrzUDsnv5w@mail.gmail.com>
 <CANpmjNPVu10Y+gO=r3eaU9GP8VL_dqmch3QQXYX8g9D-+HjVPg@mail.gmail.com>
In-Reply-To: <CANpmjNPVu10Y+gO=r3eaU9GP8VL_dqmch3QQXYX8g9D-+HjVPg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 13 Sep 2023 19:08:12 +0200
Message-ID: <CA+fCnZdempKJg13K5HsRyB9oeR0AKeYVkUg487dR510m_avqDQ@mail.gmail.com>
Subject: Re: [PATCH 15/15] kasan: use stack_depot_evict for tag-based modes
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023 at 8:59=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> >
> > Hm, I actually suspect we don't need these READ/WRITE_ONCE to entry
> > fields at all. This seems to be a leftover from the initial series
> > when I didn't yet have the rwlock. The rwlock prevents the entries
> > from being read (in kasan_complete_mode_report_info) while being
> > written and the try_cmpxchg prevents the same entry from being
> > rewritten (in the unlikely case of wrapping during writing).
> >
> > Marco, do you think we can drop these READ/WRITE_ONCE?
>
> Yes, I think they can be dropped.

Will drop in v2, thanks!
