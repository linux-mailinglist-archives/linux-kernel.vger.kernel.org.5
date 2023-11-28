Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540E87FC9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376390AbjK1WpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjK1WpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:45:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF983
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:45:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E311BC433C8;
        Tue, 28 Nov 2023 22:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701211515;
        bh=rGFxfOF2I+tYipglEif1ZyDYoJ7doqD6mUgYvsipiC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q5glqAHKFkGi9sRnBMO3YNLxYRFTnHNXRKe3ghaF+iftOpitpHLKGeLFNnGQ2pF6m
         MtEUxt1ZoVQ+a1hxARc4eOEd2RWefBEhCphbwiZof0+mRlZMbq2kWeOHiLWLzlStIX
         eDQS6nciHT89vwoHkE6pBtY4YlTSI9nsC96DVaOM=
Date:   Tue, 28 Nov 2023 14:45:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dmitry Rokosov <ddrokosov@salutedevices.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20231128144514.aa04099199dc13f52374e2b2@linux-foundation.org>
In-Reply-To: <20231129084547.79c27d63@canb.auug.org.au>
References: <20231129084547.79c27d63@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 08:45:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the mm tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> make[5]: *** No rule to make target 'samples/cgroup/cgroup_event_listener.c', needed by 'samples/cgroup/cgroup_event_listener'.  Stop.
> 
> Caused by commit
> 
>   fc2cf253aaec ("samples: introduce new samples subdir for cgroup")
> 
> I have reverted that commit (and the following one) for today.

Thanks, my rename detector broke.  Fixed.
