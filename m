Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B38D7F5F78
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345375AbjKWMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345369AbjKWMwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:52:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037061BF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:52:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9131AC433C7;
        Thu, 23 Nov 2023 12:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700743976;
        bh=LHLHykxtIY2xxp+TU7ZVrj990Mtu/u0AeZhrUyYHGvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQ8R7LoBhZ7EK6WnOltHoEC/NN/TSrT/yOilyqvE1NAO4f+THqV6cXgmpq9/qzeE3
         jtNZ1vWaHgTGqBF9w7uyZkWle8CkUP+3CuG5C6kj+MIBzsh7au2eYQH4NNrx2BkgXs
         E8l2pT9hdxQOqNt+m6GgpRCjmvxRdgwGbXHV0ER0=
Date:   Thu, 23 Nov 2023 12:47:06 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        linux-i2c@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] drivers/staging/greybus/i2c.c: Don't let i2c
 adapters declare I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Message-ID: <2023112359-urgency-flashbulb-b870@gregkh>
References: <20231118180504.1785-1-hkallweit1@gmail.com>
 <20231118180504.1785-3-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118180504.1785-3-hkallweit1@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 07:04:56PM +0100, Heiner Kallweit wrote:
> After removal of the legacy eeprom driver the only remaining I2C
> client device driver supporting I2C_CLASS_SPD is jc42. Because this
> driver also supports I2C_CLASS_HWMON, adapters don't have to
> declare support for I2C_CLASS_SPD if they support I2C_CLASS_HWMON.
> It's one step towards getting rid of I2C_CLASS_SPD mid-term.
> 
> Series was created supported by Coccinelle and its splitpatch.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> ---
>  drivers/staging/greybus/i2c.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
