Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CBF7E5010
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjKHFiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 00:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHFiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:38:21 -0500
X-Greylist: delayed 149365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 21:38:19 PST
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177E7D79;
        Tue,  7 Nov 2023 21:38:19 -0800 (PST)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx0.riseup.net (Postfix) with ESMTPS id 4SQDQL0D30z9sZl;
        Wed,  8 Nov 2023 05:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1699421898; bh=hnp+MRetZIeRthwcZt8YAw+DaHaqqmUcyacYecXNAWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2r7PWWHSYKLXYEP0X9fa4eP3tTl0mFt7+N/KzSU0pJINQt5nJO6wMP7pfj8o393B
         UVjnbftZbdJ5JYpVmL+rAWeEHXdrtWt+W1Z/EdzkW/5gH4Tr8PVEB9km+hxyp+3ri1
         JKEjcA5leBDjDdcez/nguaIBKgg4kmRPZUfU7ZMo=
X-Riseup-User-ID: 4F845E5C8472CAF32BD62747F514CB998E4B9C350F494338EE95BEACC9A4466E
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4SQDQG6LQczJmtY;
        Wed,  8 Nov 2023 05:38:14 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 8/8] soc: qcom: socinfo: Add PM8937 Power IC
Date:   Wed, 08 Nov 2023 05:38:02 +0000
Message-ID: <6027616.lOV4Wx5bFT@melttower>
In-Reply-To: <6715dfd5-acf5-434c-a9bd-0a5bcdd72010@linaro.org>
References: <20231106-pm8937-v1-0-ec51d9eeec53@riseup.net>
 <20231106-pm8937-v1-8-ec51d9eeec53@riseup.net>
 <6715dfd5-acf5-434c-a9bd-0a5bcdd72010@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 7, 2023 9:30:34 PM UTC Konrad Dybcio wrote:
> On 11/6/23 13:08, Dang Huynh wrote:
> > The PM8917 and PM8937 uses the same SUBTYPE ID.
> > 
> > The PM8937 is found in boards with MSM8917, MSM8937 and MSM8940
> > and APQ variants.
> > 
> > Signed-off-by: Dang Huynh <danct12@riseup.net>
> > ---
> 
> Are they secretly the same thing? Do you know somebody with a PM8917-
> equipped device to check that theory out?
> 
> Konrad

I don't know anyone with a PM8917 device, but I did check with downstream 
source and all the reference to pm8917 are either not used in any dts or point 
towards pm8937.

Dang


