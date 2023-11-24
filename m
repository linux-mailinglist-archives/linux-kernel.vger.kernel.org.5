Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524E97F805F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbjKXStF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjKXStD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:49:03 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC83E2685
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:49:09 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54af0eca12dso1378634a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700851748; x=1701456548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gBdjGgp5kspN/gTg/5L8/r1olrDflqhJ6eCRhlHgGxo=;
        b=xTCsoIR56qH9sKV1pAOlkzSNhUBKq4qZU6VH3GnYRJAUgbdJvzApihreQ7DZEtAXt1
         v7CFbWLMCb6B9jtK3tMIHw9xwtBUxCt25+7NflC+tTCtAwCAeuLDVjenKtOLmFfgrBRJ
         5IdskGY6c/qcrDUDTbz9vHH1INU+6qvAmI5uWqsCu1qjEjEJjmznd+vXavrqPWrJBAkb
         sKO/NSIZCOEVeMhAzdLNVb3xQo8q5ZjLoahIB6v7THa8pnvq4VwiOTHS2/PH1KXlY/6/
         /pMoqFQhPx3PNbQ8U2whERo08ZZ4gMiKwfCzCz3ap1gJIvefgkGtsIcONSl9anRDOrNE
         SIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700851748; x=1701456548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBdjGgp5kspN/gTg/5L8/r1olrDflqhJ6eCRhlHgGxo=;
        b=Kgf1PWZd3w1BSXna44bc5YowpJwuJJurLFCXcdQ5wFGKLtDU+1LevKSF8flWkrnVpf
         xDD8RTOwkm8ZRV6nC8W9VmM1jTTQ1d+HtoZ0szxEU69eSf4qFQFO90UhbO6FQDPPX8HH
         oTmAExohS0wxDvWhlMlPQG283dp00Th7Kfm9SXhYlG8zWqS+9GOAN34dehHRjLZ+EEbO
         RBQeMYIIehubZ7l3NQaZb0985+uy50pewFk1kwqkF6fDXryEmFs8R86XYJCG9TvE8ODL
         DfAisW5m4/tnExP1Gt9xq2vZ5lTzjob2YadLDZ7fTFUv+Xc5Jd4jh+tsiiK26YqhdKBj
         D9cw==
X-Gm-Message-State: AOJu0Yyw0NlQqNHjYUsa81GCLQpfsduxBivooJXuAwPRISj8+XGTDrbe
        ogmrc5gFllkYJn05Ma/5hhNqpA==
X-Google-Smtp-Source: AGHT+IFtMayisNzoJBbemLuOPI7edYsKAeRO/+QbOkbbj3iWGPQpIpJx5J0Nrzut4lWJ2YFx0hTjfA==
X-Received: by 2002:a17:906:fcce:b0:9f8:2b44:7b7f with SMTP id qx14-20020a170906fcce00b009f82b447b7fmr3104870ejb.70.1700851748307;
        Fri, 24 Nov 2023 10:49:08 -0800 (PST)
Received: from 1.. ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id lb16-20020a170907785000b009fda665860csm2376405ejc.22.2023.11.24.10.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:49:07 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc, bagasdotme@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/2] docs: mtd: spi-nor: add sections about flash additions and testing
Date:   Fri, 24 Nov 2023 20:49:00 +0200
Message-Id: <20231124184902.1194235-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=777; i=tudor.ambarus@linaro.org; h=from:subject; bh=b+NYwpA6daCzuWR90IFNBg+e5G7bQ/pnSbmqUOhVPYY=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlYPAdzQe/vFEYJVzlCJZ5Y6GZNFvYonuk1Br2I 3hs//QOzWmJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZWDwHQAKCRBLVU9HpY0U 6djmB/9E21e/4XBmcLtfvMqdO7x8KNFcVK5kxA5xcfQ7dsFHXaDdRPXke74QAR46lH8IdMfNEcZ rgyrr86phHTvxE8KQlo5vy8OhXM/TW3isiiNa0mBLf053jM+BbAZDazxNeccZ5G45EWRyHUztmK drBffO/3eJNc8FiJ3mu8b9voX+umRDkWi+3SBkdEX5xvYuMdFmkN/x8BCdjrxJ1+/3TdjcHc2Hp UzF0IX3n7jIZ01cSlWHI2zxOpigalnIsdtXz8M0CShzDN5oNl0eEio+G5omgEi4yPpfbNYDKoG9 C7LM2jmuMHIVVNCgGCj4zfbRG8GbQm5+Ht2n2EQZHTp0kO1n
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- specify that we prefer to dump the SFDP data with ``xxd -p`` (Michael)
- update the mtd-utils tests (Pratyush)
- fix formatting (Bagas)

Introduce guide about when to propose a new flash addition and what are
the minimum testing requirements. Dropped the old documentation as it
no longer applies to the current SPI NOR framework state.

Generate the htmldoc by using ``make htmldocs`` and then find the
SPI NOR documentation at
``Documentation/output/driver-api/mtd/spi-nor.html``

Tudor Ambarus (2):
  docs: mtd: spi-nor: add sections about flash additions and testing
  docs: mtd: spi-nor: drop obsolete info

 Documentation/driver-api/mtd/spi-nor.rst | 247 +++++++++++++++++------
 1 file changed, 186 insertions(+), 61 deletions(-)

-- 
2.34.1

