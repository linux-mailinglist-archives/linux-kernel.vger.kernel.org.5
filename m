Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15027C85BE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjJMMZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjJMMZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:25:37 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC07DDE;
        Fri, 13 Oct 2023 05:25:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405361bba99so20403425e9.2;
        Fri, 13 Oct 2023 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697199915; x=1697804715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CKZgUBJGWMajbilOFgGQRLxqanUY/9c6S2xkAT6//E=;
        b=aLqEwbMBI2G7QB9UdrT0dQSPZwETTQRae0YKIbIFg6Pd1qqInfbGPJJpay0ejX9Rz9
         GiOGxpn8s47HtJpGmoj210ggnzrDUxzdRtRMS/Xe5bSyyXJWnDVyqyAcsbCwkCdGFs0c
         Qd9N9uQFuuV23D50wCKSVzFM9MPSeg/zKJp2DMMTn7qa6De+agfVpNdk8NT7xWiqmYwU
         4zXUh0VZlg/HkUjkRkPMWeBPTYX69qeSq37Khc6ZhpHVW6/vxJjLgwxH30J46rx9+xde
         oeSYK43zAIFYguymNgkXxCls2Py8jEFp2PPPZFJmJhsN1k7p+FfmIgssqRfhIqKPsvIv
         IlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199915; x=1697804715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CKZgUBJGWMajbilOFgGQRLxqanUY/9c6S2xkAT6//E=;
        b=Hgcj6mtzXRqfiRco7zoB41QTu/gKAXKekv2EmhZslapxw/roJuGPBhyoQDJLAXMJsx
         coSu3BcQza2fIDxJM2tBWKJMp0nATVpAe1rW8RB3RDrke3qoAmAQS1StWJQvepjBKvje
         6uUdwX3r4PaveAm2fds3GPb5SeMsK6+4pU7Gnf8wQNRNOxhWKiM30Ijl2jgggpdbaZHS
         3oWKkz4Lnrmxh7nWqb4H+7g0SWDGzpgbZ3tjUuwxL0P0GxP7VkX0l6nN71KFB19x6EQc
         aKG6kZc1qvY748o0psQrbWgmcEmPZCt8mnec+Scc7Yd2gbLicMge9PIopA8xeBNxAzTr
         upbA==
X-Gm-Message-State: AOJu0Yy+WUZ97Tvfm4EwgWNwGFwP9OTlAtJJ4AI3Zrld9/mXzDhBVFzO
        YsxULrLU3O6foRHuHQuJ6Sw=
X-Google-Smtp-Source: AGHT+IFW0BAz1KE2TBSE/stD6qY/zQ48xnUqepGAqzzL7WODejJrsoSYGevMUD6mGnM2HNqNVX1GcA==
X-Received: by 2002:a05:600c:2284:b0:401:b493:f7c1 with SMTP id 4-20020a05600c228400b00401b493f7c1mr25124421wmf.35.1697199914681;
        Fri, 13 Oct 2023 05:25:14 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c021400b003fe2b081661sm2410086wmi.30.2023.10.13.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:25:14 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     jonathanh@nvidia.com, krzysztof.kozlowski@linaro.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumit Gupta <sumitg@nvidia.com>
Cc:     bbasu@nvidia.com
Subject: Re: (subset) [Patch v2 0/2] Fix hang due to CPU BW request as BPMP suspended
Date:   Fri, 13 Oct 2023 14:25:12 +0200
Message-ID: <169719989291.3880029.32092032379655248.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009100557.18224-1-sumitg@nvidia.com>
References: <20231009100557.18224-1-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>


On Mon, 09 Oct 2023 15:35:55 +0530, Sumit Gupta wrote:
> This patch set fixes hang during system resume which started coming
> after adding Memory Interconnect and OPP support to the Tegra194 CPUFREQ
> in below change:
>  f41e1442ac5b ("cpufreq: tegra194: add OPP support and set bandwidth").
> 
> Tegra194 CPUFREQ driver uses 'CPUFREQ_NEED_INITIAL_FREQ_CHECK' flag
> which causes a CPU frequency set request from the 'cpuhp_cpufreq_online'
> hotplug notifier during resume. The CPU frequency set call also triggers
> a DRAM bandwidth set request but the BPMP driver hasn't resumed yet
> which results in hang during resume.
> 
> [...]

Applied, thanks!

[2/2] memory: tegra: set BPMP msg flags to reset IPC channels
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
