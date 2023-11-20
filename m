Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB33F7F17A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjKTPmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjKTPmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:42:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE4A9F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:42:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DC6C433C8;
        Mon, 20 Nov 2023 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700494954;
        bh=Ec52klbY35lJdHqfaeV6a8M0GtAsBsRL4qBkgpTYu+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4BNIYSAr4Dj1MnxT6ZrYHnkn2DLnsVwMFFLu/qOVZTrPwc3qXzt/TImagFU9EIOf
         2lLAbqYDTSgZBvWb9Ivy7i+Bq3S+qpc+U+dOsRMp1bvEz1WvKEx9r0v7hgMupwbaed
         tnA3bJtClig9Zf1nYE0n+IQUKvS5STBqMFdzgaTQCMevLMJtASSYT6JqY+EkC5O5PR
         E5MbusW2MuWZ4rswYEDOVu8lkeZc63FQK0rE6eo3eHi68nrV0QOss7FxN3YIQk78GW
         w2Cx6hUW7HdiXZbNDG6wDjaF3CaXkledCdGoyOIyLoRnTPMqDSuFEc3OnUwXPTlOd9
         rMmNTyQWShbIQ==
From:   Christian Brauner <brauner@kernel.org>
To:     YangXin <yx.0xffff@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: namei: Fix spelling mistake "Retuns" to "Returns"
Date:   Mon, 20 Nov 2023 16:42:09 +0100
Message-ID: <20231120-sackgasse-umspielen-4487ee8910b0@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231118132136.3084-1-yx.0xffff@gmail.com>
References: <20231118132136.3084-1-yx.0xffff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=brauner@kernel.org; h=from:subject:message-id; bh=Ec52klbY35lJdHqfaeV6a8M0GtAsBsRL4qBkgpTYu+c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRG1wVabJobc/nyRJ0ivrt+1xaqmh259FvhxuXQt0sOc 219Vi2p0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRidYM/5MYTmuumVT67uhF L//LJW9udCg7urx58GfvjgTdws0sxm8YGVas29MpoPpgY7rqpzj9h8fEI7ofZe5aIiSrffXUrhI 9a34A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2023 21:21:36 +0800, YangXin wrote:
> There are two spelling mistake in comments. Fix it.
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

[1/1] fs: namei: Fix spelling mistake "Retuns" to "Returns"
      https://git.kernel.org/vfs/vfs/c/136aef2de55c
