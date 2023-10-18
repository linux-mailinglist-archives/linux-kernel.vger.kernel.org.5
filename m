Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6197CD84D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjJRJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJRJhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:37:18 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A409D;
        Wed, 18 Oct 2023 02:37:16 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57b74782be6so3474182eaf.2;
        Wed, 18 Oct 2023 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697621836; x=1698226636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mvmjoKmMlu1vuqXJcefzUhvBcRzyqEdg4OF3IinxaUA=;
        b=EDGL3fVT7ChFKSFtOuSNuXRJLeXSTbiqbhVfmWpoU7LX+VOc7XDtnvAKqOi2RPFpDt
         K+rqfso2a1/pT9Is3v3Q0nBWBz0IPmLJ41UPGL0RAZIxhI/MMRsKC/Rm/FLw8/Gvg0yk
         niDsxQQZcvbP8iIS/NY+i+FLi2khUGBJcbnvx3YFqd08QY0t9q9+5wlLfMWfQqje+Hp5
         bvVSQ4kiAABnGxBphDJSadiZJFmXvn+YManYvmWRVAZiJzp94lQRFN61XrSLGZRHSpvp
         4d/yDtiY0c6TQF3++NYwt4Jk06o0TjQvjvo7vMgRT00wvBLYX0wEHol/nyQ8/Wclfky1
         abIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621836; x=1698226636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvmjoKmMlu1vuqXJcefzUhvBcRzyqEdg4OF3IinxaUA=;
        b=Vpw2gAIUHkUJRkE8ANsmAzDy+x8RG4ll939eu3u2P3UCBX4CoC3iUxslaHEeuYPYd8
         EmJEeJPY9sMDOT3847gSiTXFSLjVjPseRCC6+9E9MSQo1/Gh2Ll4vkkS47qPyC+cYWbu
         eUr3LXUZG2vCTZ6sv6V+b0qq8wC/FKWK0pi9RxDj1GcJdnfiUn/2c0vBujMct6CzUoAX
         ra9vjhr3vob+4SqKo2x8FrmLZU0rT3zZzNrobUdFWpXZty8hZJWZoYluMGyAUZw44yLW
         3cTwqNWti38ZM/zc7pG+jMuJodkSNTG+I/QztkE8LUwP9rPewhlt86LNDpllJUcegGG7
         sVfQ==
X-Gm-Message-State: AOJu0YyYgsMWaEWmw/fKlWZJ8DZD+etbK0GRHSi/5I3sAWQVXjZEs2M8
        SSsZ1iMr9iWCAtYObISphWHOhS0O8O3a8kZiTqhsecRtP1U=
X-Google-Smtp-Source: AGHT+IHqXIDtPavgXpmIDPyjZPVRV8yeo3g65Kq5ugJfuUHCkN/NFHVD9Q9MrFcEUOOcpop9fda9OxikK4tubL+UHHg=
X-Received: by 2002:a05:6871:4508:b0:1d0:e372:6b06 with SMTP id
 nj8-20020a056871450800b001d0e3726b06mr5228488oab.25.1697621836303; Wed, 18
 Oct 2023 02:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231016175532.2081344-1-robimarko@gmail.com> <20231016175532.2081344-3-robimarko@gmail.com>
 <2f22ed28-47b1-4a92-aae5-b625ab4ad731@linaro.org> <44333dbf-7023-4124-9586-2ca13e83c0fd@linaro.org>
In-Reply-To: <44333dbf-7023-4124-9586-2ca13e83c0fd@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 18 Oct 2023 11:37:05 +0200
Message-ID: <CAOX2RU553gB_5JvV+2vM2NX1NJj+bQhOO-6RiSPOFciZ58LF9w@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq6018: use CPUFreq NVMEM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 at 19:13, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/10/2023 18:55, Konrad Dybcio wrote:
> >
> >
> > On 10/16/23 19:55, Robert Marko wrote:
> >> IPQ6018 comes in multiple SKU-s and some of them dont support all of the
> >> OPP-s that are current set, so lets utilize CPUFreq NVMEM to allow only
> >> supported OPP-s based on the SoC dynamically.
> >>
> >> As an example, IPQ6018 is generaly rated at 1.8GHz but some silicon only
> >> goes up to 1.5GHz and is marked as such via an eFuse.
> >>
> >> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 14 +++++++++++++-
> >>   1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> >> index 9aec89d5e095b..49f0e6aa4b5bb 100644
> >> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> >> @@ -96,42 +96,49 @@ scm {
> >>      };
> >>
> > [...]
> >
> >> +                    cpu_speed_bin: cpu_speed_bin@135 {
> > underscore -> minus sign
> >
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> I think Bjorn does not read comments, so he just picks up such patches
> because they got review. Better to ask for fixing it, instead of giving
> conditional review tag, IMHO.

I will fix it up in v2, I am just waiting to see if there are comments
on the driver patch.

Regards,
Robert
>
> Best regards,
> Krzysztof
>
