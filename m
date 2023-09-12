Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC84C79CFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjILL05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjILL0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:26:20 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A0510E7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:26:16 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7a29ef55d5fso2069205241.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694517976; x=1695122776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNmJanv/prkqq1jS6J4qAr7QRHlkbDKkqj7yolXDYiE=;
        b=I3RBQszCkv2z3kPXBdQlSDHfc/afLkFFo1S7s9AdGJXRPGTdYa6SjefVtxIG2j8oAi
         XT4xMxgJA1+6Czi/Juj2RKcnqNapReUxudq5WRY74V5dkpaDf75eYcvEYfBXeyd6QnFE
         p0ID2vspttpSFjP2XZahNLXgy7EeTUu4lc7mjBOTPNcRuXs2Ns8fJCYT0Vb/YfegRllQ
         YfzxcTJpVqJ8B6zdic54JB/zVqAlkE7zYM2dD9lymb/DpVYZpJ6ALGt7y2gFqaRRR0M3
         ty/dj1IREp64fDpAkIG1QW5tuxI/vQi6rIuOb1EVWYFURxuUyYVFVnoNYl7YM2d31SOS
         iejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694517976; x=1695122776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNmJanv/prkqq1jS6J4qAr7QRHlkbDKkqj7yolXDYiE=;
        b=oecmVF3R8nU5TdhLEkL3ZkINyZGax1/YzPfh4Y+bO68zvug/ureyrGqHtIeKb2j6y3
         VEFHMPG4XjiMjQNReYilYv0Rpfe6dc890W2X3HEC4ATnj1Md1ALhmNiQLAljuGYRetSh
         BPlOzMg5ujcxgdIldbNYS+IRxjT1HXIFFdjpHZsORIq+z9prwh7ZtKEtKMWMvx1ZaIKn
         nBg9/vr3E1cqpcl86vn9+BY1zGI8ei7PnBvVDiJQlMZJkKHIAj9Ik7xv/shQiKbdBgzI
         q+Nc6VEnMgyJjQL/z1EddLHADpPJt8Qckxh9w4Os8zCjfe7z7Quuxb6fINAeSY5D4foy
         nlDg==
X-Gm-Message-State: AOJu0YwCCM/ST3+Z4BCOq3yqQGFr7N4L0FA1c5Tk2Ltd/pBsi2u17k3c
        i54cZ20XgrURM1BFLzbXq4kxRCio1EHIoJeENLtqTIoV2U49PyOK
X-Google-Smtp-Source: AGHT+IGWHftjbkZcL3VzQlLrct/Fpc06cLfTzQ+fr2Jd2zm1XlJ6w741bN5feejluBBbvQqa12peKpGgvdRUQM6DRh8=
X-Received: by 2002:a67:ec10:0:b0:44e:e401:2854 with SMTP id
 d16-20020a67ec10000000b0044ee4012854mr9475177vso.13.1694517975881; Tue, 12
 Sep 2023 04:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230912082643.13144-1-brgl@bgdev.pl> <20230912104258.GA12405@noisy.programming.kicks-ass.net>
In-Reply-To: <20230912104258.GA12405@noisy.programming.kicks-ass.net>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 13:26:05 +0200
Message-ID: <CAMRc=McXAmOhN-vqCjz72uPB4V0Srw2czWYiSpVH7mBfBCQJpg@mail.gmail.com>
Subject: Re: [PATCH] slab: drop unneeded NULL-pointer check in kfree auto cleanup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:43=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Sep 12, 2023 at 10:26:43AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > kfree() already accepts and silently ignores NULL-pointers, there's no
> > need to check it when running the auto cleanup routine.
>
> There is, because now the compiler can't help you anymore. Also see:
>
>   https://lkml.kernel.org/r/169451499208.27769.5856056754166699857.tip-bo=
t2@tip-bot2

Makes sense, thanks!

Bart
