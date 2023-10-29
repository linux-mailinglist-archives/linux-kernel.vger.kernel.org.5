Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875CB7DAB90
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 08:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjJ2Hho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 03:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2Hhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 03:37:43 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18C0EC9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 00:37:37 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 39T7XVeA024548;
        Sun, 29 Oct 2023 08:33:31 +0100
Date:   Sun, 29 Oct 2023 08:33:31 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: Use linux/wait.h rather than
 duplicating it
Message-ID: <ZT4Ky1diHfhLjwBN@1wt.eu>
References: <20231023-nolibc-waitpid-flags-v2-1-b09d096f091f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-nolibc-waitpid-flags-v2-1-b09d096f091f@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 07:42:45PM +0100, Mark Brown wrote:
> Linux defines a few custom flags for waitpid() which aren't currently
> provided by nolibc, make them available to nolibc based programs by just
> including linux/wait.h where they are defined instead of defining our
> own copy of the flags.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Use linux/wait.h rather than defining things locally.
> - Link to v1: https://lore.kernel.org/r/20231020-nolibc-waitpid-flags-v1-1-8137072dae14@kernel.org

Now merged into nolibc/next, thank you Mark!

Willy
