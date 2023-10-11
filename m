Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017137C5D10
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjJKSwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjJKSwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:52:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C6A93
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:52:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA65C433C8;
        Wed, 11 Oct 2023 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697050354;
        bh=v0JEp1Ts/zuN8xlWxWz2EnmwAxvgi36+m6P6P4BehQk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OghFLr2Jkqc+FgNmt4OaSjrmOI2qZ7CAWVltzpzfPEy4jzjerwstjCAkSe81ieRB0
         wxQT7MFTQxTdK8xgEv45jZ5i5qVb9wfRkFmpCfmxs81lkfFXoO5+EVBVBitoQuzbpG
         GZuJzCG5QNQ+fUhQUtQmL1dQ/oUeLj/0X5qHGPzeqDVLGpMc/wrufGG4d5Z3fJUqSk
         YaOMX6MHhAcUV0Zb5dPA+tUMJRV5rV8ExZiT6CReNOgEcdQKL/PgEooArPxeTYSkel
         eSmiTJp0OPNuT6qqIS3eUfhZTM0u03zjdtmbWQ/VEiiV8H18l530eq8B0paYL3b/IK
         CFrjTgIiu/qCw==
Message-ID: <a1840176-2ed6-33b4-dc6e-0bc98055910b@kernel.org>
Date:   Wed, 11 Oct 2023 12:52:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 4/7] ipv4: use tunnel flow flags for tunnel route
 lookups
Content-Language: en-US
To:     Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20231009082059.2500217-1-b.galvani@gmail.com>
 <20231009082059.2500217-5-b.galvani@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231009082059.2500217-5-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 2:20 AM, Beniamino Galvani wrote:
> Commit 451ef36bd229 ("ip_tunnels: Add new flow flags field to
> ip_tunnel_key") added a new field to struct ip_tunnel_key to control
> route lookups. Currently the flag is used by vxlan and geneve tunnels;
> use it also in udp_tunnel_dst_lookup() so that it affects all tunnel
> types relying on this function.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  net/ipv4/udp_tunnel_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


