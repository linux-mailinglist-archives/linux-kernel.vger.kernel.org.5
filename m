Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A237B85BA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbjJDQxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjJDQxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:19 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC99BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:53:14 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7b0741e0c7bso8112241.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696438394; x=1697043194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trfPvWlc2Z4z1gMaB+tLFdm/beJC1nNivy0/WxwIxQ0=;
        b=bNXQXmV0zD08F6kKmpGWVHS9LZQTmtobzoonvvPknnc+av5IWlE5IOzLD1VyE6Ajrp
         6EwbW9JZJnFkMByayCOFR9ZwgPLnfG3roV0UuuPVZrZBDogxyUTwK5+BEj3lxUrq3YjA
         GZCSwzqicVUzcLaaKGFEaDLjcTGYM3mtrTu/Sol5qdhsJ6RSgZgQnMD7cPWPC2/SMGzo
         sl4VCrb+bLBAJPdwhYxdPFP74E1PHHTxaVRx/WiSzwioXf/TZPl8D0+8hOsY9KBgj3YR
         A+AJJ6FMMYg6h3fPTPW/LapnEdQYJjOvcPb3lP277yo7YKijsAeQDU7DeDO4rVM6zUZ5
         O/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696438394; x=1697043194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trfPvWlc2Z4z1gMaB+tLFdm/beJC1nNivy0/WxwIxQ0=;
        b=k430VlPaKfeUoyI4KryG5lsQ+/05Y/5bRCVd8BNZBMsBzBf6Jo7XGbzgC4PMBhvTrq
         B3i9onhGZkQjji8dKnRF5VB2usm7NAeotR+SfryQ3a3AA4qR6pZnxYzeY4xV/ycZxO0C
         3aloXUR6BJQquTFCEWVlkv5GhAsQNdgLsBbxjbVkF+HUYVIOsSXf+bXXP/6fzYMywWDr
         w8DbCPxzGR0rW78eAdvm9FFXGR3brkHdbodFRIGgZ4+bMUk/DFUGsTgftHAwuRvFz3HX
         JFGAeCHfDBWGJshjsLEQmEPUYej1K+rxhAoDF+EE7XExzyczU0ALBZ9TZMAF8KTUvs1d
         29IQ==
X-Gm-Message-State: AOJu0YxJuWaHN+OzFKrR+lafDLuSgldIOTg+3PecZyfgtK0xtaPwwP1e
        NjUKeTJLNuPXDmTZbBb8VOMX0kLI3g5OWtSJy/NDaBFRvQKJiBwthrOR7g==
X-Google-Smtp-Source: AGHT+IEWCgvkfIvZj/B7L0SlMZXQCDSAI4lzHhqLl6NWb7K31ZFWxOCgbPKOxLXuc0v3xopPwsLqVue5HwUql+5JYvU=
X-Received: by 2002:a67:eb49:0:b0:44e:9f69:fa52 with SMTP id
 x9-20020a67eb49000000b0044e9f69fa52mr2366498vso.22.1696438393670; Wed, 04 Oct
 2023 09:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231004110905.49024-1-bjorn@kernel.org>
In-Reply-To: <20231004110905.49024-1-bjorn@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 4 Oct 2023 09:52:35 -0700
Message-ID: <CABCJKue8MW8dsrPG0PFC245jBRFx00JqcCEjzs=Os3TXwkcWFA@mail.gmail.com>
Subject: Re: [PATCH bpf 0/3] libbpf/selftests syscall wrapper fixes for RISC-V
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Bj=C3=B6rn,

On Wed, Oct 4, 2023 at 4:09=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") introduced
> some regressions in libbpf, and the kselftests BPF suite, which are
> fixed with these three patches.

This series looks good to me. Thanks for fixing the issues!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
