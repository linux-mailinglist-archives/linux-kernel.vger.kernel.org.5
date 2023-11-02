Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E80C7DE949
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjKBAZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjKBAZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:25:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8ED101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:24:58 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-da2b9234a9fso374927276.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 17:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698884697; x=1699489497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9WlSD4Ca/HFV738P9h5O+3ftbNBpFens5cZHujKc/A=;
        b=f2Gq/r1Vf/WxJKmoDLnGAd+cN1eQresn1IMNqVfk2MZn+X7azbCRW9WlbUvUidZ2Fc
         1UzCGelqcQlZVleeYx70zFjoiDezbezQ0QVpwICYuWVaFw7iw1v0rtEAo01YpnoV4fk/
         pp+dP2Bx8zaQVsiLaHwBWsRQqKQPKQmulIsepQrcefZ/uQsnWMaRWH0IUv6Swdiq586E
         AWAr+4LMTaaItDtvMOTHVN3QmV4l+pCDpgKosnnr0iKTZFktUE/i0qF9XX4hrT51UISm
         hAbQml4qAvComXNFqFRPRbQ/XXsRrxeuLofYB59cRT93roR8/kFEueUggvMU/iPrxiZy
         +lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698884697; x=1699489497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9WlSD4Ca/HFV738P9h5O+3ftbNBpFens5cZHujKc/A=;
        b=QAle+p0rbzGG2Li/nULV4w4cfPKyj7/f549LteUDMwwP+xMH+qKRLtAc1SkuExF2CI
         WeqJhIipMr8NIAzyCYfQ3NEz5mBPTpexsTgjbJthui00G3FurAUNfIanR0AIMmgwNzxE
         0srscaw7RsOwI2uswkhbRCpszXb6896Bg8/812Uf8cNM+fVAzE7w0YaIBgXWIuCcfhsw
         XlkvfVHcHxs4xwh8JGSU+vRqotvcvCDUyjYsUS3oe09a+2koIKIjbcErhM7x4DJTmpQN
         giNa9mCC3G32SM3c6BO58XPinWnhZsUprDOO0im46u1i0A0aypib4tVdhSFE6ypEXMpr
         zxpw==
X-Gm-Message-State: AOJu0Yz+8QTt9rtWgfNjOO/tNjTcjv8bpBAmHlmV1nHi4j1k5UOpdmZG
        iJChaq0rWF4Py0ugP0MvG20FNxr/jfgiifzOnZaG
X-Google-Smtp-Source: AGHT+IFmoPhc/fYK0Zr9Ce+OjB/aRiFYDtBQUF7E5FL1N/ZBx92E3kTL8fyE/meNgmLLkrWa0naNqUMLi/7wtb6NOu8=
X-Received: by 2002:a25:ac07:0:b0:d9a:fd15:82a3 with SMTP id
 w7-20020a25ac07000000b00d9afd1582a3mr16641506ybi.24.1698884697487; Wed, 01
 Nov 2023 17:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQBV1mcFUmXQs1-VKpAVdaAQ3EiGk-G3ybxfcBkoKGwcw@mail.gmail.com>
 <20231018092351.195715-1-chris.riches@nutanix.com> <5d398909-ab9c-4837-a71c-7bbf5a8df013@nutanix.com>
In-Reply-To: <5d398909-ab9c-4837-a71c-7bbf5a8df013@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Nov 2023 20:24:46 -0400
Message-ID: <CAHC9VhQO0ThV5EAGPiJ74ydyUHGeGp_0Gzfn7aLQKunO_rF9yQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Send netlink ACK before setting connection in auditd_set
To:     Chris Riches <chris.riches@nutanix.com>
Cc:     audit@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
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

On Wed, Nov 1, 2023 at 5:59=E2=80=AFAM Chris Riches <chris.riches@nutanix.c=
om> wrote:
>
> Hi Paul,
>
> Is there any update on the review of the v2 patch?

Hi Chris,

I apologize for the delay, this is in my review queue, there is simply
a lot going on at the moment and I haven't been able to make as much
progress as I would like.

--=20
paul-moore.com
