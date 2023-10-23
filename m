Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6A37D431F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJWXOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJWXO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:14:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07861FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:14:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a39444700so4787358276.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698102867; x=1698707667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4z50vjcy/AVIRiRa1A7triZs8e3DwANWNspQc12b2o=;
        b=diDbnbtQYvQbgRBmelnZJOOuVj/TmMeu4hxvkT2Z6zsveR8K+v4Ej5/5OtgqRt0B8T
         6An+lgU3VvvCW7OTRCJkMM0gCSMVM3Uu957zaSE7QXZGlvsYf33s4hgp7vau4Iu8uKHc
         C0WYdfFn58uV4JcVN9X1i3JGI7WOdp7Rd0BXo01mv6x2b8wqIn4iURvfYxgzAvY/PEU1
         HtX8hBTB/ZCVugwMavmHGkYUwV5DrtzpriaX0wLl8M5FRM21xnrbTAMdh/40cc/rFcdz
         nC+D94q8gMcrJGiQoG9P81e2bXEmwF1l9qkE2sr0d4IS34pf8N4Vh0T54T8ok7apxunE
         7ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698102867; x=1698707667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4z50vjcy/AVIRiRa1A7triZs8e3DwANWNspQc12b2o=;
        b=BuLWvhw4j9yU0oSw68oM+eWte8ApPM/xJ6akug+gOwaOkG6kQFE4rwKdycXsf2UbRD
         +VQnxh0k/4jzcMXwlKSipd6spbEn0LMuqHt34GshBk/3l73nIuiNlH+k2WC7bSI51HJz
         xGNnnu82Vez6yu+dqD7coMm+NIk0EV/oURXoccPYiTqadq7xyE95SYHjIpAt8rix89qz
         ZNKMNswpLGGVdmJ8G9cFttGbg/9TmYgC7Ex0I/tzl3l2T/t8J29GwQz7fAoDqLoW0IzD
         E4XdIdPUmJ3PW9zA3HKDXvBE1cvNTVBTWlH82aVX/2wWZFwmmCmTo510JsKYHQ+5MoZ9
         Vvsw==
X-Gm-Message-State: AOJu0YxixGF3/+vMgS42kjS9Oi+IxC9Lvg+tgpKER0b0DdWX+XH+Clgt
        KirHbOcz2L+6K2lcPp9vUFfZLrKNuZ0=
X-Google-Smtp-Source: AGHT+IHkMFj4kxDJUf60dyKoH+kC2G8zlRJAkjUr1kpTT6iYxmji/FBt4cPJOfuMeEfkMIUPTpii3qixX2o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:34d1:0:b0:d9a:6360:485b with SMTP id
 b200-20020a2534d1000000b00d9a6360485bmr320353yba.2.1698102867294; Mon, 23 Oct
 2023 16:14:27 -0700 (PDT)
Date:   Mon, 23 Oct 2023 16:14:25 -0700
In-Reply-To: <20230913124227.12574-9-binbin.wu@linux.intel.com>
Mime-Version: 1.0
References: <20230913124227.12574-1-binbin.wu@linux.intel.com> <20230913124227.12574-9-binbin.wu@linux.intel.com>
Message-ID: <ZTb-UbBrMkmvyFMg@google.com>
Subject: Re: [PATCH v11 08/16] KVM: x86: Introduce get_untagged_addr() in
 kvm_x86_ops and call it in emulator
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        David.Laight@aculab.com, robert.hu@linux.intel.com,
        guang.zeng@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, Binbin Wu wrote:
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index e3054e3e46d5..179931b73876 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -134,6 +134,7 @@ KVM_X86_OP(msr_filter_changed)
>  KVM_X86_OP(complete_emulated_msr)
>  KVM_X86_OP(vcpu_deliver_sipi_vector)
>  KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
> +KVM_X86_OP(get_untagged_addr)

This needs to be KVM_X86_OP_OPTIONAL(), otherwise kvm_ops_update() will complain
about SVM not implementing the hook.  Hooray for useful warns! (I missed this in
review).
