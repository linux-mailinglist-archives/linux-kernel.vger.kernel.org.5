Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E47F796F19
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjIGCwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjIGCwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:52:01 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F5E10C8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 19:51:57 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7a4efcdab54so155045241.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 19:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694055117; x=1694659917; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MjC3++OQAFF+3YFPJlzAneqlLWZBVcBrth0UizVW3ZQ=;
        b=ZfONAfpWq2M/SxYxOKenT6+JTTkKYkoEE9eY8biQcKIz/SmziL0pUDWelQrG3dgPNj
         pU24lKuGrsT6X/1g7XSsTVfGfQGVBgcU249vSN99pwVQzGd/ArvLjxe75saDjO4MLX7h
         nOg+i4xsgBc32fLk9q9GtJJhYLk6Ikq2iSO0ssFUC3UQcbixWrAXKfNNvIiimpY6zeQN
         yGYrsuR0wm4IsqQw0SHKPm9BZlJuWEU8Gh3QD5zSW4cq/YkElfsPLZnUV8kjGTUarDXc
         Xzt/zHWve80gPysewVC0u+RxZoAAmcYYlzoisY2y2WlGx4/MFdwC7dX0wkxV0i3eBabq
         MFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694055117; x=1694659917;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MjC3++OQAFF+3YFPJlzAneqlLWZBVcBrth0UizVW3ZQ=;
        b=K5Y+HEmdly/5Gc4N41nJZ9zBCDQBUmCoDJx7u+ziyMuoYulS4ntvZW7g3ZNIftJHqI
         JYNikh3Uga3w4MMlenYrESBrvNcwzo20UEzHB8OAaOYLGyOsomKHJTzhA/You/eYxY7Z
         bkdp6eAY2Riisi+qt7/gAHA2bUeIQrAZ/4ld5g3Pz8QaiDVp5VrR3feGd5AtBC7MBJeg
         Cbzza4Q8aA6ovFl20SokGTMmIn7qC428l9T3/v7EAyKW+dNfzpuTleGX0bA22BofnFtM
         UZ76qJ2s3t2pbThRxqBijTzFnpbABFzCy8bcxynbemf0lJ8ilK8cZw15m8ibfi0gqMkU
         4UPg==
X-Gm-Message-State: AOJu0YwUoCVogg5jwGp8cwVfinPBuw8ikM/tphUMNsxFt7NenKgiC9dA
        C2Ebgtq39aJbzxcEBWhVf1WLTvuh9GIbmod2/pltwUVX
X-Google-Smtp-Source: AGHT+IEVRPmks2S9uuiDSzwwsdGcf16BUCemNT7cyGe4kW/Klo6JeFWhfdlEynB37ib8gSNdYRdgM37hQnC6T0Zqsp4=
X-Received: by 2002:a05:6102:3673:b0:44e:9a71:27a1 with SMTP id
 bg19-20020a056102367300b0044e9a7127a1mr4309474vsb.17.1694055116668; Wed, 06
 Sep 2023 19:51:56 -0700 (PDT)
MIME-Version: 1.0
From:   Raul Piper <raulpblooper@gmail.com>
Date:   Thu, 7 Sep 2023 08:21:44 +0530
Message-ID: <CAEwN+MCorDCS7EhN40Qgja_nY+SFc3G61Zd6yntqAS+w26YO9Q@mail.gmail.com>
Subject: Debugging i2c : i2cdetect cant detect a device on i2c line
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,
I am trying to detect an i2c device A on i2c1 line on  one of the Arm
Cortex A7 platform but not able to see any device on a given address (
0x3d) .

Is there any parameters of i2c which i can change like rise/fall time
, timeout etc in a device tree or kernel source and re test it?
I have tried changing the i2c speed from 100KHz to 400 KHz  but no success.
I have even tried removing the 1.5K pull ups on the i2c lines but no result.

So I wanted to know on what factors i2cdetect may not probe the device
or show it on the hex dump.
What parameters of i2c driver i can tinker and where? Is Platform dts
is the only file i can modify and test with?
Kernel is 5.51 .
There are other 2-3 devices on the same lines which responds to
i2cdetect with correct address but not this device (0x3D) .
Its i2c address is also different from the current devices.

Regards,
R
