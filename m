Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4D7FF670
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjK3Qmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjK3Qme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:42:34 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028BB1A3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:42:41 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bbc36f767so1705296e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701362559; x=1701967359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05Mpj4MHmTw58ZLIMAy0nBU+jdjD9L9+bDSyBxDCGGw=;
        b=KZl8bJoQLl9H8RqDs35Wmu3tWeZGK1cY4zTkxvE67jMd4cYj95T+HLYPzkwLt24cwJ
         dZ900XRXVXJBoxWRuZZTGo4MBms6P/gAZ2CdMcTgnxTHBHFnOnwsGL13PkKnQ5jVepwp
         sBRXTi2VRjzmOTthvsnOM2citTqjl0/UrHCO2PT3c/vC15Ot5MOL0er8wHkWbyrSbeNI
         ndR+gU95M+FWE2dzds5wAF8OtVnNxdHubpexVKoa1B4TXmj5gZ/R7/5g6Qid25EpnVX3
         d2OchEusDaij4m3VrBgux3IAMT5+sle7tcaBL89t+XFIeUuy29mgHCHn88pTs4DbhpwT
         kZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701362559; x=1701967359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05Mpj4MHmTw58ZLIMAy0nBU+jdjD9L9+bDSyBxDCGGw=;
        b=BmzF3vV58f2zTUxhf2s7LlkLWoMq1GEhM3GGLi5SHgtNRfLnxx8yeyuRm4bYVtC2Ni
         djwZmxCXJuatf9q2MTntEgsL+gQ/JHmL29OBtvLvMvYsg578DU6sjfMXKhlb8N3cBPsT
         ADOycDzIz9tYMDcBvVWXnpDrVAMTOfPKb+uq7BcsohlF5HFPnjI53uWQmsVBtKeylqUJ
         rjCGo0tEQWBx6pmt55Kx8zX73Km5tQ8oyd7+TWeIDWAVNSdMUNk05SO0U+76OlLvahQb
         Q/tRqJcVOw4YYMPTSJ1+1mc5E68nI3LZfYRpapCwoKM1J/ic5AR+QFeayfqbJXM2a2se
         3gkw==
X-Gm-Message-State: AOJu0YxstSHddOmI4JhcTMmCdfQZzMls82Hdun46E16NJo+T6dqpJkrP
        GLkqePFt7i+77HBdOuFxpBehRt1mwNAv0a4y1RD6Wqc=
X-Google-Smtp-Source: AGHT+IGmQC7kZKB5kMqbJJVCJWEbmvAIRLSHC0kMNiACig+8dLqeOIKlR2Hysww7WY5KQw165aCL/smz31ILUOpNCvc=
X-Received: by 2002:a05:6512:15a4:b0:507:ab58:7f7a with SMTP id
 bp36-20020a05651215a400b00507ab587f7amr2258lfb.10.1701362558781; Thu, 30 Nov
 2023 08:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20231130155213.1407-1-bp@alien8.de> <20231130160903.GJZWizn+dPaaViFVKN@fat_crate.local>
In-Reply-To: <20231130160903.GJZWizn+dPaaViFVKN@fat_crate.local>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 30 Nov 2023 11:42:27 -0500
Message-ID: <CAMzpN2j5xYq0YCzXxU8srha=1um0JSWMM2YWkUG-qFA891xVHQ@mail.gmail.com>
Subject: Re: [PATCH] x86/ia32: State that IA32 emulation is disabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:09=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Thu, Nov 30, 2023 at 04:52:13PM +0100, Borislav Petkov wrote:
> > +static inline bool ia32_enabled_verbose(void)
> > +{
> > +#ifdef CONFIG_IA32_EMULATION
> > +     pr_notice_once("32-bit emulation disabled. You can reenable with =
ia32_emulation=3Don\n");
> > +#endif
> > +     return ia32_enabled();
> > +}
>
> As Nik rightfully points out offlist, this should rather be something
> like:
>
> ---
>         bool enabled =3D ia32_enabled();
>
> #ifdef CONFIG_IA32_EMULATION
>         if (!enabled)
>                 pr_notice_once("32-bit emulation disabled. You can reenab=
le with ia32_emulation=3Don\n");
> #endif
>
>         return enabled;

The #ifdef isn't necessary, as ia32_enabled() will always return false
in that case.

Brian Gerst
