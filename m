Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8261180ADFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574727AbjLHUgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjLHUgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:36:14 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FF198D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:36:20 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ca26c07848so32219717b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 12:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702067779; x=1702672579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orHiJZT0C6fy8Fk3kj9J2cROYJthdQ2Wc1XwHn5ZMq4=;
        b=3ln6m9oI3jDYCkIaLkrprMOPDZL4zJLDkHJeUd5TD8ROVnPxu6QusfweP8eUz1WUyi
         wQvVpdwjLE3YzrqKuwb3sWcVJRWaFjDupLV2U96fw1mDUCpK/d7HFfMhFDu7fTSl83eu
         n1QLUdGLK5It7eLF3CnQAfXHK138ENkZB1SyZJ4FEfFzLHhiJUDCgYd/he5K2JEc0BIH
         meA4MobzMMmZ5XmU0RACo8+mqGSlcJ0tIjYI0ws79e0/crMfwSttuwNo99Vm+ZEzOQzK
         2aiU+4SLLY8VysAsuqC8RGhr6Lc3ztkLhZO1nFwvAHfksOT1VofCKXP9Kt3u5AHyuFTI
         QQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702067779; x=1702672579;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=orHiJZT0C6fy8Fk3kj9J2cROYJthdQ2Wc1XwHn5ZMq4=;
        b=dQ26mikrjafySIG/6b8u8Hnx0SEExOaChrUu4r8YI4klQS8WwyFBr564ewuKlPbcHd
         Vq8IDIE97ASAB2x9N19lSX7pbbKtlOLJrOcn0bBzRkK6HpMDyJhjdjO/X/KxIL8GfGyL
         wND4T1OwQisSZg+WF62HldIN8y7/a8ktZseBXOXkiB0cqW0LSyGBJ8jeA+jpt+UtrFkR
         TSGAET3ws2S4P9+VUAnHguWvXDvMu5IgSMQ/r5GiS/E740BhI4GVlZmT7lLR5oqZn+HT
         3H9hJGvBsZW+0K6oqLhIAdS48OHY4Mleyl6xJCQr7VgcCwfQZakZvi9ySuyHUN/CncI2
         WePA==
X-Gm-Message-State: AOJu0YxZAZx+UBI89rN/FukpYDzxDk6ZqjVYTQg57L4qeAa16etWhb8Y
        F4UshmAl/bnXexqMeGVIELZDMm80XGE=
X-Google-Smtp-Source: AGHT+IGM36poiI66KimXwnmZMFV+cug+a/f2/aHqYZGdi3tEpQylnxIgmZTLgmZqxePMHXCOG7mBMbzoJbc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:d1e:b0:5d2:913a:6421 with SMTP id
 cn30-20020a05690c0d1e00b005d2913a6421mr5795ywb.8.1702067779340; Fri, 08 Dec
 2023 12:36:19 -0800 (PST)
Date:   Fri, 8 Dec 2023 12:36:17 -0800
In-Reply-To: <CABgObfb2AxwvseadmEBS7=VWLKKpYVeHkaecrPXG47sMfCKEZg@mail.gmail.com>
Mime-Version: 1.0
References: <20231205234956.1156210-1-michael.roth@amd.com>
 <ZXCTHJPerz6l9sPw@google.com> <CABgObfb2AxwvseadmEBS7=VWLKKpYVeHkaecrPXG47sMfCKEZg@mail.gmail.com>
Message-ID: <ZXN-QUBpq1nADjUN@google.com>
Subject: Re: [PATCH] KVM: SEV: Fix handling of EFER_LMA bit when SEV-ES is enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Dec 08, 2023, Paolo Bonzini wrote:
> On Wed, Dec 6, 2023 at 4:28=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > So my very strong preference is to first skip the kvm_is_valid_sregs() =
check
>=20
> No, please don't. If you want to add a quirk that, when disabled,
> causes all guest state get/set ioctls to fail, go ahead. But invalid
> processor state remains invalid, and should be rejected, even when KVM
> won't consume it.

Ugh, true, KVM should still reject garbage.
