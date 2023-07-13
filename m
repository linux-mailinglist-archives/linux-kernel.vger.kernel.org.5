Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B54751941
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjGMHCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjGMHCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:02:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462E119
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:02:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so2542575e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689231764; x=1691823764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZKzT2kI7SIV/QlPNIp1G2EP8hGYRMtFnfbahsaDWDUE=;
        b=XzJxCDPeCBeNU9TtYRp94TiYADkV2OYaCse3bYTJBpV0rkv79PK3On7EmYetF9Xvme
         3Ywr1pclyxAVxL2vF77/EVwhIWsFXJoJSYDY1Cj1FLmNSaf+1QXOAJffUOpR+VjFl16+
         ZQg2kLNnbHOf64w2fJAsDJTHmCQvfpe7d5fpiEx8UugPHk89wD7Oru6u8ouHF0KpQ7ln
         BwqLXAxawY8FvA44xQ+21UXVzFK8I79DCdUyw2ZnfF8fHFE1Lh6pFqW8ykTIWbsLFlr4
         pS1xHSyjGi/ckVX5bM3obZ+kvBfSmb1R8iL8qwVjihKLBCfrLBubIkMBaIh9dVzPlhGD
         OQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689231764; x=1691823764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKzT2kI7SIV/QlPNIp1G2EP8hGYRMtFnfbahsaDWDUE=;
        b=X8t7o8O1VbrrKqbVONxr6EQX1B3B2KCK0ZZadr9eFHa6keZ9s/AGTbwYBvOwWyvLMn
         S7LeXI0Ceug6clNpXiD5qn5vLkBLoA+uww104ds4BN1rqn3QBTptz39OM/JuaU///Te4
         la+ngGYuKJ5dOn0PGelfRtxYzKwfGuklRYCGMiHwxD4Ghwu6eB3cctPnRPStZMxl30RW
         Ykmke2Ytta2awCFunltKD6Dk7opFswPMbhu6wiAu1i694oYmEItf9GoNjHGtOJOc8rxX
         AISv8mL256+O4XwwyyxWOwdV9DCoTMB1wIaPnODEJjtPrXWzoB4a9UVdFWSeO3NOKcsu
         y8XA==
X-Gm-Message-State: ABy/qLasYqOaUrULKwNpDHyzrzWq2zeIOD/2zKN8nl07ZK4ttUi/aGWe
        E6hDaCX1K9ns6rs7DQk7i2k=
X-Google-Smtp-Source: APBJJlFI1CKO7moqPVrN3fPhKLcSmvKXDNhUtwhEE+dv5Xyb7RMfYTV6PVqcY+FuWkj/ClgDutsTow==
X-Received: by 2002:a7b:cc8c:0:b0:3f7:2a1d:1b05 with SMTP id p12-20020a7bcc8c000000b003f72a1d1b05mr595990wma.14.1689231763664;
        Thu, 13 Jul 2023 00:02:43 -0700 (PDT)
Received: from ?IPv6:2001:a61:35be:1401:2331:c532:1717:d48c? ([2001:a61:35be:1401:2331:c532:1717:d48c])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d4e04000000b00313de682eb3sm6998459wrt.65.2023.07.13.00.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 00:02:43 -0700 (PDT)
Message-ID: <4d04ca21b4c9768a59be1341ac62fcae54027b8f.camel@gmail.com>
Subject: Re: [PATCH 00/10] ASoC: ad: Update Analog Devices drivers to maple
 tree register cache
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Jul 2023 09:02:42 +0200
In-Reply-To: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
References: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-13 at 00:13 +0100, Mark Brown wrote:
> The maple tree register cache has now got to feature parity with the
> rbtree cache, there are some different tradeoffs made and it should be a
> better choice for most modern systems.=C2=A0 Convert the Analog Devices
> drivers to use the more modern data structure.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> Mark Brown (10):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASoC: ad1836: Update to use maple tree reg=
ister cache
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASoC: ad1980: Update to use maple tree reg=
ister cache
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASoC: adau1372: Update to use maple tree r=
egister cache
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASoC: adau1373: Update to use maple tree r=
egister cache
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASoC: adau1701: Update to use maple tree r=
egister cache
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASoC: adau1761: Update to use maple tree r=
egister cache
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASoC: adau1781: Update to use maple tree r=
egister cache
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASoC: adau1977: Update to use maple tree r=
egister cache
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASoC: adau7118: Update to use maple tree r=
egister cache
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASoC: adav80x: Update to use maple tree re=
gister cache
>=20
> =C2=A0sound/soc/codecs/ad1836.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +=
-
> =C2=A0sound/soc/codecs/ad1980.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +=
-
> =C2=A0sound/soc/codecs/adau1372.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0sound/soc/codecs/adau1373.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0sound/soc/codecs/adau1701.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0sound/soc/codecs/adau1761.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0sound/soc/codecs/adau1781.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0sound/soc/codecs/adau1977.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0sound/soc/codecs/adau7118-i2c.c | 2 +-
> =C2=A0sound/soc/codecs/adav80x.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A010 files changed, 10 insertions(+), 10 deletions(-)
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230701-asoc-ad-maple-170068cf0c39
>=20
> Best regards,

