Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D487E3B64
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjKGMAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjKGMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:00:37 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9BEF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 04:00:34 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso74065291fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 04:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dberlin.org; s=google; t=1699358432; x=1699963232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L95ez5A4n9QHf1D8VLYBAIlRuv3kU+vYgZcEfG+m+f4=;
        b=lOHStBwvEJW/z9lR+usVjaJwFjbKsBNT5YH3AI8Bd6yS1lFO9RRCoF6C8NsphzZnb5
         PjNUCDFvhhPI+kM0sJb63IhXbhu9Kmy397qvLf02GbxfxZpC1pixR+WP0noqI7PoDAAR
         6dcOkgCf7a5h4qgxVXxz1GCwKDwl9cJaThMNv+6iKK1xfkQ4n7T69qWNsuaFcAAvZdEB
         S0I/ALf0dne41uRw3uu3ITV9XaRUs65VKg826aszuq8uAYrgFrXONdASJKeSvHrB4xI4
         BZEhTNcpGysOXNmu+ZsXYTZEP5Kkw8YHjzhA4C4BayOrgYXOkhXnLanebAfxNV4uy2YV
         eKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699358432; x=1699963232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L95ez5A4n9QHf1D8VLYBAIlRuv3kU+vYgZcEfG+m+f4=;
        b=q3cW1adWw7ZLHcapZFgbNWIhX7rCSWt2Pv1uydhzU1eSrpaRK6WKczzV86sb1073Mw
         yykJ+Ns0ho3UAzSpyksx3zxDLcx+B98hUzq0CiTMIcNVOdvYshv6jtiG8gMJ8o54xi52
         s1OLjNdzlkyIERrS1CImriDhs7hBMYAbiQbEsXEioeZ+BsyudUa3CJnAwRTZnIB+D8Ts
         z1s93ZhRDP1JSYWzQZWGM1ePpxh4D0O4jWkcM3JKp+gFI3G5GYNPKY3sXuV8jqrXC7xu
         GPGTQrR3IQ2I3B5o3BzhsvhQcnyztJn11c2H+vxwYWEgfLliU7GNjm8Zn2ziaIGENImw
         Nvwg==
X-Gm-Message-State: AOJu0YyM7FWqy+470Ii8i8nAD1CWUvJJMgYojIUJWd02y/Wl+VIcw+/H
        rDLvcSvFEBHxRsrzWUqTKRIsHZQKDyF3W7iwez3Vhg==
X-Google-Smtp-Source: AGHT+IG5rc7x9o0jJVh9h79Tb60MT+HTw/cZ7zSVnENop7Wm/YFTjOPuq/2DhQ6u9VwRPMoXmiI0kTH8nEuQhrsVpLM=
X-Received: by 2002:a2e:8684:0:b0:2c6:f945:d95a with SMTP id
 l4-20020a2e8684000000b002c6f945d95amr9578220lji.36.1699358431957; Tue, 07 Nov
 2023 04:00:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1697650207.git.dberlin@dberlin.org> <079882bf4a7c026547ecf8ad50a2b7a49ade7130.1697650207.git.dberlin@dberlin.org>
 <b907f696-c966-54ef-3267-12833c6f5d91@broadcom.com> <26a081e6-032a-b58d-851c-eaac745e7c87@marcan.st>
 <25e43cd3-45e6-d775-87c4-9ed7cdfe3e2d@broadcom.com>
In-Reply-To: <25e43cd3-45e6-d775-87c4-9ed7cdfe3e2d@broadcom.com>
From:   Daniel Berlin <dberlin@dberlin.org>
Date:   Tue, 7 Nov 2023 07:00:20 -0500
Message-ID: <CAF4BwTV=S39mUcbhoxCf6Z6+gGGFy5ctfYwbKt5yDMUYD5r3gw@mail.gmail.com>
Subject: Re: [PATCH 4/5] wifi: brcmfmac: Support bss_info up to v112
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Hector Martin <marcan@marcan.st>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 6:51=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 11/7/2023 12:11 PM, Hector Martin wrote:
> > On 20/10/2023 18.59, Arend van Spriel wrote:
> >> On 10/19/2023 3:42 AM, Daniel Berlin wrote:
> >>> From: Hector Martin <marcan@marcan.st>
> >>>
> >>> The structures are compatible and just add fields, so we can just tre=
at
> >>> it as always v112. If we start using new fields, that will have to be
> >>> gated on the version.
> >>
> >> Seems EHT is creeping in here.
> >>
> >> Having doubts about compatibility statement (see below)...
> >>
> >>> Signed-off-by: Hector Martin <marcan@marcan.st>
> >>> ---
> >>>    .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  5 ++-
> >>>    .../broadcom/brcm80211/brcmfmac/fwil_types.h  | 37 +++++++++++++++=
++--
> >>>    2 files changed, 36 insertions(+), 6 deletions(-)
> >>>
>
> [...]
>
> >>> @@ -323,28 +324,56 @@ struct brcmf_bss_info_le {
> >>>     __le16 capability;      /* Capability information */
> >>>     u8 SSID_len;
> >>>     u8 SSID[32];
> >>> +   u8 bcnflags;            /* additional flags w.r.t. beacon */
> >>
> >> Ehm. Coming back to your statement "structures are compatible and just
> >> add fields". How are they compatible? You now treat v109 struct as v11=
2
> >> so fields below are shifted because of bcnflags. So you read invalid
> >> information. This does not fly or I am missing something here.
> >
> > bcmflags was previously an implied padding byte. If you actually check
> > the offsets of the subsequent fields, you'll see they haven't changed.
> > In fact this was added at some point in the past and just missing here,
> > and is a general case of "padding bytes were not explicitly specified"
> > which is arguably an anti-pattern and should never have been the case.
>
> Yeah. Let's not argue ;-) I did miss something here and leave it with
> that. What about the EHT stuff? I would prefer to keep it out unless
> full EHT support is added.

The EHT stuff you flagged (defines, etc) in the other patches can be
left out - this one can't since it is definitionally part of the v112
struct.
