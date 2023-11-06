Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8BB7E28B7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjKFPbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjKFPbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:31:23 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0065C107
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:31:20 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc23f2226bso30613375ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 07:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699284680; x=1699889480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4pgWCBKNlAdji/TNyedAYk8usKNcfQXaSq+BvgKk6s=;
        b=VS2mrP9JMObCyBc3U1bEWv/lJ3A/ztpYHfW2X8kYcyH8DlefIF2Q68JIoPHsE1HWZj
         XzIetZ3Uj9A9aIk7gTGVUofPTSKOYlXfhZj2V7f1yb2bSWgRhrkSv+j/fK7AyzBH+6nP
         htCiW4OTQTAoxnoq7XGc3bNae+4kwFWvOXgAfteefJCKcAqkGMK+yH8i0tN5kHCpH+p4
         iilEXbElOIQOoAUbiEhzSLs4nKdK0ICIORxhIh+R2lUVmD5tAi7vQMcsRvKQt3QgHI2h
         H+/8i8PQ8gp9nGbXs8hZCTU8ZWVs0+7S4y6vKRNKP1vTxRQPKYSRqXXWiw/o7RvS+exH
         9PTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284680; x=1699889480;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W4pgWCBKNlAdji/TNyedAYk8usKNcfQXaSq+BvgKk6s=;
        b=tmc9aF8HCOX40fZAnh4irjG6Y4/IQrJ4dS/+R52ztxmESYWSTZY+GdOxNW3b4lDunQ
         vI5QRYemN6nEDJxpG6DXHaOXDdWBV7HvXSXDMXUmvLIR5mdtKr0EX08RBQS00hz4zU0F
         qH+nz5+230qTMraWcUw3rNs2Bq1sSjJhGGa2QoRfyrEFQQnXPozafHf2Inyfq8ExMJGK
         tqA+s9M/kHa4C8VnoeNd+WI27kQnW+Br3EXV3SibGHFXvYNbUD2bHqbKiW6tMjocm9Ky
         JFf8S7/UZ2hO5vgMLMtUPe7QMGHfqTxDT3X6oz1MjXrx4dk84wmYEifzGpbggkdKasR3
         AFEg==
X-Gm-Message-State: AOJu0Yz+dhJjYlCXw2KpNjdjEo1QfunaW0BaYNXJltI1Iep+TAERKze+
        WvuaD/1JWRFzhvxB4t5hR2USdgcd3xo=
X-Google-Smtp-Source: AGHT+IE+rwwSZOnNIm1oVLkjORXDZFsy09Wm5zk955j3nfIYxz7wPLisHgR0CkAQkaQqXTvi+0e32bs4FSs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ac8e:b0:1cc:30cf:eae6 with SMTP id
 h14-20020a170902ac8e00b001cc30cfeae6mr498273plr.10.1699284680259; Mon, 06 Nov
 2023 07:31:20 -0800 (PST)
Date:   Mon, 6 Nov 2023 07:31:18 -0800
In-Reply-To: <CALMp9eS+kNYYK_1Ufy5vc5PK25q-ny20woxbHz1onStkcfWNVw@mail.gmail.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-3-seanjc@google.com>
 <CALMp9eS+kNYYK_1Ufy5vc5PK25q-ny20woxbHz1onStkcfWNVw@mail.gmail.com>
Message-ID: <ZUkGxqX8mJPPtxHD@google.com>
Subject: Re: [PATCH v6 02/20] KVM: x86/pmu: Don't enumerate support for fixed
 counters KVM can't virtualize
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023, Jim Mattson wrote:
> On Fri, Nov 3, 2023 at 5:02=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > Hide fixed counters for which perf is incapable of creating the associa=
ted
> > architectural event.  Except for the so called pseudo-architectural eve=
nt
> > for counting TSC reference cycle, KVM virtualizes fixed counters by
> > creating a perf event for the associated general purpose architectural
> > event.  If the associated event isn't supported in hardware, KVM can't
> > actually virtualize the fixed counter because perf will likely not prog=
ram
> > up the correct event.
>=20
> Won't it? My understanding was that perf preferred to use a fixed
> counter when there was a choice of fixed or general purpose counter.
> Unless the fixed counter is already assigned to a perf_event, KVM's
> request should be satisfied by assigning the fixed counter.
>=20
> > Note, this issue is almost certainly limited to running KVM on a funky
> > virtual CPU model, no known real hardware has an asymmetric PMU where a
> > fixed counter is supported but the associated architectural event is no=
t.
>=20
> This seems like a fix looking for a problem. Has the "problem"
> actually been encountered?

Heh, yes, I "encountered" the problem in a curated VM I created.  But I com=
pletely
agree that this is unnecessary, especially since odds are very, very good t=
hat
requesting the architectural general purpose encoding will still work.  E.g=
. in
my goofy setup, the underlying hardware does support the architectural even=
t and
so even if perf doesn't use the fixed counter for whatever reason, the GP c=
ounter
will still count the right event.
