Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB32D80780F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379091AbjLFStr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379059AbjLFStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:49:45 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E5510C3;
        Wed,  6 Dec 2023 10:49:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d075392ff6so1023585ad.1;
        Wed, 06 Dec 2023 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701888560; x=1702493360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFz9y6OzWBpIJlSD+//aAkcmJ5zx0LpA7vS+4tAUhI0=;
        b=BAaohl8ix4UKeb4KqfelxL5Fcus6GkwJd0gCjwJZ8ZJWXF6TMxn4pLLlU9CXVN4LZe
         RkwYdwQ0c1jTDFTpcdlsLqjM9fJ6FKNTNrZ2BNmevz80QOIQhtjxJy4vInm4JddqPx6X
         cBs4SRalArNTWSqQw4DcROhWF99jdfwttvZ/4et/qsZKA18I6A77yrHTLteIWtD0Pvi1
         733kcqSiXD7Lc9DMXKv7sv83wZS5Rqy/k27FBixjxRuoVMxaSXdzblKv3JkgqVHVcTTG
         47nX2F99/W05FvSLPb2Jm4fjZoNJ/cEBWYdC0VGQbhW3IKtgXL5uzFXUw85aZm/KWgkI
         8Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888560; x=1702493360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFz9y6OzWBpIJlSD+//aAkcmJ5zx0LpA7vS+4tAUhI0=;
        b=ZdmdvuRPEEccL0r/NsAMrDrMnorZ28w1AEKChbiBognGr3oDsFmH+fQsR6x/CXG6u1
         yg7PO+gmL1XQ7ch/NSEfwbpjkZDhRBVHJpj+ReTwqS6uE4opg/y837j96f1N2lEIrIrh
         rntjS//XLuAM99XTlpTpFZa9J9Tuc9FZ+Yq9riNWgwzjN1sOTknAuAlhGzfTvh/s9SxL
         POYUonJyDV5h9ylKSJBgbrIIou1OdkosLGXOGYnzj4/9VDnvjW95EEorjeQB0AHrHenN
         MBhLoqeuHelJTLoKVs96gKi/v4VQwBAByFd8Q7/OD1B/3mRSSYFNBYhCaZyk3c1VGFT3
         IOJA==
X-Gm-Message-State: AOJu0YyyHXXu3OjuLEG2E+NzDnIEetrgmEu006UpYBLrvNgfGLY4IQoo
        uzl6h6kfmR2u/SGO1R9qQG0=
X-Google-Smtp-Source: AGHT+IGO0kkqhuDJWwAtMavlRxzrlYAC+ZmyXNJC1ygfbswa3mSlt/xVlwLmy9cv3aMfGn3jnL+LmA==
X-Received: by 2002:a17:902:bc84:b0:1d0:79c4:e627 with SMTP id bb4-20020a170902bc8400b001d079c4e627mr1735143plb.31.1701888560347;
        Wed, 06 Dec 2023 10:49:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902db0600b001c88f77a156sm149974plx.153.2023.12.06.10.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:49:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Dec 2023 10:49:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] usb: typec: qcom-pmic: add CONFIG_OF dependency
Message-ID: <d0323841-a3a7-45b7-b702-0a08f9250c55@roeck-us.net>
References: <20231206172037.12072-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206172037.12072-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:20:37AM -0800, Randy Dunlap wrote:
> DRM_AUX_BRIDGE depends on CONFIG_OF, so that is also needed here
> to fix a kconfig warning:
> 
> WARNING: unmet direct dependencies detected for DRM_AUX_HPD_BRIDGE
>   Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && OF [=n]
>   Selected by [y]:
>   - TYPEC_QCOM_PMIC [=y] && USB_SUPPORT [=y] && TYPEC [=y] && TYPEC_TCPM [=y] && (ARCH_QCOM || COMPILE_TEST [=y]) && (DRM [=y] || DRM [=y]=n) && DRM_BRIDGE [=y]
> 

All but impossible for me to determine if this patch or
https://lore.kernel.org/all/20231205-drm_aux_bridge-fixes-v1-2-d242a0ae9df4@kernel.org/
is more appropriate.

Guenter

> Fixes: 7d9f1b72b296 ("usb: typec: qcom-pmic-typec: switch to DRM_AUX_HPD_BRIDGE")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/typec/tcpm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -80,6 +80,7 @@ config TYPEC_QCOM_PMIC
>  	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on DRM || DRM=n
> +	depends on OF
>  	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE
>  	help
>  	  A Type-C port and Power Delivery driver which aggregates two
