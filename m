Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCB87A9E29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjIUT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjIUT6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:58:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0491ED4C6B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:25:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2099DC433C8;
        Thu, 21 Sep 2023 18:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695320722;
        bh=atHxn0oP50X39viOIJkKSajTFqVn3mXPy8q7EkWVcDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eo3kx3Q6ZdtBz4kiW13CIgphmBIWEst+/HoN5gH898ESRwiPd7KkOwllJAYDXEAuZ
         xHYfWg+Nu8dFuFpNPfeIKtlBq2KwvIM2jr23U+54k0CrPspE1DLUHLMTgDax/fQGHP
         i/b+II2ktSKCdDTjn/jSs76wY7dHogEP+pCvryhQ=
Date:   Thu, 21 Sep 2023 11:25:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>
Subject: Re: [PATCH 0/2] maple_tree: Fix mas_prev() state regression.
Message-Id: <20230921112521.fc07c658804f4e188179da77@linux-foundation.org>
In-Reply-To: <20230921181236.509072-1-Liam.Howlett@oracle.com>
References: <20230921181236.509072-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 14:12:34 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> Pedro Falcato contacted me on IRC with an mprotect regression which was
> bisected back to the iterator changes for maple tree.  Root cause
> analysis showed the mas_prev() running off the end of the VMA space
> (previous from 0) followed by mas_find(), would skip the first value.
> 
> This patch set introduces maple state underflow/overflow so the sequence
> of calls on the maple state will return what the user expects.

It isn't clear what are the user-visible effects of this flaw?  Please
send this along and I'll paste it in.

Patch 1 should be titled "Add mas_is_active ...".

And patch 1 should have had cc:stable in the changelog.

It's stable@vger.kernel.org, although stable@kernel.org works just fine.
