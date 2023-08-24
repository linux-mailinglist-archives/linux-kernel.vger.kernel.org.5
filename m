Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACFA78767D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbjHXRQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 13:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242236AbjHXRQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030A619B0;
        Thu, 24 Aug 2023 10:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9606761B11;
        Thu, 24 Aug 2023 17:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3475FC433C7;
        Thu, 24 Aug 2023 17:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692897408;
        bh=UulZEWglMRPoeuRzmNm1VVsIcGoEPxngUS2/IJ9FdHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loVk2sZZ/EBAK2Q48rT1nWmOe0iBCJHJetDxQ96YLMkWHj9QjrF5bpJznQ2GOKSX+
         eXgB708ZZ8B/Jf46TT3uXYDjQXgddCS3WpHOcM8Y0uVgW3Z6Av+mEmKK5dKI0uRfZM
         waOJvBzFwjDiE7ywptFyjUyydBD3tOKEolFZ331wwHHx4zyNbMgqrtXz8mGUeidsqY
         yGiFNDfgKU9mJImx9T3SLZsgJBoRdZZGIQ42Vah3Ls83y7eXDGtuwdhg7Ck5Uk/VtS
         DDtRk8MELf9CT3ynndyyupB5VgEhuvkLi+8mQV8N8JJ4dRUcfv6scmSMDm+qBIamtv
         nrpFmO3eqwsfQ==
Received: (nullmailer pid 1060950 invoked by uid 1000);
        Thu, 24 Aug 2023 17:16:45 -0000
Date:   Thu, 24 Aug 2023 12:16:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        nm@ti.com, linux-arm-kernel@lists.infradead.org, srk@ti.com,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v7 2/5] dt-bindings: net: Add IEP property in ICSSG
Message-ID: <169289740438.1060890.15375299458670602935.robh@kernel.org>
References: <20230824114618.877730-1-danishanwar@ti.com>
 <20230824114618.877730-3-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824114618.877730-3-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Aug 2023 17:16:15 +0530, MD Danish Anwar wrote:
> Add IEP property in ICSSG hardware DT binding document.
> ICSSG uses IEP (Industrial Ethernet Peripheral) to support timestamping
> of ethernet packets, PTP and PPS.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../devicetree/bindings/net/ti,icssg-prueth.yaml         | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

