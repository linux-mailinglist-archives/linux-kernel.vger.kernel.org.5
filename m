Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954F17696FD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjGaNBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjGaNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:01:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E6E63
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:01:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31771a876b5so3728273f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690808483; x=1691413283;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DDzJV1vwG/o6GKGnxfHEJZ1cqvyrsDF+27hqWZCPcs=;
        b=HNlXr+bTJpd570DCOScEd9dY+NVscjCQ4TZ9qFzuXcBnjryFEUiHuZbKNxi2KqLjAp
         ecv9fhdryF6j/Pe2vkwFnNGN8wZwsQtEqtj3V+IlJNP3uiDjdEydI10UKNHBVEiZQcoY
         qSy1GbGl3jgq/R0n9J2pqbH9lhxVyBt0gIjKs+ssZUYjhr1LjJvunNK4eM0YJLLIruXv
         f1DMFsZZFb7ZmfGhFsZzGElD9gLRTj/z9h229paaQ+eiXZ2ofBRTzgQDYBx7tDko5/+J
         FjotG2lESjTZLosm8YI5NdlR0xUrtY9Uhxcb66SYwqP26VdrjkTCzPlcioQSCeDDn5Yw
         3EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690808483; x=1691413283;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DDzJV1vwG/o6GKGnxfHEJZ1cqvyrsDF+27hqWZCPcs=;
        b=hLZY4sobhVbas1oGsl6aOl5DV8ogs9EUfZJMkqrg2Sve0XCXgtrHzMbDFvCHiDlC/m
         Y12f7yoiJpPkwATTNqt9rXtkRXjBg9x1PX2e3xthJoZd5+8Rd2RQRN00lDiJ0VxttJQA
         bOAJJUXqprJDCq5dSexMXiEBVpBWNIq1d+OcBMAMZPDvE2xePiJSFV39n8Mvr5tquv2V
         qFIrymiDu5zufjAUqswVdeMvII9TKjc1UZMQaE2jhzelykUKfmwsxSD2ZKABf7t/WyNL
         A6pgOj/1L03zETcrdQ8EttJQcCvRP41IE9B1KlGprONj8lFVtxJBStmM6Nf9ot+MPo+X
         czlw==
X-Gm-Message-State: ABy/qLY/Zv0sBs/sriXyWB2z+uKsdxYGbWtK7YKiTEhD1DWhw4P/n49P
        ea2bzL8/t3NhWgxFKB94eM7K0Q==
X-Google-Smtp-Source: APBJJlF2MLeys5HLsk1/ygRiquwn+xckE5m8ikRTKpgfwE+Po7ISnMqt/ZWo7+1AjEMXNPeiJ0RT3Q==
X-Received: by 2002:a5d:4dcb:0:b0:317:58a8:bb4 with SMTP id f11-20020a5d4dcb000000b0031758a80bb4mr6694637wru.40.1690808482528;
        Mon, 31 Jul 2023 06:01:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id j4-20020adfe504000000b003063a92bbf5sm13220390wrm.70.2023.07.31.06.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 06:01:22 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matus Gajdos <matuszpd@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230719102616.2259-1-matuszpd@gmail.com>
References: <20230719102616.2259-1-matuszpd@gmail.com>
Subject: Re: [PATCH 0/2] drm/panel: ilitek-ili9881c: Add TDO
 TL050HDV35-H1311A LCD panel
Message-Id: <169080848175.304500.6200088546909299961.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 15:01:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Jul 2023 12:26:13 +0200, Matus Gajdos wrote:
> The first patch updates the DT documentation and the second is the
> update of the ilitek ili9881c driver.
> 
> Matus Gajdos (2):
>   dt-bindings: ili9881c: Add TDO TL050HDV35 LCD panel
>   drm/panel: ilitek-ili9881c: Add TDO TL050HDV35 LCD panel
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] dt-bindings: ili9881c: Add TDO TL050HDV35 LCD panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9cd437c870b10da4a3276a569f5089af06435f85
[2/2] drm/panel: ilitek-ili9881c: Add TDO TL050HDV35 LCD panel
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=81aedd50697c876e633b68d6188a31aeafcfc535

-- 
Neil

