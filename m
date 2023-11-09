Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C751F7E71C2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbjKISxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKISxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:53:46 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8B2D57
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:53:44 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc3216b2a1so10363945ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 10:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699556023; x=1700160823; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IZlP7KMRx1o5ZJEPAnCuLQf0IFxxJqcdYtlpkJrrw08=;
        b=iw83XhQyr+7DC+k30g7xsPtTDqmtXk2xGkpNpO7sBFOJX+IA1BmhDjYBZ6eUzZPMA9
         N7TGgXeVm7lygF7ifa2Ar3UxYs+D3CaVp+Whc61ngHK6bJnRkxU+Ui24iCgvCd+9R/B8
         K4J5ttRBWnNq41EEk+UH6hZYVJxZoG0A2A9/58M6DHnVIHj1CoxVlCYz+4VPinayzN/d
         KzHBHgKk7jnmbUQ9D6UPp+3fsvPtPYOuglg8aqVQwNSJzOzWXYBGdBPVFStCEQ3JztHY
         J7TQ/Ypze6z/3DfMtSxGDNF8OjHqbmqjCxWNNhqak6IvA1CIAnw22siVjSOmjfkwyD5t
         BtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556023; x=1700160823;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZlP7KMRx1o5ZJEPAnCuLQf0IFxxJqcdYtlpkJrrw08=;
        b=hGGaQucw5OaOJHDijp42T7j2zlAZSIo+UtqCOm5l3NMdl9cOcPbuOw5vx1ZQcUTYMZ
         0LjBDaFMeD8JTo3YO2J33MvNTEbu4ol6xKYom3asuG795qOqajV+QFk5wU7sXjGE+BBX
         JahBBSpdzVJ5NATh7CEC5sMXn5SSpAbs3N7FH/8BPshiFt4YFGWqkOHPwuVd71eemoTA
         ICZT/rnuDtFnuq/qO57oVVVLg5MA2m6DBkEd0/mx4tvQdQztHUDxZpjQIKP/AEPZiZpG
         GT+DUlghGPdNY7rXSePLE4B+D4xv+pX+OsqB2mfCp+2sGwKhy/R12znK5pRmiy4cpOGt
         uc0Q==
X-Gm-Message-State: AOJu0YypT53yT8F1jr+kne0XEZ2uueJqyrvJeHr2Hr6Ymg3l76iSMZnG
        x+HsCccb+SeOdvYQutTAkSxr6+bZxBvqizrzYzl9Xo6cqBRAUA==
X-Google-Smtp-Source: AGHT+IEWIYkleWwE1kqsNYjpcgM0aFTp6wG4vvWq7i+K2jeBjdmRYhVnli2cXjCgyuRL4slVbnJw6Zd020XoqJBJ+rw=
X-Received: by 2002:a17:903:2450:b0:1cc:5833:cf57 with SMTP id
 l16-20020a170903245000b001cc5833cf57mr7133831pls.45.1699556023304; Thu, 09
 Nov 2023 10:53:43 -0800 (PST)
MIME-Version: 1.0
From:   Andrew Randrianasulu <randrianasulu@gmail.com>
Date:   Thu, 9 Nov 2023 21:36:02 +0300
Message-ID: <CA+rFky47GhkLBCis+ZmP_e+2MjNXt6oukqBhCf=qBGySxiGAJA@mail.gmail.com>
Subject: drivers/media/pci/solo6x10 fails to crosscompile from 32-bit gcc
To:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=3D=3D=3D

make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-unknown-linux-gnu- -j8
mkdir -p /dev/shm/linux-2.6/tools/objtool && make O=3D/dev/shm/linux-2.6
subdir=3Dtools/objtool --no-print-directory -C objtool
  INSTALL libsubcmd_headers
  CALL    scripts/checksyscalls.sh
  CC [M]  drivers/media/pci/solo6x10/solo6x10-p2m.o
  CHK     kernel/kheaders_data.tar.xz
  CC [M]  drivers/media/pci/solo6x10/solo6x10-enc.o

cc1: out of memory allocating 301930784 bytes after a total of 149139456 by=
tes
make[6]: *** [scripts/Makefile.build:243:
drivers/media/pci/solo6x10/solo6x10-p2m.o] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=
=D0=B0 1
make[6]: *** =D0=9E=D0=B6=D0=B8=D0=B4=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B7=D0=B0=
=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B8=D1=8F =D0=B7=D0=B0=D0=B4=D0=B0=
=D0=BD=D0=B8=D0=B9=E2=80=A6
virtual memory exhausted: =D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=
=D0=BD=D0=BE =D0=B2=D1=8B=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=BF=D0=B0=
=D0=BC=D1=8F=D1=82=D1=8C
make[6]: *** [scripts/Makefile.build:243:
drivers/media/pci/solo6x10/solo6x10-enc.o] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=
=D0=B0 1
make[5]: *** [scripts/Makefile.build:480: drivers/media/pci/solo6x10] =D0=
=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 2
make[4]: *** [scripts/Makefile.build:480: drivers/media/pci] =D0=9E=D1=88=
=D0=B8=D0=B1=D0=BA=D0=B0 2
make[3]: *** [scripts/Makefile.build:480: drivers/media] =D0=9E=D1=88=D0=B8=
=D0=B1=D0=BA=D0=B0 2
make[2]: *** [scripts/Makefile.build:480: drivers] =D0=9E=D1=88=D0=B8=D0=B1=
=D0=BA=D0=B0 2
make[1]: *** [/dev/shm/linux-2.6/Makefile:1911: .] =D0=9E=D1=88=D0=B8=D0=B1=
=D0=BA=D0=B0 2
make: *** [Makefile:234: __sub-make] =D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 2

=3D=3D=3D

kernel git 6bc986ab839c844e78a2333a02e55f02c9e57935

cross-gcc

x86_64-unknown-linux-gnu-gcc --version
x86_64-unknown-linux-gnu-gcc (GCC) 11.4.0

cmd line

make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-unknown-linux-gnu- -j8

for now I think I'll just disable this driver
