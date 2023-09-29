Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87677B32BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjI2Mox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjI2Mov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:44:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5461B7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:44:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so1787287066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695991488; x=1696596288; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILOYUpT4AgK5q+nU5tn+arMEdwkeAfGQJWwyqox7rq4=;
        b=VR+P4epeMNS6+ZPIxk9nIyrbMWsQICm/OSIrSl780HviCFVczH9xqy6Gs3eS3WcT3X
         kBzItbR9xjouTKeMP377uHvJyJMaR/0JcqFGs1ucpD3+d13p+klO6QYxcjm01gdfa3hh
         PPldWkQ0Tma1iAKsKBVaVk6WoTGkJm0k9uPPyIXKomK/vAfmn9CR0qyZOagXEzQIgHhq
         ejon7bqjsfFoBFjlsD18BVvLlww/LU4gK8KeO6tY+E8pj+LOv3bweGI37MYfPSd2Ff+/
         g7xVxO+rJUBU4Pa+9kd0xgS1UNoRIoofz0EexOcA150kqGeDLIWl+1fJvsOnPQ7e6Qje
         /GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695991488; x=1696596288;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ILOYUpT4AgK5q+nU5tn+arMEdwkeAfGQJWwyqox7rq4=;
        b=XlFz0iuzKxdqOOhHC6ribQwULCikdidsZDqtIkftF9E+eaWBeiSOOiyRtF859l0exg
         mae3PhiOUtUYG5ABtv81DTR2xfJYVCciElGwD+jQ083bhQAm4UR2/5lax3lkFOUgXjGw
         7XuTUWVLHnLIleWZciKKbcCNZVqVYKjJZqbsvBZeuZKXeZyiwPwC/hCrhk8Mpfu9fzZz
         Jb/mXlTvOSPRDwXtutB3iTTiFVk/yPW+x/niLjxvkxrbiAMgFarkR8PHJgddtHoIhrI7
         tGw9Z6LoGxOKFlRC6fasw1TRGjqC/CI7mWC6IFz3vZuUW7unVrvXoFx/ljXnAhqgrMAV
         hfvg==
X-Gm-Message-State: AOJu0Yxe9hy2AgwWvSjnotKAbmfXL6+GeXK1mM2BC/YbeWEzyF08SsPZ
        +0PRyW3H+sbf+NekfbsxmI+qZg==
X-Google-Smtp-Source: AGHT+IH1568r9Fn3T/Uv2fQlT+CxZWy39xXf/j68AARuzWrDFj9gD9phmENKFlb7+fy84sFn1vxa6Q==
X-Received: by 2002:a17:907:2e01:b0:9a5:9038:b1e7 with SMTP id ig1-20020a1709072e0100b009a59038b1e7mr3479950ejc.36.1695991487947;
        Fri, 29 Sep 2023 05:44:47 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id q6-20020a1709060e4600b0099bd6026f45sm12233886eji.198.2023.09.29.05.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 05:44:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 29 Sep 2023 14:44:47 +0200
Message-Id: <CVVET1A2CO26.3O47662JKAL6@otso>
To:     "Mark Brown" <broonie@kernel.org>
Cc:     "Weidong Wang" <wangweidong.a@awinic.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ASoC: codecs: aw88261: Remove non-existing reset
 gpio
From:   "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.15.2
References: <20230929-aw88261-reset-v1-1-fcbce194a823@fairphone.com>
 <ZRbDW3OiAYyAkWgN@finisterre.sirena.org.uk>
In-Reply-To: <ZRbDW3OiAYyAkWgN@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 29, 2023 at 2:30 PM CEST, Mark Brown wrote:
> On Fri, Sep 29, 2023 at 12:28:10PM +0200, Luca Weiss wrote:
> > According to the AW88261 datasheet (V1.1) and device schematics I have
> > access to, there is no reset gpio present on the AW88261. Remove it.
>
> That looks to be the case according to
>
>    https://doc.awinic.com/doc/20230609wm/c815e155-60b7-40fb-889b-676b02e6=
7d0a.pdf

Nice to see the doc is also available there. Seems it only shows up on
the site search but not with Google

  https://www.awinic.com/en/search/all?titleSearch=3DAW88261

>
> (which is v1.5 FWIW), Weidong?
>
> > In case this looks okay, also to the driver author at Awinic, the
> > binding doc also needs to be updated to include this change and not
> > require (or even allow) the reset-gpios anymore.
>
> It would be easier to just send the proper patch to start off with, no
> need to resend if the change is confirmed...

Unfortunately the dt binding is a bit trickier to update since it's made
for both AW88261 and AW88395.

After spending a bit of time using non-Google search machines (Google
seems incapable of finding anything there) I found a datasheet for
AW88395 and that does appear to have a RSTN "Active low hardware reset"
pin so we should not remove that one.

Probably it's easier to separate the two dt bindings then, instead of
trying to keep them together?

Regards
Luca
