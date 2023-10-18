Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819807CE9E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjJRVTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjJRVTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:19:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14062114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:19:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so12310018a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697663973; x=1698268773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/FSk4NVjesoEjX9UpCsJWztXtqv48kZAgLj5F3JyN4=;
        b=MTSXEPw9v+57p3Ahu7sgz3HIP2N/WeMmsMfIZfXFJBW2ppmKIKoPnk6CqDUCVT8ET2
         08TNxpb/9sGnhrs2GFJfEAsnd70FNwK7yYPEFoICQc8mFtRYPhkkJ8jHmFk+MctwKOZy
         8ARd0yY3qsOmSIsvPbm32ur8bFofAzlI+s+PzYyYlfzP1jIEuB+XBSkKEaYuWvMtm8OR
         7VXy6l4n4dQ8Wa269FU1aSguc18aCsgtc1Y3XsHlWbtz+dqlJ86yobqAmryHA/a1f45N
         X5M/Np2l+wOX3U1f0mC6pNSw00uby7113gvBZ8MyyMVqllae85EjO5BghNsPpYwQVa8K
         2aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697663973; x=1698268773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/FSk4NVjesoEjX9UpCsJWztXtqv48kZAgLj5F3JyN4=;
        b=jOlCiSrv9LNAwBqoaqqJAJe/6reXwd3NX7UbeYil8nPiA8ljKr3KDkCDqlvPFKL1TY
         7ucmKOnXeGg8Pfz/uLh6Vnmm+xEYC2aegcMmskfrcIrpTMjCgVzuaXci1mwEX78ZCq6Q
         mmcfaS0CO+BFMCWZNe064TbJcvoeJoVVN44Mm6zmjNOrf+iVFG9ilfBFoZfMgsWHUTnJ
         FpQG9CSqeD8gP/rLyfZGM6qLpl5nKxms4gmEjYCxg2MFPNNyc2JNKqymPSQDQz+MA2G2
         35TE7G7Hzp8xy9i9gIy5ni8LysVLtB1qWzWbsoyVemb+W3kc1Tj2eCLbGi7xFlNX5j4d
         e0og==
X-Gm-Message-State: AOJu0Yz222AK9f1zRH60Ny4GK85Ep+PTMLCRBWq5NTO0dqpQ9+D3D7Nw
        loCib6nYXXub8F6b5GwSHBXnTlDbkUXxtwNf3fhCp1jkcxf/gjLcuXtxLXZd
X-Google-Smtp-Source: AGHT+IE/tItcU+QsIrMEA7yBZIbjY7HpSGFTtyiQdF8hm+Wu6Xl4hef2s7DP1tpn/ggqQKAAFjo6NKlZRLF5s0lSa5g=
X-Received: by 2002:a50:a6d5:0:b0:53e:1721:146b with SMTP id
 f21-20020a50a6d5000000b0053e1721146bmr113470edc.28.1697663973414; Wed, 18 Oct
 2023 14:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231017-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v1-1-ed5322ec8068@google.com>
 <36928c4f-3353-42c7-a42f-2bc31e1eee89@quicinc.com>
In-Reply-To: <36928c4f-3353-42c7-a42f-2bc31e1eee89@quicinc.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 18 Oct 2023 14:19:21 -0700
Message-ID: <CAFhGd8qOdS9pAT+NxgC8f-Fr13C3G0k=r_KX11XCWsjVmLzs6A@mail.gmail.com>
Subject: Re: [PATCH] wl18xx: replace deprecated strncpy with strscpy
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Tue, Oct 17, 2023 at 4:48=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> this patch (and a few others in your recent set) are missing the wifi:
> prefix. this prefix is a relatively new addition and would not show up
> in the history of some of these ancient drivers you are touching :)

Thanks for pointing this out!

I fixed it in [v2].

[v2]: https://lore.kernel.org/r/20231018-strncpy-drivers-net-wireless-ti-wl=
18xx-main-c-v2-1-ab828a491ce5@google.com

Justin
