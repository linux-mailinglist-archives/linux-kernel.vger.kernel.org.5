Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B237E2749
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjKFOne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjKFOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:43:32 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C727EF3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:43:28 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afbcffe454so92733607b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 06:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699281808; x=1699886608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxhFFdGA0ojufmjeJNUhYbX6mfIrV7txvfMvwhSfBvI=;
        b=ZiU9OBxEeF3BDTeqyGOH4aUPDjpQiz1Jiqxn+UfoMjzf5xw0aDbwoUjR/UIAfwI3hW
         +9gv7hQ8VYVEl0kwTLWpVX0Idjmz8uEHRAZ9YXXXiI2I7koAKLz/ITMczlYoe3h2tuvm
         fhWP3Xm5R80YSa3Sv72nLnyaak0Jdc/V7vjnh/KVR4ZWhbDhbYTubqpVDew01Nz4rBT5
         7smsx88D/bJz+tzwhchhedPJ98s4F/SMvb2EyH3E5SD7kUzj+msO2yKT/JFTd0gSoxrP
         u71I6Ta2IUFCR3Ao7R6kunLz/hzaAozbTY99r5QdpbuPJoi8YM6Qjv+c0/UjjDsMPMCP
         vpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281808; x=1699886608;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VxhFFdGA0ojufmjeJNUhYbX6mfIrV7txvfMvwhSfBvI=;
        b=W62r3DA8R8rFCjK80pNt09huBQuZc9UKS1Qn8fGSoNOVa03uN1tlOt4KY0e9chKkQi
         OcKqGkNRBFFb+Vd9KNs3O9U7VuzR9KlPxaq1TtPHETljvBbvwmouu5dsrG+JQykUBPKn
         scUaEqJ+ylPt48OXIm94353pfHfuzPBWGamwwBDlMI++1yEgUxrPHwdlIwib+rgoJKWG
         Zay0VG4CXzlnNMEAQfhDcizzdXoN43AOdiitzRS/s2LYSpSsTA3HJFU5txyUK2NS6MsU
         aqZXX2cAIG0hbW3R14s1z/dceoB2UH8Z1ctYRczxmx4W8GfNsNS2Nlup2ZoLG+pnLtYa
         /aWg==
X-Gm-Message-State: AOJu0YyZSzs6H1BNp8pBOVwGPQFdXFX+D6J2twSXaD7rMZPv5lEBrXME
        V5R16ugboaUsf4LKXTzdkIyvflzvRKg=
X-Google-Smtp-Source: AGHT+IEeaK2OvSI6L2Xq4KzsQ2jm/Pbk5vY3mHTW2bRkFtSlTE2uRjmmAIgguun4lL3NuXFip0HnmlUhXYY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ce94:0:b0:da0:3bea:cdc7 with SMTP id
 x142-20020a25ce94000000b00da03beacdc7mr523910ybe.2.1699281807938; Mon, 06 Nov
 2023 06:43:27 -0800 (PST)
Date:   Mon, 6 Nov 2023 06:43:26 -0800
In-Reply-To: <CALMp9eSgvq1zOZ4KFnsPHQWk62AGYj560SvVops-bmtpyLGPRQ@mail.gmail.com>
Mime-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-2-seanjc@google.com>
 <CALMp9eSgvq1zOZ4KFnsPHQWk62AGYj560SvVops-bmtpyLGPRQ@mail.gmail.com>
Message-ID: <ZUj7jj-8pzvMDXDA@google.com>
Subject: Re: [PATCH v6 01/20] KVM: x86/pmu: Don't allow exposing unsupported
 architectural events
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023, Jim Mattson wrote:
> On Fri, Nov 3, 2023 at 5:02=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > Hide architectural events that unsupported according to guest CPUID *or=
*
> > hardware, i.e. don't let userspace advertise and potentially program
> > unsupported architectural events.
>=20
> The bitmask, pmu->available_event_types, is only used in
> intel_hw_event_available(). As discussed
> (https://lore.kernel.org/kvm/ZUU12-TUR_1cj47u@google.com/),
> intel_hw_event_available() should go away.

Ah drat, I completely forgot about this patch when I added the patch to rem=
ove
intel_hw_event_available().
