Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9087FC93F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376416AbjK1WP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376356AbjK1WPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:15:22 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ABF1B4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:15:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-332d5c852a0so3837300f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701209726; x=1701814526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSuNbvFD94OG0oYk7b+7GOQt8DSjs2N76h+2PCSx+Vk=;
        b=NohylIsrBJkwAjoEL2hqa4tDzp2xvkI9It6wIjFbwVwg0DoPcXayX2z0VRG9vDm/gR
         xEj7xWtQdzd6uJzvXXNjpTCHYPqRx3Innl+SJuKivuMSvFmIutumMPVXJ8xnCzhQX/A0
         IibtGGbLji2aey2ooMPQoHLoWCrdB5Qv+C+bn4RrFHHmdrit7xeau3UHohVL6QNoAmo6
         orbJaGjACM9apdfvrrE7mPrQo9Qj1h+bt36n3pBsguRiFqH7jjv8DJqWD3tg3ru6ObBx
         L3Mp6PVI9/5eX23r3ko6yqycVVyAV0QWe9H2yvpLe7OSHtxF0HfHgoaLAUf7S2MBONDz
         5VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701209726; x=1701814526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSuNbvFD94OG0oYk7b+7GOQt8DSjs2N76h+2PCSx+Vk=;
        b=iRVfCARMmcyI32sYVytpgpG5Hs8JIzmR/O4YVR+IRZIzoyPA2mktjew/zxkkj5Y9Ou
         lRwz+87uYPVnuMlzW82ATfgcnIWpKQREByshp0WckC3K2q2iA7FqG2aIysxSiM+9ntGf
         4QUKJ3yrftaGozIWD9CKfz6ctMr6cmKkGgOvCukknBhc9czMQBGEKhVFUD+COCg7BL80
         Jz3mWUDIUTvXWoWmHp5qM3vwaybRTDBCINuDzOw2s0awwFN7sBLNEDvSrkT3oZCZMxmj
         UlatPf3f8zt4YU3odl2WhoMBBuVHXMsolvD7nQI3bFyPbZ59QAMOxM4LMYVjJ4+A6Gto
         JVlg==
X-Gm-Message-State: AOJu0YzsSF1w3iWr2QBGvGZPkpDvVB6lHMXPeCZ8jv655dk+P833TGpr
        z2Zbnv1Wmuvwiy3ah9VBysrRu1/YMfp3ho2SOPo1RRgEtLEl/LCL869sPQ==
X-Google-Smtp-Source: AGHT+IFo5eMmUryvfDv0/Q2qmj29tK13SPoJ88ZCN7SRG/AW2iXQbMaREJXoDrOMgFKBOpSfgKWAiAma00T6FBnfSbI=
X-Received: by 2002:a05:6000:1962:b0:333:13d:16d6 with SMTP id
 da2-20020a056000196200b00333013d16d6mr4891352wrb.34.1701209726456; Tue, 28
 Nov 2023 14:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20231127220047.2199234-1-royluo@google.com> <2023112827-repent-broadband-e557@gregkh>
 <CA+zupgxfxaB_bO51ZXW+5T3-FMF94=Tm+mqZ92LCYBZtwiQd3A@mail.gmail.com> <2023112835-sediment-subsidy-7e99@gregkh>
In-Reply-To: <2023112835-sediment-subsidy-7e99@gregkh>
From:   Roy Luo <royluo@google.com>
Date:   Tue, 28 Nov 2023 14:14:50 -0800
Message-ID: <CA+zupgzbt17nRxLPpaQVpv7LJyVJjGFEHKMQN28amUD0Cr3zhw@mail.gmail.com>
Subject: Re: [PATCH v2] USB: gadget: core: adjust uevent timing on gadget unbind
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, badhri@google.com,
        quic_kriskura@quicinc.com, francesco.dolcini@toradex.com,
        quic_eserrao@quicinc.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 11:01=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> If you think this fixes a bug in the existing code, why wouldn't it be
> needed?
>
> Also, this implies that you will not be wanting it backported to any
> chromeos or android kernels?

Maybe I didn't get the criterias in
Documentation/process/stable-kernel-rules.rst right, and yes, I do
want to backport it to android kernels.
Anyway, I'm sending a new patch with Cc: stable@vger.kernel.org

Thanks,
Roy
