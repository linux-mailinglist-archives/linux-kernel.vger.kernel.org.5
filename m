Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A8780FA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjLLWvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjLLWvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:51:51 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F5098
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:51:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so59030265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702421515; x=1703026315; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=02lBGInGGp94YCTEvn0xv4pBYmlsGIQQB/nHvauVPIs=;
        b=TPMmcTENgPsm98nzN/l8WAwr4iR+Vo0JEC6LnnuilcxutGNPhqXgQMQHcucU7OMUNW
         uMbPZXk3RDGm5Fxoq2Nozf/xdh1+WyMUYMQAoy3glOIAXqRyYAnXbCSth97ShDfPtZNW
         gZjavgCCGLiSTFRfU9WtZkKIoRSA4WXfmnaZjYvPcFaLSp1ILgyX/7ZW+jsT33bFG/J3
         b1I75jveRd9jRP4NKlBu26sO3IpgqRZrawCGzhILHuQw9PKmLnp6coNLW/B6+a0weoPy
         Ee4HTO/5UACVS1Av4NerejEn8JoCZiWsr9cIpJmiqnrdyGU5e0Enofjuqd5Kxiz9wqpH
         vudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702421515; x=1703026315;
        h=mime-version:user-agent:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02lBGInGGp94YCTEvn0xv4pBYmlsGIQQB/nHvauVPIs=;
        b=ZgYYRPxqz9TcFZsjnU4WFTmuXyhrk2tM5x4F5/CHi1YbhDID1Iz/rGKccoXqGtZv6R
         vZK1IYw1H+Lr9xs7cIPMm5iML/kEFyCIO+GhksQPVKiMMQCsYB/XtAUApBzrAKgDbbhA
         x030NyP8I0Pno/2ks1Hw8+mrs0jsUR6x1iFU96NzD6ou78l7voCy1Vj+iM9HIB5Co6u4
         GURflpsUr8TO4geq6D1OdCngnxPeVtuBSviOdWdL0X6bUPSuf6penVM4/BNYh7L2SJa2
         0NeEZcKJqkD768eLZuXoB4mvOFOVZfLybHoPbvxpdHGfDaoeMY8BA5Lc82bBJxUwjTp6
         4Bag==
X-Gm-Message-State: AOJu0YwtqOlC1cY14rp86lhNgrfU42qz85oYlzxAjyj94PheQDnM7nos
        MoyXGBrLoFkCd9NnoDXhctwwdgec2s5DQEvSIjw=
X-Google-Smtp-Source: AGHT+IFD4+fcsNNPm5nFkYa7YHYvByvHGqyhM/gW36cia+2sqrPmOz3WgEhYNCoxImz0F9Qpv2+A5Q==
X-Received: by 2002:a05:600c:3b8b:b0:40b:4fa4:d59a with SMTP id n11-20020a05600c3b8b00b0040b4fa4d59amr3448040wms.10.1702421514954;
        Tue, 12 Dec 2023 14:51:54 -0800 (PST)
Received: from localhost ([193.86.92.180])
        by smtp.gmail.com with ESMTPSA id le9-20020a170907170900b00a1e2aa3d090sm6761184ejc.206.2023.12.12.14.51.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Dec 2023 14:51:54 -0800 (PST)
From:   Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date:   Tue, 12 Dec 2023 23:51:55 +0100 (CET)
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2312122348040.24250@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2023121201

to get HID subsystem fixes.

=====
- Lenovo ThinkPad TrackPoint Keyboard II firmware-specific regression fix 
  (Mikhail Khvainitski)
- device-specific fixes (various authors)
=====

Thanks.

----------------------------------------------------------------
Jiri Kosina (1):
      mailmap: add address mapping for Jiri Kosina

Mario Limonciello (1):
      HID: i2c-hid: Add IDEA5002 to i2c_hid_acpi_blacklist[]

Mikhail Khvainitski (1):
      HID: lenovo: Restrict detection of patched firmware only to USB cptkbd

Sebastian Parschauer (1):
      HID: Add quirk for Labtec/ODDOR/aikeec handbrake

Yan Jun (1):
      HID: apple: Add "hfd.cn" and "WKB603" to the list of non-apple keyboards

 .mailmap                           | 3 +++
 drivers/hid/hid-apple.c            | 2 ++
 drivers/hid/hid-ids.h              | 1 +
 drivers/hid/hid-lenovo.c           | 3 ++-
 drivers/hid/hid-quirks.c           | 1 +
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 5 +++++
 6 files changed, 14 insertions(+), 1 deletion(-)

-- 
Jiri Kosina
SUSE Labs

