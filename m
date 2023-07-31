Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E651B768B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGaFzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGaFz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:55:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208FF10C;
        Sun, 30 Jul 2023 22:55:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2D18567373; Mon, 31 Jul 2023 07:55:24 +0200 (CEST)
Date:   Mon, 31 Jul 2023 07:55:24 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung Choi <j-young.choi@samsung.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] bio-integrity: create multi-page bvecs in
 bio_integrity_add_page()
Message-ID: <20230731055524.GA30066@lst.de>
References: <20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p1> <CGME20230728075537epcms2p194154023a4cdbe37c0346ef1102d1d63@epcms2p7> <20230728075753epcms2p7354d445f1888ab3942a16e26a13d5bbd@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728075753epcms2p7354d445f1888ab3942a16e26a13d5bbd@epcms2p7>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 04:57:53PM +0900, Jinyoung Choi wrote:
> Allow bio_integrity_add_page to create multi-page bvecs, just like
> the bio payloads. This simplifies adding larger payloads, and fixes
> support for non-tiny workloads with nvme, which stopped using
> scatterlist for metadata a while ago

Missing dot at the end of the sentence here.  Also the commit log feels
very short to me for such a substanial change, although even thinking
hard about it I'm not entirely sure what would be missing, so it's
probably fine..

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
