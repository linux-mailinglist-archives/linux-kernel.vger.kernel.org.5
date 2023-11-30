Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862C27FF7C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjK3QZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjK3QZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:25:35 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E99198
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:25:40 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab9cso1291590b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701361540; x=1701966340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Frsrx8QxJTCbf8WmA7nSYv8M2eurLvDkjduXU5Q/zds=;
        b=IuMVeDtU7LvGDFGw3IOZID4Rka7Bvx233updt39BqroyROkdlwpDUGraDOTY8+l4zi
         QN6XKyZxFs2MEKrBl5x8g7hBbaz4tyI+cYY3Y4JqrfgUMo+p6/U55f4noY2Sdt2VHCdN
         AcBPqgz+DdZNJB8oXwJM0Xk37PXAKGo6uGTj5g70QatRa9X1NKODW76/iekVgmUgyxDs
         zqHDOoOb37cd9+LkNM06CB1Jn38j8k02HeFq3qwu6Oov/AZYrbm2UPccFcVOS1EIANvk
         P88oE0it0w1QGrK0MZEPdklZRXu6k7ujcng97yi8BprN6FOnf+h3nBx0Z39ozkqwCgQY
         VBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361540; x=1701966340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Frsrx8QxJTCbf8WmA7nSYv8M2eurLvDkjduXU5Q/zds=;
        b=aSHmz9h0RAhbZe1JyuxlXmTVuFhCHDP78v3Fs9586V9azCKz14XQsSH4o8piXbpCrW
         EoSv5GvYjOqQwLypMPyTL33NZFXrl5welU6/zaG7uEBWAbZcW4/ghYBzOie8VQ6WTFAt
         4nJsGEiNzsUKHS14C0MH9Dr8umdxDdrC+LXn6WNh1FJI+4GBn+I11u2eYA+Ax29j9HXN
         mTtgPTIjhxMEJ/NP3x4oKevgF7SRKEK6o0h5EfayFrnXrOj+y5aXTuMpe83jWlUsz+yZ
         ielpSXnx9+b+GhcQSkZN/y9geG5azBpb6f67Bng0YYjTe4skC5C0Y0fjLGHKPVlnzdqO
         B0iQ==
X-Gm-Message-State: AOJu0YwQ0rhLc2h/lDtQXHr4rhqsyffgRqljy7/h6We+8AhZyyC5pEcN
        7sBOy7c6H4UQfwMC9sWoLTnjlhBxgUk=
X-Google-Smtp-Source: AGHT+IGu+c68aXbfWv0Zq9ytnR9R1vz5ds4Tk7HWe8PM6XpfqZSJA6l/qnKx9Z7p0qZCIRdP8IQrTYrKQ8A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:399c:b0:6c0:ec5b:bb2d with SMTP id
 fi28-20020a056a00399c00b006c0ec5bbb2dmr5386707pfb.2.1701361540551; Thu, 30
 Nov 2023 08:25:40 -0800 (PST)
Date:   Thu, 30 Nov 2023 08:25:39 -0800
In-Reply-To: <049e4892-fae8-4a1d-a069-70b0bf5ee755@gmail.com>
Mime-Version: 1.0
References: <20231007064019.17472-1-likexu@tencent.com> <e4d6c6a5030f49f44febf99ba4c7040938c3c483.camel@redhat.com>
 <53d7caba-8b00-42ab-849a-d8c8d94aea37@gmail.com> <ZTklnN2I3gYjGxVv@google.com>
 <ZTm8dH1GQ3vQtQua@google.com> <049e4892-fae8-4a1d-a069-70b0bf5ee755@gmail.com>
Message-ID: <ZWi3g6Mh9L8Lglxj@google.com>
Subject: Re: [PATCH] KVM: x86/xsave: Remove 'return void' expression for 'void function'
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023, Like Xu wrote:
> On 26/10/2023 9:10 am, Sean Christopherson wrote:
> > On Wed, Oct 25, 2023, Sean Christopherson wrote:
> > > On Wed, Oct 25, 2023, Like Xu wrote:
> > > > Emm, did we miss this little fix ?
> > > 
> > > No, I have it earmarked, it's just not a priority because it doesn't truly fix
> > > anything.  Though I suppose it probably makes to apply it for 6.8, waiting one
> > > more day to send PULL requests to Paolo isn't a problem.
> > 
> > Heh, when I tried to apply this I got reminded of why I held it for later.  I
> > want to apply it to kvm-x86/misc, but that's based on ~6.6-rc2 (plus a few KVM
> > patches), i.e. doesn't have the "buggy" commit.  I don't want to rebase "misc",
> > nor do I want to create a branch and PULL request for a single trivial commit.
> > 
> > So for logistical reasons, I'm not going apply this right away, but I will make
> > sure it gets into v6.7.
> 
> Thanks, and a similar pattern occurs with these functions:
> 
>  'write_register_operand'
>  'account_shadowed'
>  'unaccount_shadowed'
>  'mtrr_lookup_fixed_next'
>  'pre_svm_run'
>  'svm_vcpu_deliver_sipi_vector'
> 
> Although the compiler will do the right thing, use 'return void' expression
> deliberately without grounds for exemption may annoy some CI pipelines.
> 
> If you need more cleanup or a new version to cover all these cases above,
> just let me know.

I'd rather update the CI pipelines to turn off -Wpedantic.  There is zero chance
that -Wpedantic will ever get enabled for kernel builds, the kernel is deliberately
not ISO C compliant.  I have no objection to cleaning up kvm_vcpu_ioctl_x86_get_xsave()
because it's an obvious goof and a recent change, but like checkpatch warnings,
I don't want to go around "fixing" warnings unless they are actively problematic
for humans.
