Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B677A188
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjHLRxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 13:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHLRxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 13:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5CD10D7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 10:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0015C61C99
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 17:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF75C433C8;
        Sat, 12 Aug 2023 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691862789;
        bh=gDFwiP1m0fKyKMgA4o0QJNJuPAPe4CNCLkLEAlRxL/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a88O3yT9Eb7KYYhxCJVHpyDdqiqj6bc5Tyg12kgIsFxDNCainXZgzzPX9Zm0LKyL3
         bzq0VFBL1468P7+t7uT903tLlMHN1Tkcwnz0r2nnBAYrrht9FGwnopxuNVXs7WRoKP
         R4VQHBemH8nyiCA0mAVJZlG1bxHW2lJlj6ZdZCiqfHrwMHQ2TQS8sKeV3tKqoieBct
         HKaZdEaqLoec+lbq/8yfsHWtQaO4V9obLi5IES20jVqEb2ohF4249rtA3RXw/hX/ra
         hDRUBXeshSvNOsPW5qwPrCo7xF6v2+le6S1AZ7XblM/cW+nI6QFacLEPAa6ox8WzIB
         UJH9qtDtj/EKg==
Date:   Sat, 12 Aug 2023 19:53:05 +0200
From:   Simon Horman <horms@kernel.org>
To:     =?utf-8?Q?J=C3=B6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: Remove leftover include from nftables.h
Message-ID: <ZNfHAbz+LMqhi9oq@vergenet.net>
References: <20230811173357.408448-1-jthinz@mailbox.tu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230811173357.408448-1-jthinz@mailbox.tu-berlin.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 07:33:57PM +0200, Jörn-Thorben Hinz wrote:
> Commit db3685b4046f ("net: remove obsolete members from struct net")
> removed the uses of struct list_head from this header, without removing
> the corresponding included header.
> 
> Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>

Reviewed-by: Simon Horman <horms@kernel.org>

