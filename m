Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6208C7E5ACB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjKHQH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:07:54 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49971FDD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:07:51 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cf717bacso94346057b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 08:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699459671; x=1700064471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKCBOihcFpwPiFXJ7beQ54mZLc6qbUkb2m18TA0L4ag=;
        b=KfWUcF8utVuoJ8rWDjFJ8/mKqxaV8Dek+UFT8n0jOJg07dChxJ5JPPapZWgEFn4D74
         VeXg4RC3Z2TXxSXNH4sM1uljFpF3SmDYYveyKrUS35I1Ud8TF9cIo/XKD2AKSOInrWke
         VY7InMsJJr9t8p9+IElrVTAI02GETGZ+gc24nZJRItHuVvqyh5uXralIrmnT6M/McER0
         C71DMimLplcZQg8YbYviLN0nlU1ioeykfmyZi65F+I0uy9oxf1NvHXs7CGpgoH+DQBAX
         p7yF1JMBIRVae7Aa4nNDD7L7Iib/pOSmseA3s3IItsyAo5qYzJkQe9wOZ5unjU+PYRGA
         XKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699459671; x=1700064471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKCBOihcFpwPiFXJ7beQ54mZLc6qbUkb2m18TA0L4ag=;
        b=BwgcHXGgz2VuMeNQGr4I8kIRu1CGnMKdnNTvO/KCZkVBApURykDZboak06Nx3ZMoWS
         TUPueDnCqKYca7rnsBjkbHh7mlD0yl7nm/aAIGfBtxtpvAW/B1JX4NLSGEffCRObX2NB
         5FRVN3Bq/XP+7jNNtr6WpdbkW/0kjwXaxuUJKmzCgNKJzuIJ9d867TejTnPbI4bnX6a6
         YAeNP6lWds7ELl/AXdWUL9Gg4H21QknQA5QCIMiQi1WE+9XzdwehfUwsypRr3Ed/hVjj
         DkkG0LdJw8VOKjhEQ+pdDuSjfryToO7514MgvLQ2NAycH4/Cvkg4JWb9LGR0Lc6IgIa9
         vhaw==
X-Gm-Message-State: AOJu0YziL7hOsXjr5ZNH8sMjH4p44QFG7B59MP9U6d0tN5Xcc0U1qOat
        mU0rVEcrJ9yl6lW0oGaSukQJsaRl0w0=
X-Google-Smtp-Source: AGHT+IG6W6qHJUtwWlgT3nZPL1H/oHRqw5KPj1osmkHyoB8gU4H4AXf99W7WzIxzrRs4vjlX4336dNFt/H8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:cad5:0:b0:59b:c6bb:bab9 with SMTP id
 m204-20020a0dcad5000000b0059bc6bbbab9mr42567ywd.3.1699459671031; Wed, 08 Nov
 2023 08:07:51 -0800 (PST)
Date:   Wed, 8 Nov 2023 08:07:49 -0800
In-Reply-To: <0ee32216-e285-406f-b20d-dd193b791d2b@intel.com>
Mime-Version: 1.0
References: <20231108010953.560824-1-seanjc@google.com> <20231108010953.560824-3-seanjc@google.com>
 <0ee32216-e285-406f-b20d-dd193b791d2b@intel.com>
Message-ID: <ZUuyVfdKZG44T1ba@google.com>
Subject: Re: [PATCH v2 2/2] KVM: selftests: Add logic to detect if ioctl()
 failed because VM was killed
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>,
        Oliver Upton <oliver.upton@linux.dev>,
        Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023, Xiaoyao Li wrote:
> On 11/8/2023 9:09 AM, Sean Christopherson wrote:
> > Add yet another macro to the VM/vCPU ioctl() framework to detect when an
> > ioctl() failed because KVM killed/bugged the VM, i.e. when there was
> > nothing wrong with the ioctl() itself.  If KVM kills a VM, e.g. by way of
> > a failed KVM_BUG_ON(), all subsequent VM and vCPU ioctl()s will fail with
> > -EIO, which can be quite misleading and ultimately waste user/developer
> > time.
> > 
> > Use KVM_CHECK_EXTENSION on KVM_CAP_USER_MEMORY to detect if the VM is
> > dead and/or bug, as KVM doesn't provide a dedicated ioctl().  Using a
> > heuristic is obviously less than ideal, but practically speaking the logic
> > is bulletproof barring a KVM change, and any such change would arguably
> > break userspace, e.g. if KVM returns something other than -EIO.
> 
> We hit similar issue when testing TDX VMs. Most failure of SEMCALL is
> handled with a KVM_BUG_ON(), which leads to vm dead. Then the following
> IOCTL from userspace (QEMU) and gets -EIO.
> 
> Can we return a new KVM_EXIT_VM_DEAD on KVM_REQ_VM_DEAD?

Why?  Even if KVM_EXIT_VM_DEAD somehow provided enough information to be useful
from an automation perspective, the VM is obviously dead.  I don't see how the
VMM can do anything but log the error and tear down the VM.  KVM_BUG_ON() comes
with a WARN, which will be far more helpful for a human debugger, e.g. because
all vCPUs would exit with KVM_EXIT_VM_DEAD, it wouldn't even identify which vCPU
initially triggered the issue.

Using an exit reason is a also bit tricky because it requires a vCPU, whereas a
dead VM blocks anything and everything.

> and replace -EIO with 0? yes, it's a ABI change.

Definitely a "no" on this one.  As has been established by the guest_memfd series,
it's ok to return -1/errno with a valid exit_reason.

> But I'm wondering if any userspace relies on -EIO behavior for VM DEAD case.

I doubt userspace relies on -EIO, but userpsace definitely relies on -1/errno being
returned when a fatal error.
