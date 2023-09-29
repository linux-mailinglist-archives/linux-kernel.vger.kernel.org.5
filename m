Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55BD7B2C16
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjI2Fw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjI2FqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:46:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC1B10F9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:46:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-534659061afso8143819a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695966359; x=1696571159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sKQiADHlNlV2mDTE+C+KwNLexlJtoVJGuBFuIz0iic=;
        b=I/wp5dF43s0YmUVW5E6XBXBEFj2wp/e4zKrtU+mIhl8RrETv55tT/e/iS7Z3GFYVeu
         K8R1sa4QfImbX/52eqvSCti1UjwLyf9VZq9bHSPqnL3kXqinW4vmraGul9cln/6VNhpd
         2SJGgIHQnXmpT7av5DPTJB/tfz2S7wCQfwJNDmRrpM2iUHfJXz7xc5xETAFfpGdw5P9y
         yUuLIJHDIgjnwogocs1TZUyr6MbdHKjndzz9gNDk+ps+cOV+eD+6Ggc7Gcz/Mje8SfeA
         THTG9CN/E73ZzLSKyGkEJPMS4f8BXErrB1eeOJ2tdEeuIFhFdbXhcGW9j28iNme7QDV2
         572w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695966359; x=1696571159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sKQiADHlNlV2mDTE+C+KwNLexlJtoVJGuBFuIz0iic=;
        b=pPpz6E+O+UQvbKoTTby/Rn4Q08m1AYR6lQka/XsqmjDrpa7kK59E5KHcN54v3+x1gD
         D+EmMU3kFBSG1Lbolck05rOHCmoP4OL9U1rJxKDs2InYMDDyq1hF6QBmwe4v+2JiXYTm
         iqGfZusKkIb/Ua4e0XcCB0T0IxdJXTvN5hR877MCJLU7tehkgYb99q1OD1Anz8xQR3QL
         RXQbd8vfSnsjltSwS8vsWZV1NSz6+UUAxtxF0iSJSMlS4yLNOT0+iYWlyxEWaeLFYrDY
         LKZqZ7K8sMk58cADaQ474HR2taR38dwEaCX/UMrFGiJYTqIVe/CXQ8crNQ0S1+3DfMww
         whsQ==
X-Gm-Message-State: AOJu0YxvWXtK0xeuyrJ93B7Nykf+JjeXgAW5cz18qyhDpNdZ8iAbt2dN
        TP+lfyTF7nch+caVi8ZaR1TiDFmAL3+zzzguRsg=
X-Google-Smtp-Source: AGHT+IGIx1l0QeEa2QJpynLELUsQIgEzl6QRS1QgNfPU5deBIpefVOurgX0CrIaa8uekSxeaiasojIXHvpsoKA3nDMg=
X-Received: by 2002:a05:6402:515:b0:533:9df5:ede with SMTP id
 m21-20020a056402051500b005339df50edemr2608995edv.14.1695966359363; Thu, 28
 Sep 2023 22:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230925150905.54842-1-ubizjak@gmail.com> <20230925150905.54842-2-ubizjak@gmail.com>
 <ZRXnu+8gQGVZVA79@gmail.com>
In-Reply-To: <ZRXnu+8gQGVZVA79@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 29 Sep 2023 07:45:51 +0200
Message-ID: <CAFULd4Y6OUvscbDwBL2itM89pNbo3_Q2_mKR2G4DSSbyTdD1cQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] locking/x86: Wire up sync_try_cmpxchg
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 10:53=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > Implement target specific support for sync_try_cmpxchg.
>
> Could you please provide a before/after description of how
> this improves things exactly?

The improvement [1] was demonstrated in the original patch submission.
The resent part of the patch series is an infrastructure part, which
introduces a new locking primitive, together with its fallback, so it
has to be committed first. The improvement is in the other part of the
kernel, and this part requires the infrastructure part.

To avoid unwanted patch dependencies, I propose to commit the
infrastructure part first, and after that commit the XEN part of the
series. (Please note that the XEN part is already acked by the
maintainer). I will mention the concrete improvement (code
simplification as shown in [1] and better generated assembly for x86
targets) in the formal submission of the XEN part.

Please also note checksums in include/linux/atomic header files. It is
necessary to regenerate the headers every time the checksum changes.
The resend of the infrastructure part was thus necessary due to the
recent fixes in this area.

[1] https://lore.kernel.org/lkml/20230710192440.47140-3-ubizjak@gmail.com/

Thanks,
Uros.
