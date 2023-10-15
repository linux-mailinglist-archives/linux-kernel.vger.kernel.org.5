Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3107E7C986C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 11:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjJOJA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjJOJA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 05:00:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7803DA;
        Sun, 15 Oct 2023 02:00:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so24988771fa.0;
        Sun, 15 Oct 2023 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697360453; x=1697965253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sUKXBDAU7yRvgkxOo63NtcyklMaDwxQR1L1y1/Du95g=;
        b=RwuunF8ZDfImH594IqLgMh/owDkdzw2XZvP9Jwjj2KSJTV1bzf/7HN/bV/E1AAtTeq
         a5wIS53T6q8gHE2tWlTtA7aVnSIJyDsq/t3gLfXqakgf0nM7vksF0cDCfZndYBFX5i78
         /+dXhSLeoW9EE320DwM4sEH3Fv9fS/0RZkhW43A49IaDdSHN4M8IXihPAsCDZzbuOl0V
         o/p1sUTkHkokemU0vYovU57yVTy0CPvLm6TFu02J70itAV7UNAInS17pceefWj5pAaVK
         m8vJH5UGQQnH4bZExlCx0Pp8AgNx6Dr9ngyw3AyNwMUeFVpkMMDArxiQJk24obOf8hOs
         lZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697360453; x=1697965253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUKXBDAU7yRvgkxOo63NtcyklMaDwxQR1L1y1/Du95g=;
        b=kRhJ+dKS3jMulZTNAR+YY3RfwuWRuqHW5xEvk6++noioCdvImvMt+P86NQFOVAtw/+
         FC7Zgphuu3TewBnHEcvCVGNuxvtrJcoLd+spAXlm/K2LFeM99/A/+W8d4we0DH5ahWi3
         3Wq7LwswgoMe4330Gn+BJQR1DpEesBAxOETprwWZjen0G4JWbyAJfu6oLOgPoPGIrKPo
         8/XinV5jLLZAq7HC9RHjXFTRXKLra2Dh+L6SRATPv+pxwlbKWuwlqWuz+caBdIXlNHgy
         lp+z5Hzb/FFb901PXUwdnTGSPkOyW+mDov/WdXy95tddnkzSgwhrEPL7P9Z3RchopyAM
         sC4Q==
X-Gm-Message-State: AOJu0YxOLIP5lTiWWUXXT3GUHba3auTZBWRh6wUV2sXZ9WAykEt5f9Iq
        ZdT0K//dJBDxvHFlnt0CLw1qDyR2RRsYGUgo9Js=
X-Google-Smtp-Source: AGHT+IEeRq5SP6mqrb0AloTKLb9pI1Hmn2zRyq5heXljQOw5f+hV25tMCL00qCO52s4kDz7hA9KXi+cggZZEr6EGgvE=
X-Received: by 2002:a2e:2413:0:b0:2bf:fd6c:ddfc with SMTP id
 k19-20020a2e2413000000b002bffd6cddfcmr24524661ljk.45.1697360452663; Sun, 15
 Oct 2023 02:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230057.3365626-1-tmaimon77@gmail.com> <20231012230057.3365626-3-tmaimon77@gmail.com>
 <7598fcfa-7047-434d-be03-41cb2bb46ecb@kernel.org>
In-Reply-To: <7598fcfa-7047-434d-be03-41cb2bb46ecb@kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Sun, 15 Oct 2023 12:00:41 +0300
Message-ID: <CAP6Zq1iOyGfYAEQ+psK9Xz-QYXc4Poo6sJhUsNH3m80HmE7v2w@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: usb: ci-hdrc-usb2: add npcm750 and
 npcm845 compatible
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     peter.chen@kernel.org, gregkh@linuxfoundation.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks a lot for your comments, I really appreciate it!

I will run scripts/get_maintainers.pl to the latest kernel.

After running scripts/get_maintainers.pl do I need to send the
patchset with resend on V6 or do I need to send V7 with the new
maintainers list

Thanks,

Tomer

On Fri, 13 Oct 2023 at 16:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 13/10/2023 01:00, Tomer Maimon wrote:
> > Add a compatible string for Nuvoton BMC NPCM750 and Nuvoton BMC NPCM845.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
>
> Please kindly resend and include all necessary To/Cc entries.
>
> Best regards,
> Krzysztof
>
