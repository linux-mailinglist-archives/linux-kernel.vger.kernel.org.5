Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6A078D145
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbjH3ApL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241459AbjH3Aot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:44:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6BCCA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:44:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-56b2e689828so3115708a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693356286; x=1693961086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAx3hUaf67x8Bu35HoDBYJ84Q7sU3VyyMWOcJhmdXls=;
        b=MVmzGGCHceCVXKEKF/KelU/z0eELehCzttHKv5oO7Du1rSLIH0ln/2CSMje8pUe5xF
         PP2HDWxxmnowDM4gOEfksWxYgJxtilW4zyVGmIFD7dwAgQW6agg0hFKRVAlktrVSgxEr
         lnXSLwReHPs+lWOA2/35xQ4M9tSm7ytgpIW63n7GtNWOrIUvmOemWU2tDfExV0+qlYbR
         07BDlwweOdCKrock2e9ko7j82Qj2BLLOWNzFnVYLnm7O4PTfWkUO/4XPo9m32EbhflyV
         XTiG0NjchtBt4YnplGsuIXCbTGmvn3AVg41CBPx0STnSzN87+MV1rAUQGzlRbHnrXvVX
         i9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693356286; x=1693961086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAx3hUaf67x8Bu35HoDBYJ84Q7sU3VyyMWOcJhmdXls=;
        b=Z6LIPTeI3kn54G7mGYIHZ843ZO4mkHlfN2gDdLBHNRrM5Wyijsmav5R4GeJqd3CYAS
         2tC2FJPVL5idwZMI3o6YwuX1WoV7Cq7b442pkViVFjIu3u1lCRR+gl8cng2Ko3zkjGiw
         itqXfEfGglFOfJfcQIjssuxrKWsprS0/Ar1LKKjqOCM/8kW00XTLZZKYNSTvkHcQvI+W
         uU/SWbwmz1J0KY3PjcIjDDE3aSxkQua9vKXJcOfrR3nOIQ+g1EDdlj63l8hMbhiA5pCn
         jNHEJz/HqoEJzOVG3kXIut8tS4d3gFEOYH01R/o/wSm21d6+cUolqZ0dzzj+cEyut3ya
         Enyw==
X-Gm-Message-State: AOJu0YxtHGGPf42wG3op/gXe4vKYlyHS/XTxA4QWyfTCRWwHo0SeJa9L
        0Zwu+vcgA6stRfOn8Z581O/+UbiIWS/dkKfU5wD7D/HKcIUmlN1gf/Y=
X-Google-Smtp-Source: AGHT+IGK3L9I8mGxNoIS6qRuELIHILt6Wgic76VJlZ4wkMageK4SmY3xsxrz7+5yM5g6fOr1CjbqGtBAkeFZp3jZzIk=
X-Received: by 2002:a17:90a:4587:b0:269:1e3f:a54d with SMTP id
 v7-20020a17090a458700b002691e3fa54dmr777844pjg.10.1693356286018; Tue, 29 Aug
 2023 17:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230825215445.28309-1-semen.protsenko@linaro.org> <6fd3a9ab-667d-934b-f1c2-03776be93d4d@linaro.org>
In-Reply-To: <6fd3a9ab-667d-934b-f1c2-03776be93d4d@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 29 Aug 2023 19:44:34 -0500
Message-ID: <CAPLW+4njcwODXoA3Gj=48E-DPOqofcPnJkYMv6yzF5JjyOshDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm64: dts: exynos: Enable USB for E850-96 board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        JaeHun Jung <jh0801.jung@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 1:10=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/08/2023 23:54, Sam Protsenko wrote:
> > This patch series enables USB gadget, USB host and Ethernet support for
> > E850-96 board. The most major change was done in USB PHY driver, as the
> > register layout of PHY block in Exynos850 is very different from
> > Exynos5 one.
> >
> > Changes in v2:
>
> Thank you for the patch. Looks good.
> It is too late in the cycle for me to pick it up. I will take it after
> the merge window.
>

Thanks, Krzysztof! So we can expect these to get into v6.6, correct?
Also, I'm trying to keep track of all my patches, so please let me
know if you are going to apply this series to your trees soon, and
which exactly (I presume krzk/linux-dt.git/for-next?).

> Best regards,
> Krzysztof
>
