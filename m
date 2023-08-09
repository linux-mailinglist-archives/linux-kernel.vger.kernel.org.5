Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0157C7761D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjHIN4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHIN4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:56:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40F98
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B206167A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E1DC433C7;
        Wed,  9 Aug 2023 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691589368;
        bh=JlmnTYRkyCKAu72Dr0ArIxvge7wlJAGTJk4llf1Z1x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKqa43aEiNKTbA1zxSi5LJmiDduB9FYNJoY0LnMBWXTmNYhkZQBxoXniK3JTkdEJg
         +piz+sBf3Pbt3/18k8rafHMjIGOyGx+TNdKOK2Qrb4BxtDrLTvsarzmsimviXq+GvM
         j6+IK/bSlZdhwFnMJ2/sNo2zNHNA1RWsxoXsqwdYA1RugiMdEOcwd5b7551wp910Fl
         aHcDeZFUT9Yzhn2SpAw2qtWE26FNPKs7F/TsxbIDFhReYZUdpJE4aTJ8nEwhD460n+
         ABI1U2GZUMY95sPoE1Dlr7AtjIFFz+y9vu/IhEi6ltXVR9jrVCxe9VsSImuCYK5c0I
         pYw5iCAnWbNWw==
Date:   Wed, 9 Aug 2023 14:56:03 +0100
From:   Will Deacon <will@kernel.org>
To:     thunder.leizhen@huaweicloud.com
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>, jgg@ziepe.ca
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: Add support for ECMDQ register
 mode
Message-ID: <20230809135603.GE4226@willie-the-truck>
References: <20230809131303.1355-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809131303.1355-1-thunder.leizhen@huaweicloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:13:01PM +0800, thunder.leizhen@huaweicloud.com wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> v1 --> v2:

Jason previously asked about performance numbers for ECMDQ:

https://lore.kernel.org/r/ZL6n3f01yV7tc4yH@ziepe.ca

Do you have any?

Will
