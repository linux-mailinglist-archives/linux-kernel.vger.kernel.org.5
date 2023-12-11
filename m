Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC680C4D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjLKJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjLKJim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:38:42 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6817E3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:38:48 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67a8a745c43so34207046d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702287528; x=1702892328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW9eC1zpvpO9BTLcIvV7ImAKmU6X1fHxDa/RAgBT+hE=;
        b=JLiLIPeMPeLmUsTeXopJCSZT1oJ35PfN4BVhaTwhxSn7svSQAAFgKHsldhQ3dNdVcM
         i/KfO/TLZPdT7vtTi4VA9G86rtIJBOEIUwqKTVmvL7SVSF9+m7wmxLRV4aF/C7FKc9t3
         vfG3AOc/iqUE2qSNbHrUbQaiJOPg+PzfJchlRavLgdAfoErUTRrXh4vy84VfXtsr8qOr
         qWtAGyywE2Q0edWblKXRV9lgVLHV/Hc1wuZWGTTvKWETDWvOnVjtVcmw1o2q6EMXB20X
         MaFw9PwAliECkzQxcY2BMc9BySa3CZHRk262Gzl0PoqX7LQnfkqn/wQc3fDpbmVDLZRx
         aLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287528; x=1702892328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bW9eC1zpvpO9BTLcIvV7ImAKmU6X1fHxDa/RAgBT+hE=;
        b=jlsnTSZpzvz7Z5O+SWGsqJ/rX7ThItYDlqEaZ01n53qjCoHHKvmRAOwBjXMvUG3IyM
         wpor1gg0SQaLRc6inlm+cEJpGWjyL5gqgupYpCZSNb4O+lABMMnO2Py9P6SqDST5JtDi
         LwmwP7/FOe2YZIoV8+kR/ojI9dKiDCD2d0BIflqzjf7BNSsZ6Ph7yLAT5tHSaG0i8Nhf
         TwGpm6Qax+h0CqPSBsmKvH4CPPr4pPf+fuA2Xe+ZGPaKs2eDSJVcg52MJwa/ZWI+AC9X
         +Jbvnx4am28hUU2oQSeYlq21YU2cpih8f2NWEIb6AdJN8CjZgPUQznhx6SHmprhjxvYy
         EX2g==
X-Gm-Message-State: AOJu0Yye/yNYzdjYGeDzirSVtoxCH4dDbXd8azWuTCVz48QYkPUJ2QGT
        Y8/mJRcKkAtavN5Pl7CAazlmFp9HsWHDUWpXlmyOjtCWxenLM8kzxuhDRg==
X-Google-Smtp-Source: AGHT+IFEx96QLt+QOJ3J9XTmw3Jt4QO1qBh4uujSOqXgAnzsaLWIfg4Ti0Dvocz9BQ9IP8RwVO3yObEVcsFDOZZjFiw=
X-Received: by 2002:ad4:44b1:0:b0:67a:b025:5fc8 with SMTP id
 n17-20020ad444b1000000b0067ab0255fc8mr6143892qvt.8.1702287527645; Mon, 11 Dec
 2023 01:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org> <20231209-b4-arm64-sysreg-additions-v1-13-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-13-45284e538474@kernel.org>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 11 Dec 2023 09:38:11 +0000
Message-ID: <CA+EHjTwcGzWHsLGeOyF-8dWhn5TXBeAq68YA3Cs57jgs8H-dvA@mail.gmail.com>
Subject: Re: [PATCH 13/13] arm64/sysreg: Add new system registers for GCS
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Mark,

On Sat, Dec 9, 2023 at 1:04=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> FEAT_GCS introduces a number of new system registers. Add the registers
> available up to EL2 to sysreg as per DDI0601 2022-12.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/tools/sysreg | 55 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 1c6d1c904750..b2007963523e 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1903,6 +1903,41 @@ Sysreg   SMCR_EL1        3       0       1       2=
       6
>  Fields SMCR_ELx
>  EndSysreg
>
> +SysregFields   GCSCR_ELx
> +Res0   63:10
> +Field  9       STREn
> +Field  8       PUSHMEn

This is related to my comment for patch 11/13 on HCRX_EL2, now we have
a case where the n is in the spec itself, rather than a prefix. Not
sure if it would be good to add an n as a prefix as well to these,
since they do trap at 0, or if you should just forget my comment on
patch 11 :)

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad



> +Res0   7
> +Field  6       EXLOCKEN
> +Field  5       RVCHKEN
> +Res0   4:1
> +Field  0       PCRSEL
> +EndSysregFields
> +
> +Sysreg GCSCR_EL1       3       0       2       5       0
> +Fields GCSCR_ELx
> +EndSysreg
> +
> +SysregFields   GCSPR_ELx
> +Field  63:3    PTR
> +Res0   2:0
> +EndSysregFields
> +
> +Sysreg GCSPR_EL1       3       0       2       5       1
> +Fields GCSPR_ELx
> +EndSysreg
> +
> +Sysreg GCSCRE0_EL1     3       0       2       5       2
> +Res0   63:11
> +Field  10      nTR
> +Field  9       STREn
> +Field  8       PUSHMEn
> +Res0   7:6
> +Field  5       RVCHKEN
> +Res0   4:1
> +Field  0       PCRSEL
> +EndSysreg
> +
>  Sysreg ALLINT  3       0       4       3       0
>  Res0   63:14
>  Field  13      ALLINT
> @@ -2133,6 +2168,10 @@ Field    4       DZP
>  Field  3:0     BS
>  EndSysreg
>
> +Sysreg GCSPR_EL0       3       3       2       5       1
> +Fields GCSPR_ELx
> +EndSysreg
> +
>  Sysreg SVCR    3       3       4       2       2
>  Res0   63:2
>  Field  1       ZA
> @@ -2531,6 +2570,14 @@ Sysreg   SMCR_EL2        3       4       1       2=
       6
>  Fields SMCR_ELx
>  EndSysreg
>
> +Sysreg GCSCR_EL2       3       4       2       5       0
> +Fields GCSCR_ELx
> +EndSysreg
> +
> +Sysreg GCSPR_EL2       3       4       2       5       1
> +Fields GCSPR_ELx
> +EndSysreg
> +
>  Sysreg DACR32_EL2      3       4       3       0       0
>  Res0   63:32
>  Field  31:30   D15
> @@ -2590,6 +2637,14 @@ Sysreg   SMCR_EL12       3       5       1       2=
       6
>  Fields SMCR_ELx
>  EndSysreg
>
> +Sysreg GCSCR_EL12      3       5       2       5       0
> +Fields GCSCR_ELx
> +EndSysreg
> +
> +Sysreg GCSPR_EL12      3       5       2       5       1
> +Fields GCSPR_ELx
> +EndSysreg
> +
>  Sysreg FAR_EL12        3       5       6       0       0
>  Field  63:0    ADDR
>  EndSysreg
>
> --
> 2.39.2
>
