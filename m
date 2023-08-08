Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33698774657
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjHHSzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjHHSym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:54:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E20F272B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:12:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc1c1c68e2so37789975ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691514734; x=1692119534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IWEsqywMt/WOI78SzJ+zQvaFQxja+IqU7fjbphfZ/o=;
        b=K7ivBC018mliJWzfdGCFI9IQd7LqmnS4jYZb5jWgiRAmyW+QCyvJbyZFqCeXLFzg9e
         ttwViLXfuaCdizVR+IVTMAPVk4Ky4OWkPEnAssdC+EHsrSFauND6rmbe0lLurL7Yq4zn
         F3FuNCXfO8S7Bp5a5ZXuZya4Bn1ikXSbTgcJttOzRoeFIdnm8zd5C6658+XniRcGQ2UN
         JpuZpnO854Y9dOyNeEVSOB/Qzqscc5DfRbWx4EgyfcWJwYVwZxVG8KXj9qEk41MjSY4t
         Uzn0JZOZXRx/YmJJXcJOrp2ZEHC2qYMZB3BuSULcFsOuDBtbodf5SH3DORSRNryY+jTy
         milA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514734; x=1692119534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IWEsqywMt/WOI78SzJ+zQvaFQxja+IqU7fjbphfZ/o=;
        b=ToyPJ0ISybw8Yn+Fw3vl8yb/YxWSPXb9/4sQw4ASWt0Tjz+8rnqiAU0bZDhV6OkLir
         dAp5GkDGKelBGsO+NKk8R9oOp7I3xOlhx60NZ+fdXH4ybZjbKz/dI1W7BjbGkjtwN5Pk
         0N8rWKOpZJc6UB9z7vaYQDKccihroTf3YmEvEJDHfEk+hIMMkgBp0o4aKl3k/rt7+LWU
         0dwgVD4gm7o6xGCdJXFjmp3HCAN5CRdejPu52b2QB8myA67WdjEH64AZCBm9K2eXsJUL
         HzzljvmG4iRgV8H175fRKmQMDzbQFFWgNVqvgtHpGOF+tjJMBF+nZRbx9+5ZbNNR3SsW
         3TgQ==
X-Gm-Message-State: AOJu0Yy1/wQr2sIW4Db6GEoaalv8PFpsI8/4gEtyS1bWIlV2ecOEDcKa
        UqQ+KkfftzWQ0Nq6P5H0jS087Gs1/sLu1T1bQwCUdtGYMEs=
X-Google-Smtp-Source: AGHT+IEykXvUXCW1LzJ4s24YcqCGuDQiEsKW84AVe1hkX2Re0gQn/7zFIHe61Egx3zCEoeIj57kmzYpJwePXeTmOUrA=
X-Received: by 2002:a05:6870:6389:b0:1bb:739c:9e2b with SMTP id
 t9-20020a056870638900b001bb739c9e2bmr13945010oap.57.1691494714117; Tue, 08
 Aug 2023 04:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230807130108.853357011@linutronix.de> <20230807135027.429700142@linutronix.de>
In-Reply-To: <20230807135027.429700142@linutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Aug 2023 14:37:58 +0300
Message-ID: <CAHp75VdbrvK4iPVuGP+Se+RgKUrwEh9VuLCN9Rn_yXJ5Z_u=4A@mail.gmail.com>
Subject: Re: [patch 19/53] x86/mpparse: Remove the physid_t bitmap wrapper
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 4:53=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> physid_t is a wrapper around bitmap. Just remove the onion layer and use
> bitmap functionality directly.

...

>  #include <linux/clockchips.h>
>  #include <linux/interrupt.h>
>  #include <linux/memblock.h>

> +#include <linux/bitmap.h>

Hmm... What is the ordering here? Reversed xmas tree?
Otherwise wouldn't it be better to put this before clockchips.h?

>  #include <linux/ftrace.h>
>  #include <linux/ioport.h>
>  #include <linux/export.h>

--=20
With Best Regards,
Andy Shevchenko
