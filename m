Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B04975CBB2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjGUP2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjGUP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:28:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E51C6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:28:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e57874bfdso2820158a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689953282; x=1690558082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjQynSAUQFJ+iQVSHZn81KBk8KudT4uWcOPMPn9BnAo=;
        b=Fru/HYg81exUfFNYakRh1p7PJqFAlQB17OVPbOLY75bWWrLI1vEFTuHYOvbzrjjkrb
         xz8A8cDdJn5YcSRAurcFhKyInWFPKGVOXqJoPZ+GNgIHcFoJdfBqO7XXi02ulklmM9DT
         +KnmT7UygzrNwgatqZD4bYzVD/SoyQuY6OKFxMnGcTce5WvOdrM8plYNWcuVeqgVxDKp
         dhRmIysVaN8JurvJ7+yoCGdXokjLi0PSe+wE3geekL4oecKxS1N+2GwuEYzsJWdDbtoo
         58YpJ051a6UttjIZUjMLzL5+/mqFnQSP1yQTrMYnrekrZltGIMTPy2LWhyCer1boQe/r
         GgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689953282; x=1690558082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjQynSAUQFJ+iQVSHZn81KBk8KudT4uWcOPMPn9BnAo=;
        b=ZzYV0ceeBWgE1+o5cjRi5S112xVF0s6gwFeEzBRXs9AKtRNZWQ0CNGKYpnSqr4AHgo
         8K/zdb1v5JaCDIDboz/tHJdMuPsSEaBZiRdLw38P7y9UOxLhDa3MwhyIuUBefXM9oewR
         Xc9cAHgp0I9JQdsns4FCOUocIp3EFDXMnyYEMIo2GSXhyRZXGWwP9nupOeIaNe4Id4Mm
         xNIZx1JjYXu5Fyh67V8T/wbNdOFJPx6M2DxfYxFMWkqazTWFYqahJXEBaq68UCVTcGtL
         GbSUEIjZMHmmuhIfZwtxSqUHAlci4OXJRwTm/WpdYK3JeZI4TJt6lck1Gb9rZk9mZiG2
         5LYw==
X-Gm-Message-State: ABy/qLb1vgrz2NnKjDOl5oz0aGFTxFEqsU27kXQgSxZmagR5w9LJ1s4p
        TR68FqXwWpqFL5nUS8RiTmg=
X-Google-Smtp-Source: APBJJlG/gk9DPFCa7ss1awkGl2ngITXAEo8YbTZjnoU+2iuYN1nKrXwoKPRdvI6Ex2zlweVIU+pU0Q==
X-Received: by 2002:a17:906:8478:b0:994:1fee:3066 with SMTP id hx24-20020a170906847800b009941fee3066mr2068645ejc.15.1689953282448;
        Fri, 21 Jul 2023 08:28:02 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090648cc00b00992b7ff3993sm2289595ejt.126.2023.07.21.08.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 08:28:02 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/7] bus: sunxi-rsb: Convert to devm_platform_ioremap_resource()
Date:   Fri, 21 Jul 2023 17:28:00 +0200
Message-ID: <168995326156.3656340.11878246818706234631.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706072042.31296-1-frank.li@vivo.com>
References: <20230706072042.31296-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>


On Thu, 06 Jul 2023 15:20:36 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> 

Applied, thanks!

[5/7] bus: tegra-gmi: Convert to devm_platform_ioremap_resource()
      commit: df823d210395341c58e8d346dfc37d6e67e9f2c6

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
