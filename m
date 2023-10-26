Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5677D7995
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjJZAhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJZAhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:37:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21364128
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:37:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5192AC433C8;
        Thu, 26 Oct 2023 00:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698280652;
        bh=kdPYHlyi8yRFA/DekNTf55CpBXQANDC30hXhpM718dY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pwG6S4oGL1qdFoqWVMVDtlwCeDxC4Cyh28/7Zk5RV1ugKrUGPn1TIzt11W2JXapYN
         H2YY+qOL8e6h9INEK4PoRq01WDILSk7buM2BcQMxpUuLGg5lNT9O4UodufoRcohywV
         M6fQGssmjBjkoGRI1PZKk0hL6n6Gl6NQ7g3ve4Ms6CeCmqwj/2HJ26FR33CfLrVst9
         9ATbzuitHmFrrgw/yWZE+PfZurGoGSOdC+yrktxFEaIiXQf140X8DHBF2xHMV/Xcv/
         ViZfXQ9Any3fISkzuz8RGp5o1dI1BM6AUGzeuzB2v7vOrMRowE/qJoU71asf29lKuS
         AmaG6Mzd/Rpcg==
Message-ID: <7ba2e62a-d662-4a7b-990e-ba650bd773e7@kernel.org>
Date:   Wed, 25 Oct 2023 18:37:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bareudp: use ports to lookup route
Content-Language: en-US
To:     Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20231025094441.417464-1-b.galvani@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231025094441.417464-1-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/23 3:44 AM, Beniamino Galvani wrote:
> The source and destination ports should be taken into account when
> determining the route destination; they can affect the result, for
> example in case there are routing rules defined.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


