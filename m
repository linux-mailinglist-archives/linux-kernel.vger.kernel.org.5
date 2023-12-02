Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFEA801DA8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjLBQGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:06:21 -0500
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3899D;
        Sat,  2 Dec 2023 08:06:27 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id C714028EE6F;
        Sat,  2 Dec 2023 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1701533186;
        bh=c3izzflbnvnQn9mjCeWPVgU2PPYA3ayk9O3r2CAxXv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ehks+CGbwv0HvlAuZ+sK1gITTW0vqSbQgBld22yXaTw+YjPb5kPz+p3Tfftalwv8s
         0I+EALbISNyjTrK4GX2du0dV0o1BLwcFf7Hk1IMPoIlQ1u4en9GfWhrBhTIBo5rio5
         cDjUuSNPCKylXqnLAKrFZ6JhAW6ke09bwgajsOHI=
Date:   Sat, 2 Dec 2023 18:06:24 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v6 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZWtWAPcJTNrD9wgv@sunspire>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
 <20231129170425.3562-2-petre.rodan@subdimension.ro>
 <ZWdzz7VzCW5ctend@smile.fi.intel.com>
 <ZWeNNMfqKquDYI9X@sunspire>
 <ZWiPDlNJCbUAtIy8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWiPDlNJCbUAtIy8@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hello,

On Thu, Nov 30, 2023 at 03:33:02PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 29, 2023 at 09:12:52PM +0200, Petre Rodan wrote:
> > On Wed, Nov 29, 2023 at 07:24:31PM +0200, Andy Shevchenko wrote:
> > 
> > 437:  ret = device_property_read_string(dev, "honeywell,pressure-triplet",
> > 					&triplet);
> > [..]
> > 455:	ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> > 						triplet);
> > 		if (ret < 0)
> > 			return dev_err_probe(dev, -EINVAL,
> > 				"honeywell,pressure-triplet is invalid\n");
> > 
> > 		hsc->pmin = hsc_range_config[ret].pmin;
> > 		hsc->pmax = hsc_range_config[ret].pmax;
> > 
> > triplet is got via device_property_read_string(), is there some other property
> > function I should be using?
> 
> I think I mentioned that API, but for your convenience
> device_property_match_property_string().

one of us is not sync-ed with 6.7.0-rc3 :)

cheers,
peter
