Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776CD803F15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjLDUOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjLDUOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:14:18 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F504D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:14:23 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d54370b4bso12496065ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701720863; x=1702325663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8NnWWG7H7nc5jyaZv4mKNHAF15RKAHvf+fSH/2yUjk=;
        b=Mcb6mQerwYqW2OjeWmcG3e2+zg0z4m7JzjKHPfVZajVp2Jaz+6KLr7Zr7D7Pr39bGt
         NBx03i5m2trIOn4tXXlRuTwtnux6LZcPKxrBz/5Rae/m0WN6UWEKkZ75TvG7zO1FuIQR
         q/1zuxxfMAmt0AxvEoRrpeEc+9EJDHJDyp7yxZcCO9Prs+hZagYyZ9OuMbmI1SXSrFhM
         HIKZBCaUHbFTRZt+6QO7Alc0l89FjvIDkx1zmdXa499PVmy+NadrF281rG+RCLAecWpl
         oqFSLcEDabi4u5BxUlv0C3w6ZvtINbBJS0US5s9t832LE1KTrd/SlH6JEn3eyyMndzvr
         POrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720863; x=1702325663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8NnWWG7H7nc5jyaZv4mKNHAF15RKAHvf+fSH/2yUjk=;
        b=YiNOsv2kep17QZcpfi7LKGOuh1sAOTV+WcNVmnF65y1IuVsb/4MniDs2jbk/Z1hRHj
         YkI8SKuCFf9BlZVxEwJdperA3F1D/u3HepePJDmLI/8oHZ0/AXRYrBROs2WQ/BgcIs6X
         19Ad0dA1A6kntFS0yYworb0eUmkxPp2X+5A2YA81AAHA7pHE377Sk4R0AadX78ZQUeZj
         1xy78nIZB5S1qL2R42d6AxBjU9DejPYBG0G477zP/I9Yapz0BUbgHTj9WMg4Q8AWsVaC
         Sw2wp6yrXbuzTiO7pZW2YtgYpd/VGTSaftA9UGXBIL4bW8hoDhnoSvw4fibJ6mB+ePyR
         7E/A==
X-Gm-Message-State: AOJu0YzjWzeDPZwuvwg/CZFeRjJYSAwHQdfJSQSEYrOIHHLfJslTOJ9c
        opLIsvR2ARgTDz8PBOxwMubSKO8ZijDiETr1Uzc=
X-Google-Smtp-Source: AGHT+IHKIFlEYfyVLPyh5Ok1N7q0Jpq4RxGeFjP0PY+F7s1OyioqN3CRbgraLtxNb6cVMvg3dQt0Vg==
X-Received: by 2002:a92:c5c6:0:b0:35d:59a2:bc0 with SMTP id s6-20020a92c5c6000000b0035d59a20bc0mr2482644ilt.86.1701720862923;
        Mon, 04 Dec 2023 12:14:22 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm7894060pgh.14.2023.12.04.12.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:14:22 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org
Cc:     Robert O'Callahan <robert@ocallahan.org>, bpf@vger.kernel.org
Subject: [PATCH 0/2] Combine perf and bpf for fast eval of hw breakpoint conditions
Date:   Mon,  4 Dec 2023 12:14:04 -0800
Message-Id: <20231204201406.341074-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rr, a userspace record and replay debugger[0], replays asynchronous events
such as signals and context switches by essentially[1] setting a breakpoint
at the address where the asynchronous event was delivered during recording
with a condition that the program state matches the state when the event
was delivered.

Currently, rr uses software breakpoints that trap (via ptrace) to the
supervisor, and evaluates the condition from the supervisor. If the
asynchronous event is delivered in a tight loop (thus requiring the
breakpoint condition to be repeatedly evaluated) the overhead can be
immense. A patch to rr that uses hardware breakpoints via perf events with
an attached bpf program to reject breakpoint hits where the condition is
not satisfied reduces rr's replay overhead by 94% on a pathological (but a
real customer-provided, not contrived) rr trace.

The only obstacle to this approach is that while the kernel allows a bpf
program to suppress sample output when a perf event overflows it does not
suppress signalling the perf event fd. This appears to be a simple
oversight in the code. This patch set fixes that oversight and adds a
selftest.

[0] https://rr-project.org/
[1] Various optimizations exist to skip as much as execution as possible
before setting a breakpoint, and to determine a set of program state that
is practical to check and verify.


