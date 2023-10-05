Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BFA7B999C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbjJEBam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244241AbjJEBak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:30:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E667E4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:30:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f4f2b6de8so6603827b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 18:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696469435; x=1697074235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yyTN+qkVdkyhFjuVhvjIxhpoA2iARGd0cRVG+kwHwfs=;
        b=d3DYXTDq144go9qdMLRb2WtT4bl0zJbqchDPhNnydrZCiq0YucJLqgCEpR9U3XhesC
         eRSmQHuT6TQBKM9y5fvw/TrlmYxbIgUYm7qYm9ggdRJNPtAmPvdv8u/wlKhWWqo0fM+a
         k4RCXlEygsejCIH/Uwwhw0cj1UYuYTby+K5Hnj4mpfIJky1dV2mgQi7H+VChI19Ga7lA
         3PhgwhGNba3cNuWjGDheY7SOeckWUP+NJyQEFsOrbr6ahdL5+seiTFVofyeBXeNfWuTB
         6oWqn7tPXRvkXvbelA3PYwgdrMN5UzbLAEkyec908EzqyOkySxQIlhVX478MySkWtQVw
         wnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696469435; x=1697074235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyTN+qkVdkyhFjuVhvjIxhpoA2iARGd0cRVG+kwHwfs=;
        b=Wm/5SGZLgvr91orbjYAv0T0XA2AXGWy3XyBkHi2nCbTwRjILK0ggq5+pMb/6RTIlSi
         +/QPdUoJ9HNkPxoapQ8hpoXPthKl/VLl4BKvWvWWUdKrDOWn9I/OsJEHfovgeisljuaj
         paGR9v/xoNRGcZe21Pk/MdT9MZH897YfpkHeYjCSghT0Vs+rEh1okv+TWe9ArxVtAnsw
         lcMU0L6NSndgz9pDMjWZGiZnz17YrAiFgE2jGE8ZEO1y9JyXd6Midsx81zWAkHt2oH/p
         9EEGCiOntUoEz6O4OwKG9uwdRDYj4gqeXxJT4d7aWwEUJGxl9IjM38mffdkVdDn4mO31
         Wz9g==
X-Gm-Message-State: AOJu0YyAp8fC1ep/QOR6/2zFFDLZxjqI0xgaC16OT/G0TlObgCW0PGtR
        4MliP5OcmdPeRMzn6eEC6wR7H0ifu6k=
X-Google-Smtp-Source: AGHT+IGY6yEMBX9mXtpeLecbgnz08C0zwKtPsTMIMZJZvm4kie1vwCN1GKQ2rpKWddHNl8JZvF425XPjs4w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4086:b0:5a4:f657:36d9 with SMTP id
 gb6-20020a05690c408600b005a4f65736d9mr50665ywb.9.1696469435343; Wed, 04 Oct
 2023 18:30:35 -0700 (PDT)
Date:   Wed,  4 Oct 2023 18:29:25 -0700
In-Reply-To: <cover.1692919072.git.jpoimboe@kernel.org>
Mime-Version: 1.0
References: <cover.1692919072.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <169645800680.2819931.7059133962967630371.b4-ty@google.com>
Subject: Re: [PATCH v2 00/23] SRSO fixes/cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 00:01:31 -0700, Josh Poimboeuf wrote:
> v2:
> - reorder everything: fixes/functionality before cleanups
> - split up KVM patch, add Sean's changes
> - add patch to support live migration
> - remove "default:" case for enums throughout bugs.c
> - various minor tweaks based on v1 discussions with Boris
> - add Reviewed-by's
> 
> [...]

Applied the KVM patches to kvm-x86 misc, thanks!  (I still haven't posted the
KVM-Unit-Test patches, *sigh*)

[4/23] KVM: x86: Add IBPB_BRTYPE support
       https://github.com/kvm-x86/linux/commit/6f0f23ef76be
[5/23] KVM: x86: Add SBPB support
       https://github.com/kvm-x86/linux/commit/e47d86083c66

--
https://github.com/kvm-x86/linux/tree/next
