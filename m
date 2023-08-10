Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BB8776F51
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjHJE7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjHJE7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:59:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DA62112
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:59:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317744867a6so503339f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 21:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691643558; x=1692248358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=euAie5sbhK9BZf83ob1dTMY0SFdxl8s8/ookcEMMCEs=;
        b=I+PAaO+y1JB40rnflIsP6qBHBb7+RnISJLYhNDdFx/8rkwSCvoaZCc9WUcfgKVmo9O
         36xL2Axim6NdRpTxC7LOXn+MCe57LcPQwiKMaGU+6b5iQDiFueAJ3QkN8pfTcz40G4eV
         mBtdYd4xjLoyp3tiS3Mgdvsvy2gRrYYdComQMx9D1KHS598qJomyTYFKrnlkXN0paRfQ
         uSP2N5O6ucvbMYPUubns+lOLKg6xDYOJmDenW29Kwd2dFUDo5SHyXLTi1CXoVtXQ04TM
         mMYdyq9+lWKvOljC/jKm7kODtA5Nh8Svg+YsXwgjEbaZYjxfW4qCOqXUmVoOtsp5CIRE
         TDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691643558; x=1692248358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euAie5sbhK9BZf83ob1dTMY0SFdxl8s8/ookcEMMCEs=;
        b=eu+n88bT48qTw9uBqSRDnzCswyNdJ0RKy61ywADYRDNh1BLWNpM08Q/VeBmTvmV7yb
         Ej4tXXVG1EDNdQ+sBYnaJQWO37DmjbclfdgWCIuevvXO7BY0icG6ElOwBOjj0j3HxQOp
         GY5bT/GnbqC/nCNzK/HELXKLUvyouSpy1ji+z0J0MYWUsL3a8qmPE0N8vfWkb6K0vWjA
         uoJdVgxb1+DMy/5DGWZsU9dlVGjx5e+2EHTYGPNHLk6gW1uF2MTyiUmuNI4qJh3WHPn9
         B90rEfqscL3JE0zQzfze8ClZcGqVuPq6If3OJL+7EDat/MNiZFYN64XNKoK04UNLqUzn
         hSkg==
X-Gm-Message-State: AOJu0Yz4oLQQ+AW+n10bo8NN3esEUwUWCcKaEt7ObklmRadKOQsZPmG9
        /KLMh5pZnBe0elR4NNqcd+3Z7A==
X-Google-Smtp-Source: AGHT+IE3qMjYxsryjuXtRo6j6co1x8mQdJoIMUPhdqd9mvnf9/A15YHII3zIiOejSOGEayfI8ONtNg==
X-Received: by 2002:adf:d0c2:0:b0:315:a043:5e0a with SMTP id z2-20020adfd0c2000000b00315a0435e0amr1029294wrh.56.1691643558126;
        Wed, 09 Aug 2023 21:59:18 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b0030647449730sm779008wrq.74.2023.08.09.21.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 21:59:17 -0700 (PDT)
Date:   Thu, 10 Aug 2023 07:59:15 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, ac100@lists.launchpad.net,
        gregkh@linuxfoundation.org, marvin24@gmx.de, alex@shruggie.ro
Subject: Re: [PATCH] staging: nvec: paz00: remove unneeded call to
 platform_set_drvdata()
Message-ID: <fb1cc561-926e-478d-a6ce-9d97fa0dd0e1@kadam.mountain>
References: <20230809154211.15741-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809154211.15741-1-aboutphysycs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 06:42:11PM +0300, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---

I think you are right, but why are we doing this?  That one line is
hardly a huge eyesore.  It's all risk and no reward.

Have you tested this change on real hardware?

regards,
dan carpenter

