Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E097879831E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbjIHHPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjIHHPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:15:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2521BCB;
        Fri,  8 Sep 2023 00:14:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31f6ddb3047so1509074f8f.1;
        Fri, 08 Sep 2023 00:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694157296; x=1694762096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNHspv89ggnSTyMs2COrYspoCC3kSrKdbTiTVgJufDo=;
        b=FnzClHZa5gaT7aSryjDjaZxzjAr/Z2wKVhZKTySRBH3CnrVTwl5AeI540n9TCVIKWd
         U3tFZoiH21G2xKlTcbH/fOYhK0gQBuUh3NtESDeaS3W1tfY70fx99b5MLflqjnwmV/6N
         R6mYlijpXIH8dU+cl4k9wk2xDnvc03b6YY60aS1hHTstDKATqFyTzwOAnED6URRvi8Cg
         ATzeHk3IQO9tWNvviQkc1lvKdu2/+s2Ov/52xAjRCEm6yTOpXCYuFbSm30zo3Kz9QbMP
         2YZ1ZFNUlF25mbZNr6aILyp0LFcDJsp8+jfpWrd9uq64//TEIC/M4ugTI111xGJlHSos
         T6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694157296; x=1694762096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNHspv89ggnSTyMs2COrYspoCC3kSrKdbTiTVgJufDo=;
        b=Tb4cS6NiovOjgx0ojzQkbDWOYcLfprgN+6lE7A/j0tcXv15GHTfEYHxWNx6BH8OzNC
         JpGn/36g8yH7arPN6/fL3rslmkhhLXk4jwtPZ1qek0vy8n0+XX5kdcYq8YUBD04gwPW9
         spt8y9onlFxoPC5co6iJU/AzAcWxEv7iTI9nyzjn/9bZJeBbPu/2+OS+h9pnqKfgmBbN
         i+KzxUs5X75wFM+sYuVQXJvWKGJdJyk8FN+b16rxnhM3TUB3IK4xHDE1tQZjCOb0C0pI
         I/X+lFKDxY/+uaLOgt1MadcaDlLfceetadFFYOQvcL16ynzppqF1zF/jpocfT9vfGa+K
         6KLA==
X-Gm-Message-State: AOJu0YwhqSSO4DxiB+SH1ljh1wWg0TbWj0ZbOsTjm0YIRm33X2/wuh8i
        0+eX7tR2TN4A13UU/upcxO8=
X-Google-Smtp-Source: AGHT+IE2LOhmJ7a0Eaaho+nMa6E/GFsfoic6+N7oaWU8X67psTNgnjcbPiHsaT4bTk0cY452AN9BlQ==
X-Received: by 2002:adf:ef4f:0:b0:314:1313:c3d6 with SMTP id c15-20020adfef4f000000b003141313c3d6mr1165422wrp.33.1694157295706;
        Fri, 08 Sep 2023 00:14:55 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b0031912c0ffebsm1290856wrq.23.2023.09.08.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 00:14:55 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     mazziesaccount@gmail.com
Cc:     ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
        ang.iglesiasg@gmail.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com, robh+dt@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: Add ROHM BM1390 pressure sensor
Date:   Fri,  8 Sep 2023 09:14:21 +0200
Message-Id: <20230908071421.1309276-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <55e59e66824f75ce8ffe58d3463a9cbca56e25ac.1694001462.git.mazziesaccount@gmail.com>
References: <55e59e66824f75ce8ffe58d3463a9cbca56e25ac.1694001462.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

just accidentally saw your series.

On Wed, Sep 06, 2023 at 03:37:19PM +0300, Matti Vaittinen wrote:
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        pressure-sensor@5d {
> +            compatible = "kionix,kx022a";

I think the compatible in the example is not right.

Best Regards,
Benjamin
