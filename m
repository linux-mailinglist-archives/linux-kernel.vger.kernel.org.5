Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF957AAD35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjIVIz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjIVIz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:55:26 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74CE8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:55:20 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-78f1210e27fso826203241.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695372919; x=1695977719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjLeoVmWga2Czo5HEnWmv6lh1/myqO9IrzlR/KySfMw=;
        b=vICeILXHenR+m4ChRibohyEpqBjbE24EQKFXxSgf6Pf2CvPuNs0ytRv8E4nwgpqMNJ
         bLNI167Mm9xG8A0hRy3nHpGV1hU8PHDIWgWc0Ec5t+dZigHEMGVSZ6BPQMFsIsPdhIo4
         TkE18b33/vFxkVnNBOYg6FHwYAIQiE2G/VThBFSqxYxVOIn3S23LIaj7uAJIY4DRNr0P
         cFBSHotcT2xMPsSLZsMragyihZ9GHaL44It9W+5Er4Ho9zN1MpP4Z1QkS/i0eW4hpO6Q
         186gH/BOtJjdqLgHro+Hdi1GpT4WZrmHc9ofSv+sC6cnZiBrtIjY9JWQBMKJJOrv9LuC
         uLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695372919; x=1695977719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjLeoVmWga2Czo5HEnWmv6lh1/myqO9IrzlR/KySfMw=;
        b=hhQH85i2fbXjycbhbNwCqzHAbHAL4ecDRKNGNsoHAhd1gYyB9MnYqUwUlfMie0j1iX
         KwMq03Ic2IBt5ix40cOGhLpjXfjapDE0XTTzqVbtztO0TMdnv7XV5HCpH2J2h8ci7cI3
         0ewQHfat6qI7+TYrHBzhc2Y0i2fALb67qa//2ykr0u/RIK70H+u92u7tuyhAW9q7+mF1
         oPrxiyg3V55h6WVjVTCQhnSB934w78BLEgZZk+kFTjVQJEasQ2iYJ+RueO2+oN8w6Vr/
         AxFkrEpxzii5mRtunc0+WhJE/U4RxWOiJpmbHK6+LNlT1lBo4NVdMEuCwJfmoV3TlwEr
         F+2A==
X-Gm-Message-State: AOJu0YyXqsSxfzUbs2K4/6Fv5dDaRc3C62zf7PAFjwdTqdogd0R3UWOf
        us2Q6GcyF5CrShwgC6mBspPRB0TtjYy2iqjtcHJe7g==
X-Google-Smtp-Source: AGHT+IHxBsOgjmUjvNUAwgBatLq3JI3ZZybm6kF6ybmwSMCK+7+qdXf1lXb/OX+D7+N66qahGHj4fyuD/t0by/dm+Xk=
X-Received: by 2002:a67:ffd2:0:b0:450:c666:fe14 with SMTP id
 w18-20020a67ffd2000000b00450c666fe14mr8133779vsq.30.1695372919337; Fri, 22
 Sep 2023 01:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230920075500.96260-1-brgl@bgdev.pl> <20230920075500.96260-2-brgl@bgdev.pl>
 <ZQr4oMx0+A3qHPVC@smile.fi.intel.com>
In-Reply-To: <ZQr4oMx0+A3qHPVC@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 22 Sep 2023 10:55:08 +0200
Message-ID: <CAMRc=MdasSJXgms0KrvNTJg2oj9ywb5ZjwpPD2s_fWWsFiyaTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] bitmap: define a cleanup function for bitmaps
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 3:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 20, 2023 at 09:54:57AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add support for autopointers for bitmaps allocated with bitmap_alloc()
> > et al.
>
> Haven't I given a tag? (Probably this is significant change...) Whatever,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Yeah, I dropped it due to the NULL-pointer check change.

Bart
