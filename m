Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CB976BE24
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjHATvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHATvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:51:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A08E2114
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0824F616D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7009C433C8;
        Tue,  1 Aug 2023 19:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690919497;
        bh=Vsh2EggMUIyZ6IFbT29YXmtzY2olDYuT+fH6QmapKVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LFF8Sp3Q4nScO4/C7Qz9kS8hTLttTL31YXFSdz5DUiZss3RPczW8uKfiKLw6+jg7+
         JlbdtNgSn8qFbmnW1t1i0a4h9kQl4/xtvAkzBCyUZl95dPpRBrtg27N4/wOwO7jQU4
         UQGphkldSKKi8jt34/xvVydUueUDMOrfNKcPF75ZwnCxlyHzMRZIFuZ+SxzZ1TE4G1
         k0ktFUrUzyVWZEKiumffOhZKI8Vidf8vu+DjZ4oVoJO5Qf7LO8YzurSETspAKFsL/8
         T2oj0GxdzAaUG1c3oV2/dwu3ykZt9LeEi0EgvJqjOpelqTTVa+cuXnpQN+UtqBSLH7
         mIPB1EHbpeqlA==
Date:   Tue, 1 Aug 2023 12:51:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Larysa Zaremba <larysa.zaremba@intel.com>
Cc:     Wei Fang <wei.fang@nxp.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>, <shenwei.wang@nxp.com>,
        <xiaoning.wang@nxp.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <netdev@vger.kernel.org>, <linux-imx@nxp.com>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230801125136.5d57e3ad@kernel.org>
In-Reply-To: <ZMkl6HUYMGWXj87P@lincoln>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
        <ZMkl6HUYMGWXj87P@lincoln>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 17:34:00 +0200 Larysa Zaremba wrote:
> But I thought XDP-related code should go to bpf-next :/
> Could somebody clarify this?

AFAIU pure driver XDP implementations end up flowing directly into
net-next most of the time. If there are core changes or new API
additions in the series - that's when bpf-next becomes important.
