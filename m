Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E54E7AFEE8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjI0IsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjI0Iry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:47:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD705B3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:47:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1348913066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695804468; x=1696409268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG+aXkNbfbxBluGasKx11ard4exS0JS35Im9h3EpZhA=;
        b=basUrGfH6HrsKZRKY7liaNuinnJAzRHR6xd1iFAi9slPLhS/xCoGijLEx0FmQo0Tng
         4Tv4PNQWSRZHwo/1wAmsjzbR0IJSDcGgyY0qelnBG07zHyvguYy38AjMsz3JLbMM4izu
         OJBYUJmbNBwDjH/OQUPFv73ijNFMqQVkH8mfg9o8GNw8sAYbzt6KISvb4M5yjzXEN9rS
         RDuXFRsNGX0MjMRxtMiXozxot/dX24XAc77S5Ijc3FEPUD8yI6T3sKM0yByURf8Mwa/y
         KaFWhj9ncthsa4iFHYxYo2JO5dj06HZmRNpc3WCxZyvF9oWB6PipghIC3dKDY3v4XZRv
         WOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695804468; x=1696409268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG+aXkNbfbxBluGasKx11ard4exS0JS35Im9h3EpZhA=;
        b=JiibM2NTL9uyGsSoEmoCNx/IqYLhwhwVu74jLPBIGWZ42TSjLdEcnZrEOJPlUa3TXe
         zmgZSUkth6ha+pQRdm2puW4If03fjguv/hwi+x2toSLJmpn4OnVo2ee4s44eNzAKq+UN
         HT1iLtLuacwYZthIiXEuPrhGREWWeDemeq8bR/Me6jN30E++2vrLS0paJhtJLo15M5vt
         oqsbtDpouyiSQVmT/Bwe368RvHc737NNKvvRT++hY5OwPdjxlFOgAJVGB/oaDDn6zoz/
         Mc69W57y0p34bVoYT9danmUOcB+XXvIN0JVcb4dX4q3YUJ6NhC4Yp8CCwY48qRj/hfUT
         ILHw==
X-Gm-Message-State: AOJu0YwTg4ll7yEybTFmv0Gvnneqq4w4T1ENhXq6x7/tqTJkY15wHN6o
        SVpypjEg6yb46/okzf1HzUXE8A==
X-Google-Smtp-Source: AGHT+IGfbYjgsqnjDdB+1ueCcIXEFM9gahUF8DxTN/prspZwTFUzdbaBaRYAhTpkpvSrHO+dtO6XYg==
X-Received: by 2002:a17:906:2189:b0:9ae:7681:f62a with SMTP id 9-20020a170906218900b009ae7681f62amr1095215eju.44.1695804468278;
        Wed, 27 Sep 2023 01:47:48 -0700 (PDT)
Received: from 1.. ([79.115.63.123])
        by smtp.gmail.com with ESMTPSA id lv23-20020a170906bc9700b0099d798a6bb5sm8988021ejb.67.2023.09.27.01.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:47:47 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        nicolas.ferre@microchip.com
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: atmel: add at25ff321a entry
Date:   Wed, 27 Sep 2023 11:47:44 +0300
Message-Id: <169580425755.36479.12426920554100135654.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926131655.51224-1-nicolas.ferre@microchip.com>
References: <20230926131655.51224-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=558; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=KW1K6AmNfX80IsnR9xpUdUv6VGG97t5DOKpqmZ7gNtg=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlE+wuqZPbqnRe2nbZAzVsbQm+067KrUdralogc /U169CXCrqJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZRPsLgAKCRBLVU9HpY0U 6QvoCACSUw+04JAcr1Q/YGxqO2jKfbnmEB0GRWZjOqQnb+wovxPsnLphKeT7iLDNCgctgcFSdO+ erxbJ/HNDLdx62Ud7LLWN02rmD4OTHPI3nXhYVBrxnUV+cF79QzhWZd3Btx59PKwILLrdiQnIom U7j4Nr+k0jIsvZcZXi4bDNKSoBn7MS7+QjQ/J5aXZgPYg58HoI3bg/XAI1FXGUC9p4JcYEorpl2 an4XzrDarr66EPcBGxHZMOmwWspTHzqktJy+zJ9aAMKnTO921N6LJjKFPG30JttyPGzz2zpCbse 4F2/94ATMDbCHnur6Ai9LNk2kmu7EN8nSAjMhzIFTwz4Nl5u
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 15:16:55 +0200, nicolas.ferre@microchip.com wrote:
> Add the at25ff321a 4MB SPI flash which is able to provide
> SFDP informations.

s/informations/information

> Datasheet: https://www.renesas.com/us/en/document/dst/at25ff321a-datasheet

s/Datasheet/Link

> 
> 

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/1] mtd: spi-nor: atmel: add at25ff321a entry
      https://git.kernel.org/mtd/c/8f407eda173f

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
