Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2957BF5A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442716AbjJJIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379435AbjJJIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:24:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843D59F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:24:45 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c2907ff9fcso66278421fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696926284; x=1697531084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX25oi0TLFjjBEfrkFbaH0utg1e2SC6E+qDGBgsDQdo=;
        b=G6A+LG/lVb/gMdPuzC/reTnMsTS474QHAkX2wBM+2ZyMHR3YLaeV0fJydXUsJ7w3Fn
         oy/58WqyarKKjQkZlGIzLJXNBOXBU2AuftG7UAkyeSiJd/Eent952juj05Cdl2GuSyoY
         UreDa0eCu/QB9UdUOXECOHsogEGpYkcofnkfCF7Jf3dTcs2LT9AnmlVNKOyuVD3kjFxb
         RXPJN2+i6brcQeawq8nZW687zo7lfOGWGoPbBVrDlmXtWeToZrNWCYqETNxEUK4WWXTt
         cgGIwZ5WHjrq1emw1ZLFJPJraDEWZwEci/M2jC4RMzeVPCyo4lBbnyINotm3LeaaEGzy
         1aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696926284; x=1697531084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aX25oi0TLFjjBEfrkFbaH0utg1e2SC6E+qDGBgsDQdo=;
        b=jCQaWWsbNcGRwXA80/xqfFduM2NPoBMbObgF9J0qGE+I+M6Asb3r459vrpcsJZcFSC
         9QjeGyWYbBkY7p6Pu8sIaI0hTlIX0uOXtKHvGnhE5HVgdje0En4nV8XiidNRAJODEEhc
         907DhnI3ekvrZMbDZpVqZKrQLdaF0uc5HHbyuWcst4wz11tEfins3bY/gTnwS17app6r
         w40rE1UYddUVtz9Z0pc/fl/5i+WM8+B19xH+s9l7m5DLjkMv5xTILEEGSfaX6AZh0gke
         QW5CKWCBNaTCDqh4iZePp42lQl9dmQcBaXCNbWHmHc8wWoPT6vgwoOYFZwA7FZFNtHkm
         1O5A==
X-Gm-Message-State: AOJu0YxPAagi7pkeAxdM4AhF6D+6kHIgz1u4AaKQ+MsS1j+mZqz8JUUO
        4Lh0qEU7hZcMh30PMtP/MKphpEI34QTtKSwPh9FuXRz4N9OZX26Byvc=
X-Google-Smtp-Source: AGHT+IHhrZiCx5s9X4MQiD/ZMSUpzqLwWRHkc3HfDvbsJDBkyyqNCsF6iTzVVnQFoGa3q3wDj0URozRl7VFxZ+eoCRo=
X-Received: by 2002:a2e:9ac7:0:b0:2c0:1a80:dfb with SMTP id
 p7-20020a2e9ac7000000b002c01a800dfbmr16890336ljj.27.1696926283756; Tue, 10
 Oct 2023 01:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231009165741.746184-1-max.kellermann@ionos.com> <202310100815076048fb2c@mail.local>
In-Reply-To: <202310100815076048fb2c@mail.local>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 10 Oct 2023 10:24:32 +0200
Message-ID: <CAKPOu+9TKVAwQRBAquyK+TGdAzj_xtJLT0oobXM75zVLvRsYoQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] drivers/rtc/sysfs: move code to count_attribute_groups()
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:15=E2=80=AFAM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Shouldn't that live out of the rtc subsystem?

You suggest making this a global function? Sure, if that's preferred,
I'll change it. Whose decision is this?
