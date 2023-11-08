Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991E27E5924
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344437AbjKHOeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjKHOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:34:06 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70601FD5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:34:04 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5bd099e3d3cso4490099a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699454044; x=1700058844; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wq2GKZRvDg9AiJBmgyvVfZekJ900y/B3/jN+pVNyvQo=;
        b=mBky2gqtGgpa9YZ/O63C1+wd45WsqDD4sN8AjAfeTJVFZsiSOndvEV7PDNS+Ifenlm
         MY2RYtnq5BvJU4iy1P9vI7C4r/nYdpTKBPWATDD5ByJ47uX9pqdB9tea9iRZd/9UMbPs
         /cJYwG13HbURmsL6b8w3ZZzBDfNjfqMKqgZ5I9qF2Dr2DQK8GgDJSgb9DaPLi06yk/mp
         2L7SMbrVxs6kZPhqv+OFzjKCaIaAl9X9kF0Xj1OAGX20+ebvBAMYWPu1iJh6OUuFXTdf
         f5qpkxknfEAP4zuKrt8g4q6uyMXdubJsfoeUKPQEVJb03ecsexu0dI07MdsVHLaSYFWN
         7j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699454044; x=1700058844;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wq2GKZRvDg9AiJBmgyvVfZekJ900y/B3/jN+pVNyvQo=;
        b=RBxjB4xGCkJUEJ1UYcBf2IWuqUJFxyndxqKuV9OwMM9pa4ilM0qm/lZHFTdbjcp75/
         +gwEEKzI39BPHM3knYQUNBLrtdMQQ1vMRQmKnAOKyOGs0oEmoPmrvC9v3dFQI4dMV4JT
         8Y2bYC/rOegnzSoylS1G3QY2GsgVj4uEifIeFX/wY4ubTEK9psSVo4QoGZJjx03pPH6g
         8j/hcGhOJjmQD/D2F1ab9y0LYcevW0pCz7uIQZ38xpOq3/lfloNOJY7kCCDw7Ztg/QQ6
         CB27QuCVJ6N8R0XUnjT7wzQz+fRVrdesjzYqB1a7sbWvAxXy1KBTliBq00kDbFtgILYP
         UvYQ==
X-Gm-Message-State: AOJu0YyHj+bgq6w+zvWecHzfGRWDenpXQFDdJeH+2LQlRbBweQ4DBNe2
        b35eJ3kyFxELJRP1M336c6eBMQ95O8DbxHZRBNg+0ibH
X-Google-Smtp-Source: AGHT+IHq4VxbeTl8mVGhXNaNtOvGnNzcQQOQ5BkMDms3xlPZGYAR0m+TodRfv44A87bet6AI/zdxaN9cmd1Fxor42uM=
X-Received: by 2002:a17:90a:4e:b0:280:1dca:f699 with SMTP id
 14-20020a17090a004e00b002801dcaf699mr1814925pjb.42.1699454043806; Wed, 08 Nov
 2023 06:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20231106163406.33952-1-fusibrandon13@gmail.com>
 <ZUkaTcV9cYxKjmap@finisterre.sirena.org.uk> <CAEVJM+q5TgYr01MhKe9AUzpt4fj8SAWiQNE7SkX5wVTFeaoAvA@mail.gmail.com>
In-Reply-To: <CAEVJM+q5TgYr01MhKe9AUzpt4fj8SAWiQNE7SkX5wVTFeaoAvA@mail.gmail.com>
From:   Brandon Cheo Fusi <fusibrandon13@gmail.com>
Date:   Wed, 8 Nov 2023 15:33:52 +0100
Message-ID: <CAEVJM+qkLtTfBOeG_UaCZjBHycdiUAnsuKJSxzz9yK=95vr9rw@mail.gmail.com>
Subject: Fwd: [PATCH] regmap: add regmap_update_bits variant to autoshift mask
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
Date: Wed, Nov 8, 2023 at 11:18=E2=80=AFAM
Subject: Re: [PATCH] regmap: add regmap_update_bits variant to autoshift ma=
sk
To: Mark Brown <broonie@kernel.org>


On Mon, Nov 6, 2023 at 5:54=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Nov 06, 2023 at 05:34:06PM +0100, Brandon Cheo Fusi wrote:
>
> > +static inline int regmap_update_bits_autoshift_val(struct regmap *map,=
 unsigned int reg,
> > +                                  unsigned int mask, unsigned int val)
> > +{
>
> Really not a fan of the name here, and in any case if the shifting of
> the value is an issue wouldn't this be a good case for using a field?

True. But all this does is handle the special and very common case of
'regmap_update_bits(regmap, reg, GENMASK(hi,lo), val)' where [hi,lo]
isn't at the bottom of reg. Most drivers don't resort to allocating
regmap_fields for each bit range they manipulate.

>
> Please also add kunit testcases for new APIs.

I'd be happy to send a v2 with kunit testcases, if you think the API is
worthwhile.
