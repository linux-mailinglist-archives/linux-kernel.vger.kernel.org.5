Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C4B769283
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGaJ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGaJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:57:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC1319AE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe24b794e5so2177975e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690797432; x=1691402232;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvomFymZhU7I2Vx2TPIEyiHuVXkYWyYDGHRfF1f4664=;
        b=MD+DajKB+SVP7k+tJ5gHPLEYuT4K4H07ZJScxsRERnfQ6/YxNIWdSlPl99sQfEAwcE
         o16O7Wsvk8oBuOJUo5JAdV3u8s4uQu+VhoFc5CBgCh8+ox4/P536DKULTzAkrB1i/eHS
         5CwMRtG4F3ji1i0wxyA0HKUD2nFb7UxmyRv0rPtRDcZsEnsiAcAo4MxjzpgLLkuO0VYr
         T8VPiLwl7I0hkRlvFj2ZCe1sJIUYCZVBrfwyLpHHB5QSmPSlwme2vxi7J/ElGYfsNnQW
         yxW7SCeZ1hU8OhyenvrSzTqNXnr7ZmMF+rJe3BZSB0UXWjeD9tg64ZHr5+tE7UVQJeBE
         KpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797432; x=1691402232;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvomFymZhU7I2Vx2TPIEyiHuVXkYWyYDGHRfF1f4664=;
        b=Eoa1Yes0NT3LgmvoH46CbuupmjpPU4fMEN4m7ztU+ttfr9QnfM3LlcDlyuoRVPfTXg
         dwsFulrX45+lEKFTa+PvGTEfZX1OOnHyp5rIpZAnq4/5kkA0AhT7oYbMR7N6D8NO8RBZ
         zXOza+nk7+jgPhZS7ymg6L3LHpr6+z9KXEqcAdwRLjtPB0epZx/b0T/qHzVHgW+NDJAs
         TLJbovbwqSrwuf/yZxpb29Mm9M99ZFqHRE4ThG4sbN0XqAxI78BNUr4289lwu4D2f6bQ
         evmKiPvFGJRL75jXAJ0vfa9wuzaD/9JsIc7lxFhX64KmlUPDD96lhz6E4aGTJnRk+AND
         6L6w==
X-Gm-Message-State: ABy/qLawg1RP0CWJXC1FFcIedEfogM/8ahFKyiTmcHiK3ftIF1x2aQbM
        1RLwTaiaaQ6MAVifdFLHDT+uYw==
X-Google-Smtp-Source: APBJJlFH0ZYPOOpXEhwjoJlo/69P9tZyFc2PgBntVwrgSIqU0HpLBO/1JkqGDiUfL9yVBrJn0onMWQ==
X-Received: by 2002:a5d:60c3:0:b0:317:708e:1c29 with SMTP id x3-20020a5d60c3000000b00317708e1c29mr6516329wrt.40.1690797432299;
        Mon, 31 Jul 2023 02:57:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s7-20020adff807000000b00313e2abfb8dsm12506312wrp.92.2023.07.31.02.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:57:11 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_AA08AAA6C4F34D53ADCE962E188A879B8206@qq.com>
References: <tencent_AA08AAA6C4F34D53ADCE962E188A879B8206@qq.com>
Subject: Re: [PATCH] firmware: meson_sm: fix to avoid potential NULL
 pointer dereference
Message-Id: <169079743120.199115.7501560948693756884.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 11:57:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 15 Jul 2023 22:13:38 +0800, Zhang Shurong wrote:
> of_match_device() may fail and returns a NULL pointer.
> 
> Fix this by checking the return value of of_match_device.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/drivers)

[1/1] firmware: meson_sm: fix to avoid potential NULL pointer dereference
      https://git.kernel.org/amlogic/c/b18226ffd0807446020841d0c56231518d4efba6

These changes has been applied on the intermediate git tree [1].

The v6.6/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

