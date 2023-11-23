Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6EB7F6143
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjKWOSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbjKWOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:18:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782AFD5E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:18:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA7FC433CD;
        Thu, 23 Nov 2023 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700749095;
        bh=DYG761ELVMuJyVilDAJAz+1CSGxXyRFC4h5pDEUq7Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NVKhCK/jIeeu3Abro4OrzmTsdAmzgRJYyU2VM29LCZEI0EJhR+c0alZXRxDO9wfRb
         uetAskPqpHATFJmFziJ3xF/5ZMxiKJhr/nt0UZMAIpFIwYA+hi4koYyDFwdfVSj8/E
         QZcKRHU5GDRGAJBjG/XB+/s+W9AfqAalbrfNkYMrX9A5uqIpuTscru8obUqlBYs6HO
         xVKpuxslqetFeJYUUl33ZIwnYqV8vggiA/HcF+3vuoLxs6oqMrgyEg+eTKbkpVTTty
         3cFF8hCYylrsjJz+HzjGmZ+q+F1SzC0O88xq9EViSRDH7JOXTkcZlVbZZaOWu/vU+P
         mznaHLHdqjcbA==
Date:   Thu, 23 Nov 2023 14:18:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cs42l43: Correct SoundWire port list
Message-ID: <20231123141812.GG1243364@google.com>
References: <20231113150220.1472294-1-ckeepax@opensource.cirrus.com>
 <20231123113055.GE1243364@google.com>
 <20231123114605.GQ32655@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123114605.GQ32655@ediswmail.ad.cirrus.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023, Charles Keepax wrote:

> On Thu, Nov 23, 2023 at 11:30:55AM +0000, Lee Jones wrote:
> > On Mon, 13 Nov 2023, Charles Keepax wrote:
> > >  enum cs42l43_sdw_ports {
> > > -	CS42L43_DMIC_DEC_ASP_PORT = 1,
> > > -	CS42L43_SPK_TX_PORT,
> > > -	CS42L43_SPDIF_HP_PORT,
> > > -	CS42L43_SPK_RX_PORT,
> > > -	CS42L43_ASP_PORT,
> > > +	CS42L43_DP1 = 1,
> > > +	CS42L43_DP2,
> > > +	CS42L43_DP3,
> > > +	CS42L43_DP4,
> > > +	CS42L43_DP5,
> > > +	CS42L43_DP6,
> > > +	CS42L43_DP7,
> > >  };
> > 
> > This is starting to look a little redundant now.
> > 
> > I'm not sure if this is better, but it sure takes up less room:
> > 
> > #define CS42L43_SDW_PORT(port) port
> > 
> 
> Sure, I think that is better. Will respin the patch. I mean I
> guess I could also just drop the enum/define entirely and just
> use the port numbers. But will assume you prefer the define
> unless I hear otherwise.

Yes, I like magic numbers even less.  Thanks.

-- 
Lee Jones [李琼斯]
