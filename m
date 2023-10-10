Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20547C407F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjJJUAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjJJUA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:00:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E633893;
        Tue, 10 Oct 2023 13:00:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-406619b53caso56469695e9.1;
        Tue, 10 Oct 2023 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696968026; x=1697572826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eQ4NRAmtnN/NRZQzjQnyQ6stD/3in+1JTool5Rxbj9g=;
        b=a1Fycwmzhul6madsDHKnqALUkVlJDOgtGEjt829dLjSZXqpvcA7lOlZe43BROms+D6
         qK+RwDptI9Ny/Gqa4wyTI9yVBzhFOdnT7+8MskvVuhmMgdkbwIXgqkr+hMW0XcbSYGiI
         7yV9s2aXC3l8GT76jEmQo/rKeayFpShwH5zkxC/5lI0CYdNrz82myeL179xDLNXSNktR
         VWwZogRu6y1fhBEchV3fEauqClmfhQtCxblEx3m5xOTJjhF1EKWf7M0ssoTVzs5ts5CE
         CjagSz8acXvrhmgVXY3JlQcgHO4biXRTRQDRS3b/t4FANo20wgsQHYZ+QBdkQ4Nne2wo
         8D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696968026; x=1697572826;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQ4NRAmtnN/NRZQzjQnyQ6stD/3in+1JTool5Rxbj9g=;
        b=LLYAaQXQcf357BNlNJo1onL3IR/k5/dBl9F9hrtlWVxMmcytFZ5CeGPHbkee8xTT8+
         b+1fMHNZCsCXkQoTkQ/UKtks1N9U9QXTDWn59IlOFBZ7cFz0j/emVVy7rE8I0Er4B56w
         O9FDUo5krEbuN8wYGP0rJYRihIF4SxFD6Vjc4B4axB7TJFbVBt33Kbgpg6gpEo2zyvCL
         ISFd1fZsqM/iiiozlrcCW5JKNWD0JYQJf5WX6SPavAg2gKUGiP32XareSvllbvSaR5Qx
         GkCfKD37p03q7Zvs/GQf+Vrwh7Jx4yknbUTyZGBUrHOH7GHuyRuaUtTgX+fyfM70bVfS
         YAqA==
X-Gm-Message-State: AOJu0Yz+3yrdde2tEP2cl+NeE7zEWDTkHP19PK6LwQA+dIHqqg8IIL8c
        DPTfSywjdskgH+U6OOgCUM9cf32iPiM=
X-Google-Smtp-Source: AGHT+IGq2z9HR84nxbJLb+mZvoR2JGu6JiTGC/OK2iwe+mFB0lNNAELhdNThlwt4cGJFsCppI7hC1A==
X-Received: by 2002:a05:600c:20b:b0:406:177e:5de8 with SMTP id 11-20020a05600c020b00b00406177e5de8mr17177489wmi.35.1696968025979;
        Tue, 10 Oct 2023 13:00:25 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b00405d9a950a2sm17275895wmh.28.2023.10.10.13.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:00:25 -0700 (PDT)
Message-ID: <6525ad59.1c0a0220.e3509.8545@mx.google.com>
X-Google-Original-Message-ID: <ZSWtWAbVThLbpCk3@Ansuel-xps.>
Date:   Tue, 10 Oct 2023 22:00:24 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-4-robimarko@gmail.com>
 <e255dcbd-6342-49e6-9bfe-17a47b2a3c8a@linaro.org>
 <65255c81.050a0220.141f8.7b8f@mx.google.com>
 <1aea4a86-7f7c-46ee-9cbe-655eb7663c2a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aea4a86-7f7c-46ee-9cbe-655eb7663c2a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:52:50PM +0200, Konrad Dybcio wrote:
> 
> 
> On 10/10/23 16:15, Christian Marangi wrote:
> > On Tue, Oct 10, 2023 at 03:40:32PM +0200, Konrad Dybcio wrote:
> > > 
> > > 
> > > On 9/30/23 12:21, Robert Marko wrote:
> > > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > > 
> > > > Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
> > > > Use opp-supported-hw binding to correctly enable and disable the
> > > > frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
> > > > 1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
> > > > 1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > ---
> > > Christian/Robert, can you provide a downstream source for this?
> > > 
> > 
> > Sure, consider that everything is with +/-5%.
> Hm, so you're e.g. putting ipq8062 384MHz voltage for PVS3 equal to
> 0.95*800000 = 760000, but I'm not sure if it's a good idea?
> 
> The comment in downstream:
> 
> "These are based on +/-5% Margin on the VDD_APCx that is advertised in our
> Datasheet across Temperature"
> 
> suggests this is already not very accurate, and betting that the lower
> threshold works on all chips is probably not the best idea.
>

Consider that everything is driven by the rpm. The original qsdk used the
same approach of taking the value, apply +-5% and pass it as a voltage
triplet to the rpm regulator. Also the driver have ranges so it
autodecide the best voltage in the range of the voltage triplet based on
the one supported by the regulator. Normally the normal voltage is
always used.

-- 
	Ansuel
