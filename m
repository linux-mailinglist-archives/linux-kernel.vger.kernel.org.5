Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F77E6110
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 00:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjKHXh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 18:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHXh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 18:37:28 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AA025B5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 15:37:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da04776a869so337941276.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 15:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699486645; x=1700091445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIcgmcP1EY6htEGo1pN6EVJRVE+qt/I8BKL1s/KEy5I=;
        b=YjDT3b3VA5LXmyfE5qxo4b0/zfiVxJVJeLNa3NwEIBTpx2nyLw1ZikWDHAFae/eh6Q
         qA89LqZRT7XLc837NgiEZ2ol0WfnDtajGMJD+X6zJbrA2rnbgrnLY78dxvgV2FmDLEzu
         u0nDiLzZsEHgTo2orj6d0Iu2zO5Wqonjpzy7A+Ylle05gUwsz6OVMrk8s/6EMRriEvC0
         uhW3GVwyXFcX4JO8e6PVeMUf0MJuwRCj1q1HcYeK1SWzAXE24wGtiTrq09bu1EqZAIzi
         k8YlqHi7Ige+g1TkzI9GToUx2g2Li8gC2Dn31k+9P+8XMJpGwhlHJ2YHoNzMhHoTdJea
         rT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699486645; x=1700091445;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oIcgmcP1EY6htEGo1pN6EVJRVE+qt/I8BKL1s/KEy5I=;
        b=BzANJoV+3WW2MN0oWYlqePevDzeZhpXEWlu8v95O4nc8C4y18LZs7VN7RsIIlMgW0j
         4p9TA6MHx/Rz5PvErM6yZJbYRqc6jShTVv/YvACEJu34XIIjFNBCS5R8+O7B2Nb9ZiTb
         rfl9MKfgFsCsO/0/GjZriN+IVq9drIQs1MYpfiglFtp2YtaEivPZq5ymu/zczuUs5lWs
         xtCrPCShNVtQPE5vZV3muHhLf0vyuu3pXIsD0nGwPTkrKWKng2CaZm1K+BhMAQl/bvhr
         cS2Ov59C+3aKbZq64r8IzSQqByDf+jQ3apnc7ILf1SMrwCscoc/gdCeWIOpoeCodm8PY
         caag==
X-Gm-Message-State: AOJu0Yx7BxxJlhicYb4XLOqnp2igozB3/0B5MZcmYuiL3S8Zi/0c8fb1
        45P0kWPxN7Lw+ciAyQmPtl5RQoFe+Ha/Xw==
X-Google-Smtp-Source: AGHT+IEQyf2yih5ALlCfgSEkVLSLt0Zq5IBGBmP/Cna+y8K3zSa/6bcCrG6olPCsXpdGmctjh3MSlNk2LvNOvw==
X-Received: from laogai.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2c9])
 (user=amoorthy job=sendgmr) by 2002:a05:6902:102:b0:da3:723b:b2a4 with SMTP
 id o2-20020a056902010200b00da3723bb2a4mr72222ybh.7.1699486645232; Wed, 08 Nov
 2023 15:37:25 -0800 (PST)
Date:   Wed,  8 Nov 2023 23:37:19 +0000
In-Reply-To: <CAF7b7mrGYuyjyEPAesYzZ6+KDuNAmvRxEonT7JC8NDPsSP+qDA@mail.gmail.com>
Mime-Version: 1.0
References: <CAF7b7mrGYuyjyEPAesYzZ6+KDuNAmvRxEonT7JC8NDPsSP+qDA@mail.gmail.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108233723.3380042-1-amoorthy@google.com>
Subject: Re: [PATCH 27/34] KVM: selftests: Introduce VM "shape" to allow tests
 to specify the VM type
From:   Anish Moorthy <amoorthy@google.com>
To:     amoorthy@google.com
Cc:     ackerleytng@google.com, akpm@linux-foundation.org,
        anup@brainfault.org, aou@eecs.berkeley.edu, brauner@kernel.org,
        chao.p.peng@linux.intel.com, chenhuacai@kernel.org,
        david@redhat.com, dmatlack@google.com, isaku.yamahata@gmail.com,
        isaku.yamahata@intel.com, jarkko@kernel.org,
        kirill.shutemov@linux.intel.com, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        liam.merwick@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net,
        michael.roth@amd.com, mpe@ellerman.id.au, oliver.upton@linux.dev,
        palmer@dabbelt.com, paul.walmsley@sifive.com, pbonzini@redhat.com,
        qperret@google.com, seanjc@google.com, tabba@google.com,
        vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
        wei.w.wang@intel.com, willy@infradead.org, xiaoyao.li@intel.com,
        yilun.xu@intel.com, yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 9:00=E2=80=AFAM Anish Moorthy <amoorthy@google.com> =
wrote:
>
> This commit breaks the arm64 selftests build btw: looks like a simple ove=
rsight?

Yup, fix is a one-liner. Posted below.

diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/=
testing/selftests/kvm/aarch64/page_fault_test.c
index eb4217b7c768..08a5ca5bed56 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -705,7 +705,7 @@ static void run_test(enum vm_guest_mode mode, void *arg=
)
=20
 	print_test_banner(mode, p);
=20
-	vm =3D ____vm_create(mode);
+	vm =3D ____vm_create(VM_SHAPE(mode));
 	setup_memslots(vm, p);
 	kvm_vm_elf_load(vm, program_invocation_name);
 	setup_ucall(vm);
