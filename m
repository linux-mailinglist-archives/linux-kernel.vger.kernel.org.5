Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189C47B51C8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbjJBLzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjJBLzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:55:15 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8E7D3;
        Mon,  2 Oct 2023 04:55:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D7EAC0007;
        Mon,  2 Oct 2023 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696247707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZauemzlB2GLs7I7VeZeMr7YTRfLhZitHrMbmBgYpBFo=;
        b=Y+TMpJzrSEayNtrQ1/UBUfMpH1c7s5l736WL9S3/lFbOXcx0BTUCPb/erG9k+osScJSt0y
        2tbeBT7/SGnbvouwlGDLERC25y4ZcvayWFzdg/+PfokEDbKflSRhLVWeR40woW8xPlw8Ox
        8YG1Fvh6sY+27HWsp2z15RKmQUl5kLV9dzDDPUB0zbgmVCPFeznmRQGhJQOZ2xTSYzAjGe
        NoJzak3j4Py4dzMatBXdC8yNKY3MdQrC208MwQiapP6gCOc8Tx0NARPrBEWIeXgMu71pdE
        KxUkEfL+NLoKzt+j+Ski75iX7InerKkxpp5uKvWbQdzBuBTRaaRAlf+3yYfmTA==
Date:   Mon, 2 Oct 2023 13:54:58 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v7 25/30] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
Message-ID: <20231002135458.420f6ae4@bootlin.com>
In-Reply-To: <202309291924.OBfdyhXb-lkp@intel.com>
References: <20230928070652.330429-26-herve.codina@bootlin.com>
        <202309291924.OBfdyhXb-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, all,

On Fri, 29 Sep 2023 20:04:44 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Herve,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.6-rc3 next-20230929]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Herve-Codina/soc-fsl-cpm1-tsa-Fix-__iomem-addresses-declaration/20230928-151746
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20230928070652.330429-26-herve.codina%40bootlin.com
> patch subject: [PATCH v7 25/30] dt-bindings: net: Add the Lantiq PEF2256 E1/T1/J1 framer
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230929/202309291924.OBfdyhXb-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309291924.OBfdyhXb-lkp@intel.com/
> 
> dtcheck warnings: (new ones prefixed by >>)
> >> Documentation/devicetree/bindings/net/lantiq,pef2256.yaml: properties:lantiq,data-rate-bps: 'oneOf' conditional failed, one must be fixed:  
>    	'type' is a required property
>    		hint: A vendor boolean property can use "type: boolean"
>    	Additional properties are not allowed ('default', 'enum' were unexpected)
>    		hint: A vendor boolean property can use "type: boolean"
>    	Additional properties are not allowed ('default' was unexpected)
>    		hint: A vendor string property with exact values has an implicit type
> >> 	Documentation/devicetree/bindings/net/lantiq,pef2256.yaml: properties:lantiq,data-rate-bps: 'oneOf' conditional failed, one must be fixed:  
>    		'$ref' is a required property
>    		'allOf' is a required property
>    		hint: A vendor property needs a $ref to types.yaml
>    		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>    	2048000 is not of type 'string'
>    		hint: A vendor string property with exact values has an implicit type
>    	4096000 is not of type 'string'
>    		hint: A vendor string property with exact values has an implicit type
>    	8192000 is not of type 'string'
>    		hint: A vendor string property with exact values has an implicit type
> 

This issue is related to '-bps' standard suffix not yet available in the
dt-schema release.
The commit adding '-pbs' suffix is
  commit 033d0b1 ("Add '-bps' as a standard unit suffix for bits per second")
present in https://github.com/devicetree-org/dt-schema/

This point was previously discussed with Rob [1] and mentioned in the cover
letter of the series.

[1]: https://lore.kernel.org/linux-kernel/CAL_JsqJTruTExc=uHCPCp3q-fo+fB-wAJ-ggPpHpWcHSoGALdw@mail.gmail.com/

Best regards,
Hervé

