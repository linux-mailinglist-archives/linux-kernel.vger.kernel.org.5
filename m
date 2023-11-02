Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE6B7DF2D1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbjKBMvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjKBMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:51:21 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDB8125
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:51:15 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59e88a28b98so8057847b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698929475; x=1699534275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pU8l6Ru1lmyLGco+UhPIPJQZlA30Z+Oa9JgbnH5Dks=;
        b=AZbKVW0219z6rAdwYz6L4Xoh5ZTuSdZPFZecqQ+CTAHD0kFVyPYG5WCrqAU7GXuU69
         iHKyX+nn5IJfv8VJ6zsJH8NJAWzGRI8pcbu5Pf5+yRTHJGgTDhu1SVTy4JW22jYVelm3
         S2GC5N6br4nNJm601OGIDiTE41SMDW/gC+Mxrl3csQDtprKFqQ20jGUokq2MBNaUv3wm
         o3HLTGQcSO3CfmzILDt6bEU62ZfDEYJBAuxcZVSV1+qHpWdge+1PEJxSF2SU4VhOVISn
         fMT+FIWKmSdhYleoVOxwkGAlZyik0GLuo3r/DM8j8jOPbDxFKGba3D1tWUIKQWhm0PMB
         Wk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698929475; x=1699534275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pU8l6Ru1lmyLGco+UhPIPJQZlA30Z+Oa9JgbnH5Dks=;
        b=ePEbq2bg5FLEo42p5+W/9pT2H4TMyXms+s9IvDkCGsccy9/4nLoZJ61J98i4ZKr1G9
         Zdzp4Otk8qXWbtkME6qWGKhhmA0TlaOlUEMIzK2p0pO1iarnqXCWLXgjy7B6a98Klb41
         p6t8QsjhC7jeqteU4SmadosQrmexGlLBeXW9387+zCY5dYAFKfVyBDMcEuU80UoDPW6G
         LNrMOtP5/xP5SV79WGy31eq6r+tDj4sP2AV6A17N3pH8tnxYZ1YXcGzLsFaxKYoUbu7y
         6KbCy9ifTzUMgPOn5LxEYYYJAbYsVS6/36KHURU1GCDPjPF83uB6K215WCrO+nIzyULb
         vRuw==
X-Gm-Message-State: AOJu0Yye998z9lmD5oe6wD45yhsE+I4eN1aLAi9LlSJVx8OxuWP9whH4
        SzxYWpWADmF4tNL1KgI/zJcH/RINzXhog2/+LsQEOQ==
X-Google-Smtp-Source: AGHT+IGRkYgLvFHHFjBhSWduql5eL+9bAHhVMQTgHxjzn6sHcDECaO2Lh/+qYRAoq7rT1SgPFNKls6mPJcZrLdU2ueU=
X-Received: by 2002:a81:ac64:0:b0:5af:97b6:9def with SMTP id
 z36-20020a81ac64000000b005af97b69defmr4708633ywj.24.1698929474829; Thu, 02
 Nov 2023 05:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231030072337.2341539-2-contact@jookia.org> <20231030072337.2341539-3-contact@jookia.org>
In-Reply-To: <20231030072337.2341539-3-contact@jookia.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Nov 2023 13:51:03 +0100
Message-ID: <CACRpkdbm5KYj8KWNQJ20jq7XLbW-_ykX1_t=kse9-otB1FSPSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/7] drm/panel: nv3052c: Document known register names
To:     John Watts <contact@jookia.org>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 8:24=E2=80=AFAM John Watts <contact@jookia.org> wro=
te:

> Many of these registers have a known name in the public datasheet.
> Document them as comments for reference.
>
> Signed-off-by: John Watts <contact@jookia.org>
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

This makes things better so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
