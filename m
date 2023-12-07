Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59703809257
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443901AbjLGUcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:32:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91DB1710
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:32:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB37C433C7;
        Thu,  7 Dec 2023 20:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701981177;
        bh=Czicd5N/eXaMLjTilbeZ1WUkn0YbvQTJzzOKqY7RemA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kW81JGLc1cjb9TaxSmqDV2nxeQjeYaPVfVhNAtH2tZ81Y3GWgXgHZAY0rOWblhVYv
         YOql0kFfBUFjj9v9eZ4MHZtx/Osz2FBORYVcLOC5JphinYn/42k064IrOAFY9vQyYY
         eCkTadcdQephXqlSuGRJ/wp4L7QHOd7/Mnp5giuMWCyP4GIUUw5PDwcdFenWq/gxpn
         282pHAsjgL2blUaHo6nbYDaq97UHuM6O8oP8brwLiA3qQM+d4JjPiJeqwotrtkI5Fz
         toOtfsjaGqAt52VztbWiIENZW034Ckx3N1Sz0KNDUgo2ITm9Cs+kwIcQ0yWv+7vhWh
         bfM0GKuCXcCeA==
Date:   Thu, 7 Dec 2023 12:32:56 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        davem@davemloft.net, edumazet@google.com, greg@kroah.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v6] net: usb: ax88179_178a: avoid failed operations when
 device is disconnected
Message-ID: <20231207123256.337753f9@kernel.org>
In-Reply-To: <d8c331dd-deb1-4f12-8e66-295bfac8b1d7@rowland.harvard.edu>
References: <0bd3204e-19f4-48de-b42e-a75640a1b1da@rowland.harvard.edu>
        <20231207175007.263907-1-jtornosm@redhat.com>
        <d8c331dd-deb1-4f12-8e66-295bfac8b1d7@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 15:23:23 -0500 Alan Stern wrote:
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

FWIW I'm expecting Greg to pick this up for usb.
