Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C0F7A9D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjIUTap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjIUTaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:30:09 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C9BA7B7F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:01:40 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-792965813e7so48580639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695319300; x=1695924100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g7keM3Y6fMhMfFMuWtMa5jx/7Kzyqu5FnvjTMxZXwko=;
        b=bPthNlKHuX9vNaMKhARaQldhaz2bk8ptFedf1LHMyQumGQFxu13+s/HIXEHS9dV3aP
         obmP8IOIYCLG7cOPtbNhCH01uzKkzAcGOYDLBSmXVuJT2sRG9lqlUfs68h6YpY8qYuet
         8M2irE35I01PnyHoqnQKTBgdU1SCXdlVs/BHRgckwL3u7x7zIrVpKuOt+CDDgV5MbxfR
         /+jSwGcoVvhqY3rtlV3zBXwEP31QcNM6ejYnzuE2B1/26QbWozQ0w1+EnTqQFAfuZzdj
         7TMK9F9WK1elwk04lRpjYwXX2uTHxA/Kj337pY1NYBG7sC0b4iJ0PfXX9VXGFOpnm6VE
         qG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319300; x=1695924100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7keM3Y6fMhMfFMuWtMa5jx/7Kzyqu5FnvjTMxZXwko=;
        b=TZqeGyEEQjYx1kxm+rnjG1mBjm2U5cJorI2JNVl9AAm4H6n6Epl33jyfsBVe+jIEbn
         /WyA7RTsQb1NQVZ0v4ApKHDW5v7vkjnRVEfcGMhrj7mlIKqN3aQaOvvh9kgmNr/iLgnU
         lQXSm+FusHpOBjy9zO0mzqO2Bdh2ClOdv8MWodrEyBx2LWvgXRNhk9+InrfNzUt8YrB9
         lZsy02+QfENtNUpQFLIacEYfWQImgDsaIf375TgGLfv+gWydw+PcMr1DG3g9tj+dH1t2
         F1UUCovAS1Px2YYhYCG0FKPTRKiRhUTyZeAOdoyMndBRbiSW5ncsyvMGJ3TCPey3mFar
         y5wg==
X-Gm-Message-State: AOJu0YyAKn0aRoT/mRow1czGuMVVkS4ggGpYRP5bgtyJYvQGAZQnmZnH
        ZHJygmkI52atGA58n+RqKo/s6bnM13JwC5krFCir2O7LAg0qomCuLuA=
X-Google-Smtp-Source: AGHT+IGFiuq2yAavaGohC3doXrEfCSrTTz4ql7Ccof0B/BskF92xcU/mBMfs+tpyTmR+iHwFXILbeDL6YKk4w7qSnnY=
X-Received: by 2002:a25:8201:0:b0:d78:20d6:6f4e with SMTP id
 q1-20020a258201000000b00d7820d66f4emr5008759ybk.38.1695302610815; Thu, 21 Sep
 2023 06:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-9-ulf.hansson@linaro.org> <20230921111110.tbffr5sik3ycw7gf@bogus>
In-Reply-To: <20230921111110.tbffr5sik3ycw7gf@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Sep 2023 15:22:54 +0200
Message-ID: <CAPDyKFrSkgSee=8zruR65TALvAj+hcWw1CaUOUwD3EpdxymtBg@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] dt-bindings: arm: cpus: Add a power-domain-name
 for a performance-domain
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 13:11, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Aug 25, 2023 at 01:26:28PM +0200, Ulf Hansson wrote:
> > When an CPU's performance domain is managed through the SCMI firmware,
> > let's enable us describe this as a consumer of a power-domain provider,
> > which is the de-facto standard to use for performance domains. In this
> > case, let's specify a corresponding power-domain-name, to point out the
> > corresponding index for it.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v3:
> >       - New patch.
>
> This patch and 10/13 are quite generic. I am happy to take it as part of
> this series but just thought of checking again if that is what you prefer ?

Yes please, go ahead and pick this up through your scmi tree.

Kind regards
Uffe
