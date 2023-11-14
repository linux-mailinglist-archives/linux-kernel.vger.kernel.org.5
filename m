Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF07EB175
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjKNOEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjKNOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:04:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63521B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:04:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3773FC433C8;
        Tue, 14 Nov 2023 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699970681;
        bh=034d0+jdxTnUWxQ02VoYkoPA67UyVnzHzKH7yCxURhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bK5FBxmeUBWWWPv+iIX2Af+RxSBaYf3NI5mkxn0xQLOjG2LWEVGjhs0i6Y9pjcLWr
         ihkn/6iNW9CIHaxyfS4WSosYPl68R+wL6sr5rMlyFxQiSM/pSDsv65MH3so2B0R2qH
         AmHNz9GUvcBToA8ZPB5tj8RiUXtX41LMkEl20f1TX/APjV13U0CD8WNas+KuI44tOF
         u2pHEg+SyN5ZKr5n9BMLfi9t7SrJndNyTW9+POK9RUa7VMf4XhaDUPnFK+Ui6iBTKC
         czPX/cFZFY2FiwCImMhhlX60NT+vGgUHI0o3Uvh/aX+c8zqUbdf9txvfgs7JBhW9Pd
         XbU6ot5ir7I4A==
Date:   Tue, 14 Nov 2023 09:04:37 -0500
From:   Keith Busch <kbusch@kernel.org>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, hare@suse.de
Subject: Re: [PATCH 1/2 RESEND] nvme-auth: unlock mutex in one place only
Message-ID: <ZVN-dSBf0y5vrukB@kbusch-mbp.dhcp.thefacebook.com>
References: <20231011084512.1835614-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011084512.1835614-1-shiftee@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 08:45:11AM +0000, Mark O'Donovan wrote:
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Applied to nvme-6.7, thanks!
