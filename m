Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E767FF46A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjK3QJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3QJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:09:23 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8910D5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:09:29 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cc08c794d6so1551497b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701360569; x=1701965369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/RtjJzL/vc29lQ75YmuaxVjA9U45zH9PPJffTuX7MJ4=;
        b=ne6OEVe2j4B15Tu7606C8/CiOnlmaXQd6TRZip/t1f8sUlzOIOR2Q1FoCEmcA5MHv2
         Nc+1LifGp0NV9K/jc27DHQ5K3VC3/h/zQ6b0qeiVEYdniBUMD/8b/9OlWrlBWLKBOmWI
         WO3U6WJlIUpueOBataf/wcxubZqcEyODevbNFrflbAR61ZBDqp9N+qNKKrzX67H9T2m1
         baEyKuoLWBNRBI19vrARgZFMX2r1RA++wIUn/rT+dndbay9kd7RYgE86skgwIQMCt4N5
         81EM2jqrcYU8mt7kbF7doVwWbIPfC2/ABQ/YpevlKaBw7PXH+Ks3ylj31PqmP1dQ3j0Y
         JYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701360569; x=1701965369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RtjJzL/vc29lQ75YmuaxVjA9U45zH9PPJffTuX7MJ4=;
        b=t10trN6aWit7+2iUnPXZTDQV/VBXXRcQd6yq49QcP5pB2v/UvV7Xu4ADXTcV9DegCG
         gUWROL3ix8RImjFxz80aauRulHzEq5SAfmyXfQjv2IgLoqNydzU937ZqBo8Q2Sfd+JUU
         Fa1A4ESSOYCMTLPdimE7dxfyPNMR1Qj4CPvXhY69t1TizQXbiRLIVVFWorVjIByVsVTY
         zdCx+H68qpnbaySpwHlQ/G67yuHJY/c88vbXeOmjfQI/wtjmIgSIr6/N8r3XLSm+Vdzs
         KRay0bmsIWmTR63MhuTUriSVQOLcffh7bYe4AFcPqVS3jTP63uv/Gixp0rHkyY5fMHhq
         7dPQ==
X-Gm-Message-State: AOJu0Yx+EwhG3tM8KzGBKFOv7SO9w/z6sjK3L59/nacgRD3esbDHclav
        Db61BJqeCYav2wxlHUAL63f8YUD/sTg=
X-Google-Smtp-Source: AGHT+IH1QROfldGFep5xZUPIQJ+BAGxcr5i8FuC775Xv7pFv/SUbUB2OCG86SlGNVua4BY9Yx2bcQTt4Yzg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:13a9:b0:6cd:acdf:5b0b with SMTP id
 t41-20020a056a0013a900b006cdacdf5b0bmr1979152pfg.6.1701360569282; Thu, 30 Nov
 2023 08:09:29 -0800 (PST)
Date:   Thu, 30 Nov 2023 08:09:27 -0800
In-Reply-To: <ebacaa61-4156-4948-a9f7-8ea7c0a49e4a@intel.com>
Mime-Version: 1.0
References: <20231108010953.560824-1-seanjc@google.com> <20231108010953.560824-3-seanjc@google.com>
 <0ee32216-e285-406f-b20d-dd193b791d2b@intel.com> <ZUuyVfdKZG44T1ba@google.com>
 <22c602c9-4943-4a16-a12e-ffc5db29daa1@intel.com> <ZWePYnuK65GCOGYU@google.com>
 <ebacaa61-4156-4948-a9f7-8ea7c0a49e4a@intel.com>
Message-ID: <ZWiztxAzjCAUw7cx@google.com>
Subject: Re: [PATCH v2 2/2] KVM: selftests: Add logic to detect if ioctl()
 failed because VM was killed
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>,
        Oliver Upton <oliver.upton@linux.dev>,
        Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023, Xiaoyao Li wrote:
> On 11/30/2023 3:22 AM, Sean Christopherson wrote:
> > On Mon, Nov 13, 2023, Xiaoyao Li wrote:
> > > On 11/9/2023 12:07 AM, Sean Christopherson wrote:
> > > > On Wed, Nov 08, 2023, Xiaoyao Li wrote:
> > > > > On 11/8/2023 9:09 AM, Sean Christopherson wrote:
> > > > > > Add yet another macro to the VM/vCPU ioctl() framework to detect when an
> > > > > > ioctl() failed because KVM killed/bugged the VM, i.e. when there was
> > > > > > nothing wrong with the ioctl() itself.  If KVM kills a VM, e.g. by way of
> > > > > > a failed KVM_BUG_ON(), all subsequent VM and vCPU ioctl()s will fail with
> > > > > > -EIO, which can be quite misleading and ultimately waste user/developer
> > > > > > time.
> > > > > > 
> > > > > > Use KVM_CHECK_EXTENSION on KVM_CAP_USER_MEMORY to detect if the VM is
> > > > > > dead and/or bug, as KVM doesn't provide a dedicated ioctl().  Using a
> > > > > > heuristic is obviously less than ideal, but practically speaking the logic
> > > > > > is bulletproof barring a KVM change, and any such change would arguably
> > > > > > break userspace, e.g. if KVM returns something other than -EIO.
> > > > > 
> > > > > We hit similar issue when testing TDX VMs. Most failure of SEMCALL is
> > > > > handled with a KVM_BUG_ON(), which leads to vm dead. Then the following
> > > > > IOCTL from userspace (QEMU) and gets -EIO.
> > > > > 
> > > > > Can we return a new KVM_EXIT_VM_DEAD on KVM_REQ_VM_DEAD?
> > > > 
> > > > Why?  Even if KVM_EXIT_VM_DEAD somehow provided enough information to be useful
> > > > from an automation perspective, the VM is obviously dead.  I don't see how the
> > > > VMM can do anything but log the error and tear down the VM.  KVM_BUG_ON() comes
> > > > with a WARN, which will be far more helpful for a human debugger, e.g. because
> > > > all vCPUs would exit with KVM_EXIT_VM_DEAD, it wouldn't even identify which vCPU
> > > > initially triggered the issue.
> > > 
> > > It's not about providing more helpful debugging info, but to provide a
> > > dedicated notification for VMM that "the VM is dead, all the following
> > > command may not response". With it, VMM can get rid of the tricky detection
> > > like this patch.
> > 
> > But a VMM doesn't need this tricky detection, because this tricky detections isn't
> > about detecting that the VM is dead, it's all about helping a human debug why a
> > test failed.
> > 
> > -EIO already effectively says "the VM is dead", e.g. QEMU isn't going to keep trying
> > to run vCPUs.
> 
> If -EIO for KVM ioctl denotes "the VM is dead" is to be the officially
> announced API, I'm fine.

Yes, -EIO is effectively ABI at this point.  Though there is the caveat that -EIO
doesn't guarantee KVM killed the VM, i.e. KVM could return -EIO for some other
reason (though that's highly unlikely for KVM_RUN at least).

> > Similarly, selftests assert either way, the goal is purely to print
> > out a unique error message to minimize the chances of confusing the human running
> > the test (or looking at results).
> > 
> > > > Definitely a "no" on this one.  As has been established by the guest_memfd series,
> > > > it's ok to return -1/errno with a valid exit_reason.
> > > > 
> > > > > But I'm wondering if any userspace relies on -EIO behavior for VM DEAD case.
> > > > 
> > > > I doubt userspace relies on -EIO, but userpsace definitely relies on -1/errno being
> > > > returned when a fatal error.
> > > 
> > > what about KVM_EXIT_SHUTDOWN? Or KVM_EXIT_INTERNAL_ERROR?
> > 
> > I don't follow,
> 
> I was trying to ask if KVM_EXIT_SHUTDOWN and KVM_EXIT_INTERNAL_ERROR are
> treated as fatal error by userspace.

Ah.  Not really.  SHUTDOWN isn't fatal per se, e.g. QEMU emulates a RESET if a
vCPU hits shutdown.  INTERNAL_ERROR isn't always fatal on x86, e.g. QEMU ignores
(I think that's what happens) emulation failure when the vCPU is at CPL > 0 so
that guest userspace can't DoS the VM.
