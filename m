Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3035E756291
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGQMNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGQMNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:13:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E662A118;
        Mon, 17 Jul 2023 05:13:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so4560627b3a.2;
        Mon, 17 Jul 2023 05:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689596013; x=1692188013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7mGkEFG/BBY8i1FxVeGw7e6gM5cItBSc8cgFSjGd4w=;
        b=YfPGG9my9lEnguT2SNwXZKvSdi8mAM5GSP34OK/6lDn5JVemYBY6UY3iEhQB4+HSwU
         TFWJThPRrBJdSOifFr7KXTit991XI1d4B3i6+2Vl9zcShrZ9U8uMRi2/ONcAsJob1Xob
         WieQJrPcwUK3zgSfNhMMbxwItgXdKOBsf3xiF0NphmBNS9wDDCJvvkvJPANQO9EjgC+v
         6fs+N6RbnLLX2PUdX3gocyQWmBa7vdSuAHON6JuStezrnottWN3UihHJvO/kJOtAmr9w
         PRZIwH14FoH+CpVb1O3e5yl7SyeorI1v55pQ37Y98ey1h0ZTH0pAMBTOyymFgEFLfjEC
         XqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689596013; x=1692188013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7mGkEFG/BBY8i1FxVeGw7e6gM5cItBSc8cgFSjGd4w=;
        b=OjFvAAi2O+3lyZPqThZqAbZxNHyzNmRrXHUrECo9CRvAbtEdJTG+0zqvxB5jhH9RSP
         H6uoyHa1Leun2ARe1T454KdqTW5siuwFabmf9AQUWs4SYCLUbAsU6FmoTAaL+OHmuPeT
         Znewxt0NUqCMRdHSPNTVWlKTsli5NDoSJQ4hj0W0linhwjnMnhngvNfpalpcDMnZ0DxS
         qFTEmTZ2KScDN6yweiWSK4JfMxxgi6lYwsfTsnRVP4/O0NmhNNkhh5TI/61ai3g7zQIp
         ptNPTvC9EjLrA5+a/zeniVEhmkmn9OBR1rSy/O7UjGafUPRmpRB39EDtbotLQDpORh7G
         /1xQ==
X-Gm-Message-State: ABy/qLa/ICY5z9Qojtjj6+n1uVn6dCO/yMrIdo55QuCQ56PnMsny61rK
        IagQoYRgy522zN9ywwGsrHCIfU8606E=
X-Google-Smtp-Source: APBJJlGj0lHYpLdbzSreLZstrO6fHiwNc5WkCSTSq3H+UhbbRMa8JtFWuzafHld+wv5ysTDXEkvFTw==
X-Received: by 2002:a05:6a00:1353:b0:682:537f:2cb8 with SMTP id k19-20020a056a00135300b00682537f2cb8mr15587596pfu.26.1689596013188;
        Mon, 17 Jul 2023 05:13:33 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.195])
        by smtp.gmail.com with ESMTPSA id x17-20020aa79191000000b0067738f65039sm11782892pfa.83.2023.07.17.05.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 05:13:32 -0700 (PDT)
Date:   Mon, 17 Jul 2023 17:43:25 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Vincent Legoll <vincent.legoll@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: Re: [PATCH] arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4
 boards
Message-ID: <ZLUwZTy3Opx/gdIf@zephyrusG14>
References: <ZLO450xOIQ29VoBT@zephyrusG14>
 <CAEwRq=rUXpFpkrfKyCG8Eede10cCeo6V3RCDxv0McWA_g9t0CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEwRq=rUXpFpkrfKyCG8Eede10cCeo6V3RCDxv0McWA_g9t0CA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,
On Sun, Jul 16, 2023 at 03:53:22PM +0000, Vincent Legoll wrote:
> Hello,
> 
> On Sun, Jul 16, 2023 at 9:32 AM Yogesh Hegde <yogi.kernel@gmail.com> wrote:
> > Commit f471b1b2db08 ("arm64: dts: rockchip: Fix Bluetooth
> > on ROCK Pi 4 boards") introduced a problem with the clock configuration.
> 
> Maybe you should add a "Fixes:" tag.
> Look at:
> Documentation/process/submitting-patches.rst
> for details.
Thanks for taking the time to review and provide feedback on the patch. 
I will send a v2 with the "Fixes:" tag. 

Thanks & Regards 
-- Yogesh
