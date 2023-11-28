Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D757FC9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbjK1Wmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjK1Wmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:42:50 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E1C198D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:42:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bbb78efb5so1712485e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701211367; x=1701816167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALoEGlhFgB5uPPGu3xj9KOLCNfgqVoia8DwXpxVnje8=;
        b=XXcU50Jcv2Uti8xchHU+SC1G2AEGa8VcDm3x5TfCz5cnfibTE43gnS8+7dC4RHYs86
         6rSQcrWBJDZ9obo7hIII/5qmtgeRScK+Gxb193k/G4hdq2bx4/JGcrlZjYrD9l5JdAhd
         sNlvz4ThRLK0Vq+q7urZwlfQV2XD7FwPGKYjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211367; x=1701816167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALoEGlhFgB5uPPGu3xj9KOLCNfgqVoia8DwXpxVnje8=;
        b=eZaxGC41KuUZo8qko8AA2lYAn1Ll5b8CiPTP4REbriyPlUQKkIaMNg/WqDQUg/pKBz
         Jx0VnPFyTJlQlluUqDETj6TOfadk71+7Yku9gElw+0qDgLsympE15WDbu6fHNGnA+MfE
         sntLb6nBzinZN8wcHu/suXzlJHQga8buV3Z23DmmRLmr/twEFpw1uM96Q8T24hiNuV1A
         S3M55Mo2feSSLBmYJY9ZkrNBuBSJxUeN6bT7QAr30Ca3mIwFp6apwPilJgT4xcDtONOw
         6gaHV4enX/oEGKZB8jEWD/Y2b1uY3Y8lxPpfvYNR9iZjA3i++JRYnIgrcumoaNSh65g8
         iDRA==
X-Gm-Message-State: AOJu0YyY1OuohKslxLQlfTKxW7UvS4e0sq3bFTWscKXjp5MQbihbtfSd
        6Ho1LgauSDveNXGx/uwHsSkrwNDzgws8H6BPsTUDczMo
X-Google-Smtp-Source: AGHT+IEwFCGr4ATqgYge2BjP5FRsg8dct73weqBYbxejEZxu8TlhwAl4oNZthVliHIF04XbVUjsU9g==
X-Received: by 2002:ac2:5e35:0:b0:50b:bca2:d1ee with SMTP id o21-20020ac25e35000000b0050bbca2d1eemr1842033lfg.42.1701211366867;
        Tue, 28 Nov 2023 14:42:46 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7db8b000000b00543525d9fddsm6608078edt.21.2023.11.28.14.42.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 14:42:46 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so5136a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:42:46 -0800 (PST)
X-Received: by 2002:aa7:d8c4:0:b0:54b:c986:2bc8 with SMTP id
 k4-20020aa7d8c4000000b0054bc9862bc8mr81395eds.7.1701211365772; Tue, 28 Nov
 2023 14:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20231117215056.1883314-1-hsinyi@chromium.org> <20231117215056.1883314-2-hsinyi@chromium.org>
In-Reply-To: <20231117215056.1883314-2-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Nov 2023 14:42:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VFUnEEkEh5ij05LeHhfpJBTJ=qRwabdmDdt+y7w7C3Pw@mail.gmail.com>
Message-ID: <CAD=FV=VFUnEEkEh5ij05LeHhfpJBTJ=qRwabdmDdt+y7w7C3Pw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] drm/panel-edp: Add override_edid_mode quirk for
 generic edp
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 17, 2023 at 1:51=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Generic edp gets mode from edid. However, some panels report incorrect
> mode in this way, resulting in glitches on panel. Introduce a new quirk
> additional_mode to the generic edid to pick a correct hardcoded mode.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> v6->v7: split usecase to another patch.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 48 +++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 3 deletions(-)

Pushed to drm-misc-next:

9f7843b51581 drm/panel-edp: Add override_edid_mode quirk for generic edp
