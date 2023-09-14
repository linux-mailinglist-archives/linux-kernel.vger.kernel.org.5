Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB3F7A0AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbjINQei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjINQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:34:36 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661861FD7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:34:32 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4179632293bso546131cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694709271; x=1695314071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XASZo9YTM/nTEYGFKuVlo/54fQU/sete5YVGxHMmtGE=;
        b=mdbvZyvMdLIvnMHhVmoG88SMm/RcUNndMKx/Tvz1ivqFfd73zAIwVmNCvVmRmIPV1K
         mjUS2+h/SQd3OUmYMN/SlRHP5rOR1DvVwGirIL7XFr6GwtbSC2u97h+EpcQZBfxZ/4g+
         wQcAlDi/TsG5mf80MV3bYIT1aa5zpPDlASBRpEn7cCRb0/GC/0RkZ41IM98BkqyxUkMl
         14tBUveULhtF0QaOd/FH/1+9tcb/QSJuAJERXIOxLgE01xjT2n7wYpjzVDG1nQflDpIm
         K6qFONMowmL8Veek8N0rpUVx2Jm/yEZNPiHlbaunLKuZebR8aEVAgDqrOHOsZdWozZew
         tiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694709271; x=1695314071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XASZo9YTM/nTEYGFKuVlo/54fQU/sete5YVGxHMmtGE=;
        b=XL1/OV8te/cvi19EByGm9cL6qEEWCTyULjstUm/XrZMAvhxGQm4KzUFyK5eNiAAQLr
         rUfBMmrqSs995iLhxxZtk62+2a/JXUp/dEn+mj55TBTrmooqDxbi4ndM7Yhq8Gntvv85
         enbv5h0jSDyNy7CS5FW9zpPmFE9X4ObCUIxCxDDR6Y8YLcY1ujkgKFFo+U59w2oZYjHO
         7zaL1HWLK5qCfg/gb+3woS8KHF22WAActo1m/hdqutiG/nnTAWsynDNzoFYjfKWLudkd
         cdNtipyhbJ1Z+2wAjZk0id0ar2rXKAUNo6GNvXIcct1wmzu2neCwjgqVmKmx6aBl3jXp
         nqIA==
X-Gm-Message-State: AOJu0YzYCkXH9m7y2iRTL3h2nXWI8leBWuEUlMMRiEIXbg/tVXT3EIBB
        /G9e+3T3euWJJD3j6Bpahp6XMuHyhbSf2FWPPeRWzw==
X-Google-Smtp-Source: AGHT+IHg7UmjBEGVkEhvOpg5Q7l9qEP6HqefOiFuxlirIIM6Mj2/H8NYbCInlRHktmnsTl9fFeuW1sLvb4zQBpyU210=
X-Received: by 2002:a05:6214:12e:b0:64f:59b8:cfd9 with SMTP id
 w14-20020a056214012e00b0064f59b8cfd9mr5860447qvs.18.1694709271421; Thu, 14
 Sep 2023 09:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230908231244.1092614-1-song@kernel.org> <CAPhsuW5Xy_K=6u4s=pNAZ8+eGBtX8v16Fr+9quL-FftEu+DWOA@mail.gmail.com>
In-Reply-To: <CAPhsuW5Xy_K=6u4s=pNAZ8+eGBtX8v16Fr+9quL-FftEu+DWOA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Sep 2023 09:34:17 -0700
Message-ID: <CAKwvOdk6FeQjbh7b5K4pps50HZa6Riw6o7huGKzYcHFk_R8MLg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/purgatory: Remove LTO flags
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        kexec@lists.infradead.org, x86@kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 9:31=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> What would be the next step for this work? We hope to back port it
> to our production kernel soon.

Please send a v3 with the fixes tag updated.  I wouldn't mind if you
added a comment to the commit message to the effect of:

We could also add the use of an explicit linker script to rejoin
.text.* sections back into .text.  Simply disable the production of
more .text.* sections for now; -flto* implies -ffunction-sections.

--=20
Thanks,
~Nick Desaulniers
