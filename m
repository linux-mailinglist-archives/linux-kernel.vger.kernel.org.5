Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB377D67B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbjHOXAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240534AbjHOXA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:00:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D9E1FC7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:00:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id ffacd0b85a97d-3175f17a7baso4941432f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692140422; x=1692745222;
        h=subject:to:from:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cD6dacPByXWt6P0wM+zJeh7tR3aYOCjQ3opTQo8U4gw=;
        b=WI5V1IITOpEfdzh9wEOmJu7xrqu2SqqaDkl4/807eEfUoR2KqC/WKgI3Uh+S8NfDcM
         Z3Y5KNErOBukDaXx/Ojk4PLUqdA1TECM2fDQAdlAKdybVIS0mjBhOTtXSbihKbg+erhK
         x4VlcL7r0G6FQFSqfdOpv3MRSiCdl5icNb0JMQK0wcmFR7L0llak3nG8e3kxSU49o3PP
         AOy+fV4En9qC39p1WKBu4P+KKTxYl5fmGc9czppDhUMGM3YZb2yZrZBeQMfA3YXPbDSg
         Rafr9w2Kmsk4lgu3hVjl+OKAinZRx/4ah/usyjiED26zvT4HQK5xD7xA0tXTpHPTs1+m
         X2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692140422; x=1692745222;
        h=subject:to:from:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cD6dacPByXWt6P0wM+zJeh7tR3aYOCjQ3opTQo8U4gw=;
        b=l+VmmM2eZ1jw5HnainZO4QKHgFKJB2qHQs7BCf4wIEPqze2fWQUZGlL11idN+/5bXC
         In2hTDyqfU5hFzswCXYKoeqM658d+XNXpSBhaOm9gdjowwovfrodti3SgJsxMHch3M35
         e31L8KxsNfiJ/BK0wFpS8PrPmEMc/RwSEwB1hbNT83NyKfXKR8LbCgRotG38SfEK3HB+
         06hlduy9gkU70smB5J1NxFwOpjrnuJTQjUMEEJ6vknactOS1AVw104boRfwNnl+Z7NBT
         +CrxgZ5L5fb9VhPScjsQHGaHbvSNJG6h8fp+U3jZw0NG/QR7doD9ZNUXjQuvTc/bfUoo
         5wiA==
X-Gm-Message-State: AOJu0Yx1qfSYpBtL3VlKpZeaR5HzwhHXT9r5BbujsC4duzxDgG9AnPI/
        vp/amVKuPUu/Win/DvXNWuTZOVWSXMeh3VAB
X-Google-Smtp-Source: AGHT+IHh8k3+x3X7Hh0Jbz3cj5xpZitHJIaX8Maxt/my8Cku+C8l4J2V2lKVTzHSoJns1vLxN0JCVw==
X-Received: by 2002:a05:6000:192:b0:317:54de:9719 with SMTP id p18-20020a056000019200b0031754de9719mr62747wrx.70.1692140422349;
        Tue, 15 Aug 2023 16:00:22 -0700 (PDT)
Received: from [127.0.1.1] ([105.233.88.147])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7cd94000000b0051dfa2e30b2sm7565658edv.9.2023.08.15.16.00.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:00:21 -0700 (PDT)
Message-ID: <64dc0385.a70a0220.afb68.5ebc@mx.google.com>
Date:   Tue, 15 Aug 2023 16:00:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3306924434812285861=="
MIME-Version: 1.0
From:   =?utf-8?b?QkFSUklTVEVSIEQgIFJPQkVSVFNPTiDimpk=?= 
        <donaldwill039@gmail.com>
To:     linux-kernel@vger.kernel.org
X-Priority:  1 (Highest)
X-MSMail-Priority:  High
Subject: =?utf-8?b?TGVnYWwgQXNzaXN0YW5jZQ==?=
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--===============3306924434812285861==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSB3YW50IHlvdSB0byB3cml0ZSBiYWNrLCBJIGhhdmUgYSByZXF1ZXN0IGZvciB5b3UuIGRvbmFs
ZGFibHQxMTFAZ21haWwuY29tCg==

--===============3306924434812285861==--
