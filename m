Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E7775FA02
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjGXOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGXOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:38:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BDD1A1;
        Mon, 24 Jul 2023 07:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74FB0611AD;
        Mon, 24 Jul 2023 14:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A3BC433C9;
        Mon, 24 Jul 2023 14:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690209508;
        bh=q5XSmErCVSZxyDmcAFCkhWahZ0qklghV8X9OwziX6tY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hN+++GJpYAuwQ2ni6SN01594EvsSbS2eKPy2ZLIHAWrQtA9r7gGCHL3GNfeUOnowP
         Q0pvhNdjyGJjblSdVsglbRahuJxMeh1HyP0cTZJPhGWtSaTTUEN9k60clAQlrKM/a1
         UhYp1iXMUmIZ8ZNQjCo4k0u26tdoLS5fRjGyoGvWhilNc65NxbFryrR3T6dLmldAwL
         rEx6DXQJjmSio8l3H6mlTt9XnG7K85oyTRofm6m69wfzKb3Jyyz+prtsGd1XQtndqY
         +E3BV2+PkZUXnHxmoo/sTCgNjnbMqDwRd7sOAELhNp51Kq5U9Eyi1tDSRXd8N8LuGo
         cmg7xSiLsXTxA==
Received: (nullmailer pid 3442213 invoked by uid 1000);
        Mon, 24 Jul 2023 14:38:26 -0000
Date:   Mon, 24 Jul 2023 08:38:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "avifishman70@gmail.com" <avifishman70@gmail.com>,
        "Fair, Benjamin" <benjaminfair@google.com>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>,
        "yuenn@google.com" <yuenn@google.com>,
        "venture@google.com" <venture@google.com>,
        "warp5tw@gmail.com" <warp5tw@gmail.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: Add bindings for peci-npcm
Message-ID: <20230724143826.GA3433528-robh@kernel.org>
References: <20230719220853.1029316-1-iwona.winiarska@intel.com>
 <20230719220853.1029316-2-iwona.winiarska@intel.com>
 <69fa21b4-3197-d5f1-f300-d070cf5e7fda@linaro.org>
 <6ce71c01371aefa818375d6e07b3efb8e747c86a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce71c01371aefa818375d6e07b3efb8e747c86a.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 08:03:28AM +0000, Winiarska, Iwona wrote:
> On Thu, 2023-07-20 at 08:18 +0200, Krzysztof Kozlowski wrote:
> > On 20/07/2023 00:08, Iwona Winiarska wrote:
> > > From: Tomer Maimon <tmaimon77@gmail.com>
> > > 
> > > Add device tree bindings for the peci-npcm controller driver.
> > > 
> > > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > > Signed-off-by: Tyrone Ting <warp5tw@gmail.com>
> > > Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > > Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> > > ---
> > 
> > No changes from previous versions? Nothing improved?
> 
> This is the first submission.

13th by my count.

https://lore.kernel.org/all/20230616193450.413366-2-iwona.winiarska@intel.com/
https://lore.kernel.org/all/20191211194624.2872-8-jae.hyun.yoo@linux.intel.com/
