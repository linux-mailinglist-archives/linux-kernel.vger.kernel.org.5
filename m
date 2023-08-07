Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB9772BC2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjHGQ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHGQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:56:26 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A11FEF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:56:06 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56cb1e602e7so2903014eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427364; x=1692032164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beDZjbbalYWwbDGUsSO0v+/HXnqZi1/VnHtRYjuZ0+4=;
        b=ImEKUzqeclILDmZaS8k97ytV1RXVCtHxaRu78+G64qjDmsYGMdCsGnuKYHvq+eKBDz
         JARuVhSV6I+82gFCTfR1eABBvJ5MRn5GOcWLd1drDs8UWxvqiHl6XrPShrmRBXDQ0VUn
         pZFdPkHBJNm8fcVGikF5WkX0lfzDFzUBO4JrF/dfcVGrXOZ9YBlKejpaPIEXspki2v3I
         bqvsJjPS1mglT3eAS0Cowz4llRCrgSCMD92RJ7CKeo5XjCg1Rybg5xIP03i+7/k/2JuW
         9SBvKKZtM8tPW7gvSwlFMOCoGrERcF46HOKdwZhWGgD4p+z++ILb1B1lXfXpqcpHcqoV
         fzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427364; x=1692032164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beDZjbbalYWwbDGUsSO0v+/HXnqZi1/VnHtRYjuZ0+4=;
        b=BOL/tGwt07crN/770LhbSEgGVEYBHVa+n6PzbEcbN4lILwDBpkrG3yD9WfxqaIr9/1
         rCkzr6SJb4K/TV9+4i0Lk1voNd14X7LBQ+h3DDLiWhSMqL16JgcOYU0OfrUzyyfJ4Cj+
         ZFFD5zD+QeT6viRZbXrHxC7HgxTETmv5hP46IXuawexdV/AxSz9ZqdtLNnOWLT5R3KXo
         pt9jcBR9Cg/T/B9b0LVwdfV1WOtRxBkQzZUwnW4rlKB3ojuHy1ArVTsiDg5d7cnTfgWF
         GTBGg4G0xqpnfyt9ODc0n6/s0Qc5YyRSRDMt3IlN12+rDHK9O65l0OEQyHZ5H5bPQFOk
         i5xw==
X-Gm-Message-State: AOJu0YzCsbrFPXmU6bBA1GATIxOJl8zn/B+TW63e/9eA3utYqINIJz+R
        qxYgUhUkNCzM6b8M+4jQsARgl0ViDfD9ymuXCec=
X-Google-Smtp-Source: AGHT+IEEyUblZYFAAwzOj84xyYJw3B8tUHYDCflhQppSAMoFASjHBqtEATDPSLQoSXHKmZ9SEGxDWEl3xyBS3AtYPIM=
X-Received: by 2002:a4a:341e:0:b0:56c:d297:164c with SMTP id
 b30-20020a4a341e000000b0056cd297164cmr8800093ooa.4.1691427364148; Mon, 07 Aug
 2023 09:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230802012302.8498-1-sunran001@208suo.com>
In-Reply-To: <20230802012302.8498-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:55:53 -0400
Message-ID: <CADnq5_MwvypKA+B9FGwHE1BCKjJdRCrbRZbF+7_U7GxiHSFwAA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu71.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 9:23=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
> ERROR: space prohibited before open square bracket '['
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h | 22 +++++++-------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h b/drivers/gpu/d=
rm/amd/pm/powerplay/inc/smu71.h
> index 71c9b2d28640..b5f177412769 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu71.h
> @@ -118,8 +118,7 @@ typedef struct {
>
>  #endif
>
> -struct SMU71_PIDController
> -{
> +struct SMU71_PIDController {
>      uint32_t Ki;
>      int32_t LFWindupUpperLim;
>      int32_t LFWindupLowerLim;
> @@ -133,8 +132,7 @@ struct SMU71_PIDController
>
>  typedef struct SMU71_PIDController SMU71_PIDController;
>
> -struct SMU7_LocalDpmScoreboard
> -{
> +struct SMU7_LocalDpmScoreboard {
>      uint32_t PercentageBusy;
>
>      int32_t  PIDError;
> @@ -179,8 +177,8 @@ struct SMU7_LocalDpmScoreboard
>      uint8_t  DteClampMode;
>      uint8_t  FpsClampMode;
>
> -    uint16_t LevelResidencyCounters [SMU71_MAX_LEVELS_GRAPHICS];
> -    uint16_t LevelSwitchCounters [SMU71_MAX_LEVELS_GRAPHICS];
> +    uint16_t LevelResidencyCounters[SMU71_MAX_LEVELS_GRAPHICS];
> +    uint16_t LevelSwitchCounters[SMU71_MAX_LEVELS_GRAPHICS];
>
>      void     (*TargetStateCalculator)(uint8_t);
>      void     (*SavedTargetStateCalculator)(uint8_t);
> @@ -200,8 +198,7 @@ typedef struct SMU7_LocalDpmScoreboard SMU7_LocalDpmS=
coreboard;
>
>  #define SMU7_MAX_VOLTAGE_CLIENTS 12
>
> -struct SMU7_VoltageScoreboard
> -{
> +struct SMU7_VoltageScoreboard {
>      uint16_t CurrentVoltage;
>      uint16_t HighestVoltage;
>      uint16_t MaxVid;
> @@ -325,8 +322,7 @@ typedef struct SMU7_PowerScoreboard SMU7_PowerScorebo=
ard;
>
>  // ---------------------------------------------------------------------=
-----------------------------
>
> -struct SMU7_ThermalScoreboard
> -{
> +struct SMU7_ThermalScoreboard {
>     int16_t  GpuLimit;
>     int16_t  GpuHyst;
>     uint16_t CurrGnbTemp;
> @@ -360,8 +356,7 @@ typedef struct SMU7_ThermalScoreboard SMU7_ThermalSco=
reboard;
>  #define SMU7_VCE_SCLK_HANDSHAKE_DISABLE                  0x00020000
>
>  // All 'soft registers' should be uint32_t.
> -struct SMU71_SoftRegisters
> -{
> +struct SMU71_SoftRegisters {
>      uint32_t        RefClockFrequency;
>      uint32_t        PmTimerPeriod;
>      uint32_t        FeatureEnables;
> @@ -413,8 +408,7 @@ struct SMU71_SoftRegisters
>
>  typedef struct SMU71_SoftRegisters SMU71_SoftRegisters;
>
> -struct SMU71_Firmware_Header
> -{
> +struct SMU71_Firmware_Header {
>      uint32_t Digest[5];
>      uint32_t Version;
>      uint32_t HeaderSize;
> --
> 2.17.1
>
