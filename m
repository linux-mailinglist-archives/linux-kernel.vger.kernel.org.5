Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49DF76C9CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjHBJrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHBJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:47:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18211FF3;
        Wed,  2 Aug 2023 02:47:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B29368AFE; Wed,  2 Aug 2023 11:47:26 +0200 (CEST)
Date:   Wed, 2 Aug 2023 11:47:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     John Stultz <jstultz@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Pintu Agarwal <pintu.ping@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2] dma-contiguous: define proper name for global cma
 region
Message-ID: <20230802094725.GA28241@lst.de>
References: <1690598115-26287-1-git-send-email-quic_pintu@quicinc.com> <20230731112155.GA3662@lst.de> <CAOuPNLjnfq1JefngtNrg0Q+JdMTSRz+eEqxGQJFfx9+af+k9WA@mail.gmail.com> <20230801171838.GA14599@lst.de> <CANDhNCq+3OEosUcQJ5GFgk+5OyG+JqXKM43UAo0aPz-V27OgAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCq+3OEosUcQJ5GFgk+5OyG+JqXKM43UAo0aPz-V27OgAA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:39:04PM -0700, John Stultz wrote:
> So, forgive me, I've not had a chance to look into this, but my
> recollection was "reserved" is the name we see on x86, but other names
> are possibly provided via the dts node?

Indeed, dma_contiguous_default_area can also be set through
rmem_cma_setup, which then takes the name from DT.

> I believe on the hikey board its "linux,cma" is the name, so forcing
> it to reserved would break that.
> 
> Maybe instead add a compat config option to force the cma name (so x86
> can set it to "default" if needed)?


I think we'll just need to leave it as-is.  I with dma-heaps had never
exposed the name to userspace, but we'll have to lіve with it now.
