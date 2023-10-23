Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4178D7D4343
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJWXh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJWXhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:37:25 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A07CC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 16:37:22 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id B3DE8C01E; Tue, 24 Oct 2023 01:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698104238; bh=U0OoYg7GbikTWZxa3iI1FGXi3z0etzMYaJtqHlCh94A=;
        h=From:To:Cc:Subject:Date:From;
        b=wpQP3XHQxfYe8j1OVBmZQ+UDiC0kdkNEArSLJ6tpMzgZdac9MaMoc3DI/7PqR4JJj
         GofEfzEaX1njk39rCxCQKdiXvVQrRj5R0wOSDVoakDTM8wPvX9Wt/iF5/Ib3NI7uLV
         IBr6I5ZurnFs8MKfdgJmJ6K0Is4zV13AUa4nyMGQ1T0F9DYGfVRbU6ELMPHVd7/TON
         b1bmLLZ3D2zw3ZhZ1ijVWTtprBQu40E8qKPY7VvqjCsKNZjfIwAc4uxwRczH7f4DK+
         KCBNZKP9fEKR4oSNFxqwWFSpRJGxQvWCPaY2u4YU0UmMCrkDEdQLjpQcc6Wetvrpk3
         wN0XpZzgd0y1A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 40B54C009;
        Tue, 24 Oct 2023 01:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698104238; bh=U0OoYg7GbikTWZxa3iI1FGXi3z0etzMYaJtqHlCh94A=;
        h=From:To:Cc:Subject:Date:From;
        b=wpQP3XHQxfYe8j1OVBmZQ+UDiC0kdkNEArSLJ6tpMzgZdac9MaMoc3DI/7PqR4JJj
         GofEfzEaX1njk39rCxCQKdiXvVQrRj5R0wOSDVoakDTM8wPvX9Wt/iF5/Ib3NI7uLV
         IBr6I5ZurnFs8MKfdgJmJ6K0Is4zV13AUa4nyMGQ1T0F9DYGfVRbU6ELMPHVd7/TON
         b1bmLLZ3D2zw3ZhZ1ijVWTtprBQu40E8qKPY7VvqjCsKNZjfIwAc4uxwRczH7f4DK+
         KCBNZKP9fEKR4oSNFxqwWFSpRJGxQvWCPaY2u4YU0UmMCrkDEdQLjpQcc6Wetvrpk3
         wN0XpZzgd0y1A==
Received: from gaia.codewreck.org (localhost.lan [::1])
        by gaia (OpenSMTPD) with ESMTP id 2ef0606e;
        Mon, 23 Oct 2023 23:37:13 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs@lists.linux.dev, ericvh@kernel.org, linux_oss@crudebyte.com
Cc:     lucho@ionkov.net, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 0/3] Small patches for 6.7
Date:   Tue, 24 Oct 2023 08:37:01 +0900
Message-ID: <20231023233704.1185154-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the patches we got this cycle required a bit of re-work so I'm
posting them here; nothing big but please have a look when you can.

I'll also include these two patches:
https://lore.kernel.org/r/20230807141726.38860-1-yuehaibing@huawei.com
https://lore.kernel.org/r/AA2DB53B-DFC7-4B88-9515-E4C9AFA6435D@gmail.com

This set passes my quick checks and honestly can't break much, so I'll
be pushing them to next later today.

I don't think I'll be submitting anything else to Linus this time, but
please point out if you notice anything I forgot!

Dominique Martinet (2):
  9p: v9fs_listxattr: fix %s null argument warning
  9p/net: xen: fix false positive printf format overflow warning

Marco Elver (1):
  9p: Annotate data-racy writes to file::f_flags on fd mount

 fs/9p/xattr.c      |  4 ++--
 net/9p/client.c    |  2 +-
 net/9p/trans_fd.c  |  8 +++++---
 net/9p/trans_xen.c | 13 +++++++------
 4 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.41.0

