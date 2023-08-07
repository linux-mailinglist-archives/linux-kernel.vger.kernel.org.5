Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C60772CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjHGR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjHGR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:29:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA50E68
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:29:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40fd276621aso33501501cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429394; x=1692034194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s8Am+NuCF8QWOzKex4jmoxA1gAih8dsglrkA++VhjHo=;
        b=D1t8IqXcZ6X/6+kjvndB2rmw8GHobr/D4q0HEp1VC842sFBu6ODSwWzCepiuiLojWa
         xXhaj9kLT5em2l4hyqRaY/F63VzICNEaO3U0ZpRx8EX3D9Ue25Jv5YeuP5uuaZtlkk65
         NkcSFmHZC6OcFbhJgwQQOwyKDkZpDTWr5dQIGeHB61JUzBcjrg/npwCyTjaABiSlD4e2
         b5zmj6fqAHMgcRpGGkBVCiKX4nq4X5dKm4cme6ts//af1YG5uggXAaDc5qvzvAAGgZwQ
         m2q2NUmFQZ4CScGlT1AwbVJFdXcfejC7RpQkh4WRA/t2UDGMViMv2M+AiR0maY5QSjFQ
         Emag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429394; x=1692034194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8Am+NuCF8QWOzKex4jmoxA1gAih8dsglrkA++VhjHo=;
        b=gu+MX/PVSMT09FrkP4JCrQ6tmmDWhZbZo07l85U4npV3AGhOrVzVCslTzHzVKPaMnz
         KYgnT65p6GZAbavl51iQcdLqGzhxmKwEoiKY4MYCm+6bj0mh/XuCsn2dcQO20rzvPTRp
         +yw3j2eb4J9ohRcQ8t6apBab2Ci0uCcHqBDvYpuUwVU8ykfdSZZh8EVgHdrh97yqKu6d
         sa7+F+sf6Dqzmg4B7Tu7meELmEgBDPLb423VA3ifjS5vfx/dlrwtUEsX95ptUwwy70Ss
         udx6UBKas2Zy+jdVIdxs1ck7vdpVUEr40V9cLq2yVngrT7JiKwSF2ohdpjqQCf90h1nA
         s2kg==
X-Gm-Message-State: AOJu0YxJYrordUrZzT4HvI2FXxNOKYj8MhBO06Bn06kj2u/IrUpZRqQY
        DcpFQ/0ey8t8x8DvzZ6cwNr9JP6ZsOVujXMJJF8=
X-Google-Smtp-Source: AGHT+IE8JXAdZZ2AhJvnTVq38tCiS5y3S8Lr8F9jRzOV7FZBwOTu62PWZj5snMysoZ5yp7eyV6RFDORrEGQ2dRGrHMo=
X-Received: by 2002:ac8:5e07:0:b0:409:f273:e28d with SMTP id
 h7-20020ac85e07000000b00409f273e28dmr14321455qtx.62.1691429394504; Mon, 07
 Aug 2023 10:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com>
 <2023080743-amendable-moonlit-15b7@gregkh> <CAFqe=zJ9uRTVG=jny2PzUrrFGW2E_mZrGKF-3YMRkjzMUdu_7A@mail.gmail.com>
 <CAKwvOdm0Tv0=KGdhVwuJX+8N-Dgx+kzuPy6zCBsV1kOc+6b+qQ@mail.gmail.com>
In-Reply-To: <CAKwvOdm0Tv0=KGdhVwuJX+8N-Dgx+kzuPy6zCBsV1kOc+6b+qQ@mail.gmail.com>
From:   =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>
Date:   Mon, 7 Aug 2023 19:29:43 +0200
Message-ID: <CAFqe=zKdcOQpBFJXtjWUzET76mzsLE5Qu6jr_cRSsAeccmTEcA@mail.gmail.com>
Subject: Re: Fwd: CFI violation when reading amd_pstate/status
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM Build Support <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you tell us more about your distro? Is it public? Is it built with clang?

Hi Nick,

this is Gentoo Linux, one of the oldest source distributions. We're
also the basis for ChromeOS and various other niche distros.

Gentoo defaults to gcc and glibc, though we also support clang and
musl (and any combination thereof).
You can find our compatibility tracker here
https://bugs.gentoo.org/408963 . You can also find us on
irc.libera.chat in the #gentoo-llvm channel.

Best regards
Jannik
