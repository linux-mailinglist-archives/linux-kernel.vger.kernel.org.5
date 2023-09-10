Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDDF79A019
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 23:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjIJVaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIJVaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 17:30:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE1FB9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 14:30:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12F4C433C7;
        Sun, 10 Sep 2023 21:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694381405;
        bh=+d1wUzE1HtHhCvN7YmUSIkp5DC7IX1XEEk5FGI/tX34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t3CibMo2qzJ7795iwdkdQrICOBseMAO8bt4RFLLt+CA4A9ID6gn0wSyuaZPj3/CHk
         zQHVlpAbIYYTYccdadkuxD/FNHYrHc0Wzhe233sdNYhfKon5fIo3SaLOJSx7uFl3YX
         tjTlQi+M5bNwZCV+IDmCxIfcXqyFpyurhpsezAFo=
Date:   Sun, 10 Sep 2023 14:30:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: remove redundant pr_info when node is
 memoryless
Message-Id: <20230910143004.e8191c8ebabbe7ddd0fec6fa@linux-foundation.org>
In-Reply-To: <20230906091113.4029983-1-yajun.deng@linux.dev>
References: <20230906091113.4029983-1-yajun.deng@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Sep 2023 17:11:13 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:

> There is a similar pr_info in free_area_init_node(), so remove the
> redundant pr_info.

Please quote the before and after dmesg output so we can better
understand this proposal, thanks.
