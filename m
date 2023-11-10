Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6137E7E98
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjKJRqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjKJRpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:45:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B27EF8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:54:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so2709816a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1699599258; x=1700204058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmi+Ckwu6O18+Q2KnA1YMX6KRmhCQb+yV/WW9qhuH6w=;
        b=WFVkCBzpww4pC3E5jmuP3ABfTSZjwCs/KY3UDU/bmRo0xZG5X/S03rsysUxLw0m5/v
         i87UEumxp//8gU6d1GvS2bI7Q9yGiAsqqItp9OBDVXpCM59Ku2SDRucMyc9X5k37GYuh
         AWDsDAb58szrKJeO+p0jWFIyD8LVPyKcPwOXB7qYvkehwLrjXSv1lDbZspFHTPXVhGQi
         EK0o0rz85lggO9JgvsZN6XzVxQMoEBRfeluAEb72vVpHTWR3gUZVm//CaA1Ppj3lxqzs
         zlcuveQHUSypvk8YZM228G+w1w6e2UwDgBrRTx43WYGVWm/ZZSEkZg51QUinYlrPTWr/
         zuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699599258; x=1700204058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmi+Ckwu6O18+Q2KnA1YMX6KRmhCQb+yV/WW9qhuH6w=;
        b=IsSm6UH4i/xj0cBfJr7XhjjifBlUfuImrPO7ifLoVaLkkSVH8UX23zNB9OeQAaTHIz
         X94PHgu5iIU/dOqfhscWqRTiTOihuSSKmC40grOGzZHdqc2azFuGj/6qi8SsrMNVDJiv
         pgr2AvEkpgCaIcSn58WBWk2/29PV0whxbaNWUykN+bhBxhLVKSBGcQldgU8m2eeQxjSF
         8oFwbL6RwMWCY6dxpg8AKegDOYJI6UWM64xwYDgAvB6DE3IvjhNfSrPRA5HMGKedqM1V
         Ri/pLDKcTtsJuW7XL1fQy6hB895/XnWxu13smWnSrny2KA+SK0RCgOGrpxi3ZOpBehMQ
         ycIw==
X-Gm-Message-State: AOJu0YySbxr0PX98yEqcaeFZrTMpwyIP/dUcDfv76UPxIOTLIZTdtpZP
        DXiN+Fa2bz8sPP4jk+LyFQsa0HvM1eohbSn0yf1WAg==
X-Google-Smtp-Source: AGHT+IFgg5UMeRs3kcPYSsskdYLDKVicMfj7fvfD8PWlyTapiaUXT1r0RAnUvrhJoocQ0eqXrNYvIy4lsxHHfQ6NlWM=
X-Received: by 2002:a50:9eeb:0:b0:53f:a377:7287 with SMTP id
 a98-20020a509eeb000000b0053fa3777287mr5446010edf.18.1699599258586; Thu, 09
 Nov 2023 22:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20231108105639.70088-1-haifeng.xu@shopee.com> <6da49b39-653a-1eda-2d21-1f1b50cb14f0@redhat.com>
 <5086cd5b-a832-4250-9927-4b300d2f611e@shopee.com>
In-Reply-To: <5086cd5b-a832-4250-9927-4b300d2f611e@shopee.com>
From:   Tang Yizhou <yizhou.tang@shopee.com>
Date:   Fri, 10 Nov 2023 14:54:07 +0800
Message-ID: <CACuPKxnSKQuyWWCtjmmNWP0apja28jWpdYWaKWouArsQA02axQ@mail.gmail.com>
Subject: Re: [PATCH] locking/rwsem: Remove unnessary check in rwsem_down_read_slowpath()
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     Waiman Long <longman@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 11:17=E2=80=AFAM Haifeng Xu <haifeng.xu@shopee.com> =
wrote:
>
> reader          writer                                  reader
>
> acquire
> release
>                 rwsem_write_trylock
>                         set RWSEM_WRITER_LOCKED
>                                                         rwsem_down_read_s=
lowpath
>                         set owner
>
> If prev lock holder is a reader, when it releases the lock, the owner isn=
't cleared(CONFIG_DEBUG_RWSEMS isn't enabled).
> A writer comes and can set the RWSEM_WRITER_LOCKED bit succsessfully, the=
n a new reader run into slow path, before
> the writer set the owner, the new reader will see that both the RWSEM_REA=
DER_OWNED bit and RWSEM_WRITER_LOCKED bit are
> set.
>

For the above example, it won't cause a problem. When the writer
successfully sets RWSEM_WRITER_LOCKED, the reader, when reading rcnt
through rwsem_down_read_slowpath(), will see that rcnt is 0 and will
jump to the queue label.

Thanks,
Tang
