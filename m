Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DCC802268
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjLCKMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:12:13 -0500
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEC1F3;
        Sun,  3 Dec 2023 02:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
        t=1701598336; bh=D98OLD1PzU0av069+SEqgQFkN/5n2xG9ugwljKPGRv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YVpST0YXbsjwdBdARgyDVsq31Bsq3mJCmHCXc43oKUXYpvhJymXCPUSHgVxUoSSS7
         MwmEdqKh5KpfwnKvd9+51+IoQdn7H+ERRpBUQZrRYvtEtT0A+EbWfo8r49po5ZQENi
         2zGTEIj0lViDIFGbCY4dlpMpozKltr4ik5wieMYw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti =?ISO-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Subject: Re: (subset) [PATCH 0/3] Add watchdog nodes to msm8226 & msm8974
Date:   Sun, 03 Dec 2023 11:12:15 +0100
Message-ID: <8630951.T7Z3S40VBb@z3ntu.xyz>
In-Reply-To: <170157925797.1717511.7301998654173050568.b4-ty@kernel.org>
References: <20231011-msm8226-msm8974-watchdog-v1-0-2c472818fbce@z3ntu.xyz>
 <170157925797.1717511.7301998654173050568.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 3. Dezember 2023 05:54:39 CET Bjorn Andersson wrote:
> On Wed, 11 Oct 2023 18:33:12 +0200, Luca Weiss wrote:
> > Document the compatible for the watchdog found on both SoCs, and add
> > them to the SoC dtsi file. And especially for the case where the
> > bootloader has already enabled the watchdog we need to start petting it
> > on time, otherwise the system gets rebooted.
> > 
> > It's worth noting that the watchdog behaves a bit unexpectedly.
> > It appears the watchdog counts down significantly slower when there's no
> > load on the system and can last far longer than 30 seconds until they
> > bark. Only when putting load on the system, e.g. with stress-ng does the
> > watchdog interrupt fire and kill the system within an expected amount of
> > time.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [3/3] ARM: dts: qcom: msm8974: Add watchdog node
>       commit: 95053f6bc8ffca438a261400d7c06bd74e3f106e

Hi Bjorn,

Any reason you didn't pick up the msm8226 patch? Doesn't seem to be just your
ty email, I only see the msm8974 patch in 
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=arm32-for-6.8

Regards
Luca

> 
> Best regards,




