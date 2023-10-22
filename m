Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F507D2119
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 07:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjJVFFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 01:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVFFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 01:05:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B89FE7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 22:05:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so3110151a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 22:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697951138; x=1698555938; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UDK34Wka6axvkNA8E+4NFXuZ1ntVEZV+0vSGiQsmYhs=;
        b=i52fYCZTz7hNfAsoMdA1hoCyWM/4vaHh5ZDHtVK8iz3uKIVVeYFkpzZ5elR6NyVGVS
         0k7hRP/u1YfHRsMroz7Ycg3bJsrXJKmUPl1Q7pgqUK4CpXmU/So/LbZkTiv+XzPJHjFM
         xWbBPmfh2CS5+60vk5ABxc0g4Kyjo3pfsTzbFClK6fD91cPi8yp+uToTSmvpzHYByiIV
         rr9CMfoGMzL7nHQiUzlQrYDPlqaYpoXH6Nzw6HYhnJtz1CI0I6r8U92eYRjTIlO45UJe
         hebGNB6YGTs5nh/xZFGQsJ5HdbkUyMaY1lIsp9cb+M+bBr8bb5dJiuDe9ZtVIOriLRr1
         yJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697951138; x=1698555938;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDK34Wka6axvkNA8E+4NFXuZ1ntVEZV+0vSGiQsmYhs=;
        b=jaDoQK74Q4J5amsprmlAc/xcPAK2HtwpP87VK2sOLlfcA4cI/DoDQO7WV5ws4fhsff
         A6Hrf2i720LEZsPQx7dmrJMmQGbGL9xKIwkhAZAxzjoFYIaTeJ3kd7RH/sZr5W7ia8O8
         wtQcgEGcUCjSbGCCzN/95iYOnUJSoNQilZiEruBXOlXnaJET7seshO8sBGsj0k1x84OD
         Ak6YFs3woxJMkvgM23xRsSndaXzWYoik7EKuOLx2krxH9d/Q1ec8P8YgxFtZoQkMcVlD
         ow+ELK1mBmhoDT9xW04sWXC9FoD6+UXWKhhPxXYZl0vYUWT9YTUbgMjGmhNrkCsvm1r8
         U+pg==
X-Gm-Message-State: AOJu0Yx8XrPnnG1Lxj61yRM0GvB67qJt8auLvbwiBYDM/2pbvbAG88T0
        tNOFA/lNUWjj9je7N+h7teRsf32HIfNEdjHL+JMoN4UNC0I=
X-Google-Smtp-Source: AGHT+IFQ9OSV4eayCYhBrmoa/QC7i7quzQ9+751NY5ApOy1hyLOYIGwcsz2YTH1aRpJqxoOVVLoAzTqslXvL8lEardw=
X-Received: by 2002:a50:ab5c:0:b0:53d:d4a0:3154 with SMTP id
 t28-20020a50ab5c000000b0053dd4a03154mr3654850edc.31.1697951138252; Sat, 21
 Oct 2023 22:05:38 -0700 (PDT)
MIME-Version: 1.0
From:   gmssixty gmssixty <gmssixty@gmail.com>
Date:   Sun, 22 Oct 2023 11:05:26 +0600
Message-ID: <CAOx-CDU4_3j-mQcczscZ-xqq+XF7R=H62i1SoojczG8WELUMgQ@mail.gmail.com>
Subject: Kernel panic after booting custom kernel
To:     linux-kernel@vger.kernel.org
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

I have compiled kernel-6.4.12 from source. I have put the bzImage in
/dev/sda3/boot. Booted it. I am on virtualbox. After booting got this
message:

Kernel panic - not syncing: XSAVE has to be disabled as it is not
supported by this module

Note that, no other software has been installed in /dev/sda3. I am
trying to boot custom linux kernel.

Why did I get this message? What should I do after this?
