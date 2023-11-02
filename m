Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA7B7DF409
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376613AbjKBNkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjKBNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:40:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F14182
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:40:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5406c099cebso1493239a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698932416; x=1699537216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faV8A47tvgpZ5h+iJVem6LTeAncvTfPtpMsFTDEMTl8=;
        b=nksNVbEnlbJSo2MdWScafcLIaKFdjlq0da8To25mbpf8rMQUCikP33EMh5R28TFXbU
         G6tFylY1KI8SJLyFTddtu5cKJW8OPdMoGpGzeFVtdk2UUtK30rk74y8QeGkSrZZ42lfR
         V6yWaBzU5ZE4Ng89iu/8YjKqYR/7O1aO1NruMctterXYu0CSS92s/GuKVTYfaZtr2FC6
         prD5GHSdF19R0YP4BaNS0adngglTGTvXzmk++J92uihspr+qHER9tXpNBdHRTKitHH0P
         BT/4uwCML/FksgSeYliNWCd2y887/kruq20L15G/SrJadbDM2aEBwinYMwYKJ4E7ayYp
         dl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932416; x=1699537216;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=faV8A47tvgpZ5h+iJVem6LTeAncvTfPtpMsFTDEMTl8=;
        b=QOhE0kMzLy7Yay2zREn55Hs7icoD/OCkbdNX/qHOttuKZFvO8sIIZlwdvIL4f4dCOA
         xZGnI/3JyY/74qvQRPDhyUBrn+8lxpXb65gttKOwUVTqvA6wLpXm170FBxt3vk+khgvr
         qJMTSF7+ia5QesRpkJYm7BN/FeWG6fNC6Ig9RQ4aT037dM5Aved0i65/L8hCUxwMdE64
         ucWgXnSTbRK23ikzv1fIP7mwIXqSBszD8nZPARfMMyvcB0f5By4kzW7FaEAm8IVGitiC
         P2P9lUzDYCZcNOr6kqa+LQC1W14KGhw74vrdHbPsUI9XLFqfhw0wkRKJy34jdu6mn6ar
         kiZw==
X-Gm-Message-State: AOJu0YwNgBL2YxPe8A1C2W5Fc39INtQtOFUOgcmuSW5KMIiYs1stSqD9
        4cDEazFCi67q2opCN550fnPSJxdJXRQ=
X-Google-Smtp-Source: AGHT+IFA82hBDVCIm4Aa4h6VWAi5ZV1plROwqOjG/ow5zKHaqtmNWt9drLjQQDuwmHB8X+Kcs1OKAw==
X-Received: by 2002:a05:6402:28b3:b0:540:118:e8f with SMTP id eg51-20020a05640228b300b0054001180e8fmr15039013edb.24.1698932415678;
        Thu, 02 Nov 2023 06:40:15 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u1-20020aa7db81000000b0054366251e04sm2287357edt.94.2023.11.02.06.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:40:14 -0700 (PDT)
Message-ID: <cda574be-4f33-b66d-eb14-92c2b31d241e@gmail.com>
Date:   Thu, 2 Nov 2023 14:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 0/4] Rockchip rk3066_hdmi update
To:     hjc@rock-chips.com, heiko@sntech.de
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Rockchip rk3066_hdmi driver in a somewhat similar way
to what is proposed for the inno_hdmi driver.

Johan Jonker (4):
  drm/rockchip: rk3066_hdmi: Remove useless mode_fixup
  drm/rockchip: rk3066_hdmi: Switch encoder hooks to atomic
  drm/rockchip: rk3066_hdmi: Remove useless output format
  drm/rockchip: rk3066_hdmi: Remove unused drm device pointer

 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 66 +++++++-------------------
 1 file changed, 18 insertions(+), 48 deletions(-)

--
2.39.2

