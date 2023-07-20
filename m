Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8769175B690
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGTSWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGTSWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:22:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF42186
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:22:31 -0700 (PDT)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CA58B3F18E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689877348;
        bh=digy5DCqNsigl+eVeOkr7OQYNKSxl46kC4WxbLHYBlg=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=diNoibyF55JXIzsPPkuUOMJpASnDY+58hMy9OmUx+3XHQEGIq7xNc76Q8giUcqoea
         GG+PrEvvD8SiLyNv5CX97/JSWGCqwk860ajnDPsrO/wkbuRsf8aYTtlT3u50gJOGfy
         IcQfjDbVRx4Nv4ybkYdU+4oHdfT1LUqCRAeOV4xOtUwslcdfCa0d2kxqw1Ilv+/8e3
         QL8PzLBp65wy8JmnLTYuDuTt0VfBoS5B8CHyVKlvIwJv88qJ85jUo1UCEJJWVGvdWJ
         siCy6jsYCJlWHrO5h99/Ol3Cc04zYh41iEh2jji2Bw9o/e7JlEmUN1GHtJLOh1/TQM
         Zn5ipCmFLKgIQ==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bb1bb45da1so9031005ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877347; x=1690482147;
        h=message-id:date:content-transfer-encoding:mime-version:comments
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=digy5DCqNsigl+eVeOkr7OQYNKSxl46kC4WxbLHYBlg=;
        b=ckW1LBicgTSSq4+/dNbdocZT1x++BRPKF73TWGROkKEzQgsu52XMYoJ6U+6BXYNFvL
         rWBcISgKQFpoj6GfqB/3VPCoVpEuNqDQ6a8by1M0D5iJMQYqQqQF8t1UaE9PMWvDhrSP
         Vcb/RpyhKF5mzcZ2o2A5hJSHDdVX+cyVQR5oGi7zkKZdThttm//diskvyPp88m6ADIZ9
         L1BzG659mcdGmCfV7/NCIrx68yYip2A8k2dPPqhOuMwxfCNtZ8xmzZGHxGrQz360mZpO
         enJwjyRgR8wQrbfGAJBrmFpkpmcPTTeGHHCpZKMGMSIg+kxmn/YNZU7hHb1Jm2wxe1eM
         M0/w==
X-Gm-Message-State: ABy/qLY3ht9SJe1dzzAFp5i2eJH23M7TeSNOekYKzp+On+8qN8l2u9uN
        P/G0ghlEnDOcCZ3Z9Z4HS705tx2zVbgmqYQ16qX7u9gIsIb9hJe4AWsa8/L+zmsyN/1zN8SOa8O
        k0fZGEXriNjB/j7HJdKeJ+VCSTfDkrxEKzhJ0ha+lpQ==
X-Received: by 2002:a17:902:b584:b0:1bb:1494:f7f7 with SMTP id a4-20020a170902b58400b001bb1494f7f7mr74722pls.23.1689877347514;
        Thu, 20 Jul 2023 11:22:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG9bQHHgpcEhm4TYUG2OZL2k1KHLsFgBmvmLT9xfcpP0FnGx8Rd3um5aLXu8hfZbDEbokTUcQ==
X-Received: by 2002:a17:902:b584:b0:1bb:1494:f7f7 with SMTP id a4-20020a170902b58400b001bb1494f7f7mr74711pls.23.1689877347187;
        Thu, 20 Jul 2023 11:22:27 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b001b891259eddsm1712395plx.197.2023.07.20.11.22.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2023 11:22:26 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 587EC60283; Thu, 20 Jul 2023 11:22:26 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 5085B9FABB;
        Thu, 20 Jul 2023 11:22:26 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Paolo Abeni <pabeni@redhat.com>
cc:     =?us-ascii?Q?=3D=3FUTF-8=3FQ=3F=3DE7=3D8E=3D8B=3DE6=3D98=3D8E-=3DE8=3D?=
         =?us-ascii?Q?BD=3DAF=3DE4=3DBB=3DB6=3DE5=3DBA=3D95=3DE5=3DB1=3D82=3F=3D?=
         =?us-ascii?Q?____=3D=3FUTF-8=3FQ=3F=3DE6=3D8A=3D80=3DE6=3D9C=3DAF=3DE9=3D?=
         =?us-ascii?Q?83=3DA8=3F=3D?= <machel@vivo.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>,
        "ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>
Subject: Re: [PATCH net v4] bonding: Fix error checking for debugfs_create_dir()
In-reply-to: <47eb92888fa46315214ad921a9ac45b695355a36.camel@redhat.com>
References: <20230719020822.541-1-machel@vivo.com> <47eb92888fa46315214ad921a9ac45b695355a36.camel@redhat.com>
Comments: In-reply-to Paolo Abeni <pabeni@redhat.com>
   message dated "Thu, 20 Jul 2023 12:20:01 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 20 Jul 2023 11:22:26 -0700
Message-ID: <25152.1689877346@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Abeni <pabeni@redhat.com> wrote:

>On Wed, 2023-07-19 at 02:10 +0000, =E7=8E=8B=E6=98=8E-=E8=BD=AF=E4=BB=B6=
=E5=BA=95=E5=B1=82=E6=8A=80=E6=9C=AF=E9=83=A8 wrote:
>> The debugfs_create_dir() function returns error pointers,
>> it never returns NULL. Most incorrect error checks were fixed,
>> but the one in bond_create_debugfs() was forgotten.
>>=20
>> Fixes: f073c7ca29a4 ("bonding: add the debugfs facility to the bonding d=
river")
>> Signed-off-by: Wang Ming <machel@vivo.com>
>> ---
>>  drivers/net/bonding/bond_debugfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bo=
nd_debugfs.c
>> index 594094526648..d4a82f276e87 100644
>> --- a/drivers/net/bonding/bond_debugfs.c
>> +++ b/drivers/net/bonding/bond_debugfs.c
>> @@ -88,7 +88,7 @@ void bond_create_debugfs(void)
>>  {
>>  	bonding_debug_root =3D debugfs_create_dir("bonding", NULL);
>>=20=20
>> -	if (!bonding_debug_root)
>> +	if (IS_ERR(bonding_debug_root))
>>  		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
>>  }
>>=20=20
>
>Does not apply cleanly to -net. To be more accurate, the patch is
>base64 encoded and git is quite unhappy to decode it.
>
>Possibly your mail server is doing something funny in between?!?
>
>Please solve the above before reposting.

	It appears to have trailing carriage returns on every line after
base64 decoding, i.e.,

$ git am /tmp/test.patch
[ this fails ]
$ git am --show-current-patch=3Ddiff > /tmp/patch2
$ cat -v /tmp/patch2=20
---^M
 drivers/net/bonding/bond_debugfs.c | 2 +-^M
 1 file changed, 1 insertion(+), 1 deletion(-)^M
^M
diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_=
debugfs.c^M
index 594094526648..d4a82f276e87 100644^M
--- a/drivers/net/bonding/bond_debugfs.c^M
+++ b/drivers/net/bonding/bond_debugfs.c^M
@@ -88,7 +88,7 @@ void bond_create_debugfs(void)^M
[...]

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
