Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673637D9E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345869AbjJ0Q4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0Q4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:56:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB504E1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:56:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so3965385a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698425769; x=1699030569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3d18pJO7ZCq9XhoCxYiBlHoIVFAF0YcCzxxA38+x4U=;
        b=bAvo9gzTrvaDUTv2pyOToClIFZpfGFAKc0gVCR4fuVLqq4IaKK9xSvj4V3wY2Wp9m1
         a488upjrIpR682HSJhk8Rt2R5iTkhHli85Sfto4lSLUuEelw3ZEn7x3oRRENOWaGyw+x
         Pp41GshT19O6O24qphPE48pLGmECYOzDrRcyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698425769; x=1699030569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3d18pJO7ZCq9XhoCxYiBlHoIVFAF0YcCzxxA38+x4U=;
        b=ITXgJ9Dm9yuZKKUhSjSDvoriQ8eXqFcyVtfe/Ze+fwbHwivNwwpne3qj833h2QLe5y
         FFwie5inR79Z1FkwUPrpgOFyLPdD7zZ4ApSJs15iHlnLqE0uruxQgwckCmf0L1qPATSj
         Vs2basrc0BL5IT0OA3hbeYcUeMHKiKQ9MRTpAIjJZqxLLNsoDHLoLrE8XOL0UxzYqij9
         wGJU3H7n9DCOkiJ/cqNijuInUz5xbcPnH5yajiSHwzwRMVzScBMWMTWoJwXT8jnOFqy2
         qhRUwa2kxYRuSfsXvKkQ1VrxNSEK+k4AZKxfECwvluB4rA8ijDl59na4AP46x++Bu5lm
         0ugQ==
X-Gm-Message-State: AOJu0Yzr3iVJ5Nxig5lcCyMl1HLtE3Ma0z4wBVAXf2V6GDSq1nqX9gN9
        e/vjwVGNpmke9bQW5tgSfqOUo/K560dLZdQICGgeXU1f
X-Google-Smtp-Source: AGHT+IFbHB/M+mJHM7vK2zRUzeUSpEJGawehOUEvRWFfu0U2vYEGFSBvVM+59f1jPHFOQuyod+pOag==
X-Received: by 2002:aa7:d496:0:b0:540:2b93:af85 with SMTP id b22-20020aa7d496000000b005402b93af85mr2772862edr.26.1698425768741;
        Fri, 27 Oct 2023 09:56:08 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id f12-20020a056402150c00b0053e15aefb0fsm1460168edw.85.2023.10.27.09.56.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 09:56:08 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-53f98cbcd76so208a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:56:08 -0700 (PDT)
X-Received: by 2002:a50:c101:0:b0:540:e46c:5c7e with SMTP id
 l1-20020a50c101000000b00540e46c5c7emr8017edf.0.1698425767993; Fri, 27 Oct
 2023 09:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231027110435.1.Ia01fe9ec1c0953e0050a232eaa782fef2c037516@changeid>
In-Reply-To: <20231027110435.1.Ia01fe9ec1c0953e0050a232eaa782fef2c037516@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 27 Oct 2023 09:55:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VD6nooPcrcBoV1_7c869wz3vnQgD=-JabgzxbDv8Rxjw@mail.gmail.com>
Message-ID: <CAD=FV=VD6nooPcrcBoV1_7c869wz3vnQgD=-JabgzxbDv8Rxjw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add panel entry for AUO B116XTN02 and BOE
 NT116WHM-N21,836X2 and NV116WHM-N49 V8.0
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 26, 2023 at 8:05=E2=80=AFPM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> Add panel identification entry for
> - AUO B116XTN02 family (product ID:0x235c)
> - BOE NT116WHM-N21,836X2 (product ID:0x09c3)
> - BOE NV116WHM-N49 V8.0 (product ID:0x0979)
>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.googl=
e.com>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 3 +++
>  1 file changed, 3 insertions(+)

nit: the ${SUBJECT} of this patch is too long. It's OK to go a little
over suggested lengths, but this one is probably too long. Other than
that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...as per my usual policy, I don't let simple changes to this table
sit on the list. I fixed the subject myself and pushed to
drm-misc-next:

3db2420422a5 drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,836X2,
NV116WHM-N49 V8.0
