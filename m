Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93DE77FCD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353804AbjHQRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353786AbjHQRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67321EE;
        Thu, 17 Aug 2023 10:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFA8361FD7;
        Thu, 17 Aug 2023 17:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7054BC433C8;
        Thu, 17 Aug 2023 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292670;
        bh=VE7jTioS63J6dT8DX8rxcZQN+MbADV02CUtWuC3SwBE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jVzjSVqs1+lTaYG6lzHndiGFfzNDhbGLuhD19D7hgl/q0qQxl1BbmFe1MaVzxp6Tm
         Hx/K5NG4Ij8QbVSYSytOxECnwBFD/SVWkQiVPow4n5TcVVo9fh6oi9g5G9d8xSIA9G
         1Vb2LoMxFcL7qdfm5kMcpi2beS6ogLEqAsYIU65anIg3D6bwuhiKERVbu38RXrkxKc
         ClUG83825XzWyvDbQZ2j1xSy8hLmJ1wio0LhVrZqjuuc6L18K5io/NAKczwTHC9k8u
         rqRUeCVqrhU09kNwPLGvxINK5Had9eADyVMGJHpo/xK2wqkh/PerOztYdXpJCG+t7z
         L0yz6JtHPsSfQ==
Received: (nullmailer pid 1614972 invoked by uid 1000);
        Thu, 17 Aug 2023 17:17:47 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Maso Huang <maso.huang@mediatek.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Trevor Wu <trevor.wu@mediatek.com>, devicetree@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20230817101338.18782-6-maso.huang@mediatek.com>
References: <20230817101338.18782-1-maso.huang@mediatek.com>
 <20230817101338.18782-6-maso.huang@mediatek.com>
Message-Id: <169229266724.1614955.5685157579196442265.robh@kernel.org>
Subject: Re: [PATCH v4 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Date:   Thu, 17 Aug 2023 12:17:47 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Aug 2023 18:13:37 +0800, Maso Huang wrote:
> Add document for mt7986 board with wm8960.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../sound/mediatek,mt7986-wm8960.yaml         | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/sound/sound-card-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.example.dtb: sound: False schema does not allow {'compatible': ['mediatek,mt7986-wm8960-sound'], 'model': ['mt7986-wm8960'], 'audio-routing': ['Headphone', 'HP_L', 'Headphone', 'HP_R', 'LINPUT1', 'AMIC', 'RINPUT1', 'AMIC'], 'platform': {'sound-dai': [[4294967295]]}, 'codec': {'sound-dai': [[4294967295]]}, '$nodename': ['sound']}
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt7986-wm8960.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mediatek,mt7986-wm8960.example.dtb: sound: Unevaluated properties are not allowed ('audio-routing', 'model' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt7986-wm8960.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230817101338.18782-6-maso.huang@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

