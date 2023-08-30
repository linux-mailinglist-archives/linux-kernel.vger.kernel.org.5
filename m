Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44E78DF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343980AbjH3T0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245135AbjH3Ods (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:33:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D29193;
        Wed, 30 Aug 2023 07:33:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0957867373; Wed, 30 Aug 2023 16:33:42 +0200 (CEST)
Date:   Wed, 30 Aug 2023 16:33:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Anle Pan <anle.pan@nxp.com>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, hui.fang@nxp.com,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Message-ID: <20230830143341.GA25574@lst.de>
References: <20230828075420.2009568-1-anle.pan@nxp.com> <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com> <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com> <20230829150442.GA3929@lst.de> <CAAFQd5CiHXvsJugSi+hXY9ESsmxUzBzmbhF6G48iVsOcL5eMtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5CiHXvsJugSi+hXY9ESsmxUzBzmbhF6G48iVsOcL5eMtQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:47:57PM +0900, Tomasz Figa wrote:
> Do we see anything replacing it widely anywhere on the short-middle
> term horizon? I think we could possibly migrate vb2 to use that new
> thing internally and just provide some compatibility X to scatterlist
> conversion function for the drivers.

Jason said at LSF/MM that he had a prototype for a mapping API that
takes a phys/len array as input and dma_addr/len a output, which really
is the right thing to do, especially for dmabuf.

Jason, what's the status of your work?
