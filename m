Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C727B7716
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbjJDEYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbjJDEYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:24:33 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C893B4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 21:24:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso4826a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 21:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696393468; x=1696998268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gb48+9J6OzaJRq8+aduPuwzJE/KK9ZXSagOdlOkmQoE=;
        b=JZXGPSEepYM5LW1PaUnGslbIMZFFAl1vrmv3bx2/S+TIHQpJM2wZDnLK3EJLlmEWQw
         xU3G61T7zfaBB1CD3PQpiqYNMgtKN5ul3YayQgDa4K06KFzeZ3B5vKstAFnB3qTYIlNk
         cw9bCrUoHZ2nqJPvSYLc2A5U//44zGutN+v0mnvdCS9Unoue2FG3etwEZ8WYXB+BId6i
         vU49XQkyOePSggWanEYnS4AXgyl/foAg1wFHqfT/jo2BrT91z7xfQxDl/fWTvfgckGTc
         +EPfNxgwzv/IYnJVfRAfORD0PVyiu1yi3jch8AfvW/zoLPsFwvog3zDAMZZYeiYI6/8G
         jOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696393468; x=1696998268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gb48+9J6OzaJRq8+aduPuwzJE/KK9ZXSagOdlOkmQoE=;
        b=usiyBMweIXAzNxyB5cS/eFS1s19L+kGaEUENq0Bo3J+ONqTFzyRcQdxj8uRiEd562Q
         p8B6qa9epOBLs9aWySKDR/me5GxmFw3fHyeoikshDWfmnv6RP6zre0/Jo+/EgHfO6ATW
         nv/0Di7ox+Sove7UryIkjCt3QC47ACgqJnFI3takOopeVeDm79nplvLc93yo5ApxAsDB
         8D4pUX6qSr8dJs3yC/nDYLxVRx9UTZwHwGM1Hjwqr7QpmS8PydhZ0lIIzhiFjw8ry6Gq
         SS628Iod+YjYuAj28KAQQPemN/5G7zdUYxs63hqNjsquMrJH9UP/F68EJcwJByED6u2P
         7cNg==
X-Gm-Message-State: AOJu0YwzpiRBG9bb5YuaSP76K/ghCffcasg3+SDeBWW1ipjzBpPbRxui
        sKHBXB2o6/GeN70GiwBQ3o4NAOWnuQExcA4+odRs4g==
X-Google-Smtp-Source: AGHT+IFStvjOlkx2OAzXk89YBDYZTwvQWvQXoabu6dir1CR300tiisxAPYth1mtiFIG6xx8IO8NNzGJkZ1wsvuZRoMM=
X-Received: by 2002:a50:9fa4:0:b0:538:1d3b:172f with SMTP id
 c33-20020a509fa4000000b005381d3b172fmr43527edf.3.1696393467921; Tue, 03 Oct
 2023 21:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231004002038.907778-1-jmattson@google.com> <01009a2a-929e-ce16-6f44-1d314e6bcba5@intel.com>
 <CALMp9eR+Qudg++J_dmY_SGbM_kr=GQcRRcjuUxtm9rfaC_qeXQ@mail.gmail.com> <dfdba4e2-371c-db18-6989-541f802a0783@intel.com>
In-Reply-To: <dfdba4e2-371c-db18-6989-541f802a0783@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 3 Oct 2023 21:24:12 -0700
Message-ID: <CALMp9eRGrwYzmDxJmhNi1v-1dDgjoC0PUc-RfGiw6JVcMBnpqg@mail.gmail.com>
Subject: Re: [PATCH] x86: KVM: Add feature flag for AMD's FsGsKernelGsBaseNonSerializing
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 8:27=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 10/3/23 19:44, Jim Mattson wrote:
> > I'm a little surprised at the pushback, TBH. Are you implying that
> > there is some advantage to *not* passing this bit through?
>
> I'm not really trying to push back.  I'm honestly just curious.  Linux
> obviously doesn't cat about the bit.  So is this for some future Linux
> or some other OS?

It's not for any particular guest OS. It's just for correctness of the
virtual CPU. Pedantically, hardware that enumerates this bit cannot
run a guest that doesn't. Pragmatically, it almost certainly doesn't
matter. Getting it right is trivial and has no impact on performance
or code size, so why not just do it?
