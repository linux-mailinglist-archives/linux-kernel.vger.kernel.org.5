Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6F7D0E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377005AbjJTLCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376881AbjJTLCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:02:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291ACA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:02:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c434c33ec0so4727895ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697799754; x=1698404554; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Wt9pYz4CRU22PTPdIJj4PW5fWRuN1U55iuG6Bwyem8=;
        b=dXdJmWhP1vwpttWjy/2B079zu5zR7mUNX0DwymQ1FZHjeh18ASMRJaIAv7m2s3MGmH
         5EJie0sxdvOny7XaVR1FvlMZpsxOjIDHd0b5AgPnJ1NhLO6ask+mOKH910jobl4Ja39J
         cbIsVq2p9/1CR9UYjiHoZeVyqcNnzWVKzXHyL1AOnoa+GQtxihrcV8oXo1hiT0Gw3+i8
         6Wl1k0a1ReQPf0otSO39JATCpKOgp3VsynlRpgc59Wwr2INbZGUxKLYMb5JWAFyAggTN
         zi+gRmpqQt0TLvNQgTfJZ0QGyq/3u0arFG6dzTkvBfit07qJqY1rSVhDCIa6xaqIOO3p
         8WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799754; x=1698404554;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Wt9pYz4CRU22PTPdIJj4PW5fWRuN1U55iuG6Bwyem8=;
        b=mntqZCsfaXVKdV1hjp5ke5ZhxiAwi6KRONNESwzWVtVaQa2LpH8hMK9J3QnzLZBJd3
         iF5G4azQlG5M8Bp6Sby+gMdNb4Wlo5CKA/cieNQqEMxq3R59h8WaQjIh5wumzK/gt/dW
         qJFUxcY57AsAFPMu7YZfaEt8E8ZU4u6KOmSalCN9K3OeIjemWermqshON3be8FufpW+I
         n2nyuSv3oq8Ok3QXJYUgFgBu51jpBT1+SYYC3dbNabC51nxXjbXetw4GxkhfJTl5eGuG
         bj7uUWqyoBaRy9AHod+fkixVHz+7QTD/O9jfVHmHlGhDb8xLj6n+ZJcXzEVCuPqeyaTr
         m0uw==
X-Gm-Message-State: AOJu0YwOY5HIdFbpnWnlridlis0bmosnOPhLwIXrquYQEuWpu2+p2Yjx
        uSoQWKvndwT/x18yGrb6H9hbVr3vz58=
X-Google-Smtp-Source: AGHT+IF88M7siSDLIoueb3dYWu/bKRETvv9v49o72BAN39WMN/kEIafCYuwgmBxBo3BTl2tiPfy+lg==
X-Received: by 2002:a17:902:ec8e:b0:1ca:82f0:131a with SMTP id x14-20020a170902ec8e00b001ca82f0131amr1985172plg.19.1697799754311;
        Fri, 20 Oct 2023 04:02:34 -0700 (PDT)
Received: from smtpclient.apple ([2401:4900:6152:db63:60f6:8040:200a:1c34])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b001c736746d33sm1258196plg.217.2023.10.20.04.02.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 04:02:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   "Subin C. P." <subincp@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 20 Oct 2023 16:32:20 +0530
Subject: Log crash to nvsram
Message-Id: <90A41B49-400C-42FF-9C77-A17032F219D0@gmail.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (20C65)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apologies if I=E2=80=99m intruding. I got this mail id while reading Documen=
tation/oops-tracing.txt.=20

I=E2=80=99m getting below kernel crash. This is logged to serial console. I w=
anted to write this to a non volatile RAM. I=E2=80=99ve registered to panic _=
notifier_list, die_notifier _list, cpu_notifier _list, memory _notifier _lis=
t, oom_notifier _list. But my callback is not getting called during this cra=
sh in order to write this to the nvsram.=20
Is this log happening outside kernel? Can=E2=80=99t we get a notification wh=
en this crash occurs?

****************************************************************************=
***************
cpu_4 received a bus/cache error(warning)
****************************************************************************=
***************
CPU (XLP specific) registers dump: Node=3D0
    COP2: TxMsgStatus =3D 0x00000000, MsgStatus1 =3D 0x0f0f0000
     ICU: log0 =3D 0x00000000, log1 =3D 0x00000000, log2 =3D 0x00000000
     LSU: log0 =3D 0x00000000, log1 =3D 0x0000000000000000
     SCU: log0 =3D 0x00000000, log1 =3D 0x00000000, log2 =3D 0x00000000
     TCU: reg0 =3D 0x00000000, reg1 =3D 0x00000000, reg2 =3D 0x00000000
     NBU: reg0 =3D 0x00000000, reg1 =3D 0x00000000, reg2 =3D 0x00000000
  DRAM_A: reg1 =3D 0x00000000, reg2 =3D 0x00000000
  DRAM_B: reg1 =3D 0x00000000, reg2 =3D 0x00000000
  DRAM_C: reg1 =3D 0x00000000, reg2 =3D 0x00000000
  DRAM_D: reg1 =3D 0x00000000, reg2 =3D 0x00000000

     CPU: epc =3D 0x105bc310, errorepc =3D 0xffffffffc1024270, cacheerr =3D 0=
x00000000
****************************************************************************=
***************
 Unknown Cache error in exception handler!
Can not handle bus/cache error - Halting cpu

Thanks,
Subin.=20=
