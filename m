Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763AC76851A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjG3LjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG3LjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:39:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EC31BC;
        Sun, 30 Jul 2023 04:39:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A325160C1E;
        Sun, 30 Jul 2023 11:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37DDC433C8;
        Sun, 30 Jul 2023 11:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690717150;
        bh=qMWIU+f5yjvvP0Z6YT5sLX6EstSebAQh9vRstxRwT24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFcBX5MgCppgO2SzzMLDXtla6lHT9VxURUoMFbCIUzbQ3cQUhkO9pgTYYDmjpDa00
         NoE7vR5gEJkpWu/8iHLE/UEGal6Fl2GnBIBaiBFqlho2Fy3OZSu1XpsNAa9pJwqLCK
         mxP4JHL6ijpQNzySF/SsGEOdU50Osfn2PRspchAM=
Date:   Sun, 30 Jul 2023 13:39:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH 01/22] Input: cros_ec_keyb - use device core to create
 driver-specific device attributes
Message-ID: <2023073050-syndrome-abreast-391f@gregkh>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 05:51:10PM -0700, Dmitry Torokhov wrote:
> Instead of creating driver-specific device attributes with
> devm_device_add_group() have device core do this by setting up dev_groups
> pointer in the driver structure.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

All of these look great, thanks for doing them:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

