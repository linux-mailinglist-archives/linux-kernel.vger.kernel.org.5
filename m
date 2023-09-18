Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DACC7A46D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbjIRKWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241153AbjIRKWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:22:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB67126
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:22:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so72333931fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695032533; x=1695637333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX6Za3zyMvqmXctAk0a5Iwv/WZyf9mXODoigV6qCMRo=;
        b=ZGApVSmVoU5dsPak7V2A+WWxPOXQHT38YTpcdkRXJqP0sIe2id4VnHMT2usiMKq44u
         Iz+zyerWrb9CTjN0T+oh18hoX1kQRDLLyHGuYQEYzDvpf7/Blm7EEeOb3kQcG0JXALQL
         qPw6bTvQM/lJa3H9aTKMuMvwhtwQ7BYBhgPNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695032533; x=1695637333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX6Za3zyMvqmXctAk0a5Iwv/WZyf9mXODoigV6qCMRo=;
        b=Eh17ZOkBUwSu+S+K8XBmUeboh1DV/N8vlT+uGMJUSkkTKjLqewfZkJrYSA9E2duHzS
         V29lsPglE9bmlDU92MIVGH16ZGaWzjzhOi3WNmRFZAvbztr9ldEEDetFvWzst7HA2pnm
         /vvsBaLPogMc1EnzxoNLIXkh1IL3M8/D0/ya7g4Bn9Kamm06zw7cOGt2HarTpGLuSxqm
         XFQ28CIlDcSuD3bcSsSPeIrcfJVNVP6LsxP2X4xvYVADoZmDJ0j8KUlxTrh6TwY6R4aE
         lwJm6neB+NgVar8AZ5hYpEonHalkjYIjiOAxrnjrA3WFgmAShmFxbX04xhe5F0rDtI/H
         blyg==
X-Gm-Message-State: AOJu0YzwnYJdhiaqLpet6b4vnSqc7AyGfXB+PcJHGIk0Y0IBIum6RHdG
        ALyHaNQEoBHXAXxu0G3JuhciJY4bAGA+6NO83P3oKA==
X-Google-Smtp-Source: AGHT+IGrOZ01cn2qw0qI6mUsa0BPS8suIqLpCLQSaooT4447KAkiTjntIXrQMcMfujDWXRNpeNDPG7ExNaXoGbZJW2E=
X-Received: by 2002:a05:6512:1115:b0:4fb:9f93:365f with SMTP id
 l21-20020a056512111500b004fb9f93365fmr8180795lfg.38.1695032532962; Mon, 18
 Sep 2023 03:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230822084520.564937-1-wenst@chromium.org> <20230822084520.564937-3-wenst@chromium.org>
 <7f743fba-6cba-cce0-d499-0a9d95e3b026@collabora.com>
In-Reply-To: <7f743fba-6cba-cce0-d499-0a9d95e3b026@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 18 Sep 2023 18:22:01 +0800
Message-ID: <CAGXv+5FgGtpY697e9-Dnk=1Ro0dM7C6qmtdXkWHb5EtocU+t_w@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] mfd: mt6358: Add registers for MT6366 specific regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 4:55=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 22/08/23 10:45, Chen-Yu Tsai ha scritto:
> > The MT6366 PMIC, compared to the MT6358, does away with the VCAM*
> > regulators. Two regulators VM18 and VMDDR reuse their register space.
> > There's also a VSRAM type regulator VSRAM_CORE thats' split between
> > the VCAM* register space and other parts.
> >
> > Add register address macros for these MT6366 specific regulators.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> For ease of applying to MFD, I think it's ok to have the header changes s=
plit
> from the actual user; so:

Actually that doesn't help, because this is a compile time dependency.
Merging this through the MFD tree and the rest through the regulator
tree would mean either creating an immutable branch, or Lee giving an
ack for this patch to go through the regulator tree. We would be doing
the latter if we squashed the patches together anyway. I think squashing
them does make sense.

ChenYu

> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
> Cheers!
>
> > ---
> >   include/linux/mfd/mt6358/registers.h | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >
> > diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/m=
t6358/registers.h
> > index 5ea2590be710..d83e87298ac4 100644
> > --- a/include/linux/mfd/mt6358/registers.h
> > +++ b/include/linux/mfd/mt6358/registers.h
> > @@ -294,4 +294,21 @@
> >   #define MT6358_AUD_TOP_INT_CON0               0x2228
> >   #define MT6358_AUD_TOP_INT_STATUS0            0x2234
> >
> > +/*
> > + * MT6366 has no VCAM*, but has other regulators in its place. The nam=
es
> > + * keep the MT6358 prefix for ease of use in the regulator driver.
> > + */
> > +#define MT6358_LDO_VSRAM_CON5                 0x1bf8
> > +#define MT6358_LDO_VM18_CON0                  MT6358_LDO_VCAMA1_CON0
> > +#define MT6358_LDO_VM18_CON1                  MT6358_LDO_VCAMA1_CON1
> > +#define MT6358_LDO_VM18_CON2                  MT6358_LDO_VCAMA1_CON2
> > +#define MT6358_LDO_VMDDR_CON0                 MT6358_LDO_VCAMA2_CON0
> > +#define MT6358_LDO_VMDDR_CON1                 MT6358_LDO_VCAMA2_CON1
> > +#define MT6358_LDO_VMDDR_CON2                 MT6358_LDO_VCAMA2_CON2
> > +#define MT6358_LDO_VSRAM_CORE_CON0            MT6358_LDO_VCAMD_CON0
> > +#define MT6358_LDO_VSRAM_CORE_DBG0            0x1cb6
> > +#define MT6358_LDO_VSRAM_CORE_DBG1            0x1cb8
> > +#define MT6358_VM18_ANA_CON0                  MT6358_VCAMA1_ANA_CON0
> > +#define MT6358_VMDDR_ANA_CON0                 MT6358_VCAMD_ANA_CON0
> > +
> >   #endif /* __MFD_MT6358_REGISTERS_H__ */
>
