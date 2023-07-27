Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C176580F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjG0PxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjG0PxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:53:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46B3BC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:53:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8b2b60731so6394815ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690473181; x=1691077981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKtgqp1u2xh8Lnzw63ydJQR4zWouaxM7EYEQJ/Gqtx8=;
        b=Ys0TU5LF97kp5pUBJu1vJUOHVdfiuMEiEWvnozXPP8CbclNLX8ADuMxnV7t5C4K1yK
         D8Joi0BZrq76t8TP/CbbK4zREwfVSJBylrOQgzGv+ocsE7bBRfar+iy02IEupLjZ6qDn
         Ui7F4LgDa5xzdF161819L7flP4kCFpn5B53KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473181; x=1691077981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKtgqp1u2xh8Lnzw63ydJQR4zWouaxM7EYEQJ/Gqtx8=;
        b=KNvgjrDF1zIQ/xOcPkO2gFs85oypxgIlLPCxU/g4ILijNJ4u4NOXxuoLn5JkHFdwdy
         FmJGyGv1iAojj6i1RXbXYWJRX/1nyhl9ZrnrjcjY0nqfuhBXqBUXHsmUCZFFMXjuNdSN
         AbO0gOFcgS9kmOg/2tJ3e/EbWzpswqrQkzuUnpGmfv2CFL3U1ezXelW9Q3DRROsiLChR
         VWYlpCC5TSyUuW+5l8ZlFMTV/xM5B22xfe9mS8hr46rFbFW5sCDX/vGZ5Cm+hNwbUDWv
         SIKsgbzPswnC2kVyrL5FSxDCHA5ntGEYW74HtKn7WO1h2A7wLnbVA11n2PeyoGp6saow
         pDIQ==
X-Gm-Message-State: ABy/qLbVxqoMbVW9Pskcfn00vyFQmXGVsqt8Pg4dRbdEgAsxQw1BYqek
        LHKT6u1s969HXa/wUu9SV5cY3w==
X-Google-Smtp-Source: APBJJlHQu3CTwASavzZKIq52nhmrqYf20V0hkWuKka0SpYId/y4TdpNecTBvy3SyWaDDMBHHR3OOLQ==
X-Received: by 2002:a17:902:f545:b0:1bb:a367:a70 with SMTP id h5-20020a170902f54500b001bba3670a70mr4328734plf.17.1690473181183;
        Thu, 27 Jul 2023 08:53:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001b8959fb293sm1820901pld.125.2023.07.27.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Haowen Bai <baihaowen@meizu.com>
Subject: Re: [PATCH] um: Remove strlcpy declaration
Date:   Thu, 27 Jul 2023 08:52:54 -0700
Message-Id: <169047317154.2400214.3532264877542326061.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703160641.1790935-1-azeemshaikh38@gmail.com>
References: <20230703160641.1790935-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Jul 2023 16:06:41 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied, thanks!

[1/1] um: Remove strlcpy declaration
      https://git.kernel.org/kees/c/61ce78f29a69

Best regards,
-- 
Kees Cook

