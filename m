Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6077C7934
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442978AbjJLWBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347416AbjJLWBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:01:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037FFCF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:01:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso2534119a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697148078; x=1697752878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odwr8eDy5SCBmCoOrVqIA/yNf2FEEwKvqJwp3o31tFQ=;
        b=GufGVWIZMUS7kr3IyC4izYXap+cKiYLwfoYZ/dvXYGG0UnTeKIbXufmRXbcK2XCE4E
         wWZSOyFnsU6uF9sOB4u8dZttGoUJ1a3SBSpD3MO1WaT9vj2b39P7ZYx4sWWBnG1gKgdz
         Krht4U7UrM+tH6PUoBhgNyou152hTZ+V1unZw2Vc5orixBhmhHNRX0OJSa/CQ2vR2cRG
         F301Wi62seOdctwQ8JQao3gwmuqz5YB+6hYpKeG3NRxeQVBNNzIITSuc2OOqCIrtY5eX
         eWnofK6Bdem2v1dHlqlcODhk1vccdwwHFO/Y/NG7Rqf8ISJ0Oq8RAmzM1nrmGp4aDLpB
         PtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697148078; x=1697752878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odwr8eDy5SCBmCoOrVqIA/yNf2FEEwKvqJwp3o31tFQ=;
        b=Y9APtdA85dXWHAm87Tn5ppIIQwYEZ25V2yQamJuZdw1cYU9lMlXl5RQsmxbd+9aT+T
         t5JJ/CjPlA02bWUR53K/DFICVpES+7O//v1A8LGpFoJbD8E5gkNVBvBzzTaqANYUzLbF
         /0y7jp0IlI4PvXP8igbvmLSzOyok5Gr1eyceLRbtuCy+MLuYrJ61Y0o3CrDAGXLRiMIg
         Z3HxlQhPnME+9HY2eJY/cj5RpSWwkhLW/CENxsGkL8oWfphlZovFkOrb3Csc8p5M/Uxa
         JEVdoTXdu8tCYRNXDKd8auRfUQ1fF9jK3B4LFJGBcZnYSAIhW8A8wChclH1WjtmEmqNg
         abMQ==
X-Gm-Message-State: AOJu0Yz9dYQ5nrmhOTnO57sfHDXwPu9z4HFiGYFIAPKCmssUfT9RBWiy
        QbDap7wpLdo4fX2G1cB8SlycuQy5QXrqI7Yv5VJIsQ==
X-Google-Smtp-Source: AGHT+IHkRTS5Quw20yMh+SqaVjNY3XB88DzaTtUMhrYwgnSHDbh2ArUGSmO9mOxhUHP6tq7BOTcPgHl87BdqzOm0Vr4=
X-Received: by 2002:aa7:da84:0:b0:536:2b33:83ed with SMTP id
 q4-20020aa7da84000000b005362b3383edmr25702236eds.24.1697148078438; Thu, 12
 Oct 2023 15:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-phy-mdio_bus-c-v1-1-15242e6f9ec4@google.com>
 <a86149c3-077c-4380-83ec-99a368e6d589@lunn.ch>
In-Reply-To: <a86149c3-077c-4380-83ec-99a368e6d589@lunn.ch>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 12 Oct 2023 15:01:06 -0700
Message-ID: <CAFhGd8qAfWiC0en-VXaR_DxNr+xFfw8zwUJ4KgCd8ieSmU3t5g@mail.gmail.com>
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 2:59=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Oct 12, 2023 at 09:53:03PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
>
> Hi Justin
>
> You just sent two patches with the same Subject. That got me confused
> for a while, is it a resend? A new version?

Yep, just saw this.

I'm working (top to bottom) on a list of strncpy hits. I have an automated =
tool
fetch the prefix and update the subject line accordingly. They are two sepa=
rate
patches but ended up with the same exact subject line due to oversight and
over-automation.

Looking for guidance:
Should I combine them into one patch?

>
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew
>
Thanks
Justin
