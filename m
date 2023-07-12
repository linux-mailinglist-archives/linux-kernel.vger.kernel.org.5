Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0CD750E83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjGLQ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjGLQ1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC331BEF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8593361820
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6060DC433C8;
        Wed, 12 Jul 2023 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689179231;
        bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQbNWaOaEizbCcCcZdgGihct5HzRCHog1s+VqMGS+EM59SaGiND6CB+UHBR4e2cqU
         bibWgsMd7XC6Z6XAS7hND6S24BkQZrYsGND5kdRysFdmzLRybo4DcHGIAs/H8Bm/VV
         NjvPi5pMHb6QEMF/LKpIwx+F/fUO1unAMEIN+J2SrT01zSVi7fxpZBwl0UxZ/hSq/Z
         81QfPhMFbKzPE7XdW7cftF5hJy3151rIzjTHXENlSVhxl0PQ2KPenoZozudhYuUcCJ
         smUoJUUNszpTmuZqtzN/lKm1anNmd16WM0MkSayr6kUoGIiypiXAtqJhBvKdCt56qd
         t50DLHA4MdgCA==
Date:   Wed, 12 Jul 2023 10:27:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers: host: fix parameter check in
 nvme_fault_inject_init()
Message-ID: <ZK7UXdV0zmStHyyT@kbusch-mbp.dhcp.thefacebook.com>
References: <20230712111838.11923-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712111838.11923-1-duminjie@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks!
