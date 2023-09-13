Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341EF79E7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbjIMMMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjIMMMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:12:44 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1EC19A8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:12:40 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59b90c199f5so30816507b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694607159; x=1695211959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKRWKGQHFX0WLbXiJYPaDCbcQzMct0uU3qJAXZ+XXig=;
        b=ZBzV2/WyUYJuzapIuLqunL7W0mXEGQKdNSW34QHBvpM89ziL2y8nOytocOmXC+JYJw
         i0kBSQT4hUsIJpRURxyjyzQbPykcMQsZuHj8xhf0Lkvgs12ikAovApcKOMDYRmtp+9Bs
         QbCnnP2Fwa7+DhvQDZFBXpZIrocK8S8XKfNtO+VgyB4bbhSAg0KmAthEUcQfAVihKIX7
         m7+64zUU17UKOlKlmMqsvaOSUaxw0Z6zya+XV45KCkb8KyVX58JtzLqtJS6SxHNggpQs
         pAQAEbPtn3YJ1aGXBqYScMEGJYR/CBeV16C0jr/LtKHwYZS+ndJgp83Kvsh8nyMsdvKa
         Cm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694607159; x=1695211959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKRWKGQHFX0WLbXiJYPaDCbcQzMct0uU3qJAXZ+XXig=;
        b=HL0/VbMoFbfeN3iO0LjEyMT9beleKLV1wp3EfUO4a18U1rvHc6k9MkbWVLRrIdKzaA
         OqejHkMf2ITDavSMfyzwEJyYudwpfbDbZ11bPWUSC0+AHgKy/fdffp5mPlK16B7KA/i/
         lnFhSJFhDfC+Y+t/HuLFBUvkQ+gnDPeO6TuQKPwkk7njgg0Ra5OewhF7oMJq0lvF0b6t
         rA2LMcUSYnlsNZrA/nwRXjQn70pSVhWCPuRyo7NRZ0iELigHHGU8lSmSH4ymSuQCtmjD
         +8QQ+LhW4zV9AeDLSNlffmBqML5VuJWFOxWJlB2T7JP1Dbqru1u75ynsCx6gNK0D/jYg
         MfIg==
X-Gm-Message-State: AOJu0YyDbLcpFj1uFK4Iir68Yxmra6BStDlM7EVya9VRXUormf6M4w10
        YN8crqGTqzMfbQKV3NA+c+kt8WTmg3iunISWKYEuvA==
X-Google-Smtp-Source: AGHT+IGKKhpTIt0pOIDxYff0iy7DeEYGSZN2lqVUTnABVES8DyBu5EcH0Ri5ssNmofC1qs+rQqEPLywIEhdUIkyO7pc=
X-Received: by 2002:a25:c012:0:b0:d4a:d2e2:afe0 with SMTP id
 c18-20020a25c012000000b00d4ad2e2afe0mr2255507ybf.14.1694607159447; Wed, 13
 Sep 2023 05:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220615092958.3962271-1-windhl@126.com>
In-Reply-To: <20220615092958.3962271-1-windhl@126.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Sep 2023 14:12:28 +0200
Message-ID: <CACRpkdaB-nhb86N89nBfExydTQ_HvTEQQDuoZ6Ed72rhwFYipA@mail.gmail.com>
Subject: Re: [PATCH] arch: arm: mach-versatile: Add missing of_node_put()
To:     heliang <windhl@126.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:31=E2=80=AFAM heliang <windhl@126.com> wrote:

> In vexpress_smp_dt_prepare_cpus(), of_find_matching_node() will
> return a node pointer with refcount incremented. We should use
> of_node_put() when it is not used anymore.
>
> Signed-off-by: heliang <windhl@126.com>

Patch applied!

Yours,
Linus Walleij
