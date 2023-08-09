Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12518775630
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjHIJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHIJP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404721FCE;
        Wed,  9 Aug 2023 02:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C819E62AD1;
        Wed,  9 Aug 2023 09:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECD6C433C7;
        Wed,  9 Aug 2023 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691572556;
        bh=Q0uq8jXhxDiUHMy34oilY5BxQXi+jvtkpHe3hOZtILs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pIzNYGfu53aahgPC4Y84agjdk7f6WooBKwH78hh3bTjQBw1n65uv4QARSBzDY3Lp5
         NPeMGRfGovct4ctk3canU8GzqPYOZCw5G/FL4lqxVrdaawxsECFCeSduSySuD3IA7u
         TaO2hKAftuTWh9yD36RgRXVb53VWmS+YjvcAmC2I=
Date:   Wed, 9 Aug 2023 11:15:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kurt Garloff <kurt@garloff.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: Drop 0fc6fea41c71 ("drm/i915: Disable DC states for all
 commits") from the 6.0.y series?
Message-ID: <2023080930-overturn-duo-17de@gregkh>
References: <f0870e8f-0c66-57fd-f95d-18d014a11939@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0870e8f-0c66-57fd-f95d-18d014a11939@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 12:52:03PM +0200, Thorsten Leemhuis wrote:
> Hi Greg! Months ago you picked up mainline commit a2b6e99d8a6
> ("drm/i915: Disable DC states for all commits") for the 6.1.23 release
> as commit 0fc6fea41c71. It causes issues vor a few people (at least
> three, two of which are CCed) -- apparently because it depends on some
> change that wasn't picked up for 6.1.y. This is known for a while now,
> but nobody has yet found which change that is (Al found something that
> worked for him, but that didn't work for others). For the whole story
> skim this ticket:
> 
> https://gitlab.freedesktop.org/drm/intel/-/issues/8419
> 
> I wonder if it might be better if you revert that commit for 6.0.y; I
> asked already in the ticket if this is likely to cause regressions for
> users of 6.0.y, but got no answer from the i915 devs (or did I miss
> something?). :-/

Now reverted (note, 6.0.y is long dead, I reverted this for 6.1.y)

thanks,

greg "drowning in kernel release numbers" k-h
