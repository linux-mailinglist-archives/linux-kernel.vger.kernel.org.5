Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2DC80A396
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjLHMmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHMmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:42:35 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8CF10CF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:42:42 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1ca24776c3so646051966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 04:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702039360; x=1702644160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjQchJHu8QRtple6f9Gf5U88XWgKGzUKlPM+WKnbsyU=;
        b=BVSVjYv0PXwGJ65wJbI8nJ4KTX6H75OwmyHqRobO1pqzUqVnfdGdBy8BQIGIT1Hupu
         ICXzlCYegsOJ2gHILciUvcNjdhzCFXlai7091ntz1pHVP9mE7yWRn8AQpaC0Us0+OaF+
         L2/pTmAodaVg5GrW4LWdj94xlxtLkW8/IG+UPn9IJAnHvsL77zYNovX8Ujss4gz2kvis
         /P+xPtrgFFFpJk909ydERLMQN1MBuXtDXS2OaWdepqr9MM7ihbxSUYQ2BB5cNcENTNzb
         IlR0Xlh5aUEAXS5f7hSawWYw0wFXMC6zsTca92YXU+ZlagDQpIt/yxlokGIl0XPTI48j
         7Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702039360; x=1702644160;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjQchJHu8QRtple6f9Gf5U88XWgKGzUKlPM+WKnbsyU=;
        b=n6/XuryS6ii2krJ+rqUnWxhknzY11/Nk8fh8U4i0teiyJQ9S5cKtFqGPO6G4YItvaF
         4zHIFkF41Z7jQuUtOlqN4gRzwuFP+92rKR3txhrJ+GGauD3XTHouOZlGwyBMAJCsOUYU
         gE0/YMT6pK9Uh/I2yWz5cC1nNMSHE7GEDFP05FNRaSH19jUQhRSZ61bl0K4AFgNVR4T+
         MMDqsGuBIPmxMAzItPmRa4Z4cDq/zB9RrRFo9287rZjpb3XhD+OOBPHaY5dENqWupJHq
         FfLAlQZOGM8dLXKzXsbelck5S5c21CKKdZe5dk+SQ2F09iOktmGAkIK6CDnq4rhIpCBO
         5x0g==
X-Gm-Message-State: AOJu0YwsnBeUUUAn5/pFGzSziboQQKsvMwPNyWIWBjIa3+2TsY5/L1gp
        75j6wNnaoS4zutOnuOOY8Rb97w==
X-Google-Smtp-Source: AGHT+IENq6lcfmEo51Vs9NEBU7dKkjOtZb4+QUEbikhYlWV5ZFvBGl8+MMnTtuC6g9xVMPdtKK+xHg==
X-Received: by 2002:a17:907:98c:b0:a1f:5526:ead1 with SMTP id bf12-20020a170907098c00b00a1f5526ead1mr75007ejc.58.1702039360607;
        Fri, 08 Dec 2023 04:42:40 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id sf22-20020a1709078a9600b00982a92a849asm968908ejc.91.2023.12.08.04.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:42:40 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
In-Reply-To: <20231102062848.23965-1-zajec5@gmail.com>
References: <20231102062848.23965-1-zajec5@gmail.com>
Subject: Re: [PATCH V3] nvmem: brcm_nvram: store a copy of NVRAM content
Message-Id: <170203935960.22033.10753187984539476656.b4-ty@linaro.org>
Date:   Fri, 08 Dec 2023 12:42:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Nov 2023 07:28:48 +0100, Rafał Miłecki wrote:
> This driver uses MMIO access for reading NVRAM from a flash device.
> Underneath there is a flash controller that reads data and provides
> mapping window.
> 
> Using MMIO interface affects controller configuration and may break real
> controller driver. It was reported by multiple users of devices with
> NVRAM stored on NAND.
> 
> [...]

Applied, thanks!

[1/1] nvmem: brcm_nvram: store a copy of NVRAM content
      commit: f019a0e9c19aaa532cb46142e1f333c9daff92ff

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

