Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9D7AF45D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjIZTps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjIZTpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:45:44 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992391BC;
        Tue, 26 Sep 2023 12:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695757523; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ScOC8dkczEHByLDCHXTyAtz0XB3x/QS5XF28r4V9A/AqPobuiYMoo0ckpre76HoSIZ
    hK9TDUZ+xfLudytstgQgw+KUL4Lof8lqeqMv59jWiLMhvOxG9dpYpw7Amj577Bgv0jwV
    va1mV+m5Zw694B1ZBKFQDBYSsNNUpP/G97d4KEMGaBiLg0SwwFNAuRh6P9eQrIWluYL1
    ZE4Ws9hm8nSmyb/ekzFKoa2UmV+8FvWHHe41dPMZZMDmYcE1KnuGS7Uhu1fJJvbj+PIw
    FJETA65zEbPhPD2u144DTEOpseJCTp7S4PYsIOQwDL+oujJ0/jF2hFDzJaSxh9NYqZ2e
    fFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695757523;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=vMZSpKkvBIjU+HT65CAb4001uGPmrvyGeh/oBusn7/Q=;
    b=pB4b0L0+kdrb5hGFGnZhkF58qHuzltW/JEq/g6lLr2ys8LvRQrNBpJC9o1z4KqDad1
    LkwtwEP+nb1C6dkKZdKG7az149dKSZVZDLYnUci1l3/Xv79dibWoz23wWS90tC13N/UD
    bvnKPEZDdI8cg9laTr/alhaFGGd5okJ0wXvcbYZsVFe961sNljnCNDLkpphjtwpMdARR
    XH3QTZkAM4d9Q4Vi/fOCmtKPX/U3oJxsK9lgZKEnX9pi7I8fGeC92tbf2N3yPrwJEWHT
    QnJ2RGkJacMp62X2HHRr6k4+b9kPz/zWCiHo43ufCQEnxfbUc8+jyiDEjQUCHXQiJ04z
    gxww==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695757523;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=vMZSpKkvBIjU+HT65CAb4001uGPmrvyGeh/oBusn7/Q=;
    b=cMZGdPuR9lITKkw/oem4D8kok7Ic+V67Wj61RnC9d8TTBD158Y/muFBL0JrRx2zNIC
    sS9CZ6tDEo1HKq64tdntbWqOY3TcFSqah5KCSBWjx2hySY1Hou8V/KGxkzKBYBUFMQ6F
    g9ECpobUiqwklCKFkMfcKIscUR2WqvqaeDCfHPtjM1lMM7uVJUsPKoXmkGXCKmdEcPfF
    DH0VzlEec48ZpwkwA+gvlZpCNY0ZV8dT1QFiZK6JqFmYtMPO/ERNIdACWRLcNX1eKqyU
    Pz0hkgWEBkW+k9AczWsD65HecW0mQ7ar8dB28IMVqMS7sRP5rlVcLkUEWTvnnwIQej6x
    zBVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695757523;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=vMZSpKkvBIjU+HT65CAb4001uGPmrvyGeh/oBusn7/Q=;
    b=jQKaNRA3eeG/DmMQK1XXKemeGHoQNva3wrO+n+4gpuVoinJRpCB0RblITQ4L25ros/
    8yhX6U0GzR1eiNSY8CAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QJjNgOe
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 21:45:23 +0200 (CEST)
Date:   Tue, 26 Sep 2023 21:45:22 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: Re: [PATCH 13/13] arm64: dts: qcom: msm8939-samsung-a7: Add sound
 and modem
Message-ID: <ZRM00htVplpdhz0x@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-13-398eec74bac9@gerhold.net>
 <dd85dc88-467d-460c-a47f-60f3cac1cf53@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd85dc88-467d-460c-a47f-60f3cac1cf53@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 09:04:47PM +0200, Konrad Dybcio wrote:
> On 26.09.2023 18:51, Stephan Gerhold wrote:
> > From: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
> > 
> > Enable sound and modem for the Samsung A7. The setup is similar to most
> > MSM8916 devices, i.e.:
> > 
> >  - QDSP6 audio
> >  - Earpiece/headphones/microphones via digital/analog codec in
> >    MSM8916/PM8916
> >  - WWAN Internet via BAM-DMUX
> > 
> > except for the same differences as the MSM8916-based Samsung A2015
> > devices:
> > 
> >  - NXP TFA9895 codec for speaker on Quaternary MI2S
> >  - Samsung-specific audio jack detection (not supported yet)
> > 
> > Signed-off-by: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
> > [Stephan: Add consistent commit message]
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> [...]
> 
> >  
> > +&lpass {
> > +	dai-link@3 {
> > +		reg = <MI2S_QUATERNARY>;
> > +		qcom,playback-sd-lines = <1>;
> > +	};
> > +};
> reserved hw?
> 

My previous reply for reference:
https://lore.kernel.org/linux-arm-msm/ZRMwdRo9hAm4BO5E@gerhold.net/

Thanks,
Stephan
