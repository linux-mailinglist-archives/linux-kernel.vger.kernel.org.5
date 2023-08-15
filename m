Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773C777D35A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbjHOTYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbjHOTYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:24:12 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1C1198B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:23:43 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962535808so87886881fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692127422; x=1692732222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qaFxc7NLdnRLFGC9mlhpM8Q09n9sYqbBf799fEemgfw=;
        b=TQ21jZyTGF3bfMGXahLoN4HPtf2jI0G0qRbhilG9PHiO7OiF3viTLSdLr8ftgVW2MJ
         t/n2cjVspxR/8irwI7IlFbd6Uz7LHi9Jg2/8yEW2dI8ahXpOgxzvvwLFm8s7DiZOtODy
         b6gCmq7bfnW8qjx3IwQfBDhg2BPtk1nuT6sUFCwbJ4WsFL4V8p2lbF7K7ZtV3F3SxPSN
         6pBvh0Xdf02XPh993XjEty6Nt9rGfLcTjiHKZ4wso3ztCAoO356imeB2k89ew+cS8F/h
         bm7axHDRBMrKR6de5WQphoD+otQM27z+Ue9qY3UlFB/ZHbQ4/npLLN0KnzuGcH4+DS0I
         P2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692127422; x=1692732222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaFxc7NLdnRLFGC9mlhpM8Q09n9sYqbBf799fEemgfw=;
        b=GaObdEkQ4tDdZUzx6aHWRDbUVjVeuK8UcZQFPjs9KOo9/Z5JGlZgVc1YYr6ph9I1wc
         sPVppwi5Ozj8GG2Gh0z7CqZ4UtH0CylyXhakUL98mL9A6FyHDOjCgDyXptIJd+bzZKOl
         JzxgnorTCFPWpG8FclGEraHaCVXiztFFSoUVlnRWp1xylcbUlsg0O1UuQnBHPzTCh1n6
         xhMmGu+9XGyF3bXKakeTmX2ZU1PsQfYRb1ItpGLY1sW4r+u5xqf2NVLh4CGstQP1uCiR
         q3HJAZkDogi88Eh7rjHTARdvEb8vvw5QQDiHAOOl/R4roUZIc3nhZaVpebpF2962d5sa
         sxAQ==
X-Gm-Message-State: AOJu0YxQxqgveP48sBSWtyEebHJyifE+MNal8OjE+BYraCWa7OyZ0uV7
        9ZZs8tQGRwcdpBF6/790cQspN9hN2TRMQFa3SAA=
X-Google-Smtp-Source: AGHT+IHJLA26STk/hwBrtqzVAv06LFh2j1m+MsPIDzZXybnuQC5Pb5RCUUJwpAsqa9+P2xMq87XKKRMURzO/wBgCQmw=
X-Received: by 2002:a05:651c:14a:b0:2b9:d3b6:769e with SMTP id
 c10-20020a05651c014a00b002b9d3b6769emr9194707ljd.24.1692127421409; Tue, 15
 Aug 2023 12:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <389b-64db6700-1-3dc04b80@31442286> <b278375f-4644-2db6-9a14-9088470d528c@suse.de>
 <CAKMK7uF1hv3S--=jsmFWG_tkOKavgMBOkWQt6VOSV0d1U7C0VA@mail.gmail.com>
 <1b9ea227-b068-9d91-1036-28a4161b1744@suse.de> <CAF6AEGsr+2xaCeExm9wPmK=nU+jxevLcd8RDWTSFrwKR-yCvZg@mail.gmail.com>
In-Reply-To: <CAF6AEGsr+2xaCeExm9wPmK=nU+jxevLcd8RDWTSFrwKR-yCvZg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 16 Aug 2023 05:23:29 +1000
Message-ID: <CAPM=9tx16UoYoOw4hBChVNPcj57ox1XsybPPTGZn=r2DDQBJmw@mail.gmail.com>
Subject: Re: [PULL for v6.6] drm-misc-next
To:     Rob Clark <robdclark@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, daniels@collabora.com,
        robdclark@google.com, gustavo.padovan@collabora.com,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        linux-kernel@vger.kernel.org, robclark@freedesktop.org,
        david.heidelberg@collabora.com,
        Helen Mae Koike Fornazier <helen.koike@collabora.com>,
        anholt@google.com, dri-devel@lists.freedesktop.org,
        emma@anholt.net, airlied@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Otherwise, there should be something like a drm-ci tree, from which you
> > can fetch the changes directly.
>
> I asked for a pull request so that I could also merge it to msm-next
> so that I can do CI this cycle.  (Unlike the earlier out-of-tree
> version of the drm/ci yml, this version needs to be in the branch that
> CI runs on, so I can't use the workaround that I had in previous
> cycles.)
>
> Perhaps it should be a pull request targeting drm-next instead of drm-misc-next.
>
> We were going to do this one-off for this cycle and then evaluate
> going forward whether a drm-ci-next tree is needed.  But perhaps it is
> a good idea.


I'm still not 100% sure how this is going down, and I'm meant to be off today,

Don't send this as patches to drm-misc-next, but I think we'd want
this in drm-next for a cycle before sending it to Linus, but maybe
it's not directly interfering with the kernel so it's fine

Ideally when the real merge window opens and drm-next is merged I'd
want to have a branch + PR written for this against drm-next that I
can send to Linus separately and see how it goes.

Dave.
