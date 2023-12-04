Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E57803A90
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjLDQkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjLDQkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:40:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3929DB0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:40:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08960C433C7;
        Mon,  4 Dec 2023 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701708015;
        bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jt8rZZvg35YTBKyt8lr79LVY1IsyDbbDXXp2bBgAzEBAsPcUZ8cj9zoBD31JWUsXu
         0novmI5RcoAJyEzbDANCABfJj6uWrOOwgG2ImO7sVgW6lnj5AziqaNCWV8FD93flRo
         vqwA7LdpsOkFxTdXxzvma58vCR8ShwVOf0LslWzEafuul9VOULfV2cCI/QUwJYYLpb
         x+ZvGi3zaGqx3jiO7NwJGcDfFudpiUE1w4eDmZWMXZQcDkGI/G0O65+W1hx9y9ZNWE
         sHEgfWbhf+1HYNb4LvYO04ZtQhmyotUlhD4DP32O3lqhE7l1P18tr6CRkvVFbUH4WY
         COLxCMTx3f+VQ==
Date:   Mon, 4 Dec 2023 09:40:13 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
        gost.dev@samsung.com, nitheshshetty@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: prevent potential spectre v1 gadget
Message-ID: <ZW4A7XYF5sVgcZ4l@kbusch-mbp>
References: <20231128122958.2235-1-nj.shetty@samsung.com>
 <CGME20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6@epcas5p2.samsung.com>
 <20231128122958.2235-2-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128122958.2235-2-nj.shetty@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to nvme-6.7.
