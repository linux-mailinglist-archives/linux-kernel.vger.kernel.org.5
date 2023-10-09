Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6A7BE8DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377424AbjJISJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376898AbjJISJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:09:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD5E94;
        Mon,  9 Oct 2023 11:09:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AD9C433C7;
        Mon,  9 Oct 2023 18:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696874987;
        bh=55mBdPux7Faa+MTMfhzDfhcLUi40zyKZ0NpJ/3a3pcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8H/ukR+KYxcZZzJWnnwdyKPt+JA+nb6tZkMCHtSBtn1jOzDg5vGkrfaX4Jf57lCD
         zlwvmPnfyJIlA6S0FhT7B+GC4D/QNTajBMCBXPOMvY9w/gCA7qNXP+saLnrbZZPMsW
         h4IT/msBBFYLiRTvKuBC77JlNLpKEquBREqOVt7E=
Date:   Mon, 9 Oct 2023 20:09:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Bryan Jennings <bryjen423@gmail.com>, sashal@kernel.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, olvaffe@gmail.com,
        amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
        stable@vger.kernel.org, Lang.Yu@amd.com, christian.koenig@amd.com
Subject: Re: [PATCH AUTOSEL 5.10 13/22] drm/amdgpu: install stub fence into
 potential unused fence pointers
Message-ID: <2023100908-chaperone-squishier-4f10@gregkh>
References: <2023083119-phoney-ascend-d4ec@gregkh>
 <d32d6919-47cf-4ddc-955a-0759088220ae@gmail.com>
 <2023100750-unraveled-propeller-3697@gregkh>
 <0eb8750d-79c5-4508-ac36-7f91bc8cbaf9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0eb8750d-79c5-4508-ac36-7f91bc8cbaf9@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 02:46:40PM +0200, Christian König wrote:
> Am 07.10.23 um 11:50 schrieb Greg KH:
> > On Sun, Sep 10, 2023 at 03:43:01PM -0500, Bryan Jennings wrote:
> > > This is also causing log spam on 5.15.  It was included in 5.15.128 as
> > > commit 4921792e04f2125b5eadef9dbe9417a8354c7eff.  I encountered this and
> > > found https://gitlab.freedesktop.org/drm/amd/-/issues/2820 while researching
> > > the problem.
> > Confused, what should we do here?
> 
> If this patch was backported to even more older kernels then please revert
> that immediately!

It only went to 5.10 and 5.15 and has been reverted from both of them
now.

thanks,

greg k-h
