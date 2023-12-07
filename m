Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1729808817
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379437AbjLGMhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379421AbjLGMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:37:51 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712F710F0;
        Thu,  7 Dec 2023 04:37:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so5136965e9.1;
        Thu, 07 Dec 2023 04:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952673; x=1702557473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YHBwoyDjedu5XQ7s8skeUEAIG/9qhqMseyxLf/UJGFg=;
        b=aCHQQTVUwBVARoBAM5iMCt2LdMB9CMclb+e6DEnqPgAE9dsCd0mRkkM2hQdUwLK6NG
         4AzA2AqznKlhP/PANe20RSJxaAQuA3+/HPthn6o/U5YmOMju82o+o/0keCIUyFAK1EC2
         UVcKwdsFiHrOa4Y9Xb2dn82HUsq4cczL8Vf+LwROnFbeAnX94WYEFKdcrQ6+U0E2fg8u
         5fzuSJs9W39owx8AzAfm/bI74VoMmWSReb9/33Y3/lCzV46JWe7Gwi70ENNFVZ5HHGRH
         7/7ko8D+RB7SontBC+r561sN8Zjf0QsIq19k8ES+7KmmKPbS+DQ9b46ZS7+/pkdm2BUu
         xIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952673; x=1702557473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHBwoyDjedu5XQ7s8skeUEAIG/9qhqMseyxLf/UJGFg=;
        b=G/SF1GmHRgAz8qK5vH/AQjJ24V4iX74PgeJvJ766hTzGgFVA4ePYY+qRWSOwTT1ciN
         Q6pUWB3XLxkHvgS/zZRdRoQ1+wNEyisNTWjUzbyuDN8YYGcHg6jNYT1TQ1xUZeRqFrkq
         YffALr8j79fwYOgkJTnBiOPixKNjPYN5za07keTv+jcux1IrRhJ/tC2YcFZ8wRf1gjsS
         aIOfLRyQ7I7V6fPEck9zp7ihbFEjuvsvmmZ9+QgQSFEzV2dX/jCoYzgrwuExzAzPPjIe
         IP6zzlwMyHA8rzGr37xV3+qt0rdmnPjjOW5aoGNypGkgYWIxX1Zp/XVCdWQjGv1wvgKk
         7ofQ==
X-Gm-Message-State: AOJu0YwJ5SVaINncd/G87tc1vrsNQby+C4LY0M7qiyTPeC+U4JqfxcyL
        dDz7zzwUMviGNKDoKzBSj9eqE2GFFLcKTNHns90=
X-Google-Smtp-Source: AGHT+IFm3uvKUeZ2aJsxTlbEqDNbqUgt7fUphXqPyWYkZTrojc5WDFlnw6gHTSDOdSXH6Vcl5IwYVc4nvcJB8p7Z/wM=
X-Received: by 2002:a05:600c:d5:b0:40b:5e4a:236f with SMTP id
 u21-20020a05600c00d500b0040b5e4a236fmr2438696wmm.113.1701952672388; Thu, 07
 Dec 2023 04:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20231005074858.65082-1-dg573847474@gmail.com> <20231006162835.79484017@kernel.org>
 <CAAo+4rUE=+9Kp8CvMH3w15dJotkX03h=5YMV+hu-YSobkwj1NA@mail.gmail.com> <20231009081750.2073013d@kernel.org>
In-Reply-To: <20231009081750.2073013d@kernel.org>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 7 Dec 2023 20:37:41 +0800
Message-ID: <CAAo+4rWiPtnmW8anx-E1+qG1HAsobJ+F7EOfZS8Jhwh5DGT=-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     3chas3@gmail.com, davem@davemloft.net, horms@kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

Sorry for the late reply after such a long time. I have just sent the v3 patch
to change spin_lock_irqsave() to spin_lock_bh().

Thanks much for your effort in reviewing!
Chengfeng
