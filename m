Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5018476A1C1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGaULM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGaUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:10:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D11BF9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:10:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F65C68AA6; Mon, 31 Jul 2023 22:10:47 +0200 (CEST)
Date:   Mon, 31 Jul 2023 22:10:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     August Wikerfors <git@augustwikerfors.se>,
        Keith Busch <kbusch@kernel.org>, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
        David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <20230731201047.GA14034@lst.de>
References: <20230731185103.18436-1-mario.limonciello@amd.com> <ZMgHE2wu4T4OfrTR@kbusch-mbp> <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se> <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 03:09:08PM -0500, Limonciello, Mario wrote:
> So is it reasonable to just add a check for
>
> ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP
>
> In the same error handling path as this patch?

No.  There are tons of NVMe devices that only support creating and
deleting namespace out of band, especially in virtualized and cloud
setups.
