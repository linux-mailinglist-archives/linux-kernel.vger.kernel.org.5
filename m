Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502487E4D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344595AbjKGX1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjKGX0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:26:50 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C232D71
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:24:43 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d00415a92so6876606d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 15:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699399482; x=1700004282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlH3yDHH8VWiFHnu4y1ED06RXF9ED0I+ELE6Udjp544=;
        b=FkAU1OfO61MwzNiTE9DY1OG26wLHZwtikTLq217fhiY4FMaver2eQyKp+zIzMovtZe
         6aE8SxLFf4820yikQP33WS2EiAodjhJpETBk391erb/RLjbtEXU8u5S3Dz6iN8oWM3xw
         nflqXSrEGs/OXnuSQBYIrHEm0CJaEh2pLDwFLhajZzlP7sCj5ZIMMvp0MlNzZRXC29fu
         JqW+gURKQLr/MctyuoLGeEjsACBOoUQizUYA7Eupu1UqsxQ90EioE/okDCaU7iDqAOpb
         CCBgZ2O7kyLJYCEnLJP0lUn5kO5cBFvHo1wj+wwEpz7S4Aavgi6pLpIl2lNdMqFwDZWh
         OPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699399482; x=1700004282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlH3yDHH8VWiFHnu4y1ED06RXF9ED0I+ELE6Udjp544=;
        b=UOpvBv91ctBnFpotwkLFXDNaRHfTl8UUMKobtTrk5xBaX2o5RdwIo7t1zg0sXwCyEP
         ImjGKN60Se0PCjvBqL+5J3ekmhlO0HrvatWgH0HVfC3BwyjGWz1katnyKaqGPmBqhEvF
         f6O4Obr31EEAJYAv8cMY4FMwcCUSCwPxVRU4Q1CIXDlYv3bi5DIEI6h+WlhOVl190L5q
         cLwBe4soTP+asc5sFyh1C1xvFaVMg37rJBN1m/zzvkuYXH6+atW0ZR+IKu4LoGrzs3xh
         Qy0Z+2eN/uVdE7MM9M5pbrQFsJBIT8oxCI+zMOo4PeH4B+t/SMKBym7Blx6/Oh5TR20M
         nJ/A==
X-Gm-Message-State: AOJu0YwlprjNhfamrv1elBH4tvJJ6REdRxhby/TFkGyV/QNlJKfYYBFF
        zpZjOnLB13mruSG62HtkEpMM5QK8M1aTaQei8o8=
X-Google-Smtp-Source: AGHT+IFzKOfsxUAOyTg4/B2c2+FRm2EghLOHHC6yIj5u4gceOSiG2NGcXwnnyvJ1a+etNcEqJQcS0E/2GW5KCMNNzcE=
X-Received: by 2002:a0c:ee6c:0:b0:671:1408:d46e with SMTP id
 n12-20020a0cee6c000000b006711408d46emr293062qvs.0.1699399482480; Tue, 07 Nov
 2023 15:24:42 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNsDLvZR8RGf9ji5938QreSix89FCpGHju+9in2x6OfDw@mail.gmail.com>
 <CADnq5_ObMvxN4pFAsWU7OM3SAtYCNHKE_fHsLqizGm0p1ubp=w@mail.gmail.com>
 <CABXGCsPXp_pWZcyVQajYSTZKeViRqjfXK2=jmuRXh0yug_OoWQ@mail.gmail.com> <CADnq5_ND_aBmsD3X=tx2==EM7VOz4EBwid4hRVZ79mbi6bWq1w@mail.gmail.com>
In-Reply-To: <CADnq5_ND_aBmsD3X=tx2==EM7VOz4EBwid4hRVZ79mbi6bWq1w@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 8 Nov 2023 04:24:31 +0500
Message-ID: <CABXGCsOn2a9vZj_1yET96mum=wjGmer6tHG=XgToS76L9ihdUg@mail.gmail.com>
Subject: Re: 6.7/regression/KASAN: null-ptr-deref in amdgpu_ras_reset_error_count+0x2d6
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 12:12=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> The attached patch should fix it.  Not sure why your GPU shows up as
> busy.  The AGP aperture was just disabled.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Thanks, after applying the patch GPU loading meets expectations.
Games are working so overall all looking good for now.

--=20
Best Regards,
Mike Gavrilov.
