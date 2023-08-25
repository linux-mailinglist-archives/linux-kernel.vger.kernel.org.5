Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D057788E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHYSU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjHYSUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:20:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0663EC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:20:20 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bf703dd1c0so13113305ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692987620; x=1693592420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQn+lc9Zn9XQ9J939oDe/ZcA4NWd+xpmQ6kTnC/ITQA=;
        b=ws86JAcoda3XzSJO73gtptr9My13oPIx4loG2uk2nrWH0yQfh8pP3Mt0W2hurKkT7Q
         IcauStdfn5PQrQeCAuEQIM8Imchqal5U9z8CZthlhD961TzbImZbqgomYawc4bwJYkBG
         TFGkEiR2H53dtHyBE1+mvxk+62OZaVTncwQued3b/qYxtsPy/DtpZX3nPulhQ7HfuH4T
         yQs4++FqjC83WknrI7WaWu4apuivDC4YOacvcstDPn/NyFcBs3VKhQSUZK1gTT05068J
         Q5mDumIDx//Mj0IxZl/2yUmceN1KzWBXhR69APL+iDg8WV77/kLsLbLPbLZHgdb15m8B
         elPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692987620; x=1693592420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQn+lc9Zn9XQ9J939oDe/ZcA4NWd+xpmQ6kTnC/ITQA=;
        b=DRNswaDH1BjRmXRiCY/cfXRdOAC9aSvkb0cCw30mUOwmMYHN4FnwLY7i1ZRy9+UKQ8
         18fHJFSK/IrWVnwDRPzqBgGBLZYaPtnKOVqcCmxzwLgCjgJbNy3RPckBMcfhAH+Ybw/c
         5sV6oiShHlZoSrZZFkFN8oLjpR/b+o9pvgHYii8wFRl1j+ptDapCJ2aNe9DH/A2lnzhH
         xx65Ctbl/IrXy0yXw5uxlBxgfDv8DFXtdFcJS85tOCMCMX/ajq6UQRelw5eGQSrTkT6w
         nz0CfRdsaxaIQOT6PPvl9f1U02U8+jH81qKaU9Qm4MdrkE9KQ5udnZ/oYvm5ysS6lDTa
         qSKA==
X-Gm-Message-State: AOJu0Ywcbe9q5fYrvVrQSBmxzcCWx/LIgBoqnPU/2W4xjUnGgGc8r3XN
        Kl0elYS1/BHsZ65sbCgF/mUJ73KYfIk=
X-Google-Smtp-Source: AGHT+IHaZkT3UCDUR4FJK+7KkAqvSQP4EsmwBiNQCBQNc/ZUnLKehyozd6tfrcwQ56d65v2f7hjd0Qzf2UE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:234e:b0:1b8:80c9:a98e with SMTP id
 c14-20020a170903234e00b001b880c9a98emr6970330plh.13.1692987620459; Fri, 25
 Aug 2023 11:20:20 -0700 (PDT)
Date:   Fri, 25 Aug 2023 11:20:18 -0700
In-Reply-To: <a4ab1e7fe50096d50fde33e739ed2da40b41ea6a.1692919072.git.jpoimboe@kernel.org>
Mime-Version: 1.0
References: <cover.1692919072.git.jpoimboe@kernel.org> <a4ab1e7fe50096d50fde33e739ed2da40b41ea6a.1692919072.git.jpoimboe@kernel.org>
Message-ID: <ZOjw4uPOKltexXOp@google.com>
Subject: Re: [PATCH 05/23] KVM: x86: Add SBPB support
From:   Sean Christopherson <seanjc@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023, Josh Poimboeuf wrote:
> Add support for the AMD Selective Branch Predictor Barrier (SBPB) by
> advertising the CPUID bit and handling PRED_CMD writes accordingly.

Same as the other patch, please call out that not doing the "standard" F(SBPB)
is intentional, e.g.

  Note, like SRSO_NO and IBPB_BRTYPE before it, advertise support for SBPB
  even if it's not enumerated by in the raw CPUID.  Some CPUs that gained
  support via a uCode patch don't report SBPB via CPUID (the kernel forces
  the flag).

And again, feel free to take this through tip if this should go in 6.6.  Turns out
our Milan systems have the SBPB fun, so I was able to actually test this, including
the emulated WRMSR handling (KVM allows forcing emulation via a magic prefix).  I
have a KVM-Unit-Test patch that I'll post next week.

Thanks Josh!

Acked-by: Sean Christopherson <seanjc@google.com>

> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
