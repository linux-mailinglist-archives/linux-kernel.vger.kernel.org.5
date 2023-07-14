Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE3753CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbjGNOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjGNOJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:09:23 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DB9AA2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:09:22 -0700 (PDT)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id A363D28012A;
        Fri, 14 Jul 2023 16:09:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1689343760;
        bh=M0SoCIDigrh34C8zCDczRKfN4d2BWxv9UemPawpMyzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PiIRHazyMSRJ5zVVXJ3d6lwTAB9US7oCcdFwtoq0o/7dWHXrd/FmscTbP5T3StLSn
         29q9QXhsW4g/LTXkIUSjUO6NOMBEfN8Iu2gcrxI0wP01YgV3y/HDjaUMcn1rHOU8Yq
         UuMq4VkiuYRmcPQ7dkL7PbveQ/LyfXyyot1pDQ8rGT+91xtBqicpxtNnDdWIOSaKqN
         3vOye471ooKK7U1U1Ot3EM4Rg2NgiSH5S1pRjmeELQuKUCor8pxVnqnF3eFcJokDkT
         iJy/B5TGib0yV7wLejswTpkXV2ZjPFSh4LxNqpqxO3hx1D6fbzvNKDu4psEUqiurUl
         +8tN/uOYBPG0g==
Date:   Fri, 14 Jul 2023 16:09:19 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Message-ID: <ZLFXD0WNDTCU5fHp@8bytes.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 02:40:25PM +0100, Robin Murphy wrote:
> To that end, implement a flag to refine the SAC business into a
> per-device policy that can automatically get itself out of the way if
> and when it stops being useful.

It is summer time and it may be the heat, but I am in a brave mood and
decided to give this a shoot. I applied it to the core branch and will
push it to linux-next for testing.

Regards,

	Joerg
