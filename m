Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A068779C652
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjILFoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjILFoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:44:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3726DE73;
        Mon, 11 Sep 2023 22:44:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so43661825ad.0;
        Mon, 11 Sep 2023 22:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694497448; x=1695102248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+e4JiOyEr3j8CmCh1EolPUAnNspfKlO3lylcewQSXhQ=;
        b=R+xwSjB6JUUO3hVOhNqsbG8Yg6YqbtcbNe1gnFM+XmWYMMNnKWaM0lxotc19xGq2Ei
         10Hil7yoeqputVNW7wTm0MWnRhY2p5d2Q6thcvbXjfWWAdbokrWK0tkmOEke7dyzYV9X
         hIDfdwqfG9EvfmzSo79snQdZ1AW89pQln3ItEbBjgv7tjgcT5PAGfXP/uiREon6EFJit
         oHFdHlUfeYZNINmhhqJogBUUPMLKwHyBcttycBSwIjVKV6iu1onJ1RtPHtyD0gzUDpGf
         cGopsDGvBS2998CfT70n/vVm1uy7WEds0mwwOunF6+cdVkE+fG05+O4K4JlFj5WmSFjG
         Y0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694497448; x=1695102248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+e4JiOyEr3j8CmCh1EolPUAnNspfKlO3lylcewQSXhQ=;
        b=fMXcf2yOt/o0gEcuS3QEFdQLZoO1a2T+lbp47C/pN6y1HvpHypl5bwXtoM5qt5Sw4t
         nbGowX6fJz0JyJ8ir6zx8eA0Jay6CMV6LyMgqh8zeQt58wPaq1umnZKcRrslWWbOkeE8
         gAZHebzPng2seiSK1PDJcl+z2pFr3duRIfF7ZbtAJP/ZuU00rr0U70oUdo8a4lF0WvPv
         kE/Z915vuzt/U+0gtJWBK6r912GAp9yGeEhQ+/u6cUgcuEqEp+Ljjsp/2AKZYHogaQ2m
         aXStoNVyQfH25X3wqVnl5jESvuqeY82COkzlSAlBFBgadwvhdrui4Ph/E0nH7qzAXCyR
         /MLQ==
X-Gm-Message-State: AOJu0YxR9mz5xEUeAZA7izUEg4OQwWUFR9tlDptKmiB3pwCs9ELx9jp5
        TFeVf+nUaAdjwRF8omtrrWM=
X-Google-Smtp-Source: AGHT+IEtEluNM6oHil2gixSWlIuYg+iWHgWUv3IUSBf1fM6HqthydsKPgw373vw3KReREdfHm85YNw==
X-Received: by 2002:a17:903:1cf:b0:1c0:d418:87ff with SMTP id e15-20020a17090301cf00b001c0d41887ffmr2045020plh.19.1694497448142;
        Mon, 11 Sep 2023 22:44:08 -0700 (PDT)
Received: from localhost.localdomain (220-133-92-191.hinet-ip.hinet.net. [220.133.92.191])
        by smtp.googlemail.com with ESMTPSA id w2-20020a170902e88200b001b246dcffb7sm7429289plg.300.2023.09.11.22.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 22:44:07 -0700 (PDT)
From:   Zenm Chen <zenmchen@gmail.com>
To:     zenmchen@gmail.com
Cc:     Jes.Sorensen@gmail.com, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        rtl8821cerfe2@gmail.com
Subject: Re: [PATCH] wifi: rtl8xxxu: Add a description about the device ID 0x7392:0xb722
Date:   Tue, 12 Sep 2023 13:44:04 +0800
Message-ID: <20230912054404.10728-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912053614.10644-1-zenmchen@gmail.com>
References: <20230912053614.10644-1-zenmchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link to the driver provided by EDIMAX
https://www.edimax.com/edimax/mw/cufiles/files/download/Driver_Utility/EW-7722UTn_V3/EW-7722UTn_V3_Linux_Driver_1.0.0.6.zip
