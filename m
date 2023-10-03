Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DEC7B6EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbjJCQtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjJCQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:49:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E9A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:49:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B05C433C8;
        Tue,  3 Oct 2023 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696351753;
        bh=iEwy5TFfW38GUWMzKpl2xUh3tcJyNxUXX2NNuztvv9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ns/DbDiT/6XDOd6Uk8EkSsMmWp8ic4CpREMt2sxYNdXgCKGD++IGUO9aqxrQsFvI0
         yoIxS0oz2Z0K6oU3DjugeJXE7Oomocvl/fRH4t4eQocEoxGYaiFGelq0UnGhaloiv8
         wvOIruSKsDxb/4lMOsQ64f5Zg4KmBLNUJpwqkX9k=
Date:   Tue, 3 Oct 2023 09:49:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH] mm/migrate: fix do_pages_move for compat pointers
Message-Id: <20231003094912.08cf57998135446ef475dd19@linux-foundation.org>
In-Reply-To: <20231003144857.752952-1-gregory.price@memverge.com>
References: <20231003144857.752952-1-gregory.price@memverge.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Oct 2023 10:48:56 -0400 Gregory Price <gourry.memverge@gmail.com> wrote:

> do_pages_move does not handle compat pointers for the page list.
> correctly.  Add in_compat_syscall check and appropriate get_user
> fetch when iterating the page list.

What are the userspace visible effects of this change?
