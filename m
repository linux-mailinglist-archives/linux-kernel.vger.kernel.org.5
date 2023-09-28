Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FFA7B22AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjI1Qnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1Qno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:43:44 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101D7195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:43:43 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c73fb50da6so3089545ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695919422; x=1696524222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7uCd0QIlhG6HfHsWPeUF6AGYijVjwnKyuv8QyMGuqQ=;
        b=ThCW+33Iz6dc/bFEHCYwa5dLhStPB0AcWLhhQDtYUAE3GKgKvVdkpxuco3OTXy36Wh
         MlB3o7rptioPwIhj31QLZJpGA+dHRvzdqA4dC1eN7VBcpbSyIgevUWjhkIjH3RxyzKtm
         8zHizt6DMcK0TfgauP/EKovkfJ+WGWO98F26cMl1N7rqsqrqHNwMCQhFUuY/VX3+nOyc
         rJpfr51XYYH5aq6MlILnDaBLZdP6xJvyFX4zfiDkHTrauYF2lWl5ydwzYHhZAbunjLTe
         96wVR7YWZTEcg8C/S9UIX0ElilolO9AzwnvA+F6Nt2fSdOvwGtum9k5wWAx7AraK4kvy
         bJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695919422; x=1696524222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7uCd0QIlhG6HfHsWPeUF6AGYijVjwnKyuv8QyMGuqQ=;
        b=qW+ZK6mRrf7qDUJ0uYJsO3Pt56m29GEqBcFW0DcYmaxvhwQ7aSzS2AP/glxgYt0shT
         W5RmjQr8a8fcy7l6++dnZUomJzfuAmCwZOoDDPxEvLmwQrSobONbnXAlqczKUkdmO4kp
         6/Uad0oE6IbmBp8SYNUUCnUrd5Xi2PI6BO7vPZucdRukcD3wk8RgTzAf1v+n14DJo2XC
         BwPAINBhYiwRG14NuJZX8Ybq1U9dpkKPXpa/65dfOsTxkmsqFDKLRp0PIiIAJxDVT0J9
         f80k2rrQjvr7QBMLuHBzsgxottFx6wcV/HsQHteaUSS2OdxdUgX8TASKPQQGQveT+iF1
         MLVg==
X-Gm-Message-State: AOJu0YzNKrWayE8ljF/stnqx0tNQ4WbUSYkciCf7yaasKdiPddw0Prse
        2sWeBkJVj2IP9UCQDVOt16geIJ0jga0=
X-Google-Smtp-Source: AGHT+IGG+Yhxa9H9ld81PDQ0vqw6YJd3AWhOE2PO70HBx+F5FJfbzhtTtOdntOMeVn9MVcswzJeNN7wdqSY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4cd:b0:1c7:217c:3e4b with SMTP id
 o13-20020a170902d4cd00b001c7217c3e4bmr25525plg.5.1695919422494; Thu, 28 Sep
 2023 09:43:42 -0700 (PDT)
Date:   Thu, 28 Sep 2023 09:43:10 -0700
In-Reply-To: <20230824215244.3897419-1-kyle.meyer@hpe.com>
Mime-Version: 1.0
References: <20230824215244.3897419-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <169591938644.1017478.16393733297254638025.b4-ty@google.com>
Subject: Re: [PATCH v3] KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, dmatlack@google.com,
        Kyle Meyer <kyle.meyer@hpe.com>
Cc:     russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com
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

On Thu, 24 Aug 2023 16:52:46 -0500, Kyle Meyer wrote:
> Add a Kconfig entry to set the maximum number of vCPUs per KVM guest and
> set the default value to 4096 when MAXSMP is enabled.

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to allow up to 4096 vCPUs
      https://github.com/kvm-x86/linux/commit/f10a570b093e

--
https://github.com/kvm-x86/linux/tree/next
