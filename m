Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB13675A359
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGTAUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGTAUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:20:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D0C26BA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:19:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso120170b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689812338; x=1690417138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a2fKBNDS/BT8xGkvmwL61aPgUlEwLkJXN1Vosidytos=;
        b=nhnqQPqCsEQfk2zBKweGKXt6Cl32Y6PunHxs3U/u0Kf9PjG4qHM31zoobvLsSb2uMc
         WRa2n8gseylakBnGjXA77Dyh0glgkIYAMht7oJeSvjbIRosiJhwLPqpcXmXBi1lx2Jit
         +E8i0vJ+fFwhThGuGPt7OLVfm6J9BNfX2IwVa5AT3ykX+Nch77o3BcCYMYzQKf17yeMn
         4Ab6VrmAt5wiVwktJW+A0z7VbS0mDePAa5NnH+5bB6BCX7IZVV9zYqKLoEHfd7cBblCG
         icXCZ12el4wjMHmanyFBdxESZKKX0gCL4pzku2SfMAkmaQGujdUNRWYMw3pDev+IrG2Y
         vQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689812338; x=1690417138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2fKBNDS/BT8xGkvmwL61aPgUlEwLkJXN1Vosidytos=;
        b=VqS5MyUBxxNcUtKokru2syKOsdH7ENFfAqBMdGpzXveM+wT2zInCt4iNV5aFCP8GAQ
         A/4E9MX0uV0l58BkZyvLue5f5psuBFh4xmIH5eGuz3WB3JBrwhfeOIigyeeBwHb+842M
         Dgix3D7ZPUF2QL9u+u4JX1MGM/vt32JFrwxqH5TLuD2JW4umoSDsX+mCmindwG/AHbxt
         hLX0IcEMfonPHkCpXNfc8Bs2HThYmcdOJwNKblWzgoE5W/ljvF+Sa52Cs3e9bAapBjCt
         sxZscgY7zdhUGGUGlh/erjS/hKI4eMAzco9W47pqwCDL/EmFLsIVBl2yAYDCsCL0KIVC
         VeFw==
X-Gm-Message-State: ABy/qLYfW0wyqyJnc0IiqA4EcljgH/TB24VuKHDP0jQT+xCMHI8wtDkV
        0TPYX0/CY+gohQtQwZIuOBkR/g==
X-Google-Smtp-Source: APBJJlFQmMOLjyeCBsSqHlhl4h+9nw3quYgNKgWBuSFdNrZsRcFIHQbIBl60W2H14/GlzRWfDZ1T0A==
X-Received: by 2002:a05:6a00:2295:b0:686:2539:9ff2 with SMTP id f21-20020a056a00229500b0068625399ff2mr7643647pfe.9.1689812338252;
        Wed, 19 Jul 2023 17:18:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:2510:cdd4:99fa:ade4:1608])
        by smtp.gmail.com with ESMTPSA id fm15-20020a056a002f8f00b00666b6dc10desm3839975pfb.56.2023.07.19.17.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 17:18:57 -0700 (PDT)
Date:   Wed, 19 Jul 2023 17:18:52 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v2] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <20230720001852.GA572618@google.com>
References: <20221124094845.1907443-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124094845.1907443-1-debug@rivosinc.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepak,

On Thu, Nov 24, 2022 at 01:48:45AM -0800, Deepak Gupta wrote:
> commit 31da94c25aea ("riscv: add VMAP_STACK overflow detection") added
> support for CONFIG_VMAP_STACK. If overflow is detected, CPU switches to
> `shadow_stack` temporarily before switching finally to per-cpu
> `overflow_stack`.
> 
> If two CPUs/harts are racing and end up in over flowing kernel stack, one
> or both will end up corrupting each other state because `shadow_stack` is
> not per-cpu. This patch optimizes per-cpu overflow stack switch by
> directly picking per-cpu `overflow_stack` and gets rid of `shadow_stack`.

Are you planning on resending this patch? I see it didn't gain much
traction last time, but this looks like a much cleaner solution for
selecting the overflow stack than having a `shadow_stack` and calling
to C to compute the per-CPU offset. The asm_per_cpu macro also would
come in handy when implementing CONFIG_SHADOW_CALL_STACK, which we'd
like to have on RISC-V too.

Sami
