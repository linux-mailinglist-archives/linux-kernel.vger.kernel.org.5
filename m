Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6646F7FF906
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346717AbjK3SE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjK3SEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:04:55 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D2010D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:05:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3316d09c645so1086982f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701367499; x=1701972299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6d9jPwSWN6yLTXx2alJGabuq1uAhjr4p52aUUSqzQY=;
        b=hynOf0zoKM+k6MEXIrdpc/GrWOCScOFVh5MNjgggP0MOeL0LH4UCRcbPg7rSeR5BGO
         fyKerwNrq3KZVKSBNSQUj726J03Zfq9/htBhNNiEdjP/1pYGw2cnvr6R3Vm4CoAazdSw
         tGyU8GOS9YW8x7Fj68VRuRQu1cqnKGbhgPEb9vjCq9Xn+MPwlRdbJ+LG4TF1WpQnJCco
         aBa7XWmmAiPjEUf8TuZD6o2QxyWCqN2VBg+2bunKNfTmVbetbmdnnWZHrM1X/A4bLXcG
         3CyOhCEJar+5gSRZ01hqWDlJFjIrHN7Lc/Ad459ljBoRMP44hzcNqX/Txvqgd4hKkLJL
         Gbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701367499; x=1701972299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6d9jPwSWN6yLTXx2alJGabuq1uAhjr4p52aUUSqzQY=;
        b=PZO3SaPApfYAyM4YCMscKNoiXDzpAdsGZinKnzs617iwYSeM+1oLjAUijsdufRxQI2
         //cHQB3hT2nauZ8QwQnRK71ohv1tPGm4sk9i+Y9p1SrAh/HusmrGxOBu6VfPhxmdxYPk
         KLMkSH19NhBYfbOVYgEHBzPVQvG1ug1VGziVslBSLZr7eHnkeraRgGBNER2CkuTcgNDR
         AECr8jvtsnjfKch/vxOWoxoSFYUADWjGAuCGLfDRDD/0PwUVZliCm1kog4K6hIjW6V3h
         hNoU5qmfgcfOKIHSxHEs5KvUzJgCIwzDLVrZlPCjkKWXEAIpPN1rqId3SkYp691M/lyf
         Fo6Q==
X-Gm-Message-State: AOJu0YwVeKR2v6ds0kq7SlYv9Ml2dWeyPOwZ0HSHovJADi9OoCDDMllK
        hwNLSdst/1sDNWn7BlxI+ZjE73WaKyFUuXBlzao7VXyRdQ==
X-Google-Smtp-Source: AGHT+IHLN6apI117jRKkfLFG90hZjLVUS6Mz4AAI0pfkS/prY+jJudjlOvU1vaJQpX2SAjCXtY+xahLXrBmUcjiXn8Y=
X-Received: by 2002:ac2:531b:0:b0:50b:d48a:4485 with SMTP id
 c27-20020ac2531b000000b0050bd48a4485mr2130lfh.57.1701365468422; Thu, 30 Nov
 2023 09:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20231120104152.13740-1-bp@alien8.de> <20231120104152.13740-2-bp@alien8.de>
 <dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com> <20231130171316.GLZWjCrHGHl+VVp724@fat_crate.local>
In-Reply-To: <20231130171316.GLZWjCrHGHl+VVp724@fat_crate.local>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 30 Nov 2023 12:30:57 -0500
Message-ID: <CAMzpN2j+4gUmUSghPjUDrQBLMn70FVT0cAAbZLkjk90y3L1jBQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] x86/CPU/AMD: Add ZenX generations flags
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:14=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Thu, Nov 30, 2023 at 11:05:14AM -0600, Tom Lendacky wrote:
> > Previously just being family 17h or 19h would get X86_FEATURE_ZEN set. =
With
> > this, if the model check doesn't match, you won't get any X86_FEATURE_Z=
EN*
> > set. Should you do set X86_FEATURE_ZEN here, e.g. lowest common denomin=
ator
> > for the family?
>
> My assumption/expectation is that those WARNs should never happen
> because they will be caught early enough in enablement and I will get
> patches.
>
> Besides, X86_FEATURE_ZEN means only Zen1 now.

It should be renamed to X86_FEATURE_ZEN1 for clarity.

Brian Gerst
