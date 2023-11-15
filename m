Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99F37EC92F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjKOREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKOREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:04:04 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CF11AB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:04:00 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28019b66ad5so653600a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1700067840; x=1700672640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vXjZi1TWybvJvWusx2LE/qbFHFpHMDPrWyl59LPtpg=;
        b=gsu7AaESz/BpWzy8JIO1t+cXWcA7KiA7xJE53dbNRT1xROB9j/loENDymuKL/+F5dk
         yWxXTIMDMBnBEWKul35GVSSkYzoOkGuc/fDZKapjm1UHPbb+fQ4ekhH3AjFWAxKeKy+G
         1LuRYtuPoY+xbXol9v7Fh6KEVk16nlo7CoGDiNT2DYwBKbLOma3iBI4xF1W6llM55xmn
         A6oO7y5UNeErwSKV+oBU8NQCvJKGa3px5hawDlIMdkN2kxXTiCT0CbSo4gpcZaIFuwAQ
         aXzntc7AosqlVw9Qd4oe7wIUV/WOhQWLbsnj0cZdDA4e3p/uXWbHNKtDJbZYQjoVKAl0
         3n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067840; x=1700672640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vXjZi1TWybvJvWusx2LE/qbFHFpHMDPrWyl59LPtpg=;
        b=rgELwOFhK7b9cIMswNCJ6h+1vUvoaJj1zziL2iJSqS0AMfvF9zO5viag7b32giTGF3
         /DhyaQbsBrR5LHdgTM1rpRdU5fm+vzbqWcC2rcXYiE1k3Sm2i4PaDEZRdqnjF16PZHpb
         LbnVVJKY4rsNHDJ/FziFRM+TpWnB2MW/PK2O2BgJfu8RfycZrnCJg5/OkoIiT8ifUTUw
         hzlHTWva2VaeESMmwuFsr8KTQ33n/KdpDlCpiKGW7uBL0YU14g0Cy44zV+X+9Gpd/mK2
         99mKCHPObQPcU7s696ZtwUtQWHOc+AiM0ngISL5uJw5lmaBNAxx4yiMrfQ2WkjBply+g
         w6Vg==
X-Gm-Message-State: AOJu0Yw6LfM5EziY4qG450PJTBu2rXdBvQ8zJia8GbNN31wfTDILTMxJ
        TQAclxxC8CJaUirT1wkRZ+cGKGYnYknftm685Ndt1g==
X-Google-Smtp-Source: AGHT+IEXxL0Hb77ml1/HRd/tgPldZOLlZgj9iohwffkaNcHKxiyHPI9T/wh7OZhMep77EWc97jgS7nM7mNVYzT9tQHU=
X-Received: by 2002:a17:90b:1b43:b0:280:472b:2e82 with SMTP id
 nv3-20020a17090b1b4300b00280472b2e82mr12995352pjb.39.1700067839650; Wed, 15
 Nov 2023 09:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20231115032515.4249-1-quic_luoj@quicinc.com> <20231115032515.4249-9-quic_luoj@quicinc.com>
 <a1954855-f82d-434b-afd1-aa05c7a1b39b@lunn.ch> <cb4131d1-534d-4412-a562-fb26edfea0d1@linaro.org>
In-Reply-To: <cb4131d1-534d-4412-a562-fb26edfea0d1@linaro.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 15 Nov 2023 18:03:48 +0100
Message-ID: <CA+HBbNGnEneK8S+dZM6iS+C8jFnEtg4Wpe2tBBoP+Y_H0ZmyWA@mail.gmail.com>
Subject: Re: [PATCH 8/9] net: mdio: ipq4019: add qca8084 configurations
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Luo Jie <quic_luoj@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 6:01=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
>
>
> On 11/15/23 17:20, Andrew Lunn wrote:
> > On Wed, Nov 15, 2023 at 11:25:14AM +0800, Luo Jie wrote:
> >> The PHY & PCS clocks need to be enabled and the reset
> >> sequence needs to be completed to make qca8084 PHY
> >> probeable by MDIO bus.
> >
> > Is all this guaranteed to be the same between different boards?
> No, this looks like a total subsystem overreach, these should be
> taken care of from within clk framework and consumed with the clk
> APIs.
>
> Konrad

There are patches for QCA8084 clocks:
https://patchwork.kernel.org/project/linux-arm-msm/cover/20231104034858.915=
9-1-quic_luoj@quicinc.com/

I guess all of the clocking should be done there, it isn't really a MDIO is=
sue.

Regards,
Robert

--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
