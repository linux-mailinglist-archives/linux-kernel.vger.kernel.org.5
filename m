Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AA67F4D33
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjKVQtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjKVQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:49:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3787110E6;
        Wed, 22 Nov 2023 08:49:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8454C433CA;
        Wed, 22 Nov 2023 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700671760;
        bh=2eaEiOuJiPmI83K90hZDYAc0bHogYH21CSUhgSS445U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORj1pfHG383ZfGaFkbkiJgiyVzT867/J3dvmvSCkgZjFKYDqfDi1r0OZVm/DgP6Pc
         ViDz4j7NPKGSEHCU89SrvFBF26SpBNuujZefGAI3o59WqwP5mDCxAJyQfHf0SsDk8o
         /7cBjVVVl+wR4K/Bw3d5CMQi3JMdYWoNMT1YjlJ9kR7rv9F7OSDtbCMy4Hu8H5oky0
         6VAS0OsnEAZ67VYK/If2gZXlU8RbpjZtBiyaw0NZ8Pzwm33LSt99itdWXw2Kajo1RE
         +xzRw9Cu3yotvsq/wa0g9kfhYSXWGN6+k5gCsNKBvUkeKUPeFNIR/CWtWM7pgBIeHQ
         BAglB2rz/XVaQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5qPv-00031n-0F;
        Wed, 22 Nov 2023 17:49:35 +0100
Date:   Wed, 22 Nov 2023 17:49:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        stable@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute
 stream during trigger.
Message-ID: <ZV4xH0lBhlwWYtLO@hovoldconsulting.com>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
 <ZTukaxUhgY4WLgEs@hovoldconsulting.com>
 <ZV4hMR8oGQBSbnMl@hovoldconsulting.com>
 <2023112225-crop-uncle-9097@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112225-crop-uncle-9097@gregkh>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 04:35:17PM +0000, Greg Kroah-Hartman wrote:
> On Wed, Nov 22, 2023 at 04:41:37PM +0100, Johan Hovold wrote:

> > These fixes are now in 6.7-rc1 as
> > 
> > 	f0220575e65a ("ASoC: soc-dai: add flag to mute and unmute stream during trigger")
> 
> This doesn't backport cleanly, can you provide a working backport?

Sure, I'll do that tomorrow.
 
> > 	805ce81826c8 ("ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag")
> 
> Now queued up, thanks.

I don't think this one will build without the former so better to drop
it from your queues and I'll send backports of both patches tomorrow.

Johan
