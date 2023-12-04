Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BAD804164
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjLDWOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDWOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:14:47 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAE3FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:14:54 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c69ecda229so618002a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701728094; x=1702332894; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o7NAHp/MgTm9SnzSWNXfFwt/FdMVpyaPo3ZgisLjz/I=;
        b=WRb+46fTXqd5sRdJUueaTb020qZkOMghj3gRWtOIcX5OORMR1f759TGn9hNrPjV1fa
         jOF6uUinAkleHsKcOr7UPmTJsnAat8VVbMua8PRWX9RjEaOIHU3OEvjP2NQBBdR/NKDy
         Y3tF22aS/ES5WNGUohCppwFUSxUXyz7R2FD2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728094; x=1702332894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7NAHp/MgTm9SnzSWNXfFwt/FdMVpyaPo3ZgisLjz/I=;
        b=tXRgjU5kcuKaibQS+7MZAC/5wos/5AcQecs6rmOsco/9jdu1ArdaHlJSZoSyA6lbSr
         M+dJ6miG3dy1iuwh3eSL0yJ+25wXB+v2/+HRPGMtAH1ucBfAzXJg9FNH9sLw5pyhmuRn
         21U3Ca/V4iPOVNM4aVGBB2T4VuNFqjHFZ86IO1JUobmLn5TFaz5Vtp8tmDgkquhqO2Zd
         drBRJEBN/2vp9ZWRY9It//0WW1oE8oMciOWPh5KNtDMHT+Ss1Zcyn5quyrvbbMq1C676
         uKnST2op+kmy3NbO8e3s61OQt+LFNpJ6Z+mf1GrxyTD4W4OAVNz5AfrAaM2fTsl4NpC8
         kR2g==
X-Gm-Message-State: AOJu0YzAETYe2VEtc4QPC9esToGLXApcs13jdDlrbJEu4JfOuvP/Q2hG
        o1ANUzuI7xzVLtlhrinmHDcXwQ==
X-Google-Smtp-Source: AGHT+IEkvdihAqbNhlhSGxMupjG8dnFLuD0j5JoZv99BA2GbgcxonJ/mSfL3Y7TTC0ZNcKA4UdPv0g==
X-Received: by 2002:a05:6a21:1cb0:b0:18f:97c:9276 with SMTP id sf48-20020a056a211cb000b0018f097c9276mr1608801pzb.91.1701728093815;
        Mon, 04 Dec 2023 14:14:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a8d8500b002867adefbd4sm4108188pjo.48.2023.12.04.14.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:14:52 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:14:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 08/18] stackleak: don't modify ctl_table argument
Message-ID: <202312041414.441475830B@keescook>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-8-7a5060b11447@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204-const-sysctl-v2-8-7a5060b11447@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 08:52:21AM +0100, Thomas Weiﬂschuh wrote:
> In a future commit the proc_handlers will change to
> "const struct ctl_table".
> As a preparation for that adapt the logic to work with a temporary
> variable, similar to how it is done in other parts of the kernel.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Looks good -- thanks for catching the table-modification cases.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
