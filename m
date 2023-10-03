Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFE7B6D4A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjJCPjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjJCPjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:39:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AB195
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:39:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-503397ee920so1316520e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696347578; x=1696952378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ExDWs22CqouqpPu+z2OTT2+Lny2f2DrlLFQpikfKgc=;
        b=JIb/uNT3XeRqcVwJXYX+nV50CpAfzSrATpQcA7GG2Kbc1vzNkb7CyTWdXpjyv0M2nC
         j8AWaFSVAfRjprgh50SUUH7mjvKgB/64bbbs+v1nFoOFPXXPtfg9GZd/nAx83wJFk59l
         a4uhWOTMP9fy5ZdGT0Ta32rFEgrsnqtHbal3E7FEWhpChhiZHNbDmEqImVHTm2G5azG2
         K0/s0v8GUBIlUAgWBs8HHLZWKzFe20G6StjjVfuCgcz4NnxTpUzxMXkp27wnJJv5w5tl
         kSr2ktFPfotjEDohdEA1n85nWmciaxZbUesWw+opfIHT86z9OUzqjto3k2sH/Sz+AKOR
         2ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696347578; x=1696952378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ExDWs22CqouqpPu+z2OTT2+Lny2f2DrlLFQpikfKgc=;
        b=t3sgPK8kU5zvt/SfOaSIy5k7sPVcn2RJ1Arn7OnVwcJq+RSf1yLFLXqzMnRnLAEQjC
         yNiiRZ2cOSvm2dtR54fg+vOODqLoWYPiO1kXItH7RHuiMFnNyg7JhvkAmpySg43e8eDS
         Fm/kHI4WfhJsgdszhYk8Ibssf0o49a269cWEmjFq77HoRTMXSdu0GUzwADFmrYZoGMAY
         LLhw3Ad9loSrHlOYiK6Nfwuvn1+QHXxvc22dxbrXj43mSGdzOQ7xc3CsvydttLsF7L/s
         /YmJwqwKZ5pxU067xHLESG1Jsy2pQFEmfz+juFS+dxR4/D7SYe7M6cRENBpP63+SWXiT
         ZU+w==
X-Gm-Message-State: AOJu0YzAOztXW2Ett4XXw4F5SWGyM83HCl+6OcPJXmWuTCiieZoDDtP9
        66BtkPPTLGXWm1mICZDo4kLvF/z9FXIOmGZMnTo=
X-Google-Smtp-Source: AGHT+IFZ5IvMYGEoG5wA5ML1toOnz+99UBbJfQ355ZBlwsVuO/M288NZFve5quihP9al8o8wuaVELi19PSmiEquHsoE=
X-Received: by 2002:a19:7716:0:b0:503:1875:5ae5 with SMTP id
 s22-20020a197716000000b0050318755ae5mr11001875lfc.38.1696347577773; Tue, 03
 Oct 2023 08:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230926150316.1129648-1-cleger@rivosinc.com> <CALs-Hss+OK-vJy_ZKjVbGh7rTBZA+GditWcdM1XjDDskGF76Dw@mail.gmail.com>
 <10997d30-e6b7-4a24-a43e-e22679e8d450@rivosinc.com> <CALs-HssAAgbdUuoCyPEdjs+8yH+a8Gzz7jCpMre-6k21aE_sdQ@mail.gmail.com>
 <CAHBxVyEOvJy8gBfqW9v96XwW6_XFoWb3RdrL=AqMHJLHS7n2ww@mail.gmail.com>
In-Reply-To: <CAHBxVyEOvJy8gBfqW9v96XwW6_XFoWb3RdrL=AqMHJLHS7n2ww@mail.gmail.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Tue, 3 Oct 2023 09:39:26 -0600
Message-ID: <CAP6exYJOvjvuyBBk81+wndFqONKZXn6aCgVPeksGe5rQXZ0xNg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
To:     Atish Kumar Patra <atishp@rivosinc.com>
Cc:     Evan Green <evan@rivosinc.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?B?QmrDtnJuIFRvcGVs?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Maslowski <cyrevolt@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 2:40=E2=80=AFAM Atish Kumar Patra <atishp@rivosinc.c=
om> wrote:

> IMO, it should be sticky until a reset.

that's a wonderful idea; perhaps this discussion needs to be held
elsewhere, esp. as it regards possible violation of the spec. Thanks!
