Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB379B74F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357257AbjIKWFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbjIKM0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:26:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD01A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:26:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2352C433C8;
        Mon, 11 Sep 2023 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694435175;
        bh=e0zrDg0KO3B5/KtujlA1/eFIJ9q/fV/U0oZsXyESjdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=al/AQL/ZcLq5uzoUOQnsfyIWd+og8Z5xF0+Rqp3t1NfcVoXzOsaUQy0drR5+LPbMl
         VGfeqmXorvkClAFKKtvRmfcofgS8JZDa/UySlLdA1oGjIeDknp5Jr79xmblDrzGZMe
         ZJHiPe4fPKcHe0u08camxy42KsF4OXzHvNpDWQjhixdDQdk9eTpfaldHO6cmhmrKW/
         rDitt4wEIBxLi860Km4ZZIze7OKynbtWQqUUp10KyZxPbFg2ZHOkgJXG6bQS3Trycj
         V3Z6AsKCS0oX8bJHXfZ+PSXOA1pabg209ZYZ1LVXTcC1JODa8yx8LTx9x5A2jGws2m
         Pcld3Fvstf44g==
From:   Christian Brauner <brauner@kernel.org>
To:     axboe@kernel.dk, akpm@linux-foundation.org,
        Jianyong Wu <jianyong.wu@arm.com>
Cc:     Christian Brauner <brauner@kernel.org>, loic.poulain@linaro.org,
        wsa+renesas@sang-engineering.com, linux-kernel@vger.kernel.org,
        justin.he@arm.com
Subject: Re: [PATCH] init/mount: print pretty name of root device when panics
Date:   Mon, 11 Sep 2023 14:26:08 +0200
Message-Id: <20230911-unentbehrlich-ungunsten-1909304b2f91@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907091025.3436878-1-jianyong.wu@arm.com>
References: <20230907091025.3436878-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=brauner@kernel.org; h=from:subject:message-id; bh=e0zrDg0KO3B5/KtujlA1/eFIJ9q/fV/U0oZsXyESjdQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT8Z/f9pe9w6N+jLV7dIfe2txau+xS/7lPboxzG1zaO+/RE vefmd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEey3D/5oJuhn9l6vqTsX7HGsJuH z8S1pdHrdqZQqfjNi3F188VBj+aewoOh/LxTXXbb9lnuprtpdnXq6cuSVzq8wcu4885+7xMwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2023 09:10:25 +0000, Jianyong Wu wrote:
> Given a wrong root device, current log may not give the pretty name
> which is useful to locate root cause.
> 
> For example, there are 2 blk devs in a VM, /dev/vda which has 2 partitials
> /dev/vda1 and /dev/vda2 and /dev/vdb which is blank. /dev/vda2 is the
> right root dev. When set "root=/dev/vdb", we get error log:
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

[1/1] init/mount: print pretty name of root device when panics
      https://git.kernel.org/vfs/vfs/c/fae8adf5208d
