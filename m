Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4097E5CA3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjKHRsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjKHRsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:48:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419201BEF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:48:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39BDC433C9;
        Wed,  8 Nov 2023 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699465696;
        bh=B3D8kn+YAuTi2y8lgXrgSAq8tNXjJQV5oZRUhMOzh4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KpYEkL08STie+f6FHsECybos+SkhZy/VhqZCt0AROESLGuTCGXX1in2v2Ct2RB7pq
         HLLMMct+beCFwVVqoA4CM+YkEfd52io5bYbvx2GwXdu0mEmlUxQxtcakhIy+Je3HkT
         3rL6/O9GdaMx+b9IshEs013pU1Ak/DuBlWXnhSwE=
Date:   Wed, 8 Nov 2023 09:48:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lasse Collin <lasse.collin@tukaani.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/xz: Add ARM64 BCJ filter
Message-Id: <20231108094816.5532cac69a4b8541952f44c5@linux-foundation.org>
In-Reply-To: <20231108194448.674cd0ad@kaneli>
References: <20231108194448.674cd0ad@kaneli>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 19:44:48 +0200 Lasse Collin <lasse.collin@tukaani.org> wrote:

> ARM64 kernel decompression is done by bootloaders but
> the filter can still be useful, for example, for Squashfs.
> 
> A duplicated check for XZ_DEC_ARM in xz_private.h was omitted too.

There's nothing here that uses the new functionality?

Is a squashfs patch expected?
