Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E2D805338
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345245AbjLELnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345158AbjLELnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:43:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AB3C6;
        Tue,  5 Dec 2023 03:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701776597; x=1733312597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kTMmsxIwvrRFNgPLBtZ6ROY9A+n4NFUXiCrfw96ydpw=;
  b=WhTix8GJr+SA6lNoPycz2yZi8kNA4PLiIGvfXeH5tsFc54YRVTbcK16G
   u7ht0G6JQC9nEAmkmax1KX6igmvhRLTktdYl1etiLnsDzzgAiAs2DCroZ
   8MVQiyIQA7Hy7gP+uziuw7w5Ujei6gBRuQNxTeP8mfa8qnAW0yq6Ljyox
   faL4LlppVy23mhDWHBl9n3FQJkWn3EaMAuaO1HZlRbIPJ4ORAFP27TdvF
   lrMDSKPKjo++8SALPXtTkdvhjUW7KS9mq58rtU/YTnS1NbN83ffkKKGFQ
   1mmwxIE/TnE60m4XUL42j2VzoDz6n4wJbNJDvzWDqfKG+Uv5vxEdFEtJJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460370442"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="460370442"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:43:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="18936758"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:43:15 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 2504E120622;
        Tue,  5 Dec 2023 13:43:11 +0200 (EET)
Date:   Tue, 5 Dec 2023 11:43:11 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: ov8856: add missing second link
 frequency in example
Message-ID: <ZW8Mz3OWE1ELlFRC@kekkonen.localdomain>
References: <20231205084835.15871-1-krzysztof.kozlowski@linaro.org>
 <ZW8DFbz3DqthC6fU@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW8DFbz3DqthC6fU@kekkonen.localdomain>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 11:01:41AM +0000, Sakari Ailus wrote:
> Hi Krzysztof,
> 
> Thanks for the patch.
> 
> On Tue, Dec 05, 2023 at 09:48:35AM +0100, Krzysztof Kozlowski wrote:
> > Bindings and Linux driver require two link frequencies, so correct the
> > example:
> > 
> >   ov8856.example.dtb: camera@10: port:endpoint:link-frequencies:0: [360000000] is too short
> > 
> > Fixes: 066a94e28a23 ("media: dt-bindings: media: Use graph and video-interfaces schemas")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/media/i2c/ov8856.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> > index 57f5e48fd8e0..bd1a55d767e7 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> > +++ b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> > @@ -126,7 +126,7 @@ examples:
> >                  wcam_out: endpoint {
> >                      remote-endpoint = <&mipi_in_wcam>;
> >                      data-lanes = <1 2 3 4>;
> > -                    link-frequencies = /bits/ 64 <360000000>;
> > +                    link-frequencies = /bits/ 64 <360000000 180000000>;
> 
> There indeed seems to be a problem with the example as far as the bindings
> are concerned but the primary issue seems to be in the bindings. Both of
> these frequencies have significance from driver point of view only while
> the device itself supports a (wider) range.
> 
> How about removing maxItems and items from the bindings instead?

There's also a similar issue with lanes: 1, 2 and 4 are supported.

-- 
Sakari Ailus
