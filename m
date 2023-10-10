Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19717BFE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjJJNm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjJJNmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:42:14 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050EB198D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:40:10 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9a6b21d1daso518653276.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945210; x=1697550010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=iU+P3jUeRQTOL6K8ZiDZpR+KxqDJiJG3z20HoibiZzHaTMmxvrL4wKGecYVe1LCh8s
         U5UnCHXJZu5h8IRri2QyQs8bCoBwD3bt4pNPr6Y4E3YX8VHlo+WpHKBXDgzwSyjth2r+
         /3foJe+ReZ9QwQuASSc/t1aSqp3yvhnkh9l78EwZ1UDJPuPev0p/7ZpZ4hLG6vOiM3Pp
         yibqs2Z7q19YZgOWPkrNyTz8ECEqw7nuac3AMWIfx8tgN2trz7n2QxvVtNjraHGqfG1w
         ISX6q3swN+1eYbSkLBp62v2Ka0IPhnmzxDFsR9yoSK9X+gGjUiTidQBBa8IBQEPk6jT8
         6zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945210; x=1697550010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=d83rjO4yujDuO49P/lOr/1cG1voQP6v5jsEtNlmjyWVg+Kk8fXMmMe2rIB5bPiGtEB
         RFQ4QwRqGXiiayEqYLDRtAlwtpsCvviHO87MFeBHPSMbdnup7thOhW5hdTWq41OhkRKt
         SOah/yk/nhDoQyr2ImOE+in/d9ZDrvLGiYZFlAw02PLx1vH20OKvaXYXPEqxXZcGbHQ6
         /E1KrOrHCiPWEBV1Y04cGdHejLPXiExTZJcXEBr1Ko9gQh6RDMCxwe/K9iqFHA2xCmdL
         7n8eE2j2/r02V3wz3W2uA9wzsTYMwSMCZvjLdWb6HC++0FOB8Y/5An4H1+1UbecxLkL7
         EE3Q==
X-Gm-Message-State: AOJu0YzXzalN1h18chtH3Bty/h9cyFlPbHebzrXllX3I0Hh6SGn/gt/K
        OI+PRoun10XEUF0w/Uv4M3A5ZzscqSm49mkBVSq2nA==
X-Google-Smtp-Source: AGHT+IERlhK31X3rTtl/eFbhmoKroyjEbbBwMmyA9pS3eknMyDbLgAnhuFLtBvx1RksawYaE6uLXmvuEw9HUPksW4Bk=
X-Received: by 2002:a05:6902:1105:b0:d81:5436:9893 with SMTP id
 o5-20020a056902110500b00d8154369893mr19893265ybu.21.1696945210160; Tue, 10
 Oct 2023 06:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de> <20231009083856.222030-11-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231009083856.222030-11-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 15:39:58 +0200
Message-ID: <CACRpkdagxBPxa+BmmBEn_ngNr5u0cVGj-Pda7TMLqv018o5uew@mail.gmail.com>
Subject: Re: [PATCH 10/20] pinctrl: as3722: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:22=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Patch applied.

Yours,
Linus Walleij
