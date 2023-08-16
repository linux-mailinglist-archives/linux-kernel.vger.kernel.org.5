Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4177EBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346555AbjHPVhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346558AbjHPVhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:37:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069CEDC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:37:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so4634a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692221829; x=1692826629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuS/h2vqI/TNPK9231HrTTQYLYSfNx8VEdjhqDSvM3I=;
        b=helse5TTvzZY/qTqKQTbEcpAcGKVIMSS+veWN85WXQrNlm0siGnScoCzZD8MCsfECD
         QRihKUKeWHsfQOiwE7tw4K5WXklYPEvemLJRonlY9rOTUM4asY1XTTJLHUfmM+X/9uP0
         DtiOoLukejrn0fRTSEqBLlrK3Qc3TRXlxrUPe9PJH1uOZ3eAHeSAdYdC6j1z7HGes60Q
         687SyPBO5UmoiCTaTl7OwfNMfMVIE3TQKQPWUOC/UtiHM3/idR9wIXXZGyuYGMVhJ3sJ
         KYnqYhs1WMpyGkC3Hd/l9VKbAhdzEc6L3xP0G2YLesEfmsU3SjFzU/32QfUxWGbfjXqO
         zLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692221829; x=1692826629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuS/h2vqI/TNPK9231HrTTQYLYSfNx8VEdjhqDSvM3I=;
        b=C6qI6kylyp3MdH3sDihPCZ4fDtjDZbHKOzf5+G3aEEliuggJQpjGbkqLV3iLxsloxw
         sQ4gicJaSAyfue0g9RtJG+Bj5emvAYbZkhBrNYRSed2huWWN6FnZ5cpYLsP5MzOjyY47
         CfHor9QmzcLZKCi7BO757Mmg2DawNiuYtVtmL6aGiMjuaTSk2wK4Kvuh+JqTytHK9m7A
         31A5ifDcip/tJu838vdLNqp56Lbb2QAuD0T7EVhxrECQTHDtdxqW0v9zCzYiCJ/PPLpc
         Lotc0KZJkHVFr4q+6znmuvEQuGrEergasxG1trYsWathPx8W+XXmBwvDBy5a3bEF5gZm
         6BKw==
X-Gm-Message-State: AOJu0Ywj7fhP4tS4C7AcQJ1qSyoBi/xeZpW2A75+6XSGsCc0PDdvDCw3
        lPBz/Z3FeEoQlKgRSc6WyfkNXJBrcaAAJsZjxLClQjD549eZiTvpXsg=
X-Google-Smtp-Source: AGHT+IFLzRtJKBX8YjOUOQM+tpZWRF1Q+hVPwQ6nUbKCf8DPEnAyUtLixog8aRzSs9I/KwfH16HW7TOFPbSEzOxVvp0=
X-Received: by 2002:a50:a45b:0:b0:523:bdc9:48a9 with SMTP id
 v27-20020a50a45b000000b00523bdc948a9mr36864edb.0.1692221829436; Wed, 16 Aug
 2023 14:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
 <20230816201700.589822-1-jmattson@google.com> <20230816211821.GUZN09HTGo+yQ2+jd7@fat_crate.local>
 <CALMp9eR1Ub78MZwdZn178d4OXPu3Au=faBgVGe6ty6ARV+nK8g@mail.gmail.com> <20230816213025.GVZN0/8cjvLebNANTq@fat_crate.local>
In-Reply-To: <20230816213025.GVZN0/8cjvLebNANTq@fat_crate.local>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 16 Aug 2023 14:36:57 -0700
Message-ID: <CALMp9eRT4xCrK3Up_1bQuBZNd_2ZKLFqgamvP4BtA+HuC1driQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
To:     Borislav Petkov <bp@alien8.de>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, x86@kernel.org
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

On Wed, Aug 16, 2023 at 2:30=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Wed, Aug 16, 2023 at 02:23:52PM -0700, Jim Mattson wrote:
> > Specifically, "Security Version Numbers (SVNs) of the currently
> > executing platform firmware and microcode."
>
> Yes, I know the microcode revision is part of the attestation.
>
> What exactly are you asking?
>
> If you don't state your question, how do you expect me to answer?

Doesn't this render that attestation misleading, since the microcode
patch may not have been loaded on all logical processors?

--
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
