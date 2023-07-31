Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C901769C78
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjGaQ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjGaQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:28:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721301BDC;
        Mon, 31 Jul 2023 09:28:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbc06f830aso30259105ad.0;
        Mon, 31 Jul 2023 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690820896; x=1691425696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h7lSNE73lj0ioWSGlzMCJus9tMgkN5ZlR6+RtZDGzA=;
        b=GYf6wrsH4RBCnRKEyaSJXyu6M/eFU0AqSzSetvo526HOrkihNr9WhcMPEHzdvEocEs
         hHdzbIfZVcVmk0XmlVJ3iqydGcYMVWp4ASzw3JI1j4f1lDgeOfFgWZUr+lvMKxL85NRh
         2JiO5EI5XU+l/EaR9sZnW2zOFVhq3sv5OkcNko+Naqreg6UcUOX+ye5EpUjQGMlAbeXk
         A920b7aqMN9RgMDWR9PkwwtE7lldQ4mzlwKWo/+fV5QbdvPQWS5XP50Mx+rWiu9Zdj77
         hjAmSr3eNzeq16D3d4ft1EWjs3FSIjBw1THJetHIWpoBWlA7Qk1T1wAZ5X2wbjJnp1/G
         Q+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820896; x=1691425696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4h7lSNE73lj0ioWSGlzMCJus9tMgkN5ZlR6+RtZDGzA=;
        b=cOz4bC353BcYACCZ+2Lde6J9bKAXRZUyPg3zlzZoVvbyuiR/Zo9tSub7yYATRN3yaI
         HGh8TVuNbOdR0VHKqEIkhfJ2VyKVRIRWf2dSts2N27kXWyW/ou/2eSHHXiwlHs6m/8AQ
         ILla00G1QEXeazTgo1RpPiTAG+k5q19GFzephW8fXNOIbiPJ6daQrfdgJdh6S35fnb+5
         Fyq0FcCGwgUc35LhrCp5ddTCKQQCfDUMi80p5DPrrVVwoWH9PShGgjqpNlf3XSzR//sk
         ySvk9pFq9cWW0cnSgrd4oiMRW8+5LyfwJUMTZa1Zh87k0Q+X8izrver+kVZvYnjNZYtO
         O+lg==
X-Gm-Message-State: ABy/qLbQXX4oWXMxIvNGs45fg0uYudz9WMWnIA6RCFFDHSISMWYZpoNf
        bogdjiQB7ZsFlTHab7Xs7Zw=
X-Google-Smtp-Source: APBJJlEPCe0AQA/D7GKT1NLPzJ+LI5ZLrQPWugkbBuVJTmpTScfwhh8Xreqv+n8ydHmbCelB+Pw6WQ==
X-Received: by 2002:a17:902:6504:b0:1bc:224a:45c2 with SMTP id b4-20020a170902650400b001bc224a45c2mr301722plk.15.1690820895765;
        Mon, 31 Jul 2023 09:28:15 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-73-13.dynamic-ip.hinet.net. [36.228.73.13])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b001b8b73da7b1sm8796117plq.227.2023.07.31.09.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:28:15 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     deller@gmx.de
Cc:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        minhuadotchen@gmail.com
Subject: Re: [PATCH] fbdev: fbmem: mark registered_fb static
Date:   Tue,  1 Aug 2023 00:28:12 +0800
Message-Id: <20230731162812.25518-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0cb2ab66-ca30-b2ab-47f7-04208b2400cd@gmx.de>
References: <0cb2ab66-ca30-b2ab-47f7-04208b2400cd@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Helge,

>num_registered_fb is still used in:
>drivers/staging/olpc_dcon/olpc_dcon.c:  if (num_registered_fb < 1) {
>
>Helge

Thanks, you're right, num_registered_fb is still being used.
I'll check this patch and submit v2.

thanks,
Min-Hua
