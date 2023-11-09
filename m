Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4964E7E667C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjKIJTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKIJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:19:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CED2590
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:19:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AF2C433C8;
        Thu,  9 Nov 2023 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699521551;
        bh=HVYvN2ozVNeiaMghylZLEYToigZ/kX7ZicoXTeV4yrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ak2l8fchJOepij39mv/tFpw2xQhP+8ITDV/1uKYBlWBbwDTPF3nloOkHMUYL8mUUt
         LoGAnMc4TpW/WAhZ5y4gUXY/vrKU7UjMfbIQ+286lN56QwhglNPucsfijVA8IXHvpK
         OtBxnGHu6xdoueQ/9CACI+PbWYaF2VhhMvdTQAgu7dJuF71vYfSPOhkmBykkeZlO95
         f9QYP6zJiuywK7Cq/OXcDTM5XnxAUzDx2/9sbSj3eFgAFG/UctLTm4Nu4dd+oSx7kS
         tSyMgUq5zFBrgDLuD+Kof05icpkQGUnHTk5osbxBRfkPkYvliW+Man1WSKiCQihLJR
         CXjrzcC6pCKjA==
From:   Christian Brauner <brauner@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Yusong Gao <a869920004@163.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: Clarify "non-RCY" in access_override_creds() comment
Date:   Thu,  9 Nov 2023 10:19:04 +0100
Message-Id: <20231109-klang-thermal-02adaa814632@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031114728.41485-1-bagasdotme@gmail.com>
References: <20231031114728.41485-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=brauner@kernel.org; h=from:subject:message-id; bh=HVYvN2ozVNeiaMghylZLEYToigZ/kX7ZicoXTeV4yrA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT6LP7d5Xi51b+CxenWlF+VdSuf7Ey/0tu5jqUo6dKqhdYP 2k7t7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIVzDD/5j3JQsaVHwZVDiX2/67NH Hbc/5n99bIHs494Fgo0dp9WIiRoaHugqaMgKpm56TzLJwsfB1nVOb+dNL/v6PpXoeOgnonLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 18:47:28 +0700, Bagas Sanjaya wrote:
> The term is originally intended as a joke that stands for "non-racy".
> This trips new contributors who mistake it for RCU typo [1].
> 
> Replace the term with more-explicit wording.
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

[1/1] fs: Clarify "non-RCY" in access_override_creds() comment
      https://git.kernel.org/vfs/vfs/c/effa12a475e6
