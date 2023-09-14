Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C079FC25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjINGiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjINGiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:38:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C588CCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:38:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so6546365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694673485; x=1695278285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ln9AYYR12krk4RrRHWYO/LjdYMxN479/wAy3HLaC4E=;
        b=LKoFw1ZsEPVitQv/QBGJj+3Q062VKdL9KZvfQemkrsVQHpEU14qFK90vwnsJV0MDkz
         paFiqeA4HZr3NnCgszcnkSYCsIttRfC7GQ3raFunY1nhUvt5RnY/rqeIogUUGvrK4b4T
         JoKP/RQKHfgL/4FrSvoIk+aXBAVDEdBxdpfmwT++WphT707ZjY2ZRT0dJo85EY4DTafo
         W3EGgvS6R7LIWOTPmYazqGeo6gU2TkhuRBVId+jDnDT1sdDeqWDZGTN+hdgNCVZwfrOf
         vQbubjLGLh/bv/dqnV0l63hunl5+g+sofejyIS8N37WtKaoBGXkG9lEnKqWUmUeJa3i2
         kW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694673485; x=1695278285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ln9AYYR12krk4RrRHWYO/LjdYMxN479/wAy3HLaC4E=;
        b=Zd2Q1xZUVIW8RUZVSn/OmCDLxnPXV+S8xJs9GeoT2mLs3UUB+KFNKWmrNM0puDCmaz
         6gEMePObYka6bFmBdKcJnigOlYS+9NPuYwrteRyBOXuD8SEms1A3Jjg7UyJXdVFxVRps
         TowuJI4jTS8wYZbxabypeg+JGifUsdg7Eczw+Cdj/thUZa1fOS9d8Dys9tSuMsETVMCi
         Fo/BTBa3WQywleuIzexUtW8GpAqWA15E2bbZppfZnJT+KnPY3OEqk8g8T/EWMHgIQuKH
         jAWNhOcPFSukHzmH607zE4E8ovMPBGvrpsBpXQACCuCYoATIfW+1dpGkZ9cBiyuSwArb
         RPGw==
X-Gm-Message-State: AOJu0YwGMdAsVgMBFlpz+ClFZ1b5UN65Q/Zdh4VsfT6zeCnCuLMfoV6g
        umDMQN/vEOytwxVbMkhMgH67/q/CrLN/J6/sBuY=
X-Google-Smtp-Source: AGHT+IGPEw/siPqdPa1mmpWtwvScyxJuter6eejbGV+yhWaeYVM/X3KyHBo5xANDsRBa4zWBvGUj/A==
X-Received: by 2002:a5d:58fc:0:b0:317:6ef1:7939 with SMTP id f28-20020a5d58fc000000b003176ef17939mr4011730wrd.23.1694673484942;
        Wed, 13 Sep 2023 23:38:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k3-20020a056000004300b0031fba0a746bsm851192wrx.9.2023.09.13.23.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 23:38:04 -0700 (PDT)
Date:   Thu, 14 Sep 2023 09:38:01 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [RFC PATCH v2 3/4] staging: vc04: Convert vchiq_log_info() to
 use dynamic debug
Message-ID: <7ea529c2-3da6-47df-9b09-28d4ab36c4ef@kadam.mountain>
References: <20230913185528.770634-1-umang.jain@ideasonboard.com>
 <20230913185528.770634-4-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913185528.770634-4-umang.jain@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please rename vchiq_log_info() to vchiq_log_dbg() or something.  When I
see "info", I think it's a KERN_INFO level.  This is all debug stuff and
it's done correctly but the name is misleading so it looks wrong.

regards,
dan carpenter

