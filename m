Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105A17D0BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376649AbjJTJ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376612AbjJTJ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:27:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55919D49;
        Fri, 20 Oct 2023 02:27:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079f9675c6so834131e87.2;
        Fri, 20 Oct 2023 02:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697794053; x=1698398853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HqcVJytl5bv/aF+KxQt5JHBD+CsHQ2qMEG4kdAlh5s=;
        b=WIpyNE75romXiEXoDRTjusg8AGAmw9R9BwCd22pkVXrUPibIi6ST6ISa60rxJeFGBn
         W+mrDAQ8pHRk7a+P+uvtAsWOI75yL9hM4OJe0ZsdKU9SNv+h8tkYYSTQT8Av968D34as
         KsdLnoHv5oKvqff4vItMW0ipfMyO9PxUJXe2st6kuuiJ0VLNRSpchCivf2khnU4qEPbC
         OcdhFu77ZfDITW3NuT4EWgsbOmSw4I1yNTvFK06MlDetb/vTAMZzH9sNsHM5sh7o68Cy
         X2rWigxBqBLpnOOLe8f4EuQPYQHzvBjHb07MHaosJw/GPx9snj0AF58A2462GiI75uUm
         H/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697794053; x=1698398853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HqcVJytl5bv/aF+KxQt5JHBD+CsHQ2qMEG4kdAlh5s=;
        b=oCRnoVVyi1t8ollQ+AQ+FylcQbW0I4YsDeming8TYvCE5Xt+PmPl7L2Q3258cCqPNW
         MdyUQ86FXuNOGEcFdTb1k+XhYjIqEzrA2YjcIpBBZ2+N1BphSpSBjPSJrjkvHSnuUw2v
         ggE3KY62iJR/EVmhAKnUbsNP7tLhtCK2FHMnXE/NBZR6dCcikhEI9SAcpnVjDM7yV5wx
         dJLn/+aND9Aryk3IelOCJz+t5Zcz4C8WlAPX4sXEalClnv7XA0ULSMCAiAQIdWzjD2XF
         Q44NCEncLz3R6dn8UOVusfP8ZVoNpP53khCtHJqA8xbY2aG3oz+seR3+BjVyzr7BHXiS
         azDA==
X-Gm-Message-State: AOJu0Yz+ft1lLBKSLbTpHRzl72IgBA8iwgFCKTWfw/asyCX6EhkqRGmq
        Fe1Cr7h6veayspMiePlKryQlgEKlAnleXA==
X-Google-Smtp-Source: AGHT+IFQ08ub3og0Zp1kbIM98EmTalF0t0kVjHMIiibOFN0/Jw5V/kHj+j6LWfgM1fKeOEK1MVmT7Q==
X-Received: by 2002:a05:6512:3247:b0:501:c779:b3bb with SMTP id c7-20020a056512324700b00501c779b3bbmr812270lfr.60.1697794053180;
        Fri, 20 Oct 2023 02:27:33 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id a3-20020adfe5c3000000b0032da40fd7bdsm1307189wrn.24.2023.10.20.02.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:27:32 -0700 (PDT)
Date:   Fri, 20 Oct 2023 12:27:29 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     UNGLinuxDriver@microchip.com, andrew@lunn.ch, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        woojung.huh@microchip.com
Subject: Re: [PATCH net-next v3 2/2] net:dsa:microchip: add property to select
Message-ID: <20231020092729.gpbr7s2cbmznmal7@skbuf>
References: <20231019165409.5sgkyvxsidrrptgh@skbuf>
 <20231020084620.4603-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020084620.4603-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 10:46:20AM +0200, Ante Knezic wrote:
> Ok, will do. I am guessing I should leave the existing 
> ksz8795_cpu_interface_select() as it is?

I would encourage moving it to the simpler call path as well, but
ultimately this is up to you.
