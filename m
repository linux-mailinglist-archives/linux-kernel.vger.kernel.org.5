Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFD477C6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjHOFGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjHOFFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:05:55 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E181980
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:05:28 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40a47e8e38dso115071cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692075928; x=1692680728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhwGPIQfuuKo3NNMbjP7kxl9NVjQk4SHNCBif9DoxSI=;
        b=Za459b0URO2IDkQkjP1F7f+tgXuFkwfyFEhSwJ9HXLHHOyI6fL5IJU0SpTtUkFEMLr
         XxfyJIj8lgzjtbryZgniTwPoe91JOIHZ7cttRlhX4FQp8+mGdy/jpvOzH/eKlEoRX1uE
         6o0Inb+WSyPTKS2nza4MsTkv7NStjZSp42FRESxz+zkLI3J6xW7vAb/pkVT23uxaWZ/i
         RGCFQggEvEniTCjcrdXpGM2m+M5YOMgApyLS2jSlTyhgbVNT9zPaEF61R7o4n3skqCMq
         7SPWgmlOnuAKqKjQoLBtP0N2SHGjxJuCbv+UlikO9R1XcR8OB7fvPs+g9iYQKDS8ThCj
         v86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692075928; x=1692680728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhwGPIQfuuKo3NNMbjP7kxl9NVjQk4SHNCBif9DoxSI=;
        b=VwgfBuosqR+QSgMAvfxRvLyatD5BKR775apgFSlaOA8UI8iimP/J46vS60PsnMv0MZ
         0xVQlonmDw27vPe8TKqdZU4i7lM5F2bddTKhFutC/ewxmrDHOTMBnozsaXmEYqUNG9ZS
         S7cPWQLm2/7Po3tvsVYy5qdJ981730X+UGqOLJGSauawobY3ZgWqCDLW09XosEpM7UuJ
         hmqA/fJCtiCmmSiYZKEFAxQD7oUroQrsdXJEeVMdDCiQ4Ekfff/XVFylniUdZpXjUoNN
         fSLc65lMgMZ0/Yox2bzC4rxR5NHVPTTWo7MXgyAw6QS4dtJ+7QKeHY8/HOXdev8kNIaO
         g5OA==
X-Gm-Message-State: AOJu0YylDJlDG/V4ixo8vCK6e4ZKdbWUj62Y7OuyDOURV/MQzF5rwg9O
        s4v3mxU/7Mmih07JKjHvRhclmmfHQaG5Psn+GrPNEQ==
X-Google-Smtp-Source: AGHT+IHnwvWbPv/kxcDDpMRDBg+QeL0+2NygibehL9WzHNY+3kg6opMG79eNUDV7b6rQ/6Lr44smm2jb/Y+g9aFKZ6w=
X-Received: by 2002:a05:622a:1b8c:b0:403:affb:3c03 with SMTP id
 bp12-20020a05622a1b8c00b00403affb3c03mr753428qtb.10.1692075927853; Mon, 14
 Aug 2023 22:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck> <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
In-Reply-To: <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Tue, 15 Aug 2023 13:04:43 +0800
Message-ID: <CAKHBV27iMDaU3RgJSVFva0UBmyKD8oJEtzDU7PJ4LuPGWAjCCA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
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

On Thu, Aug 10, 2023 at 5:15=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
> On Wed, Aug 9, 2023 at 9:50=E2=80=AFPM Will Deacon <will@kernel.org> wrot=
e:
> >
> > Since you're dropping this and relying on the lock being taken higher u=
p
> > callstack, can we add a lockdep assertion that we do actually hold the
> > devices_lock, please?
>
> Will do!

I spoke too soon; the point of this change was to remove the
dependency on the arm_smmu_domain, piping the devices_lock would
defeat this. In fact, this section is really depending on the iommu
group lock not the devices_lock.
