Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C516077B910
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjHNMwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjHNMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:51:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92745E63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:51:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31965c94001so2010182f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692017499; x=1692622299;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtxbpPobBQ60qiIOsVcRjACO5EAGCWGmZXv0NYOmeRg=;
        b=iu1W80X1P0xOIbese/6X5rDsMCWlQoc0D1Xk22w9Ht/qrOXzzK7Nm84yUPBh8YBpeK
         dOWHYGdy4lJmmH1/3QRUDsTm2HPW6+ftxT1wwkC9Oql74xxUPt+M98v1ItIzM/PnFU37
         J3VZxbtCo0nsnKA66BnNTBD2b+q8TBL8jTjZDFV2cq5gwp1NQRMyiyatT+HRFIMJGh+t
         KCr7uZTuVjzoPgPvULTenrLorOeDpVx4bhlrU9pt+sdfB4cChdsAtj/3pwPY9DhT4SEl
         fpdjiI8AhDDXQrkR7kFYwQbs9/yV7AOQvH+7pgFw2BA8e+CbkwgYA2URbjsLBHlj1TYA
         nkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692017499; x=1692622299;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtxbpPobBQ60qiIOsVcRjACO5EAGCWGmZXv0NYOmeRg=;
        b=Kt/NNynaVmlAUJ3w6kj0G0f5NCBFpxAax1Fd4fib8rD90R80HPTX8IEhSPSa9YgTIV
         +C+dogEvutcnXML70lhN5GPS4DQZtpijLxAzIUjVPoAolv12FVGSQIzy/8wHDS0IhibD
         78DyvrG9inObIyt/xgD6GxlahZl5jBBAFCv92BcYY0HbQWDMS410VVtTDO/URpkcMgXk
         L4DP16yZTV7sMmJDVLXk+2Y2k8IhazFa2nxAYe/HS9jwHAmXxy7znXsspQrdMmXd8iKP
         IxHxpAo6vn+ckjR+xbYhxAfppnZZaEvsrOKw+Eb8ao1iYNsA5yIDnVksy+sm8YUBsnr0
         NemA==
X-Gm-Message-State: AOJu0Ywc1/S6aSgBXDnrVLuOzxL/TrENUqfJUnELxyl0uGiO8C8pSYkL
        kveq3WvGETZhKuaoL4/thsJ+kw==
X-Google-Smtp-Source: AGHT+IF9Cqcw4S9B/6raPS2pKVWvFX4qVWroY2Ok1sBCnVHvIifsYoZYpdmVpde3HqJt8fcobXdLYA==
X-Received: by 2002:a5d:420a:0:b0:315:a1bb:4d7b with SMTP id n10-20020a5d420a000000b00315a1bb4d7bmr7632107wrq.35.1692017499598;
        Mon, 14 Aug 2023 05:51:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r10-20020a5d52ca000000b003140fff4f75sm14432530wrv.17.2023.08.14.05.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 05:51:39 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
In-Reply-To: <20230804151239.835216-1-luca.ceresoli@bootlin.com>
References: <20230804151239.835216-1-luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/panel: simple: Fix AUO G121EAN01 panel timings
 according to the docs
Message-Id: <169201749881.1408950.3682671362847659092.b4-ty@linaro.org>
Date:   Mon, 14 Aug 2023 14:51:38 +0200
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

On Fri, 04 Aug 2023 17:12:39 +0200, Luca Ceresoli wrote:
> Commit 03e909acd95a ("drm/panel: simple: Add support for AUO G121EAN01.4
> panel") added support for this panel model, but the timings it implements
> are very different from what the datasheet describes. I checked both the
> G121EAN01.0 datasheet from [0] and the G121EAN01.4 one from [1] and they
> all have the same timings: for example the LVDS clock typical value is 74.4
> MHz, not 66.7 MHz as implemented.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/panel: simple: Fix AUO G121EAN01 panel timings according to the docs
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=e8470c0a7bcaa82f78ad34282d662dd7bd9630c2

-- 
Neil

