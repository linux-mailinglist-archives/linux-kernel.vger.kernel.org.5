Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F2D8052E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345093AbjLELbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345075AbjLELbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:31:11 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8112C1B9;
        Tue,  5 Dec 2023 03:31:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701775857; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j8ERvUoQFRjxzG3q+WoTBj1tiSAUaNNRRWQVzv3YChJpuqqjq5wIMapskHmrZ/dxQn
    +nKRxGQOx6sQbb4VS2JbtwukY5kfaegoSRxR9hJUtpRj+EsdsI9kDlOUsS6DT/uNKZiV
    E3oaZANWqdrl7ieUdYqoH8yNUOXdqqYpdyZf11MRpkAcPw6K5+Jn+wh1emKGR+Gy0d5V
    COveT6qXTRG25t8X78MCMe59XUDiSHVGjGR7FEFFFWMaUr9V+YYfL6thiAScqmghyFL1
    v7I4Ez06vPu+n4Y1+aEDP9PFo71j0K+ba4D7wdbaNG8d9EKc4H5Y9mf1I9oMN2JkhlWr
    yp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701775857;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=R8hAw3u8uqXybhgsoJbMwSKfmEEJh0/vArUEqpnDzW8=;
    b=Xuo2z92jnhvalBzoA/FJv5RM/4iFyeugNtj6kUQdMnOLBCqg5rKX3+xbNHURiAADij
    qpxe45n6q99RsaPrYpcoxZyI4UegrYWSgyXBh8CYzjPXiX3uVk2KhQ7cqjkLVBFewx5y
    rFtVEdHS/oZLKqaxEUIBwJFwdAksVZilS7a0lKVib6QkFbmx32eXpacWS96hkPbyy281
    7loYXdggQt2wVeYQuw0HYoEihJ//VDF0EWXTBkGpUjlfBCwXBgdDiXbNuwVmS3IF1rr5
    PdSELmVfXHMTMGbJDLOhGu7IfsdlNit91/eFnupQgGvfgJVRxSbcy8K1POjlNLS1DZK1
    rfNw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701775857;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=R8hAw3u8uqXybhgsoJbMwSKfmEEJh0/vArUEqpnDzW8=;
    b=M7XiLvX73qoQax2FX0WCdtSotvrXrkdQu0DAmf1qcF9qH0wnlpwaNKMCuXVB17FC7r
    c4nXgffq+mYxza2XOpLGCGV9chiVi8ngsOFUf2VOOSdhpzGQ9H3Fr8nt9uVo3gc5sKvi
    2tSdbtMPm2zogOqbBHig8FQIMMflhs/uh6jZqLZf4t0wVbosyx/VG/fziMa2z3NV1FIf
    mNQxj7JhcwGw3loI6xByyfVBqdBGKXLH0hqUeBnRgRoNf+KQlwqWmmoKMH0IiVrEPr7l
    BARz5m3nXqWcC71+LbBtYsOleD/Lw1NsvnCnI/iBiYy2OjX/wo1e8ND7iXElkYuv4pg6
    5nRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701775857;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=R8hAw3u8uqXybhgsoJbMwSKfmEEJh0/vArUEqpnDzW8=;
    b=wcXJG4s/z88ltIwTsAmmSfGUkunYw8ndfagKoH9cZ5jWXVCPV736ww7fHo65T71Bco
    75BdiM0wjzv+sI5D1sDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8paF1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.10.0 DYNA|AUTH)
    with ESMTPSA id 58bb61zB5BUu12y
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 5 Dec 2023 12:30:56 +0100 (CET)
Date:   Tue, 5 Dec 2023 12:30:50 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Raymond Hackley <raymondhackley@protonmail.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] arm64: dts: qcom: msm8916/39-samsung-a2015: Add PMIC and
 charger
Message-ID: <ZW8J6vYKg82Q4JFV@gerhold.net>
References: <20231205093841.24325-1-raymondhackley@protonmail.com>
 <1c62dd8b-72b2-4204-8284-a1dd90d4f909@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c62dd8b-72b2-4204-8284-a1dd90d4f909@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 12:17:15PM +0100, Bryan O'Donoghue wrote:
> On 05/12/2023 10:38, Raymond Hackley wrote:
> > The phones listed below have Richtek RT5033 PMIC and charger.
> > Add them to the device trees.
> > 
> > - Samsung Galaxy A3/A5/A7 2015
> > - Samsung Galaxy E5/E7
> > - Samsung Galaxy Grand Max
> > 
> > Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> > [...]
> > +			/*
> > +			 * Needed for camera, but not used yet.
> > +			 * Define empty nodes to allow disabling the unused
> > +			 * regulators.
> > +			 */
> > +			LDO {};
> > +			BUCK {};
> > +		};
> 
> Aren't the camera regulators off until enabled ?
> 

We don't know for sure what state they are in during boot. If we omit
these nodes the regulator core will ignore these regulators completely
and just leave them in whatever state they are.

I would indeed expect them to be off after reset, but there are also
other situations in which Linux might be booted, such as kexec. That's
why it's usually better to be explicit and avoid relying on boot/reset
states altogether.

Thanks,
Stephan
