Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6F76DE42
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjHCCcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjHCCci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:32:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18944682;
        Wed,  2 Aug 2023 19:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 808A361A55;
        Thu,  3 Aug 2023 02:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB01C433C7;
        Thu,  3 Aug 2023 02:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691029721;
        bh=BgvTFcE2u4K0+wxe4GvjKEq1YVlpBtvyHHKrVLaiFEY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gyuEomxZRpX0SrxHywJ6XkYDOcwFtOUioPx1aolK7mBSQhxdXEa6YSnVREJ7opi4n
         sgyCPQXqchLsgBzSw+d5vZ9eYBrbJ9XNIK31YOnJJ2JdWVaTISRMm+DpEPRHocebph
         0peN/fjKTHVZxEx/FKLFV9Ujrf2TIWz4ftu0U72HMwDytxioiewlwH42fUXKm2evUJ
         jQswICDfO6memyrsk4iLCt5iXldxPcfDuKLGoeQa4Y+SI+uL1xaa2k4ssjYK+bh0OF
         CZfbSkmkbA2145Z/9FlI7zoDGJAFyUJ0q+3cbwVmtFKRYIteplDbejtae9Z04ROXn+
         vYn9BFHmsllxQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1bba7717d3bso275126fac.1;
        Wed, 02 Aug 2023 19:28:41 -0700 (PDT)
X-Gm-Message-State: ABy/qLau2GI/Y/7TLvyqzm41QEfT2G813Dt/ToAJjnwQxeUrpywTcmOn
        ingJwgrMa2NQpUr8zbm7LTEJgJnn1GEW/b5mZ/o=
X-Google-Smtp-Source: APBJJlELbN7rxcW25qLb4oacTTj27yeJseFlXg3oNxqEwQolADUFiVKUtX8tDZnTRGb0hufQVnnqbeyMzZF8kKEROk8=
X-Received: by 2002:a05:6870:fba3:b0:1bf:9f6:b810 with SMTP id
 kv35-20020a056870fba300b001bf09f6b810mr7709025oab.36.1691029721131; Wed, 02
 Aug 2023 19:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230801140657.1324086-1-boris@codesynthesis.com> <20230801140657.1324086-2-boris@codesynthesis.com>
In-Reply-To: <20230801140657.1324086-2-boris@codesynthesis.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 3 Aug 2023 11:28:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=da_jTF77hF0+Est-orBybwReZAkqWLH5sGTp59eH9g@mail.gmail.com>
Message-ID: <CAK7LNAS=da_jTF77hF0+Est-orBybwReZAkqWLH5sGTp59eH9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kconfig: port qconf to work with Qt6 in addition
 to Qt5
To:     Boris Kolpackov <boris@codesynthesis.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 11:07=E2=80=AFPM Boris Kolpackov <boris@codesynthesi=
s.com> wrote:
>
> Tested with Qt5 5.15 and Qt6 6.4. Note that earlier versions of Qt5
> are no longer guaranteed to work.
>
> Signed-off-by: Boris Kolpackov <boris@codesynthesis.com>
> ---


$ make xconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/images.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/menu.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTCXX scripts/kconfig/qconf.o
In file included from /usr/include/x86_64-linux-gnu/qt6/QtGui/qtguiglobal.h=
:7,
                 from /usr/include/x86_64-linux-gnu/qt6/QtGui/qaction.h:7,
                 from /usr/include/x86_64-linux-gnu/qt6/QtGui/QAction:1,
                 from scripts/kconfig/qconf.cc:7:
/usr/include/x86_64-linux-gnu/qt6/QtCore/qglobal.h:106:6: error:
#error "Qt requires a C++17 compiler"
  106 | #    error "Qt requires a C++17 compiler"
      |      ^~~~~
/usr/include/x86_64-linux-gnu/qt6/QtCore/qglobal.h:491:11: warning:
inline variables are only available with =E2=80=98-std=3Dc++17=E2=80=99 or
=E2=80=98-std=3Dgnu++17=E2=80=99 [-Wc++17-extensions]
  491 | constexpr inline Deprecated_t Deprecated =3D {};
      |           ^~~~~~
/usr/include/x86_64-linux-gnu/qt6/QtCore/qglobal.h:1009:26: error:
=E2=80=98enable_if_t=E2=80=99 in namespace =E2=80=98std=E2=80=99 does not n=
ame a template type
 1009 |          typename =3D std::enable_if_t<std::is_arithmetic_v<T>
&& std::is_arithmetic_v<U> &&
      |                          ^~~~~~~~~~~
/usr/include/x86_64-linux-gnu/qt6/QtCore/qglobal.h:1009:21: note:
=E2=80=98std::enable_if_t=E2=80=99 is only available from C++14 onwards
 1009 |          typename =3D std::enable_if_t<std::is_arithmetic_v<T>
&& std::is_arithmetic_v<U> &&
      |                     ^~~
[ snip tons of errors]







The first error says,  #error "Qt requires a C++17 compiler"


Right, g++ defaults to this:

$ g++ --version
g++ (Debian 12.2.0-14) 12.2.0
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.






It worked for me with the following fix-up applied.



diff --git a/scripts/kconfig/qconf-cfg.sh b/scripts/kconfig/qconf-cfg.sh
index a1b718a7366c..a5d5ed008dc3 100755
--- a/scripts/kconfig/qconf-cfg.sh
+++ b/scripts/kconfig/qconf-cfg.sh
@@ -17,6 +17,8 @@ fi

 if ${HOSTPKG_CONFIG} --exists $PKG6; then
        ${HOSTPKG_CONFIG} --cflags ${PKG6} > ${cflags}
+       # Qt6 requires a C++17 compiler
+       echo -std=3Dc++17 >> ${cflags}
        ${HOSTPKG_CONFIG} --libs ${PKG6} > ${libs}
        ${HOSTPKG_CONFIG} --variable=3Dlibexecdir Qt6Core > ${bin}
        exit 0






--
Best Regards
Masahiro Yamada
