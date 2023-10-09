Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6377BE4AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377335AbjJIPY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377028AbjJIPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:24:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A73111;
        Mon,  9 Oct 2023 08:24:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1506C433C7;
        Mon,  9 Oct 2023 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696865061;
        bh=zuaUKR5hhGmNwxo4/WYo0MDrdfEbXYhaQqjlY5wORiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijsFJQuH3aqI/SBO5lAJCxZJVFXUWWC8FEhcyW6rTBoE3ZX6YlRNxaDUZpAeSOhY8
         E9HQvD7XLMGiHkRAixo5FoiPKrcQ+Q+DQHgHwHzZBOXceiQAvozpuQvIf1zymxNsuK
         iltc+PaLqQoeKlBHp8/KG8e06LmJJkQ6fv3N4MFo=
Date:   Mon, 9 Oct 2023 17:24:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/10] staging: ks7010: remove unused ioctl handler
Message-ID: <2023100913-various-doodle-cfd0@gregkh>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <20231009141908.1767241-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141908.1767241-4-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 04:19:02PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ndo_do_ioctl function has no actual callers, and doesn't do much here,
> so just remove it entirely as preparation for removing the callback pointer
> from net_device_ops.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
