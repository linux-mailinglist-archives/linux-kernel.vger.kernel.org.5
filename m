Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7852D75F64E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGXM2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGXM2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:28:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABFFE73
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:28:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C6260F19
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C76AC433C7;
        Mon, 24 Jul 2023 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690201717;
        bh=fTeuDC6FLvsDn/nWMSpZM6lpOWDKYoRZxVyr5w1xGOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5pHyqjn6kZq+5c2D96u1UTZ9ZmQXQjrqKl1ju4lNKsK0zPFdZQboUGssgy95O+Ut
         J0kXc0fpk8tbAKJg1BBFmyf0xf5HXq9Z60XBhJLbSz5soAkwox3NLu4rWGsa6AAVfU
         JlmlDoj1yV9kN3jnyoPIAa47r45suB9bi1ArLCpU=
Date:   Mon, 24 Jul 2023 14:28:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     linux-kernel@vger.kernel.org, git@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com
Subject: Re: [PATCH v3] cdx: add support for bus mastering
Message-ID: <2023072447-slaw-spiffy-51ba@gregkh>
References: <20230724120433.15910-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724120433.15910-1-nipun.gupta@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:34:33PM +0530, Nipun Gupta wrote:
> Introduce cdx_set_master() and cdx_clear_master() APIs to support
> enable and disable of bus mastering. Drivers need to use these APIs to
> enable/disable DMAs from the CDX devices.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> ---

You are adding apis here that no one is actually using, making it pretty
impossible to see if they are being used properly, or if they are even
needed at all.

Please submit this as part of a patch series that uses the apis,
otherwise there's no need for anyone to accept this patch.

thanks,

greg k-h
