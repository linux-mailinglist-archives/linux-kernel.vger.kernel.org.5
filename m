Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254717D3ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjJWSQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjJWSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:16:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127A48E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:16:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65792C433C8;
        Mon, 23 Oct 2023 18:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698084985;
        bh=8/Y6yUM2qc8zQIYxaEm1P3142V5gTTQ7O/yNb0plVTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j7LD7Xmspw0EbsKJ6nsrDwZvgIFMLB5dH7Uf9tdbSiWIMo4k5P1yGYlrxtgqwLeen
         WxZOWgrHzN3fImNCUfgAPt9bzm2jeQFx6fysV3VlbDzpSXkEQeZeFcguCdZ3VKqNpg
         geiuI+xwJwuJRwuvSTocybN4daXcLsArRlk3TeTk=
Date:   Mon, 23 Oct 2023 11:16:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mm/kmemleak: move the initialisation of object to
 __link_object
Message-Id: <20231023111624.15ea508ed8aba2dee69035c2@linux-foundation.org>
In-Reply-To: <20231023025125.90972-1-liushixin2@huawei.com>
References: <20231023025125.90972-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 10:51:25 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> Leave __alloc_object() just do the actual allocation and __link_object()
> do the full initialisation.

Changelog doesn't describe why we're making this change?
