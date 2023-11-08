Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62E07E5D34
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjKHS3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:29:14 -0500
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 10:29:12 PST
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951042105
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 10:29:12 -0800 (PST)
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
        by mailscanner01.zoner.fi (Postfix) with ESMTPS id 7B6CF42E3A;
        Wed,  8 Nov 2023 20:21:43 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
        by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
        (envelope-from <lasse.collin@tukaani.org>)
        id 1r0nBP-0005Py-19;
        Wed, 08 Nov 2023 20:21:43 +0200
Date:   Wed, 8 Nov 2023 20:21:42 +0200
From:   Lasse Collin <lasse.collin@tukaani.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/xz: Add ARM64 BCJ filter
Message-ID: <20231108202142.7e22d4eb@kaneli>
In-Reply-To: <20231108094816.5532cac69a4b8541952f44c5@linux-foundation.org>
References: <20231108194448.674cd0ad@kaneli>
        <20231108094816.5532cac69a4b8541952f44c5@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-08 Andrew Morton wrote:
> On Wed, 8 Nov 2023 19:44:48 +0200 Lasse Collin
> <lasse.collin@tukaani.org> wrote:
> 
> > ARM64 kernel decompression is done by bootloaders but
> > the filter can still be useful, for example, for Squashfs.
> > 
> > A duplicated check for XZ_DEC_ARM in xz_private.h was omitted too.  
> 
> There's nothing here that uses the new functionality?
> 
> Is a squashfs patch expected?

I need to send a patch to mksquashfs. In the kernel the XZ filters are
handled by the XZ code, so Squashfs in the kernel needs no changes.

Initramfs can use the filters if initramfs contains a significant amount
of executable code. There are practical reasons why it's not commonly
done on other archs though. The main one is that kernel modules
shouldn't be filtered (worse compression). There are plans to improve
the compression tools to make this easier (it would help in other
contexts too) but it will take time.

-- 
Lasse Collin
