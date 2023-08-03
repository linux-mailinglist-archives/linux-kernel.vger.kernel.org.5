Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD2976ED81
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjHCPEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjHCPEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB68E2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D86C461DED
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9313C433C7;
        Thu,  3 Aug 2023 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691075050;
        bh=QiRaXf3F65WtJzNiwzXsBrsbRQI88q2pid30CNFVANg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1RktGnfaBuL2qTnxctjzQHBLJ9jy361Vsh6PMAgtjhh5buVcadtrwWJo1Ql4Ex1e
         wBRxRoG2CVLgncqn2fpHji541GGBnuNuISCrRhJiNZBlLXVqw2zFe7qr3TvUXnzP7S
         B7v5KYGt5ZVVvci7cLtw63OuQ0Izz2GEyXId+1J1LJ8CGKifGAmbUuLs5wdXQOz0dP
         IhPtSM6otHhD5Gillt7wb8T8EGvFWPtc9cyJt54dWZtsRbfiJP3i3YXQk5PnZBfibw
         MbptBWm0/o/v2B/UIcf6Hs7blsWfskGttAksIChrV0M8SCoR24B6LpP1w5N30AiTa+
         piIU8ocYkXgyA==
Date:   Thu, 3 Aug 2023 17:04:06 +0200
From:   Simon Horman <horms@kernel.org>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net] test/vsock: remove vsock_perf executable on `make
 clean`
Message-ID: <ZMvB5lFhNJC6I6h/@kernel.org>
References: <20230803085454.30897-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803085454.30897-1-sgarzare@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:54:54AM +0200, Stefano Garzarella wrote:
> We forgot to add vsock_perf to the rm command in the `clean`
> target, so now we have a left over after `make clean` in
> tools/testing/vsock.
> 
> Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
> Cc: AVKrasnov@sberdevices.ru
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
