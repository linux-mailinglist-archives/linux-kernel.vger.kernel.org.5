Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7876892E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjG3WuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3WuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:50:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11FBAB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:50:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so35873081fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690757408; x=1691362208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsawj/okJxkOE6tbkBUKnS5IEaUD+sUamL8wpnfLVls=;
        b=InnBQXHHoDHKmxspkaC63IQQejVy/ScCIdtVKOGdn+5uD7xm2bfIITMu4mxiJD1tBI
         WsX1JN3Rb9yBDKjBlXSeBG1Kutt0wTiySHfPmXlWnDCSBeLBUtSR/ephO2wr5ncOxcrj
         vs1HHQ8juTzAIPCU3UXUm7m0oJdC9L484hTRovIShbYiR1/ShF1D7W9bjsDW7yLYAVbx
         cU4NuS4TWHGRoph5ZfcVmg7sDgrwzOn/Woa0MuwNjyyfYt4oGc60caWzYzx1dMOXzJK/
         NlkgvIKoh6rocA0C9yfopvJySTEb6ZKr7J/le5r23skwjP1kIC8C7SdaboegvbIrVDF0
         aFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690757408; x=1691362208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsawj/okJxkOE6tbkBUKnS5IEaUD+sUamL8wpnfLVls=;
        b=Hhv/kyg/x2ueCSl9iAk1/qdp7i6fD5lV3QxOFY74P2+OfCr/GKFeIXHtU76U+Cnevx
         nBEVv9CajRaGyOQyRX8tCke9ru0gGtsvW9KVRlubloERgrAWz5CLpmKegAg787Ax4vT8
         DoTtIZifnp0DmFTMvHdA9hiuPGibkMcD5Mz65e0aYti97wvcDREJ6fqfLDVe/hD1pTZf
         icLcWuoUU5LVA2S9vukHE8AR4eFU6WOvlI/VMnu4WQGEJq+o7aVBnh6bk6NjmoI16iE8
         15hzBv9C9xSTdcgzrNoTkS0SN/i7zxdGzKhw0cN3/H78FA8BK+sShIsahl2dfJf+F/ot
         O7cA==
X-Gm-Message-State: ABy/qLbTE2hQru0Z50f6g56jdtEff77nfPT2PFZEUUEr2eK2IOZuqcG2
        ULb4lY5rPXYKOZ5sJBXpJEo=
X-Google-Smtp-Source: APBJJlGnA+fBqb2blleyCSfYQBRRNVcNfvhhhx+6iP3+UITDNLffibjwEOcoQPuf38NuAdv3DO9PZQ==
X-Received: by 2002:a2e:7013:0:b0:2b9:5b46:2107 with SMTP id l19-20020a2e7013000000b002b95b462107mr5586086ljc.9.1690757407847;
        Sun, 30 Jul 2023 15:50:07 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id q10-20020a7bce8a000000b003fe1cac37d8sm3031955wmj.11.2023.07.30.15.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 15:50:07 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] bus: sunxi-rsb: Convert to devm_platform_ioremap_resource()
Date:   Mon, 31 Jul 2023 00:50:06 +0200
Message-ID: <3509710.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <20230706072042.31296-1-frank.li@vivo.com>
References: <20230706072042.31296-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 06. julij 2023 ob 09:20:36 CEST je Yangtao Li napisal(a):
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied, thanks!

Best regards,
Jernej


