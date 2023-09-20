Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C407A73AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjITHGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjITHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:06:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF0D3;
        Wed, 20 Sep 2023 00:06:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37770C433C8;
        Wed, 20 Sep 2023 07:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695193571;
        bh=oP8IOTnoBTPkWHwbE/Ttl2bM4z0e2euCv1MOLa8xiQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nB4zsdTGma4GSVOYF2SuvKyMbcwprZ6OnV+6KgOiU9jbXCL/l/GMvdkeQ9jDt04cs
         IxrIJs/SgtQ4csPLTqYH4xZqrx63YQVBhtmeWvsvX/GwIMj2ZkUOASmR8VxoX0kQLO
         wiklitpBAb/pH9KMdBbFElzy9aI9RIg5F2Dc35GuYfYsS9DDXxZ4Gg+O/F26zx13k0
         zR++Jyu4YrjcMdJxQYIndkxMO3m8snde7Yz2IeJ6OhsG4/qvAn0+XJnePUFmX4kJuc
         oG9TU2TdYUznrq3PFq+TddhzeI0L8ER2/zurSlfAVcRL52q3w15jdA+QIo2SEXVNRx
         08isUZ6AK3Ipg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qirI2-0002mU-3D;
        Wed, 20 Sep 2023 09:06:27 +0200
Date:   Wed, 20 Sep 2023 09:06:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.5 30/36] arm64: dts: qcom: sc8280xp-x13s: Add
 camera activity LED
Message-ID: <ZQqZ8uYegx7PABnw@hovoldconsulting.com>
References: <20230908192848.3462476-30-sashal@kernel.org>
 <ZP60ngCV3hhNZiX5@hovoldconsulting.com>
 <ZQjEEt7sB2M5EO53@sashalap>
 <ZQk8aJx268Soy4yH@hovoldconsulting.com>
 <ZQmc7hznPpIh6iwP@sashalap>
 <ZQmh-DaBTwMuOLHe@hovoldconsulting.com>
 <ZQm5woD5zwRIG9cf@sashalap>
 <ZQnA4o7G4A3YC-pe@hovoldconsulting.com>
 <ZQnFj6g4pbwMz69C@hovoldconsulting.com>
 <bd906454-8949-38d6-9327-d640468b6c3d@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd906454-8949-38d6-9327-d640468b6c3d@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 06:53:09AM +0200, Thorsten Leemhuis wrote:
> On 19.09.23 18:00, Johan Hovold wrote:
> > On Tue, Sep 19, 2023 at 05:40:18PM +0200, Johan Hovold wrote:

> > You also seem to have made up new stable kernel rules
> 
> No, it was me who changed the text, as I saw people struggling with it
> and noticed that's partly due to problems in the text. But just like
> with code changes there's always a risk that slight changes to a text
> result in unwanted effects. Not yet sure if that's the case here.

No, the updated text is just fine. My point was that Sasha's wish to
backport devicetree changes to enable hardware features violates the
stable kernel rules.

> > as adding device
> > tree nodes clearly doesn't fit the description in
> > stable-kernel-rules.rst:
> > 
> > 	It must either fix a real bug that bothers people or just add a
> > 	device ID.
> > 
> > (This used to say "New device IDs and quirks are also accepted.")

I just put the old formulation in parentheses for reference to avoid
having anyone think this was something new.

Johan
