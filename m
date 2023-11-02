Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA507DEF4A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345914AbjKBJz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbjKBJzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:55:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE31913A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:55:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so1172358a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698918949; x=1699523749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD1LP756xWcLmOGue5zN8DFu0Ql7ryK355DrzfRDjH4=;
        b=L4o0JABnVMIR5pc56fo8/YAJEFHy1LhmDz1H20X6Tz2omqDFRsgkBVLrJ3xyq3q0Cp
         RHcm81LB7+Tt8wx5xOnsl0pCTN+fXbJet4LUwIv6x/IAdwTFqEWvahuUbWmq1yMWOD6u
         lzlXgjL9kD2yZMLNHbNSiZLFYwNW8in6yfwpXYfFbNJNhbnxU3kJdeZJOwOxnW1XhVOH
         i4ef7DsUWcXJkE5hIC82LaCPGMB8HpLml2neGZ8+/p3VdMOgxNCeGufuDIUPtdf0yY1T
         csHCJOnDAaov0X2qdrLr2nC5Fark6jFc17LxBed2zPetVnGFxBeTzHCA++H9FfPG7qqP
         HzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698918949; x=1699523749;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KD1LP756xWcLmOGue5zN8DFu0Ql7ryK355DrzfRDjH4=;
        b=RSCNRHG22psGYarLQQp5d1wk4vNf/FrqN38dK5bmlVfLAAIs1PxvL8u91IUzENiVLD
         v7S/3NvwVDk2YeCUEgrxuQYya5boPf9PXXPhFNADqcgDeya6+Dhgd/O5A2sepyJ1eely
         NCy4iR9Dg7jYHlePaVPRPOAX+bIyFWcoLNOCAIxYUzK8BSvPOLmn8C3d+vS6jAijKRfL
         7bmV9WRp1hmsKAkMXd2dN2TQTf+f49DCNHAISng2b9xN1b3UYL9HNtYqnhtORM6z3rIk
         TRShYQwoUhf15Pi4R6QD5cIY4/WrgRyikKEn6IanG6r7Zi+C7329BPthp6RNgl9SH5DU
         8kug==
X-Gm-Message-State: AOJu0YxNztW9UW3czWzp+FNTiSV/I99+65pp07Sxqurl4Ze19GJomAo+
        Z6uBKtZEkJLi16/+HhGeDjG9SOXvAcWcemkBd9H9i4T2
X-Received: by 2002:a17:907:6d27:b0:9ba:2fe3:c97e with SMTP id
 sa39-20020a1709076d2700b009ba2fe3c97emt3051134ejc.11.1698918948114; Thu, 02
 Nov 2023 02:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231101081726.1163042-1-xinglong.yang@cixtech.com>
In-Reply-To: <20231101081726.1163042-1-xinglong.yang@cixtech.com>
From:   sean yang <seanyang230@gmail.com>
Date:   Thu, 2 Nov 2023 17:55:37 +0800
Message-ID: <CADGqjF+qsrKcNntO7FdcUxJ+L4rC8jcMT94nv8uOOTH-VwG9mw@mail.gmail.com>
Subject: Fwd: [PATCH] firmware: arm_scmi: Remove inappropriate error log.
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MALFORMED_FREEMAIL,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A xinglong.yang <seanyang230@gmail.com>
Date: 2023=E5=B9=B411=E6=9C=881=E6=97=A5=E5=91=A8=E4=B8=89 16:17
Subject: [PATCH] firmware: arm_scmi: Remove inappropriate error log.
To: <xinglong.yang@cixtech.com>, <sudeep.holla@arm.com>,
<cristian.marussi@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>


The platform may not support fastchannel, but this is a legal
operation.

        -Before this patch, when the platform not support fastchannel,
        goto err_xfer will print "Failed to ...". This log is misleading.

        -With this patch, when the fastchannel is not been supported,
        the "Failed to ..." log will be skipped.

Signed-off-by: xinglong.yang <xinglong.yang@cixtech.com>
---
 drivers/firmware/arm_scmi/driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c
b/drivers/firmware/arm_scmi/driver.c
index b5957cc12fee..2b990e50c8a5 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1642,7 +1642,10 @@ scmi_common_fastchannel_init(const struct
scmi_protocol_handle *ph,
         * fastchannels at all.
         */
        ret =3D ph->xops->do_xfer(ph, t);
-       if (ret)
+       if (ret =3D=3D -EOPNOTSUPP) {
+               ph->xops->xfer_put(ph, t);
+               goto return_normal;
+       } else if (ret)
                goto err_xfer;

        resp =3D t->rx.buf;
@@ -1695,6 +1698,7 @@ scmi_common_fastchannel_init(const struct
scmi_protocol_handle *ph,
                "Using valid FC for protocol %X [MSG_ID:%u / RES_ID:%u]\n",
                pi->proto->id, message_id, domain);

+return_normal:
        return;

 err_db_mem:
--
2.42.0
