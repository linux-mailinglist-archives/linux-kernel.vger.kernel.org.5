Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4F7E6FD3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbjKIRGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjKIRGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:06:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FE672726
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:06:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40307106F;
        Thu,  9 Nov 2023 09:06:54 -0800 (PST)
Received: from arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C61D83F7C5;
        Thu,  9 Nov 2023 09:06:08 -0800 (PST)
Date:   Thu, 9 Nov 2023 17:06:06 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Omkar Wagle <ov.wagle@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MM: kmemleak: Add %x to pr_debug
Message-ID: <ZU0RflNjfMaP9ppu@arm.com>
References: <ZUtlwgDB1L2WVzfy@arm.com>
 <20231108165424.8845-1-ov.wagle@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108165424.8845-1-ov.wagle@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 08:54:24AM -0800, Omkar Wagle wrote:
> Add %x to pr_debug to keep it for debugging
> Remove the NULL check for object pointer
> 
> Signed-off-by: Omkar Wagle<ov.wagle@gmail.com>
> ---
>  mm/kmemleak.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index a7b74dc3ff01..93b77288754a 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -410,8 +410,6 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
>  		unsigned long untagged_objp;
>  
>  		object = rb_entry(rb, struct kmemleak_object, rb_node);
> -		if (!object)
> -			break;
>  
>  		untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);

It looks like this patch is on top if your original patch. We don't do
this unless your first patch was merged. So please fold your second
patch into the first and post what's left of them.

-- 
Catalin
