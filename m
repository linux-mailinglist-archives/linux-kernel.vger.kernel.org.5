Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFFC78F2D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347084AbjHaSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244547AbjHaSmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:42:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66FE64
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:41:57 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c06f6f98c0so9294635ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693507317; x=1694112117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I5ChSmKazSx23s1Wn9L0e1jbuOoLwOeqFS1zmJOj+pc=;
        b=Sbn820Y2t1VrGYJLx03xoo1soWUGFh6FdsfmIcpyD2o5PW929BlgNUt7YwaQ55uAox
         Hlr02ZeVuEaFv0fK2XCdqrrObL+08Nykr3XXicRQLrQxeBJkjMrsTMCLOS/7590NNmF2
         Yy6bh1kuWZXAuvF3KQ2RJSnTsuOGacEA5AdH6dl+m7InJBuCk0CtuVyDGynA6mC+sMzP
         sFJI5U7WnxBwcJlBb0tA/x5s8aTmOGEqW/JDd2kuZCC5QguR+DI+Bms8SVOFepqa6sCs
         EAOyRPKSvCpkPL7uFs72fCRbNaRaatD24/bB8WjtHgzIYIhn+mnffhRjhtFA26DYuHJn
         qdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693507317; x=1694112117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5ChSmKazSx23s1Wn9L0e1jbuOoLwOeqFS1zmJOj+pc=;
        b=QHKv7lPyTYVR3BQ6J6pypT49XXfM9VC+S+dvPH5k8fl2pi+CA/94vfnz7X/o6SvGYv
         A9L+rlcDjztQR/Mo842Q0fJWdtmx99G20BlGw3HuHlJ26vkV7MqiULE6QS+Wtu4Zfpxe
         nVR/F/iTD4gC2U2D6SlBNdsp6ScF/wgXeZeFuTMAnI6QiDCLkLFWNBGaG1y/LA1L7WhO
         FoDw2/cYsnOUUQqi0pchvIPjifVWcL9+salk63zGD1ygSB2qstmmC6zp0b97Y93WZYDu
         ivQt6iGEQXCH7w0sIsiQazriat0ZtSvRn8TqLdfO3YgIjKAeLJguBfifYyC4DJ6xK0/s
         RPbQ==
X-Gm-Message-State: AOJu0YwJUDaybnrDfRNaKBreoX1NV9qvSiZ1RwLwKdy+1DWQeJ54bb2+
        2dtIR6DTKXTKa3TcXGdn51xmPTkZ3uQCxPFMCc4wng==
X-Google-Smtp-Source: AGHT+IH7P0udp27gF7WoaIK8quI86T1Rkg5UneAJLa76Rjycml/SAA0iGsGta93UOBQfMggY0Jy1LaDWA1sMMZuKs8s=
X-Received: by 2002:a17:90a:bb96:b0:26d:291b:cfc7 with SMTP id
 v22-20020a17090abb9600b0026d291bcfc7mr169830pjr.45.1693507317351; Thu, 31 Aug
 2023 11:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230830103620.3611761-1-Naresh.Solanki@9elements.com>
 <20230830-waving-stinky-d510fefbbf82@spud> <CABqG17hvSYbsnYYGOQxVsiXsqLXFnovXvkhgc=pYR9osgF0-1g@mail.gmail.com>
 <20230831-defrost-rebalance-5efda5e5ff5c@spud>
In-Reply-To: <20230831-defrost-rebalance-5efda5e5ff5c@spud>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Fri, 1 Sep 2023 00:11:49 +0530
Message-ID: <CABqG17hxe+mn_qiXQ8ikPcU32KrU__FqkVaq_Aam=w_yF7qTkg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add Infineon TDA38640
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, 31 Aug 2023 at 21:24, Conor Dooley <conor@kernel.org> wrote:
>
> On Thu, Aug 31, 2023 at 12:49:32AM +0530, Naresh Solanki wrote:
> > Hi
> >
> > On Wed, 30 Aug 2023 at 21:02, Conor Dooley <conor@kernel.org> wrote:
> > > On Wed, Aug 30, 2023 at 12:36:16PM +0200, Naresh Solanki wrote:
>
> > > > +      Indicates that the chip ENABLE pin is at fixed level or left
> > > > +      unconnected(has internal pull-down).
> > >
> > > Maybe you've already been over this, but if the pin is called "enable"
> > > why not use the same wording in the property?
> > EN & ENABLE is used interchangeably in the datasheet.
>
> Maybe we can go 1 for 2 in terms of consistency then, rather than 0 for
> 2.
Ack.
Will go for EN as that's what is mentioned as pin name in datasheet.
>
> > Just to keep property name short I use EN.
>
> Consistency & readability trump brevity. Please pick one term, or point
> out that this is called two things in the datasheet.
Sure will pick one. i.e., EN. EN is pin name & description as mentioned in
datasheet is 'Enable pin to turn on and off the IC'

Regards,
Naresh

>
