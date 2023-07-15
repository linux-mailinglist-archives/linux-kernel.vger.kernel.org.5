Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551BD75476E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 10:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGOIAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 04:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGOIAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 04:00:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24A73593;
        Sat, 15 Jul 2023 01:00:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992ca792065so370725066b.2;
        Sat, 15 Jul 2023 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689408039; x=1692000039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjSF4VOKvVkLhpC37d1SJ5c0UkjYX5JYRACBex13jMs=;
        b=Aul8Ad3eIO/Bk+g6awp7kwCX21h8hrjXxsz+siGafno3Zfzl+ZsFOM14sa2LqloKF7
         zutYk7e0UG5CJLAL9NmP+V6WkvBD2ott2CJCcPaEumn4OTE3YNcvQpehWt6PCbJ3N+Kt
         3Zw0APs9hv8nxP9yZwNq5mUJBIJOkWSXA+M84M1xhG1fF6LlnO7Ajega4EsAR4yDCDX8
         607zCL15I3QVtAYPhtjnXX40ykcxFHotwAlHk7XrgfgRvGTDcTtWAON3hSzTw1FILbWv
         9d9awG+bTe18QYBij5MCX3SriovvLT2cxM+7sGOibX3ce/7EZAF5MHNxW72dsUR+ddLb
         38Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689408039; x=1692000039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjSF4VOKvVkLhpC37d1SJ5c0UkjYX5JYRACBex13jMs=;
        b=g8ATM725C636+E5eMQ8IHUcXMHzyzhIht3MBPHtZCP2jlszzQXsTdsTzHxuUOnRnQj
         9eOqakrKjXn5EEpxCL/UeUjhKXTWHuGBhokGtuDQyfMgqS3d7RfaQtsfT26AC1P9LYyd
         81Sy+dfN2fijb5u9NSVvmJhA2gQ19ydso96Tet1crRr2YxAW8snZJ//7ber8Me9fy5Hd
         yqKuCmYsnakj58LQwC2ez6rgQRX/4a99RdvCyPIKCdWNmWAKWxkLul8fjmjICRkBl9KJ
         YqenXnWh6g99TyPSnXfDZHNflEY3PPzwT2wxeTlkhRq0WG4xQTStar2xJ0GvuQN/K98i
         QFBA==
X-Gm-Message-State: ABy/qLbpvYhhwLxBNa2PBXkXNiKbK+ZIB/dsn+9t16d3EAYiVPFZZ+cK
        bbcWCGp1iFff9q4SuIOIdRebGb4n/DsE3ZTSgXA=
X-Google-Smtp-Source: APBJJlE99cxOI4FvSiq0jRKg7h4+7OKucNnznzqFMWWJcOvvrGKEui0wTkcrndRpcxrQzSR7/N9G8nSn4Wc1xbUsMyA=
X-Received: by 2002:a17:906:4bc2:b0:988:797c:759c with SMTP id
 x2-20020a1709064bc200b00988797c759cmr5559641ejv.69.1689408039150; Sat, 15 Jul
 2023 01:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 15 Jul 2023 11:00:02 +0300
Message-ID: <CAHp75VeyHYCucnxaXb5UU0x2i0ugJGqxeiBZvMqd_2qX=gGsBQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] spi: rzv2m-csi: Code refactoring
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
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

On Sat, Jul 15, 2023 at 4:04=E2=80=AFAM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> Dear All,
>
> this series is to follow up on Geert and Andy feedback:
> https://patchwork.kernel.org/project/linux-renesas-soc/patch/202306221133=
41.657842-4-fabrizio.castro.jz@renesas.com/

Thank you!

Some comments I sent against individual patches (Suggested-by can be
applied to many, btw), if you address them as suggested, feel free to
add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
to the entire series.

--=20
With Best Regards,
Andy Shevchenko
