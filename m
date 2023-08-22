Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824F1783F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjHVLdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjHVLdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:33:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F1E4F;
        Tue, 22 Aug 2023 04:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FD4665291;
        Tue, 22 Aug 2023 11:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EDFC433C8;
        Tue, 22 Aug 2023 11:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692703912;
        bh=a3FKI5fLWw6BMBXM2pVAbx96bPD8OCs7OUQB2nqubdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oVfzJYXQP6luoOZKSlrGfn0HaDGWydhomAmU3svbyp3PtAhFvcE7c3uqgktj87Zww
         4ppWLWULdFxpz/IdTNvxP7AxhPMDmKSHCkdE9uv6l0E1sb4/cR9YZUBmF5Jdh18b8N
         iZPBKiNIubPjAIBVXvtBrFxEesu+ev+RGJ0yso08=
Date:   Tue, 22 Aug 2023 13:31:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        rafael@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.4 18/54] thermal: core: constify params in
 thermal_zone_device_register
Message-ID: <2023082232-anaerobic-smashing-42d3@gregkh>
References: <20230813154934.1067569-1-sashal@kernel.org>
 <20230813154934.1067569-18-sashal@kernel.org>
 <ZOSRPJxpVfCiyUWb@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOSRPJxpVfCiyUWb@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 12:43:08PM +0200, Pavel Machek wrote:
> Hi!
> 
> > [ Upstream commit 80ddce5f2dbd0e83eadc9f9d373439180d599fe5 ]
> > 
> > Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
> > parameters structure"), thermal_zone_device_register() allocates a copy
> > of the tzp argument and callers need not explicitly manage its lifetime.
> > 
> > This means the function no longer cares about the parameter being
> > mutable, so constify it.
> > 
> > No functional change.
> 
> Not a bugfix, should not be in stable.
> 
> 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
> parameters structure") is not in 6.1, so this is not correct patch for
> 6.1.
> 
> Why was this selected for AUTOSEL? Can you make sure patches marked
> "No functional change." are not selected in future?

No, because sometimes they are needed in later patches.  And marking
things const is good :)

thanks,

greg k-h
