Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1DB7DDB20
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbjKACsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345105AbjKACsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:48:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19F7C2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 19:48:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so7195a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 19:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698806886; x=1699411686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBisgJ9QGTELvVjJu1jW4LEFa5KH3eLa6pgyaizlfpI=;
        b=I7dELkTHRZI6Ft2T6W/D0rvxDBBGekrzgAHyQr2b0yQmEw9fYhi1HeYBrok/rA61pV
         VP7+4CIdQFgUDuq0XE/Uw8wftwB8EWY6VTpcKfFV52zHP3w6t0J05lZ9Hw16Zo8II4Zs
         i/8nmO4EzIErXPSICrecy5r+fO15tKrS2eWUk5cZ77FvetPRHHzFL6U7vwc5GWJqvavS
         DP416C2DDAruw9c+jTZmvlDPpPfSVZb568uEyOKcmsiK0+eK8IQ07CBurRvBhFqckaBp
         RPt9IdoQyTL1ild93s2Gf3q026CAXUnFO2g++jARNw3rdFiXqBoFOjqBL3Ez734FW2oZ
         FsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698806886; x=1699411686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBisgJ9QGTELvVjJu1jW4LEFa5KH3eLa6pgyaizlfpI=;
        b=IJp4qqn8hVW7KP2QnK3y+Aj8KWsQzF9nL6/vo0251ps0sGSO1k3mqDDuAT03fLURh3
         rorDaaVYtCZ0RgrHYeGDfGjC5870QkuM3tMF3E0Bro6xxp6mtDBAfrQ1pw968b9NKLjV
         EdnRsfEempSqSsJoY2HGz+D6e8EO+iDtPVB1DHzX1Bwgjz6qznMJAqOylzIZiS1bJYTd
         EnJ11slB16RQQvHQYvCsR9To8krrW+W7HWCduEViAhAgBkHiMtr29YR/iaSlTwwb6YPv
         9olfcVCAxIUQLYEcifbU8RiE+Ou93XEhHa9HaWBFoZkWEd7joPqN1ibxUA+6LVFKGk34
         H7kQ==
X-Gm-Message-State: AOJu0YxK/9lsN9WarvRhMiZEH9MCd5CniAi4rPrbRG8izilUYd3iI0NU
        mq81BYUiR/sNJ7uga61BbLih803MKmOf4YdXoRmbrQ==
X-Google-Smtp-Source: AGHT+IFBES0LJlTgryIhVSib3Wvc/VZriFT7FNc4avva3KWlfHL4RO1f5PaYTbdAncKIyKrpFeVFxO1RxrdLPc/rNKQ=
X-Received: by 2002:aa7:c718:0:b0:543:7345:6283 with SMTP id
 i24-20020aa7c718000000b0054373456283mr181280edq.3.1698806885966; Tue, 31 Oct
 2023 19:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231031092921.2885109-1-dapeng1.mi@linux.intel.com>
 <20231031092921.2885109-5-dapeng1.mi@linux.intel.com> <CALMp9eQ4Xj5D-kgqVMKUNmdF37rLcMRXyDYdQU339sRCKZ7d9A@mail.gmail.com>
 <28796dd3-ac4e-4a38-b9e1-f79533b2a798@linux.intel.com>
In-Reply-To: <28796dd3-ac4e-4a38-b9e1-f79533b2a798@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 31 Oct 2023 19:47:50 -0700
Message-ID: <CALMp9eRH5pttOA5BApdVeSbbkOU-kWcOWAoGMfK-9f=cy2Jf0g@mail.gmail.com>
Subject: Re: [kvm-unit-tests Patch v2 4/5] x86: pmu: Support validation for
 Intel PMU fixed counter 3
To:     "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 7:33=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 11/1/2023 2:47 AM, Jim Mattson wrote:
> > On Tue, Oct 31, 2023 at 2:22=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
> >> Intel CPUs, like Sapphire Rapids, introduces a new fixed counter
> >> (fixed counter 3) to counter/sample topdown.slots event, but current
> >> code still doesn't cover this new fixed counter.
> >>
> >> So this patch adds code to validate this new fixed counter can count
> >> slots event correctly.
> > I'm not convinced that this actually validates anything.
> >
> > Suppose, for example, that KVM used fixed counter 1 when the guest
> > asked for fixed counter 3. Wouldn't this test still pass?
>
>
> Per my understanding, as long as the KVM returns a valid count in the
> reasonable count range, we can think KVM works correctly. We don't need
> to entangle on how KVM really uses the HW, it could be impossible and
> unnecessary.

Now, I see how the Pentium FDIV bug escaped notice. Hey, the numbers
are in a reasonable range. What's everyone upset about?

> Yeah, currently the predefined valid count range may be some kind of
> loose since I want to cover as much as hardwares and avoid to cause
> regression. Especially after introducing the random jump and clflush
> instructions, the cycles and slots become much more hard to predict.
> Maybe we can have a comparable restricted count range in the initial
> change, and we can loosen the restriction then if we encounter a failure
> on some specific hardware. do you think it's better? Thanks.

I think the test is essentially useless, and should probably just be
deleted, so that it doesn't give a false sense of confidence.
