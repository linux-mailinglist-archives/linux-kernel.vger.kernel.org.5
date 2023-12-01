Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C668017D6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441888AbjLAXga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAXg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:36:29 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C511A6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:36:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d6b751dabcso12087127b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701473795; x=1702078595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/jHCS6F3lbvEQJJqHlAwpq8uP8HzWRDFHsUBTwOKoYA=;
        b=R8W3h1wd7UWGnDg68u+W+ivoAEIXvIJkWDkf/TLNzgknfMOTw/eYxTjtju4KYwVV9e
         o1uEJQTgGDTSACoz+TD19Uv1u3XxBPXX4O+7vlmwnGRK29I37vlcqxyrw4IKq9nmrXeK
         iFgolvGCccGwjcnpa4/vlVSf235nMBJOyilo7U5J2CXEl7Usiic4y/upMCJgYgejFz2n
         IaZWX8lU6sLfOclRs+6MRju3piT5kpizbS3uptRCfgrjIf27gPnNqNt7YH2JPYYqeI6/
         3xD7lOg7dvB/XjMyU4fDya9IOZOJQhooTm2HT5N9WUJ9b1i+asNFusuGPZAkXOK4By1T
         J3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701473795; x=1702078595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jHCS6F3lbvEQJJqHlAwpq8uP8HzWRDFHsUBTwOKoYA=;
        b=DtoJwKU8cLcJeKdD15YbdaPxwjkBLqzB6h4fwSg1CG1ezHH1wHXbUTq+xcDpw8Cjgc
         YksKm0ZXQiHbTnFKFUvDkETpZ+Vxkhar6S/i0iQCgY5MTTa3Z/m2fQKAgqHqUJaRcJa0
         3eqApJCuXgNi3uPPcRWa1w9/Q1CB6qeEMs2QN8iIgjt8RemruSHUGeE5EwjEb+gqO7F6
         RH8ZkGjHqfymMWBHlDAfNqDrZd4B67lG25zqjIcmVRk3BvKjg3T/aZHq6j9cErc5corQ
         OuIusKa75tK5r8sAXNFJwoxP0LCPkrm6NkBU5lYMddZhm5KLWfHQCba3IJzO1zpJ8b//
         krOg==
X-Gm-Message-State: AOJu0YzRc0ileCoAC6QmWFc1XaNd+BYvG9TC4k3X/RihPvLjes6XLuck
        +yNTQULBlzbVdOH2d3z5wo/vQw/pcl0=
X-Google-Smtp-Source: AGHT+IGlq9gyyFjUbd1DEYgHFW0mjeWZjtYRN22TpnbSC7OjLFEQ2FItPU5EgWmocploWturhKQe3NO3jfs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3202:b0:5d7:36b4:94da with SMTP id
 ff2-20020a05690c320200b005d736b494damr3412ywb.10.1701473795112; Fri, 01 Dec
 2023 15:36:35 -0800 (PST)
Date:   Fri,  1 Dec 2023 15:30:37 -0800
In-Reply-To: <20231129224916.532431-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231129224916.532431-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170144735827.840391.573598926440531573.b4-ty@google.com>
Subject: Re: [PATCH v2 0/4] KVM: selftests: Annotate guest printfs as such
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 14:49:12 -0800, Sean Christopherson wrote:
> Fix a handful of broken guest assert/printf messages, and annotate guest
> ucall, printf, and assert helpers with __printf() so that such breakage is
> detected by the compiler.
> 
> v2:
>  - Annotate the relevant helpers. [Maxim]
>  - Fix all other warnings (v1 fixed only the MWAIT error message)
> 
> [...]

Applied rather quickly to kvm-x86 selftests, as I want to get these a few days
of exposure in -next before sending them to Paolo for 6.7-rc5.  I'll happily do
fixups if there is any feedback that needs to be addressed.  Thanks!

[1/4] KVM: selftests: Fix MWAIT error message when guest assertion fails
      https://github.com/kvm-x86/linux/commit/1af3bf2befc0
[2/4] KVM: selftests: Fix benign %llx vs. %lx issues in guest asserts
      https://github.com/kvm-x86/linux/commit/4d53dcc5d0bc
[3/4] KVM: selftests: Fix broken assert messages in Hyper-V features test
      https://github.com/kvm-x86/linux/commit/f813e6d41baf
[4/4] KVM: selftests: Annotate guest ucall, printf, and assert helpers with __printf()
      https://github.com/kvm-x86/linux/commit/1b2658e4c709

--
https://github.com/kvm-x86/linux/tree/next
