Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C91777956
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjHJNNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjHJNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:13:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E610826AC;
        Thu, 10 Aug 2023 06:13:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so8287295e9.0;
        Thu, 10 Aug 2023 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691673216; x=1692278016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBhUjYJB57IDpg//HzidEUQPRD9Ij3Hoz+KbD9Efgcg=;
        b=TcFfpXwkBBPAq0NBcNrHsW1c4sUY58+9ahJLEhkfjGTFzc/3cK5PhxciefozZVoGCN
         8na+Im8VyJNUDuFMuhvWkb2uI8sPstepuuYnTAMbH5JdvIQKKL/2xppZY/r9weya0Vru
         ckycSiYtcy7a6oGn8DNutV7PZNLnXAHSvKPR2qiLBu/L51/NZPvDo/tcjWzKQf1wILYS
         AHs226d6QpPHbJm+qK8m+gYOOdLJ1mhizwn3rROyUf/ip73pNS+eZMciSBSXeJfe7oZV
         82fAIxmzjYyqg0mN6d2ZQ87sorCGJ6q9NBuMDfwDioBu6EYolGINwVmGit2p0hhGl6qr
         a6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691673216; x=1692278016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBhUjYJB57IDpg//HzidEUQPRD9Ij3Hoz+KbD9Efgcg=;
        b=ckCjWTj3+H/FC/bzlKobsHCLjGQXhOPgBjxZJRyRX7+eQpgP/AUQ/dXdl2k5W3u0Mi
         QXsNKvN2Lxy130X4i/XK+8hpSl7NgFBUEcDG495tnUssk3G/r5sbQsAK8z/vEXFx1a0d
         GydZcWLT2pz1owUGCR/t0yG5/0GjI1bCMnjKDgBIUZLSzzXsehI3yV5htQ2p4St+CzFE
         Q6FEZJDKQ+fiEDbC+p0H+MLNg9xjIbnvBEUb92w5wEH4sTxO+qFjEdTpfmTJ1InK3b69
         K3STvDGFe+sfOpbiTAZdKkir4whpMnb8J2qpuxfk2bQPSRkhTMz9tvmPDpo4jDMyb6lc
         Z+sw==
X-Gm-Message-State: AOJu0YwYnnW25eGFNlTjlfGzs3rUnNB0Q5BhAPs+umtxsd5Vp7CteiV4
        0KCq5ZUB7UIss1oqEOM9B+Y=
X-Google-Smtp-Source: AGHT+IHklVUeXSY1U4xhUe1yFTSP/55+Ie6PL6bdURE+H3ONkkC3Ip3iEN3BpJCHe2n8zJjS/PMpHw==
X-Received: by 2002:a5d:5489:0:b0:317:5d1c:9719 with SMTP id h9-20020a5d5489000000b003175d1c9719mr2064130wrv.9.1691673216090;
        Thu, 10 Aug 2023 06:13:36 -0700 (PDT)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id y14-20020adff6ce000000b00317e9f8f194sm2167545wrp.34.2023.08.10.06.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 06:13:35 -0700 (PDT)
Message-ID: <23d8d0c1-1a67-b641-f09d-f17f9678081e@gmail.com>
Date:   Thu, 10 Aug 2023 15:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] tty: Explicitly include correct DT includes
Content-Language: fr
To:     Rob Herring <robh@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Timur Tabi <timur@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20230724205440.767071-1-robh@kernel.org>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20230724205440.767071-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/07/2023 à 22:54, Rob Herring a écrit :
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>


Acked-by: Richard GENOUD <richard.genoud@gmail.com> # for atmel_serial

Thanks !

Regards,
Richard
