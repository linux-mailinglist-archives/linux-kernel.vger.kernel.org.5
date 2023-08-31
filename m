Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FEF78F1F1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbjHaRaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjHaRaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:30:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE916E7A;
        Thu, 31 Aug 2023 10:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 35A87CE216A;
        Thu, 31 Aug 2023 17:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD63C433C7;
        Thu, 31 Aug 2023 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693502994;
        bh=057dXhBltFNY+YXutamWEKDOENY+dS9838PYVA3CeIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAg2oRB2Hz4CCaDGqT+FpM5RsRuIyfObS5GYwv4qsjQsEN+HmzbDaTxJnvFpStRRd
         b00tiO7VLBSRyilW0ijkSUxyBAa2sxb+FML2eTBhG35GFsAA7qf1hQtb5f+8vVKixa
         yPAriWirIlFos9iq7I9p40aG0ObfpRrBETt185Z4c7+nye4Pl0kmDrhh4cl/A3sHh/
         uIFwdmugmKkajgnRbu5f8yhjugaVMRr/Dg4NVmbzdayh5+tdFBYE/vs+XrMoncl889
         BE5JBZn6DL45yNp3NIxH2AkFPcQseeitRtr7OnBCFYW3vK3UyAMTlZlPQsHU/n6nfz
         2nYRKMW8Jas6Q==
Received: (nullmailer pid 2472823 invoked by uid 1000);
        Thu, 31 Aug 2023 17:29:51 -0000
Date:   Thu, 31 Aug 2023 12:29:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     alsa-devel@alsa-project.org, andersson@kernel.org,
        quic_plai@quicinc.com, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        perex@perex.cz, bgoswami@quicinc.com, devicetree@vger.kernel.org,
        tiwai@suse.com, linux-kernel@vger.kernel.org, agross@kernel.org,
        lgirdwood@gmail.com, srinivas.kandagatla@linaro.org,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v5 24/32] ASoC: dt-bindings: Update example for enabling
 USB offload on SM8250
Message-ID: <169350299098.2472764.11068604113616998755.robh@kernel.org>
References: <20230829210657.9904-1-quic_wcheng@quicinc.com>
 <20230829210657.9904-25-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829210657.9904-25-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Aug 2023 14:06:49 -0700, Wesley Cheng wrote:
> Add an example on enabling of USB offload for the Q6DSP.  The routing can
> be done by the mixer, which can pass the multimedia stream to the USB
> backend.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../devicetree/bindings/sound/qcom,sm8250.yaml    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

