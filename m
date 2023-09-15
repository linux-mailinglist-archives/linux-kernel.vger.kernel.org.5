Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6457A1B47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjIOJyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjIOJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:53:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49812728;
        Fri, 15 Sep 2023 02:52:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5007616b756so3103988e87.3;
        Fri, 15 Sep 2023 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771554; x=1695376354; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbdBrDek2QYvPDQBlPiROzdzjCQXwx5rfR5eDq4xQRM=;
        b=GTq+wHzM8GoJPq09bkHdf9FPE44FuMYZsCssG4DMEh1GhE3hooJLOU/hNzzKPZyWgQ
         NqobS7A2rQtGFc8JevApvQhrbiC0i4t31H8KZo+Rr+JIddBTTi7DxvM+Q6SEcQsSzJ7B
         DEMyVYPKrwwtBIxYqQwOFBt+28WIuzdtrpdGVKTN/li2jEk3t9pPCFa/KJ9ybmX1GLWM
         jbL4DpKhMzThjSdLpJCSBZwXrvZk0I+O6vrky1nBAXVWaZUjs39hmMZZNW+z1FxC1ogk
         yoVWQbJDkOdUwGdisjy/oN+oTGNIiW3FXKx9pzIl2KzWvFy9MkiRRK8vrBWL/zxMfk4J
         QcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771554; x=1695376354;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gbdBrDek2QYvPDQBlPiROzdzjCQXwx5rfR5eDq4xQRM=;
        b=Z4i6IlETpPoND4sLPaNk2NCTuQ/O8bfSW2QDm1McVdPQMuLnjFjIfu3JkF8smnQMXE
         PF5wlQGiuFHhhDPs3U4x1y1UZHoUDru3qT5GXE8X6/FbNaNMDfWUWF2EQKY1UQLw9CU4
         PFw8WfpPp5s00SjbCBwP4G6Yktb9T/1pFpv73nWgSLsiy3n2OuwgToEtT5rxkZykSSOF
         cMYcbHmn/VAczWwrICnvIqR3j2Dl9a9U1SUMUR6ay37Ziikwm9e1zqjSJYjDmfUIEOew
         22vsaWrQZ4RgU7jgHb3hIugXZhAyjG6RLFlnw7rJC15MiojRddJH5+E1r+Tu3aS1WRYD
         tNpg==
X-Gm-Message-State: AOJu0YxNnr2AzQVljt+u2hcaUwJ4Lrv4E0MUdGAXCpzVneQVOFJo6Poz
        u3mwugpRfCdGjiCsGgZ/Zto=
X-Google-Smtp-Source: AGHT+IFLeDW3AX96+g3WQOiD1VYBFJpFmLIsq9GViNo9PKi5X/7tXQGK1PkeGfIY+AqBzlcc0tTtZQ==
X-Received: by 2002:ac2:5390:0:b0:4ff:834b:e01b with SMTP id g16-20020ac25390000000b004ff834be01bmr899268lfh.19.1694771553823;
        Fri, 15 Sep 2023 02:52:33 -0700 (PDT)
Received: from localhost ([89.40.182.212])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c235200b003fe61c33df5sm7089180wmq.3.2023.09.15.02.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 02:52:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Sep 2023 11:52:30 +0200
Message-Id: <CVJEDI913FDZ.1LVK59USWA4O8@vincent-arch>
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Manmohan Shukla" <manmshuk@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: error: Markdown style nit
References: <20230906204857.85619-1-manmshuk@gmail.com>
In-Reply-To: <20230906204857.85619-1-manmshuk@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes a trivial markdown style nit in the `SAFETY` comment.
>
> Signed-off-by: Manmohan Shukla <manmshuk@gmail.com>

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
