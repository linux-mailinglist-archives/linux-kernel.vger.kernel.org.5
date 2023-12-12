Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9509C80E790
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjLLJ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:28:11 -0500
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B4DD5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:28:15 -0800 (PST)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id A5A5F15F8FB;
        Tue, 12 Dec 2023 10:28:12 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1702373292; bh=a1R8znDPERKpbzdxol/NMeaD5QrbDBEo3tdX50aZNJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AbZ6SLU3xnza6sfvA7U/POrVXxUf77pN2fSzktUQxFAJCSYQ9vX9xzdqVx5Exl+QJ
         FwEmU9CEwrrzh+gdMpXqGDtmw22l/I4ocI/+r4uAWtauhKYExsm2ckZl7rAR7CkDhn
         LCEEXdxrrnF/tVhZjsNpNRyRwqSLFCwCBRbMiFpANh6nIaOrldDqmX48IjdBbqdDkm
         zqFFocBMcwYw9sEWJ5JtfaVpDE+IFo6hhjvZ6mVnh8cPo6JBZv+aHzyxS3GLNJtp8L
         29tdUryzhAODYT4wXjPAPwfh1RESqAV1AGKFaog3wPEgZnokqykuUAyugx+NSHHmaC
         x8pdqO/X4O1mQ==
Date:   Tue, 12 Dec 2023 10:28:11 +0100
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH RESEND] swiotlb: reduce area lock contention for
 non-primary IO TLB pools
Message-ID: <20231212102811.7e700dbd@meshulam.tesarici.cz>
In-Reply-To: <20231211174020.GA28041@lst.de>
References: <20231201121352.195-1-petrtesarik@huaweicloud.com>
        <20231211140111.5dbb74c0@meshulam.tesarici.cz>
        <20231211174020.GA28041@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 18:40:20 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Dec 11, 2023 at 02:01:11PM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > Hi Christoph,
> >=20
> > just a friendly ping about the following patch. Does it need more time
> > to review, or has it gone lost? =20
>=20
> I've just been a bit too busy.  I'll do a run on dma-related things
> this week.

No problem. Thank you for quick status update!

Petr T
