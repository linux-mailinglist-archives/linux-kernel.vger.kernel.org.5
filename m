Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078547D21F7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 10:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJVIsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 04:48:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4350E7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 01:48:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so3203009a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697964530; x=1698569330; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XNLtWHFBNxsnTsrSDhKXsMmerBpDk501aPfxsURUQ/Y=;
        b=ajE2DrdSZzsFUYw4T7lCmBJcR6B+Inr8vi90eNuxLdW4/QnEouVagR+XGXEcPZrRWA
         MVQVJ0VIh0JteNgLS7bONqBJr6c+yhQopIuzc7J8j8Do2LsnmhMXNW90tbX1oz7d6Zro
         W1PDfwU7RVKJHqjIfpQoe4hg3S8TeAwSIefrNGaoZ9QASAoi1YDLXi9lvsal7W76LV5f
         uKAxonzVOh5B18gK+WA2Nyc4k3m3SVVqlIE1MAPZBrUBcdO7nFrcRXa7ch9X8Kt9JqUg
         oXCLNvlRGCEp6J/jMnVzn2rs4X0LR71Mlk0g5PyUajVim6f7niDfOS73eUdg2G0tQRpo
         buwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697964530; x=1698569330;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNLtWHFBNxsnTsrSDhKXsMmerBpDk501aPfxsURUQ/Y=;
        b=BAwvxeWSq4ycc2+lH70PLEYjU3R3+l0w1yB1N8OxM0cHjbqohOfmKXAq+ADXZxSr8k
         6ynXrjVCCkAVMJ29iqP/i7pBKxJ2w6QJtNtJHUejeh7y3I6fJDNYdMWTeP1inyb4zyZ+
         MN1dXzkGdMSu8bIQ1WPe4FjDL+Fytm35I2qqN25iasUwSAyovLUcmxlYJB+MjhSTU2zz
         S8zG31dCAyQZvJN01Pck+YlAdUbDJtpo3p5CizflNTbgfTS4+WGazBHMXGiGCgLSGjEy
         JUTcBcxyMxcvu2I3zlAUp89R66WVDsQrUu5XpWCX3fAYO8GQlHW6vMjpX0X7wwdlFH1y
         LR8Q==
X-Gm-Message-State: AOJu0YwUnNwtB8ilocB2vBMTNhxZSjpq6FeR39VMn58wUw1y/Y/sp99G
        q9UXZvaaGVZxRPcqMZH29vhPzFOWHZeVH3xUzqVG0nsRYVs=
X-Google-Smtp-Source: AGHT+IHo2z9LKRryB04+xzrV36LO+lfhmYlD2L48ockzfBXn2zByKUtKb/nZnr8zzenhxAkGo4/lY/gIFVv7FNPZnhk=
X-Received: by 2002:a05:6402:5114:b0:53f:efbc:e42b with SMTP id
 m20-20020a056402511400b0053fefbce42bmr3257343edd.34.1697964530009; Sun, 22
 Oct 2023 01:48:50 -0700 (PDT)
MIME-Version: 1.0
From:   gmssixty gmssixty <gmssixty@gmail.com>
Date:   Sun, 22 Oct 2023 14:48:37 +0600
Message-ID: <CAOx-CDV52DRTmrZ7WEYxngCTpO-X7-H4PGXS86xC9vDJU9U94A@mail.gmail.com>
Subject: How can I get/check all the kernel boot messages?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How can I get/check all the kernel boot messages? After booting, I can
not do SHIFT+PAGEUP to scroll up to see messages. Also, how can I know
there is no problem with kernel booting?
