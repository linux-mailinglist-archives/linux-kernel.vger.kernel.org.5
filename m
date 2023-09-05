Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A667930D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243904AbjIEVOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjIEVOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:14:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6CBBD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:14:27 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9936b3d0286so461220566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693948465; x=1694553265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKF3gb3bcI5KLidfb/rm+VBeJ3AWNKTfuggzgnt4FSc=;
        b=lxZYhYt9tYmE/qjyv1ZZMNGI55RElJIszhOrC4/7ash7VDOPYAf5mgef/uolDbvF6S
         3J8FSfqsuKkjyxo2dvLehtBbFyOnx9Zpf1q3L65n5MtADnfCXfikp/Ltknawa4ZL4Sw+
         0dP7anY+6zKnApKVlWwjnDbr8jgsTHBMrqQ7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693948465; x=1694553265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKF3gb3bcI5KLidfb/rm+VBeJ3AWNKTfuggzgnt4FSc=;
        b=KVmq+fZaY45ylZ+oG+R/wriG9Pt+HXPrvN++LsrdtdaJN8Ozab8qvbNGY0LUQokmvc
         rvMm7X4MkFe1BDDw7hE/+ltUOSw+ufm/wQzYGtQX+Wh5hvUb42PSEp/xXaf+Pi9dWBOQ
         3CO6mOCF2ZZYRHjbONVH6PYrqkMQr8aSqQW32YQQU2YUAU1MTtQ2o+yphWia3xiohJVJ
         byiwqs/wvuE6tOYgEIlQXW/uBBcyY6eMB4UZ0kEQ+5KFCeEYS4EWtiBT8soc86NDbsgv
         HCwOn2zue6tFxVs2ocF077h9U3zBPrpoDXybP76OE8gZO9rh2dYBLsu8Xi0LLMBRHBWI
         SpZA==
X-Gm-Message-State: AOJu0Yxwujj2+lbwz/3C8S0hDNO+JENo3oYbT50IVZ01TMnqAuS7uhZe
        g3/+ZuBFYjaayxuC5TE8llLaDxxlEbe+v+ajUPuWzSu3
X-Google-Smtp-Source: AGHT+IHHYI9XOphJv8Lz4dIRMmXHfhjv9jfsF1XKHg0ngxsJw63Bk1IWitPJick/7cFqIK9sBv74/w==
X-Received: by 2002:a17:906:18:b0:9a1:b967:aca7 with SMTP id 24-20020a170906001800b009a1b967aca7mr729992eja.42.1693948464856;
        Tue, 05 Sep 2023 14:14:24 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id q6-20020a170906940600b0098e78ff1a87sm8032664ejx.120.2023.09.05.14.14.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 14:14:24 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so5036a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 14:14:24 -0700 (PDT)
X-Received: by 2002:a50:d002:0:b0:522:4741:d992 with SMTP id
 j2-20020a50d002000000b005224741d992mr49434edf.4.1693948463930; Tue, 05 Sep
 2023 14:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230901163944.RFT.1.I906acd535bece03b6671d97c2826c6f0444f4728@changeid>
 <4b3a93c9ab2432f8ae0e9282d9e00d2a.mripard@kernel.org>
In-Reply-To: <4b3a93c9ab2432f8ae0e9282d9e00d2a.mripard@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Sep 2023 14:14:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VO_AxBuJya_Rea2xHJ3NMR7RL2+YV3VTMUXAwsnTkJew@mail.gmail.com>
Message-ID: <CAD=FV=VO_AxBuJya_Rea2xHJ3NMR7RL2+YV3VTMUXAwsnTkJew@mail.gmail.com>
Subject: Re: [RFT PATCH 1/6] drm/atomic-helper: drm_atomic_helper_shutdown(NULL)
 should be a noop
To:     Maxime Ripard <mripard@kernel.org>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 4, 2023 at 12:55=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Fri, 1 Sep 2023 16:39:52 -0700, Douglas Anderson wrote:
> > As with other places in the Linux kernel--kfree(NULL) being the most
> > famous example--it's convenient to treat being passed a NULL argument
> > as a noop in cleanup functions. Let's make
> > drm_atomic_helper_shutdown() work like this.
> >
> >
> > [ ... ]
>
> Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks! If there are no objections, I'd tend to land this patch
sometime early next week just to get it out of the queue, even if
other patches in the series are still being discussed / need spinning.
If anyone objects to that idea, please shout.

-Doug
