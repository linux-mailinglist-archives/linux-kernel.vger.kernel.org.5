Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7435D76580E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjG0PxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjG0PxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:53:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D22D42
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:53:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so7063935ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690473182; x=1691077982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+9U4Beprb9pu1uU4Mx83trCWS4lhvPi+RBhwLYwj+g=;
        b=WlWFNqNPyREpMe5W8ha9YLRAYUAVHVCcv9Lk68+jM9LBf9M5bKGSw3Lou098CcfPkB
         mhNx9ShsdckTOhyZT5le4i6VwwwKJol7ks+8eXPXVkc3SdtHXMeObhwrB5YSeboQNYhf
         T/+whbs3KyR6OmlvUUZnuSxVVvxBaOv0hlMwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690473182; x=1691077982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+9U4Beprb9pu1uU4Mx83trCWS4lhvPi+RBhwLYwj+g=;
        b=FU6z4xARTQAd1Q00jIbkvAM1S2kmK7FZjPqJ8lttzB7c1AmKU7pAwkd3zqaaA8D2fF
         gMMPrca2UgqRvXaxHqCDxvMHAKahzUHv2b0meKfZuT9Docgc0nmJeYpuD2MezMDq7iUd
         0Mnw8lF5sb81V+wVKmpr4AuOUc2WUpKlCEYcO8R22YJt0wYYk5zojsTbou1H+AECD5jr
         ERj2D+w+FMraF/KEJxuZ7bAy8tVEmheTx0A2BTapaSva9CaglV+Oivr6HgbGElS+S5pZ
         QR8Ml/JE4tDCIB3Sqmm6m73IP3YfPi9cOp0iHOt+qRyLREClvds01pWsGqyUQzEMiKE/
         T+hw==
X-Gm-Message-State: ABy/qLYU4mF/S8GqYl8JH9a0qcrqvClnew4qw+N9VpGFGEz7LEoWTleN
        yaecGrCNRYQRyXuAgWUbuvcMig==
X-Google-Smtp-Source: APBJJlEbz+18hZOehpOx2Lg90Kn5OMIjVJqD6tiWpkUMlrFwOey76fAAMQaSy+GlhuNZNkNRKASRhA==
X-Received: by 2002:a17:902:e885:b0:1bb:83cd:ad8b with SMTP id w5-20020a170902e88500b001bb83cdad8bmr5009270plg.30.1690473181766;
        Thu, 27 Jul 2023 08:53:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902bc4800b001a6a6169d45sm1802462plz.168.2023.07.27.08.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:52:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: Replace strlcpy with strscpy
Date:   Thu, 27 Jul 2023 08:52:55 -0700
Message-Id: <169047317159.2400214.7882697833368890001.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
References: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Jul 2023 18:12:56 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied, thanks!

[1/1] wifi: mt76: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/535c78cbc0c4

Best regards,
-- 
Kees Cook

