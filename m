Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E87805160
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376695AbjLEK5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbjLEK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:57:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6BF184
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:57:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB70C433CA;
        Tue,  5 Dec 2023 10:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701773842;
        bh=YqpV12wF1wW4FbDYUwIQqQF3MI0jix0N68VmlJ6caHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZqSyY/Zse2ysr5oLlPSkX8cWt1V6ESwJEwFozwLMgK7KYO+Ef+LTcxwyM4btJfk6
         p8qXXtVOlnTUpaZ1SXPO4TLbPFQva0SasThKzoeM5CKKaYFY2UXJyz0MzjGv85tTFK
         mhaHFs2kTBF6Z0KU/8q5Vr47Czer9PNVv+Uvs1OslaMxtDda0O8Sz74D/ncikxako1
         z2zDCeXHcaENcFwJ2zwDOV7DRJz1X1eu3xtXFjVC0cKzx+QJNp8X9oGK6KFvgQAUQE
         aGBl/r6tDZgBbHUuUPieNZKjo7JGVUdbSplvOPcdtKThH9RRQHeNPwSy49kWI8lwiH
         RpBQXVLZAW8bQ==
Date:   Tue, 5 Dec 2023 11:57:18 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCHSET 0/2] Get rid of import_single_range()
Message-ID: <20231205-kaminholz-halstuch-280db992267b@brauner>
References: <20231204174827.1258875-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231204174827.1258875-1-axboe@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:47:48AM -0700, Jens Axboe wrote:
> Hi,
> 
> While looking at this today, I noticed that the 'iov' argument to this
> function is totally dead code. Patch 1 gets rid of it, and with this
> function and import_ubuf() now being identical, converts the callers
> to just use import_ubuf().
> 
> No functional changes here, just a cleanup removing some dead code.

Looks good. I've picked this up into vfs.iov_iter but let me know if
you're already carrying this.

Christian
