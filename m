Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B467BAEEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjJEWmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJEWmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:42:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B079DB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:42:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-69af8a42066so628782b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696545730; x=1697150530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz7lk7ASZyzYk8GD9c9UI0XKLO+hFISo62X4fmfBjLs=;
        b=MiifTB1OW2EQSGbn8uFBfa+BeiveCEke0uMAPHIm4aaUAjKKIcpMghHK5G2n9Rae98
         Kx/ynOtpHDU43KdyJuoA/A3Dvde3JMe/hL1NMVOFnEIAr38uZOoH41jT14cOF4IBgZo2
         mXyn0wYyaruDOfkyOGFGnL8AyLF7fOSw0FzN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545730; x=1697150530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz7lk7ASZyzYk8GD9c9UI0XKLO+hFISo62X4fmfBjLs=;
        b=Ne+33Wnmu08mEGdoH6RdWqqciJvgis/giaeZuzHX8hcHnM6BUaSnPVxHHqqn1lf9SG
         +GYqexe/I8N+rW4ZxMrsUP6yY11rbHBxo/nwxeX8D/MGE8uZ0KKqG7Gdkk+AA2JsDA5Y
         BXtcdWULRnoNHQImQcQ6FP3GZ9Sw481xyXID808N3DKBGAIpO0wJOeOL5HhJSt6RdFVV
         s47hPGgKvwQLnUXP/gNtEiKZYVl6qswvSfC8fZBvd5uMluI+t/H7xMQ8Et6QD2hjGlsi
         dPNUidCqy67OJ73jtuEN+hAqhjAe15XjnyqukXPUZbR8tmAFdWwBqojEmLILo8MK4sw8
         Kd6Q==
X-Gm-Message-State: AOJu0YxQCYb+/Pco1Bxp3DVchm3/7skQi9qQ6XEGRaU0wr4M8x440j8R
        Aq2bnF3MdDV5SP8KQZAeagAxag==
X-Google-Smtp-Source: AGHT+IEgQZTEs2BdqQ0GOWFAgas7OCDMFaKUSGv2iXW7ue7c1U+XG351TvMd1vGVOqGjStDFLsY+kA==
X-Received: by 2002:a05:6a21:819f:b0:15d:8409:8804 with SMTP id pd31-20020a056a21819f00b0015d84098804mr5926846pzb.57.1696545729755;
        Thu, 05 Oct 2023 15:42:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b001c5de06f13bsm2284923plx.226.2023.10.05.15.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 15:42:09 -0700 (PDT)
Date:   Thu, 5 Oct 2023 15:42:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for
 lan9303_get_strings()
Message-ID: <202310051539.B2D34DB@keescook>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 06:56:50PM +0000, Justin Stitt wrote:
> This pattern of strncpy with some pointer arithmetic setting fixed-sized
> intervals with string literal data is a bit weird so let's use
> ethtool_sprintf() as this has more obvious behavior and is less-error
> prone.
> 
> Nicely, we also get to drop a usage of the now deprecated strncpy() [1].
> 
> One might consider this pattern:
> |       ethtool_sprintf(&buf, lan9303_mib[u].name);
> ... but this triggers a -Wformat-security warning.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Ah, cool ethtool_sprintf() works. Maybe some day we can fix the whole
API to actually have bounds, but yes, this is fine.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
