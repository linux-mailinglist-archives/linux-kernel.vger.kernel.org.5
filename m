Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6477A02F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjINLqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbjINLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:46:12 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282F71FD5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:46:08 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d7e741729a2so893716276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694691967; x=1695296767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+t+nzRMHh/MGP5/jvrxD14eYE9j6gVWw5j4hZzdwFE=;
        b=VsyRH4VUyRxVUgpIAnhHojT15gCH7QPJJg3IP7CuZZlIDdCYN8fdEOEV/Qhc6VyX0r
         96k4w3L/Slv32R0pTyPqCo2vOhaz69jeAbbKBKrKke2LUJFs10Kklq2OhBo+DojqRlYL
         0wskSnOstaGno9MYSPZGke4IiJAFsrwk3YdYv4LGvaz2ejh5dabG605e6hK8tXT5g/ZX
         amB4Qw12+Rs0KkWZ8p+NLm9JTHxeNQVPFAoVXNPaQyq6508812K2Nedb4mJrQfRtNwPn
         XlUjX60riYLd/tIu/UjsjpFLZYD8MKpaCn2b8Y5bZ6iXOYK5Z7tS8ZQzclUd6NW+JCsd
         WFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691967; x=1695296767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+t+nzRMHh/MGP5/jvrxD14eYE9j6gVWw5j4hZzdwFE=;
        b=Cq8RiSi2CyVYYGUwTwi86z5NmHmk8W+Jy++RnRwSpVaDQiqojndKjkhpEt8ZZcwg5P
         oLlE7lC+hNEDpL5tgGsHJVeKW4akJAxfhZpKsarANRTy3hsCT+NlfTntZ6WXnvxCy1cc
         oqM+kNAqeTwE7VJOfIMc6KrzcHUZhYowdHyaBCsrgGEXw0+mD2TrSAjmUBGHY3DNDm8N
         3E2EjWhq2Uv2zhuSfgUOUtNebdoIceFedh2Bd4g0LB9RwnvXWQAQtGuyDcYI1GqanYnb
         UsGOYvWFnoPsfo/DKoVu5Ifvl/Ale8yjWV/8TzEKAsSLR9aGGMfR3P+36PjG2/KU9tWW
         8ugA==
X-Gm-Message-State: AOJu0YzTg7jB4Hn+IRI3l8lMJSJ0XWWcxX2h1pjKssNZYr5fF0hUs8Hb
        ECnHvWPQ6lbmr2Jtdh4CBysTI+VNT3pqCrxyvaR9dg==
X-Google-Smtp-Source: AGHT+IGmHBJzyl69gBYwQv4b0mI3Vn+L0mVdmhr8enj4P0ZQl5AwarQm7e57WkCLiFnkBXVbOCqnB5cIPy1TvGjUfMY=
X-Received: by 2002:a5b:b47:0:b0:d1f:6886:854a with SMTP id
 b7-20020a5b0b47000000b00d1f6886854amr4559019ybr.9.1694691967397; Thu, 14 Sep
 2023 04:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230914111855.586724-1-ulf.hansson@linaro.org>
In-Reply-To: <20230914111855.586724-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Sep 2023 13:45:55 +0200
Message-ID: <CACRpkdb-1872T_mqmZY0-s-A4969C5A5CzKfY_hKvXgn4p0_JA@mail.gmail.com>
Subject: Re: [PATCH 12/17] pmdomain: st: Add a Kconfig option for the ux500
 power domain
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 1:18=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> We shouldn't really use the CONFIG_ARCH_U8500 option directly, but rather
> have our own dedicated Kconfig option, so let's add that.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This looks fine!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
