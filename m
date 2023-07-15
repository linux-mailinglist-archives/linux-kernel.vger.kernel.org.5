Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBEF754764
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 09:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjGOHzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 03:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGOHzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 03:55:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C173A87;
        Sat, 15 Jul 2023 00:55:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9891c73e0fbso547883366b.1;
        Sat, 15 Jul 2023 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689407724; x=1691999724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZVljmN8gKzVihzv67m8xWAZ45voGqqmcvosG919a8Q=;
        b=gMDSLsP0AjtZZVd/MA0X86nT6x4fPQkWW96WRsOO/IkhyMXwhTBxdVSI/FgM2nXrUp
         klNAi2o0Uty8fqAmGQ3ao8LYO5EUUOVxOBSEs9AiXswl5RSZ/OM3L6U9zZo20QxF1cU7
         SZRGT2clfqi0sgzeElkw9CJqAjU4EXJizzPhEA0WdpQpH930nrMaTz14GcKgM/G/+6Al
         gpBMgOIQgwqooGljzsyAnDzDKTaCiSkCPMH9pahBC+PE6e0weErt2Z30WIa1PVmSJHSh
         4IjR5v7P09/Auqg8yWKTu8bDi4KHpTcguykl0ptuWXi0nJp1thJI6WrIB6LP886mpo5T
         n0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689407724; x=1691999724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZVljmN8gKzVihzv67m8xWAZ45voGqqmcvosG919a8Q=;
        b=fm9gg91n+t1ZRF6AE+qE8gsynjVOiNId6uioR8dhp4O5I8Try7ph12GA3B0HQhRmwR
         65CLacCdpDqs+eqzUo/2S6+LIft287kvmSXJtQ+TOT5OubWPnJtXTnMb7EbVfLCJTscc
         TAr9qpgtQUR0DOXOOQCf4mTILPkKdzMBOuAbVyhKovCE8J2UV4QtrNV5QNyD48CpATyZ
         /9fK2Rf9LJ6Z5Hb2C16sYrwBAf0y/sjmUaEeIvUhO5cxwplkpmrU7B6E6iUicefEEIKH
         MPFnfz/FljgvE7lydxQJJvzuNuScEmtiC/ULzqjaAqd51vrENyNZnHI1Qtp+3MQcmGMS
         S+Hw==
X-Gm-Message-State: ABy/qLZR8T7trJLuIKdoCVf/NQLS6L0oDmeu5O4W/bi/iyQYFzfU6Esk
        3NMneTf8LBy1RwWSU7YDGy9ESAEzPy2mAN6Mk3dXUuflDSE=
X-Google-Smtp-Source: APBJJlG25DuLYvRiAJwCiIKNT6BG1olipljfJ1brsg8juTeUW2lriWZlpXFwWUzGZ15I0DS+CkowlFQBZW0WP5BrriM=
X-Received: by 2002:a17:906:109e:b0:98e:1a0c:12c0 with SMTP id
 u30-20020a170906109e00b0098e1a0c12c0mr5665527eju.7.1689407724430; Sat, 15 Jul
 2023 00:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com> <20230715010407.1751715-7-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230715010407.1751715-7-fabrizio.castro.jz@renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 15 Jul 2023 10:54:48 +0300
Message-ID: <CAHp75VdyUhvk9JA4oW6iYjK=YdatjG3OVa0APMQrc+un2EyadQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] spi: rzv2m-csi: Squash timing settings into one statement
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
> Register CLKSEL hosts the configuration for both clock polarity
> and data phase, and both values can be set in one write operation.
>
> Squash the clock polarity and data phase register writes into
> one statement, for efficiency.

...

>         /* Setup clock polarity and phase timing */
> -       rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_CKP,
> -                               !(spi->mode & SPI_CPOL));
> -       rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_DAP,
> -                               !(spi->mode & SPI_CPHA));
> +       rzv2m_csi_reg_write_bit(csi, CSI_CLKSEL, CSI_CLKSEL_MODE,
> +                               ~spi->mode & SPI_MODE_X_MASK);

I think this now regresses due to the absence of parentheses.

--=20
With Best Regards,
Andy Shevchenko
