Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A95810947
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378518AbjLME5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjLME5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:57:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD843AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:57:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CC4C433C7;
        Wed, 13 Dec 2023 04:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702443428;
        bh=5BOi3Lwdro3EYfj4e0mqi80DNewhu0wK7EVeY8e20mA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mL2viXPFPMXylyv+jO64cyP5OgXhwVz7USicBblv5xRQIJlimFbas8/P6ZZxR3wyt
         feiwg+g3PEARPbJgmIw4CtC+aJ0gjk9BLGjUM1T6BUcd5LLb6/c/6was5hiiyvNwgK
         XVz50wfZyeVcTIVYEdye1UjW0aiKFIcLp29cF5dXZvsy+u/hUNFZu8j1qlNxSnTOQ9
         sRswZ5TOqCtdN7xmcfbee7Lr7YuyThuNdUmlv8gofKkI/3uJeFotwn9oOpPi5lpfq5
         tZckmc3cuBRgSZGenLPG4bEq/tKOgOGka3S76GuYULYE22kLCs2f71/aWsUbUYuWeu
         5K6bG/6VnZLBQ==
Date:   Tue, 12 Dec 2023 20:57:05 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
        yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
        linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dm: Support I/O priority for dm_io()
Message-ID: <20231213045705.GC1127@sol.localdomain>
References: <ZXeJ9jAKEQ31OXLP@redhat.com>
 <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
 <20231212111150.18155-3-hongyu.jin.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212111150.18155-3-hongyu.jin.cn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:11:47PM +0800, Hongyu Jin wrote:
> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> Add ioprio field in struct dm_io_region, by this field
> specific I/O priority when call dm_io().
> 
> Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
> Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>

Is struct dm_io_region really the right place for this?  What about
struct dm_io_request?  Or a parameter to dm_io().

- Eric
