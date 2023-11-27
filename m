Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDFA7FA1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjK0N6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjK0NzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:55:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0647F1FFD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:54:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CD6C433CD;
        Mon, 27 Nov 2023 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701093283;
        bh=Nr5swYY4gA6xNHt0Z4yplaqReZBU8Yic7S7/xZDwbj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1L+wIxIymXhI5stPgPpsACycTLJJWDPTmv3EFof1rQgFrKKgoNCa64FRgBiKy0rJr
         xqNdNKTdSKo1zsCdfVINxNhvUPTBhkw/xYukl/UScs2cIJPkWqrRRsB6GDrUfxX1BA
         a/5/M78PHdt6zVjxCCTMGhe9VgY32oqnl9pGXgIc=
Date:   Mon, 27 Nov 2023 13:53:56 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ryan Lahfa <ryan@lahfa.xyz>
Cc:     zhengqi.arch@bytedance.com, akpm@linux-foundation.org,
        brauner@kernel.org, cel@kernel.org, david@fromorbit.com,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, paulmck@kernel.org,
        roman.gushchin@linux.dev, senozhatsky@chromium.org,
        steven.price@arm.com, tkhai@ya.ru, tytso@mit.edu, vbabka@suse.cz,
        yujie.liu@intel.com
Subject: Re: [PATCH v6 00/45] use refcount+RCU method to implement lockless
 slab shrink
Message-ID: <2023112719-quantum-aside-2294@gregkh>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <oiinfvmshahzzwfjo3bn5zjspuoeei3yg3sutstmzkang4lwfp@m7esnepoxwtc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oiinfvmshahzzwfjo3bn5zjspuoeei3yg3sutstmzkang4lwfp@m7esnepoxwtc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 03:27:03PM +0100, Ryan Lahfa wrote:
> Hi there,
> 
> Given that this series removes the old shrinker APIs and re-adds new
> shrinker APIs with `EXPORT_SYMBOL_GPL`, is the intention to prevent any
> out of tree module user which is incompatible with GPL to use the
> shrinker APIs to register callbacks?

We really can't do much about out-of-tree code, sorry.  Please work to
get your out-of-tree code merged into the kernel tree properly, as
that's the normal kernel development model.

thanks,

greg k-h
