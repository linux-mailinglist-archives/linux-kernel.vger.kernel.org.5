Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A1B7CEE67
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjJSDZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSDZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:25:45 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9F011F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:25:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ca82f015e4so28359975ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697685943; x=1698290743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHUzNIzJOVcPaGrU00gF++IjKBsdiY8jEN9JO/P5KMw=;
        b=FYmXjFW2iOyvLr9PktujmgX55Ir/JiwpHrAyVS8t/RuMEltAr5GGgxpFzQSu/oAwu5
         2OM3sejoyOcBRxrN0Nn4TEsz/iBwJaE4Bumjev8HuC2cG9v97dygEfvbLKkoKacx6F5u
         V6Mi3Q4ke+GRJiPrUD+yp7nm8SPe1o+NEY9qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697685943; x=1698290743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHUzNIzJOVcPaGrU00gF++IjKBsdiY8jEN9JO/P5KMw=;
        b=K21whiYz8zs1kNJgiwH4/qPIjNHA7jAqPEuqW90q8hlLP9iYVsnlwf6CRcZCXJJXCa
         7OIWioRC/KSktl+8yxnxISn02BDkL9vxAg0wUTiHnNsZZMrXjBxIQvI0qDOA55TDwoJQ
         7uoj3xNNCVeY+V4KRpJQu0HDvqqBojumTtaHGK45B3mtiJ5ZG5R4qwICZxmklBvF+u6D
         mv7++mUG5E/Zhx22K2Sfk0ePbVRs4rpdx+3FF/DDYQzU+UP4J7nITX/yZ1NFm/zAj6kK
         Fkw6pvIMSBPCW3ImYjuVDF5T0EdoewIpqiFEs3WZCGJ2xlFE4+1uIVyQmWntkM2q3wfn
         Kt8Q==
X-Gm-Message-State: AOJu0YwpsxE8Fsd0uq0prA5FxEc0M9eSEA7xD2CBu2vP9ua7qLd3cq3b
        TTta8FruW4PwaCenBGyx2bovKo/f2c1digc0A/U=
X-Google-Smtp-Source: AGHT+IF29KrVEu+UcCAxusXSjkxkDhirwB1hv8T6FJruleVOAqxDINURrXK3y03uADL6MugBT4krDQ==
X-Received: by 2002:a17:902:bd0c:b0:1c6:2ae1:dc28 with SMTP id p12-20020a170902bd0c00b001c62ae1dc28mr1082672pls.36.1697685942788;
        Wed, 18 Oct 2023 20:25:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b001c9d2360b2asm681051pld.22.2023.10.18.20.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 20:25:41 -0700 (PDT)
Date:   Wed, 18 Oct 2023 20:25:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: wl1251: replace deprecated strncpy with strscpy
Message-ID: <202310182025.8A48543E6@keescook>
References: <20231018-strncpy-drivers-net-wireless-ti-wl1251-main-c-v2-1-67b63dfcb1b8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-strncpy-drivers-net-wireless-ti-wl1251-main-c-v2-1-67b63dfcb1b8@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 09:15:23PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Based on other assignments of similar fw_version fields we can see that
> NUL-termination is required but not NUL-padding:
> ethernet/intel/ixgbe/ixgbe_ethtool.c
> 1111:   strscpy(drvinfo->fw_version, adapter->eeprom_id,
> 1112:           sizeof(drvinfo->fw_version));
> 
> ethernet/intel/igc/igc_ethtool.c
> 147:    scnprintf(adapter->fw_version,
> 148:              sizeof(adapter->fw_version),
> 153:    strscpy(drvinfo->fw_version, adapter->fw_version,
> 154:            sizeof(drvinfo->fw_version));
> 
> wireless/broadcom/brcm80211/brcmfmac/core.c
> 569:    strscpy(info->fw_version, drvr->fwver, sizeof(info->fw_version));
> 
> wireless/broadcom/brcm80211/brcmsmac/main.c
> 7867:           snprintf(wlc->wiphy->fw_version,
> 7868:                    sizeof(wlc->wiphy->fw_version), "%u.%u", rev, patch);
> 
> wireless/broadcom/b43legacy/main.c
> 1765:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",
> 
> wireless/broadcom/b43/main.c
> 2730:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",
> 
> wireless/intel/iwlwifi/dvm/main.c
> 1465:   snprintf(priv->hw->wiphy->fw_version,
> 1466:            sizeof(priv->hw->wiphy->fw_version),
> 
> wireless/intel/ipw2x00/ipw2100.c
> 5905:   snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",
> 
> A suitable replacement is `strscpy` due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily
> NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, looks like a clean replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
