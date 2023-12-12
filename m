Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D248D80EDC9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbjLLNiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346414AbjLLNiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:38:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0BC83
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:38:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0FFC433C8;
        Tue, 12 Dec 2023 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702388286;
        bh=QG65l3/kLhGFIU5NyryJrHOqXPwHlHohY87W+40tc3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PM96PurBR5NnkHndjaKzUrtOCrl93+SKx0FVWSx8vjIi0szY+mzHHABOnvzAYpRmr
         Jyq2t2nnFbnNrHTwPNy8/C81tCyU+4755Fl2hU5vDgPIT1zNXmyf0DG0rES99CXzsQ
         ok3BvX2vvAHIY6tOjRHN7jwSG+ZA1I2RVmDZLMapuwwcRp3+DSfQtfPAWDgDPHk850
         9wvXj/Rxa6EaNviF4kK0DexTD2EK+Ol34fMzvMcmz8j/hC+cF5LBjtjeRYebRmmJ/b
         oM2efGvqVXJn6pgYt29heicbe8BngHZac7Saxljx4aAoteVvY6ucEMgDmGtK8a1N7B
         BC32/LlL7MwEg==
Date:   Tue, 12 Dec 2023 14:38:02 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the block tree
Message-ID: <20231212-innung-zuber-2f10bcffac51@brauner>
References: <20231212130213.631140dd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212130213.631140dd@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 01:02:13PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the vfs-brauner tree as different
> commits (but the same patches):

Thanks, Stephen. I gave Jens a stable vfs.file branch that he can pull
into his so this shouldn't become an issue again.
