Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C546805193
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376710AbjLELIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbjLELIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:08:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE049A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:08:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A81C433C7;
        Tue,  5 Dec 2023 11:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701774510;
        bh=HHOxMjZH5nM9ClZgb0ghCiIEvF8MqJKExZZrSODIhS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGk9MUyfr4PZcRO4T11b9CCtt9K9ib+1sWAycaXmp3IcRyRNVoHFKqtf3nN2PkRMx
         /KWheiGlWqyVAOnYHdmayhAxY9F7MlrivIzkmmImV9Y5xjZiff05paaN455FQuV/f8
         woSe/AZezE+xsAUcf+uTvXB57ym8OvdkwsAM8MR4BTxH30/Sm5/VLbLZN18ZSTQLEV
         R5te+weRgNWXnZbDKgaHmfSx8PtT921qgPOoZ1Eiocs/xJGCCwFsvfcoP9wCmsQcch
         GkubySjh6YXQjwAzVKpuA2rmX5wE5ZMa1K/toiuV4tDuAvgE7wf7K94sN7eMIIi9xp
         i2DEOLR7MRpEA==
From:   Christian Brauner <brauner@kernel.org>
To:     viro@zeniv.linux.org.uk, Hao Ge <gehao@kylinos.cn>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gehao618@163.com
Subject: Re: [PATCH] fs/inode: Make relatime_need_update return bool
Date:   Tue,  5 Dec 2023 12:08:19 +0100
Message-ID: <20231205-bemisst-verfugen-808478dd80f5@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231205064545.332322-1-gehao@kylinos.cn>
References: <20231205064545.332322-1-gehao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=brauner@kernel.org; h=from:subject:message-id; bh=HHOxMjZH5nM9ClZgb0ghCiIEvF8MqJKExZZrSODIhS0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTmsyxir0wzm7JhxqlX2b8uiz7POFd7wutlcWueiKHTm +Jgy6zYjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIms3cLwP2f9/xm9MvYFCpJ2 KSopq84/qPi+WjWPOyJTopynQ2+GDyPDCsN7/6oebn5Qp1yoOOWczAyZ0Au/UtyOfYgI2nFxwQ9 PHgA=
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

On Tue, 05 Dec 2023 14:45:45 +0800, Hao Ge wrote:
> relatime_need_update should return bool to consistent with the function
> __atime_needs_update that is caller
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

[1/1] fs/inode: Make relatime_need_update return bool
      https://git.kernel.org/vfs/vfs/c/f957e74dd3bb
