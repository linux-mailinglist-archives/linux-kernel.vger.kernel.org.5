Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D877A0095
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbjINJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbjINJoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:44:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C369026A8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:44:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so7967655e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694684670; x=1695289470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2zlwMt/1qb1MLOV1sSBNn+CBe41p91fImSV0fPQ0M0A=;
        b=rWARnC6w83n1EEhFuNtjJNwzw5NQ8pTHcFHsoX/cQu6jqR5jGPdFndp0bonUPK7uqN
         YLSPAjwQrCXygXVR/lsX7VEjESTH27fw5CnQsvhk2U9HBlPM54AP6DmLK5qADNpC0BA6
         argS8qlacVgGOPFUaKqFHXWfsPQSGXx4d96SVlc1Xh+NPEBmFJ7qz2FoR1itVVoiVkZr
         L8KUcbzRqHaqL7WkY/YD23GC55w5B1Jx3tbYbnW8L5yTEs4KLzifzIwAScBpXZUJeOdD
         XRlxZllSrWJFsLCLf9W7IzjMKg6YGITLEyAlYQdxld3tDfx8d513+ACL+TnWkQ/JWsVh
         boVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684670; x=1695289470;
        h=content-transfer-encoding:mime-version:to:from:subject:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zlwMt/1qb1MLOV1sSBNn+CBe41p91fImSV0fPQ0M0A=;
        b=mUeob7mIqIDvZz2mBk7FavpNCaA0nyDhtE9fIanI9eBD+XGGHhqGoVEeXG31Kpm7cD
         12MjGKavugjEeJKcKGM1VZlDYM+RGgA53sR9i30Yd4sJ4AxjTX1wKMuk5pNQRRj/xDgB
         /l/QADe97vtOHdDoxuc4dz/LRNsS2u/hLuJCmfPjilimmfgJBRbyRLJKVVaJ6o210nuS
         Y09kGL9SGzW+CwdVBgSucTp+vX1n2bKbu2YvrN5b4KED2HWx1mdzb79ECapblVsWKYzz
         jaa8m/X/Mhy8dbjjKr7sNXnChYK8qx4gglnMBpAafOHreMKc4RB/3qw/Za2E+7ZhFgxH
         gvHQ==
X-Gm-Message-State: AOJu0YwrxN85VXskBF12kxcZMNT35V2JF+ynIOY7rtn9MChOWfHFfIGQ
        y16GC6Pl5sdW8zeKdSsCSt9tdJfPckNFYg==
X-Google-Smtp-Source: AGHT+IFc5G53FVaExDgb7Ec+zUJb4oulzj/DYeV0TFAGyvB2kYZ6NbVXgwSSwzn5p055GsYjtErC1Q==
X-Received: by 2002:a05:600c:2242:b0:402:fec4:fddc with SMTP id a2-20020a05600c224200b00402fec4fddcmr3836118wmm.17.1694684669944;
        Thu, 14 Sep 2023 02:44:29 -0700 (PDT)
Received: from [127.0.0.1] (178.165.204.138.wireless.dyn.drei.com. [178.165.204.138])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d63ca000000b0031ddf6cc89csm1261752wrw.98.2023.09.14.02.44.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 02:44:29 -0700 (PDT)
Message-ID: <adaba30d259f8113a6d7f524ee2facc1@swift.generated>
Date:   Thu, 14 Sep 2023 11:44:24 +0200
Subject: Re: Domainname reflexzone.de
From:   Johannes Braun <jb7283397@gmail.com>
To:     "" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guten Tag

reflexzone.de steht in K=C3=BCrze zur Verf=C3=BCgung, h=
=C3=A4tten Sie Interesse daran?
Falls Sie weitere Informationen ben=C3=
=B6tigen, freue ich mich auf Ihre Nachricht.

Viele Gr=C3=BC=C3=9Fe
=

Johannes Braun


................................................
