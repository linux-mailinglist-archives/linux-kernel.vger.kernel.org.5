Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C1777AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbjHJOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjHJOfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:35:09 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46F826A2;
        Thu, 10 Aug 2023 07:35:06 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1ba5cda3530so848241fac.3;
        Thu, 10 Aug 2023 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691678106; x=1692282906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2gV1030sZCbxiS6NMaJx8ViLVSVMgkSZNa15D6K3vI=;
        b=WvKmnKdTk7/vcpPkkquQKRnsM2nH+X7LcfB5W5JUec4VmYYP/79R/TlGfNw9UDw8iv
         g8gWOr48Fpd95EJOkiyJZWMnl2lAJH6lXxeYXpE5PAiJTaAdNDfJ1EKJP2xXYsAPPlWa
         zcJIpjJmJjZICDXmQH3twd5/kUR+UWW5PsbHTN9WkbjKjB3y0xNIAuYvGSatJtFf1/wz
         XKloZWdRDnM+CplcTo0EW5JyP/vQlcYL0Vd4hX/tuyTnCmHROO2YEH5WnULbwn5JnblI
         LX/xm57Tgu+A94keG6VVPxvUCWyLtQKAVLbBb8oVKwajV7dhgYhhVktmpBchiH9gcGxx
         mf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691678106; x=1692282906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2gV1030sZCbxiS6NMaJx8ViLVSVMgkSZNa15D6K3vI=;
        b=N9o3lCTQ+YB5+yisUI8qawa/JnVcoi4r4qBgrg8+caBeyFyR1d/wwVE109/ToRZrlI
         GSRk/fcUt3Up2u05++o1CnVWJ/rAdmqW/va8aRXkHBC+nAqDPdrShH5YeEbH0ZMO5wd9
         zCvwZWKHuRXekb1Zg/YmbRcYC85ZefL440XSqs8cnFFmYnjwl6EaUlwDoBGkE5g+wnn4
         gdcK+WjpWJxfuYYl4VE9ZxegDrWa2A0NHh5FqBmsjqAlrlxhxrWp/5blX6rJuda4haCn
         vKD+dsyaQNM6hJ1DuPiup19ckr51Xlp+Ff+pAHabn5zed2tAriL/8trsGG2ib2KorPN/
         tJPg==
X-Gm-Message-State: AOJu0YxmTHmH93r1quZWTIzAiofa0QvabaAOImJ/h6tSY9XNJIEr+PgZ
        Ez3fPT7rIuZOYQW8dW97vZvWgDcq46BxkCdLu1Q=
X-Google-Smtp-Source: AGHT+IEHA1a88InV115gvWZ6fTpuo8G8dJ0JE+QhlYWK9ofr3EsSSwBeJb9FbIglLDFxn9OhngPeBTahocUoDlfqpz0=
X-Received: by 2002:a05:6870:364e:b0:1c0:b4ec:c0fa with SMTP id
 v14-20020a056870364e00b001c0b4ecc0famr2865098oak.41.1691678106019; Thu, 10
 Aug 2023 07:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230810130600.25616-1-coolrrsh@gmail.com>
In-Reply-To: <20230810130600.25616-1-coolrrsh@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Aug 2023 17:34:30 +0300
Message-ID: <CAHp75VeSLwR-EbkJYM131Fkj2C0Cr1OA80B1=H1jOnpHcvt=NA@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: gpio-imx-scu: Use ARRAY_SIZE for array length
To:     coolrrsh@gmail.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
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

On Thu, Aug 10, 2023 at 4:06=E2=80=AFPM <coolrrsh@gmail.com> wrote:
>
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
>
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
> This fixes warnings reported by Coccinelle:
> drivers/gpio/gpio-imx-scu.c:106:32-33: WARNING: Use ARRAY_SIZE

Yes and this makes code more robust against type changes.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
