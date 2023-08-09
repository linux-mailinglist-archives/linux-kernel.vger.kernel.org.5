Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E1E776C45
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjHIWh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjHIWh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:37:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5990E7C;
        Wed,  9 Aug 2023 15:37:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0075668AFE; Thu, 10 Aug 2023 00:37:04 +0200 (CEST)
Date:   Thu, 10 Aug 2023 00:37:03 +0200
From:   hch <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     hch <hch@lst.de>, Stephan Wurm <stephan.wurm@a-eberle.de>,
        linux-block <linux-block@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Eigner <johannes.eigner@a-eberle.de>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
Message-ID: <20230809223703.GA10719@lst.de>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm> <1293911429.1782934.1691445776353.JavaMail.zimbra@nod.at> <20230809135308.GA32214@lst.de> <ZNOec8JmndA63Mnh@PC-LX-Wurm> <20230809141542.GA32614@lst.de> <366198994.5052941.1691620484888.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366198994.5052941.1691620484888.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 12:34:44AM +0200, Richard Weinberger wrote:
> Will do so! So far I managed to get UBIblock work with scsi_kmap_atomic_sg().
> Sadly now with kmap'ed memory a bounce buffer is needed since IO in UBI/MTD can sleep.
> Is there a strong reason why scsi_kmap_atomic_sg() needs IRQs disabled?

I don't think it needs irqs disabled.  Also if you switch from the
deprecated kmap_atomic to kmap_local first you can sleep and don't
need bounce buffers.

