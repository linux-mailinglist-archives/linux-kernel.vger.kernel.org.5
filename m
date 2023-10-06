Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8397C7BB03F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 04:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjJFCVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 22:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJFCVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 22:21:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B9ADE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 19:21:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8153284d6eso2356115276.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 19:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696558903; x=1697163703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YA+Cq8KKd5SLVssX1l4RlCcP9aKEvDTuHwUHfnMy3sQ=;
        b=Z+L4E3oUhFAGSLgAywc0kpzZzAgpzgvZMI4XgpBJxtGUnyKLGO7UWCEbB0mkbmips/
         0qElMp2EAZ5e7E0U7nE/yZLpN1MOCiwZ/bSygH9HleqIr1+yeuGYd0WDq0WU2fIQ/KL5
         ssQwhMeWQwQTyruEbcLI+haJ2ZIe/mYcKuMLmbkvoD+RLnufyyLMV/N0/W6cZMdjVzo2
         U+UNEe28hvG6yxrO4OwYJWEPtSOFgfgvoadCsrIEXZqXElfCCndmQOdE2cpm2T+7+NcC
         3OQeLjEhioAqTNGNliX6v6yLHuNPyJNgdlXsqM7VhQ7GnMjqVMO+aulKNZXKQ47Ha5ou
         NGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696558903; x=1697163703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YA+Cq8KKd5SLVssX1l4RlCcP9aKEvDTuHwUHfnMy3sQ=;
        b=Bqn0yAEijIQRHGsdRs04eVkyHvtC2+2JS04sLm2KDj0/1oU3OBsn9vNX17KPHm2D+r
         +GZIa0xi6ysFdiPnVvUAQL0uaz89Y1OwmQpJuLb3dDYxTZjTaPK+adgbL204hn0Eruzs
         9dzBi2vLg8XklQIVErowiCgLmttrn/ecN2nqvVWXxtntuPNPHUYhCzVSNsSNOz0begLR
         ySgFRquo2pAfbgrCL9m3uF7ruGxCWjzAQ3O+9r1EcQML1KbE0X/TkUgcWI5+u/b4gr7R
         rBFVomY4lRwt3c6mqXJLHjcIIJTpTWnzI5nz4XdvJukubdnUP8dnNH/L+jFqi6tetRPn
         8ftw==
X-Gm-Message-State: AOJu0YxvPzhxjE6mEw1PK8XzA01PcVtIkOBfrfHjSSpjwY/BKjvTufe6
        bnlSJ0rR3EIv890Qs5Kl4FBcz0OQwo0=
X-Google-Smtp-Source: AGHT+IEmt68AoxtPnWuyaCCn+Zj/+0mc6WtKkThbxJBKMz7krdJA8UcNiwqpDXmY1FKyQxnWztdJZhkmuPw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8a0d:0:b0:d81:7617:a397 with SMTP id
 g13-20020a258a0d000000b00d817617a397mr114628ybl.9.1696558903249; Thu, 05 Oct
 2023 19:21:43 -0700 (PDT)
Date:   Thu,  5 Oct 2023 19:20:07 -0700
In-Reply-To: <20231002133230.195738-1-michael.roth@amd.com>
Mime-Version: 1.0
References: <20231002133230.195738-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <169655697465.3534024.7746001565902273346.b4-ty@google.com>
Subject: Re: [PATCH gmem FIXUP] KVM: Don't re-use inodes when creating
 guest_memfd files
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Michael Roth <michael.roth@amd.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
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

On Mon, 02 Oct 2023 08:32:30 -0500, Michael Roth wrote:
> anon_inode_getfile() uses a singleton inode, which results in the inode
> size changing based with each new KVM_CREATE_GUEST_MEMFD call, which
> can later lead to previously-created guest_memfd files failing bounds
> checks that are later performed when memslots are bound to them. More
> generally, the inode may be associated with other state that cannot be
> shared across multiple guest_memfd instances.
> 
> [...]

Applied to kvm-x86 guest_memfd, thanks!  I added a comment to explain the use
of the "secure" API, there's a non-zero chance we'll forget that wrinkle again
in the future.

[1/1] KVM: Don't re-use inodes when creating guest_memfd files
      https://github.com/kvm-x86/linux/commit/b3bf68b66062

--
https://github.com/kvm-x86/linux/tree/next
