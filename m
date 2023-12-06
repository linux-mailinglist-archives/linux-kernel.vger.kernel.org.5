Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F713806AA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346775AbjLFJYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346728AbjLFJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:24:18 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF8D40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:24:25 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B04CF227AA8; Wed,  6 Dec 2023 10:24:20 +0100 (CET)
Date:   Wed, 6 Dec 2023 10:24:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Georg Gottleuber <ggo@tuxedocomputers.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
Message-ID: <20231206092420.GA27348@lst.de>
References: <20230920085210.22573-1-wse@tuxedocomputers.com> <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What does save a lot of power mean, and why does it only apply to
some platforms?  I suspect the more likely case is that APST is
simply completely broken on this device?

