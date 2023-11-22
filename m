Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D367F52AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjKVVgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVVgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:36:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0C51BF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:35:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355EEC433C8;
        Wed, 22 Nov 2023 21:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700688956;
        bh=dUf7J8K5pInX6ApRsBDZomkEu1RtnSBNH2JHXiSX7sY=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=YtP/GvNT2rI51Ptztgba6YuBdIJ6WPXSCcClZeCkvVekUWZLIJDyWDxopcNGoFjtl
         0RPiAaKPgWqPzWGSuWzOL5EXxSZzsS3VnvtYtaecgsPSmm2mKEXSit4VD0mbk+FwjD
         ZF0NTHlA1pRC4uG7AMRgH6DD33mm2a97R3Ay4+Vc=
Date:   Wed, 22 Nov 2023 13:35:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        mhocko@kernel.org, tj@kernel.org, ying.huang@intel.com,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 00/11] mm/mempolicy: Make task->mempolicy externally
 modifiable via syscall and procfs
Message-Id: <20231122133555.b7fc6cdefae0395d34a4cd1c@linux-foundation.org>
In-Reply-To: <20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
References: <20231122211200.31620-1-gregory.price@memverge.com>
        <20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 13:33:48 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 22 Nov 2023 16:11:49 -0500 Gregory Price <gourry.memverge@gmail.com> wrote:
> > echo "default" > /proc/pid/mempolicy
> > echo "prefer=relative:0" > /proc/pid/mempolicy
> > echo "interleave:0-3" > /proc/pid/mempolicy
> 
> What do we get when we read from this?  Please add to changelog.
> 

Also a description of the permissions for this procfs file, along with
reasoning.  If it has global readability, and there's something
interesting in there, let's show that the security implications have
been fully considered.
