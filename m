Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE67D80B5F4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 20:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjLIS7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 13:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjLIS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 13:59:50 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557B7F9;
        Sat,  9 Dec 2023 10:59:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1c7b20f895so372543566b.2;
        Sat, 09 Dec 2023 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702148395; x=1702753195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndTha4anD1aznZ6EZWV8m1hC/zS0G2iSKtGiySv+I10=;
        b=Uclu4fdjqvkLSi5inwIc4enFWBOygo6CQI8wyB54h3tFD2LMiV3lRzSYQSZOC4MuuZ
         MNT4nYhQUOLP9ie8Zn7tIGsENcXmNg+q2oJbSOnKBk/sJMI/tSUWwwz0zYegxhqAgPDw
         9oe7uiujtcHajSx8yu6l4ehCPNi/WubyndsCFx/Ltk3j/tH3KPom3VsEMI5VCmKKkMFN
         zGkrCo2cgScG2egx/zC+ZJ3EHY4BLrZcsb6UazWFr4+syMWDGIfGjY12CyMUqUJNx2zs
         hnmyUJS6c07OVsH5vSztewfUuk0/KyZm+ErX3ROzd2VsLdmla7B8HGf/GQZZo3qdmSw2
         nKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702148395; x=1702753195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndTha4anD1aznZ6EZWV8m1hC/zS0G2iSKtGiySv+I10=;
        b=j5XIbHl3WzUquy9Wgq9kTFDyEPJ9jPOwSyyC1MsdP4wFXJ9W0mvEcfmtSXfe3x8u1m
         JykIpcKpuFyLwwkesH6rFI5Qlamt9xnfsytWDZ296Es/V0jMJa8M+1hJKjgG+uYtcsTh
         qKluammAimLxYyBD57rexUGaiIkQavf1LBgIzt+lLs5wTkuKLCXWKyB2LeFDfjOltfaZ
         od0ZmeSYNk8WyAQYBaRfNKAVtAlfHftTvgGNZt2L1mXnP1edqAc13Z3pIdOE71zHfZcj
         yy2+kdDLmUdmdvabru9xx2H5KVq+3iqeD+VotPvb5kwZn7pHPCOysLAkT4/otFgryBMX
         sVbw==
X-Gm-Message-State: AOJu0YyYQfZfEO0KT8gfd5UM3R1jGo+uEHGvdlEB3L61UZTNGQw+RErR
        vyebXTNamkFbYDyW0/E/O4Hwj23gjuskTCRyWow=
X-Google-Smtp-Source: AGHT+IFSNwed3LE/BAR09oAI9nX5Q6nVPIbx6h/kpZ/S0cOetDuH9WHFP8Fd1fjxwbC5NhniNpB4LyOrDoG3LHqR+n0=
X-Received: by 2002:a17:907:7f26:b0:a19:a1ba:8cba with SMTP id
 qf38-20020a1709077f2600b00a19a1ba8cbamr969888ejc.88.1702148394542; Sat, 09
 Dec 2023 10:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20231111204916.35835-1-krzysztof.kozlowski@linaro.org> <9f611e20-9530-42de-b794-b6210f465bf1@linaro.org>
In-Reply-To: <9f611e20-9530-42de-b794-b6210f465bf1@linaro.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 9 Dec 2023 12:59:43 -0600
Message-ID: <CABb+yY0oTSakkY8FXaRMON=qO+uRQX73OEB8LXoo3XT77n98fw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mailbox/arm64: qcom: rework compatibles for
 fallback (continued)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 3:52=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/11/2023 21:49, Krzysztof Kozlowski wrote:
> > Hi,
> >
> > Changes since v4
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > v3: https://lore.kernel.org/linux-devicetree/20230322174148.810938-1-kr=
zysztof.kozlowski@linaro.org/
> > v4: https://lore.kernel.org/linux-devicetree/20230327140752.163009-1-kr=
zysztof.kozlowski@linaro.org/
> >
> > Important: v3 and v4 are quite different.
>
> Jassi,
>
> Any comments from your side? Can you pick this patchset?
>
Thanks for the ping, though I hadn't overlooked. I want to wait enough
for platform owners to ack or comment.
Picked now.

Cheers.
