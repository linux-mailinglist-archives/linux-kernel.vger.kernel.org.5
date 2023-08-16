Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC377D8D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbjHPDGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241489AbjHPDGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457872684;
        Tue, 15 Aug 2023 20:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E696471A;
        Wed, 16 Aug 2023 03:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE7AC433C7;
        Wed, 16 Aug 2023 03:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692155171;
        bh=KEjlrLZtYJv66nW3aqlVJkY4yIP7El3uRorpItbBrtQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hdq319xhOLrap5sCgeMwRs8dPmf2HKlbNivaG0ko844rQnq0RptXgf4fBdmBylpuU
         voN937Ql0NSiMHBzf82MSO2Cu/Il6bIttkTf0bv/shKbsEk/ArH/slxcwpD/379WmF
         5oElU3Zw5Pri1klakgBB89fhqM4Kte6v7ZdqShumJ376nzoMFbQb/zEmi7bbq9jQWk
         4f+dlkg+T748alT+09PYy4+SJTK/JuIGKtQamUzBLl8Y1RMLTAEk7ARMus1dp3CHJs
         5rJ58BKyIYIzN5czAtfjUy1euyylLO59b4muZnBAAFJzukZYkOYir1dntbOdHhxF6R
         KcWW+1U8yzJng==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1c4c7a83bcdso2526501fac.0;
        Tue, 15 Aug 2023 20:06:11 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxp6eeJQdANAYYAswGZUpe58LSGUlAXiyzmHGi0JGBmC5lZM2T4
        QTf8GTJCyP5PS1ALAJ0QY7s+0QbjsaltZhEFOuI=
X-Google-Smtp-Source: AGHT+IGw9jqUHcVXQCWBXXEzmt5aHof2d1HRWaknUdJ/zjPUK853onf72od52gGVCYM6xXMm8CGmgmiocNDflC+lOHo=
X-Received: by 2002:a05:6870:d689:b0:1bf:607:e0f2 with SMTP id
 z9-20020a056870d68900b001bf0607e0f2mr728673oap.29.1692155170528; Tue, 15 Aug
 2023 20:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230809114231.2533523-1-boris@codesynthesis.com> <20230809114231.2533523-2-boris@codesynthesis.com>
In-Reply-To: <20230809114231.2533523-2-boris@codesynthesis.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 16 Aug 2023 12:05:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZ6nhe96=8O2dRt3hPqj9v=5DJGgkt+CWuSkpvkCKanw@mail.gmail.com>
Message-ID: <CAK7LNARZ6nhe96=8O2dRt3hPqj9v=5DJGgkt+CWuSkpvkCKanw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] kconfig: port qconf to work with Qt6 in addition
 to Qt5
To:     Boris Kolpackov <boris@codesynthesis.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 6:10=E2=80=AFAM Boris Kolpackov <boris@codesynthesi=
s.com> wrote:
>
> Tested with Qt5 5.15 and Qt6 6.4. Note that earlier versions of Qt5
> are no longer guaranteed to work.
>
> Signed-off-by: Boris Kolpackov <boris@codesynthesis.com>


Applied to linux-kbuild. Thanks.


I sorted the include directives alphabetically.


The following is the diff from your original patch.




diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 3a4d7a19e800..620a3527c767 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -9,7 +9,6 @@
 #include <QApplication>
 #include <QCloseEvent>
 #include <QDebug>
-#include <QScreen>
 #include <QFileDialog>
 #include <QLabel>
 #include <QLayout>
@@ -17,8 +16,9 @@
 #include <QMenu>
 #include <QMenuBar>
 #include <QMessageBox>
-#include <QToolBar>
 #include <QRegularExpression>
+#include <QScreen>
+#include <QToolBar>

 #include <stdlib.h>












--
Best Regards
Masahiro Yamada
