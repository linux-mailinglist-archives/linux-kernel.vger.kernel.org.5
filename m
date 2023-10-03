Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14F87B73FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbjJCWMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjJCWMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:12:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D02A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 15:12:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566CCC433C7;
        Tue,  3 Oct 2023 22:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696371137;
        bh=q6Dyt5FLueLuidAVO6CSqngPH4jdGpeS1FwXNN8jOvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BgdwRZUzLtjU1j502sgJEyqQ+dYb74+GZ33d6lrbtWVhyrhZl1zsmLq4V+JhBesuQ
         Ajj0lSVsuSnt1/rb98YiNlkZVMEI+X5noSJsxbhKxHeuykAPkOSIq97q0vDbtf6O5Z
         QDPcPDN7QnVs5iJYlgBl/fFe5X97mjKLKuNvm0THOPeHMxHito0MX57FLWdkcItY8N
         ewLjJNeOMaT847b4fLqG+1bc5aLhKT4NYY1EQYBtA++jDcGczHDOKFSCGX2ICo0DKQ
         q+eZ+V3PfenUripubJ+kl3FiEZjQTeLy8qiMGDEPwzBwKiQQ+XzOJKJaZjbe4ZO8bK
         I2MaOl5PaWoFw==
Date:   Tue, 3 Oct 2023 15:12:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Liang Chen <liangchen.linux@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v10 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
Message-ID: <20231003151216.1a3d6901@kernel.org>
In-Reply-To: <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
References: <20230922091138.18014-1-linyunsheng@huawei.com>
        <20230922091138.18014-2-linyunsheng@huawei.com>
        <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 09:45:56 +0200 Paolo Abeni wrote:
> I think it would be nice also an explicit ack from Jesper and/or Ilias.

Also a review tag from one or both of the Alexanders would be great!
