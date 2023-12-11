Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4933280CE44
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbjLKOXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbjLKOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:22:59 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3361030EA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:22:03 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id E50E01A3EBC;
        Mon, 11 Dec 2023 15:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1702304522;
        bh=IkGeRoV4YK3/w+vDOMHedoYysVVERefkq3baaHIOGpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8+L31TinSHv4eBKtTIQ/Kw0WZsDpYPHepdvhPSwXg6wvf2lZh0YgGlFfHKGaYILy
         XoyqTIFugqoVLunbKHHksRxpTmrCFT+h0BNTpAcobKiv0Q5puXpE5u6g0L5iXYC0V4
         RwtWbP9TwupnUv/S2YfUfK0Eh9Txp79POYJyyc4QhdRBBBW29QEe8S1wzhz1glAB+y
         A7hsxzmaVGbNWs7TnJvFiU6ZFQisoJUbPKBAjz8wcoXkqKwCagxikQZrez6NQTJe31
         HopSIh/qrIv2FLzQRt3podYDoRbi7r+MenhTD/3UeaWIB7lW+QBPGyoKc1dCG8HQjF
         Kx51tG08UXUCA==
Date:   Mon, 11 Dec 2023 15:22:00 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        mlevitsk@redhat.com, seanjc@google.com, vasant.hegde@amd.com,
        jon.grimm@amd.com, santosh.shukla@amd.com,
        joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH] iommu/amd: Do not flush IRTE when only updating isRun
 and destination fields
Message-ID: <ZXcbCLKJbM7Udpcy@8bytes.org>
References: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:42:36AM -0500, Suravee Suthikulpanit wrote:
>  drivers/iommu/amd/iommu.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

Applied, thanks.

