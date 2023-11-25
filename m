Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B87F8BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 15:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjKYOse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 09:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjKYOsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 09:48:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D8B6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 06:48:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29007C433C8;
        Sat, 25 Nov 2023 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700923717;
        bh=Bu5//kjJspOiaXvzhiIPwduKqA4hrH4OAkkljNG/AaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ked7JVe5kebzJGTY4cwvgKzVwjTYL4K0cZzOyNsRyZvd9PZ+VrOXyQicw9+r9YuN3
         SPPCZsbL4uNEy3c6tk/z16BT9nkCozZYhzMwCbZUa5kYhPb/vc3gra+vTDb+JpYiwc
         3sIJYjyazGkm+gNyG0Tpio2259t6lvOIH2Uj0LAk=
Date:   Sat, 25 Nov 2023 14:48:34 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2 2/6] debugfs: annotate debugfs handlers vs. removal
 with lockdep
Message-ID: <2023112530-eraser-glare-44b2@gregkh>
References: <20231124162522.16344-7-johannes@sipsolutions.net>
 <20231124172522.0442774abc66.Ia70a49792c448867fd61b0234e1da507b0f75086@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124172522.0442774abc66.Ia70a49792c448867fd61b0234e1da507b0f75086@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:25:25PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> When you take a lock in a debugfs handler but also try
> to remove the debugfs file under that lock, things can
> deadlock since the removal has to wait for all users
> to finish.
> 
> Add lockdep annotations in debugfs_file_get()/_put()
> to catch such issues.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
