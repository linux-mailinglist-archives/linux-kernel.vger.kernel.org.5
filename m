Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78F17A0159
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbjINKOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjINKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:14:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3B61BE9;
        Thu, 14 Sep 2023 03:14:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5EA6166072FF;
        Thu, 14 Sep 2023 11:14:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694686445;
        bh=OFvsdCQ1KzQj5G85fRFDOIGP6wxoxx66ab2XPVsGYNo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O5eUS/j1EBqT+GT8lG7w3gmWCXNr2WoXzTo1g6W1TgY2sSvzHB3bBi3TJdiAlBan4
         +WjXI2p4inBo+YqHFBQc/e86tTAYh+SSrDojVvTurYT4QYCNbcIp9RCBLdplp3BO4f
         0oQTHfsVeS3RffWfG5UPpm1qh6asxrLn4fw7I8NLK7YDoPsZa5ce501l6C4R/+OD1N
         n9z15xKyg7cdpENK/KbCGPyTsMgitMdqV8MarY+8xbWePdNJSK1QtS9PpGjVi3YfwM
         cZezC6cCVVTomAhDjI6+L+evhMvinI0oqdQxpDTHyq7BG2S0L0Mm/3Qb5mbUcn9Hvc
         vo8IGJqCve3/g==
Message-ID: <712ab5f3-eb61-f7e5-fc67-c6c175beaac0@collabora.com>
Date:   Thu, 14 Sep 2023 12:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] usb: xhci-mtk: add a bandwidth budget table
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230830122820.18859-1-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230830122820.18859-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/08/23 14:28, Chunfeng Yun ha scritto:
> In order to estimate when fs/ls transactions appear on a downstream bus,
> the host must calculate a best case full-speed budget, use a table to
> track how many bytes occure in each microframe.
> This patch is prepared for introducing an improved bandwidth scheduling.
> 

Hello Chunfeng,

it would be helpful if you add a cover letter with some test results for
the BW improvements that you're seeing here.

Thanks,
Angelo

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>   drivers/usb/host/xhci-mtk-sch.c | 113 +++++++++++++++++++++++---------
>   drivers/usb/host/xhci-mtk.h     |   4 +-
>   2 files changed, 85 insertions(+), 32 deletions(-)
> 

