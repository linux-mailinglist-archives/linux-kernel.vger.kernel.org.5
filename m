Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6987F3ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjKVHX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjKVHX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:23:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B524E98;
        Tue, 21 Nov 2023 23:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C3HyZQRnJO9EqJwETvVaXZbN3z73cWz7ZWScuDy8MZQ=; b=KFbh52MeuV7DDHCIaijeZcHO66
        efTM8ckcvShYP9b6aGDVWeKsSOHLWnvPV0ro6zclldqI0wwRqhLmHVEPEhZCx/cv0kLKoJloQDVs5
        uB/HWf/ocTNOY/wjoMPO5ToUfN12EQJfLODZVPKjYCeVUrAODBePK/cVXP1FoVI9Qig5Plm8HhELA
        MP8k54hO27Mm9tM004D1Z09YnW6w0gESvtqOXiTPpCEh6BtCLAzRLq5laL5lL4QXSzuIK3IK+7VUv
        NTz9teq11JCVIX2K6uU2o3cKCRTdHBmZBbOyiS+CV+PSmYY1EDEbqOhkTktOL2a/st+7c2sdssoj9
        EUvM3mnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r5hZh-000tqM-0r;
        Wed, 22 Nov 2023 07:23:05 +0000
Date:   Tue, 21 Nov 2023 23:23:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jkbs@redhat.com,
        kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
Message-ID: <ZV2sWSRzZhy4klrq@infradead.org>
References: <20231122071924.8302-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122071924.8302-1-chentao@kylinos.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 03:19:24PM +0800, Kunwu Chan wrote:
> net/ipv6/route.c:2332:39: warning: incorrect type in assignment (different base types)
> net/ipv6/route.c:2332:39:    expected unsigned int [usertype] flow_label
> net/ipv6/route.c:2332:39:    got restricted __be32

Can you expain why you think the __force cast is the correct thing to do
here?
