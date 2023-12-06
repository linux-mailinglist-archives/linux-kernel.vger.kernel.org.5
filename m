Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BCC8076E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379742AbjLFRqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjLFRqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:46:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691BDD4B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:46:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026DFC433C8;
        Wed,  6 Dec 2023 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701884768;
        bh=f2thWcW62IXUOrbPqO5jq+mUatO667MclBvkg0ftvMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DFqQOeDxOragNgCWaFB6fa/ZCUeDo5jmoU1N3o+euH/x/dJRnbGN2Dh947WoRMkcs
         /8vTxrMuMnU1i0jggbiaweErVewwBVFafutVmrUkeGA79VysLZHGTCqqUwZSand9Id
         P286oQYjgY9ncbftP7gKexfXpcyozXEK501VzUGOXW8GGSOgMTrcLziO1Tpk1jqieM
         wYVgyZl83Rvd38DSfChLMVXpet5nxAyRnU+DZ5uwNFjwDl2NbCZ2ZrloMIvObrhEzp
         PstIjHRDwzbwlpmj+NcnMZBMO7kVyN5imz2VUVNOrVh+l8aEqjQpOnMldvYYKDcBYW
         qCKNGvsZ/5pLg==
Date:   Wed, 6 Dec 2023 17:45:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petre Rodan <petre.rodan@subdimension.ro>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v7 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series
Message-ID: <20231206174558.27f72d37@jic23-huawei>
In-Reply-To: <ZW4_OoyKSZ3EBL2x@smile.fi.intel.com>
References: <20231204194401.20891-1-petre.rodan@subdimension.ro>
        <20231204194401.20891-2-petre.rodan@subdimension.ro>
        <ZW4_OoyKSZ3EBL2x@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +		ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> > +						triplet);
> > +		if (ret < 0)
> > +			return dev_err_probe(dev, -EINVAL,
> > +				"honeywell,pressure-triplet is invalid\n");  
> 
> Still you can use mentioned device property API.
> 

This is one of the rare cases where basing on iio/togreg is
sensible because you do want a feature that only exists there today.
Just state that you have done so in the cover letter.

Jonathan


> ...
> 
> > +		return dev_err_probe(dev, -EINVAL,
> > +			"pressure limits are invalid\n");  
> 
> Indentation?
> 

