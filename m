Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843657B326B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjI2MYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjI2MX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:23:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A4E1AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:23:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ad810be221so1902568066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695990235; x=1696595035; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sla6wmpD1DUPXq81GA+Qf96ZRYBJdn00BJ+JAxCtCQg=;
        b=RDfYwL3iPdVBDnC8c57GDN+3kAlSFgn5Pk66grBMHHnzbWdvN2tFRo44knjhLxTt5C
         9Uh5rBzShfr2JTTiOhbqy7JkGfDaU3aNlfBMuKTuPl1EzvdmLXOH8+Zve8niBcasOB6Q
         4kWQNebEPoXfwLeYrGappNCQqgPnSyr5iG7/OVStx84oRhoPxGQ36W2o3TokPG/6hqBK
         tKAnHHkhrLP1PRr7ScmXkrGstwguOGQRLax7wKx3qz8LCt/octdtupAdDbEjGypZ2tMb
         n6bOIGxa1DTBEVa9t1U6r7hxFq5NPNFIlyMjc5f02hEjapJH3MumFYJKHUD3T92Pj1x7
         /HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695990235; x=1696595035;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sla6wmpD1DUPXq81GA+Qf96ZRYBJdn00BJ+JAxCtCQg=;
        b=GvJFDnjZD38miK6LId/YcxPo23Yd+E4I7JyoFymprOkTqEBbCq4egDBqd/u0VzQBbv
         iFSkpyENu7L6/I6dNggM2ivHjsYG5qyV5tP1dyeF0uHaY4EHIGUjszro/b8vuciYF1Re
         f2mChaVYiSLKLtnMFplZcjohXaX8xBl0Z2FuJY857GUq/XQUlqjgbfJVkF37v0HZyhG5
         QOeo98kJdGtJ+QjqUnwIR4jv3lSki4riKQPZtCt3bR7YgM4dZ1strNrYV6ACB46orTnL
         A4WfZjk5djvaQt8EouElMVeSkeB5w0wYR+R2OqZn6jJp2EG5sfPOeJoejr5SlqYIJG8v
         vC7w==
X-Gm-Message-State: AOJu0YzglasZkPD0zAOlVuXzp45MrNnqiJHC1Dzs8L1LLX9JoM73rCoR
        kNZGwHxi2fNy1XWSRVYLJPpLlA==
X-Google-Smtp-Source: AGHT+IG2kjzZLb1SdI6/JkmBGM33kigR2o+WpFZUGImV1UHmk2br8Y6U1scGw32/Vw2pa3JA1cAbFg==
X-Received: by 2002:a17:906:217:b0:9ae:3210:22fd with SMTP id 23-20020a170906021700b009ae321022fdmr3509603ejd.48.1695990234936;
        Fri, 29 Sep 2023 05:23:54 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id mc1-20020a170906eb4100b009a5f1d1564dsm12209790ejb.126.2023.09.29.05.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 05:23:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 29 Sep 2023 14:23:54 +0200
Message-Id: <CVVED1K40NK5.1MFHLQH8YS4IY@otso>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add ports subnodes in usb/dp
 qmpphy node
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.15.2
References: <20230929-sc7280-qmpphy-ports-v1-1-7532c11973af@fairphone.com>
 <af19b32e-9e91-4829-8d77-9cf154e19bac@linaro.org>
In-Reply-To: <af19b32e-9e91-4829-8d77-9cf154e19bac@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 29, 2023 at 1:44 PM CEST, Konrad Dybcio wrote:
> On 29.09.2023 09:31, Luca Weiss wrote:
> > Add the USB3+DP Combo QMP PHY port subnodes in the SC7280 SoC DTSI to
> > avoid duplication in the devices DTs.
> The rationale here is to make describing the connections between
> certain hw blocks possible. Defining it in the soc dtsi gives us
> a very cool side-effect of not having to repeat this, but it's not
> the main point here

Commit message is copy-pasted from sm8550 commit with has your R-b ;)

But I'll change it for this commit since your comment makes sense.

>
> With the commit msg amended:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Konrad

