Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56247D00A7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346286AbjJSRe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345199AbjJSRe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:34:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C7B106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:34:22 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso13141370a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697736861; x=1698341661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrMvigYB3sGbXrzmGtkW+duvRLkjqgFO+ebJCA8YXIo=;
        b=xvmEuloFUK5vMxtbHzs2mrZRiBWtrFHkq5R4Tdr4Rf029w4U+DZvh9ZLc3EWbftwM7
         FK407yfgM4XUX0AmqgPmcqvxgqcSTdhVg35i/vXFUVNMOYnaMiDTSt8EY9bLMVZTLAke
         Z87XX1G2gxSYeqYzZaZYqA7cMo/kh2srtKYU1YNI7t0g9NcDe2w5HZLEYo5xrHmIJdOn
         M79Sfm5QQvIuovE64NvE5tA6qO7ckxrhVXNWKTCXmqoj4jJzugnqiA8CxIadBM4qdH49
         87UHJVRwzQtYWty/nZev1c9pW6IHFcDRXEvFP2ZQxY1s8MzHjdK5FEbb0TT5ri5NtrM0
         g/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736861; x=1698341661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrMvigYB3sGbXrzmGtkW+duvRLkjqgFO+ebJCA8YXIo=;
        b=PHbTPkKIaPjA7a5tJrWdg+5D+FBmaOrla3S0PtedleIsy0wpjpLKTYjLRkkxTbt9pH
         cH1+RaPQa/iCiTYz8xI1eGBW7MCbOHI+PeQMq+1IzfkG2zhLX55PoR9m5Gdm8ylmK7ag
         eLyUA1Nvf8nQA4c3h8oNR13vp2qxb5xwxq/2YBXzFlFA2NmaXPKuK0R5/wPUuDVJBusA
         wLFotthuVymoTyaYJpy546vG3nItVXLUFib4hX1fajWrL8SincXkhXzTa1OZeYBS2nxK
         NulifIktwoMO9xTo4SLPO5mgBVlPFilai4A4NXrHkL9i0DwNtY5HjHXXHLbPfZgml6U7
         DBVA==
X-Gm-Message-State: AOJu0YysqTWz8yC6nQ1GqQT/ugsjG2ZIfwjJgLBe9QJwLAOsEGuJzcW1
        Lp/CdyhZssSEWzt7M0opCf/A68y120jhHRpmI/LqFg==
X-Google-Smtp-Source: AGHT+IEXaAShkeRYMp2kuDHKws4X4gLvdPhiPGnuGhJBGTip6n1Ab0xYv3oA9sQrddtbSVhOwchiiQkFTqpYi+Oct/Y=
X-Received: by 2002:a17:907:2da9:b0:9c5:cfa3:d044 with SMTP id
 gt41-20020a1709072da900b009c5cfa3d044mr2405065ejc.19.1697736860992; Thu, 19
 Oct 2023 10:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231017232152.2605440-1-nphamcs@gmail.com> <20231019101204.179a9a1d2c7a05b604dad182@linux-foundation.org>
In-Reply-To: <20231019101204.179a9a1d2c7a05b604dad182@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 19 Oct 2023 10:33:43 -0700
Message-ID: <CAJD7tkYZ826ysjnoSbYnTH3h7eWKOE=ObHNCADb78c4x7NBHzg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] workload-specific and memory pressure-driven zswap writeback
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 10:12=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 17 Oct 2023 16:21:47 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > Subject: [PATCH v3 0/5] workload-specific and memory pressure-driven zs=
wap writeback
>
> We're at -rc6 and I'd prefer to drop this series from mm.git, have
> another go during the next cycle.
>
> However Hugh's v2 series "mempolicy: cleanups leading to NUMA mpol
> without vma" has syntactic dependencies on this series and will need
> rework, so I'd like to make that decision soon.
>
> Do we feel that this series can be made into a mergeable state within
> the next few days?

There are parts of the code that I would feel more comfortable if
someone took a look at (which I mentioned in individual patches). So
unless this happens in the next few days I wouldn't say so.

>
> Thanks.
