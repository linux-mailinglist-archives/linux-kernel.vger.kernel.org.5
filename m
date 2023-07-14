Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E453753FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjGNQNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbjGNQMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:12:55 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4614F3AA4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:12:28 -0700 (PDT)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1154C3F18B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689351145;
        bh=CwaSp74uZftYhoTLsMnm8U4NTHT3a9L0i+07xUPdu00=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=L3Ks7uE3keZzuwd4io+Rbk3aJyz4oJSetSXq520qTT9SFvuBxcVRa36h4mFY/1Qg6
         ff3KScB2Agpl4kvhCUK/KMTKjcA4JqUq+6aSD8iGcmnS3R3/H1WJWC3aiV+8ukt0Tq
         DzbsZboWFjNpgVRNQoNeHnFUKD71WsffLYZRd+GKnYPHoaJjFKNOza1SQWG7PsIUXI
         Dddfz6AqGKJ7Zian+n2k2CDyZrqmuJmWkxZvN7LvNgsz9N+c1NSmOooV4IKne285Tn
         G+2sQeN8fyCkZVQnZEaX8dXPmY36KT8Qi7wNMt6Lfq58Qlh6nyhNPf0R7jP4hmdq3C
         NLnDOlLacOFqw==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b89f6463deso15276125ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351143; x=1691943143;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwaSp74uZftYhoTLsMnm8U4NTHT3a9L0i+07xUPdu00=;
        b=H4AqHeiS79NJsTT22m6kycq2l1mfG2w8bK2EyWMvajmyXm9H0AbDI/voDQS0DrrDDS
         FmrKA4cYK6BlVHqt5MKqFjmk5frNBP40W7rtgmEflDKfGOXtcc0OZ3hH9Ztj3S4gi1Gi
         uj+jnuyS3HftgHXXTvmkOP3H9BOLfY4zIQ1SQLpdU8pcDa0Ulq3zIuAMpJkyJCAiJGUx
         0hjze311EpbDgCfnk2gp2Ut462LJZUUVM2pp0ETz59QIfRi4uBM1xcSG71SJDotwGxVM
         ns87md3KWjdEydNT2KwUPzsRgCxwzWiQUZjqnQ+NAk33WsMH3mviSSlQWDv6jJU/SJNK
         9nPg==
X-Gm-Message-State: ABy/qLalbr59j7f5u7geJHw52xvyH+nEC0X+3QnuH5femmXKjw0Ev2Mm
        jbpmsHz/6OAMIqEghldgOEusiaBp5LTfgEv8CHujL1nqm75P2facU03SXeRewsHW3hws1rMdf4x
        u5kCXobZp23R3eaibBdzzEUo6naf1lzKWxzNDkA4dhw==
X-Received: by 2002:a17:903:32c9:b0:1b8:9598:6508 with SMTP id i9-20020a17090332c900b001b895986508mr6807248plr.18.1689351143743;
        Fri, 14 Jul 2023 09:12:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFepLrKkDT4u/qlVRlTziDggnm7/uTnrvyRnUgN69tZrzr6A0mZXP6lmaKx6mU0TCY3nHKpVA==
X-Received: by 2002:a17:903:32c9:b0:1b8:9598:6508 with SMTP id i9-20020a17090332c900b001b895986508mr6807220plr.18.1689351143478;
        Fri, 14 Jul 2023 09:12:23 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001b895a18472sm7951284plg.117.2023.07.14.09.12.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2023 09:12:23 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 9C68B5FEAC; Fri, 14 Jul 2023 09:12:22 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 948B99FABB;
        Fri, 14 Jul 2023 09:12:22 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Wang Ming <machel@vivo.com>
cc:     Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net v2] net: bonding: Remove error checking for debugfs_create_dir()
In-reply-to: <20230714090856.11571-1-machel@vivo.com>
References: <20230714090856.11571-1-machel@vivo.com>
Comments: In-reply-to Wang Ming <machel@vivo.com>
   message dated "Fri, 14 Jul 2023 17:08:42 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3369.1689351142.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 14 Jul 2023 09:12:22 -0700
Message-ID: <3370.1689351142@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Ming <machel@vivo.com> wrote:

>It is expected that most callers should _ignore_ the errors
>return by debugfs_create_dir() in bond_debug_reregister().

	Why should the error be ignored?  It's not a fatal error, in the
sense that the bond itself should be unregistered, but I'm not sure why
an error message that the debugfs registration failed is undesirable.

	Also, the code in question is in bond_create_debugfs(), not
bond_debug_reregister().  The diff below looks a bit odd in that the
context line lists _reregister, but that's not the function being
changed.

	I thought the v1 patch was fine.

	-J

>Signed-off-by: Wang Ming <machel@vivo.com>
>---
> drivers/net/bonding/bond_debugfs.c | 3 ---
> 1 file changed, 3 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bon=
d_debugfs.c
>index 594094526648..a41f765420dc 100644
>--- a/drivers/net/bonding/bond_debugfs.c
>+++ b/drivers/net/bonding/bond_debugfs.c
>@@ -87,9 +87,6 @@ void bond_debug_reregister(struct bonding *bond)
> void bond_create_debugfs(void)
> {
> 	bonding_debug_root =3D debugfs_create_dir("bonding", NULL);
>-
>-	if (!bonding_debug_root)
>-		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
> }
> =

> void bond_destroy_debugfs(void)
>-- =

>2.25.1
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
