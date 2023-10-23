Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A377D3E29
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjJWRox convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Oct 2023 13:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbjJWRou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:44:50 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45C310A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:44:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4011D6342D26;
        Mon, 23 Oct 2023 19:44:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZwQG_BZb1_Op; Mon, 23 Oct 2023 19:44:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A6DC66342D29;
        Mon, 23 Oct 2023 19:44:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ItP854Hxml7T; Mon, 23 Oct 2023 19:44:44 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 794E76342D26;
        Mon, 23 Oct 2023 19:44:44 +0200 (CEST)
Date:   Mon, 23 Oct 2023 19:44:44 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Yu Zhe <yuzhe@nfschina.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        kernel <kernel@sberdevices.ru>
Message-ID: <406915015.32119.1698083084288.JavaMail.zimbra@nod.at>
In-Reply-To: <3951ac21-a0a4-47b5-be94-edb0140c69a5@salutedevices.com>
References: <20231019073838.17586-1-mmkurbanov@salutedevices.com> <20231019073838.17586-3-mmkurbanov@salutedevices.com> <1258129392.18842.1697703134703.JavaMail.zimbra@nod.at> <3951ac21-a0a4-47b5-be94-edb0140c69a5@salutedevices.com>
Subject: Re: [PATCH v1 2/2] jffs2: make cleanmarker support option
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: make cleanmarker support option
Thread-Index: ewMpg4ruzQjVS9d+DleKQJCsQylw7A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Martin Kurbanov" <mmkurbanov@salutedevices.com>
> If you disable the cleanmarker, the found clean block (filled with 0xff)
> will be erased again (see fs/jffs2/scan.c#L162).
> In my opinion, it is better to perform the block erasure again than to
> not work with such a nand flash at all.

Doesn't this case many re-erases at each mount time?

BTW: I tried your patch in nandsim, jffs2 was unhappy.
[   56.147361] jffs2: notice: (440) jffs2_build_xattr_subsystem: complete building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 0 orphan) found.
[   56.200438] nand: nand_do_write_ops: attempt to write non page aligned data
[   56.201090] jffs2: Write clean marker to block at 0x001f8000 failed: -22

Do you have an idea?

Thanks,
//richard
