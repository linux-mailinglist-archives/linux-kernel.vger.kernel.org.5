Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7837CF570
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjJSKfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjJSKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:34:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157D121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:34:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32dbbf3c782so358345f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697711693; x=1698316493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHZ0E2oURQ40dzVmSqirtuqVQjv7KJZAugs/PKtmYUc=;
        b=lgXCyMoJ4ePOJCrJQlFBVWwImk9CquZTm2u+4IE5bTLtPVWBbowhiIBfGgaGuAWrir
         DMxI0HL07KlU1xMB4vomLRQKtQMZLphduJzxLtj2ykGYudNotYgAQqSoAnDKKRUT/gNI
         SgcdgfC3VbnIluEfSaA7d/2WV73XdsUSrMjHLFjNMAYh3QJzTsG1AT6xJbt8D20l7NEg
         7O4YkfxJpbWGEE08hp+aAS6en1I9e6rsXaJTKTeKxVBWPWTorAwlBUeRSrJWXpo4LLsx
         HsrmepXs085cNJX7L5ZVKAFsHgngCK3ga37IxqX4hyu9uwhOPvk86n+uWaDncEpLjTZd
         usQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697711693; x=1698316493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHZ0E2oURQ40dzVmSqirtuqVQjv7KJZAugs/PKtmYUc=;
        b=lma4DRBBWQmdGV5aZzQoLxkcZhK6QN0VuYeBXX3YlV74OcgTByHvnD5LUG24qD9hyq
         rF50HO/m+vSGkwI2Hex8l92w5uCvDtUXWQNlKsF6V3eHUrC6zxA6b+q5wGUU8m/xf5+9
         2lup5NSgsADHV3+YoiHj+/VB1zZw2ByLZGdpUyVRE5Qktwb0nQauwzVYSAp+IuHka3sx
         dffAIsNMwErM5dG4LB8RMaplMBaQus+QyKCoQMxETkf28zhp4ZTL8vr+sspbE1GzkJMt
         l6GOiBqkdodhU4vG20vTM2PNsL8WXjJr9hePZ2CR+bGy7GLdOP6gGgaECDc/+bgTqnbo
         gNPg==
X-Gm-Message-State: AOJu0YxpQYZXxUkgndSQnH48ddgvBF2ehiD5e76QsKfCMWTBVhRTt96F
        9IoeJASeo/HQAwLL1cE9DrMDHA==
X-Google-Smtp-Source: AGHT+IFdar0VVDaMOSgRpl4MSClkYLbAVPKlMoGU4cE/swmAe891KuxkdeV5d/6VMA1irMhQ27GKxQ==
X-Received: by 2002:adf:eb87:0:b0:32d:dd68:e83 with SMTP id t7-20020adfeb87000000b0032ddd680e83mr1075240wrn.21.1697711693227;
        Thu, 19 Oct 2023 03:34:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600000c900b0032d8eecf901sm4175868wrx.3.2023.10.19.03.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:34:52 -0700 (PDT)
Date:   Thu, 19 Oct 2023 13:34:49 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: lan78xx: add an error code check in
 lan78xx_write_raw_eeprom
Message-ID: <aa78dff4-d572-4abc-9f86-3c01f887faf1@kadam.mountain>
References: <20231019084022.1528885-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019084022.1528885-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 04:40:23PM +0800, Su Hui wrote:
> check the value of 'ret' after call 'lan78xx_read_reg'.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> 
> Clang complains that value stored to 'ret' is never read.
> Maybe this place miss an error code check, I'm not sure 
> about this.

There are a bunch more "ret = " assignments which aren't used in this
function.

regards,
dan carpenter

