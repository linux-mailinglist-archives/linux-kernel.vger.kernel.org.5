Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0520759807
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGSOUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGSOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:20:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54310B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:20:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ca8e5f39e09so1422588276.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689776408; x=1692368408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhEe8Ro3m3xzVle4clHGMPuyDiBtjYljaeIOHNrxaD4=;
        b=W5CztIfb2WV1OWqLAThymisnkJPQVhPq+rptaayQR88+SC3tZCZIZmDvoAzm9Rc0mr
         zT4hx1GUSD1sD7nHriR2nT+8WYZ7RQfzs61CwB0q/PMbEhe3SFBgktQsio2IgawVLhkr
         BYDmSWHJnulfQ8y8LqLZCLucqszhaZj4dHelTBP4r/9HO2L1uU5wOUOiH5/IVgelIGbW
         N228nAnoKOTr9l2EvlOOpnDIJHzBpPdiKrtJ3o6nFYbhcUXMBIE81Eb98RTXzJ+AIlgW
         5TLxT88Puoptxkgyii/kXfJ8SjYs2YpNsxVtYoegULEMlwsk198zpQZnISGnP+Gbm39y
         dCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776408; x=1692368408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhEe8Ro3m3xzVle4clHGMPuyDiBtjYljaeIOHNrxaD4=;
        b=k4OCSEY3S+0PcLy5gvKiaMu75rmVuYTmDEFaaKz6khdl/PvSkCAC3Q9dd2YEsXv7OT
         pvRX4Ts+ySl1I1FiyDIzVBjrfc1sBXBRwMvNl5+O+UBHIJgdegnV7OGoAS6IZx1jz+zx
         o3YeH7q+2MPZEcjlBN71jbT+nW7lkyO4q3lfs2KfMeMFF5fHtEBbnGPc0KZ6YDl9QvK6
         VNqdPCE5mtyGEyk61DNu/7ZZpNqfXLh1bmI+BMoNzwwhv11e+GzH5LP9dK2XFtso4rod
         Zt7j1RBScTASgKSnVBfhD7iiRQRGsXeVG3ImsZrdaf3vmk5pgtOQUxr1ab9rhD/U5D8v
         NN2w==
X-Gm-Message-State: ABy/qLYgYrQ6UOLrdN04wNrjlQZW9hgGLmIvvw1ljkznHwGbNCpT6Kuu
        dD2K/l7MewHO8szr8JAYoFMaNoOeINU=
X-Google-Smtp-Source: APBJJlF2IkKp6n6PH2OlPb2WtD4mLbCloSic8/PuahGhbvnmxuxv/ezql90pF+Be+RGqIUM1q5hZ9k9FdQc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:f509:0:b0:ca3:3341:6315 with SMTP id
 a9-20020a25f509000000b00ca333416315mr33581ybe.0.1689776408256; Wed, 19 Jul
 2023 07:20:08 -0700 (PDT)
Date:   Wed, 19 Jul 2023 07:20:06 -0700
In-Reply-To: <cover.1687991811.git.isaku.yamahata@intel.com>
Mime-Version: 1.0
References: <cover.1687991811.git.isaku.yamahata@intel.com>
Message-ID: <ZLfxFkFTotkOumRG@google.com>
Subject: Re: [RFC PATCH v3 00/11] KVM: guest memory: Misc enhacnement
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        linux-coco@lists.linux.dev,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Yuan Yao <yuan.yao@linux.intel.com>
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

On Wed, Jun 28, 2023, isaku.yamahata@intel.com wrote:
> Isaku Yamahata (8):
>   KVM: selftests: Fix test_add_overlapping_private_memory_regions()
>   KVM: selftests: Fix guest_memfd()
>   KVM: selftests: x86: typo in private_mem_conversions_test.c

Folded these fixes into the guest_memfd RFC[*].

>   KVM: Fix set_mem_attr ioctl when error case

And this one too.

>   KVM: Add new members to struct kvm_gfn_range to operate on

And also included patches that achieve this (and will also post them separately
as non-RFC, mainly to coordinate with MGLRU).

[*] https://lore.kernel.org/all/20230718234512.1690985-1-seanjc@google.com
