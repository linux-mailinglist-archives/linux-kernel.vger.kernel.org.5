Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F6E7D8D09
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 04:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjJ0CJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 22:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0CJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 22:09:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F4ED7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 19:09:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507bd644a96so2315248e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 19:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698372572; x=1698977372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rt4kjE1PFotWNeCEmDZRYgDY06rLqeQSNkyqt1sQPE=;
        b=TdsLyBDyoAA4qPByujbZJ3NY4g/OMI/pS9jOLfMB6aIjKJ0juOh90NdBhlLWsS5mJV
         QjaHXun2HvosbncB0o10bB5T8uHIlQi9U5WdtSYgLJYW/8yEI/psjRcXmzwFAE0dGx7R
         XtuwUWxXx5ZxCSFLnQh2DhchJV+NbwhIE702eEEx3/XG5iiKCTTVI3jiQqgP+Bi2Tcmm
         Ubxb7x+KuXg+atCjpQXMC71dGvIRLjxSdjEf4ufeV91L553Y+PgxSJpdPirl0oh7HorD
         AXLYTBTBrXL5Vx9Hxqf8PWCIl8fVck/DFvwZQ8VF7dtXr2kN4O/UbJGEVNmD8H8hVkhI
         ha0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698372572; x=1698977372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rt4kjE1PFotWNeCEmDZRYgDY06rLqeQSNkyqt1sQPE=;
        b=NbsgZ3ZW0aZj4HJtvnou3GhNL/gGAzfIYQAx8KOx6StguzrqtJU8h8tZq2RnMUj2jM
         qNdg8u2HAdd/KVx7d+T88dtKAUtAL4rsEWg1eQ7ABTbjVVxnrW/rAIdtqGNYjOovhpH9
         nfZru6MrqjDbulsLPWglEcsbZe2/MUIQgNlrqoxVfjlHitR3jx8E7r8sJa62Ke5TYHby
         Ac5rXSdJDDeHhiTNF1qv9VCTEUbujIbAKiVrUPAy/1rcO09TUENsoIZ22novZVGDJcdQ
         P1Cm5Tyl+ndX+i/oSKqUMIgJTwiLAMGsLDYrqNmk3/dwKbXZcbE4zfLnXv5T0pTcb1Mx
         HJQg==
X-Gm-Message-State: AOJu0YxnGGMt4GU3BRvM/R3nTLbC5P1VVZSyPTZcPQ6z0IGLjYYI7Ey3
        rdtwKVPxjd06mUJEIXJERdczMFIKjJM1rtXLGg==
X-Google-Smtp-Source: AGHT+IHQ++Rie3IHMRL01lgiGSlvW7c2gy/pe9Ni0qQti9TlzM3wPo0BURddWQs8EPATE7TZO7uZk7ZXBBz4vHQlciY=
X-Received: by 2002:a19:5513:0:b0:507:a8d1:6e57 with SMTP id
 n19-20020a195513000000b00507a8d16e57mr737059lfe.40.1698372571452; Thu, 26 Oct
 2023 19:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-1-brgerst@gmail.com> <20231026160100.195099-8-brgerst@gmail.com>
 <CAFULd4ZSzJGzckYLGuh-uVXqpk4E7bxnen0_y5HqFiPkr_36PA@mail.gmail.com>
In-Reply-To: <CAFULd4ZSzJGzckYLGuh-uVXqpk4E7bxnen0_y5HqFiPkr_36PA@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 26 Oct 2023 22:09:20 -0400
Message-ID: <CAMzpN2h+5FvMhDMWBf8H80mMAMYTOBMBFM4nSr92QRJLA0gqJw@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] x86/percpu/64: Use relative percpu offsets
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 2:47=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Thu, Oct 26, 2023 at 6:01=E2=80=AFPM Brian Gerst <brgerst@gmail.com> w=
rote:
> >
> > The percpu section is currently linked at virtual address 0, because
> > older compilers hardcoded the stack protector canary value at a fixed
> > offset from the start of the GS segment.  Now that the canary is a
> > normal percpu variable, the percpu section can be linked normally.
> > This means that x86-64 will calculate percpu offsets like most other
> > architectures, as the delta between the initial percpu address and the
> > dynamically allocated memory.
>
> The comments above MSR_GS_BASE setup should be reviewed or removed. I
> don't think they need to be set up to access stack canary, they are
> just clearing MSR now.

GSBASE is deliberately set to zero offset on SMP for boot because we
want any percpu accesses (including stack protector) to use the
initial percpu area until the full percpu memory is allocated.  It's
possible that more stack protector checks could sneak back into the
early boot code, and after the conversion to relative percpu offsets
they would work properly again.  I just didn't reenable them because
they are unnecessary that early.

Brian Gerst
