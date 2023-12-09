Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A180B154
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjLIBPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIBPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:15:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F80E1720
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:15:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B66CC433C9;
        Sat,  9 Dec 2023 01:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702084544;
        bh=pS7MlfNbwl/Fhu3GrSIjw0yO1cc0pZZG21Lsn10Aahk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YnBjlmg9axdBsBOudX3MhpFZxt5NM0IClStBSJBRD1fkcfmkwot7ga0Gkqx+C3ZF/
         +uv8zET9hz0fLr/b9Hw4jhhbroBrEqtj9HDlqZhdhmUkfRWsbEDPbMM0IwcfcbdC5m
         TnKEH6fG931dw8l+RlujMQsKF8uIw2vhHT7iJQVWN/69YDEIn44sWIE3nx9r9ZZ0dK
         ZyrZaYVL0mSXCCRxwzGHW9fbaS/paBfpvjvfYkNCoisXBqMPKBZznWJb4yIyHUW+0s
         o3NrD3DhFYj7Inn/cozQb1eKNStRTLvu3JlwfD44OK4ZppHbYev42RVMDaemcYfbx2
         e/iw5EnKCT+aw==
Date:   Fri, 8 Dec 2023 17:15:42 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 04/12] iavf: kill "legacy-rx" for good
Message-ID: <20231208171542.30699419@kernel.org>
In-Reply-To: <20231207172010.1441468-5-aleksander.lobakin@intel.com>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
        <20231207172010.1441468-5-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Dec 2023 18:20:02 +0100 Alexander Lobakin wrote:
> Ever since build_skb() became stable, the old way with allocating an skb
> for storing the headers separately, which will be then copied manually,
> was slower, less flexible, and thus obsolete.

This one has a conflict on net-next :(
-- 
pw-bot: cr
