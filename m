Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68437FBA9A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbjK1M5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344416AbjK1M5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:57:17 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A169418F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:57:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 50D0D227A87; Tue, 28 Nov 2023 13:57:19 +0100 (CET)
Date:   Tue, 28 Nov 2023 13:57:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Jim.Lin" <jim.chihjung.lin@gmail.com>
Cc:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        jim.lin@siliconmotion.com, cj.chen@siliconmotion.com,
        david.yeh@siliconmotion.com, hardaway.tseng@sk.com
Subject: Re: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Message-ID: <20231128125718.GB7613@lst.de>
References: <20231128025737.53026-1-jim.lin@siliconmotion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128025737.53026-1-jim.lin@siliconmotion.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:57:37AM +0800, Jim.Lin wrote:
> SK Hynix BC901 drive write zero will cause Chromebook takes more than 20 mins to switch to developer mode
> "disable write zeroes" can fix this issue and Sk Hynix has been verified.

Did you test this on an upstream kernel with

ommit 1b96f862ecccb3e6f950eba584bebf22955cecc5
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Oct 30 16:50:15 2022 +0100

    nvme: implement the DEAC bit for the Write Zeroes command

included?  Or in ther words, does this drive not implement DEAC
or does it not work properly?  What are the chances of actually
fixing the fimware to work properly?  Also WZSL limit does the
drive report?
