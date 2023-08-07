Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4D87723C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjHGMWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjHGMWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:22:18 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F977E76
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:21:50 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40a47e8e38dso422171cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691410908; x=1692015708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnwColYSZ3XmSl1bpZo/azPZh2FDVfUZk9ZS2ZdZQHY=;
        b=TrBQ8VPQMcf/qpu2cHmg21VlDcAedV3vTdiRn3i0+Z++5MnVbbmZt2LwsiaF8hPGeH
         S8aXQS1y6/nOEpe9yDnv3Jw4ELm+BRTP0vl+/21Sdys1mEuq3TEjkaSulf04pqlGiDbI
         QmtJ495Kx3G4Sb4NbEymFF5Ny0MX98J63MfNBAWb30Ya0/3o1i92Aq5MdRd+sNBFK4YA
         iduJ2jcZblqno1jApMd9ilSc8wACQPn8UQ3CYPgS79qVgnF0E0muO8KJ+UmOSkH36ysT
         2yd9A11hfvrWcHtcl42lHUc6ya7iFw2mn8JxqCu6mbG0p8ptJaetacngcT32umAi7zT+
         8EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410908; x=1692015708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnwColYSZ3XmSl1bpZo/azPZh2FDVfUZk9ZS2ZdZQHY=;
        b=dELIdiu5u4UP/womIakHRak6I6+jUdSTDVCvMqK/vrNX9wdnyRFRJebD8w/Ij/HmT9
         xTrfPf53l5NkiNeywbvY3tFHlGC1XOxfJ+k7ONZuC3EtvK25AwOslqXuRFzap9F+GxxG
         vmuWcOGHxdbbh3jz4bAbBCcG6AE69uJoYzY8D8ymkKmuELbA3SE5jwIYikp3SKwh8i1k
         tmOtFrlSQjWeX5XSVg5FfX5QqCukjXwzc0e4J5qzFStZTE3x3TLUbZNDPk3sOsWH0PjW
         Sh+gQ+D+ZptxdmniOS7Qb3PIpokjpT+HovwKsKfe4fFdfje7y75g2S+aIMBtNkjm+5/Q
         c+qg==
X-Gm-Message-State: AOJu0YxCYHDSiN1Z29KkUtXwBuCfad6rxycl6PqoKXeBXK0P4X1x8TYL
        y+Ld0R+vlS7zVP+p62E11SXd3mSCznewTpJCkgqdWg==
X-Google-Smtp-Source: AGHT+IEMLGULSlVZult/2Q3+afbrOjHWrJzvVVPqLYP1dw+AFfKzXE4tHKlAfTJFU/sZEnAsMyMyNJU3jhfdP2K/sgI=
X-Received: by 2002:a05:622a:1891:b0:403:b6ff:c0b with SMTP id
 v17-20020a05622a189100b00403b6ff0c0bmr395515qtc.6.1691410908040; Mon, 07 Aug
 2023 05:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com> <20230803003234.v4.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
 <ZM2Ki7MDsNLkBEQ9@Asurada-Nvidia>
In-Reply-To: <ZM2Ki7MDsNLkBEQ9@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Mon, 7 Aug 2023 20:21:12 +0800
Message-ID: <CAKHBV27vPc0mS14oz8nAbrm+bVKeMmtYt5YVU_abkFZEuqmN=A@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd table
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 5, 2023 at 7:32=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> w=
rote:
> It'd be nicer to spare a few more lines here -- something like
> this yet feel free to rephrase:

Yeah you're right, this commit message was pretty sparse. Will update.

> And btw, you should probably put your Signed-off-by at the end
> the commit log, i.e. behind "Reviewed-by", meaning you created/
> updated the commit, and then signed it off.
>
> Nicolin

Ah, thanks for the tip, will do as well :) .
