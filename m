Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C5B75A3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGTAr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjGTAr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:47:56 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA831BF7;
        Wed, 19 Jul 2023 17:47:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so2810921fa.3;
        Wed, 19 Jul 2023 17:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689814074; x=1690418874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMC9ISeR+VkWGAWEa1cNLcI3IOnmieq6epgbCGmm3AE=;
        b=a/OZqojo+/mRCY2PtQ1iv2PKZSj4yez4mdkwV9xl4MUcey2sSNCDLlMdPK3a2o9DrH
         xg8Rf8tDdo5dThWKz4REi1YYf6WQniffqkHTRfq6RU5UieX2r9akqn82rZM1BuYBfukY
         lfc2kIZlhBvSMrs7w+uyOd73wv7rv1zFO5ubvlBCeKDA7zmufcfH1Hxfvj/eGcjTZ1zD
         PycPlOu96qMAh3oOwqvH0awsmqbS7dIs6ihtEv+FQBJRr7UuLdl8PHVbhhcGE7dx62Bs
         AMUTYIZHqVKn9BJ4FDdkfh/pk/H1sHO6kEeqBd5ADy1/sGutKHcaE4kXT55b0mQf5Hk2
         7ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689814074; x=1690418874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMC9ISeR+VkWGAWEa1cNLcI3IOnmieq6epgbCGmm3AE=;
        b=PJbtlpuvrfivNcRQF3lOvkXlI/LJ8bOCXh58QIIqTmiMXTC6DWylmiIHAQRZXy+EfL
         zPwgVlZ0678gGTLdoaniIbLQ2rvj5jbzvG9urug9Gxk73OtrTqmepbuAJrt5p9ZjQCpT
         rAQbS66+oSI4qShmSRUNeBj6qimjykirKxGMUGNObB8vwdK2Lj9INbL76JqL1JrHmZIZ
         L9GDNUAXsctU0AAqOji7zVrn9SiNaAvippPKpKGawNPXwDBSwQEDm5QYUp1fBJCytkb/
         SQ+pJlkjPOo6gdxpWbCHIR/V2XMiZIJ2R1oA+UaU/tlr87uYPQrkCI5wZ4Pc8YqL6psy
         p7TA==
X-Gm-Message-State: ABy/qLbFzxr+yzKMKkta7iDaTeEueYeIHknShZomyIkbLRCCq2OzOXpo
        KX2nL3YrAQELiipGt4MUOTfrluwNgI23Yv9Ansc=
X-Google-Smtp-Source: APBJJlF/ndQHml697HrEn7Jjm/aiS76PxmyYplon1r3d25EKCUraEN7zi8GNSiXFox6i5kb+glZYhwIQi2uSSq2eJmg=
X-Received: by 2002:a2e:8742:0:b0:2b6:9f95:46d3 with SMTP id
 q2-20020a2e8742000000b002b69f9546d3mr761208ljj.9.1689814073489; Wed, 19 Jul
 2023 17:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230720103540.0436273d@canb.auug.org.au>
In-Reply-To: <20230720103540.0436273d@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 19 Jul 2023 19:47:42 -0500
Message-ID: <CAH2r5mugNKYBNXm7AuPFL=V=77Qkm3q6TtXCj-B0kugmpL0aYQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Winston Wen <wentao@uniontech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Winston had an updated version of the patch - just replaced it with
his updated one which does a cast to (char *)

          ses->local_nls =3D load_nls((char *)ctx->local_nls->charset);

But as he noted in an earlier email thread:
> Perhaps I should make a change to load_nls() to take a const char *
> instead of char *? If this make sense, I'll do it soon.

which is probably cleaner

On Wed, Jul 19, 2023 at 7:35=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the cifs tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> fs/smb/client/connect.c: In function 'cifs_get_smb_ses':
> fs/smb/client/connect.c:2293:49: error: passing argument 1 of 'load_nls' =
discards 'const' qualifier from pointer target type [-Werror=3Ddiscarded-qu=
alifiers]
>  2293 |         ses->local_nls =3D load_nls(ctx->local_nls->charset);
>       |                                   ~~~~~~~~~~~~~~^~~~~~~~~
> In file included from fs/smb/client/cifsproto.h:10,
>                  from fs/smb/client/connect.c:37:
> include/linux/nls.h:50:35: note: expected 'char *' but argument is of typ=
e 'const char *'
>    50 | extern struct nls_table *load_nls(char *);
>       |                                   ^~~~~~
>
> Caused by commit
>
>   46055407cd4a ("cifs: fix charset issue in reconnection")
>
> I have used the cifs tree from next-20230719 for today.
>
> It looks as though the parameter to load_nls could be made const safely
> as it is just passed to try_then_request_module() passes it to
> __request_module() which just passes it to vsnprintf() to construct the
> module name.  There does not appear to be any maintainer for fs/nls ...
> --
> Cheers,
> Stephen Rothwell



--=20
Thanks,

Steve
