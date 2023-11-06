Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8583E7E29E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjKFQgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjKFQgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:36:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2035F3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:36:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A2C433C8;
        Mon,  6 Nov 2023 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699288607;
        bh=i/ae4hJdIve54O+1/N5AmqSGvw4v4QG1RuIz6Bfe7CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L857G2yVMIhWjeGXQli2nFJEwQ0RSUX8law95qewMP8pO770uwM75kzCM+9RHP2xd
         bDklj+dQFl3KO3+LMMGUoQJbKr7kI4bWrhxtAXUitScGAj00A3WjjtrggYUyqnFB5m
         qdzzL/ukBqUkmrRCiF/53Alr1Np7gu/D8eqACXQXOAVq51BVq8h6GNp2/q9gwvNQiw
         eQViz11kodlKygGXKutlU8+TyEiw9swBw5zBgehVtNWlBYl/zS4ZmZzp/8eBwlPhT3
         dQqJluzNO4KQ/GRX0ZehccHL7qNp9O3SFhY94+qaSwIHXUbrS4NVNFsruuvpLM0Cw6
         tkhPk1RU4Dy4A==
Date:   Mon, 6 Nov 2023 09:36:44 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, hare@suse.de
Subject: Re: [PATCH v3 0/3] nvme-tcp: always set valid seq_num in dhchap reply
Message-ID: <ZUkWHNgXt_RNQVwG@kbusch-mbp.dhcp.thefacebook.com>
References: <20231025105125.134443-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025105125.134443-1-shiftee@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:51:22AM +0000, Mark O'Donovan wrote:
> The first patch is a small unrelated fix which makes it clear that the
> response data section of the Success1 message is not optional.
> 
> The second patch removes use of the host sequence number (S2) as an
> indicator of bi-directional authentication.
> 
> The third patch causes us to always set the host sequence number (S2)
> to a non-zero value instead of the 0 value reserved for the secure
> channel feature.

Thanks, queued up for nvme-6.7.
