Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1A7B2A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 05:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjI2DfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 23:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjI2DfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:35:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5571A2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:35:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c724577e1fso37478475ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 20:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695958501; x=1696563301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HP9g/8ujJMa7tWcM5+uRVJlaPLI8TNMtBPHn63AVXHs=;
        b=Mx9HLuRNsHFjksqrdHk/9cVPVVEY9au+IhVcj6o7kr760wRFVFZcVYnz2UbcSxmssz
         dqjcoFQjYGO2WbRltiXvLotxuBX12e4kj0vLrWY2RaccZmIxgQCUKeQftikDNOnM7hsb
         Rqa/MEFTVIdlM0DIoCiGEg3urtZop3rLO96LxtLyqAthHEED6OB92CGmDE3tREbs0Ve0
         gHdOYz1gtz0BgUXmufUjt1tw0cGwINJRX7ysLls5GTi+HYgTIVU+CI5Fe4r9uIW9TwzH
         Y+j3ihr9sYO0QrqUrAVs5yBS46MiR8rw7nfzGMwu+L/dRK7iZV4uxtEUstebVYzdNsj0
         A5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695958501; x=1696563301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP9g/8ujJMa7tWcM5+uRVJlaPLI8TNMtBPHn63AVXHs=;
        b=n0Fvzn/8yaxLmmuusFd4CETy9NhSNLsKuos1V/47cFS1MiSWCNQxd0yJ5vi8e+8GFQ
         MxVnpElH1dTQJ0oUZ1QHvd7wP47etdCJ7IrqE0b609m/Z1iwvkUfIDhHFRObcPKIXpz1
         npo+Kgh+hw4WabH1CuDrXSiA4UB/4SwWjhT6TZRNv+0kUo9VuAcZpK2fCE7Pe/99H+XL
         nYFOsIixjnzGe8/9iLzsrhsK+Dvyq0SYOm1lkwzkmZquxi30CiqTrN8eK7a6XGOm9js2
         RxNsUGPz7KqtMnctVjCdlkcHDiGzSol/Hu/K/DQ0qLgjne4aG1k4Rxx+16KbWkYaKicO
         aHyw==
X-Gm-Message-State: AOJu0Yy+Z1znh81l2Je2nq3XyMWhO9aLm1NcbxJbGJXVpBtak1qVyZEI
        Sshgvb10pcQn3itG5vK0d7rMGQ==
X-Google-Smtp-Source: AGHT+IG/x1zQDAVplp1UNHm3GUCzQBw8v+D24VTKD/duYQ3xzfbQZ0leD7mWhslO9LgDqys4FVRwig==
X-Received: by 2002:a17:902:e748:b0:1c3:a4f2:7ca3 with SMTP id p8-20020a170902e74800b001c3a4f27ca3mr3545979plf.66.1695958500990;
        Thu, 28 Sep 2023 20:35:00 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001b7fd27144dsm15898651plj.40.2023.09.28.20.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:35:00 -0700 (PDT)
Date:   Fri, 29 Sep 2023 09:04:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     soc@kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/arm64: dts: Removed undocumented and unused
 "pl022,hierarchy" property
Message-ID: <20230929033457.b743ffge7b26behv@vireshk-i7>
References: <20230928190859.1072420-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928190859.1072420-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-23, 14:08, Rob Herring wrote:
> The "pl022,hierarchy" is not documented, all instances use are 0 and
> isn't handled in the kernel driver, so let's just remove it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Arnd, Please apply this directly.
> 
>  arch/arm/boot/dts/st/spear1310-evb.dts              | 2 --
>  arch/arm/boot/dts/st/spear1340-evb.dts              | 2 --

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
