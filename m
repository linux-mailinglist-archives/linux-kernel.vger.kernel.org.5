Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031E0807AB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjLFVoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjLFVoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:44:00 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC4E8F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:44:07 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ce76f0748fso279633b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 13:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701899046; x=1702503846; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=emWQ//128IChCAhCT/THcHGJcWxhncZjLzE78FXSX8E=;
        b=fpedcGrXN/s/usHdY5n66hpDB178ztE+Biv+HqogR8yk7FHQhvfPAypMzjmwoH3Jeu
         RQj3AtHr6cSmIK5seDqhgno1Nld+U3e1AuQ0Nss7B9j2MgyI3YQhFgesSPTXNhGZtjA/
         Fg2KaITdLEeyAmGyRZJJ4xgRH3FYX57BljlYj58IT475aJWbNLEe2vR5cZ+TnZ8iT5H3
         ji60uCNHum81RoK9CCRUrShJmxjzqXnrA1SstKerWXkQF7lURFNXqwi8UFuNhmSo7lQG
         5bnygjrk58+gvOacllLHSWymXMsoAZMtVUFlgRsJbUF0OVcjXiC/FElWsk2ARgJdtuCN
         CJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899046; x=1702503846;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emWQ//128IChCAhCT/THcHGJcWxhncZjLzE78FXSX8E=;
        b=f0BUOaW7aeC2AuhjuFWLqo0SXKCLFdlxhtDI9x4ief8/HM9VF/pOI/+yW0AGgApoCo
         aLCm6cv4TRry7JxHvuzTkftwQffxzFdEUUeKcscq4tsL/SaTjmuiU5y1n5TZ9idt2uwH
         aPQJHyfPAGxfkg8A8alnSm/U51j27RGP86RPpYP7SEzt6NXHZf7f+cHQqSF+ti8s2xuV
         cSZ1L0GlkMzWuuC2cUBKfJaiF2x/iXgIgrG27jUDapcfkTkzmFguUW5k4ek0NKcuMVeb
         q3K3IGaRjLtior9C6gwyExvAnK+QCq8s+KEEZrhvvLErxr1UOmB9TBxa/Em8p5jzg9sY
         tdWQ==
X-Gm-Message-State: AOJu0YxgTeU7Un2LeIlRDqi3r1S8aFAj7JszRmfNXarorZxPx822Yuju
        M3eAtmAwgUtYwRuf5mzgOJuGtA==
X-Google-Smtp-Source: AGHT+IF/KxemxaFFxK+8duX7yz47wLjIg4ovMlgkotFmeA6CuhxmgEGVP9MOvenfubO04eLnbo0Zng==
X-Received: by 2002:a05:6a21:190:b0:187:f343:ab3d with SMTP id le16-20020a056a21019000b00187f343ab3dmr1422332pzb.55.1701899046588;
        Wed, 06 Dec 2023 13:44:06 -0800 (PST)
Received: from localhost ([2804:14d:7e22:803e:f0e2:3ff1:8acc:a2d5])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001c74df14e6fsm267818plb.284.2023.12.06.13.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:44:06 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-23-201c483bd775@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From:   Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 23/39] arm64/mm: Implement map_shadow_stack()
In-reply-to: <20231122-arm64-gcs-v7-23-201c483bd775@kernel.org>
Date:   Wed, 06 Dec 2023 18:44:04 -0300
Message-ID: <87a5qnhuqj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Brown <broonie@kernel.org> writes:

> Since the x86 code has not yet been rebased to v6.5-rc1 this includes
> the architecture neutral parts of Rick Edgecmbe's "x86/shstk: Introduce
> map_shadow_stack syscall".

This paragraph can be dropped now.

-- 
Thiago
