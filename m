Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12947FD8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjK2Nz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjK2NzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:55:25 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1903E8F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:55:31 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cc55b82ee5so64414167b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701266130; x=1701870930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpuvInZNM8fsmU2z2sR/CbG3xzQL+n8KAjtla2xbn9g=;
        b=n9pmanAn3VcMVLpHtiz8w2WEwoGauHHU6YYMpiv+myIEONBQiYaZVIuQQkZtGMUpch
         6qPv32PnfNsYFEUOi1rg2L89Y7WvP+erDqFAmI+xV/kpaMAMVtslNHhHpTOU40unYScB
         bt/gWxK9c+GQHkpGRfjoLLpQHcXp5aFdQtDMQ81TPq4JzklpoYv6QQFh8LVwwBg9qerM
         LmSmbCCP13fjgK6B9VU9WG7P8me/qvrTNw5Zjcsx5131bB49T+P2Q3+ZJ3EPmeiyQ5zx
         6Q78sV4wfSrh6FwgJ35CYZKGFGy8Ydm3n7xTU/8mTxzVHAKSVZkCYJvzzapNfgdEeEpK
         Y5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701266130; x=1701870930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpuvInZNM8fsmU2z2sR/CbG3xzQL+n8KAjtla2xbn9g=;
        b=LuQ9b8vqOHomffuZtq33J5+HTeeqZAjFBuNo06c3l2cxba9UL1Q15kxPFDpINUxpGU
         tdrAhtiIae0e3fOMLGWprtXkWHyRbUJn962UFJGkTr952LoapM78uOVFL0v8V/pB6Qdy
         rbPFR25OxjWaw5udFRw+1Hc55KvzK2wiP79tVq2sMnfRv6yjdKq/ULTp+6VHB2AlYXLR
         ZqKmi1b5ddFYkdgQBSjo7vpnZtsItKJ0T4ub6aV+PYC96ZEHVqDLDpr5Go0LmhonEWEY
         M/2gg7NlZnSDXYMp/X+zRzyv8sIjstuiOIxfP9gRezJkRirqKE4Vk53Ou916pWBRGlOP
         5pSQ==
X-Gm-Message-State: AOJu0YyO0E3XpwyPcmq/EUx4nzcYIBmG/KFeDVDJTivcJccWIKroXIkL
        P0E+kzRCv9UipGCliqsCGJyzUHuQjpmCNhiU2yB9uA==
X-Google-Smtp-Source: AGHT+IGwu2YvBMSoYaFGrNKixDYgQXfobVbXlj1+WiRWKYV83ej5z8x/5rqafA1r99kgas/9POeBW2+CPHD4zJcuBkA=
X-Received: by 2002:a81:ac5b:0:b0:5d0:b0e7:929e with SMTP id
 z27-20020a81ac5b000000b005d0b0e7929emr8950952ywj.42.1701266130305; Wed, 29
 Nov 2023 05:55:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701264413.git.namcao@linutronix.de> <361901574eec1271c0969edba6492d3f2132fade.1701264413.git.namcao@linutronix.de>
In-Reply-To: <361901574eec1271c0969edba6492d3f2132fade.1701264413.git.namcao@linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Nov 2023 14:55:18 +0100
Message-ID: <CACRpkdZYZUP9rnXbqO1BaHe_e5R8m30sYuPmfhj=VcDS-drZjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: introduce SPI_TRANS_FAIL_IO for error reporting
To:     Nam Cao <namcao@linutronix.de>
Cc:     broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 2:32=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:

> The default message transfer implementation - spi_transfer_one_message -
> invokes the specific device driver's transfer_one(), then waits for
> completion. However, there is no mechanism for the device driver to
> report failure in the middle of the transfer.
>
> Introduce SPI_TRANS_FAIL_IO for drivers to report transfer failure.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

This looks useful to me
Acked-by: Linus Walleij <linus.walleij@linaro.org>

>  #define SPI_TRANS_FAIL_NO_START        BIT(0)
> +#define SPI_TRANS_FAIL_IO      BIT(1)

Is it obvious from context when these flags get set?
from transfer_one() and in which flag field?

Otherwise maybe we should add a comment.

Yours,
Linus Walleij
