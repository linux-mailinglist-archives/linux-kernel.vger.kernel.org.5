Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A968175AA3E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjGTI7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjGTIrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:47:42 -0400
Received: from out-9.mta1.migadu.com (out-9.mta1.migadu.com [95.215.58.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F0A268F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:47:40 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689842858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JL2+aJ5O5gUNHRDDxgtEpVboWWUfK6z9tvOlRoQ8myk=;
        b=xtQyII0x5U1qJFK0WPGA+HV++LxAJwxaVyUTgg84THCOFE6YEDyA6wDA+mVZU1Jke7uI3E
        jjnscDcehbsYcLIDxx7AgzgmrX/I1Ml3V9JTcGlNb+xJhhB4UiynyXS4y2wSwl1lzX8OJl
        NQaJw47b8YyWhWCfGBIn/6ohKJdHRuU=
Date:   Thu, 20 Jul 2023 08:47:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <25942dafbc7f52488a30c807b6322109539442cf@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, akpm@linux-foundation.org,
        paulmck@kernel.org, catalin.marinas@arm.com, rdunlap@infradead.org,
        peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20230720082517.GA7057@lst.de>
References: <20230720082517.GA7057@lst.de>
 <20230712074758.1133272-1-yajun.deng@linux.dev>
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

July 20, 2023 at 4:25 PM, "Christoph Hellwig" <hch@lst.de> wrote:


>=20
>=20It turns out this doesn't apply at all. Can you resend it against
> Linus' latest tree?
>

It's based on linux-next tree.

This patch should be after my other patch in linux-next tree.
a960925a6b23("dma-contiguous: support per-numa CMA for all architectures"=
).
