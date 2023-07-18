Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5157585E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjGRUBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRUBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:01:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631339D;
        Tue, 18 Jul 2023 13:01:02 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso10047258e87.2;
        Tue, 18 Jul 2023 13:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689710460; x=1692302460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsvfuniumUvrIUad+FZ+IggHzjIA9v5b89HgRnRmbbg=;
        b=WMS3LPUYM7SRTV2JJy9QuMJh1i0EYGYpz6wE8LhTEEpaE99le5jH45Q0wwlLhfpVXB
         JVjgnlRIXxkpf2nlYRxO27/g5GGFSCZV3gizRLlvARf0mKrJ2GhwmsMQQDs+31SIYimp
         GSxtN63kFs4rVyfT4eKZRd4GdZbHMauvwW7O8qpKclPc/igFnwEUVVeueA9JAvfFrLQp
         VjVbn3trrbAen/oY8/7J/JDqCpPPWAGaBtJA7JfEpZLIQ4HobzJ8SvarbDUC8STUSSsZ
         bpsRAqgbCr7kOaYC6BCY0hklixnexf5bJ8MZ+KoPcIJfcR7WC0PU6Wj0ZhNj8UlCZcjf
         o1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689710460; x=1692302460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsvfuniumUvrIUad+FZ+IggHzjIA9v5b89HgRnRmbbg=;
        b=MSVRfwMqsnzbF/YyKr8AeUXOhKwPR4a53ZCi/TXWTasHWKygKo0W71qkaRQf1Uxrv5
         /q/wEhhizxyzaxDgfEDLTRrCKGk7m58OJNHRgFcoef2kfQLvJ8c8wXDlHVUCt/Rmics0
         cbxcsdBjYB73dw2YEkJDUKSzZLO5pKHhFOazHk1LxkuMUilTeHa2MQyRmM4ojBsLaFVI
         /pghAq7L62ifvjNfOaZojQhvFhVPUC3FYXCjL7WQDcdzWZK7FsxfpGLhRvx0pcn15Xfb
         2psMTUEomOs1ePtQ1j11JZV7Iwz5v3W9rNFFlAn3VOBfawXFqVZjhLAcVM0SRE9RgepL
         uNQA==
X-Gm-Message-State: ABy/qLaVo/dKcRn/b6gixUD0IAYaGpwtDBuG71SnHbOBZ8CSUQ0xVqSG
        cY2rOXEKJ9lEKLGtuTBCjDsQohqaYG7SXg2eGjc=
X-Google-Smtp-Source: APBJJlFEkIxPU1zRHgCE0Yvos/6nBFcpXuNGPNI0RSv7fO058aV+jKep38zsgnKxdwypcLoMcfu6eoUSdbtGssw3OAk=
X-Received: by 2002:a05:6512:2214:b0:4fb:a990:bb28 with SMTP id
 h20-20020a056512221400b004fba990bb28mr12199600lfu.18.1689710460410; Tue, 18
 Jul 2023 13:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230718192453.543549-1-fabrizio.castro.jz@renesas.com> <20230718192453.543549-5-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230718192453.543549-5-fabrizio.castro.jz@renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 23:00:24 +0300
Message-ID: <CAHp75Ve-q6ZgYBzKwhTpOHjS1ib8WcZkSPE_vzhxzOsvMTVacg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] spi: rzv2m-csi: Make use of device_set_node
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:25=E2=80=AFPM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> Use device_set_node instead of assigning controller->dev.of_node

device_set_node()

> directly because it also sets the firmware node.

--=20
With Best Regards,
Andy Shevchenko
