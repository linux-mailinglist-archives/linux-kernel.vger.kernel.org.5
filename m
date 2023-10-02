Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052D07B4C5F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbjJBHMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjJBHL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:11:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC188E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:11:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50567477b29so4914093e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230714; x=1696835514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebhLT7Bk8BegSoKqGP/uGHgUFUu9P9Y8HhtEWWMfVHo=;
        b=xq0S0horA4OdXjx1Os3JqPE8SdoHKDJiKvFhGHQiZ0fMbl8uoU/86R9/AwVfp0CJlu
         Wl5DFuctcXIXqSwxcXH/ppXO87s+OpWRHQuBcqmO2NbtrrM7HwIcqli5GdqoTYmxQ5bP
         qiSFyjZmNDmgTWgav4HLT+KpdG/didiJZvXJWN6QXnz+hMAr5NBz0wlKrh/kwKJr3pMf
         cuQhCOHSeV56v1llzBy+lsaZJ3MroXpvwAfmBPQcMxyMzzQOnSqAH1GatJ5I9yzg7BFb
         wFfuV3FP0tOni7lBJLz31AT+Hl3RCZDUTCucr7PCIEJBzYB8dSafGITd++4CnT/Q5BA2
         DwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230714; x=1696835514;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebhLT7Bk8BegSoKqGP/uGHgUFUu9P9Y8HhtEWWMfVHo=;
        b=e1g8bZVK1mBfw271Ea857Tk+wyULNy51aqSLQ6Fdub0T02gsT2R8y7j+LQGuz7u8Vb
         BwURIoGRYo6v2+FMNhD6216GAJVOUX1Dc5o0BX3voVhu62uguXNSTrnciC8ip79gWAt8
         GzIom7O/kvu+/9clJIHszasVLC3NXnfL9Kn/gbYNPy3jyCTxDk3mPpQDfSvpFUWbd/Rd
         KuYz+20cw1P/qkesvOVfizaOmQovmznQFwh6ZTlHM/bO4H3J3mwOGHa2kBU4GJ4QXHyh
         S2aDZAL7JTh118ebj9hDsmhiFy0Bt9emWnOez4KIeSE/SI6/FuNRr7J2rsKBvgxesa7z
         unDw==
X-Gm-Message-State: AOJu0YzHi0g0qGHby+4oMQRMPAkhrGFupdN3rBdV3oTLCDXziyzWjDkn
        CKgt9f5ogV5wnhEeWundILRFsb8Sp4bBVlkWQnAYhlNK
X-Google-Smtp-Source: AGHT+IHuSrV2k6DA9B2OyyK5jQodlrfkuCDECVUkCMO3P3mkH1WF48HtXVeYwdF/JDJumnd9eE3aWQ==
X-Received: by 2002:a05:6512:3986:b0:501:bd6f:7c1e with SMTP id j6-20020a056512398600b00501bd6f7c1emr10840429lfu.33.1696230714694;
        Mon, 02 Oct 2023 00:11:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b00405623e0186sm6601371wmj.26.2023.10.02.00.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:11:54 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Luca Weiss <luca.weiss@fairphone.com>
In-Reply-To: <20230927-topic-fp5_disp-v2-0-7b5e1d1662a6@linaro.org>
References: <20230927-topic-fp5_disp-v2-0-7b5e1d1662a6@linaro.org>
Subject: Re: [PATCH v2 0/2] Raydium RM692E5-based BOE panel driver
Message-Id: <169623071357.3600226.13335704878597295966.b4-ty@linaro.org>
Date:   Mon, 02 Oct 2023 09:11:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 29 Sep 2023 14:54:19 +0200, Konrad Dybcio wrote:
> The Fairphone 5 smartphone ships with a BOE AMOLED panel in conjunction
> with a Raydium RM692E5 driver IC. This series adds the bindings and driver
> for that.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add Raydium RM692E5
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=d1fd19e6bd7d276cf2290300cc563e2e5ac4ebf7
[2/2] drm/panel: Add driver for BOE RM692E5 AMOLED panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=988d0ff29ecf7ab750b9be29fddae588156c3d03

-- 
Neil

