Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB97768B73
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjGaF6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGaF6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:58:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF2BBF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 22:58:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0421567373; Mon, 31 Jul 2023 07:58:07 +0200 (CEST)
Date:   Mon, 31 Jul 2023 07:58:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
        hare@suse.de
Subject: Re: [PATCH 2/2] nvme-auth: set explanation code for failure2 msgs
Message-ID: <20230731055806.GB30150@lst.de>
References: <20230727134748.4163796-1-shiftee@posteo.net> <20230727134748.4163796-2-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727134748.4163796-2-shiftee@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:47:48PM +0000, Mark O'Donovan wrote:
> These error cases were not setting an auth-failure-reason-code-explanation.
> This means an AUTH_Failure2 message will be sent with an explanation value
> of 0 which is a reserved value.

I'll leave the final decision to Hannes, but shouldn't we find a common
place, either behind a label or in the body of the function to set
chap->status?  Having to add this in a lot of error labels doesn't feel
very maintainable.

