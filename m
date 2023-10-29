Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269F67DAB38
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 07:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjJ2GtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 02:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2GtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 02:49:10 -0400
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A035ECF;
        Sat, 28 Oct 2023 23:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1698562135; bh=il9Fc2Id6aYri4aenoZl3aFbJEXg0M1dBlK1j6kQgZM=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=DVneJ5HKDQzvqY5cL7ZJ0zjd296MagKxHeREkyKE4uw2QJbTD+tjfKYW64htSexOe
         HtbnvFPsjc6tsfJVVtv5DeqnZJ7t3TMqPOfxz6MM69w8kvpwxE2eRy+rvcmS9pIHUb
         9ufnZcCPOCJ/o12ViRa0F5ZyqHkkAn0KrWTrnFZs=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
        via ip-22.mailoo.org [213.182.54.22]
        Sun, 29 Oct 2023 07:48:55 +0100 (CET)
X-EA-Auth: 0gKghmjOi49/2iYqDCeG6caHkCfjeYJ8z58c0pw/xcedGi7dK9MdswDKuSLkRyxsPWNj5aRzcLU2+dQG5H8uvzY9G44kzR94rxzzc7R0Rds=
Message-ID: <6a79fd87af45c14aae5205ea1aa3875827fa1d31.camel@mailoo.org>
Subject: Re: [PATCH] clk: qcom: gcc-msm8939: Fix mclk0 & mclk1 for 24 MHz
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>
Date:   Sun, 29 Oct 2023 07:48:55 +0100
In-Reply-To: <2f8672a3-1ce4-4f8c-a472-3a1ad09e9214@linaro.org>
References: <20231028120756.316574-1-vincent.knecht@mailoo.org>
         <2f8672a3-1ce4-4f8c-a472-3a1ad09e9214@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 28 octobre 2023 =C3=A0 15:06 +0200, Konrad Dybcio a =C3=A9crit=C2=
=A0:
> On 28.10.2023 14:07, Vincent Knecht wrote:
> > Fix mclk0 & mclk1 parent map to use correct GPLL6 configuration and
> > freq_tbl to use GPLL6 instead of GPLL0 so that they tick at 24 MHz.
> >=20
> > Fixes: 1664014e4679 ("clk: qcom: gcc-msm8939: Add MSM8939 Generic Clock=
 Controller")
> > Suggested-by: Stephan Gerhold <stephan@gerhold.net>
> Reported-by?

I believe S-b is accurate:
I mentioned a problem about those clocks on IRC,
and Stephan pointed to the 2 problems fixed in this patch.



