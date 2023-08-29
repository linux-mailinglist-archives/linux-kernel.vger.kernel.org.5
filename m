Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC3978C674
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjH2NuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbjH2NuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8689BC5;
        Tue, 29 Aug 2023 06:49:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BA2A6203B;
        Tue, 29 Aug 2023 13:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C8FC433C7;
        Tue, 29 Aug 2023 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693316996;
        bh=LW/rSLFckewbOBZpi29c0fTrIq1ojmvBBFxON5lCxYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diAWWcbwvgx6CeLY/0wNDuVkm+HffgLJQBZM/AUzqPVBW4rixmBxDQMGkF3qWDwvj
         qqDGo8sU9eRPT+JFUzcU4tIOULssXYx3foZw2BSCOjtrYI+aYDPAQJRqF61cVckujw
         gRCNI9baO9oi4U4ltgjzu754DwgnhE7WuGkHcUKM=
Date:   Tue, 29 Aug 2023 15:49:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2] usb: xhci-plat: fix usb disconnect issue after s4
Message-ID: <2023082933-dispersed-quench-bd26@gregkh>
References: <20230809095826.18183-1-zhuyinbo@loongson.cn>
 <c2ee56a6-01af-931e-c766-7fe03e78eb57@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ee56a6-01af-931e-c766-7fe03e78eb57@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 08:43:18PM +0800, Yinbo Zhu wrote:
> 
> 
> Friendly ping ?

It's the middle of the merge window, I can't take anything new until
after -rc1 is out.

thanks,

greg k-h
