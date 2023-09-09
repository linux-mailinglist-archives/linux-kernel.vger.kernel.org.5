Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D821E799694
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 08:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbjIIGaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 02:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjIIGaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 02:30:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C311BC5;
        Fri,  8 Sep 2023 23:30:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A41AC433C7;
        Sat,  9 Sep 2023 06:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694241011;
        bh=CpMJD8Fdvs8i0D8AdgC4R4zpvfsPkNH72axloON+30w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T5UsbJFuKZi970QivQsGy+WAnofak/BvhTfrNYmE58IUhu7fjuG0ny6LhjfOqLEsv
         Y5idP9BwYDDBszi+L6rjpQ8PFmCceSNcXLvmS9nThoumqA9xFPRP23NLhh/ZXsNoSC
         WY3s242t5zOMeKWzCXV9+jZ1Awx+SaJGODZPa6EI=
Date:   Sat, 9 Sep 2023 07:30:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Wu <william.wu@rock-chips.com>
Cc:     Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, frank.wang@rock-chips.com,
        jianwei.zheng@rock-chips.com, yangbin@rock-chips.com
Subject: Re: [PATCH] usb: dwc3: core: Avoid resume dwc3 if already suspended
 in pm resume
Message-ID: <2023090938-bobbed-rearview-c406@gregkh>
References: <20230909040628.31398-1-william.wu@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909040628.31398-1-william.wu@rock-chips.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 12:06:28PM +0800, William Wu wrote:
> Change-Id: Ia699a1388b28baf9feeae316097c6c309db08b45

This is not needed.  Please always run checkpatch.pl on your patches
before submitting them.

thanks,

greg k-h
