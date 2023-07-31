Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7F768A94
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjGaEHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGaEHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:07:05 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CA91B7;
        Sun, 30 Jul 2023 21:07:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686ba97e4feso4110893b3a.0;
        Sun, 30 Jul 2023 21:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690776420; x=1691381220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iecctykKTsm0q82UtUMIa1inbPuKOlOwMPntbBWiA7M=;
        b=Qgw6X8PgM/yfApdep7jdZxiutuZFmm49igDyyAElEToLnI5m+Oe9Z3oV6VNYiJd3wL
         M+N8yizMMU2TB4wmdiNwMJHWxemWNtsjoKSHjgJAJCAkUVPLRXm00JKXFXCHszONNvEO
         1+HZ9gG+lB3lymrNLclKzCnF9dwSS8lhhC/WekeJumJ5NmJnPZEdxi3QWXLyJ83BPMb2
         r503zWwhbKowRJ1pZRq+n8hcS5K3Q/X9utGazw2EEDHHNYrS+jUdhyaxm3nSDydo+3O7
         K1cpmTpKgo7CgiHbzMY27x/uapjv5o+drleiRzxhILJEfLet1M/HOPtt3ywp6McGeKNN
         O5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690776420; x=1691381220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iecctykKTsm0q82UtUMIa1inbPuKOlOwMPntbBWiA7M=;
        b=WxGJ2sF6qmvZ8bRGUy/WbQfwR7MK2KajxiufeXowv/obzwxWtQBMmvXD6H1mMd+7Qv
         eKeZevbknzUru1kIPIsIXf7YkZ/LL9LTyG4wpY/2s/pg/7WuYTNLgpB3D7j/x6qCI8mJ
         oyvFt4ALPtdiHDFd7/aUY9UtzGPPuuI7ppkkfrCeFZ0WAzBuBpf9wjE/Nk0gYVuM7AF1
         SGr1J3J567DC0ORM7CpyxIcGreoQUIb9qPbdeRK6SAChUPHXp2luWW/BEsPU0lzV8Tqh
         PBoKAoNVgEQVP24DDEu2OiSNlR1m1SRt/dfU4w4Z8t6CvjJC8Ts4RsE0gomzMzeGUG9a
         iDpA==
X-Gm-Message-State: ABy/qLZeCqQCX37rUqFFKk1gP8+wIkMZeSMOQsnGdAyPyAvlMG8lyhGF
        voUOl3Cn8BPDNdc4LxsAYboctFMv5WdVDw==
X-Google-Smtp-Source: APBJJlFsfNmZA51+mk2lagnMloXlawPx77/7vQN8m1US4KkRz9j200XgJ1dxizafViZPekyxslNRmA==
X-Received: by 2002:a05:6a20:3d8b:b0:130:f6bc:9146 with SMTP id s11-20020a056a203d8b00b00130f6bc9146mr10223204pzi.14.1690776420484;
        Sun, 30 Jul 2023 21:07:00 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b0054fe7736ac1sm7178398pgc.76.2023.07.30.21.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 21:06:59 -0700 (PDT)
Date:   Mon, 31 Jul 2023 12:06:55 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next] team: Remove NULL check before dev_{put, hold}
Message-ID: <ZMczX9ruN3yUsXQc@Laptop-X1>
References: <20230727005741.114069-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727005741.114069-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:57:41AM +0800, Yang Li wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold},
> remove it to silence the warning:
> 
> ./drivers/net/team/team.c:2325:3-10: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5991
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Hangbin Liu <liuhangbin@gmail.com>

> ---
>  drivers/net/team/team.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index d3dc22509ea5..bc50fc3f6913 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2321,8 +2321,7 @@ static struct team *team_nl_team_get(struct genl_info *info)
>  	ifindex = nla_get_u32(info->attrs[TEAM_ATTR_TEAM_IFINDEX]);
>  	dev = dev_get_by_index(net, ifindex);
>  	if (!dev || dev->netdev_ops != &team_netdev_ops) {
> -		if (dev)
> -			dev_put(dev);
> +		dev_put(dev);
>  		return NULL;
>  	}
>  
> -- 
> 2.20.1.7.g153144c
> 
