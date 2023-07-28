Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E2D766676
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjG1IJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjG1IJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:09:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501AC3A93
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:09:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso20419415e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690531779; x=1691136579;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqLr/DM3vzoT2FIGmxl1EtsMfdCCfHjdp08hXZT3Xyg=;
        b=jNqp0QPCVYTkV4bvppxC/WE1D3dThiR6UKFK8p4qV3WMajrs8aXfR/yEOGVVt4WO/4
         C6lj+p89l37MtuxXWAebhshvKx83b6ctlrKZ3CD7QWkKwaUrDUSdAhTUkL5JZllRwaIn
         aUO/FOw/zeur8egsp7p8tXrfbkQm2MAPBeeKrptG93bsgZA/gRiHUfaZXvUwjeD9JUty
         PZXizjxorCUDAclhWNrac3NH1InWJ9R9WrAat5wjHGfPbEQyyaYYdn/ntfYc9fC8ZlFj
         2jP6M0Ff0Led0BcYGs2Hc3hK+Sblib/akOE7NoPjHj59JUM1ML9mw3yh6Xauefqt8RMT
         9fPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690531779; x=1691136579;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GqLr/DM3vzoT2FIGmxl1EtsMfdCCfHjdp08hXZT3Xyg=;
        b=LeXR7JtNsPyvzkSwcsS80NwEaUc4XxT0RhJA07flYJNmlFXQQjypH1ybTIcmCqZXB4
         A2CpNhY+qhflJWIvr6cKiRrF6U4ol958VK4rjuB65N5FAG+ueKLC5v2PhMYdpngfOqVt
         zo40kIvMmET8Vt5jTC7FWNOC3xgK+UIZTk502sgdWNxvs1KhcnzcW3RE93JZTBqyTNYR
         6EhpF/bKnHG8b793Z7lv3Plq5fDYJBUMiqicIwir3/9Gbe/Mai3Y/Kg2TpuqVHoWsoYk
         A1SMP430Qz6RGO1OjBCan4t4dUL5n23H9PxXFiMM1xTQz3vDTa1HMUxj4GfUVYKnncWY
         XNMA==
X-Gm-Message-State: ABy/qLbifrcfZMcYJvH+pQOmvWtDrN1U2GstXp2h7RSFeBiSg9hyGYty
        Hd5/qNk98kN7mtcK6E1Ib3A=
X-Google-Smtp-Source: APBJJlFQW3i7+kOV3XLOmwouH4a0XHOhL2g3BliaVEr4MqWslzbF6GJX6aD17eqL//lIKPOLtJwD6Q==
X-Received: by 2002:a7b:c853:0:b0:3fb:b67b:7f15 with SMTP id c19-20020a7bc853000000b003fbb67b7f15mr1289443wml.21.1690531778542;
        Fri, 28 Jul 2023 01:09:38 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id f21-20020a7bcc15000000b003fd32074e74sm6447479wmh.31.2023.07.28.01.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 01:09:38 -0700 (PDT)
Message-ID: <29e17fa4-0dc3-2542-f303-7dceb1ed16bc@gmail.com>
Date:   Fri, 28 Jul 2023 09:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: drm/nouveau: fan:
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

static analysis with cppcheck has detected an issue in function 
nvkm_fan_update() in drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c as 
follows:

         /* schedule next fan update, if not at target speed already */
         if (target != duty) {
                 u16 bump_period = fan->bios.bump_period;
                 u16 slow_down_period = fan->bios.slow_down_period;
                 u64 delay;

                 if (duty > target)
                         delay = slow_down_period;
                 else if (duty == target)
                         delay = min(bump_period, slow_down_period) ;
                 else
                         delay = bump_period;

                 nvkm_timer_alarm(tmr, delay * 1000 * 1000, &fan->alarm);
         }

Checking drivers/gpu/drm/nouveau/nvkm/subdev/therm/gm107.c ...
drivers/gpu/drm/nouveau/nvkm/subdev/therm/fan.c:93:17: warning: Opposite 
inner 'if' condition leads to a dead code block. [oppositeInnerCondition]
   else if (duty == target)
                 ^

The first if statement checks if target != duty, however inside the code 
block there is a check if duty == target which can never be true. Either 
the logic is wrong, or the duty == target can be safely removed.

Colin
