Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D096D7BA640
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjJEQcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjJEQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:32:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D3A868D;
        Thu,  5 Oct 2023 01:06:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3226b8de467so701173f8f.3;
        Thu, 05 Oct 2023 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696493192; x=1697097992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3D64ys7Y9Kfwst1+PfpLbA0bnJLWhV+7Z8p0nT7iUfY=;
        b=HhQ4hlFJKWKiryfgDewlRNIKck7o1tZpVlN+HEERa960sjmSLRphhooRdBOgTKNwcu
         W4R+fEJDzOywQB6pX2wQ5gJiVxcwrZpGtnJhtO1QSVXfYvT2Hl7auYcb2myFIdQbHeZv
         +KpGx1eSEqkgzkuAYcwiOzYdYcmUQi51g2to1/CJDD7xnK3dRCiKK4O7pjpixUyb5JSB
         T+gW1rnyVfAb2r4048m/T9yiewLIg1cll97Lq6GVm818B5BV+2gC65vf60N9uuniju1z
         XhwHRJGwFixKdTQKXlKXpra+JGM0KOsBIntZPlr0wqk8Hri1YI4FXo5nx/IwKRgBeCib
         Z/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696493192; x=1697097992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3D64ys7Y9Kfwst1+PfpLbA0bnJLWhV+7Z8p0nT7iUfY=;
        b=Jvw2c1x/XQwUnxd3R5TgegMEuzcgNgzejehve/qbyIl6xqXG071JkIMo20ExQE6R3N
         GgzZEClS8LwdjoO64u09GwpvxMUaEtk5BP8eXOLjfN3HZEbpeK5/jcQK7d9uXkN/Gdxk
         1IaiSvl7TZq1v69lMkRIh6cii+vbxF6UOaKZlDbITJOd5pFBhUzvK14C7ipTEKdkpD2Y
         cFkdRmqDkhaJTrfUqtchxFBslqU1hFK7feDXSx3wFh2x6J+zTqxFexBDIre9m9DzbD3g
         VzUUXJkM25i34tWukGptMjLxNCh7KBo0qlZCQt14bMqgCw8wLYrkBAFpmiSSue1h9GBR
         I7xA==
X-Gm-Message-State: AOJu0Yxqx9OF+bQlUgVhR3jnXxqgYenYtNaG+NN3YAb3bZnDclILEGqu
        Bb4GWTZ25mU7R80lR3IYu7e+ll9x2W7mutGZWAslMJRy
X-Google-Smtp-Source: AGHT+IG1l7K9F4O4IKLUskx/V3dL6B/Gd3COeS+t8ETpAx5U3+ANkIwRQHHPiVldlICWEOzrXKIIKBJ0oXHWWNWKsE0=
X-Received: by 2002:adf:f9cc:0:b0:31f:98b4:4b62 with SMTP id
 w12-20020adff9cc000000b0031f98b44b62mr3645102wrr.37.1696493191520; Thu, 05
 Oct 2023 01:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230926104442.8684-1-dg573847474@gmail.com> <20230930160428.GB92317@kernel.org>
 <CAAo+4rUpC0NOyPWt4xDFWmEnHCGEBf-wbFBDn18TVsLabdocTg@mail.gmail.com>
In-Reply-To: <CAAo+4rUpC0NOyPWt4xDFWmEnHCGEBf-wbFBDn18TVsLabdocTg@mail.gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 5 Oct 2023 16:06:20 +0800
Message-ID: <CAAo+4rWOGNo-2XFTj3Fk2so98DrUGC=cQqAmxcELFEk6euPd_w@mail.gmail.com>
Subject: Re: [PATCH] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
 and &tx_queue_lock
To:     Simon Horman <horms@kernel.org>
Cc:     3chas3@gmail.com, davem@davemloft.net,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The splited patches series were just sent.

Thanks,
Chengfeng
