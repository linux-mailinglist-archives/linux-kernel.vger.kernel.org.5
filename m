Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2800B799313
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345361AbjIIAP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345350AbjIIAPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:15:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CE11FDE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 17:15:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so21399517b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694218549; x=1694823349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gaKhly8Aj9nDlRectFKYGw3FxO6EGE4C2aH6vsrGIcs=;
        b=KKQYboSqcTfMiYuHqb6JaslyaUwLzygQtr54knTg8NFmKZzW9Nk9F02RAnx7QH76ia
         RSnP7F+UCzWFEgW1vS7n2nD/rmqu97xxXhcj5PwkUBzHhxGFYXhOM0um0yr9FX8DpsCH
         21bYQnWQAdXtwyqFTHsM9D2GXmjWt7d51G5geMz2N4THsLnsSmGJFJh325W3DOtzhQG+
         mKmymS6dV9lG4v1aHafJwZMd4+rREJjtGYyKpGi9L+IMoZ3vprp5C3XlcQHUBn1z2+j9
         MaVh85U/qkraojXJqCxJBnLJIvLcUlXYYdEsb1ph6ov4zAOxrXGLaXGELdxBclajwmko
         Lk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694218549; x=1694823349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaKhly8Aj9nDlRectFKYGw3FxO6EGE4C2aH6vsrGIcs=;
        b=tnX3I37bYrN8Mcfr/zNyr0PsttYvbnLs8nypvEx5XQfR6pNFozk2vaFNDKMruBxzYn
         UcGPMn1E3GMqKr4KXwEs4Wc88oLrWlGi9j0passQwCea4nCPboGqn8i1SDregYbknCxg
         w8l4bwYDFaUeAykRn+z2kixYs+bqWDYpPb6TzYDgt4fxNvZsSfxvjacHDoGFm17LOMwS
         C16nRrbkDvusTY4UnA8UewSWpnItx8YEL8aNK5cGhpNn55k8BDC5YAn+/jTZMyN9ZerG
         fbYr+63eQZ/j3RDGTC4StEJBgO9z3ehnleT088IfKpwqCk1tSA3EYJyAhMujE82OjhPM
         XjJg==
X-Gm-Message-State: AOJu0YznoFuPlnFQIvy0bFCxF7vCj5GYISrkHvJBLUu4s1l/SZl6lnI0
        SYrRQbi7Br8r8LHDIPapu+aJyPT3P0Y=
X-Google-Smtp-Source: AGHT+IF1C60bg2DJN40Ko3jIsOcOxP0NOjMSP0DFTt+pfC3PQMs+2qr1EtNSX5EQJ2FP9+vXkLa3AHa75+U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9848:0:b0:59b:5a5b:3a91 with SMTP id
 p69-20020a819848000000b0059b5a5b3a91mr89060ywg.2.1694218549752; Fri, 08 Sep
 2023 17:15:49 -0700 (PDT)
Date:   Fri,  8 Sep 2023 17:15:33 -0700
In-Reply-To: <20230908074222.28723-2-vbabka@suse.cz>
Mime-Version: 1.0
References: <20230908074222.28723-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <169421599820.98577.9267896589643015779.b4-ty@google.com>
Subject: Re: [PATCH gmem FIXUP v2] mm, compaction: make testing
 mapping_unmovable() safe
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     ackerleytng@google.com, akpm@linux-foundation.org,
        anup@brainfault.org, aou@eecs.berkeley.edu,
        chao.p.peng@linux.intel.com, chenhuacai@kernel.org,
        david@redhat.com, isaku.yamahata@gmail.com, jarkko@kernel.org,
        jmorris@namei.org, kirill.shutemov@linux.intel.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, liam.merwick@oracle.com,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mail@maciej.szmigiero.name,
        maz@kernel.org, michael.roth@amd.com, mpe@ellerman.id.au,
        oliver.upton@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, paul@paul-moore.com, pbonzini@redhat.com,
        qperret@google.com, serge@hallyn.com, tabba@google.com,
        vannapurve@google.com, wei.w.wang@intel.com, willy@infradead.org,
        yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Sep 2023 09:42:23 +0200, Vlastimil Babka wrote:
> As Kirill pointed out, mapping can be removed under us due to
> truncation. Test it under folio lock as already done for the async
> compaction / dirty folio case. To prevent locking every folio with
> mapping to do the test, do it only for unevictable folios, as we can
> expect the unmovable mapping folios are also unevictable. To enforce
> that expecation, make mapping_set_unmovable() also set AS_UNEVICTABLE.
> 
> [...]

Applied to kvm-x86 guest_memfd, thanks!

[1/1] mm, compaction: make testing mapping_unmovable() safe
      https://github.com/kvm-x86/linux/commit/4876a35647b9

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
