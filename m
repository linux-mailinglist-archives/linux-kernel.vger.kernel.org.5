Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7467E4688
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjKGRHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKGRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:07:00 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F1DB4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:06:58 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41e3e77e675so39118831cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699376817; x=1699981617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+VaAdPtkAnBxuKvSA0PBWxh7jsWLqK/vaILkQ8So3E=;
        b=UkzqtvYGhPwyap3n2XX0ySxqMhlPo0hgtt1LpbBw+BGJ1DDAj+v4D1MEa96y2YV0W8
         tlSAfmCU4WdoNMg25701Fh4JHllZAYTt56RAvQEqAhyuSIafE+0Qg4NM6bUjWVr894ZT
         JyrwAwgwq65Q5nq6CKlNcuO1Fq8BL8RzVw14q/zRLgdHbHKcEtYA6GFv1gzVzI5NEe9S
         AmFZcrwltd6r61Q3QTX1S7PptjmeOr66uPTN0Z+K7UJIuPzHuroYpfsibb+zqxx60UGl
         QEH09OyFrWv4xoRCr+ShriwyZUXNH3xlUBP16v5QjpA5zEfKpUiFaL3U29SoI/kAIlr/
         ZhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699376817; x=1699981617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+VaAdPtkAnBxuKvSA0PBWxh7jsWLqK/vaILkQ8So3E=;
        b=R18AqjjulurEGxUDP4p+utea39cF2FpubKDUg7ZkD32I1RA+3bX3py+1+LkpBLkf2U
         UOiHXm5p3UPE5YkJ4LBDEXWwH+mliDGXc17TiqD7JmhRtcG+IOMDzUkbEb1wmeeaGLPP
         Oxte1h1hNZkZeoMP/IlmYsiImV+pN9p9XQZ6jDbyj4PwzhZ1hkXlDDbunD/ydXCNlf8z
         MF9tA9XXNRVGkIPJ3ZTKQS6BCsUDDNDKbS4ge2qAIsJvQc4qWL5ePtWtsl0YRqkAXDC9
         iYpXdUoQksX/qraZUEBEq9qdAY8CrMpOmHJZl61DrDqvrEwym+eOE71osUeOc3NfxZ7C
         H2VA==
X-Gm-Message-State: AOJu0YxELR7kQK/sF9P3X5irk+b+LJTm7G8f+yfJ0o9iFcSzw7dl9OGV
        XtrIHdMs3LlSpSsNpfyxOJJ+XzF1N1oAQNo7SKww4g==
X-Google-Smtp-Source: AGHT+IFukxLzZgJhLzuXpVAkNm8hPSJQTZrWH85juaxJ8+6n0AWDzjWoLSL7BNoyHJP0Z40vjZs+kNKe5cnnKJw7F2o=
X-Received: by 2002:a05:6214:2b05:b0:66d:18ab:b482 with SMTP id
 jx5-20020a0562142b0500b0066d18abb482mr41717674qvb.63.1699376817112; Tue, 07
 Nov 2023 09:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20231026080409.4149616-1-jens.wiklander@linaro.org> <20231107114630.GE954129@bogus>
In-Reply-To: <20231107114630.GE954129@bogus>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 7 Nov 2023 18:06:45 +0100
Message-ID: <CAHUa44FfnUbQVE_+R-wU+fKE=v_ZhTb49VBM5bP7tdgYAT2nTQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 12:48=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Thu, Oct 26, 2023 at 10:04:07AM +0200, Jens Wiklander wrote:
> > Hi all,
> >
> > This patchset adds support for using FF-A notifications as a delivery
> > mechanism of asynchronous notifications from OP-TEE running in the secu=
re
> > world. Support for asynchronous notifications via the SMC ABI was added=
 in
> > [1], here we add the counterpart needed when using the the FF-A ABI.
> >
> > Support for FF-A notifications is added with [2] and this patch set is =
based
> > on Sudeeps tree at [3].
> >
> > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander=
@linaro.org/
> > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4=
-0-cddd3237809c@arm.com/
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.=
git/tag/?h=3Dffa-updates-6.7
> >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version=
 to v1.1")
> >
>
> FWIW:
>
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks, much appreciated.

Cheers,
Jens

>
> --
> Regards,
> Sudeep
