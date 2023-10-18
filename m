Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7777CE0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjJRPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjJRPRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:17:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C9998
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:17:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8838DC433C9;
        Wed, 18 Oct 2023 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697642223;
        bh=tYDvOcQYMxY8m9SGQfhjrd9cWuqQEEGhyR4rDAfRaTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eaaiYcn6gSFfDUR4XbUsgIuZNCRef2tMCpBfqHEC/E5+oGAGB3ida/odELyAWoDjl
         b6xWex8Glgld6p82OZIh0Irwt6fPPmnUjYrKc3dp5C6L7wwEUUornJcOW99to2CvgW
         49S45IDtHNnXtqLPM05RXzaVt1AXSTNUD6UeupynzD7smRsNChIkXNjmKn/tQ3XLYd
         z2Actt8+5SrIE+MWNywgJ45dpkMXJzJawDNLxz/CxLW0ME3W6xU+E321/evOfuphAo
         jfXtHaBkBQAz83ZesH5XZj8Ub9CnnQ3Q62uehbOtn9PvprhdzJsnvEObt30q7SFG46
         d7upvMuv5C8Ng==
Date:   Wed, 18 Oct 2023 08:17:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     Louis Peens <louis.peens@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
        oss-drivers@corigine.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] nfp: bpf: offload: Check prog before dereference
Message-ID: <20231018081702.2e24ce32@kernel.org>
In-Reply-To: <20231018145244.591454-1-artem.chernyshev@red-soft.ru>
References: <20231018145244.591454-1-artem.chernyshev@red-soft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 17:52:44 +0300 Artem Chernyshev wrote:
> In nfp_net_bpf_offload() it is possible to dereference a
> NULL pointer.

And who would call this function with prog = NULL if old_prog
is also NULL, exactly?
-- 
pw-bot: cr
