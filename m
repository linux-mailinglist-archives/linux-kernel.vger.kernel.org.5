Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A680F778021
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjHJSUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjHJSUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:20:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E702123
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:20:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686bc261111so927875b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691691652; x=1692296452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a92NBeJNU7kmNJxtb6OxiUYppen1ETPcAG+MO1xgGG8=;
        b=Yfn3GdIvCwu2oEr/UdGSalfoJE76m9VGVWRUPpvJWnMx4rafovziTfk+ZFJ3xu6rIh
         /YuUMm6n0YNcztvyDek/olgJAfjTMwfss5mycHlsNUq4t5RBCssIg50ZtAO/yv7kvEHb
         0fqPDOV9LdJhufu2nExnkrUjMa/fhSS8OgrO4EeDUENbENeQwBb1mZQnG8IncbjYffnE
         fSpRCBsk5G478/eI+M1xCmC2UKD4rFtFgBC7hG3lRblDlmn75hOu2ESLkn/k2wxdP+fm
         hP4wt+q4NA13fea/zBz1AN+4G79PnOf8kPuyCASnelWWU/ADVHfXVk3fQHAK66MAJ7FH
         Q7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691691652; x=1692296452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a92NBeJNU7kmNJxtb6OxiUYppen1ETPcAG+MO1xgGG8=;
        b=dhQXl/ZAtm/5/RdyxucNzT8ag7EIHUqSNclb9WTvJaNxic1c4xfkuVB0B1WBT9/J3A
         T2/IUSSz8QKRdEx8EuE6rsJK992GgyaxNiL3Mlr29r2op7P4ujr99ZsX1+wS+znav0e7
         cm00A94yMYxOIgdsoR3EVijO8rewPmXEmI0eQFYLIXtoSd/Hju3Mi8gNU4DpGNIGqiwU
         +Ggb9bLL1xURhtuKS6rtupgk/cFdSh9fhWknXEqMmKH4DAPXYtZWQoo2v95TxwqVJRsg
         Xq5hfglZyrOLvX76HR/raSlW1q8mANZ84WSsMx5DiXKl+n5uGva+fdSZvX/9Wb/NtuAc
         aZdw==
X-Gm-Message-State: AOJu0YwIeUF9JPp6Ln9HEJuplpDyeyRbpUjf5GBWR/KZ3istpLqbZrYS
        IOSLrW01Jr25DF5moMjh8vVf8BM1kJr8E0jEzx+optJy/3LlM216RN8B8Q==
X-Google-Smtp-Source: AGHT+IF/11sgXt4jPq8ZgakJoFsFCLSUEZHUnWjift/2DZe4VQ1NGIh/RCBkVITu8qUtWOSUuQQypF/G7+VleZ6kXgg=
X-Received: by 2002:a05:6a00:130b:b0:686:2668:796f with SMTP id
 j11-20020a056a00130b00b006862668796fmr3808106pfu.32.1691691652250; Thu, 10
 Aug 2023 11:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103642.552405807@linuxfoundation.org>
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 10 Aug 2023 12:20:40 -0600
Message-ID: <CAEUSe7-etoOT0ox2byNnKwmLaFQAE4j5dWnO2G2T_JuRHgr_3g@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/204] 4.14.322-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, lyude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 9 Aug 2023 at 05:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.322 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.322-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 4.14.322-rc1
[...]
> Lyude Paul <lyude@redhat.com>
>     drm/edid: Fix uninitialized variable in drm_cvt_modes()
[...]

Two new warnings are introduced on x86_64 with GCC-8 (defconfig):

  drivers/gpu/drm/drm_edid.o: warning: objtool:
drm_mode_std.isra.30()+0x98: return with modified stack frame
  drivers/gpu/drm/drm_edid.o: warning: objtool:
drm_mode_std.isra.30()+0x0: stack state mismatch: cfa1=3D7+104 cfa2=3D7+8

Bisection points to the quoted commit ("drm/edid: Fix uninitialized
variable in drm_cvt_modes()"), 991fcb77f490 upstream.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
