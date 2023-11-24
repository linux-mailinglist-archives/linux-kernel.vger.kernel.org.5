Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB537F818B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbjKXS72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKXS71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:59:27 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D22137
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:59:33 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d7f3a4bbc6so1260020a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700852372; x=1701457172; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82KAXx8prioxlVSYKLMBO8IPdtBCdxAO6nSEIEEsI5g=;
        b=Ol8BB/KHbI5IXn9BlP2BWgNInu2T0G1NPhV54O/GUwGmJFDzwgwNHFk7f9n4gQOHT2
         4zwwHM9pxhJ7aQEXtmxonh3Ex8WhhJOFsEZNe+JyLAQShrDR0ZFAMh9UuikcE8/NCcbU
         2T6yaelF4j6E8mtcGlc5BMP0fZ4SJtUsROHiZVPblHmrNazk+4sc1Ll/EGKwr5abiVVZ
         K23OuNfbPaCNsYuN/Da7w8Zzz9jb6FLsTaSlRg1Y1q8aTS9FcYIipxQEn7Y31hd+FLQN
         oIGHIbPU6Df+97WlYX/HQuLAKpn/75IYpnp26ACw1dR+kEHamiy0motx0nvgUdaLU3TQ
         8xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700852372; x=1701457172;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=82KAXx8prioxlVSYKLMBO8IPdtBCdxAO6nSEIEEsI5g=;
        b=fGCtBhwj9ALhtVmJzyAeEoVjL3JoVyqUEIFrSj3hvcX/ZmW7rILEdDd5/L/AFL5UPo
         pD44QOWZ2ZhKi+ZRcZmweUbaylvT5T7el2mumruRAjT8pWcuKDTky6uUiH6YD4nnX6/9
         9Q/mUw1XgXpiAYtJG/vsB1TpYh6TWkY9aA16n7Ja/itl38YekFkRTShcqukRrgipD7ku
         nZ7jyAoe5AJVhTr8sLUjygt4h370rqzD2oZWQBBqkF8mG/TKGNZrFyvZWKBB1B1d8LYz
         jJRDXHoID0X4okmb7AyGWUavfz00kWC5dwbK6/3Fl49sK3G6VD5pZMrQsNkG9Kgwz7JT
         cMDw==
X-Gm-Message-State: AOJu0YwJjY9AsWpzaTs1BmrejCvkCnfB0RZD39vP54mPX0wYqi6nQ0O7
        ymGNAsbd4SpbwHbV/RViPQ8XDkk3WewWbunHZoNBGg==
X-Google-Smtp-Source: AGHT+IHfX9pbgpUea7RKc2eNBDbLbmgIayqHTR8NILG28QoObP0K5P4Yh2KYlnBdB3iffpi/yNYDDQ==
X-Received: by 2002:a9d:6f03:0:b0:6d8:16a:e597 with SMTP id n3-20020a9d6f03000000b006d8016ae597mr4617948otq.23.1700852372505;
        Fri, 24 Nov 2023 10:59:32 -0800 (PST)
Received: from localhost ([2600:1700:19e0:a90:c242:2a26:eb7d:4205])
        by smtp.gmail.com with ESMTPSA id w5-20020a9d6745000000b006d653b68fdesm588384otm.55.2023.11.24.10.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 10:59:32 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 24 Nov 2023 12:59:31 -0600
Message-Id: <CX79UGJ80EBU.34DF47O8X8C7V@cloudflare.com>
To:     "Stanley Chan" <schan@cloudflare.com>, <linux-pm@vger.kernel.org>
Cc:     "kernel-team" <kernel-team@cloudflare.com>,
        "Thomas Renninger" <trenn@suse.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools cpupower bench: Override CFLAGS assignments
From:   "Stanley Chan" <schan@cloudflare.com>
X-Mailer: aerc 0.16.0-81-g91b26ad93f93
References: <20231124185042.315148-1-schan@cloudflare.com>
In-Reply-To: <20231124185042.315148-1-schan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, this is my first patch so I'm still learning.
Meant to add

Fixes: dbc4ca339c8d ("tools cpupower: Override CFLAGS assignments")

---
Stan
