Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90057CD689
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344651AbjJRIbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjJRIbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:31:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD3FC6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:31:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07306C433C7;
        Wed, 18 Oct 2023 08:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697617892;
        bh=ZaFTrm6vAmtjqP5iNcp9wlgpbS/wn22o1q7nRAq9XZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0iwZ43JxbY6cQT/a3/P4Az87awZg5egm3VM/VcXX6k0dcqUHebGpF9TaJiq41blw
         d0ovbvLBSpI3wt+WAAFbEr8EJ8rg6HBxtEDUX2RWukz3he0AIvjx6OvzTjMpIyEumM
         4eg6a6oVx6kGBLhJaol920fdvyEBfi1eZ8gFZOo4=
Date:   Wed, 18 Oct 2023 10:31:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH 0/5] mlx5 ConnectX diagnostic misc driver
Message-ID: <2023101858-underwire-donated-3ae9@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018081941.475277-1-saeed@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:19:36AM -0700, Saeed Mahameed wrote:
> Historically a userspace program was used that accessed the PCI register
> and config space directly through /sys/bus/pci/.../XXX and could operate
> these debugging interfaces in parallel with the running driver.
> This approach is incompatible with secure boot and kernel lockdown so this
> driver provides a secure and restricted interface to that.

Why not just write a UIO driver for this hardware then?

thanks,

greg k-h
