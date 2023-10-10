Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF27BFBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjJJMtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjJJMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:49:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60D4C4;
        Tue, 10 Oct 2023 05:49:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53b8f8c6b1fso4859072a12.0;
        Tue, 10 Oct 2023 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696942183; x=1697546983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpyGzsJqUZOdlNhUzdO0XHC5n7dKd8p4LRJo7y5zFRo=;
        b=MFsqCqzBwtbPYkZzimJkkeelASqdtkzchD5ExD1ibdNERTvEPuSUn+FPECCnny1ipw
         I08tty6E7rONJqMnQdToCqhmgmbtfYJB68+aA3UnDEB8HO9/2/Meptj9oxj9LOyOT2zA
         MpxQCqleVZaGZhR44IFLfJVO0Y0KpUmgyMqRmaeHe0ydhjSjl9IrHMHjvmaLJpn+K0Cl
         ymV9VFLdJVtNShUlFx74e7vdsQLxN1tYSZX+oysda1+dxnW7ZRakjodlTxJQ76n+HT5J
         QP2AKz6CsWkAbLhXltVFuoJ9gHh/slaqD75vpYoKr7oCI83mJPe76IcADuhg2o+tY+VV
         46aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696942183; x=1697546983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpyGzsJqUZOdlNhUzdO0XHC5n7dKd8p4LRJo7y5zFRo=;
        b=LpXEmzkjiMbS2+5tU3snaGSDmDhi98Kyz33C0cwwoRcQsNejLnKkagK2Z+96x3XpEU
         bW6iujbVAJzmQfFTZ8ebkkpp1uv6SA01+Fx2jm6YjZ60QKqYiNfdLAkifyMnrMD5ox7W
         H8CAbcqGMr3aGNaH35ie/BzueTI7jZAZiX+Oc21D3jwhTxk8AxZt6oETREeWjoXTqIta
         300j4TrartMUl0iEWvPX8Dv26SZI7SSuTXP/K8BmdrN+8zGHTuujGP9ZXakNGTuML/wu
         Gzb+C+lTmMnomS4Xw6Bx94obq/WmfUV/zAzWIOMDc6X4ieYWh7OFl15tOMS+pNeuGvaS
         zw+Q==
X-Gm-Message-State: AOJu0Yx3Ct/77HfoEPTPKWh1SUEjiCcxNiCDmrX61T6SdM8wwUHGGcLw
        V0XjamGS+Z9rbR+d1sXNSUg=
X-Google-Smtp-Source: AGHT+IF7LULjTm+S3KYKN7FnsmB66pHjXcemL5nxvxUlEt8GQv43A61btvDeO6+D37l2KuCTn9rGXA==
X-Received: by 2002:a50:ee91:0:b0:51e:53eb:88a3 with SMTP id f17-20020a50ee91000000b0051e53eb88a3mr15020100edr.25.1696942182843;
        Tue, 10 Oct 2023 05:49:42 -0700 (PDT)
Received: from spiri.. ([5.14.139.113])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402005a00b00530bc7cf377sm7629476edu.12.2023.10.10.05.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:49:42 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] iio: adc: ad7192: Remove unused member
Date:   Tue, 10 Oct 2023 15:49:25 +0300
Message-Id: <20231010124927.143343-3-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010124927.143343-1-alisadariana@gmail.com>
References: <20231010124927.143343-1-alisadariana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisa.roman@analog.com>

Remove extend_name from channel macro since it is not used anywhere.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d72a190c5109..fe47ef43b3d7 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -895,8 +895,8 @@ static const struct iio_info ad7195_info = {
 	.update_scan_mode = ad7192_update_scan_mode,
 };
 
-#define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _extend_name, \
-	_type, _mask_type_av, _ext_info) \
+#define __AD719x_CHANNEL(_si, _channel1, _channel2, _address, _type, \
+	_mask_type_av, _ext_info) \
 	{ \
 		.type = (_type), \
 		.differential = ((_channel2) == -1 ? 0 : 1), \
@@ -904,7 +904,6 @@ static const struct iio_info ad7195_info = {
 		.channel = (_channel1), \
 		.channel2 = (_channel2), \
 		.address = (_address), \
-		.extend_name = (_extend_name), \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
 			BIT(IIO_CHAN_INFO_OFFSET), \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
@@ -922,16 +921,15 @@ static const struct iio_info ad7195_info = {
 	}
 
 #define AD719x_DIFF_CHANNEL(_si, _channel1, _channel2, _address) \
-	__AD719x_CHANNEL(_si, _channel1, _channel2, _address, NULL, \
-		IIO_VOLTAGE, BIT(IIO_CHAN_INFO_SCALE), \
-		ad7192_calibsys_ext_info)
+	__AD719x_CHANNEL(_si, _channel1, _channel2, _address, IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
 
 #define AD719x_CHANNEL(_si, _channel1, _address) \
-	__AD719x_CHANNEL(_si, _channel1, -1, _address, NULL, IIO_VOLTAGE, \
+	__AD719x_CHANNEL(_si, _channel1, -1, _address, IIO_VOLTAGE, \
 		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
 
 #define AD719x_TEMP_CHANNEL(_si, _address) \
-	__AD719x_CHANNEL(_si, 0, -1, _address, NULL, IIO_TEMP, 0, NULL)
+	__AD719x_CHANNEL(_si, 0, -1, _address, IIO_TEMP, 0, NULL)
 
 static const struct iio_chan_spec ad7192_channels[] = {
 	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
-- 
2.34.1

