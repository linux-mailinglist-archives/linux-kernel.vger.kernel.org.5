Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D727E622D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 03:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjKIC0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 21:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjKIC0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 21:26:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702CA26A5;
        Wed,  8 Nov 2023 18:26:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864A7C433C7;
        Thu,  9 Nov 2023 02:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699496780;
        bh=bvkrLtnAeHE0QC2OdmfX8Hg2tktQ7eKe6WDZsBHFo1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DUr3DwBIu27FhAKrid+Jirzy8lFaAV0ao2SEx4/SFo6q40YtjpLlneu/slcP93h0F
         kyXqzDD0cUFDJUG769F23SX5dH6/dYZVF3lKMdEvE+p5zW0yyugCc0H0d3IdAsoLn4
         iFTD9mdC9sHQwo39naD8w0oqdguPdY+TGnGc5VCwCKoZ4o9djS8ZXxvB8r3sbCCL5M
         KuhDPO/wZcC9N5bc6CPsN9aRjWfsUOFx4VIJLc0dvyToz1Bla6ayDV8o+G0G62iIhX
         c1F2YnqyhdnTGMtGdEz4dn7Bkw6wuHup1xZMVLyMaGpR/e6dZ4hzQZOTcbPs5RYDr2
         m7xb2/QMUYmlQ==
Date:   Wed, 8 Nov 2023 18:26:18 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net,v3, 2/2] hv_netvsc: Fix race of
 register_netdevice_notifier and VF register
Message-ID: <20231108182618.09ef4dfe@kernel.org>
In-Reply-To: <1699391132-30317-3-git-send-email-haiyangz@microsoft.com>
References: <1699391132-30317-1-git-send-email-haiyangz@microsoft.com>
        <1699391132-30317-3-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Nov 2023 13:05:32 -0800 Haiyang Zhang wrote:
> If VF NIC is registered earlier, NETDEV_REGISTER event is replayed,
> but NETDEV_POST_INIT is not.

But Long Li sent the patch which starts to use POST_INIT against 
the net-next tree. If we apply this to net and Long Li's patch to
net-next one release will have half of the fixes.

I think that you should add Long Li's patch to this series. That'd
limit the confusion and git preserves authorship of the changes, so
neither of you will loose the credit.
