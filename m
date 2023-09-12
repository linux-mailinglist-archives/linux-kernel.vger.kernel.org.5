Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA9379DBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjILWfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjILWfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:35:23 -0400
Received: from out-213.mta0.migadu.com (out-213.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98DD10C8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:35:19 -0700 (PDT)
Date:   Tue, 12 Sep 2023 18:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694558116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVlBUVbNPXjPamFjkreO+xojIX5ElCVy21Zr6XoSbQU=;
        b=amoRbgM/w6SYiEpv5ns7cdDqHAlT2lLe63efSp/BE9lMBKre+CzdX/vEyY2WYFHL8rBosW
        oHnFz4o1sIKbL1m2XCpgKGnGJVEb0APEQq0ymOsPjf3DgEtuUnpoBqu+L89h3el0ibEM8O
        ZsISLDKSva/Dd1yG07gVE4M9CfjU84s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] bcachefs: Fixes for various compiler warnings
Message-ID: <20230912223510.i4hh3jkrrmyujzuj@moria.home.lan>
References: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912-bcachefs-cleanup-v1-0-c1f717424e6a@weissschuh.net>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:24:39PM +0200, Thomas Weißschuh wrote:
> Some fixes for warnings found by "make W=1".
> 
> Note: This was only compile-tested.

I've been working on these fixes too, most of them are already in the
bcachefs-testing branch or about to be.
