Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F8C802625
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjLCSMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCSMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:12:21 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC8EB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 10:12:27 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58d54612d9cso2525339eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 10:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701627147; x=1702231947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg+rYehudk4zCa2J1cWSGcffMXq8x+Mv5QTHznDZ7UE=;
        b=IItbyqSaslJmRtggyu2MJS+ZvmgLSPiVPVxd2zCgP5su6Rzc0f436I16Kzy2d3iS7C
         z1e83YjuZ4XHkI0eXQsQcNsF9Q30ABDjm7EAxKQnGUdTRZPUxPKzyArV10HiKD4jnUrR
         BGjpu/N3DNis4/6iR3DnUlfgQhiw/py8pBKSNjBNEa/0owAG8s3GB2C0/gSN4rEFKxn1
         5kqxHQ2+Gh35xP8Wk+t8VBLlBf9+L1546BE8iOq/MyFyYvIY7tcSf8jpK+lVMZKAz8ce
         AxgOx5tKA8F8NJysQmRx06xrpnm7YbBbD5sUQuloYcKh5X7lm08SJYM4OdJh2riv0DF0
         xoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701627147; x=1702231947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lg+rYehudk4zCa2J1cWSGcffMXq8x+Mv5QTHznDZ7UE=;
        b=kyzEf51477i9CA7iv9wvOD+APr2ROvIROuGg7j5LwWu8wG2dsnPOfmqSfoUtCsqPY6
         3PBRs2ga+YbY2DrHU9kGEexzqep/dpR3oUd6jJbWTkGb5ZYcwK7XBYPjvQjDtglnUgvo
         1x3yag+WNGn9egV+dRQMTh/dzlnPt5CYeUnFXmU1PH4/WBEihMqVxWdtcKX56YmX2TQg
         bW5YuIWEhfO80uo7QJwyKceoF/PeCZDwJ9U+cjMXppcJ4rGthI8bZo8aoAiOQmHzSY3+
         P5d0Y+IwrrH3lLEJc9duIChy7VTcM6uus5BsRkncPoAvuN2A0QEYcnO85ZRW6gaP3OnO
         qHTw==
X-Gm-Message-State: AOJu0YyJpu2kn0HSv6vCBMX1OCqWtUzT1KQLxMGFU6i5KjMuY/q79a+J
        QcYNzKpVQCtxJTYSUIfC/OtuOXBcLUnr3k1jZJcHiUxbe3uWDizVBdk=
X-Google-Smtp-Source: AGHT+IFKiSLUh69bXIrR+MV8gBrvB/vkxWpWEmjwGc5/RbIXCKbbWe0MXg9D42xuTng5Uf6CH97soxZ4iLXLqlDmZLs=
X-Received: by 2002:a05:6358:10a:b0:170:17eb:b3e with SMTP id
 f10-20020a056358010a00b0017017eb0b3emr2568531rwa.40.1701627146725; Sun, 03
 Dec 2023 10:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20230612133452.47315-1-luhongfei@vivo.com> <3a32ad33-5f0e-4166-a118-1bbbec9c68e0@ixit.cz>
In-Reply-To: <3a32ad33-5f0e-4166-a118-1bbbec9c68e0@ixit.cz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 3 Dec 2023 20:12:16 +0200
Message-ID: <CAA8EJppC6kGVf2XKu8AWYtJu+p5auei3Mdttae1qvuxRrSa-gQ@mail.gmail.com>
Subject: Re: [PATCH v3] soc: qcom: pmic: Fix resource leaks in a
 device_for_each_child_node() loop
To:     David Heidelberg <david@ixit.cz>
Cc:     luhongfei@vivo.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2023 at 19:46, David Heidelberg <david@ixit.cz> wrote:
>
> Heya!
>
> I think this would be great candidate for backport, at least up to 6.6.
> What do you think?

Yes. Most likely it should have had:

Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")


-- 
With best wishes
Dmitry
