Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30832782F64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjHUR23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjHUR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE19100;
        Mon, 21 Aug 2023 10:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F8976401F;
        Mon, 21 Aug 2023 17:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F004C433CB;
        Mon, 21 Aug 2023 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692638905;
        bh=/OeoYkugHikEXBo3UPlpwpyhdjMMUxLjzSOtgPsd+zc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T5gKJNFko/fwhBG5KAYl6wuxIe0lvCu8rK+hZYcTjh9PxEm0L401M+SN6/cKlbPN4
         ZvCndoharQ4JgSkghtGxx+Jz/fApp2E1IyXqQGO6PadYPQ25MKfW2MzSfb5Y7w4UYJ
         kt1fDY1LLMYBR3yPTZb4UCaqE1VQknSE10z5P4bTdeY+mMgUNfz6cIHnb84QXbbMZK
         Ye2KjI4f4/H7CTVcvbl5PBt5iSh86ZcigvXNGkMz+2lC8EjY00BbVBC2CPRnIuTHJt
         9DA4PoFuK2qxWB3UcGZbKY9jhG+N9VfWfxI1jWcXP21rs5rbsdsaO9VukCGIhOWx6M
         HP2h/pNXszUaw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2bc63e0d8cdso31888941fa.2;
        Mon, 21 Aug 2023 10:28:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YxNkQd0tCKPhroZZudislOj8CpYa5ng5Bfj3b2ki4VxPD/TKBtC
        iEH60c1p92K6Vs81AuapzCE+ktHX65Q7+fHZ4Q==
X-Google-Smtp-Source: AGHT+IE9WHY5/4ZLeXyRg8ekKTg9MDXk/M9DCc70jbzBrdfs7y40dPmzepVfUeIl0nhiPLCX0OQa41eCDrd9inLXXEA=
X-Received: by 2002:a05:651c:101:b0:2b6:d89e:74e2 with SMTP id
 a1-20020a05651c010100b002b6d89e74e2mr4645401ljb.7.1692638903558; Mon, 21 Aug
 2023 10:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230810224930.3216717-1-contact@jookia.org> <20230810224930.3216717-4-contact@jookia.org>
 <ZNY+x/R8/T5ysPhy@finisterre.sirena.org.uk> <ZNZFB2-kBrpnMSn1@titan>
 <a7db4653-cb12-4f90-891c-5cf7270598bd@sirena.org.uk> <ZNqgKW3TZBVF8ggo@titan>
In-Reply-To: <ZNqgKW3TZBVF8ggo@titan>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Aug 2023 12:28:11 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+S2p2DarZ=kzxvsb8EPPHHFCOJ9F79Wm-LAQP14=Y97A@mail.gmail.com>
Message-ID: <CAL_Jsq+S2p2DarZ=kzxvsb8EPPHHFCOJ9F79Wm-LAQP14=Y97A@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: wlf,wm8782: Add max-rate property
To:     John Watts <contact@jookia.org>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 4:45=E2=80=AFPM John Watts <contact@jookia.org> wro=
te:
>
> On Mon, Aug 14, 2023 at 07:27:04PM +0100, Mark Brown wrote:
> > You'd have to define an enum for that but it does still feel like it
> > might be easier to work with since it's more direct.
>
> Alright, I'll give it a go in the next version. Thanks for the feedback!

That property will need a vendor prefix as well which was missing here.

Rob
