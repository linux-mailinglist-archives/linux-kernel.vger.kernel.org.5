Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CC975B3DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjGTQIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGTQIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:08:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5610B26A3;
        Thu, 20 Jul 2023 09:08:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977e0fbd742so161891766b.2;
        Thu, 20 Jul 2023 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689869295; x=1690474095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3iV3Z2UZghH3gdkUcJuImA2u2EXku6eg64KmtZo5Mc=;
        b=GcJaQHkR/xXQh1TtkI/YAX7So/wDlQJ5rgQQCFWqcb73EXKgis5YGqB005sswQuy2D
         lgG+sNEq6Pw6tdP1tMidlZZZyZYfQDY+rZ65zstZAUeNTMgrNrYGojvZvKLin3ehLsvh
         IUVx2IwEy959BxsVoKIrMusb7t4pQXFvKyjf9IIkzDY3GAydgHzhsngF0iMY4ThYVQQl
         qzu9RChd2v6wRxFWXUH6KMTJevarX0mHX9nSMWzNU1PZX8ZmzXpATuUnnsO7gQnk0SRi
         na6GMI3fEq8HHFe4B8J8j4xPAvkmQgAaRQ69O6cKFoEO/BNNT9gmaDIB9lfuvKT5bXn6
         C+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869295; x=1690474095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3iV3Z2UZghH3gdkUcJuImA2u2EXku6eg64KmtZo5Mc=;
        b=iGgK16qqRoK1DEGkHs6fM6hqE0U9ll/Bn0tj2kCPr24ZHTR+v46iDtYfvDIhIWaLxa
         TpM4ovAN9g7ZiMzWDYfe4qkSEnRcLLBSMEr2dxt7mY0vhDZ4AQMk+CYhDBVifSt2Y7Po
         qSHrs/ubcBZMHtpMWbTfw2Xh5LSVLe+hP5sm/uGQCaOfnMjRCz8qzv8ohDNZEJCV59wl
         /wR3i8EvRmW3+6p6f84cOOKLPvMGeja5LVwf4c3kAlgdHGLq+TUgxs95jYbcfns253lt
         ks93AXw8lXLxbJ71nrgYYZQQBpWnj1rBBhmsiU1bOVJbxcCdVFMDi8LiqUneC+DdQ5og
         xXkg==
X-Gm-Message-State: ABy/qLbzJMJhqwTELBfo29ljgp/MUyW9p62gezw3C60OtXyYIT1E6q+z
        TIftsg6D6dAhmovqESHuohmcswVPteMjH83kkcXJbeak/rs=
X-Google-Smtp-Source: APBJJlHw4eBMiD6QNzwnYAWRwtYJtixe6h7oMo7t9AQTupbKnQxEKuoI0lh8A3ok0oM7sOXYjLvLYIW45Swbn/VzBZI=
X-Received: by 2002:a17:906:1091:b0:991:c566:979 with SMTP id
 u17-20020a170906109100b00991c5660979mr5523314eju.36.1689869294907; Thu, 20
 Jul 2023 09:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230720132911.23449-1-aboutphysycs@gmail.com>
In-Reply-To: <20230720132911.23449-1-aboutphysycs@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Jul 2023 19:07:38 +0300
Message-ID: <CAHp75VdU1c1vUoRpbekPXoLg2DDcbSThwUmkdHRT2FaZ9kagRA@mail.gmail.com>
Subject: Re: [PATCH] gpio :lp3943 :remove unneeded platform_set_drvdata() call
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Alexandru Ardelean <alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 4:29=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call, to access the private data of the driver.
> Also, the private data is defined in this driver, so there is no risk of
> it being accessed outside of this driver file.

I got this twice, moreover the Subject is broken.

--=20
With Best Regards,
Andy Shevchenko
