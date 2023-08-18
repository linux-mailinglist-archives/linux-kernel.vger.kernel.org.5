Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625A278095C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359571AbjHRKAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359607AbjHRJ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:59:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00C830F6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:59:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so7190715e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692352763; x=1692957563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWfiFERj7vA+UlXnQZ40sFn2d+5FoEugxlHGm1w4MYw=;
        b=ThJVQY0VaZ94PdRIvlv8EPgOaqlv7cMrFuoVZRClsAnzZhzQgCk6YPzr+Kqsd1qzRG
         ZFEEfOOpHACFeLNKBdEtKqLO5OIC+q1n5vz7Dz/2qnlQQbMKEesSEvDqSevdrB+tEGis
         vL3L9AOFlc4pjYLvVFkJU1l/ikWD1R0UgR6q2/yFzq8vVyn85VA7aMNrZTGbYrQwb+EL
         AZsZpvEpslZLXo+hJDayz+vaIXPf9o4Wa0DEqBoiNE/Bu3drWEt3xQxK7ZHWsf/5TwpQ
         amkN1LNl36qSrl0nVmkQyejOYMTZxNML0v/H39+x5jWslp31R9tYwItNR0YUhkHGlOWg
         qrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352763; x=1692957563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWfiFERj7vA+UlXnQZ40sFn2d+5FoEugxlHGm1w4MYw=;
        b=IdoibnbqOdgw1KA0CCx1PoRbDPLhca2p1vZPr/TlsY387xifnbO5w8gMKSWPLrQhAQ
         W/P6CDLt5lEqCd97goKO2jht4nWJDcHHGduSYHQuujS6WxzmDqkUBd9LzVV5fc1a4gAV
         4zWlOVUIYvJVsFoKfD8cszc8mbn5BAgPgqP+8o+bS8zfz1eoekqSXmAXRoY5wIXvpgYx
         Cf4gmRkwABLsKDZnslSlOv08qeXw6tMyzcXXn6lznCDaEuXE7IsODwnpRCS4Zje9eQB8
         KhHgFn+l/kFWD/KU9EHaFxoeec+yk1mEM/pzkGAqnA8Un8P+n+1eLq/5MtuDlGYgS6nb
         c6Yg==
X-Gm-Message-State: AOJu0YxMh/bnR236diNg6wXSBEHiyoWslerjjcFe74QtrBAUX12Niddm
        j/C5KhkRxBrOnkAU2BChXbwHvQ==
X-Google-Smtp-Source: AGHT+IEV4UxFRczlomY7J0SXwmRZxQGovHsQZc+ztEb2Xaj80IKNOT1KUR+YRWbtEG5+RhMeopKkTQ==
X-Received: by 2002:a1c:f701:0:b0:3fe:18d8:a61b with SMTP id v1-20020a1cf701000000b003fe18d8a61bmr1836801wmh.29.1692352763059;
        Fri, 18 Aug 2023 02:59:23 -0700 (PDT)
Received: from 1.. ([79.115.63.195])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c028500b003fe505319ffsm5726678wmk.18.2023.08.18.02.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:59:22 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: spi-nor: Check bus width while setting QE bit
Date:   Fri, 18 Aug 2023 12:59:15 +0300
Message-Id: <169235271779.45114.300580580063413210.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818064524.1229100-2-hsinyi@chromium.org>
References: <20230818064524.1229100-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=470; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=Bp+PiKv4ARstIAO0GX552wPxr5uZN46GdvFLMgvexoY=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBk30DxGYnKe9ioTDD7Y7yNbB9VC6LNKpbY76dwb H85tP7GY3mJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZN9A8QAKCRBLVU9HpY0U 6W1DB/wOtv2/Bk7wUnRiHYqw90fL01w0nKXvNpbcKPucUKDK6GknxLXsistATCCDMgLxOuLj2GP RDHUcIAOCpyVRArh+Y4obwrsRvt9j30tZKxfrL2OQ0j7a2X8UVzzo9itS16KSnDwkMA/LyH8GaS zh4arLgE3SnMq9sTtOwr7oizcYbSdnlBIJTi7HKwmNY9ScAYdjV6XwjwZJAnp8+PXc+5fTr6QX+ gNbEWAJVTFT/PuzoM2t/iKffAGAHdFRccTv2p5HutZoKnVNNjKjAY0hX2GQTl90XFCR3q2QvP03 A97G5ljoNN8xbn7JeeYsPyl8q1HR3wt9hEWq7vmUz7TM2a0V
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 14:42:23 +0800, Hsin-Yi Wang wrote:
> spi_nor_write_16bit_sr_and_check() should also check if bus width is
> 4 before setting QE bit.
> 
> 

Updated comment in the code and
applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/1] mtd: spi-nor: Check bus width while setting QE bit
      https://git.kernel.org/mtd/c/f01d8155a92e

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
