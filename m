Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF143780FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378365AbjHRPz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378359AbjHRPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:55:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912AC2722;
        Fri, 18 Aug 2023 08:55:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9c0391749so17298931fa.0;
        Fri, 18 Aug 2023 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692374145; x=1692978945;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ETDTZRuDCsJhdwG5H+kaBHFDL6q5sCZ3qYSKgjJ2APc=;
        b=MySTeByZ5+SsV8iaiMfxQLhpfIxROX6fbB07JPFNKT5hUD3rENgnmh/vclZHxyAOI6
         BKggqGCz/eGO5QoHVNHl/81qeTlje9XO/PoSVxOsjVeU7gSid6908dGCfo6blQiYtElC
         oFj7ZNw9nRXdnWgKhmRtJ2zfFg+aKcj5mrRLXYRHvHiJ71d1KOBuM5evzjANbzrr4Fhf
         jjBffDpfj3Ldpf6fSSJSTS6bTiWacfwhPca77VwVNL5U5KZpIcfhZLrL3q4ojADUedIT
         BVQkOxLT6OCdNe0DlG4RaXQyHI45+02T97wLdwjj8HiDDfGyRrbAJW4Ga6WXop3YvAnd
         bW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692374145; x=1692978945;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETDTZRuDCsJhdwG5H+kaBHFDL6q5sCZ3qYSKgjJ2APc=;
        b=fWC58HSg2zLavjL1P0I0qv5/af1F/G9Q9PpHOLS94y/s7WaHzLP+bZ3n8agBA1Vz/3
         nuPNx1iEmP9eIxVjn7Uwtph1qfpwl3XaBkIcmPmS0oom8pB7p8l9ydBhiKRyurRTrHqt
         2Y2SdpkNje6jROvPC77OolNTV7l1WYn4lm4PANI0vy5PqM7LPYqBkuKt1sHPLyUAOJbT
         7kQj1gvgMNeZ/HAJcMsfxNXz3OJZNaxIPVx+FwWF0pdnZT4o8A4ZClX6CjckN49Dpriv
         vQfivOtNLneDJeuWofYanHiHV5GC09iR7jCpNyEHgJTc/rkpQARcfGV8KgK1STGkJ6IX
         4Wjg==
X-Gm-Message-State: AOJu0YzcpmEraaZxQS+o5q0w0o08//bX2swOJUfBuij+UGouDhOHyMvy
        0FsUnxYXAB68j8s2OnpZSWQHIeQ8u6DktshY4OM9dPbaTFgFMude
X-Google-Smtp-Source: AGHT+IHM/trkFBqEk8379E2mtIFqjpKMlBzJHDsLWs9QF/V/cQUq6YYzYKtgSo7tTpYhaB0BrXrqblSoeO5R87dBDXI=
X-Received: by 2002:a2e:b05a:0:b0:2bb:985f:847b with SMTP id
 d26-20020a2eb05a000000b002bb985f847bmr2042909ljl.27.1692374144393; Fri, 18
 Aug 2023 08:55:44 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 18 Aug 2023 10:55:33 -0500
Message-ID: <CAH2r5mtF7UiHyNArEancsoUnnzghBNjh3YRBAfzjjMU=KaE6SA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
2d7b8c6b90e4054a35eb59cd6d7c66e903e8ae4b:

  Merge tag '6.5-rc6-smb3-client-fixes' of
git://git.samba.org/sfrench/cifs-2.6 (2023-08-15 20:00:40 +0000)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc6-smb3-client-fix

for you to fetch changes up to 270d73e6507f9c7fff43844d74f86365df000b36:

  smb: client: fix null auth (2023-08-16 00:26:07 -0500)

----------------------------------------------------------------
small SMB mount option fix, also for stable
- fix minor regression from move to the new mount api
----------------------------------------------------------------
Scott Mayhew (1):
      smb: client: fix null auth

 fs/smb/client/fs_context.c | 4 ++++
 1 file changed, 4 insertions(+)


-- 
Thanks,

Steve
