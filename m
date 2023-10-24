Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC367D56B3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbjJXPjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343730AbjJXPjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:39:37 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA4E9B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:39:35 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7b6cd2afaf2so1636538241.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698161974; x=1698766774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey4VomTRBY3avfKTyvFYcfzW8AVbvE2wkpROIGAd9Vc=;
        b=xSNHd5o0x454M+TWvM/yuR+elXo5JS/iGVrfCsc1yTygdwC36dni5va2R7/wyR7Hj9
         EUWbeCSAkWGrWDd50NWzpBaQwkz036Pdxg2TRmFVUjbNxHFTv20ndBfpT+BLXnwreLlR
         aR9pZhP8+eMxxFQP5HFpbUnNFPrMxs7veS2RwRzYpliu7wSkgzJZ9AnlcWrk3rFK7cKi
         dxxN39auBEaov9X06tJLhpzcPwNRhog1DDQUSjPLW/ijdvJHrQr5YoEbihazUmjT7BDi
         Ke8hmn88tO5uAKTsHIw/F3yDu7gdq5vLAHODhb/0clxjIjLJ0N9TR//xQM29kUM9k4dD
         nciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698161974; x=1698766774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ey4VomTRBY3avfKTyvFYcfzW8AVbvE2wkpROIGAd9Vc=;
        b=XthuARlnhz06W+e8+ev9WqCrz7drWI2Z3wb6sW0+mMZpHvQkQZ9PUIWwpuMKKD+TVu
         edkP30Rd6BYT1UFEhe1dJcU7wfn65OiVSGTtjeWhx9/EwXTXgEvpaDMGOag8jIwWqnQd
         HmwfGm/6D88HJ8yNJD08anvnv0Gm77apfS94j7Nb+6s/Ry8kNx/w3i5oWuljrZB5GgLd
         ly4MIz7EK06rJtkXJfwfV5jfCeL1cqVs9yKiLqEFhPl0ts2upE9dFyVJA5NR0YvLRO7J
         S1pi/bWavLlb95oCi+tI4CYivVdPit27D3ZsieYnVlRnl6dDdiKZ6VzfxUa8WURBa84H
         hRqQ==
X-Gm-Message-State: AOJu0YyKVET/DfpUHcMCT/sbR+JXF8yg5Bxa4lCLyVXnu3mTtts9Z3if
        6fp4B6k2K3vJkVfl0nqt5pLJ7NUQtOHmKQ3sWC+Yyg==
X-Google-Smtp-Source: AGHT+IGRHs5dvy9h28NcDmykUIafrHUuAhfRFaNAAqFctlM3EPafjqsw5rvTxrhrAeiDafc/HdNoJDjo9UT3nJy1ffE=
X-Received: by 2002:a67:e019:0:b0:457:d3fd:caaa with SMTP id
 c25-20020a67e019000000b00457d3fdcaaamr9623309vsl.8.1698161974486; Tue, 24 Oct
 2023 08:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <5fb11a4743eea9d9232a5284dea0716589088fec.1698161845.git.andreyknvl@google.com>
In-Reply-To: <5fb11a4743eea9d9232a5284dea0716589088fec.1698161845.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 24 Oct 2023 17:38:56 +0200
Message-ID: <CANpmjNOJm=PUE0N856owRnxrZx7d5cW0MqCp9Me6GrSit=NcUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation: ubsan: drop "the" from article title
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 17:37, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Drop "the" from the title of the documentation article for UBSAN,
> as it is redundant.
>
> Also add SPDX-License-Identifier for ubsan.rst.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/ubsan.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/dev-tools/ubsan.rst b/Documentation/dev-tools/ubsan.rst
> index 1be6618e232d..2de7c63415da 100644
> --- a/Documentation/dev-tools/ubsan.rst
> +++ b/Documentation/dev-tools/ubsan.rst
> @@ -1,5 +1,7 @@
> -The Undefined Behavior Sanitizer - UBSAN
> -========================================
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Undefined Behavior Sanitizer - UBSAN
> +====================================
>
>  UBSAN is a runtime undefined behaviour checker.
>
> --
> 2.25.1
>
