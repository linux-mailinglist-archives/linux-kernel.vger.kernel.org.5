Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396A57D89A7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344845AbjJZUWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjJZUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:22:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C41718A;
        Thu, 26 Oct 2023 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=wNTOQPV73Hy7MLtPhY+UIEup4Hnv+7LNNm+Nm3DMl9s=; b=C5acYAWr+JlIQF3tm2JBMkFctf
        iKB4BcOgS4y7zB0ARbGhV10KmvJ/EZZRgv4IGVZbiQrvCJb9xlCaGby5W38VrKXJ1hP0Tq8sZPBMo
        ba0mNjrDbd/h+Brnik1+DeQdY6e/CaH5udw0gQu793GD/7kyhZ8xDodVqciMtizRLZxz17x7kZ9pX
        3YPvWc9Mwo1YMLGoEqAFCMzkPONaT6MrgL7KGPHGXTcTIwJH6uBBubdsVhNbc7UTjCews8jSH3e53
        deYNaIrpTsLwkuD/xhy66QtoZ4Uit+/F38Jom6+IiS3mjSCKlencFervvPQt94ehXkgDG7Ignbsj3
        2m9+bMFA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qw6sK-00F7OL-16;
        Thu, 26 Oct 2023 20:22:40 +0000
Message-ID: <8edd2ee3-13a1-4873-bb59-46727c0914ea@infradead.org>
Date:   Thu, 26 Oct 2023 13:22:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Oct 26 (drivers/nvme/host/core.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, sagi@grimberg.me
References: <20231026152213.13c2382f@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231026152213.13c2382f@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 21:22, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20231025:
> 

on S390, with:

#
# NVME Support
#
CONFIG_NVME_COMMON=m
CONFIG_NVME_KEYRING=y
CONFIG_NVME_AUTH=y
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TCP=m
CONFIG_NVME_TCP_TLS=y
# CONFIG_NVME_HOST_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
# CONFIG_NVME_TARGET_LOOP is not set
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set
CONFIG_NVME_TARGET_AUTH=y
# end of NVME Support


s390-linux-ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
drivers/nvme/host/core.c:4760:(.exit.text+0x1e): undefined reference to `nvme_keyring_exit'
s390-linux-ld: drivers/nvme/host/core.o: in function `nvme_core_init':
drivers/nvme/host/core.c:4727:(.init.text+0x122): undefined reference to `nvme_keyring_init'


-- 
~Randy
