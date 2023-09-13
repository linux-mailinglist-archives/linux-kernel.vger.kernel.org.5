Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A563879E7E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbjIMM1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbjIMM1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:27:03 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AD419A8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:26:59 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 10A4116D705;
        Wed, 13 Sep 2023 14:26:57 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1694608017; bh=l2P3vuYEXp8YYXF7TcGLCAflguOs4M8Iw9ghGrNwm+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vndP0sDBhJr4VQYNperhPevNZ5jfin8s2dQrJTBbaQUNEInznbdhVMPC1/bOej7lF
         COgkx2U4rtksBq0xIoHqsE+Lv1yUeodoyllWJmycFGli6as2M44hfwCOESMtGwmCxg
         NyO4Z6Hm88nLvkemT5wKU+MByf0sB+8rmDDzwzLpVqbePStPt3tpTbusWwY1b1qblK
         o6Adl7XpZLspGEWdc/arJDsCJWo7hIVZlqyFogJ0hPBPNqz60jpxi0QlmWZll2yuyd
         eZ53H08QGbFBX6CfBjHo+Ug92ljptB5zBSDoRYmjkbcvgXWulBNVqUkf30BpONXHtU
         qvc0lfwRzQRJQ==
Date:   Wed, 13 Sep 2023 14:26:56 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] swiotlb: fix the check whether a device has used
 software IO TLB
Message-ID: <20230913142656.29e135d6@meshulam.tesarici.cz>
In-Reply-To: <20230913121403.GB4544@lst.de>
References: <20230913114016.17752-1-petr@tesarici.cz>
        <20230913121403.GB4544@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 14:14:03 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Thanks, I've applied this to get it into linux-next ASAP.  I'd love
> to have reviews before sending it on to Linus, though.

Fully understood, given my past record. ;-)

@Catalin Marinas: I have added you to the list of recipient, because you
spotted some issues with memory barriers in one of my previous attempts.

Petr T
