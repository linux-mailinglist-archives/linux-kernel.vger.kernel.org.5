Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F1A797B3D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjIGSKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbjIGSKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:10:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A832108
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:09:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401b0d97850so14101975e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694110188; x=1694714988; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pCnFNrhfKvgKyhjnPC51hGyoH3E3jnCxGNU/i7AfUKw=;
        b=hK+a1UhReZj5IdkYiUIcmOsf9TomYlMy5StwqlIRIVB1eIjDi7AwJ//4K5JOpf7r6h
         2A3FF4C2wq5HbfTEiPA8yqoTksOeH/b7vdqMWkj1a/rIypzDggmTQXNn1bL1oqrxMEH6
         /xKTqHO+QDAZiIt2ILB6GJgi7zrRV/KQKad0PdDv0fpGRUcvmHrykLlTxWfj2bkBDsG0
         gMJIp4N2sg7aylYh3JMGuXF9VNgWdUmBvY8wwB7kNsXqm6VAhwbEW8D3Hc/RkweGuCAb
         gTu3WOWwXIMn53nmJBT6X6K559y3aLgBZ18BMbJAGyjmAY6Bf9ro5jTROiHrL8kCmFkQ
         RrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694110188; x=1694714988;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCnFNrhfKvgKyhjnPC51hGyoH3E3jnCxGNU/i7AfUKw=;
        b=axaxWACfQPbiKi/XomJid/bJ7ex8P9QNoMn2/CkoVTt069UaOAVWNs7hKBuhxOZv3h
         xbpnQGLp/IUhGYJMzycSQF8AMS95CFbzqSfUJsq4rmdH6uy+h1Gp+bxbvrCJqccB8lZI
         Zt5WUM0C3KuHdQzdPswlgRpnkFkCeuMI0gogkoTdfgyD0mPh6YWkCQME6O16hoIBQ1t8
         6P8Ph5Foexyc0tmj33pSZfN6KPjjsFEnAILmRAFHJMDk3qRp8t1s0yrLZhiNj0jhTL5/
         oqi01OhKlzvDKObYG1G66lBAMxQ6SvOI5FGkSs9SkvK0EdxHWZ/Uzo2n8DPLOV8Pds2H
         9yxg==
X-Gm-Message-State: AOJu0Yy7+rTwwFaqsh+6Sb3jkv6KHAD4QX6DR9iWEiNypdB9qtH7p+F8
        5x+dWx0dEtspTZ+VhjF1+TlVzA/vt7zNNESIICtuqrqmAaA=
X-Google-Smtp-Source: AGHT+IEnYPPlapasnUAkpS1CC82jTk8/nJ3YADivWX8o2hqChvYztGv3qsZlBnIBP88hMae5KBaGcUDhlNDDaiP0nXc=
X-Received: by 2002:aa7:d510:0:b0:525:6661:dc90 with SMTP id
 y16-20020aa7d510000000b005256661dc90mr4254659edq.25.1694087779966; Thu, 07
 Sep 2023 04:56:19 -0700 (PDT)
MIME-Version: 1.0
From:   Jon Maser <jonmaser8@gmail.com>
Date:   Thu, 7 Sep 2023 04:56:08 -0700
Message-ID: <CAF=mWJPsrWvVVoDqRtZwC48cMKx+5x0bBt5NBLOQemKva9ef9A@mail.gmail.com>
Subject: would a linux kernel news group benefit the linux kernel?
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_20,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

under the guise that it would be used, it would allow discussion, file
sharing (down to distribution isos) and it should not be hosted on the
typical charge for use nntp servers on the internet, which hold
questionable media.

the problem is it would cost money to host all the files and deal with
all the traffic and internet noise, so im just throiwng that out there
incase the linux developer world would like, news.linuxfoundation.org
to host files like that.

and yeah, all youd need to do is download a news client such as pan,
enter in server info and read/download/post

just a novelty, but could be useful
