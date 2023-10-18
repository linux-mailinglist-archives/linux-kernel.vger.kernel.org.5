Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC647CD347
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 06:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbjJREw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 00:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjJREwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 00:52:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A8410E9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:50:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so10982493a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697604649; x=1698209449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJTgecuO9IlcEiPhpF1l4nKhffuqUxUpzxSxXR6k2WI=;
        b=neI6taRDE37ADVJMDSELWP2AszuEgLtZcewaIzzWvpk2MN8VX5nPfJoh68rQZwgYG6
         lUsbLMRWW2THDeMbM+tIXWbCr5ihdP3cP5eCNzyLj+6FxIvx9QvueA+X92aKynsVUQD9
         7WxLvaJ5obpDkR8+4zfp0vPGSV7+t0lbeLvSdkx7+ORnvf+XFBo9jEkyYu48zUAJfzZh
         2R7f1Mz9jG6jtR1zNoc0dyzPJyHPM40AMagP3+u1BN/S48w6DUhiRd7umrT4dCdGPFKu
         4dxEhPd74P/8+xlpraaR4AhXhytmPpTEWBgnWe+hN0HoeWC3lbFw41jRJtZUmsqv01SQ
         yeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697604649; x=1698209449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJTgecuO9IlcEiPhpF1l4nKhffuqUxUpzxSxXR6k2WI=;
        b=GB/ZJETz02kvgojoC/TCkBdSRkmDUw56YI4zSC/CXZiNyfWQSfsdPDDxKuAxdK1NSh
         dQnrvQpBMvJ3xIVK3v804gE2QmufjM7wHi/bPcTiKIdRtpXIDd3qhiebyrk6t6soeGQM
         3nY6VDysa6Z/z2ytuZB2sf4bTwok6jE6W6lVIZOeIycL6A2KJM/RoHUHE7oFSbAEroUj
         +4IeYVteTFxe+AJybKTUO5c5AcE5Rft1HLyK/r7jDbPSJgbakiGDX3ZkH+upkmUx03W7
         vF1kR8nHlPJW4jL164TgwAYJvlJWkoQnxdJE3oEhYGBKFPY3Y9amx7xAOq9bTKLkat1J
         otzw==
X-Gm-Message-State: AOJu0YzeK1ImPFBYEOCcAB6jASAwTOqqhcfFOe1rvCxv73/UiJhllt7Y
        I62PNN5epO+NIpbG4d+yk4DVtQ==
X-Google-Smtp-Source: AGHT+IGjPZ9tpAlShZ0QPpySXzyhCBr1xtf1fcfhMo9RW3fvI+GuhFJT9QRkEKU0ndTsgjkMEHz3gg==
X-Received: by 2002:a05:6402:50cc:b0:530:77e6:849f with SMTP id h12-20020a05640250cc00b0053077e6849fmr3496073edb.27.1697604648893;
        Tue, 17 Oct 2023 21:50:48 -0700 (PDT)
Received: from 1.. ([213.233.104.181])
        by smtp.gmail.com with ESMTPSA id n30-20020a5099de000000b0053e469f6505sm2196878edb.26.2023.10.17.21.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 21:50:48 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: Re: [PATCH v4 1/2] mtd: spi-nor: micron-st: enable lock/unlock for mt25qu512a
Date:   Wed, 18 Oct 2023 07:50:44 +0300
Message-Id: <169760461825.6371.1786952858220503854.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017074711.12167-1-tudor.ambarus@linaro.org>
References: <20231017074711.12167-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=620; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=4Fa79AGkAfQS2RZS3SU5DMBGknFdIGFh+yLgsIhDUqo=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlL2QhQML57IIx5rz4mOWlvdIvFXMR81sXg9IoH QRIeZY0xSSJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZS9kIQAKCRBLVU9HpY0U 6bRJCACYL8lhh1R/Aij6phFer7+gwBjqMQkfg7oa5Ym/dcZaymlmbh+k45ldRFvuTWs9Ir5ucaE pwyNWMeYoWu0PpUUn2TV8e16j/cPgngkpSuEcFGC6PhZS+Y8kDF88cS4sO+y7tqqdnAbcnH8lr0 PusnqogpAlRByC18InUI+kv1elwABndLpIBXbMwK+FZXpaUeLk12zai6QyqmLkwmR8XCu7LJ3H2 YjriO2QbJsKXE0U2jXGoIbTEuwfIOKITn3RaznJxoAvPRnRF2xA7hbfwCSRzTA8Dq/GySveklwd 2JWbJCgW9AGhp6ksa56iqjKa8BN/sLzrAUsQbhXGDa0yc6fs
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 10:47:10 +0300, Tudor Ambarus wrote:
> mt25qu512a supports locking/unlocking through the SR BP bits. Enable
> locking support. Tested with mtd-utils- flash_lock/flash_unlock on
> MT25QU512ABB8E12.
> 
> 

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/2] mtd: spi-nor: micron-st: enable lock/unlock for mt25qu512a
      https://git.kernel.org/mtd/c/a2a3e5430e7b
[2/2] mtd: spi-nor: micron-st: use SFDP table for mt25qu512a
      https://git.kernel.org/mtd/c/6823a8383420

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
