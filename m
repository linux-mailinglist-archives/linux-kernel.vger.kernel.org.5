Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F74076E56B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjHCKTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbjHCKSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:18:34 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E44210
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:17:52 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4036bd4fff1so261861cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057871; x=1691662671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29AWipdQo31kN/LF6uL0S9fTmmZ+Vp1T6y0yHo8ss3s=;
        b=qENaUuvDShKvl0GSjEp+Xq57/W9/7QiDDOXIMSbRNu6tVCfSamwUwv8lfKvruI4Mdj
         WXoWUQ5ab5hK+HZvmYmpJGuyt2cLf3eOzlAhuhhbohP1AqVP7C0yZRqRkSPtE5QKZcsp
         hqJb5yZUn3jF1MXwk90sadZggDmo0BJ4SwbX0tjePaim19TxYz+kdqEWf5hF5p4xEejJ
         Qs/O4aOK10ofyiAI35verfeR4X6f+bTQn/DymVewBIUkWQhNGlTvZFIglFsUKSZO6Y18
         aXeathHxRUad/alfxViGElYYVHuJCtplXmJf8YcSEMdZUmd9hLbMORd1IkjXUQ17oDO7
         2FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057871; x=1691662671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29AWipdQo31kN/LF6uL0S9fTmmZ+Vp1T6y0yHo8ss3s=;
        b=YH5ifJ7oAiACtrvtjVAQavvGg1+v7o9jvXIViNRaQ420mB4C+tCQJU4dTZcwBe9W+i
         bePGOZtTJP32FLeiH7z/JEj0aeEQZmXHUIMWgS47qOhXJVJHwQOuJ8J10wybBhGlqoz5
         Tye4BshW1HUbPSZ8XYdm8uyjDtaXGxohsKDo71v+AOU7rUiKMxcjfpNQZIATcQlt4EjC
         jt6XxjFd4KR6I8ogYJqsUcE3g5nl8OMwsyHMJKC75qujaGeEAz+UA9+RiQC8JgYM6LQK
         9tQ49FLyCUOkEnZDwfsHVN6TEdIh1YRSp5hP88BWxalS9JIBigqliZnNx/klE5+kkBiB
         hWyQ==
X-Gm-Message-State: ABy/qLbh4aVXvJQUu1PMSyI9/glFECaDekFQNW0BlUHQS2m/MAgg4mM/
        O/+02SrY5Lp67rfDsoWwidiyZ3jekoKoVZaHk7vhyA==
X-Google-Smtp-Source: APBJJlHH21AxchBfMPJlwaX6hi1FkZvHXSAuBRU5Jw5qd1WmFBl7oznkQ9KCKkmxkFo5LYGeNlbmoe3bfCOouswmTFQ=
X-Received: by 2002:ac8:5913:0:b0:3ef:5f97:258f with SMTP id
 19-20020ac85913000000b003ef5f97258fmr1582616qty.16.1691057871221; Thu, 03 Aug
 2023 03:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com> <20230803181225.v5.5.I6f3fb0734ef5ef746ae7c9b27f632f506197eb30@changeid>
In-Reply-To: <20230803181225.v5.5.I6f3fb0734ef5ef746ae7c9b27f632f506197eb30@changeid>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 3 Aug 2023 18:17:15 +0800
Message-ID: <CAKHBV27=9PJkWi8oJbhBbHYw1BLkdBKXEUyGSMcNmL9yN1-HPg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] iommu/arm-smmu-v3: Free pasid domains on iommu release
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com,
        jean-philippe@linaro.org, robin.murphy@arm.com, nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 6:14=E2=80=AFPM Michael Shavit <mshavit@google.com> =
wrote:
>
> The iommu core doesn't guarantee that pasid domains will be detached
> before the device is released.

I'm not certain whether this is possible or not. Is this change really
necessary?
