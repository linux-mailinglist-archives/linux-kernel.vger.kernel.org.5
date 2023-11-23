Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8383B7F5BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjKWJyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjKWJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:54:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E883
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:54:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE9CC433C8;
        Thu, 23 Nov 2023 09:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700733265;
        bh=h4u+Z4PevK+HccYSFyk9MZh1m/3uRe4+K6fsxaTqZzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OEOul13wUWM1V1seWURR8g8h66cbFpwNNVN7LH0fFQNPSjTpFQHZChPKKLDhOsuHU
         XESZktq2bXQFoApB41k1Ru89s7tRN1HgK8OnRK3FOFkbzfDQznhseFn8iKEHeP5BQW
         vsZiykJEYqpPwrZrIaKLPzRbAJvo3WxQwhHDqG9r5r9AhBDaB+BOyxnWDsVBsPOBdn
         X67kHRdFPAFABq+Gr0110OtPcG0JLmWhv1MEJU+4rKs0zClbMBFzUyPese7y/h1pEw
         QhY2rs283QA8Rc7KwrJPyVLMpfOpl8mlgnnOpR0J3SPGWjsfcIQXjDqZwasWklqHLl
         4iSTpyCzbg55Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r66Py-0005N4-1e;
        Thu, 23 Nov 2023 10:54:43 +0100
Date:   Thu, 23 Nov 2023 10:54:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute
 stream during trigger.
Message-ID: <ZV8hYid_Gc0hE4xg@hovoldconsulting.com>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
 <ZTukaxUhgY4WLgEs@hovoldconsulting.com>
 <ZV4hMR8oGQBSbnMl@hovoldconsulting.com>
 <2023112225-crop-uncle-9097@gregkh>
 <ZV4xH0lBhlwWYtLO@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV4xH0lBhlwWYtLO@hovoldconsulting.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 05:49:35PM +0100, Johan Hovold wrote:
> On Wed, Nov 22, 2023 at 04:35:17PM +0000, Greg Kroah-Hartman wrote:
> > On Wed, Nov 22, 2023 at 04:41:37PM +0100, Johan Hovold wrote:
> 
> > > These fixes are now in 6.7-rc1 as
> > > 
> > > 	f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
> > 
> > This doesn't backport cleanly, can you provide a working backport?
> 
> Sure, I'll do that tomorrow.
>  
> > > 	805ce81826c8 ("ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag")
> > 
> > Now queued up, thanks.
> 
> I don't think this one will build without the former so better to drop
> it from your queues and I'll send backports of both patches tomorrow.

I've just posted backports of these commits to 6.6.2 here:

	https://lore.kernel.org/lkml/20231123094749.20462-1-johan+linaro@kernel.org/

They should apply to 6.5.12 as well.

Turns out we had a conflict with commit 3efcb471f871 ("ASoC: soc-pcm.c:
Make sure DAI parameters cleared if the DAI becomes inactive") which was
just backported to 6.6.2 and 6.5.12.

Johan
