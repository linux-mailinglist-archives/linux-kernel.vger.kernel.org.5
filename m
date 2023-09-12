Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2070B79C150
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjILAsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjILAro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:47:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5804214
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:28:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fc448ee4fso54698617b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694478431; x=1695083231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4AVoaNQ85/pLQiIjn6fQJoFuF8zGeRmg0o5//coPMFY=;
        b=nw9cGkT38GjGOoZ2vEiwLSIkenAR4dGlcNX9F/bgzWC/2D5BQzbTR390bQYeyHF2z0
         CFWOLbcdk036Rrp5TcLRGUUm2+lo0p15jt5dwxChbbQ4JeC3thgYTurPra37xQ38JUF4
         CkqGUSiScUyYoYRzQc6QF9UE+bp2t3UtUIBZAgiposVh6aXHvIFMLTltjiXt9f+4aagZ
         rmHEv6mRaIDw4s7kIkNo3Q3EGZZ09xpF4cqljqZls03rWdHegTME3tLnSLB9NsUNkfGr
         QDYoexK42CIHub5dNs8zzdxTQmcnCNYFz5Bxae1vmvKb0vtn37J/ESEpErpr7Sl9kRY2
         7mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694478431; x=1695083231;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AVoaNQ85/pLQiIjn6fQJoFuF8zGeRmg0o5//coPMFY=;
        b=cmJfI+ByYGYodDEomBs8p14HGFXO6hL6RHPki4WnaxU9ax8lVgbNS8YF0eb0To4o7h
         Bqn+zLxKl+kt+vSMpfDFYVQfM02k8WJVVEQ+/ziPtbsXeD/r0p60F7Z6U9OVbQjzDmPr
         iobJsXYBWlDoevw7UDsUjslQT0j11/dzUurBn3hSgS0w0dRMdtTDox5rGIXmtzP9I/bw
         mjmafoGspne40Dt7MBbxjoVMxrjzLEu9VI4HzY5YBR7LBsuWBCysqAEdUGRHfR+7gmq7
         lm4s2T+Fp3/knj7Nr3eXrTXagxPhfTIvfkcoQP+on/729MoT4v8smQK5nCqZi+AIiM6Y
         sGYw==
X-Gm-Message-State: AOJu0YzBDZr6kUGqyTOwK+p47MuBU5piBbrit1lJrTOY9k79wf5Ow+eK
        NBf3q4GojsLLYRncPFxKgZ1edsFoUG4bX77rZ2YdQ70Brhrky8J8gOegSdE7d+UMZoRe9RD+hG/
        +DDR9CUH3P2/PkfLEVvCMLiX+ehCs81Qar5x6AoEmlMZ2xeme3zgRyNpdGwQQQNo/Kp4ZmBTc8f
        Q=
X-Google-Smtp-Source: AGHT+IGNeDlHhZxkdhxIvL4ZddAwjhhRyWRI/HSptnDGQj7xn5tiLdizgluVumpsmJKQe+MeuMvQafQWkIBlEg==
X-Received: from anticipation.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4517])
 (user=acdunlap job=sendgmr) by 2002:a05:6902:161a:b0:d74:93a1:70a2 with SMTP
 id bw26-20020a056902161a00b00d7493a170a2mr268622ybb.5.1694478431269; Mon, 11
 Sep 2023 17:27:11 -0700 (PDT)
Date:   Mon, 11 Sep 2023 17:27:01 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912002703.3924521-1-acdunlap@google.com>
Subject: [PATCH v2 0/2] x86/sev-es: Resolve early #VC handler UB
From:   Adam Dunlap <acdunlap@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Adam Dunlap <acdunlap@google.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Peter Gonda <pgonda@google.com>,
        David Rientjes <rientjes@google.com>,
        Khalid ElMously <khalid.elmously@canonical.com>,
        Jacob Xu <jacobhxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In v0 of this patch, I mistakenly claimed that
boot_cpu_data.x86_virt_bits was not getting set to 0 in some
configurations. However, it is in fact reliably being set to 0 because
it is specified to be in the .data..read_mostly section, and .data is
initialized at this point. The boot failures that we were seeing were
actually due to the gcc 12.3 compiler exploiting the undefined
behavior to return false from __is_canonical_address when
boot_cpu_data.x86_virt_bits is 0.

This patch set applies the 2 changes posted by Dave Hansen: remove the
UB by explicily checking for 0, and remove the period of time where
x86_virt_bits may be temporarily set to the wrong value where the #VC
handler could observe it.


Adam Dunlap (2):
  x86/sev-es: Allow copy_from_kernel_nofault in earlier boot
  x86/sev-es: Only set x86_virt_bits to correct value

 arch/x86/kernel/cpu/common.c | 37 +++++++++++++++++++++---------------
 arch/x86/mm/maccess.c        | 19 +++++++++++++-----
 2 files changed, 36 insertions(+), 20 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

