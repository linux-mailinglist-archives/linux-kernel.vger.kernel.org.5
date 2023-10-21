Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2347D1E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjJURSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjJURSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:18:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3437E5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:18:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3180BC433C9;
        Sat, 21 Oct 2023 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697908697;
        bh=1jJLkfQFRdwlc6uR8h0OoDnZjlKewWJVl/5PyS9siHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGrABgB2Nz+5Gq00dyRMwIUGb+FZFyqgRQ04mSQkDcmNbc3COVMZBcXrfL1voGfeb
         GUcwO7DOqnsRejVNN+Vna2Si3hAUDr5JxZNOBR9wdgYDcFYFSo7yfdZqNu3slb+XPD
         X/w5+TPJceTtZvpEQW3SpY0Ix0KfCpqbpr2tNxtE=
Date:   Sat, 21 Oct 2023 19:18:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/6] Revert "nvmem: add new config option"
Message-ID: <2023102100-tile-spinning-fa1b@gregkh>
References: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
 <20231020105545.216052-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020105545.216052-5-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:55:43AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This reverts commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f.
> 
> It seems that "no_of_node" config option was added to help mtd's case.
> 
> DT nodes of MTD partitions (that are also NVMEM devices) may contain
> subnodes that SHOULD NOT be treated as NVMEM fixed cells. To prevent
> NVMEM core code from parsing them "no_of_node" was set to true and that
> made for_each_child_of_node() in NVMEM a no-op.
> 
> With the introduction of "add_legacy_fixed_of_cells" config option
> things got more explicit. MTD subsystem simply tells NVMEM when to look
> for fixed cells and there is no need to hack "of_node" pointer anymore.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Why isn't this also marked for stable trees?

thanks,

greg k-h
