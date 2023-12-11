Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BAE80C59C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjLKKGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:06:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42741B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:06:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2532C433C8;
        Mon, 11 Dec 2023 10:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702289207;
        bh=ruZzyWAtms11/Ti8YUwlxFhxyYABN17MRpVZkmWtJ14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AkXHQYdM/hj1HG/X8G5xW6JnVQTCZUGwiKI0nkgYtF/Y0xURs8khlX2qoNMhzGMFZ
         2Tkykt9rDpINFoHaRTQhJI3/ITkBJUz2HEK4tM+IvJXG+vCFk5ve9fZRZjA+NSM/M3
         cy6enkwzYaqf/hcf5PiGa+V4gLmTX/sYX58GSjmlIhdm+nCHcmS+0ag0/5Qos8PHFP
         s6WBeUM22HPNGeg5uJZ0OxeOV2cAut4B4LocQY/tyNMXYVSpEa7QwFNKM0flpkjWwR
         j7y0zUkiU9OJekpBpPCVAnay+dJnZUicXricJ+J1O6k+BUWrM6TJjBW3NFqHflZHKQ
         euOkJPAO1MJGw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] eventfd: Remove usage of the deprecated ida_simple_xx() API
Date:   Mon, 11 Dec 2023 11:06:27 +0100
Message-ID: <20231211-betanken-mengenlehre-2daa69758114@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To:  <575dcecd51097dd30c5515f9f0ed92076b4ef403.1702229520.git.christophe.jaillet@wanadoo.fr>
References:  <575dcecd51097dd30c5515f9f0ed92076b4ef403.1702229520.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=brauner@kernel.org; h=from:subject:message-id; bh=ruZzyWAtms11/Ti8YUwlxFhxyYABN17MRpVZkmWtJ14=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSW3Vf6/FNeYOuKzgy+PLWIfZ6xE9hL1+Yf5fo3M7O3u cKqj9muo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJH2hj+SoVdet18kOn4BLZM ++lRtruzLd3sfrE4+oa1pi+MkjI9zsjw6OXDB5lZrrNmr3nAtc1UJ1xl6pPmqcIitvX3q/ccEDf jBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 18:32:18 +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] eventfd: Remove usage of the deprecated ida_simple_xx() API
      https://git.kernel.org/vfs/vfs/c/ece491e762cc
