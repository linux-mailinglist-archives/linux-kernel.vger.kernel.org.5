Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54CE80920E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443872AbjLGUHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:07:24 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644371713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:07:29 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db537948ea0so1456088276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 12:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701979648; x=1702584448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWWx2X5EKVBT2ik8RNeobD9aXUGmS5cw6HelRXHUt0Y=;
        b=OOhTtmS/zd/xbYlsrFNvhdshu6HikXSG8pz6R6NPC/DhKmWzUN85qvdP+oJC9iZ7mY
         w+t3k+NqNIPycz/dhW1sp/caABieR9x5ojgfau44yWvafqHmjojid7n9ISCsdGdoTAQJ
         IvmlWg+c10OoGsx0v+adQDBu8GLJzAM4OFZwdsZ4g0x2fPOHjyr3f7cVGX5nfaMWtFej
         aDiJ2QkstV4FwiyCR9S3ii2jtmnEgj5YGGX1jCGbeSL94V44F3ndZP2sXNFPwytHDrKB
         C8bFjt3P2Gkg8KEYGPezOU8hgOJowhiKCPWQKzi4WpGn9WSsCE4VGLewmnBPRH2GJEDe
         WfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701979648; x=1702584448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWWx2X5EKVBT2ik8RNeobD9aXUGmS5cw6HelRXHUt0Y=;
        b=rf4Wv1c5VEIr15pfo8zfVFstNZXGjZI0/zQJBXLqkNMN3NvrfeeOjEXsSUFeMelg+6
         NCJSN1WpHhhI3R5Y5qp2iaJeH/IVvHF4haYLjWs1fQKDzLJ5BqNbvu3p+l/C2MMZ7sV5
         pvOu9PbvNiS2Mzf5uGTY89fjibKqqvwEd+Y5IX33l0IrYB+0KesyweA/9FEb2csfJ72C
         zRxnqB6H6JnWQUSsNNYg9MRyVxlej2Iji6RtlEvl9qdh+m9TWOkh4Ysl4euvt2fRlxOX
         +CI71fqLYr4k4ubh0DWsAyjZtlc2B+wEc6ZTzr60LGrTlgl17ZM9UFcKWnnt6UyKiJsc
         Jegw==
X-Gm-Message-State: AOJu0Yw2RvlPKcTUQTHCbQzmQ7ZMogIKKBYQ5J6hAlzdZPfi2FM0NvO7
        lEMAsMoJv8hh9WBCYqemtbk/wow3QbazfzeULYLx
X-Google-Smtp-Source: AGHT+IG5/rfQ7VOYEbjBCN4z3iR1f+9ch+DgYqYY7IQnxs9sgR4R5gv+dYWcIh0/BxhiyVctY7N0GyyZ5mV77zvS90g=
X-Received: by 2002:a25:2f4d:0:b0:db5:449c:5ebf with SMTP id
 v74-20020a252f4d000000b00db5449c5ebfmr3001755ybv.38.1701979648614; Thu, 07
 Dec 2023 12:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru>
 <CAHC9VhQGX_22WTdZG4+K8WYQK-G21j8NM9Wy0TodgPAZk57TCQ@mail.gmail.com>
 <CAHC9VhTEREuTymgMW8zmQcRZCOpW8M0MZPcKto17ve5Aw1_2gg@mail.gmail.com> <20231206075529.769270f2@kernel.org>
In-Reply-To: <20231206075529.769270f2@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Dec 2023 15:07:17 -0500
Message-ID: <CAHC9VhT2Azgxv4uL0+Auj4YtOt3cm6=yNnZ=Qihfd5NNhmi4uA@mail.gmail.com>
Subject: Re: [PATCH net v2] calipso: Fix memory leak in netlbl_calipso_add_pass()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Huw Davies <huw@codeweavers.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 10:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 5 Dec 2023 16:31:20 -0500 Paul Moore wrote:
> > A quick follow-up to see if this patch was picked up by the networking
> > folks?  I didn't get a patchwork notification, and I don't see it in
> > Linus' tree, but perhaps I missed something?
>
> Oops. Feel free to take it via your tree.

Okay, will do.  I don't believe this is a stable candidate so I'm
going to merge this into the lsm/dev branch, it should be there
shortly.

--=20
paul-moore.com
