Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B8580AC9B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574636AbjLHTDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjLHTDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:03:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C3711F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:03:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbc5f7781faso515109276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 11:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702062236; x=1702667036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnnp0/fnEWWka5ENVyb9xgW39qrerb88jdwgH/GIHYw=;
        b=VIwpJ3h6+AHyJaY6ZfkgXDZvBOgLMvMjpoybM6nMxH0QyAcnKqSy7Vwv1Vk5PsknmN
         ABr+jnmkOFCnpXKeyoyk6d/PknY/A6CYYeZP9jKX+VJlF9cxOM2hsochXmZYz5cYAnwG
         jy/UIFUsnImC/vqPMiBOpXDgV9C1TU6klIl7DDhtX7iGiEHsVRoHBI3tVb9N/IqUoATt
         gwMZO92ZtE+KQ3O+45MtX1vCGvCn+AjsWaJzi8+OwHig7egbK3wXId0PhlLc9eALun6C
         XWLUxdPf2daWNtYirF26H7hsejx8oJ4X5PjReoOeM8snYXnsH5IrTKgGxNo8Ma5Ry5XX
         /meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702062236; x=1702667036;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pnnp0/fnEWWka5ENVyb9xgW39qrerb88jdwgH/GIHYw=;
        b=M4fSjIDs7o0U6H6I6GqdIN+kiikTTtE0EXUxyjNW9S49Qi0GrLoqA3gLhVFZbQ98Fo
         bIZMthPdLO5ehdY8///L3At33udX668wlC3OTu3LQtW62rSg3iuHqYIkLsbm8XRgDKSj
         hu6Pr3sjEmv7hZQJ5S8PdidNXAoa5ALIoEK8vYZEKd7YH7DHnVagg8pH+kmPh76KkQDa
         L/1HVFrvVWM/+ZpVlcV8Nm9Iw8V6h8M9DBdOy2eLWEbc/LmrPfd0SitZo3UYTtZw+2oa
         fVNO3TzEqgbANKyZGNakb0uHSGMNKuK9C02BOYplziUcTxn4Ul8p6YS6NkI08IA+gw1A
         yS6Q==
X-Gm-Message-State: AOJu0YyFa9ucsRu7jNcOKE+/E7e7ytf7sdU671HngFBNANLK/YHqZinp
        iuqd8LJ1Y96jZ0IifO9Vbcnb6IMPuI4=
X-Google-Smtp-Source: AGHT+IHoX/JR8CN++E5+tp3yzgkmAnPoCjWxHmdzOWRgqCcQC6P5gd4eVJxrokGbbxFq15a3TKUUpHzqCkY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab09:0:b0:db7:dcb9:790c with SMTP id
 u9-20020a25ab09000000b00db7dcb9790cmr3789ybi.8.1702062236159; Fri, 08 Dec
 2023 11:03:56 -0800 (PST)
Date:   Fri, 8 Dec 2023 11:03:54 -0800
In-Reply-To: <CABgObfbgs0z0Pe37T=TJprEkq0dZngSxKKKVnM74xHg6eFGegg@mail.gmail.com>
Mime-Version: 1.0
References: <20231208021708.1707327-1-seanjc@google.com> <CABgObfbgs0z0Pe37T=TJprEkq0dZngSxKKKVnM74xHg6eFGegg@mail.gmail.com>
Message-ID: <ZXNomuGtEOuG9hr1@google.com>
Subject: Re: [GIT PULL] KVM: selftests: Fixes and cleanups for 6.7-rcN
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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
> On Fri, Dec 8, 2023 at 3:17=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > Please pull selftests fixes/cleanups for 6.7.  The big change is adding
> > __printf() annotation to the guest printf/assert helpers, which is waaa=
y
> > better than me playing whack-a-mole when tests fail (I'm still laughing
> > at myself for not realizing what that annotation does).
> >
> > The following changes since commit e9e60c82fe391d04db55a91c733df4a017c2=
8b2f:
> >
> >   selftests/kvm: fix compilation on non-x86_64 platforms (2023-11-21 11=
:58:25 -0500)
>=20
> This would be a 6.8 change though.

/facepalm

Sorry.  Having to switch to kvm/next to get a sane pull request should have=
 been
a big clue bat for me.
