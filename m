Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA198125F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjLNDcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjLNDcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:32:08 -0500
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF0111
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 19:32:13 -0800 (PST)
Message-ID: <c8b952ea-e5fb-491f-b444-0a4e179716c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702524729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nrtfzVsKhb+pEEnD9Dv72GTrmorIJAeKuyjqO56so4=;
        b=XHRyd9Jcy68UY2+b6OIO4TsTUvyimNKSumeotXqxtvjPUDwBFsPS6QZ2OxVWzCrdXKjOBh
        fPFtwXoydoAnjsiZn6157IVAEWdnxpxxHyRDqJttEnRoJR/udUtoD56DvXL0U+Dtazhkq9
        O2thaA9yED7ZczwVxPiYuy3XI4yzLs4=
Date:   Wed, 13 Dec 2023 19:32:05 -0800
MIME-Version: 1.0
Subject: Re: [PATCH] ARC: add hugetlb definitions
Content-Language: en-US
To:     Pavel Kozlov <Pavel.Kozlov@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>
References: <20231213150710.13574-1-kozlov@synopsys.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vineet Gupta <vineet.gupta@linux.dev>
In-Reply-To: <20231213150710.13574-1-kozlov@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 07:07, Pavel Kozlov wrote:
> From: Pavel Kozlov <pavel.kozlov@synopsys.com>
>
> Add hugetlb definitions if THP enabled. ARC doesn't support
> HugeTLB FS but it supports THP. Some kernel code such as pagemap
> uses hugetlb definitions with THP.
>
> This patch fixes ARC build issue (HPAGE_SIZE undeclared error) with
> TRANSPARENT_HUGEPAGE enabled.
>
> Signed-off-by: Pavel Kozlov <pavel.kozlov@synopsys.com>

Added to for-curr.

I'll pile this will rest of patches for some linux-next soaking.

Thx,
-Vineet
