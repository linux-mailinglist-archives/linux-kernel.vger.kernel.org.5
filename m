Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD4479C826
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjILH0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjILH0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:26:23 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E647E73
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:26:19 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7e741729a2so4913868276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694503579; x=1695108379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLdsOWkCbaUO2wihDuVV34jtr6h0+7J+jydeFj+9d3A=;
        b=FHxf6FGLo/aAe0RKd3LC72Dqv5r/hojKYGnCpjKTy8FU06ma+pcWsnK8ZD9exQa54W
         XKdbmTvom03wLo2p/fi0kzXH1cMx3dKnPrfXg7YEHKXKXzpVMnLwa5XZOqoJspYKpbGn
         5vX9wNS4bCyhPQkhZbY7BcqBXS0kuh+qIi33t59+cuTCyDRHRcqJ9EgrEAXu+7Ap3Pbh
         FlfanFlakLzBjIh04k+T4vgdcplz7Q39OjjKyUNaFOLbceM0J034d+omgHsqK8hXJmsX
         vWjnJ/SaPAJHdNdQ4waDnBLZdmA/VyAhOWxJ9V1Y5WpKytay5JzJkkumJcEpCP4aCiJU
         AhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503579; x=1695108379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLdsOWkCbaUO2wihDuVV34jtr6h0+7J+jydeFj+9d3A=;
        b=kWODSHnIY7ceqYwdVrgMwxo860a4cl6xpFgiK1mbnumzSMq6p2YOIZZFu4zjprlafO
         NWu8SiVXaegeo+ukqw4F/ASOIgNXlWY0j1NrHRzOoRGjOVu1vpiMyKzLzU6ipBshS35o
         dZvgHBQQ7cRF1W89AOfTb0mQxupuMI0Q81hzMRrCunLRW4gDeLISFJNehEFZXJOsrBjM
         dRxKj0ZVPTtJmfEkXh9DdqKWh8n2EphyNsyRE46TiGzUIXedPRhuP9nmk6t+XkSvmWYe
         cAdwqPuBv+069KdvY+CXdSPRMTiXs0/8pTvVkrUKghHG8kt3XvSbareMaY1nrKZi6dlF
         KzRg==
X-Gm-Message-State: AOJu0YznX765e3S6347m5fcPod2c1joB2alsmJ+D0pYJaiywP4xjzcpk
        VxfbgZkXfoC+hVX/z6D0TJVzI2lUSE1roUCr3eaaEw==
X-Google-Smtp-Source: AGHT+IGeNWnbTJYHAEpu7ttxsHAQMqTYNLyDgS4Z0qnT0Qv02dPr86nF3zYh83i2sXkcAXGeeyTdc1GC/t+sQyizd3k=
X-Received: by 2002:a25:4c2:0:b0:d13:5ab9:827e with SMTP id
 185-20020a2504c2000000b00d135ab9827emr11105762ybe.16.1694503578805; Tue, 12
 Sep 2023 00:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230809-topic-mpm_mappings-v2-0-4c2b4495e654@linaro.org>
In-Reply-To: <20230809-topic-mpm_mappings-v2-0-4c2b4495e654@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 09:26:07 +0200
Message-ID: <CACRpkdZw=EfPUWqU3-o3aPQSYZWn5hnenbMqgU73Y8oTo3Ogtw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] MPM pin mappings
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 11:21=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linar=
o.org> wrote:

> This series adds the MPM wakeirq mappings for some SoCs and fixes my
> "big oops" within the 8998 driver.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I simply applied this v2 version since there has been over a week and
no comments. Any remaining issues can certainly be fixed in-tree.

Yours,
Linus Walleij
