Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53ED7A902B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjIUAdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIUAdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:33:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9127EA3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 17:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YLE/ocZi0x861oQuFVNwlX4NFF2oFei3Xl9PzOSuTg0=; b=1lJizZJ/Q44dgn1TRWzFFyGV9T
        Px5r0aDdLdmHdKceo8ZisIHvvw4nSy9OCAd1V6BTtn132d6pQVcnV+tOD2HuArODvA2lhM/cs0z2N
        jJGHMJW1efGWYnzfW9lZZGLCVUn8PJYXcikux3SkGGpKJ+JmjdDi60b7Skw67bP9MwKsRR04PLiFA
        /SxiuLWOVrHGjN1xTOVYcn+M5LwkzVgXHy5t+Co6ArEN4fn+dEfvOefuZhjWkf6DGPm6dxfJV6Ozd
        3hUfejlcYXHCB/kjjykP22cRGruX6XWByQnxE2xfLdNq4calx6bsK3pg6nb+v6yx6euCgj/1WaVp3
        sBUzq/YA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qj7cl-004Y3z-1H;
        Thu, 21 Sep 2023 00:32:55 +0000
Date:   Wed, 20 Sep 2023 17:32:55 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()
Message-ID: <ZQuPNzgJfPILOTHq@bombadil.infradead.org>
References: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
 <ZQiBhRCGG13CNWqt@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQiBhRCGG13CNWqt@smile.fi.intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 07:57:41PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 12, 2023 at 06:05:46PM +0300, Andy Shevchenko wrote:
> > Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> > should only use sysfs_emit() or sysfs_emit_at() when formatting the
> > value to be returned to user space.
> 
> Any comments?

What tree were you taretting, looks sane to me.

  Luis
