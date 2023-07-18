Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB6E7583B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjGRRnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjGRRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:43:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C5C10CB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:43:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so5710864f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689702194; x=1692294194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+k9BdcG6/wKA2WJ+Z1glGS1nq3dMoRFR2hTr195Q+U=;
        b=PLvVSjnMvyHl1OZDIGH9hu6A+tKXzQyznVfttIiff4Y8nw+DzE7Bp7lfFDNQXwJ9wf
         dUosAf+mXDdAIe2nv9JD97+sLC+Y1NG/7gTrwGfgXCWp2IyvwYZKDSIt2v3TZg+SbRxE
         +j4hCOL/wQvXB1MUn3hb104EIoQgO9ycMQvXKHQQBKy7eaxG08pqbDhQA0e2hr/NqJNp
         CZMMpN2zsbnO4w1zQ+mO5dxRVpy+HzN9Y6yahe+g002Z50dAiTOxNZvjnMbeKPmIg+0E
         V2BDrlirbymAPXdn8iYZo0qvTNingfTyMFD68W4lVbMcuPU8bDkc+B9zfd50kFY4GSF9
         kb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689702194; x=1692294194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+k9BdcG6/wKA2WJ+Z1glGS1nq3dMoRFR2hTr195Q+U=;
        b=RLp/gDVuxnOuPpMGebNF8XNZ3ExODsjRVT7NgJqyEYxFF7CxGPcX55HqODgTU8wMaj
         yhx862apOM1iSQX86s9Ptg06eJmu5Ru11/ohTpKMj/Sp20exPMQ0ZLjKu2K81hE80LaY
         ZIkI0qI5yRb9T+NnUv9JLA/+3zKA9LlCj3uEz3U298FMe79cURP9QH8PN6iMno/6DeR4
         Cw+kAwh3XrRErQlh8tvSzlPxBoOougNg0wxYOrc88zTZKmzU9FUk5py8YpAt6qdMbXYs
         rO/pwRpJmBAm4eFFCheUlZQRTCJNvVnrPmzW/wv1SmNwoQn8qk5Py7I7e8htPRREwUgE
         J5qw==
X-Gm-Message-State: ABy/qLarGpVAJiAE5hfmfsrWVNaJOyPICrEbzqcI0eQ0zM4bmUlXCj0s
        doqwGSJJ2td0EkM+/KR9YGZpH8diEZnn25PWH9U=
X-Google-Smtp-Source: APBJJlHpU5h377RzXJrLYNSB4ttt+B1dMQTiBr3QdTXBVoZ6aerI86g50rdX7YHhRnj/5zYkUn/hqw==
X-Received: by 2002:a5d:52c5:0:b0:314:545f:6e8e with SMTP id r5-20020a5d52c5000000b00314545f6e8emr11873879wrv.62.1689702194500;
        Tue, 18 Jul 2023 10:43:14 -0700 (PDT)
Received: from 1.. ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d6345000000b003143b14848dsm2951442wrw.102.2023.07.18.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 10:43:14 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, takahiro.kuwano@infineon.com,
        michael@walle.cc, pratyush@kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        bacem.daassi@infineon.com, miquel.raynal@bootlin.com,
        richard@nod.at
Subject: Re: [PATCH] mtd: spi-nor: rename method for enabling or disabling octal DTR
Date:   Tue, 18 Jul 2023 20:43:07 +0300
Message-Id: <168970217898.7924.7478939621103935495.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714150757.15372-1-tudor.ambarus@linaro.org>
References: <20230616050600.8793-1-Takahiro.Kuwano@infineon.com> <20230714150757.15372-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=tudor.ambarus@linaro.org; h=from:subject:message-id; bh=O3mGwcG/uRgZe0IXPsDP8xQtTqGuZ1b7Ksp9CjPvyGc=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkts8ppPuVf7YB2psHt9WHAQSmjLszLMRGZT1zl pwrf0twS+aJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZLbPKQAKCRBLVU9HpY0U 6dmrCACTnsHqsHOTTnpDdSZQpw+DNOz3lEr1iMssZNduZkU7c2aW4JFjSJ8rec13FW2SeAPa5Rh HxSjlKpDowVp2rZWnam0ScHAwzKaK6G1C/A39u+/nrB12e7xgMxq9hqhz+0SAG9D076ih1Mfpnr XPIT8226yJqPHAC+Uqp0ACgt0auAndL3UQknxtZYEBMIuOodQPeyc/+tyMN+gYYFwqfSEOHaojv YZ2lH8xPOgpjLrUkmWAo0+0guGXBrb05bw65e5wjrH7ZO7utAEPg3Og9gM0cB9+Wbe8zeC5uQju X97+QoosIMsWFXevnwPprTUFPjMWDGFOZUMYQRqkMsYk/jUN
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 18:07:57 +0300, Tudor Ambarus wrote:
> Having an *_enable(..., bool enable) definition was misleading
> as the method is used both to enable and to disable the octal DTR
> mode. Splitting the method in the core in two, one to enable and
> another to disable the octal DTR mode does not make sense as the
> method is straight forward and we'd introduce code duplication.
> 
> Update the core to use:
> int (*set_octal_dtr)(struct spi_nor *nor, bool enable);
> 
> [...]

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git,
spi-nor/next branch. Thanks!

[1/1] mtd: spi-nor: rename method for enabling or disabling octal DTR
      https://git.kernel.org/mtd/c/d4996700abc1

Cheers,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>
