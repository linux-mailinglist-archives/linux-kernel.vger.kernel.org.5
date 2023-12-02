Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1AD801EE1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjLBVpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBVpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:45:03 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C97BE8;
        Sat,  2 Dec 2023 13:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Rwyik1Cyaf8rPAzDwFjNdQAfgF5Q1clOrCxMqMQ94o=; b=Z1FoUWKOMFkaUPPOx1TpIBqZYj
        oE/rw6p6G0Gdbrxv1xh+gWe62MwcSRjvo66FsO/w+Y0rbVbvivKZ8F5dlKiE11g9E3j9mwDfoz7zN
        HJgQyvOwilDkm4U5MxnnAmc5fKMpI4fhp8h4CtxvxtIV2fS0eB1FAIPvTc2a9UxQlLNFSQCGXFTja
        4xSL1DjiYZLcOIC8lBMtb0KacxdxNt7dPRvugTbkKLVicFsWzGTo62N+PcjFPWkRpeGw3P4kaBNz6
        prVtjHDOySrh1PSdPhho5ImtrQ6w0uwx5Wa2fkn1LVb8lXYTJfDoSZYn5ls50lnnw5fpdRlyihuBw
        LnFtuiOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r9XnK-006OGD-15;
        Sat, 02 Dec 2023 21:45:02 +0000
Date:   Sat, 2 Dec 2023 21:45:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-fsdevel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/5] fs: Add DEFINE_FREE for struct inode
Message-ID: <20231202214502.GS38156@ZenIV>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-3-keescook@chromium.org>
 <20231202212846.GQ38156@ZenIV>
 <202312021331.D2DFBF153@keescook>
 <20231202214212.GR38156@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202214212.GR38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 09:42:12PM +0000, Al Viro wrote:

> I'll poke around and see what I can suggest; said that, one thing I have
> spotted there on the quick look is that you are exposing hashed dentry associated
> with your inode before you set its ->i_private.

... and on the second look, no, you do not do anything of that sort.
My apologies...
