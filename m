Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D327771F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjHJHy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjHJHyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:54:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D871610F6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:54:54 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d64f0c2bc95so62222276.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691654094; x=1692258894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtlymLNA8DDXiFEZ6qkyWTsNDDZ9bMQ7Xcy6MabS43o=;
        b=aqmbUr4GEMwGcGxIPuNAt18SEew4RcLqdSYgPqoy84NfjNwQsO2jN6GomHPpNf4aA/
         wuGzkCEyfViyejFREqEyMKy+lhQvnWtUDA8lgexOMHWgxex8SJecoPMBYHQ0SFyi1oSo
         Yl3UpnB+aGdydIRI2l/0h0o2/mOMHQAbBJ/9fxMCfEpXM4FLdaWjNVQGcErcVQVSKlHa
         myCMvflPxrhA0zDfBI7Ls7MEhzu4pdloZ/ypg++hKFYh7Gi8WvlXxs3x0/eK4cSUwkD8
         Fi/hX7CI0lNpsV/qOrDqqkPyUMxdUcZlBB4y77xQtqgQzbXhUsFKrgC3GF2FNgtqiJ4q
         my/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654094; x=1692258894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtlymLNA8DDXiFEZ6qkyWTsNDDZ9bMQ7Xcy6MabS43o=;
        b=YQBYsYMT/JqGUuKvsRV3HAs4Rq6jLQff6uWysF2ssQQ7LF2TndJYsFywWjOUEF2ZQ1
         qTHYjLQtBRRn8r7T/2+iXnbPAvysdYJ+oMOCgZg0uYdWamtR3P5HJT2/p7ihs1eQ9WKm
         EvS/gHJv3lE4vWiy9bsllyMr6q2SFzPvXy81WPjv7lM7I6GAMgKjs39xL+Hbi1v1BLkV
         /o+2azhYqxCsIdlZyLXjGK4K5YXZgtfTTqVPTlIQIBVrmK6it3PP53DEu2Y2AR7/qeHC
         l945wiXVUVVupZF3AKQKKF80Ia/l8qQgVNR/ahQRdwfelN6XfrYkDbTjcun8VRXVcHY5
         5YTQ==
X-Gm-Message-State: AOJu0YxSUQDIweB5AIns/Qc05aWalZT0IdFGnqDCs1+otbhSm3HtavQE
        AkPK7+44IkH8354fBv//h9953mbcdk6RokXW2rFzNw==
X-Google-Smtp-Source: AGHT+IEdxjOBOjoec+WaIE4q8w8QXHlpLX5c+lenELaRZHEzZyH9rf/PlyEjKcPuOytBnV0qSQguqgwx05dRMIqu/4M=
X-Received: by 2002:a25:ab72:0:b0:d62:b8d1:67e5 with SMTP id
 u105-20020a25ab72000000b00d62b8d167e5mr2020999ybi.7.1691654094172; Thu, 10
 Aug 2023 00:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230720115524.137944-1-krzysztof.kozlowski@linaro.org> <20230720115524.137944-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720115524.137944-2-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 09:54:43 +0200
Message-ID: <CACRpkdYASsQ85n9M-CV_9nuy8YEuVzkTQF9KMPa2DrFXn2zP2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: st: href-tvk1281618: correct touchscreen syna,nosleep-mode
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 1:55=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> There is no syna,nosleep property in Synaptics RMI4 touchscreen:
>
>   ste-hrefprev60-tvk.dtb: synaptics@4b: rmi4-f01@1: 'syna,nosleep' does n=
ot match any of the regexes: 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij
