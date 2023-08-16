Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6277DD55
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243332AbjHPJcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242445AbjHPJcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:32:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446026A1;
        Wed, 16 Aug 2023 02:32:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso5549368f8f.0;
        Wed, 16 Aug 2023 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692178329; x=1692783129;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CROS11eQc4VdamWNPpkT/+SP9fFFyQmzSXVLUtxDZNE=;
        b=gkJUMBYDBiDz+w+hHK/s4KLlBswof+5/6pLmHCiSRn+8eM/S962FZbAtIdUj9BnHZD
         bhWNK6PyHY7ByDfxeXxqjSIRD9TianaNDEfWwUw4NTX3f2uTzeD9wcXetkXRW3OIRswH
         g0YSrsAi1EYxWAsnPUy5gXBA/oh35RSoTTLVukDHUTu/fxqtWU48mr68AnjyZ7E1Cn05
         l+tfZKhOw+yGqNIyod5CMZgJsOAR6p6HAovoWC9vzdXuwqK3SGhrFRAZ6C/xYYt5+BT6
         kNV4B9Rgld2atqYao1zvT7hMXJLwuKmXXIUjmifbMszc71xt5Q/5j5G+s/C2EYsdmq/G
         s4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692178329; x=1692783129;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CROS11eQc4VdamWNPpkT/+SP9fFFyQmzSXVLUtxDZNE=;
        b=Qn3H9OyOKkoX1P9Dn4fGRw5E8M9hY82gfNiczcb+RJFGzcVWH4kyI5b1Ni1o9oFe4e
         2PaQWU39btLQqJNyiMR//A5++YDsOzSMSmyd4AfZG0M2DcCXTpvoQKSIZe+wS5y0Bp8X
         j9ZZHAJMTo3mW4vgxVxsZCZaPc8YCbbdK1r3GMn8IvOaNsMXO6PMjjlxSZUgaDdjwbYR
         5gk0CfKqo4kVOY84j/1sRePX313prYZJGb9HUfRMCMUSCmwK34V/27MylmXz0BsmJlMo
         OBh5u063r4ALXIC3rMTfTWwkOntVyDasTOmCUI9zGXZ2GvNZiltVWapA8O5KYJ0kvS1O
         WlDQ==
X-Gm-Message-State: AOJu0Yy1fK8Hjf/mBWQkzusVFLW2kN3JpHhY9a0nU7Pm5mqecEwQLK5L
        0rPWf1XheFgqxgZxkswNnM4=
X-Google-Smtp-Source: AGHT+IED11k3OhCVYJf57vRvQOu7TpdsSNcxeoXQrTN4ekCEG4hqItcvlx+nbAfnEFrZegkR0U/J5A==
X-Received: by 2002:a05:6000:90e:b0:314:34dd:aaec with SMTP id cw14-20020a056000090e00b0031434ddaaecmr891744wrb.8.1692178329137;
        Wed, 16 Aug 2023 02:32:09 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d4904000000b003143801f8d8sm20748650wrq.103.2023.08.16.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 02:32:08 -0700 (PDT)
Date:   Wed, 16 Aug 2023 10:32:07 +0100
From:   Martin Habets <habetsm.xilinx@gmail.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ecree.xilinx@gmail.com, netdev@vger.kernel.org,
        linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sfc: Remove unneeded semicolon
Message-ID: <20230816093207.GA239320@gmail.com>
Mail-Followup-To: Yang Li <yang.lee@linux.alibaba.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ecree.xilinx@gmail.com, netdev@vger.kernel.org,
        linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20230816004944.10841-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816004944.10841-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 08:49:44AM +0800, Yang Li wrote:
> ./drivers/net/ethernet/sfc/tc_conntrack.c:464:2-3: Unneeded semicolon
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for catching this!

Acked-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/tc_conntrack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/tc_conntrack.c b/drivers/net/ethernet/sfc/tc_conntrack.c
> index 54ed288543d0..8e06bfbcbea1 100644
> --- a/drivers/net/ethernet/sfc/tc_conntrack.c
> +++ b/drivers/net/ethernet/sfc/tc_conntrack.c
> @@ -461,7 +461,7 @@ static int efx_tc_flow_block(enum tc_setup_type type, void *type_data,
>  		return efx_tc_ct_stats(ct_zone, tcb);
>  	default:
>  		break;
> -	};
> +	}
>  
>  	return -EOPNOTSUPP;
>  }
> -- 
> 2.20.1.7.g153144c
> 
