Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5388A7FEE46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbjK3Lxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3Lxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:53:38 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF7284;
        Thu, 30 Nov 2023 03:53:45 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id DA9C66034B;
        Thu, 30 Nov 2023 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701345222;
        bh=reCd9s72ev7gdvAogNCY6NtLVEoSrppdrQfr7HgLR98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LttCqIzTNM2ZlP7EJibwLD7sLpbs6h9dxvlzMab6XrA00laGOCEXOtSCZ/s99BoqN
         VuI6vQI14PRVaTdg8hcs4x4kSRM6ZOGdZMi2DZlGWyCRDdYldcZr1+SXDWHWEHuhJG
         t82k/bzWL5te0n4/pS136Ca525PPWiZwEPN0IQpltRSiNe32V6VaTZiA4nPRMHeL2u
         IHcHRQ1c1JytJAeC80bIyGFCHL7Ab84GMIqWZRkS9pFgA+TrDtUWDfzIz4/JLDHrrj
         8Ctvut2LRLbPtNTAuI/AAZ2mpj7gKzC0L4pZJQyZEqZwD02yL4YPQnTr2QIpMt2TZw
         u344fBIgY+GlA==
Date:   Thu, 30 Nov 2023 13:53:20 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: dra7: Fix DRA7 L3 NoC node register size
Message-ID: <20231130115320.GA5169@atomide.com>
References: <20231113181604.546444-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113181604.546444-1-afd@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Davis <afd@ti.com> [231113 20:16]:
> This node can access any part of the L3 configuration registers space,
> including CLK1 and CLK2 which are 0x800000 offset. Restore this area
> size to include these areas.

Applying into fixes thanks.

Tony
