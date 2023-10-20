Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711BF7D08E6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376347AbjJTG4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376326AbjJTG4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:56:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2300598
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:56:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40853c639abso511885e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697784979; x=1698389779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9LEiI73HKl/yMmpsQOiFinCN5KnlO7an5SddP9Ej00=;
        b=h/zZ9RXbaO6rAMYh0u9MNKdaz1N2GUNDrj0mfc9tH9JPEDqCCTixPhr71XprBswFpU
         zw1UDvRG1gxZjStRUOUJ22FxlnDBF1cdw0aY6vLGihvZVTbAXxRSl4I6J4Q7S4noXN2s
         ivtewT2w6+s4XOX1A43g8i1gjRwINtvhtRpvXg55ON5YvbqBfMIc8gvJqxhwopN/F18z
         a8gkfuK5yM1Zr4H0dH1Q/30ICWdmJtInyuaRboQxhuC5DfU7SndpLWEaC16Ks3+B3Rvt
         iCIrUzRBvNw9pLmh9lnHbt/wwPBaiKDI4g/r97X0LhRv15n4Xn+n5KkzPno1g83eh5gQ
         WLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784979; x=1698389779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9LEiI73HKl/yMmpsQOiFinCN5KnlO7an5SddP9Ej00=;
        b=FLVFj6R2CEJ41QVG4xD5I31uRNLL5YCtIk5PiGAaDoJ2ckI4iFyEkVqEsB/4I1zxf/
         QmC+z3rP2GFLB7YwA61Ls9NRIe/pjO2r2lB7aEJa4RguS4ebdFG66SdzQs53I2zNWwkM
         kafDJfODKWzUUHkf7yP48klm8CEbOWr2aMZZ3tU26wFf7umHdfSia+8bIa6mg1ylL94L
         w+EjHYrN0eNASufZMpow/bC9sClT8WvdmRUlJT00x9savXB/r7KNhxJtNmNlTHbcdLWd
         mUnJMZQrP4YQPTUaeh9sQbqBqu9UQ4pGzZCOFLzJaXGmHjDMseqZaRH3+Xe7mw/oKMpW
         lv/g==
X-Gm-Message-State: AOJu0Yz5RbPukdMs8yPZqbAIDZqmXYeBq3BoqY8yLV9JKoThUIBc9VkH
        TWC6VxuGzwPcMzBukt4i8NMvYA==
X-Google-Smtp-Source: AGHT+IEvEEtQGpyk+q26WaO58peFpV+y2bXO492uWGPLm75ilrOY/3/PfE6IuqfhDBM16huGVo92EA==
X-Received: by 2002:a05:600c:4f12:b0:408:3696:3d51 with SMTP id l18-20020a05600c4f1200b0040836963d51mr833558wmq.4.1697784979490;
        Thu, 19 Oct 2023 23:56:19 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ay10-20020a05600c1e0a00b00405442edc69sm3580447wmb.14.2023.10.19.23.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 23:56:19 -0700 (PDT)
Date:   Fri, 20 Oct 2023 09:56:16 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] i40e: add an error code check in i40e_vsi_setup
Message-ID: <be0b618a-4732-467f-bb99-f623fe4da962@kadam.mountain>
References: <20231020024308.46630-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020024308.46630-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:43:09AM +0800, Su Hui wrote:
> check the value of 'ret' after calling 'i40e_vsi_config_rss'.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> v2: 
> - call i40e_vsi_clear_rings() to free rings(thank dan carpenter for
>   pointing out this).

Looks okay now.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

