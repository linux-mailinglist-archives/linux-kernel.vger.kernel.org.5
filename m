Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81897C7EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJMHwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjJMHwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:52:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A243D83
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:52:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so1679348f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697183555; x=1697788355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTHX0FRa0mIsovtBPL6JAcK8C3YX/mCkit2iZ+0AIBg=;
        b=TSRSSwC+Y8X4UkwZe0u1l5p560VIJqmYulA3kPTy/U1NZJ5Lbz0oTv2MYtTuJCNiFl
         jEpqGrI336ooXhd2ojCjmWDj34IrcyMAyXhLDCemPkoSzpEzMkoW6MPWY+Oj5SHP4gz8
         eUqF0rB1FbJ21sTZLyGk8r82o92zIvotnkgUvjHDJ8rBoR4QcUJ62DjLjGHV34TtDlPQ
         YLVpRZ21TUQ9Z//nxVdcbMRNDWZR/D/a9LCqtvmMiQHt3O1ILlYXN4epvxQisVmxRCmt
         EgVEYjvpnvhtZbmyCoQm9BgyE9suXb9ohiuEEaQ0DCix/cS3ZHhWVlTk6GQY83mU92P6
         Y58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183555; x=1697788355;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTHX0FRa0mIsovtBPL6JAcK8C3YX/mCkit2iZ+0AIBg=;
        b=nm9VhdoFRI8erGkxtjP0eVfoDSp/8aY5YytXrskqTrbKZ+OFQymmQE4fRv35IhZSFr
         6vBFNVFjuay4rGveJ4u+qQbgW1re65dePTpFgLMsn8n9h1Mzw/2ABtS5312cwQwCZ+zf
         DqOz7I9DwVP7WXhySCRt+RDRJG0WGURGsFhwAufZQvJPGmKSEBfngxhNpsb1DlB7GnyY
         O8YQRIvw7ApDzZ0waqOWcR8H+Yg0YG9DV4XEm7vXoh84IKf6A7d9Pt9FvWjpHLo81OF7
         2+yNlXKYfWZDuUNPVUXepMhKFj+J3zH+lCpgJGwvNO7s59sf922AlFA3ZTD5S17g5rdo
         MRUQ==
X-Gm-Message-State: AOJu0Yw3sz7HM0mqaAEhP0UIFkuTUQ4W1Lum37JPWCf4405QpkTaMgbI
        sbzT4BgPsCJaAIEU1p20TNmpzAzRt0wAm9HXiI4g2d34
X-Google-Smtp-Source: AGHT+IGiyB9W+thMrr/86BjFDhdIxFVIHXZpdrHzrUUMm74SeNpy7U029sugpKwEw5/NWnsIWPXEtA==
X-Received: by 2002:a5d:504e:0:b0:321:4c7e:45e3 with SMTP id h14-20020a5d504e000000b003214c7e45e3mr22735710wrt.11.1697183554975;
        Fri, 13 Oct 2023 00:52:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d538c000000b0032769103ae9sm20171592wrv.69.2023.10.13.00.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:52:34 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20231012103600.3381340-1-m.szyprowski@samsung.com>
References: <CGME20231012103636eucas1p21eec119a94d1f2adfe8d1c2602bd4012@eucas1p2.samsung.com>
 <20231012103600.3381340-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH] arm64: defconfig: add various drivers for Amlogic
 based boards
Message-Id: <169718355421.802317.14102706469164690952.b4-ty@linaro.org>
Date:   Fri, 13 Oct 2023 09:52:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Oct 2023 12:36:00 +0200, Marek Szyprowski wrote:
> Enable drivers for the hardware blocks present on the Amlogic Meson SoC
> based boards: Khadas VIM3 and Hardkernel Odroid N2 to increase testing
> coverage.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/defconfig)

[1/1] arm64: defconfig: add various drivers for Amlogic based boards
      https://git.kernel.org/amlogic/c/a23bfeda86239d29f18a149a7e658cc3d4e5ef8a

These changes has been applied on the intermediate git tree [1].

The v6.7/defconfig branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

