Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA677ACECB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjIYDxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIYDxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:53:19 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C094DDF;
        Sun, 24 Sep 2023 20:53:12 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7741bffd123so306816185a.0;
        Sun, 24 Sep 2023 20:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695613992; x=1696218792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=946SNZdxXTqdOgduwOZbKLZViiZKQpmP4Kz81FU/byI=;
        b=h2JlHY2kLruzWWVqS6sLAGRlTSdqRBkmpdm75Upo1yoKtAL/xE9PrCxHX4EY5Y6B5a
         GRn8nEr2R1iveJOnxCKGuXfbc/CblouFZp5C9k6B7bfAm7ro+X1ViUu86cc0LItu0kMG
         Ee6sYdP9nY9wK67NTh8R341+dYVz6SigjOILZ38XWoxs5dzkZ5PGgeko9XAtHuj0Rj9X
         8zewoWxdVLscc2+Psm5HF5TMNgUsi1/8cI7LUBN9PoKqplKgyIk3YxTv8DYGI35Un3ds
         /gQfCHEYVri0zg5x7p/CPd2LCDGmIblYLd27wDr2EeXU/RY4pentsVF3UMnmdiQgDM8/
         cfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695613992; x=1696218792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=946SNZdxXTqdOgduwOZbKLZViiZKQpmP4Kz81FU/byI=;
        b=isJ+mMFj7KyxchqmBgQBVEMjPNmbzLRJU5Zzm5aUJrwjjSihRf6DkBUeL0dr8Q0ttR
         4oo9rw1lKpd+jL/OOcn5VLZTyA03hgdSoNU4qw9mzcaGWPCGkeaG/92MViQ23MVO3Sgw
         /aiu1zG3mRwnhTlp5EvBeeGS99IarnxsAS3WFDHJZl9FUPOBU6zRe/kYw5JnRCN7PjT8
         uCKqGjE/NEiraGlobtObcSpzjw/OO7AtkelMguSgbrf4G0bigFb7GQPL3co5ZRp0uW55
         B5cRj7Z4cQXwI6Wxg1Y9mkrte9gzvjZnO8pYVfYDu4qwZs4F3lRJ8ul821zkkEpa0Ltq
         lhuA==
X-Gm-Message-State: AOJu0Yx3keDZve9CmHmLGRAlB93ZzXgpwH/2ZQiBbsZhEUFkmPqjFBq8
        6Oj3CUqIczc6P9xDwQKq5Ql/zALXT7vEYj3Tsew=
X-Google-Smtp-Source: AGHT+IH880SzUV+0+eH2log+gpotQMt+RpnHf6iOAzehb5kO1SF6wrdx2gry+Mz4hWxydirQk+iiW/0gjvkuBm5xC2w=
X-Received: by 2002:a05:622a:1487:b0:412:24e6:a492 with SMTP id
 t7-20020a05622a148700b0041224e6a492mr8170882qtx.60.1695613991895; Sun, 24 Sep
 2023 20:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230924044800.2199524-1-james.hilliard1@gmail.com> <20230925035036.GL7231@dragon>
In-Reply-To: <20230925035036.GL7231@dragon>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Sun, 24 Sep 2023 21:52:59 -0600
Message-ID: <CADvTj4oz6oJ_ifLO83JhaAnjmbLM=hTPmFG4S3h_TBnUeZrC=Q@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with
 Custom Board
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 9:50=E2=80=AFPM Shawn Guo <shawnguo@kernel.org> wro=
te:
>
> On Sat, Sep 23, 2023 at 10:47:55PM -0600, James Hilliard wrote:
> > Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.
> >
> > Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> So what's been changed between v9 and v10?

I had forgotten to add uart3/pinctrl_uart3 in this patch:
https://lore.kernel.org/all/20230924044800.2199524-3-james.hilliard1@gmail.=
com/

>
> Shawn
