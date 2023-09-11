Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E4079C409
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbjILDUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbjILCaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:30:10 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BFF9030
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:53:51 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77058512c18so282980985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694483630; x=1695088430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w16s33Ihl9Edec8v32eClrQeM6o/EkNqBq369IDiij0=;
        b=AMr1qKYFAd9XeTtZmSk3tu5drW/cNWsjZD86TMqlblU3+W5M6Dyx3NfKLrDTSWhilB
         CD7Wze1JVVYoNMAtJi8d3ZoqdqU/TlNqBXxrkOJd6aYtMkuW9AryvnJWGIsJFfjXbENA
         jtLhem3NgBdWofXIAT1DkMH3ZuloCIPO8rLeabn99rXUs9j4rQDiBtPA6wp5KytuK+/7
         EpBgTfD+9r0b7ZJ3SN6JRqS/71AIa5uj9LRVVQJ/b8J0vgUWAucPAuGeMLbyUv+D1CUa
         Nd+FpQbGyI61FGJezVNMpDSc+SUWYoiyxB4KixpU/HWhOpSg6OovEXZBJz16h4xaSA52
         CRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694483630; x=1695088430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w16s33Ihl9Edec8v32eClrQeM6o/EkNqBq369IDiij0=;
        b=ceSuFyTuoyG2jr/ZRzBX4D7Gi3YskU80bLP/+N4VIDsnx3VacxZY3Ed7cgg83X+D2U
         izPPIoQHAVVEbdsFoCJ+1iqoQ/mI4U4Ibf/HLexh8Vzg7yA9/TeLBzYXIQylNky3vkIV
         2DEAEKsxz1en88dd5GoNcJq7XlmfVerF6ZdZQk1UuCDhwQp6wtEM3gkoLoIuajk6lc/E
         DpEX/5+ETswLY56Qzi5eFyKcngmWFlGmu2IMp+fjpBHU/6bMu2sy03nqatvSOTzeVJsf
         UROGuE7oejcKLiIGljV0eExICyTDdQ80dVCAgV+sYIJn2gkb2CFgmGuhv3iPTDP3X7a3
         aYSg==
X-Gm-Message-State: AOJu0YzkD0nYzASE5G2PLnMr1b7roZisM81fQOCtVaPNRi+mPd+ABzaK
        6s4K/8JbulvJOz+ZcFUvFiYJzuJnNv8yfKxiNmm7iErSF6UrHfazyGE=
X-Google-Smtp-Source: AGHT+IF3VFWmU2t6fGzRh4Vg2raGEn2I0dv7mwjtityQsXhfiZidYslEoRgJugqphqPksCLP/EWvAYBzQKe8PdqA+eI=
X-Received: by 2002:a05:620a:2483:b0:76f:24d2:e232 with SMTP id
 i3-20020a05620a248300b0076f24d2e232mr10582843qkn.47.1694475802678; Mon, 11
 Sep 2023 16:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230911061147.409152-1-mizhang@google.com> <ZP8r2CDsv3JkGYzX@google.com>
 <CAL715WKyS4sTH3yEOX2OyV+fxMLMOAV6tX-A7fvEAKEUGj8uxw@mail.gmail.com> <ZP9X7YvstWhS/pWn@google.com>
In-Reply-To: <ZP9X7YvstWhS/pWn@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 11 Sep 2023 16:42:46 -0700
Message-ID: <CAL715WJwb8RhqdvOaurUxY5=ftixw7LHZWBT9PrOGRAzF5veqA@mail.gmail.com>
Subject: Re: [PATCH] KVM: vPMU: Use atomic bit operations for global_status
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
        Jim Mattson <jmattson@google.com>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 11:09=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, Sep 11, 2023, Mingwei Zhang wrote:
> > On Mon, Sep 11, 2023 at 8:01=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Mon, Sep 11, 2023, Mingwei Zhang wrote:
> > > > Use atomic bit operations for pmu->global_status because it may suf=
fer from
> > > > race conditions between emulated overflow in KVM vPMU and PEBS over=
flow in
> > > > host PMI handler.
> > >
> > > Only if the host PMI occurs on a different pCPU, and if that can happ=
en don't we
> > > have a much larger problem?
> >
> > Why on different pCPU?  For vPMU, I think there is always contention
> > between the vCPU thread and the host PMI handler running on the same
> > pCPU, no?
>
> A non-atomic instruction can't be interrupted by an NMI, or any other eve=
nt, so
> I don't see how switching to atomic operations fixes anything unless the =
NMI comes
> in on a different pCPU.

You are right. I realize that. The race condition has to happen
concurrently from two different pCPUs. This happens to
pmu->reprogram_nmi but not pmu->global_status. The critical stuff we
care about should be re-entrancy issues for __kvm_perf_overflow() and
some state maintenance issues like avoiding duplicate NMI injection.

That concludes that we don't need this change.

Thanks
-Mingwei
