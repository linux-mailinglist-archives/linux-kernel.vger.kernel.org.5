Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF017CB122
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJPRMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjJPRMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:12:38 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F54F7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:12:31 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c514cbbe7eso28040321fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697476349; x=1698081149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR2mIVGSF7TnFNx625C974mkPtvhKRG+fj3NHxRdBic=;
        b=IQ38Sl4IxMh8inhRGCJyf7OgdWua/+R5OeFSIVDWGhTAZbx4CU25k9GArKVc/GH2ZA
         Tn/T3jruJAyDN/dm0i59a4VDQ7LK+evi2tKwNKbyiFHZmwXokmgI7O+5cMlnjggIuv+n
         rlItrHdA636ABz3btjFRLLCRTHlYQWKmap5+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697476349; x=1698081149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fR2mIVGSF7TnFNx625C974mkPtvhKRG+fj3NHxRdBic=;
        b=tvnV3AvIQHlamYQvdB7AeEDmkNwSR2tgnUAH5XpJoTB/qzNSLH4PbwcteLHPoEzKVr
         cd2R1i4Mkk+3/2Zq7STR63Cr0b7wxbGOcVsWCKo4m16Ooq78oo+GrBT380mU6wtQM66B
         alf7H7PP/CkhSrkRbKRyfFrXj64zUJjxgez11w4zmFont98Estxc1ENTOsP3f/dsa/XC
         s0Qb7mQ62BVz3k5+xGnrHgE38jDsSYurna6I0ubIcW+aBHJhJjwzc1BXOz/TrULd8udS
         7ykCxlTnyYckgNn5gZNxoSBhESfVzP8KN0iczUy6jSsCpVRQtaM+i5GTamvZzFOuYEIi
         mUcg==
X-Gm-Message-State: AOJu0YzErggvWZR6Ik2F8LO7yLTDTEuo67Zvhl2w7eQ0lonploinN7Xp
        ClDlR91VnlwpdartO8S1HxleSLpIPECodM7GwIR1CQ==
X-Google-Smtp-Source: AGHT+IFYEwS3GmFPfDnVyPpFl2TGjAr5jpeeRbFDZPrVa7iXPThSJ5Gw1GMmajv1hPud7RpmMQRMCt7PWljX+01yQ3A=
X-Received: by 2002:a2e:a98e:0:b0:2c5:1c4:9005 with SMTP id
 x14-20020a2ea98e000000b002c501c49005mr8458352ljq.32.1697476349608; Mon, 16
 Oct 2023 10:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230237.2676469-1-wenst@chromium.org> <20231012230237.2676469-7-wenst@chromium.org>
 <318016c7-8ceb-4c96-8784-597fac8d194b@collabora.com>
In-Reply-To: <318016c7-8ceb-4c96-8784-597fac8d194b@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 16 Oct 2023 10:12:18 -0700
Message-ID: <CAGXv+5EY_vfX+cNZ4QH++fH0uRBJ_hEK5mQpRAJbbsisXWBaNQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 2:21=E2=80=AFAM Eugen Hristev
<eugen.hristev@collabora.com> wrote:
>
> On 10/13/23 02:02, Chen-Yu Tsai wrote:
> > Tentacruel and Tentacool are MT8186 based Chromebooks based on the
> > Krabby design.
> >
> > Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
> > convertible device with touchscreen and stylus.
> >
> > Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
> > device. It does not have a touchscreen or stylus.
> >
>
> Hi Chen-Yu,
>
> The Krabby design has the touchscreen ? if the touchscreen is for
> Tentacruel ,then the touchscreen should be described in the tentacruel
> dtsi, not in the Krabby and then deleted for tentacool.

Yes. The Krabby design is the reference design and has all the bells and
whistles. Vendors can choose to drop features for their market segmenting
purposes.

In essence the vendors are taking a Google design and tweaking it to suite
their needs. Sometimes things get deleted. Deleting the node seems like
a proper way to describe it.

ChenYu

> Or is there any reason for describing the touchscreen for Krabby ?
> One additional way to solve this is to have the touchsreen as separate
> dtsi and only include it for the boards that have it, e.g. tentacruel .
> Eugen
> > The two devices both have two variants. The difference is a second
> > source touchpad controller that shares the same address as the original=
,
> > but is incompatible.
> >
> > The extra SKU IDs for the Tentacruel devices map to different sensor
> > components attached to the Embedded Controller. These are not visible
> > to the main processor.
> >
> [...]
>
