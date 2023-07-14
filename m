Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F08753D06
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjGNOTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjGNOTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:19:08 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7945B2D57
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:18:31 -0700 (PDT)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 047AA28012B;
        Fri, 14 Jul 2023 16:18:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1689344310;
        bh=x48tQJuhRIcBK8H22bowqvguJJwO4RiPk3c8qAoIwxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dp0bpR/TN6JUtC2kVopJCIWL6JgKs6ep/uDNil4nOncAjdx8i5643rC7XpfbQz/oJ
         wgX9d0iHrf47FXFmQrKlkn0a5k+oRW/Rjt5TwtyqQEDOR7pfTD8WHZw/UCRS/LIveP
         OSmROeqVdXZUilMAGUgu/5sGLXgLm49sLKwT7kn9SDvlImkJH9oNxb703qm7xKePAX
         PBM6w4VEduBYW2BkfgUdSLjpn1OFW1KX9lVucEWP0DXrMJnJfvV91CTMOIl4+y9qIW
         h9QFUSCMuH/lBX/VDf+rJh4J74YqmNnc7QumgOwcWATRgJkKv5DQt1+D14HLkRoQNi
         /TGV0Evt5GVKg==
Date:   Fri, 14 Jul 2023 16:18:28 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iommu: rockchip: Fix directory table address
 encoding
Message-ID: <ZLFZNH_6HIxkYS4n@8bytes.org>
References: <20230617182540.3091374-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617182540.3091374-1-jonas@kwiboo.se>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 06:25:43PM +0000, Jonas Karlman wrote:
> Jonas Karlman (2):
>   iommu: rockchip: Fix directory table address encoding
>   iommu: rockchip: Allocate tables from all available memory for IOMMU
>     v2
> 
>  drivers/iommu/rockchip-iommu.c | 50 +++++++---------------------------
>  1 file changed, 10 insertions(+), 40 deletions(-)

Applied, thanks.
