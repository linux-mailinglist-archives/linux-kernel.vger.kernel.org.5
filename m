Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7867F9C89
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjK0JXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjK0JXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:23:31 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA465DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:23:37 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 9C98B1A5C8A;
        Mon, 27 Nov 2023 10:23:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1701077015;
        bh=5XvWu4SCjTGmDrrNKE1KatUlot8/Q88rx/yko7yl438=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTgipGR59rmL4c5iInY8POzIwIYNn+7dtsMPdnAiT+wI1MyLeJGg/gbPZ50RiNMlg
         BVezA45Ab25KMBx2phDRol4RQ9m06UGDmY0Of7RU0gdJ7vBNlcWkysXrIG9alj0dde
         r7Hu85H0/pTCI1LcLfcKzhDUlR5l1X34CG54/a7iVXuAfRVk+D/bkTT4g3a4qyBNgO
         WROWEtbwg6j6p/Fm7mr9rIC+JCJXvn4wOfSFX1gMKAYPKT0mbACiEze2/zk1UiR1gh
         RHhumhb5dk16chHT5Z1XpCXKbyPmcA4jMRHbcnAha8kgYaPcfGqWPTjeLGh4e4KJOp
         imBi7XRaqHZLA==
Date:   Mon, 27 Nov 2023 10:23:34 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     will@kernel.org, robin.murphy@arm.com, treding@nvidia.com,
        jgg@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu: map reserved memory as cacheable if device is
 coherent
Message-ID: <ZWRgFjIvnuzj5URP@8bytes.org>
References: <20230926152600.8749-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926152600.8749-1-laurentiu.tudor@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 06:26:00PM +0300, Laurentiu Tudor wrote:
>  drivers/iommu/of_iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.
