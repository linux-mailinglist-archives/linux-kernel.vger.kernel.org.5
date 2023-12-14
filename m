Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DFD812C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443556AbjLNKLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443503AbjLNKLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:11:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E771B2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:11:24 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so54999585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1702548683; x=1703153483; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DwJPwRC5n42ZUrIXnJ3iNJ62mEI4hAuX8AmnWt5GOxU=;
        b=AAH5T3/rqEOq2dzaJ2Ufabe5Mk6VaPvprls3UoMcYTv3bRd2kHUJyazl7R9nr1vPWj
         5ZUCc3fuGsOgDCOCFmc1+o6j+Ydd79pY7yi8VIg65Kk1fIDUlm3uKrq/2Vk10bTOjVTM
         /4G/SxdXrDOhOnPCKjuC070BEjLNgO3j8jLtJ2W6ER8/JkTxT39VXK42aR7ohNzBmBRj
         gYPaL3NwFw7I2y8gugnda4SgSqL2eDIAoYjft1emCBKqLLapFCHlvH2uPHSwI6IlFTPc
         c1lUSiMohcKB8urIMmbh7r/4KPtRxbVfOR72xm7HXUbPE7lBnEa+TvVFA/j8uQ2Ow4QM
         Vhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548683; x=1703153483;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwJPwRC5n42ZUrIXnJ3iNJ62mEI4hAuX8AmnWt5GOxU=;
        b=jhFQbY3u0J1EL7TektzjEJGyd0yUwwLgJ3ZGQ8AnLN+puWfRGrcpdzjZCNb0sDz11o
         xK3fwtIyapHLkJGx4MMoDViFS3AqdPdmEfyeA55YYyAVjvd9nYjV+66NpaM85aC2LAOl
         6s5ti13smgW8gsXzO3WY9aTNesOj7sSx4T+1C2DtldCmjtsFsvEHgpu3znDJtdYsvmJd
         ST5loz95MTq1pw3DzSDJFsIfzId/7lyMaDQMrP2i2b8Ms164UJSY9RqdFuPHlQWOEvMQ
         8K6Lv5wzIZkFjh22uREAAlIosSLa3b/clTCXdYr5mHlLKeIsMVlWy3NV/4nWajNviNgW
         Ww+g==
X-Gm-Message-State: AOJu0Yz6HFoygLyNxFaxJQyeh4RybGlFX/sTRnpuTYpnyhTDuskzibi0
        +ihkHHw1TzKUCR4TnNxpJF7iAfyvgGDJDWNlHCGdUQ==
X-Google-Smtp-Source: AGHT+IEwCgUn9rve/eSSnIs2eQKl/d1mHCrM3llLrsOtX7YNvUUHF9eUP2ONysYZWLp41VSUnG0cLA==
X-Received: by 2002:a05:600c:3b1f:b0:40b:5f03:b39b with SMTP id m31-20020a05600c3b1f00b0040b5f03b39bmr2857734wms.189.1702548682746;
        Thu, 14 Dec 2023 02:11:22 -0800 (PST)
Received: from 2001-4dd0-53c2-1-52b8-d67b-716b-9a96.ipv6dyn.netcologne.de (2001-4dd0-53c2-1-52b8-d67b-716b-9a96.ipv6dyn.netcologne.de. [2001:4dd0:53c2:1:52b8:d67b:716b:9a96])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040c4886f254sm14119157wmn.13.2023.12.14.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:11:22 -0800 (PST)
Message-ID: <c812ea74dd02d1baf85dc6fb32701e103984d25d.camel@mwa.re>
Subject: element sizes in input_event struct on riscv32
From:   Antonios Salios <antonios@mwa.re>
To:     dmitry.torokhov@gmail.com
Cc:     rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Henrik Weinstock <jan@mwa.re>,
        Lukas =?ISO-8859-1?Q?J=FCnger?= <lukas@mwa.re>
Date:   Thu, 14 Dec 2023 11:11:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I'm having trouble getting evdev to run in a simulated Buildroot
environment on riscv32. Evtest (and the x11 driver) seems to be
receiving garbage data from input devices.

Analyzing the input_event struct shows that the kernel uses 32-bit (aka
__kernel_ulong_t) values for __sec & __usec.
Evtest on the other hand interprets these variables as 64-bit time_t
values in a timeval struct, resulting in a mismatch between the kernel
and userspace.

What would be the correct size for these values on a 32-bit
architecture that uses 64-bit time_t values?


Kind regards

--=20
Antonios Salios
Student Employee

MachineWare GmbH | www.machineware.de
H=C3=BChnermarkt 19, 52062 Aachen, Germany
Amtsgericht Aachen HRB25734

Gesch=C3=A4ftsf=C3=BChrung
Lukas J=C3=BCnger
Dr.-Ing. Jan Henrik Weinstock
