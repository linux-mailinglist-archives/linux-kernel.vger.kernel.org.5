Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200657FDBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbjK2Pro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343972AbjK2Prc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:47:32 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300E61717
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:47:38 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c8879a1570so88196141fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701272856; x=1701877656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRJn66jmWmp7/ZR7vFS84ebK8490j6jGvEbdIOkMUdw=;
        b=YWKUxlDhX6TSVXpg8bGLHebAQsogvU8SuEEDxQKYBml20Mci+SZRmWYBif/3zcLbEu
         aCNuC6JeC13k7Ox/hJHP6vZQRdW1mp4DRKxPRFSJmJwCkq79HejIxwpc3STGblOy6uyZ
         tlmH83khr9ysJlLTNXPoXW6d0Akbq2Te10KLIWVucaH3svAJHKcZvPSrDSlGxTPlv+Yc
         xS1qeW3HnCS+xKOtfwPHcbm7hjPzCFuy0rxl9yUuzfXAGhkTPTxaZFa+lqBQv9Mxa+eO
         WhJALhhJsC3xXHscNrK1wj1p8d2yr+AEQsLpknpm6mOKUa8xrZow8vaXNTokGlJxffPw
         zoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272856; x=1701877656;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRJn66jmWmp7/ZR7vFS84ebK8490j6jGvEbdIOkMUdw=;
        b=mKZg1SubVjJ1WBaMkHVL4rjjAgKXxPuH8fNVZ+a01KL3G8nYYnbynZY/fFlgmcMTnp
         mXPdUrFsNEMXdR3WsAow5/Rz0zKoJ8zr2gZ7wqBw42L4/iQU3zfEULHlKRSISMGztIge
         yHmUQ7VVv2xM/kNAgpEIP52Rpgn7zt5+2Dx7ABZ+3dmSoip9/qroReLv0vV+B8tX7Uyl
         Gr4ZN9k4KPnZU8y5YqMQuNj2XKECyeFRBUiqbA8KWjGn6Wn0EP1XUXr5sDzbZul43sG0
         m2HHb+hXhH1nUwfj9YZiByld2knT1tatuMwlUviJ2RLQCM+bHwQ7s25HWV2sIv2xE00C
         85mQ==
X-Gm-Message-State: AOJu0YxfiH8DURqbUlIp9EWjq+d9KtrGw7xU8oTIFTWXjeWhDinjWnR9
        VoJ7C1pvCepL0wny7/ZHRa0ANw==
X-Google-Smtp-Source: AGHT+IETEW5DdmUBBS65qune7HAaHWNsQy2FXMNw+Ke7eh3cjph9mF3UhiHnJUJcTGvL4QTqjgC0Tg==
X-Received: by 2002:a2e:9ccb:0:b0:2c9:be24:5bcf with SMTP id g11-20020a2e9ccb000000b002c9be245bcfmr1641523ljj.14.1701272856198;
        Wed, 29 Nov 2023 07:47:36 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b004030e8ff964sm2690644wmq.34.2023.11.29.07.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:47:35 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Cc:     mripard@kernel.org, dianders@google.com, tzimmermann@suse.de,
        quic_jesszhan@quicinc.com
In-Reply-To: <20231129084115.7918-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20231129084115.7918-1-xiazhengqiao@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v2 RESEND] drm/panel: starry-2081101qfh032011-53g: Fine
 tune the panel power sequence
Message-Id: <170127285546.3101813.16310801657747690818.b4-ty@linaro.org>
Date:   Wed, 29 Nov 2023 16:47:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 29 Nov 2023 16:41:15 +0800, xiazhengqiao wrote:
> For the "starry, 2081101qfh032011-53g" panel, it is stipulated in the
> panel spec that MIPI needs to keep the LP11 state before the
> lcm_reset pin is pulled high.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/panel: starry-2081101qfh032011-53g: Fine tune the panel power sequence
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=fc1ccc16271a0526518f19f460fed63d575a8a42

-- 
Neil

