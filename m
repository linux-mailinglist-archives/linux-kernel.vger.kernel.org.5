Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4F97F8834
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 04:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKYDma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 22:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYDm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 22:42:27 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE951990
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:42:34 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-54b0310f536so1818143a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700883753; x=1701488553; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=766zOCXW+wn6J8KyQRvcz8WUKKoMiVBE5Gq4HmUOI/Q=;
        b=J5TPZ6KP/jg8L0yiIH74b36E6sXLHSN3WUClHglUrd17ohK0ozJM4FhDbprUcNW52q
         3M+TDFDrYXNMukocVLq4OCcNL95DidiC6AMi1MaGxuOztiqJA3PfiqgoEVZTYNzTs47h
         9Qqst6I2Mc7rlRD/E5YtqiksvlXdmTafLT6gO10pNjUXhtp4Dkqtlqq0v/9O10deWc87
         /6MTlab9v9epazDlVH50J6QgBmiMrloq7KXrfjxv7OWEUXbV7tOU6u8+YMiRdQCzeuMV
         Y8GyVdgSGqSwZ9pyVWpPHqjYYSrgKEWv/FSB3i4b7/z3yHNNxk8XMj/C8Zm2LxdCGNrl
         Szjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700883753; x=1701488553;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=766zOCXW+wn6J8KyQRvcz8WUKKoMiVBE5Gq4HmUOI/Q=;
        b=le775RalI9IC5QC7epbOVX5MdrHPQAXmDPxdSKJyXWSBbN4COFb+leyNPAei6g3G8i
         kbyXH7Wivq3Hl1qRjDtkSqA+99RMEy07POUXxB5L0iBuZXZH/cUfqmwkL0FZz6kBXtxG
         asB1cl4FRhn72FRv6gBOtHLmViNaI06A1UvMQdso126O2h2M1unJWOPnqHu+IC8TM4fZ
         TMRGxAZBG/HerNiLvCmGDX1bPYGtvh4zalx1qZ+zUsGb2Y8PdCC/0lRq/sqtCq9Hjpax
         tYtY6ElOX7GZj3kxPAEnePYzgdGOUpsbhe6c4casQM0h3T251KTuTRTax5IaWkTn4ZiT
         RHFg==
X-Gm-Message-State: AOJu0Yx1m/caaORhUmTCrbTApF1e/7RR9dtwRHK6KCTwAO67XO72NaTA
        4H9p9Cm4xMewVJ7pn8bFEAXI50kN07omSg4LfkovnDtxs9HXV8NG
X-Google-Smtp-Source: AGHT+IEi1TVc2g4KWshMllLMqc/1RaEZ1yEIN/qJ+1oXF7/53do/K/dxOTjPkRj0UkQHGGZF0M6aqV0Gulm3nqyR0sI=
X-Received: by 2002:a50:ed81:0:b0:54b:1bb0:9f22 with SMTP id
 h1-20020a50ed81000000b0054b1bb09f22mr915847edr.6.1700883752879; Fri, 24 Nov
 2023 19:42:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aa7:c593:0:b0:54a:f632:8469 with HTTP; Fri, 24 Nov 2023
 19:42:32 -0800 (PST)
Reply-To: andersonmorris490@gmail.com
From:   Morris Anderson <robertnmasinachi466@gmail.com>
Date:   Sat, 25 Nov 2023 03:42:32 +0000
Message-ID: <CAF0iT+Pi--AvjtAqsdr93vqDQzEhbQCVWOrDbD2oaexOvF6MGA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Do you see my message? I sent you an email but no response.
