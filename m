Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01C17F6D54
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjKXH61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjKXH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:58:15 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7955A19A5;
        Thu, 23 Nov 2023 23:58:14 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a02ba1f500fso231990466b.0;
        Thu, 23 Nov 2023 23:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700812693; x=1701417493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p7dDjCm5/iLvLgQDDLJfWkSJwlYnIAvuwjTfuhLRQA=;
        b=gc1UBbXUlP65qYLy2lcZ13qIU61y4hbm3whIsSeXARn8+ezOhiy5g+7RzND6qABSmn
         +fwzDPv7ZLdb+fXb3dunhMAAOhha1ciSWswrSVyXY+LX9npbfs/f4VhhSUhcp0pXaKpe
         AQHHYQVcsihMmkvsjwZggcdnkR+2d4cdoJv0NtJIq80MrlnIXvNPaZgHEWQU7m1ZRgRi
         XT6Sr0CscnEfPUHtwp1XHHPCiFHpLuxpnNnO6dTkpcZyHl92bPG/d9ftSFgilhWKSflQ
         qk2BcYgK4ObNsONWweAKR/J/Vv6GlaXCxLxsbJJNLUWdDH3A033TDcTnRQ/2kD/PRa/R
         jTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700812693; x=1701417493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p7dDjCm5/iLvLgQDDLJfWkSJwlYnIAvuwjTfuhLRQA=;
        b=Z7Bd1ITn+ioPwECFAOVPcD5UT6SRZ2OGWk8Ehj170DWE9+Y2xNXt0Oj+lBoz7CqF7Y
         zvtR2kT3YDchi4mWJVp6RdmnYP/vnQxPQdAqAB8JlgJcMmByrlKnsrJ1klLiXsCkbMA/
         c1C2u5R2tczxwN2Pk0SmkPTRh2XWKB0MUfj6MPt6ENiAZzsu8l2NUIcwD5L7UhCcmw9O
         twLdHdSpcUZzzb3pj92vH0hiuT0dqVPE1cumFbHjBF6KHwS4D54R8ZaAaHMMjsDfE9yd
         5ZArK0m6xhGrabJS8IqpUSqgFEXnI0M/KCE9Zo4AX+ladoIyh52XW+aNCkhP9NFfGJMV
         f+FQ==
X-Gm-Message-State: AOJu0Yx2/gy0vcOaNQ9ZhFxNGnq/+JMgEp1pfcs0KEE0SG0F30N0OcW+
        s0ShCILYqNYDhW+WKZ3JQ8b6Rj9KXHIrY5INPqIFrS0Qzko=
X-Google-Smtp-Source: AGHT+IEPyeMGcJbKf9VM4SzfT7pg1ea0f74KgjJ1BME+tFnbuB0Hw++ZZHZQ2HpsGcUa3T7xjYbBENVawrrltbDNsME=
X-Received: by 2002:a17:906:3fd0:b0:9b2:c583:cd71 with SMTP id
 k16-20020a1709063fd000b009b2c583cd71mr1203541ejj.50.1700812692734; Thu, 23
 Nov 2023 23:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20231124131331.23279543@canb.auug.org.au>
In-Reply-To: <20231124131331.23279543@canb.auug.org.au>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 24 Nov 2023 09:58:00 +0200
Message-ID: <CAOQ4uxjFta+-jirxbD3z4qDZ735F=jtghzSNuTxsOxEY+A41zQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the vfs-brauner tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 4:13=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the vfs-brauner tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Documentation/filesystems/api-summary:14: include/linux/fs.h:1655: WARNIN=
G: Definition list ends without a blank line; unexpected unindent.
> include/linux/fs.h:1658: warning: Function parameter or member 'level' no=
t described in '__sb_write_started'
>
> Introduced by commit
>
>   2a7b49f698d0 ("fs: create __sb_write_started() helper")

Christian,

Do you mind folding:

@@ -1648,6 +1648,7 @@ static inline bool
__sb_start_write_trylock(struct super_block *sb, int level)
 /**
  * __sb_write_started - check if sb freeze level is held
  * @sb: the super we write to
+ * @level: the freeze level
  *
  * > 0 sb freeze level is held
  *   0 sb freeze level is not held

Thanks,
Amir.
