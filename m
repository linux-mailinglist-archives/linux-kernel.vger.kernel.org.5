Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E7F7E6686
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjKIJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjKIJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:20:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4739E2704
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:20:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AE8C433CA;
        Thu,  9 Nov 2023 09:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699521616;
        bh=s8aQrU+W+ZhcWoRz4Tom+0RhbuHclc9MDMzHmMoqIBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRqHUJwxV2VH34rtiBe/d51sTEVeTHVkrSijjQIFF95r2+5w56evf4QR+fWCuF0Rr
         qR3EXRSZROAYyt9+h1xZ2lRttqGiWEGbQVX4by/ulRTFuBDq1qH2+8iQr343Hujsz3
         naWHsOZjkJ4h35M+OsVBdeTKMGa4kCdBdy1BhvwTvoaUD1uVytZg296WwXBJQX54uX
         1wUkEyHE/VDo+yaSKQmAybPnpASu3wMq5BnQVeofmE+SFpUE4nf4ub3eA1cpdzooBH
         7lnNLBRmFQXkDQyIqqL3IkhkNkm4mRTyo8F6+q12lCo6JVatdNONC1r2f7/tnlDUHA
         /XuesRu5LIY3w==
From:   Christian Brauner <brauner@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>, patches@lists.linux.dev,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userns: eliminate many kernel-doc warnings
Date:   Thu,  9 Nov 2023 10:20:10 +0100
Message-Id: <20231109-amtszeit-geurteilt-89cadab33960@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830163215.13193-1-rdunlap@infradead.org>
References: <20230830163215.13193-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=brauner@kernel.org; h=from:subject:message-id; bh=s8aQrU+W+ZhcWoRz4Tom+0RhbuHclc9MDMzHmMoqIBQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT6LFHLFDaYdPywlPLr74q7DV6+2eX3e9e0Dsf5/y1fzs1n LFgc2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRiw4M/8u9f8x6t1E27HdjEGOX/G Mt72Qp7RLLUm+WnU9lb1xyiGdkaFvy7/pty/6If4se85wMcZxZE3/g48yfG5rSLnBfZbF8yAQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 09:32:15 -0700, Randy Dunlap wrote:
> Drop the kernel-doc "/**" notation from 8 structs or functions to
> prevent 22 kernel-doc warnings  (samples below).
> 
> user_namespace.c:239: warning: Function parameter or member 'map_up' not described in 'idmap_key'
> user_namespace.c:246: warning: Function parameter or member 'k' not described in 'cmp_map_id'
> user_namespace.c:277: warning: Function parameter or member 'extents' not described in 'map_id_range_down_max'
> user_namespace.c:295: warning: Function parameter or member 'extents' not described in 'map_id_range_down_base'
> user_namespace.c:344: warning: Function parameter or member 'extents' not described in 'map_id_up_base'
> user_namespace.c:364: warning: Function parameter or member 'extents' not described in 'map_id_up_max'
> user_namespace.c:776: warning: Function parameter or member 'map' not described in 'insert_extent'
> user_namespace.c:844: warning: Function parameter or member 'map' not described in 'sort_idmaps'
> 
> [...]

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

[1/1] userns: eliminate many kernel-doc warnings
      https://git.kernel.org/vfs/vfs/c/97966f21d3d4
