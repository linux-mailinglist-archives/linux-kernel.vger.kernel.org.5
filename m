Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1A77EAFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjKNMNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjKNMM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:12:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC3D1B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:12:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E1DC433CA;
        Tue, 14 Nov 2023 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699963973;
        bh=8kXJWWj+IxMhyzIH21g9tcu4B65dLiehTI2WpsbUmUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xMrrslAQl5utdVE7FIYal8YJYkaw75FUkKBTtqY7SeeB8JNS6CdN3gYzJ+FERe4K/
         7iFlWgcgjB7mW/DIhDtDj+DbI4UZLbbkelY5hey3tMfkwS4In2goqLE3A/WdLrll3D
         /HN5W8lDwWwWHDW6Szf/08aeeojoin0SQsevW41U=
Date:   Tue, 14 Nov 2023 07:12:50 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Revert "mei/hdcp: Also enable for XE"
Message-ID: <2023111451-campsite-eaten-b8e3@gregkh>
References: <20231114100843.1923977-1-alexander.usyskin@intel.com>
 <20231114100843.1923977-2-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114100843.1923977-2-alexander.usyskin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 12:08:39PM +0200, Alexander Usyskin wrote:
> This reverts commit 62db7d00efe48c614b006086f306d5addedf8f83.
> 
> It will be replaced by match without driver name.

Again, you are saying _what_ you are doing, but not _why_ you are doing
this.  I have no clue why this current matching is not acceptable.

And did you just break the existing code if only this patch is applied?

> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

As I asked this same question last review cycle, I'm now going to be
very picky and say "You are not following the documented Intel procedure
for Linux kernel patches that Greg has to review."  Please work with
your internal Intel kernel developers to fix this, otherwise we can not
take them at all, sorry.

thanks,

greg k-h
