Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EF37DE13D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjKAMwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjKAMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:52:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE6210C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 05:51:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so9700a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698843117; x=1699447917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5Xp3E2sNGurYgFgV4DFltI61gPnCGK2ee6FfBRryFI=;
        b=sLch8VwWZ1zSWfBadZ8y7Hj0W93EptAw+uscEv3zuRfnDoneD/GWEIwccnaJtKnxpf
         vFsn8hIS1x2CMwzQzmSDZZnmop/xOmlII+340ZCPhU/1KoclJPJ+CSMrAXE7p6DhurSt
         md6ZiVmounouybPxqU7CeYRNyM0gRKUmtx8+He/5rHhv6f27izWempfoQ0l//9da2DfF
         gHn1Wo/Xzo8J4mCy5MTm6SjY5owjbQZkJ3tVfBKY6iY010ECa+zX1NpOfb3opKfrOyE3
         U47zzgT4vNH4SseHHP85nne4/JEdnvFd2zloEHFvYnlhszAr7KFSqK7P1no+9JnoNNz7
         5Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698843117; x=1699447917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5Xp3E2sNGurYgFgV4DFltI61gPnCGK2ee6FfBRryFI=;
        b=BfMg1sWrf8vrLm4z2fyFyzB0J9MBPCgWESuiWF3OIN0Ds1ySNJ3vn2XeHd9Fp0O9Og
         yZWR0AQAk2JIXXsRXlt9HGQ9Rnx+p9sxpJIWPJfpghoUXwT8SoZC4QPsL8jZwllJGEmF
         cf53fhj/WIuFpIHDTv8EwCIYqlNTr5DHNH0LukkNmpen2hOmQJnOhJ7QxHkjSCNzpFp0
         3gUybO1F2UQ/MYivSMSxael78JEDUuxpHLpv54N9IgOtARRf1Mm9VGBWYMYTwcxusQho
         vK/5yCeA+7/wnTZ96i+GrDvQWthMG5F0g0qHIgoD8je+M+gz0GuNJbfkeSS68FXXsMuC
         Qq4w==
X-Gm-Message-State: AOJu0Yx0PIvNzGGh2GsQ966AaN1W1dLjfrqDpUY0McACU+sTNYd702f0
        7dFgvyHkBF86IRwmwUtxFOjEe9hBOxun2+2GUJFFJQ==
X-Google-Smtp-Source: AGHT+IFkCTEbSFkG7scGgC6TPzXxes69hSs6N5IfbBplDhafMoz8fYHl4lzT4ijrjOXjRvVuuGWhG1FmH8yvUfSka2I=
X-Received: by 2002:a05:6402:17da:b0:543:72e1:7f7 with SMTP id
 s26-20020a05640217da00b0054372e107f7mr210251edy.1.1698843117362; Wed, 01 Nov
 2023 05:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231031092921.2885109-1-dapeng1.mi@linux.intel.com> <20231031092921.2885109-2-dapeng1.mi@linux.intel.com>
In-Reply-To: <20231031092921.2885109-2-dapeng1.mi@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 1 Nov 2023 05:51:41 -0700
Message-ID: <CALMp9eTB-uPOnUchFsX=-JDz3Pu-OjdSksOEVQvz3htNazDhvQ@mail.gmail.com>
Subject: Re: [kvm-unit-tests Patch v2 1/5] x86: pmu: Remove duplicate code in pmu_init()
To:     Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 2:21=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> From: Xiong Zhang <xiong.y.zhang@intel.com>
>
> There are totally same code in pmu_init() helper, remove the duplicate
> code.
>
> Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
