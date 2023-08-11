Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD147793B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjHKQBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjHKQBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:01:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823B730F7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:01:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-687087d8ddaso2037288b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1691769661; x=1692374461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=azPy6ZE0EPshKUByccxzWY+NkMutj3Uc2kXD5MseRzw=;
        b=JuQ6m7Y8nAVgczhi1UvWAm+TPe3kk8ie5lRjYsI/q2Jb2Nq4ifnzGEX/hTF0nVNWVb
         Ap7N1ZjuK/a+NEmuiSkUmB9q31FCS2dgptPexRVqog4JVngESZL3Bcqtv4TyKglIEIhJ
         jCqtHLcWs/+uSdpTk6MeqIabpVBhMPnjZq6Nq0mzQ9jVM1EuTOYcZjm2zAI2M/q0Xnuk
         V3ebh+APEUopa4+OYpId94SEujZ9QQJpJ/j+I6XpFWpz6x+a2CP2fUlaByKHM8lRVzQK
         E9RXthYKLuorN/hrPHGlTbtJClEdShjKSBr0ct4jiuYacYL5frzRBYi5bi9bIpJGHMdH
         hA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769661; x=1692374461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azPy6ZE0EPshKUByccxzWY+NkMutj3Uc2kXD5MseRzw=;
        b=TrsrNeDFEtVw7TVTLF0YZFD2+t0VFlYItoC0S/wtUt7X6M7/pLhjuDfa5ylwehj+is
         9++hOe8pP+9AOMRo3kkeFrsFUd6KW1oJTX2DgBKklm1oLamL+Rmi4h20EoByJDY/BMWA
         rYMy73fBRuBNhAYWvDlWQAHZnq+quALtTmW4MtZlh8XrFoFzbWr7h0ZKd653ndrRcfsA
         pRor3KlJgiELqdeWLbAIWEe1HInL/viGOZiruVaOxfVa5kjrvkF6XCgZqrNSIlhGZByQ
         c0DX9FHOZItSkcEMtSwvYK35bUZj2ycRHnyj5eFjxHCLfaG/4hjHC0Z9CtXo4vu/WnAq
         NXRg==
X-Gm-Message-State: AOJu0Yz1WaDs4N71ceTZNOIG7l/+1wS8NC1vYo9s7Gowxwhh2SpiASfd
        7HLeznD2jEeEhwOdm8zMmZ1pexFhVpteQ4ENW0qdsg==
X-Google-Smtp-Source: AGHT+IGmpjakQwuxG3fPOOeGkL/maZOE7MU7pvjEkW+cTOrpXMnuWaNo5Zr8qO5qAj4lnlG4tJCdT6j+uzhfrPKHP8U=
X-Received: by 2002:a17:90a:f310:b0:268:300b:ee82 with SMTP id
 ca16-20020a17090af31000b00268300bee82mr1900784pjb.19.1691769660873; Fri, 11
 Aug 2023 09:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
 <20230808-stand-cheddar-b76b0b7509a0@spud> <eced746a-1181-bd8f-6828-4a4eeb79727c@roeck-us.net>
 <20230808-esquire-epidemic-f9bd74ffde25@spud>
In-Reply-To: <20230808-esquire-epidemic-f9bd74ffde25@spud>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Fri, 11 Aug 2023 21:30:52 +0530
Message-ID: <CABqG17jm938MaEeqS03WeryVWSRBS7Bqq2Vwq9SL4QOGqXU43A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add Infineon TDA38640
To:     Conor Dooley <conor@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 8 Aug 2023 at 19:58, Conor Dooley <conor@kernel.org> wrote:
>
> On Tue, Aug 08, 2023 at 07:10:08AM -0700, Guenter Roeck wrote:
> > On 8/8/23 04:46, Conor Dooley wrote:
> > > On Wed, Aug 02, 2023 at 09:31:51PM +0200, Naresh Solanki wrote:
> > > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > >
> > > > The TDA38640 chip has different output control mechanisms depending on
> > > > its mode of operation. When the chip is in SVID mode, only
> > > > hardware-based output control is supported via ENABLE pin. However, when
> > > > it operates in PMBus mode, software control works perfectly.
> > > >
> > > > To enable software control as a workaround in SVID mode, add the DT
> > > > property 'infineon,en-svid-control'. This property will enable the
> > > > workaround, which utilizes ENABLE pin polarity flipping for output when
> > > > the chip is in SVID mode.
> > >
> > > Why do you need a custom property for this? How come it is not possible
> > > to determine what bus you are on?
> > >
> >
> > That is not the point. Yes, it can be detected if the control method is
> > PMBus or SVID. However, in SVID mode, SVID is supposed to control the
> > output, not PMBUs. This is bypassed by controlling the polarity of the
> > (physical) output enable signal. We do _not_ want this enabled automatically
> > in SVID mode. Its side effects on random boards using this chip are unknown.
> > Thus, this needs a property which specifically enables this functionality
> > for users who _really_ need to use it and (hopefully) know what they are
> > doing.
>
> Hmm, reading this it makes a lot more sense why this is a property - I
> guess I just struggled to understand the commit message here,
> particularly what the benefit of using the workaround is. I'm still
> having difficulty parsing the commit & property text though - its
> unclear to me when you would need to use it - so I will stay out
> of the way & let Rob or Krzysztof handle things.

To provide context, my system employs a unique power sequence
strategy utilizing a BMC (Baseboard Management Controller),
rendering the reliance on the ENABLE pin unnecessary.
In this configuration, the ENABLE pin is grounded in the hardware.
While most regulators facilitate PMBus Operation for output control,
the TDA38640 chip, when in SVID mode, is constrained by the
ENABLE pin to align with Intel specifications.
My communication with Infineon confirmed that the recommended
approach is to invert the Enable Pin for my use case.

Since this is not typically the use case for most setup & hence DT property
is must for enabling the special case.

For further insight into my setup's power sequence strategy, you can
refer to the following link: https://github.com/9elements/pwrseqd

I trust this clarifies any questions or uncertainties you may have had.

Best Regards,
Naresh
