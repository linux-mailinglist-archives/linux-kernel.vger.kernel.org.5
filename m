Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3BF7CEB8F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjJRXCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJRXC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:02:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19375118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:02:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b44befac59so156613b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697670146; x=1698274946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaVR9Cc080ZMyhxNmnpSMr32p+CTXK3yu4RzCaSLriE=;
        b=1LtBqgO23+s4K0S4TTIf5hM9cVPprJ11PwXVLFcpS5ib3kAU6c/3ViW7s7c/NgyxYl
         yMvZTpL/ne7Xhe3RHY+/H6bB943trE/7ddPJUlvfoOa7oWJrztc61Zuo7/256yW1P1CA
         L6fWGB4bXb8Cbn8dANBgKXe7LcMOUphOUHNs9kkWZKv780v2Pikf6c5juOJXwFAUmi3M
         HgGOmVBPm/SQtwNmiw0x+BLLwQI4Bmr0KDcT2qusG/28RMgnlgLgZgy/vGG/zwEzzibj
         fR1j+rx4sRHl+LzWMLVmxDVrHnlKclHRvQAE3bbOuTWJolW1/nNgaYIBXh75kMeWM9+w
         CKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670146; x=1698274946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaVR9Cc080ZMyhxNmnpSMr32p+CTXK3yu4RzCaSLriE=;
        b=DS34h+5O2j2eEuJWVNGxUvT0gQF09thOAN/sB28dNtQfWPEnr9lBNKshQ4FiMO8Hka
         HwurOP3rgRs47++YUX/ZOU2KEQYYs44hnTmAqzYvMRKCj3xGYa9bmWe6GaTO/MGAZhiV
         tLLaU8x7Gar/EM10SBo0qcsJotRk/cLAsHKpO6wTaIewB+68wZ05J0eqxcUfYyhRcP3C
         bQOt1MMWcyv+ueV9LTwV/fEuzdhFrA9fRhwKkpzDsCVh3FrsAbjvlHM7GRIEbDaWagre
         x70lg0gdlNRrR4eWdyQpX3GWJ7MxSp/LyCFRInTI/PlvZHFqfXLf+CD5ZREhc4WTzLXo
         TIww==
X-Gm-Message-State: AOJu0YxkuqB+/P9Bn62HLVG2BiN/rVDuF2IK90z7ynyG/AZcdik8Vl9A
        Poclu9Ky68tAuNzhIxj/aB0Vr9xmGMK76fG6QMQQhY50gnsVJqtRLDYCug==
X-Google-Smtp-Source: AGHT+IEVfAPxbRIJBLB3C85Ktsz1YYCoFtUoT5iKkkTfVO6EAXsPNhq+IbKFs3oohLOcAVgNKMT563qUvPWPvQ4OgxY=
X-Received: by 2002:a05:6a20:7d81:b0:15d:b407:b0a0 with SMTP id
 v1-20020a056a207d8100b0015db407b0a0mr329581pzj.26.1697670146342; Wed, 18 Oct
 2023 16:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <87r0lry3bs.fsf@jcompost-mobl.amr.corp.intel.com>
In-Reply-To: <87r0lry3bs.fsf@jcompost-mobl.amr.corp.intel.com>
From:   Adam Dunlap <acdunlap@google.com>
Date:   Wed, 18 Oct 2023 16:02:13 -0700
Message-ID: <CAMBK9=ZAzKyxuxdsDXNeA8xyPufwFoMxJaHwuh-z+eOmrGD1qQ@mail.gmail.com>
Subject: Re: Reserved bits and commit x86/sev-es: Set x86_virt_bits to the
 correct value straight away, instead of a two-phase approach
To:     "Compostella, Jeremy" <jeremy.compostella@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, kirill.shutemov@linux.intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Felix Held <felix-coreboot@felixheld.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 3:27=E2=80=AFPM Compostella, Jeremy
<jeremy.compostella@intel.com> wrote:
> In the light of commit fbf6449f84bf I am wondering what is the right
> approach to fix the regression for AMD and then fix the MTRR check for
> Intel. Should we introduce a new cpu_dev callback to read the number
> of reserved bits and take it into account in get_cpu_address_sizes() ?

I think this approach makes sense. It seems better to have one
function that simply sets it to the right thing rather than setting it
to one value and then adjusting it (fbf6449f84bf did that for
x86_virt_bits, although it caused some other problems). However, I'm
not sure it would solve the problem your original patch tried to fix,
since x86_phys_bits would still be set after intel_init, which
apparently uses the value. Would it work to move the call to
get_cpu_address_sizes() to nearer the start of early_identify_cpu()?
We could also add a cpu_dev callback so it doesn't need the 2-phase
approach, but this would at least bring it back into parity with
v6.6-rc6.

Ex (untested):

---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bcd3b2df83bb..cdbe8241e250 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1592,6 +1592,8 @@ static void __init early_identify_cpu(struct
cpuinfo_x86 *c)
  if (!have_cpuid_p())
  identify_cpu_without_cpuid(c);

+ get_cpu_address_sizes(c);
+
  /* cyrix could have cpuid enabled via c_identify()*/
  if (have_cpuid_p()) {
  cpu_detect(c);
@@ -1612,8 +1614,6 @@ static void __init early_identify_cpu(struct
cpuinfo_x86 *c)
  setup_clear_cpu_cap(X86_FEATURE_CPUID);
  }

- get_cpu_address_sizes(c);
-
  setup_force_cpu_cap(X86_FEATURE_ALWAYS);

  cpu_set_bug_bits(c);
--=20

Thanks for finding this problem!
Adam
