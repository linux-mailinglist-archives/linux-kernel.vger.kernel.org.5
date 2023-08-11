Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815D7789FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjHKJcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjHKJcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:32:25 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569E530DF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:32:24 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d075a831636so1663971276.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691746343; x=1692351143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIUWah3ZHsW9fjPYHkUzRyvpVVLPmFz1Sr2nMFev8LY=;
        b=L2AVn9waDP0qa4+fk9FVrNkmaRlLx/Gzt6TBJfwbUoDzOAkNA+eM9SY7SJmlX0AwOR
         bz3J0kffBAUpEh6W/rZgla7a/jpoKd5Umxjrn7FI0+GpCvA/qQnf4S16ilSMSp2g8Pr7
         bC6VbvtuARSPxK3TS+rzz71PrnZjcBftFB9P/X/9bfm5IDaM67VwQy0S0YRv7BObTsFr
         U4Zwlqxc35xNbHSVs+llXr4OyGGQTRgaOLBd1TJQuaDJidYfgbJHlMtQZAFa5Qhw6SGZ
         GhCvVOx5U2h3XdCjzQAQgjG8b31MnIqHndnPN44+9YOpwdNJrkUpOLvKztrFTXhSfNsU
         7cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691746343; x=1692351143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIUWah3ZHsW9fjPYHkUzRyvpVVLPmFz1Sr2nMFev8LY=;
        b=fYlUxcPH3z2VMEqq7d7ku6Xxz+J+Khu5gPYNcs0YqR0dXBJg0V1GUdYAJpbLRwOPfb
         MTIqTGgzm3z/eXaYxL4EndHDsynj6/E5mFOLaWwkuOmmiFDLDPB3g0AOFfOgL43cW+SL
         8n4CUNMj6Hjm3BzMmLIjGcpGjlIq2xzxFbgB9KLUdgZWJEAjU+eImBv2idm5MMYACSPW
         CkHWGZ0vnWGfchBMSjTd6YPCWkd9EdcgrEzu6mNF0gpyDNSKe4KNVbZCeIMbk0o8FA4I
         UsGuzDHgCA557S6j96ZChc+K9LHn2PuTuHXfAd/bmQgThgjB+ZtnUxgdmyT1zq5beiQ4
         AEdQ==
X-Gm-Message-State: AOJu0YwUDvn7rN0BwqrUNTLq6F3wSBiO/yaR7bIeWW7lO5DKhB8Ps1Us
        Qrf7f1giZUOGEANAPtZMFYXxjLwFO1CdTwgTUnWyuw==
X-Google-Smtp-Source: AGHT+IE7APCRfNQkkBCoQSOQF1n1tctmW7mQ1WLnXMi8dlzz/rrPRaxMr7JqGv+EVthpkT2vKsksGiRJ8t40ENGuX0Y=
X-Received: by 2002:a25:b286:0:b0:d0a:8269:e5d9 with SMTP id
 k6-20020a25b286000000b00d0a8269e5d9mr1017814ybj.60.1691746343556; Fri, 11 Aug
 2023 02:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691703927.git.william.gray@linaro.org>
In-Reply-To: <cover.1691703927.git.william.gray@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Aug 2023 11:32:12 +0200
Message-ID: <CACRpkdZ_vUsgWWoQTO_c=pBz3wFYP0VMsCKNQNSSw-ASXC+V3g@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/7] Migrate ACCES and WinSystems drivers to the
 regmap API
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:00=E2=80=AFAM William Breathitt Gray
<william.gray@linaro.org> wrote:

> This patchset is a collection and resend of the lingering GPIO patches
> for the regmap migration of the ACCES and WinSystems drivers.[^1][^2]
> Previously, these patches were postponed due to pending dependency
> patches that have since been merged into mainline. Now that those
> dependencies are present in the GPIO tree, this patchset can be merged
> without incident. An IRQ handling fix for the ws16c48 driver is also
> included at the end.[^3]

The series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

The result is really nice!

Yours,
Linus Walleij
