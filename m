Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75C077AB2A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 22:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjHMUWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 16:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjHMUWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 16:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E24810FA;
        Sun, 13 Aug 2023 13:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 134CD60FFB;
        Sun, 13 Aug 2023 20:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01502C433C7;
        Sun, 13 Aug 2023 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691958151;
        bh=mGaxb/v93wxDqmTbSSYAvxfquShX5rFkS3m7T1jd2ZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cH8v7AQ5dn480AL1+dwxHnHHbDNogreUZb4lh1Xp86gJBrEFYi7SJuhXAIkWUf0y5
         UzuvLoWpQdzPnMl2dh/1SuAO7TZhm+VCzw6HVib+N1DPLXLPHE5m4CRUV8+xzraQl9
         9Zcdp1f/Tv/ZwBRVVZbG1WxZSzSOfu/Ok4PEvReI=
Date:   Sun, 13 Aug 2023 22:22:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 4.19/5.4/5.10/5.15/6.1 0/1] sch_netem: fix issues in
 netem_change() vs get_dist_table()
Message-ID: <2023081318-dental-rocker-796a@gregkh>
References: <20230813200746.288589-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813200746.288589-1-pchelkin@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 11:07:45PM +0300, Fedor Pchelkin wrote:
> Commit 2174a08db80d ("sch_netem: acquire qdisc lock in netem_change()")
> was backported to older stables where it is causing 'sleeping in invalid
> context' bug. The following patch fixes the problem and can be cleanly
> applied to the stable branches affected. It was backported to 6.4.y about
> a month ago.

Now queued up, thanks.

greg k-h
