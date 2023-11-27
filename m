Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9AE7FA7DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjK0RYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjK0RYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:24:05 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3EBA5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:24:11 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-285d0ef1056so1649830a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701105851; x=1701710651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rL9LfDvcE9DBnUyEpS1p+L6oMlIKUpS9e4ZuAaaj8xo=;
        b=dDeDJeVQHlQ994p98Okkt8Fi8rO1ymAvpvZY+lNMB0xLQP3k3YRPwn9ZU9FM10XfYP
         MpWA0na4iyrnNjsT1acdT0xPP8jDcuoea7DyqVPE2BudYQTvoI4nvsdOXtnIxvyqE9m1
         fqNWvqdHvZVzjONjkZAQVCua/7BOXMe1xSrmLKgk9Ac2Vs5kx8zUcTeWZoqNhqVerl1K
         dpBkNjWJrHd8C8c+ubG39GQute/aj+q7GVgozK+sqjlEpTI17g3cIPVDJbYny4+OwWI5
         7P464B7FJqQt+9EbtT/IrxqNel4bMvdakiNUUYr6hzJ69vYfrNJu+6r1HE2cXoZGrqjJ
         VqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701105851; x=1701710651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL9LfDvcE9DBnUyEpS1p+L6oMlIKUpS9e4ZuAaaj8xo=;
        b=cmmx7/H37I3dGCGqRSk9j92g4ou/BzyvNxiiG/EUVr/5xtJ93tzHaLNAp7G8a4c4aW
         yxzTqpRd9QvN9O3u3D7PMf5TJUh3giLhz6GeW0gi53DnpbQH7IEBu+DubBJFmng8Q0fM
         tghMag65ET9G9Xc0FxUwDp9sfbOixPbaAFcXpHVt3c7Pf5pnYh+7fBwaQQv6RofjJ9k4
         NkzAEZYgBkRIqOoPOEAuHOmprA/DOZ4TRoWUVvgX3L9OSrx9XJVz5IPbHHNxBLFmj0w5
         X7ohs8+Dp1mUMg0jx9s/pLE/sPu0DFvYCCJXnMbodPuYzI97R6S0U0Q9S06jTCUitbwW
         ihkA==
X-Gm-Message-State: AOJu0YzcBYQC4r8BAfuYt3QRqCXI0dYKGTM1pRUHmSUGVTxEvcMn0RjL
        BnBLHtkQTfZT5nBcaHFRjgncVBTyQvM=
X-Google-Smtp-Source: AGHT+IECzk14EwMjjFb3/1urDD+Q4mbeNYdw2g1/0ksrRD/AQy7nqH1ycmu7b6tnBPlSMiaoFaFQgGrTeFU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:e8e:b0:285:b86b:6412 with SMTP id
 fv14-20020a17090b0e8e00b00285b86b6412mr1194032pjb.4.1701105850944; Mon, 27
 Nov 2023 09:24:10 -0800 (PST)
Date:   Mon, 27 Nov 2023 09:24:09 -0800
In-Reply-To: <c858817d3e3be246a1a2278e3b42d06284e615e5.1700766316.git.maciej.szmigiero@oracle.com>
Mime-Version: 1.0
References: <c858817d3e3be246a1a2278e3b42d06284e615e5.1700766316.git.maciej.szmigiero@oracle.com>
Message-ID: <ZWTQuRpwPkutHY-D@google.com>
Subject: Re: [PATCH] KVM: x86: Allow XSAVES on CPUs where host doesn't use it
 due to an errata
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Nov 23, 2023, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Since commit b0563468eeac ("x86/CPU/AMD: Disable XSAVES on AMD family 0x17")
> kernel unconditionally clears the XSAVES CPU feature bit on Zen1/2 CPUs.
> 
> Since KVM CPU caps are initialized from the kernel boot CPU features this
> makes the XSAVES feature also unavailable for KVM guests in this case, even
> though they might want to decide on their own whether they are affected by
> this errata.
> 
> Allow KVM guests to make such decision by setting the XSAVES KVM CPU
> capability bit based on the actual CPU capability

This is not generally safe, as the guest can make such a decision if and only if
the Family/Model/Stepping information is reasonably accurate.

> This fixes booting Hyper-V enabled Windows Server 2016 VMs with more than
> one vCPU on Zen1/2 CPUs.

How/why does lack of XSAVES break a multi-vCPU setup?  Is Windows blindly doing
XSAVES based on FMS?
