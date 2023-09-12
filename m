Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F9079DBC1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjILWTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjILWTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:19:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54710E6;
        Tue, 12 Sep 2023 15:18:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502984f5018so8729853e87.3;
        Tue, 12 Sep 2023 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694557137; x=1695161937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XSY8ZMt40+LfWzUvU2F+1fAOyiq6EBAamykygoHnjQ=;
        b=rcK8J8PIHb7ji+/LF7w1U/jh3Y32JJnPN/K8veS9DSVhctseIpGWfbbbSAJ08sVf3/
         ExbEUxRT1vtxQQYRgwxhIXkwnkJPwoL7PUOBXFDWTcgiZR6fH8gIiFlFMo/d6qUSF2tU
         ETo0Dzh9NreRfbl9ART4FXNyUZsPDhxFFRNIqRrwVX0pf3MYvUGK2W8DXIrMiYCmKUug
         hr4estHz/N84FYmWEU7fwgTN8SeIYl0Cp6zgFsWd9cN3kGbdcrzTxbP725uiQl7z2zbv
         vOEhjcfdGa7CtqTnbKFr8HBXCW/DTRKWy/WKjYRenHxf8BrRXXCp8IGhwzlEIgHsbssa
         K9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694557137; x=1695161937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XSY8ZMt40+LfWzUvU2F+1fAOyiq6EBAamykygoHnjQ=;
        b=giLIyX5JSLbcsf6wmkFbrIQS+UAK/inezG7/OFUQmZeDf80efECz+XdDNJ/UIELGTt
         3q03Pb/5m8tSd+VZH1WfSIgb9MuUfcjXtlQBsoU3jNyPmdFLbKYRp2H9YS07bmpoeUCg
         7C3VytDZUbNluGUboW3j/mIHA65CHvCq8qzDO1IElYPnic/nrYAu9XTVsv+4LSYCwaaK
         YdfAh4d2CLRFyurX/CIUd0O4pO41Xy+FEIo301y1vmEgctjp3U0nL7mKYf2+T7Fwd3Bl
         gDuDFeSKb30jinNNr+INooe2enbyZuwRKLy45kuDQ/ZZ/DkAegABMiaM+maK2I3atMED
         ui7Q==
X-Gm-Message-State: AOJu0Yy4oslnq7QxtRU6sqJR/zA3WnFsEJ8HoxdvTxeWXFoU16hbTyQ0
        AFkWZFIvk+HuqPpaRD0fIwYy1y55HkQ3x2I0dAY=
X-Google-Smtp-Source: AGHT+IH1ATRVlWCPJEbWfjoxrwhYstSSqOtzKcPTYAXwwZZfbXGmszyoYb7akXifhfGbtQQ0MBQI3SlhNi2A2Y172i4=
X-Received: by 2002:a05:6512:1091:b0:4ff:95c:e158 with SMTP id
 j17-20020a056512109100b004ff095ce158mr631125lfg.64.1694557136519; Tue, 12 Sep
 2023 15:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230913081050.5e0862bd@canb.auug.org.au>
In-Reply-To: <20230913081050.5e0862bd@canb.auug.org.au>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 12 Sep 2023 15:18:45 -0700
Message-ID: <CAADnVQKt_oCgJpVv+jqi5yhO4XUb2RWzajNSsNWk4fJWD4cJ7A@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the bpf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 3:10=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Commit
>
>   3903802bb99a ("libbpf: Add basic BTF sanity validation")
>
> is missing a Signed-off-by from its committer.

Hmm. It's pretty difficult to fix.
We'd need to force push a bunch of commits and add a ton of
unnecessary SOBs to commits after that one.
Can you make a note of it somehow?
