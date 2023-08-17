Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3383477FF55
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355058AbjHQUyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355067AbjHQUxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:53:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4A35B7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:53:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d637af9a981so337759276.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692305613; x=1692910413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljybATuWSbqmcibWUndDogW5Y0plwtBc+lCyiblyYw4=;
        b=k8tkFeoESpIBm6Q+udwluVr3e5YqNzb/Lkr1Qw/uBsgo4VVePmhXbPYXE5MSh7m1eL
         Vrb1Cw1E6SlIsn16tG2KVPeFQe0CqZaEoWgphHnZctIvR2QqgQKM/vriZGPYHjtsKTym
         4jWvMHJurRfGauhrPSPtereJREILf9FysF9IpFaI64a1bfCzswV8k40D7igblL0BcvLJ
         eh4raNykfp9fzfCUKJF+5IBn69brzTsGJp8557u9IxfrLOaKFHINHoxtlPsQhtFRfeCP
         ha4o+H40uDv2raAxT7BxgClTuDxeScTCsP8xd20Yk60P/cDkYDASUats8lop3IEedyD4
         nubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305613; x=1692910413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljybATuWSbqmcibWUndDogW5Y0plwtBc+lCyiblyYw4=;
        b=C1YWhYgwI5snaZIl2q/er1BUouzz1oB9qMTJNKqdtMlprGfPOpHu05DsLTpxzXgT7i
         /0UnrBDbSz/gRtdSkFjKjk4WNphC+poEzqKu8Qt/64aJzem1Aqyw7tYXCqehd80dOlvr
         VeLMqIm+sS0vhW0XSsPvdkum5WGv1rfatPQHkOye2NwekZ7t4mz4SGk/BtzrugvEbMbA
         hkhJh7H9hETeN+KAi9Xj3jxkQcvuUOsU5qJ6wM7V7eoJfgx/NM7Op6ydEC+8qg5ancxV
         DvGabalNRlh4jHhJDtZLiR9XwBN/rhrz6VMMBFnAFoVEG7w9Mo27BCaOLl1v/Rw0I5GT
         5W5A==
X-Gm-Message-State: AOJu0Yx+wdvrh+xx4BHPu+qTi0j+dAClZDFhlSltd0dosJigMDTu1FKP
        xXJloj7bYgkrfOomIlfvotP5rpzVGkE=
X-Google-Smtp-Source: AGHT+IFo7906WTHrxxZj9RUs2ONt+vA5DOr/hlq8cAehDvSfNTD1SHFH/KLFzVD1jYuA/jz8SvfypUDZXg4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab54:0:b0:c6a:caf1:e601 with SMTP id
 u78-20020a25ab54000000b00c6acaf1e601mr9138ybi.13.1692305613170; Thu, 17 Aug
 2023 13:53:33 -0700 (PDT)
Date:   Thu, 17 Aug 2023 13:53:31 -0700
In-Reply-To: <20230810090945.16053-4-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230810090945.16053-1-cloudliang@tencent.com> <20230810090945.16053-4-cloudliang@tencent.com>
Message-ID: <ZN6Iy1h6wuiSDZZx@google.com>
Subject: Re: [PATCH v6 3/6] KVM: selftests: Introduce __kvm_pmu_event_filter
 to improved event filter settings
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Aug 10, 2023, Jinrong Liang wrote:
> -static int run_filter_test(struct kvm_vcpu *vcpu, const uint64_t *events,
> -			   int nevents, uint32_t flags)
> +static int do_vcpu_set_pmu_event_filter(struct kvm_vcpu *vcpu,
> +					struct __kvm_pmu_event_filter *__f)

Just "set_pmu_event_filter()" please.  The "do" is pointless, and the "vcpu" part
is confusing since the filter is per-VM, the selftest just happens to pass around
the vCPU.  And to be consistent with set_pmu_single_event_filter().

No need for a new version, I'll fixup when applying.
