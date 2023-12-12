Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E73180F17D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjLLPwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376969AbjLLPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:25:48 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7FC10B;
        Tue, 12 Dec 2023 07:25:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 47F9B68C4E; Tue, 12 Dec 2023 16:25:44 +0100 (CET)
Date:   Tue, 12 Dec 2023 16:25:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 03/14] page_pool: avoid
 calling no-op externals when possible
Message-ID: <20231212152543.GA19879@lst.de>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com> <20231124154732.1623518-4-aleksander.lobakin@intel.com> <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com> <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com> <534e7752-38a9-3e7e-cb04-65789712fb66@huawei.com> <8c6d09be-78d0-436e-a5a6-b94fb094b0b3@intel.com> <4814a337-454b-d476-dabe-5035dd6dc51f@huawei.com> <d8631d76-4bb3-41a4-a2b2-86725867d2a9@intel.com> <6c234df1-d20a-812e-3c58-7e3941d8309b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c234df1-d20a-812e-3c58-7e3941d8309b@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:20:44PM +0800, Yunsheng Lin wrote:
> I would prefer we could wait for the generic one as there is only about one
> month between now and january:)

Same here.  Please fix this properly for everyone instead of adding
a pile of hac
