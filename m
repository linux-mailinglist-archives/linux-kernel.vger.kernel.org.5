Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B449764445
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjG0DWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjG0DWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:22:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E531FFC;
        Wed, 26 Jul 2023 20:22:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bba54f7eefso11094625ad.1;
        Wed, 26 Jul 2023 20:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690428167; x=1691032967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOCw3tpOEkG5/EtUROA6ZEpUAqPahbTI4RHTbQoB/Hg=;
        b=HzcG3g3UHsjEAs3chpzxRsJX2TKUE6woS5MmSGktqiGRnoAikjc5OlNSR8NXmoKNdv
         yDh0j+qIdpkv5hJEWcpG6SAaRVUYRVOrpvmzrHQeF7dsqhlvYCcWrbdD3Pb0mCK21KkU
         rrL9dKtee3BCYh5IxauF966Yh7n41glBpUA9A++2KXZGtl3+4OQXkAnENKkq/YLhK74P
         +roXcaOkz3ZuAR7DjvtQ+o+11zOZUEUZ4BOfmqWm7dVxZkotE1JD4aWYmVNtxC+alvFS
         dTAkNEX8UazU3WmZYFbmiqPGmEuNbQbhwNPpsYPFwU5hyYiotL22sIxN0Y4jwelJ9AYe
         Z4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690428167; x=1691032967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOCw3tpOEkG5/EtUROA6ZEpUAqPahbTI4RHTbQoB/Hg=;
        b=kz2l72+El+UZTvcV7QHhe1tOdh1HCdi483ohMO4JiNib44a/usPyuRRqVLnQLnZzHr
         Apa4NKRDjqz2ft/2Nvlr2kogXr0vMyU5RBU7CSHhlcpu0nALIsGO1fBP/oivc6B9sgj1
         3BqgAIaE43NeRXd/O2dwuiVyNgv6mffegeBd9bmNiF09x1wpb/Yrn+EkYfoN26dw/aO8
         utBOJg+E4DTQTYJuF4Dv/CFtRaf0lLBCkFRog3/1henf/zrKFwjH8wFHK5y5TFrfQoch
         BHWt4DwBo6VmYpVd9utgjM++x7bJJpTn3IRk0TOvLOMQM7/ztdnWdANQ4s4MfkcH8FD4
         +ywQ==
X-Gm-Message-State: ABy/qLZ6DRngWsI9inwM17SZPk+V+SRWpFLTGP1ZkMsOmDkn7eYCuynI
        Q8r6ICJmWJsqUbe3qEpbljq9Msh9wkANP4pQ
X-Google-Smtp-Source: APBJJlGZe/I1Ujw/CjltJQl1utB7MetkJz1HzRVtMnRswtp5PbgsxjNlYnFHni0NfgXc/eaakokBBg==
X-Received: by 2002:a17:902:d2cb:b0:1bb:b2f7:e075 with SMTP id n11-20020a170902d2cb00b001bbb2f7e075mr1758828plc.7.1690428167028;
        Wed, 26 Jul 2023 20:22:47 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709028a8500b001b8ab115ce4sm292544plo.278.2023.07.26.20.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 20:22:46 -0700 (PDT)
Date:   Thu, 27 Jul 2023 11:22:41 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jon.toppins+linux@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] bonding: 3ad: Remove unused declaration
 bond_3ad_update_lacp_active()
Message-ID: <ZMHjAWT60adJfhqY@Laptop-X1>
References: <20230726143816.15280-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726143816.15280-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:38:16PM +0800, YueHaibing wrote:
> This is not used since commit 3a755cd8b7c6 ("bonding: add new option lacp_active")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

It looks like a function I added in the draft patch and forgot to remove it
when post... Thanks for the fix.

Acked-by: Hangbin Liu <liuhangbin@gmail.com>

> ---
> v2: fix patch prefix
> ---
>  include/net/bond_3ad.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> index a016f275cb01..c5e57c6bd873 100644
> --- a/include/net/bond_3ad.h
> +++ b/include/net/bond_3ad.h
> @@ -301,7 +301,6 @@ int  __bond_3ad_get_active_agg_info(struct bonding *bond,
>  int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
>  			 struct slave *slave);
>  int bond_3ad_set_carrier(struct bonding *bond);
> -void bond_3ad_update_lacp_active(struct bonding *bond);
>  void bond_3ad_update_lacp_rate(struct bonding *bond);
>  void bond_3ad_update_ad_actor_settings(struct bonding *bond);
>  int bond_3ad_stats_fill(struct sk_buff *skb, struct bond_3ad_stats *stats);
> -- 
> 2.34.1
> 
