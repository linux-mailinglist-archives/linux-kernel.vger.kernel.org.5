Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3106D757DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGRNkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjGRNkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B6DE5;
        Tue, 18 Jul 2023 06:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDDD7615A0;
        Tue, 18 Jul 2023 13:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34D1C433C7;
        Tue, 18 Jul 2023 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689687620;
        bh=/OS496YBy+5JqnR0vuyG56/C1HZH898leTrQ9TTujcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDW55LDifwdboqgAdNyvB8cOzOLcTbOS++Cifqtau0h2pyx2VurtG8Te69sY7vlq2
         hhcMhxYaoqmTWj4StS2t19EVdbUo/T57+38WxqkUqJjL1XYThAp1T9ll2P58cKeBsx
         vUSkX+d+DkShyNAl/0zcNNwSR6apNQuy69RiyykM=
Date:   Tue, 18 Jul 2023 15:40:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (oxp-sensors) Move board detection to the
 init function
Message-ID: <2023071808-power-rise-930c@gregkh>
References: <20230717222526.229984-1-samsagax@gmail.com>
 <20230717222526.229984-3-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717222526.229984-3-samsagax@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 07:25:16PM -0300, Joaquín Ignacio Aramendía wrote:
> Move detection logic to the start of init() function so we won't
> instantiate the driver if the board is not compatible.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> ---
>  drivers/hwmon/oxp-sensors.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
