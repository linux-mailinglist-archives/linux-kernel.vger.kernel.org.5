Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3059782ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbjHUQvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbjHUQvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:51:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5093110D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6ce0c4489bso4624222276.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692636657; x=1693241457;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrXD26cwrSohEjsiyzQGHaMTNTd0Am1wC0c7gF01+5M=;
        b=kB0qhS6MTVzMjer+btbUGYGmZadhhFxqtAdWeIcW1L9Qs/K5eBHRXTBcwo3IbTFk4l
         Rbo02uv22lv3sDo4S9R1cq7/kmX/+Rn/4P1f8LPHPpFkk60gfmDU3GHO5vN9KtM159EP
         mIFPdmbtOBYX5SZaP2wYlsM9N1nPmJshwy/2DS2JnYedr6UqXTQDjYELSUKWY5Q3IlPl
         XxsmkU/NnNUsvIHz5WU6Y5L55xplKk/eg4lDRQjtJB9RVchJf+hFQrw1GITPA8XLhMXY
         b7KwH5nUaMIoZ/HPEVE1L+BtRxiSsuvbWCb9GdHT+JEt+jGtU4ArvfKCtH9jfjkGHAhF
         P7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636657; x=1693241457;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DrXD26cwrSohEjsiyzQGHaMTNTd0Am1wC0c7gF01+5M=;
        b=ffFAaCudotK94mQEggt/KgnBrywDtP+C6m7M0sAv1rCwYog4GnPu5AW1FtImsU8h7l
         RCokZjDufshW3lMN/7tukKsE7dGPBkrkGSeLmYBHdqgEF2csKS/QPX7YU/X5K+UGKvTA
         UJjmS2QRBGaVESe29PIiicfzU907Y4E70NThajTGItEr1cw+7ZAQ41mmHIpPfXTeqPgj
         FYh57mVUX5IsE7OoTdzmTVGRADgRepxvKiQRmUCxC2x2sm/XpCNCosdmZjNSF6NrW2ud
         iMm3Bu/4mjuxcxQZ3Jzfi5PAxTlltVoBZOeUXnkM6ye5ZQSJUVlHYNpgPlxep4ywmBDI
         fqiw==
X-Gm-Message-State: AOJu0Yz7p/ijRhEBJ14y4NH92RcU0i++gPN387L91UMs56wvuG3lwkPE
        G4tnJ7WzZLDA3LVurg6jhTnTH0D1L4g=
X-Google-Smtp-Source: AGHT+IGDcRVJN5xrXnJ++QrK4QSZF2m59xIJaZVD8x78pxgBrcNoXX1F+BvA04cxk6udcTuYjBDMJWYCju8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2442:0:b0:d11:6816:2d31 with SMTP id
 k63-20020a252442000000b00d1168162d31mr55337ybk.7.1692636657585; Mon, 21 Aug
 2023 09:50:57 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:50:56 +0000
In-Reply-To: <14f97819-11af-5072-d4f2-a7b4f16d734e@suse.com>
Mime-Version: 1.0
References: <cover.1692580085.git.jpoimboe@kernel.org> <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
 <45ef7bcc-d52e-3759-403b-e4b5a79a4a4f@citrix.com> <20230821162337.imzjf3golstkrrgd@treble>
 <ZOOSXc9NE1rMHDZ1@google.com> <14f97819-11af-5072-d4f2-a7b4f16d734e@suse.com>
Message-ID: <ZOOV8CoKqC/71IUW@google.com>
Subject: Re: [PATCH 03/22] KVM: x86: Support IBPB_BRTYPE and SBPB
From:   Sean Christopherson <seanjc@google.com>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023, Nikolay Borisov wrote:
>=20
> On 21.08.23 =D0=B3. 19:35 =D1=87., Sean Christopherson wrote:
> > On Mon, Aug 21, 2023, Josh Poimboeuf wrote:
> > +               if (!boot_cpu_has(X86_FEATURE_IBPB))
> > +                       reserved_bits |=3D PRED_CMD_IBPB;
> > +
> > +               if (!boot_cpu_has(X86_FEATURE_SBPB))
> > +                       reserved_bits |=3D PRED_CMD_SBPB;
> > -               if (!boot_cpu_has(X86_FEATURE_IBPB) || (data & ~PRED_CM=
D_IBPB))
> > -                       return 1;
>=20
> Surely data must be sanitized against reserved_bit before this if is
> executed?

Heh, yeah, I missed that minor detail in my quick write-up.
