Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4784793DAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbjIFNa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjIFNaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:30:55 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E802E6B;
        Wed,  6 Sep 2023 06:30:52 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5739965a482so507720eaf.0;
        Wed, 06 Sep 2023 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694007051; x=1694611851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTEkkM13Gphml9oWsQLKQadc/TQ9JNkPJiqMr8G3e3Y=;
        b=nbYKiHMQSQuEUVFzNEcFY+wOiw015zrDvlVsyPuhLlEdbmQtVvxbxYlVvpaGUfpYMz
         pMRFUJ0Mh/cCc5mXq9P4rGCWtFzKabTZmN/J7KTQk9Uw9sSbtMZMocgRjjQpRIB7ROYw
         oCViOvgPGMgS1rmR/XErJhRdYxsTzOHnCZUZ232y1Sn2miYAryLHr4PM/tAIcTrEuf5+
         SzlQMjdZ9WG7gicYBDSuNFkD+/1Szf5Fl8utd1Ciyyc/b2zFygFCvnLXEJKi7cX0ctZM
         /5pnp61fSvr0EdALMxAeaRAG9VFRwHqBvD3se5dhHmUmR64qPcmsZQN1yEMS2qNengGt
         o9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007051; x=1694611851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTEkkM13Gphml9oWsQLKQadc/TQ9JNkPJiqMr8G3e3Y=;
        b=HHjaN0/8GplDE4dbcS81+VRgICfTsY6Gab/Mv/i4sojQEga9S9XzafY6/8pnleNsp4
         cAKiUaSWsuRfVrtZZW2scQ01TRK93hFjL8WBIt9S7LFmjF1+em/wwnVIyRO21MoPKEIJ
         phix0ecYMIIRbuC+XjmRUDhRk3d1mMUV7zJLvV6P+d1n6wV89bjeKi54T76b8Kh/6Jlc
         gX09JvsGriahC2eYM/CEw+TSkGsz9yYJ0NKzvM6RLVb27YrSLuptNwRMIlz9BD1rhK70
         KOSR7thtl+l/7jvJlVnhGv98SKF0Cz8NLG9f2MnE4zK9oB7jrAiLBE97x46zIUo+lFu2
         A4/g==
X-Gm-Message-State: AOJu0YzrtJ2XnLxNggFGdvnoBvFrGs+XjYohyDQ0M7olTyk/qX3o3S64
        MfwfsSvwKDd1eO9NfZkaS//M04VW+hFPWUT3u5Rt5PAfy5c=
X-Google-Smtp-Source: AGHT+IHgLCr9gzW2JJF1hKuXjYYCqfgfES4I2E2T/f/NXykru6PWJ3HpwETfOO7MQqDJVnXNymS8YNrqHgB4Gk5toi8=
X-Received: by 2002:a4a:9bd2:0:b0:56e:a037:3827 with SMTP id
 b18-20020a4a9bd2000000b0056ea0373827mr7143267ook.0.1694007051265; Wed, 06 Sep
 2023 06:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230905-strncpy-arch-x86-platform-uv-uv_nmi-v3-1-3efd6798b569@google.com>
 <ZPhsSzHG6YMViOSk@gmail.com> <bce762af-0da7-bb5e-1580-b42803c183f6@redhat.com>
In-Reply-To: <bce762af-0da7-bb5e-1580-b42803c183f6@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Sep 2023 16:30:15 +0300
Message-ID: <CAHp75Vdn_pPkjg=zyspnraz2RARrWJ6A76e8_PKLhtUrewFQMg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/platform/uv: refactor deprecated strcpy and strncpy
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Wed, Sep 6, 2023 at 3:16=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
> On 9/6/23 14:10, Ingo Molnar wrote:

>         strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1)=
;

If you want to make it short and more readable, you can use

  strscpy(arg, val, sizeof(arg));
  strreplace(arg, '\n', '\0');

--=20
With Best Regards,
Andy Shevchenko
