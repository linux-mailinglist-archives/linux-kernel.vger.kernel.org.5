Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3EC758CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjGSFGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGSFGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:06:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1531BF3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:06:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so6136721f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689743180; x=1690347980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CacrP58zq0+usnB3XTcjIP1l3ZG/LBc8uVYTg+/ZhHE=;
        b=IxgI5XlSaeBgu1PFj1XffbjNHH6gjpVLhln6sVG86XmAyxPHceVr3CdYFztsBc0PDL
         7ECQ9Az7R2Gws0HlzFItYT75w2IeEdyitVN1iGtpUX9Ig9fxqCOAS/raQxJWojk4OKkl
         CqK2JFwGSN2uQI1eIsHfdmWaRiw78EAuZY6wMBOqmGolWQtJN3hChkT/lcYFCe8momu5
         IWzwiZQsD9ZuJIa0WqGoRQ2C8A1lVeLQylBEkSqwTRo6jKkjzDdnCL+t2kRhe2nfxmIZ
         aF7Utea4wMVIfyxfK4bFNbOtY1fBMMSnzIWg8/8jsdIFKHOMEem8MGDzhG0fn+Sus03y
         LJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689743180; x=1690347980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CacrP58zq0+usnB3XTcjIP1l3ZG/LBc8uVYTg+/ZhHE=;
        b=fnowdCsJQpbzl0744hSUIxFYYsv1IvuEYkNN2Z5DNww0fM6QC/W/o6Q2MyA+0aMJ8V
         vOmEDmCXO9b6Fmr/hjQD1Xo6Wd2s5Wlo3Kzx+rNkVBnaWwLDlmwz0nd6SnWfgiVjmUjj
         o1LCMWqoEW96uI8AXnO6rdmSaewGcAXW7Ua6Tmumzv2P8cj0E4Aj+7GYPfE+5bAulBSt
         fFb+YL3aOk168hMbuDJVaxHU+yzry0mYzNxKTTLmUQi6PWOk3sbs6tDDIDeN0mNERLup
         UQU6y7QfwYRSftu+VIb5oFalzrLwGM3pjmuakHWs3k1X2ciWGFTSRS6CvBady1jm0m/R
         tLJQ==
X-Gm-Message-State: ABy/qLYtmil7qriFpE3IuoRz+D6Vlhfr5WE0gEtZvxbJ/DZywR4Vmd2W
        62t9sy2WK1R4YbEvUjdFuacrA3wxYPNxRtyERRgFBacK2v4=
X-Google-Smtp-Source: APBJJlHyXo//D6l20y7ps/JakIZR/7tky4G6kIPHac2NdZy1caEM8dtk5Tce7IxyeVSp88egGmVCE8cxi+FRPay/Dbs=
X-Received: by 2002:adf:fd89:0:b0:314:4437:beab with SMTP id
 d9-20020adffd89000000b003144437beabmr11779504wrr.55.1689743180159; Tue, 18
 Jul 2023 22:06:20 -0700 (PDT)
MIME-Version: 1.0
Sender: getarunks@gmail.com
X-Google-Sender-Delegation: getarunks@gmail.com
From:   Arun KS <arunks.linux@gmail.com>
Date:   Wed, 19 Jul 2023 10:36:08 +0530
X-Google-Sender-Auth: yKFI9T3yjp-s4_w89q2fM5l5iV4
Message-ID: <CAKZGPAOYPp3ANWfBWxcsT3TJdPt8jH-f2ZJzpin=UZ=-b_-QFg@mail.gmail.com>
Subject: Question on sched_clock
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, Arun KS <getarunks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel=E2=80=99s printk uses local_clock() for timestamps and it is mapped =
to
sched_clock(). Two problems/requirements I see,

One, Kernel=E2=80=99s printk timestamps start from 0, I want to change this=
 to
match with actual time since boot.
Two, sched_clock() doesn=E2=80=99t account for time spend in low power
state(suspend to ram)

Could workout patches to modify these behaviours and found working in
my system. But need to hear expert opinion on why this is not done in
the upstream.

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 68d6c1190ac7..b63b2ded5727 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -190,7 +190,10 @@ sched_clock_register(u64 (*read)(void), int bits,
unsigned long rate)
        /* Update epoch for new counter and update 'epoch_ns' from old coun=
ter*/
        new_epoch =3D read();
        cyc =3D cd.actual_read_sched_clock();
-       ns =3D rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) &
rd.sched_clock_mask, rd.mult, rd.shift);
+       if (!cyc)
+               ns =3D cyc_to_ns(new_epoch, new_mult, new_shift)
+       else
+               ns =3D rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) &
rd.sched_clock_mask, rd.mult, rd.shift);
        cd.actual_read_sched_clock =3D read;

        rd.read_sched_clock     =3D read;

@@ -287,7 +290,6 @@ void sched_clock_resume(void)
 {
        struct clock_read_data *rd =3D &cd.read_data[0];

-       rd->epoch_cyc =3D cd.actual_read_sched_clock();
        hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HARD=
);
        rd->read_sched_clock =3D cd.actual_read_sched_clock;
 }

Regards,
Arun
