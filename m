Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61021797B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343713AbjIGSR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343872AbjIGSRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:17:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B7C1739
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:17:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c3c8adb27so153104366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694110639; x=1694715439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDPtIqRa9KhP+Q4GO0CUVTyJACCkZW6CDP5L78rGp/8=;
        b=CRO78rZP0W+O3ZB94RaO58PLoBnJw2u03Rdp9VCRtGFe3v3Nno64teEAZ4vdeCZ5xT
         stPX6cpw8V/ElI0bFYEA6A+OECkWEP0Kj7Vfm2599v4985XeceTAAERmAXR+KfLxyWdT
         NqJFDr7UCFbIZiGGSIWhnV/UM5RHKagcDFV8vo7+mGldgKAI/yzkwMXUb72CJs5UeI/T
         ZpHu+Ws5IApWIbbxNpGgDfkWkFZT70RMn9V5zPxSGT3yO6c0Xo6vnQ5QUuvSdnfHN+kB
         zS6p6y5vnVvDyRDLt8474aZaKJSBFep9Y7g0rrDO1Kl2R7iSMe6ZQClIt24ma/dR0X8x
         kyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694110639; x=1694715439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDPtIqRa9KhP+Q4GO0CUVTyJACCkZW6CDP5L78rGp/8=;
        b=GExV24DtcjuYGF9sTiiTU/HQ2oBFaLfsa5LIAroP2daN56u7J6Eh0KKcuSgsQLTgyh
         5zSU6oZGU0jYsNJ1XVyJZWZitnFi7IIifcR7MNkfujxj6gTDL/OjcKGt/w3VjyiyKK3m
         +R6BahMpG3AV5PWixLo4pUV2h3pDD6G5yvYEceDnCXKsxLPX64bDPcqdn4825fMAmoud
         Qw+6PMmH2wYcA3hf1C9OHndGVxUtjFfFM9e69dYrHQJaKCiM+bEITyq76aypBLH0ZzRH
         405n6vaqoDIvgTMqEP3V76TiutCMfWTzdB8ykomamwqW3t8Y0jy/NjuP/EHH1+ZyGVbj
         l8VQ==
X-Gm-Message-State: AOJu0YyQNU0O19bEsVbIumNnR+rbbu9CPxMCNHpt1NH1Q+4MGdbCZpiV
        dzrEJtLPXlw4m9yEWz1RCrRGDp8OrPhrsBIJkKOKlA==
X-Google-Smtp-Source: AGHT+IFG1xSKke0CRIQjuPuE+RTs8E4Z46EDtLFpNt/QqqoWQcSA8uhvKIJ7x4JGRAP/N6MiFolen7PkHPuoysGq2pw=
X-Received: by 2002:a17:906:10dc:b0:9a2:eb6e:2cf1 with SMTP id
 v28-20020a17090610dc00b009a2eb6e2cf1mr139764ejv.5.1694110639377; Thu, 07 Sep
 2023 11:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230905-strncpy-arch-arm64-v4-1-bc4b14ddfaef@google.com> <f08f590a-df05-4d83-984f-41b4d60af971@kernel.org>
In-Reply-To: <f08f590a-df05-4d83-984f-41b4d60af971@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 7 Sep 2023 11:17:08 -0700
Message-ID: <CAFhGd8pMeTuvn_OqzYtRbfAM7L_-Jb_hFA4WY0hMap_eG=F7RA@mail.gmail.com>
Subject: Re: [PATCH v4] arm64/sysreg: refactor deprecated strncpy
To:     Konrad Dybcio <konradybcio@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mostafa Saleh <smostafa@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
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

On Thu, Sep 7, 2023 at 10:37=E2=80=AFAM Konrad Dybcio <konradybcio@kernel.o=
rg> wrote:
>
>
>
> On 5.09.2023 22:10, Justin Stitt wrote:
> > strncpy is deprecated [1] and should not be used if the src string is
> > not NUL-terminated.
> >
> > When dealing with `cmdline` we are counting the number of characters
> > until a space then copying these over into `buf`. Let's not use any of
> > the str*() functions since the src string is not necessarily NUL-termin=
ated.
> >
> > Prefer `memcpy()` alongside a forced NUL-termination as it more
> > accurately describes what is going on within this function, i.e: copyin=
g
> > from non NUL-terminated buffer into a NUL-terminated buffer.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> Hi,
>
> some form of this patch [1] went into -next and it broke booting
> on at least the Qualcomm SC8280XP-based Lenovo Thinkpad X13S.
>

Thanks for the heads up! The previous versions of the patch (including
the one that was applied) had some errors. This patch should be good
and Will is looking to apply it to arm64 fixes tree.

> Konrad
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?h=3Dd232606773a0b09ec7f1ffc25f63abe801d011fd
