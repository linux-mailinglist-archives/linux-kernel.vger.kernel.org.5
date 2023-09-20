Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B857D7A7215
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjITFdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjITFdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:33:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD69AA3;
        Tue, 19 Sep 2023 22:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/CINST4ityXNhoVAarY5lh3k37tzzTDhSRd3Om7kDGY=; b=pay/pzmq20ZtMt6njYaMbIU+55
        tdQx+nb+/IK8wkalRicItEgCWtP5FEE+vv2Hi3aLZf9aGKU44QdPNPH+37XR6OW9uY1tflHh/TGts
        jwSWRPs3pB5e3TM0aYrFd0qqRQnwPq4DGdvY1nYmX5qsfHxcW9sVmiTEhUiOe71Z9dJhbvHQc/zgN
        9dKuXA2h04iFod3bpENWTDQOdegWco+8lkpX2aMLfAkBXz3Il7SKRoXwJ5Sc791XvISHxj/i1QVeD
        aTTny4QAYio0jJPogihDBSIsdpDYRCkvucO5ofMhyrHIeHOc8ncsEN79MDeJCd4/sNr0YzgFHis8H
        3hbeFYoA==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qippX-001vFZ-2f;
        Wed, 20 Sep 2023 05:32:55 +0000
Message-ID: <4c84eb7b-3dec-467b-934b-8a0240f7fb12@infradead.org>
Date:   Tue, 19 Sep 2023 22:32:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Sep 20
 (drivers/net/ethernet/intel/idpf/idpf_txrx.o)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alan Brady <alan.brady@intel.com>
References: <20230920133714.351f83f9@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230920133714.351f83f9@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/23 20:37, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230919:
> 
> The mm tree lost its boot warning.
> 
> The drm-misc tree gained a conflict against Linus' tree.
> 
> Non-merge commits (relative to Linus' tree): 6006
>  3996 files changed, 459968 insertions(+), 111742 deletions(-)
> 
> ----------------------------------------------------------------------------

on arm64:

when CONFIG_NET is not set:

aarch64-linux-ld: drivers/net/ethernet/intel/idpf/idpf_txrx.o: in function `idpf_rx_rsc.isra.0':
drivers/net/ethernet/intel/idpf/idpf_txrx.c:2909:(.text+0x40cc): undefined reference to `tcp_gro_complete'


-- 
~Randy
