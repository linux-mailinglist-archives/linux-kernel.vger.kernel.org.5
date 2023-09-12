Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED3179D8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbjILSqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbjILSqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:46:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A0210D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:46:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59224c40275so65957377b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694544360; x=1695149160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qTWRNy0B9f+ysXrRobFDRO6uVjKtmJ5Zj+3oA+uRqFw=;
        b=SCrNki8Jh/KDjueh7CYSf8v07IBDd9cSO/+obsBUIryLQl7iWKfUYdvrOP/lP4xd12
         pUB6Q9ptoCMePKL0iBY3/KqftWHmf2MpHdnvDsGEKJwgQvlMGH0+lpOa/Xyz01zV/PIR
         rhn8WPzS6ljB3+62B7C3ZQ+Ish0RWVTcq376F5xXgAZt8TgiQRwhzalmvzjTRDa7fMJz
         TqfjDKafiSVCk6Wro+5heXmfd3NbS6aXrDYiZU5c47CdyEM+QU39EofFWnrAoUs+u2yQ
         yB2dGwwl9pz2fSygR3HGud1CQUHAv+bh5xXalmEOZq00EyvEIOc8EWW5hgQtMBrvmbDz
         zajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694544360; x=1695149160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTWRNy0B9f+ysXrRobFDRO6uVjKtmJ5Zj+3oA+uRqFw=;
        b=k8rcEhUtx51oo+0poVQqAh88xnDfl+FIF9SC7dq/ZpzDDZ2qw1bvlJSH5tJexzLIbb
         Lqlgdqhn0YPzowEqKyLSHeqi7lrPSXwQfZrN2v+YA51Spq9r9AbEgHF831NXcVxYjoIN
         RSeq1LyTe7F8nC/yn03rxxtWl5JhDbODRR6x5q4D1lx8GEGKoNEYQw2e2V+pjjZwXJV0
         9Qe+XSKvYASbHQr+elBlZI28YiL+V1PtVIGOg1WdM7C4CLroumXJolHj5z8TRExMYxWm
         JYyGKNEX8f8SmBTbGJJg6EqhCj5g4HJ/IT3CM8qH08bPh9dnVk36VqUu9S7IV7aT/9b9
         x9kQ==
X-Gm-Message-State: AOJu0Yw6BwktWVF83AnOyzeno/yrcDHDFENqNmIiEzkHx/q1jSbQHNy4
        81vdj5EKbTWxVCQZqJsQJ70in53kFnZa
X-Google-Smtp-Source: AGHT+IExxh81sJmoda00gQCx452m1kAPhvdCiEgMvshXnrLFY3W2YcbVYQ9y4uEExivicBlb6fdygWXh8dff
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a25:949:0:b0:d80:ff9:d19e with SMTP id
 u9-20020a250949000000b00d800ff9d19emr4790ybm.9.1694544360050; Tue, 12 Sep
 2023 11:46:00 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 12 Sep 2023 18:45:49 +0000
In-Reply-To: <20230912184553.1887764-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230912184553.1887764-1-mizhang@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912184553.1887764-3-mizhang@google.com>
Subject: [PATCH v4 2/6] KVM: Documentation: Update the field name gfns and its
 description in kvm_mmu_page
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>, Xu Yilun <yilun.xu@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the field 'gfns' in kvm_mmu_page to 'shadowed_translation' to be
consistent with the code. Also update the corresponding 'gfns' in the
comments. The more detailed description of 'shadowed_translation' is
already inlined in the data structure definition, so no need to duplicate
the text but simply just update the names.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
 Documentation/virt/kvm/x86/mmu.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/x86/mmu.rst b/Documentation/virt/kvm/x86/mmu.rst
index 23c20455d4e7..f659f282357d 100644
--- a/Documentation/virt/kvm/x86/mmu.rst
+++ b/Documentation/virt/kvm/x86/mmu.rst
@@ -221,11 +221,14 @@ Shadow pages contain the following information:
     at __pa(sp2->spt).  sp2 will point back at sp1 through parent_pte.
     The spt array forms a DAG structure with the shadow page as a node, and
     guest pages as leaves.
-  gfns:
-    An array of 512 guest frame numbers, one for each present pte.  Used to
-    perform a reverse map from a pte to a gfn. When role.direct is set, any
-    element of this array can be calculated from the gfn field when used, in
-    this case, the array of gfns is not allocated. See role.direct and gfn.
+  shadowed_translation:
+    An array of 512 shadow translation entries, one for each present pte. Used
+    to perform a reverse map from a pte to a gfn as well as its access
+    permission. When role.direct is set, the shadow_translation array is not
+    allocated. This is because the gfn contained in any element of this array
+    can be calculated from the gfn field when used.  In addition, when
+    role.direct is set, KVM does not track access permission for each of the
+    gfn. See role.direct and gfn.
   root_count:
     A counter keeping track of how many hardware registers (guest cr3 or
     pdptrs) are now pointing at the page.  While this counter is nonzero, the
-- 
2.42.0.283.g2d96d420d3-goog

