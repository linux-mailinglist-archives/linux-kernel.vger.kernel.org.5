Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1DF7FA6DF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjK0QvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjK0QvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:51:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFAED2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:51:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b2fa4ec5eso33247715e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701103867; x=1701708667; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8AgEC5hl9xTiJhztF4t3qyhaDyaWPbhPKGmUnOdojk8=;
        b=gx+wa8Dt5O4Jt133x+JgCZuD5AtWbzxDJd4/TPZnT2ouNa9t2TB0g2nZs9y0sWCmSG
         rKCwSbkTmhOa/+T2hE7R+7WJP31wvyBdtbjO3vZ9f1AyFXmjF6BH0D4OPHjy99NTRtSS
         MxkXSdyEEUMCT3/c1YvjRZSdPdNkDGzArAszRqrqfUB2WvyquTZKS4WOWmxtxhBRm6Bs
         /mVoW3XK+sqWW1MxT7Eff5TwDAKRRFdS953vmKugxPEz0h9/WDqsVlD0IzaWCpmc3Jj7
         Gh9bTAy0/gI0YPsTPJauNGr+rxiOeMY5qinT2zJcxUQP20N5pA8h5ltbtEoBWLufMpeH
         NALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701103867; x=1701708667;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AgEC5hl9xTiJhztF4t3qyhaDyaWPbhPKGmUnOdojk8=;
        b=WBU+jfZnVlzQG5beQKhESxUk0VWLB+U7WObxo90ZzMFJGtZFo9YonbpvA0pSeTxlOK
         43Uu1g+Pr4t2CkldRbj73l7d27QVGBsmnyoQUAk12onFREDpsaMiCxxlJtPUmmLXnJJv
         x40Xq/wCq6YUHrmWj5L3LyblZZQHK8UEzllc1vHknbvq4s62uzTKNI4f/TLy88FlJqmM
         /mr3dnQwtKhFcPJoWsNGW3cgljw86SNqPMNF0nFIzR/x8Kj/3GkQ3JLhHzD6n4w8xb34
         9/zKHErqtsCOPcZm2PCcOwwd91q+KR4QYmykrKE6PW2i2Jy6noXWd7Ve4S04KE/kNet+
         deFw==
X-Gm-Message-State: AOJu0Ywx9D1BngQV2G3EoP5zTGBR+xe8p+71NzFlyK+pIqJoNH0hR0uo
        0uiEFKxAnfnaIpdHccCk6G9/J5kBclc=
X-Google-Smtp-Source: AGHT+IGHHAAh/ydDP4ntX/SoJqHQvLDh94zs+GaWmVI/m2yvkEdRIIFjW+79ckjjNvZ93n4cVv1sqw==
X-Received: by 2002:a05:600c:a46:b0:40b:26d6:f538 with SMTP id c6-20020a05600c0a4600b0040b26d6f538mr10284876wmq.41.1701103866992;
        Mon, 27 Nov 2023 08:51:06 -0800 (PST)
Received: from DESKTOP-6F6Q0LF (static-host119-30-85-97.link.net.pk. [119.30.85.97])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b0040b347d90d0sm15131887wmq.12.2023.11.27.08.51.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 27 Nov 2023 08:51:06 -0800 (PST)
Message-ID: <6564c8fa.050a0220.fd479.2035@mx.google.com>
Date:   Mon, 27 Nov 2023 08:51:06 -0800 (PST)
X-Google-Original-Date: 27 Nov 2023 11:51:04 -0500
MIME-Version: 1.0
From:   callahanbryson63@gmail.com
To:     linux-kernel@vger.kernel.org
Subject: Building Estimates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0D=0A=0D=0AWe provide estimation & quantities takeoff service=
s. We are providing 98-100 accuracy in our estimates and take-off=
s. Please tell us if you need any estimating services regarding y=
our projects.=0D=0A=0D=0ASend over the plans and mention the exac=
t scope of work and shortly we will get back with a proposal on w=
hich our charges and turnaround time will be mentioned=0D=0A=0D=0A=
You may ask for sample estimates and take-offs. Thanks.=0D=0A=0D=0A=
Kind Regards=0D=0ACallahan Bryson		=0D=0ADreamland Estimation, LL=
C

