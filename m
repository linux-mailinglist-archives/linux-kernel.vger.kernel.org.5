Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD807CEE8F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjJSEKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJSEKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:10:44 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00730119;
        Wed, 18 Oct 2023 21:10:42 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1ea05b3f228so3047934fac.1;
        Wed, 18 Oct 2023 21:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697688642; x=1698293442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exlx/JOZFhxO7je5a84RZcfHQL1GXgStxtSXicAG0t8=;
        b=Upf3vdHBJlJkC/QBNyAXGQPR/Out9kyx1WScJMSinCajOLR+S2OiX43j2g2RF+aVYY
         FqEcGxSe/j99LMkkp7/SDJ4z8WW6TLcjIdPbdziO6CEzwMYfEyFIp876Ex4I9aotC93T
         S1SWDf2+n51GVQPLjK8f6edc++8srOoerIEFBD4NJxBu71vt8i4+pZhV/yNlWZNRmgNs
         DH6HoSNS2/3c/UqQWvDwOA03i6oMt5wL8AJnXQcHV0j1uLaRTheQmjGw/rm8bT2vrOCs
         AO2/m2NKb1WTvzpqYUDv0ynLITp7Lma5PnlHvQG9IMgU9mFw2IE1AhjOq9zuMnvMAuMn
         s2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697688642; x=1698293442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exlx/JOZFhxO7je5a84RZcfHQL1GXgStxtSXicAG0t8=;
        b=YhFeNKGpZG0UeDnSTpkrbhH8x2IsHOs37FsqViK3GTZpuW2bp6EfCmRjcAUj4oRn0M
         PEETqoqERwEQ81BlQvrfPEDzzS99UwL2D/uHGDuuto8FoQDjGYulBkWZt7h9usqEU9r/
         X5lE/8YwQ53V+7GOFr+7AzIpmkcbyIX7zUUVcZgyf3w+ptrF8z+tfHnzLELLh0gG3tYZ
         7CCfsWTm8x4eCB54CIUezG1WEKUSvwNQQOR+oKlrFhUrIYDQBHcyo9Y+O7++l0S5hcWW
         zBby4HeVKJuCdAb0oU8XWBud3SVOIBSw/Xxc2LEWQDKIKbt0HF8D7qIsTIMBOydqf4/M
         3HEw==
X-Gm-Message-State: AOJu0YzIyTHjpc8Cd+XrmrTcK1sfPQYRrRMaAECI93h7SjMP1DKapTxV
        PB8d1RAHjPQNs99/h76VO/LFu2IuRi16+afukur5Ky3J
X-Google-Smtp-Source: AGHT+IFpttNbHnNs4OZvxDAywxepXeRJm16GxFMmxIIWBmhA+hzcWgp/FQNpot0HCKRlnpenGHI1MeRAOPKnF1J/on8=
X-Received: by 2002:a05:6870:aa92:b0:1e9:64f1:9c30 with SMTP id
 gr18-20020a056870aa9200b001e964f19c30mr1632950oab.18.1697688642232; Wed, 18
 Oct 2023 21:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230827023932.501102-1-sergio.paracuellos@gmail.com> <13d7cf46270082855174414b691fb3be.sboyd@kernel.org>
In-Reply-To: <13d7cf46270082855174414b691fb3be.sboyd@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 19 Oct 2023 06:10:30 +0200
Message-ID: <CAMhs-H8ek=bGOQpeF7i7CnSnu-AYCUN+jTxTtOXW2EgLAmQXfg@mail.gmail.com>
Subject: Re: [PATCH v2] clk: ralink: mtmips: quiet unused variable warning
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, tsbogend@alpha.franken.de,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, arnd@kernel.org, yangshiji66@outlook.com,
        kernel test robot <lkp@intel.com>
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

On Thu, Oct 19, 2023 at 2:32=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Sergio Paracuellos (2023-08-26 19:39:32)
> > When CONFIG_OF is disabled then the matching table is not referenced an=
d
> > the following warning appears:
> >
> > drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmip=
s_of_match' [-Wunused-const-variable]
> > 821 |   static const struct of_device_id mtmips_of_match[] =3D {
> >     |                          ^
> >
> > There are two match tables in the driver: one for the clock driver and =
the
> > other for the reset driver. The only difference between them is that th=
e
> > clock driver uses 'data' and does not have 'ralink,rt2880-reset' compat=
ible.
> > Both just can be merged into a single one just by adding the compatible
> > 'ralink,rt2880-reset' entry to 'mtmips_of_match[]', which will allow it=
 to
> > be used for 'mtmips_clk_driver' (which doesn't use the data) as well as=
 for
> > 'mtmips_clk_init()' (which doesn't need get called for 'ralink,rt2880-r=
eset').
> >
> > Doing in this way ensures that 'CONFIG_OF' is not disabled anymore so t=
he
> > above warning disapears.
> >
> > Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIP=
S SoCs")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-lkp=
@intel.com/
> > Suggested-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
>
> Applied to clk-next

Thanks Stephen!

Best regards,
    Sergio Paracuellos
