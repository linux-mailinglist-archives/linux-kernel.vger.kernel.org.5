Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8127AF434
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjIZTgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZTgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:36:46 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96023DE;
        Tue, 26 Sep 2023 12:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695756984; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bNYPS6PpHI6Z6bZNVDTQCIilpEqVDUfDhLuzNR8EruuIsDdj2zf2WB/UjR7kfcTdvs
    nTkPAQ8dITz26dzjcr6DQn78+6Ho+cfI23xo66yuQ5prXZ987fW+Bx/x6QvEP+khF6Y0
    GxXAvtKqmV1ffENTHCgyZ84tpq7dCnc0P+qlX6+vAwdG9tQ7HJUq2M10lkcyWU+e0VBB
    sesvWMt9yTu03+HI8dJITtF0s11K1/Chw1Aws+VFVvHIosPTnkKORSJnFxD0unT3hzfA
    ciMNCffT4Pya/P5Zlgb2dZv7Ozj1RefNGFHcOJvMUCPH2/FAeH5j9Ck97dpt2TACp+dw
    ixNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695756984;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=diagiRFnguO/Zss2xMlKyNxZ7dcpCQXf0eI9r+Ar6ZY=;
    b=bkPI1Ffs7lCKbgUWwdbXWytQ0Mcu7q1UI32tzR4ZHmIppNny4ScBaFe82fi7xO6FC7
    bfYr4a3wlbPj32KhXWynroVXdA+8hBVrA35ZrILQkCFojRkN913e90NBCK3RQhzEmDHd
    QZgafPGdBxIUCzIJa7q3bMRL5N4fRSFUZIjin1q1dsuFvxC+By1vJEVOxOC2ia+wQrCZ
    d2KXuOGNp6N4IdRGXANbLtYKxPX/Glk+HAcx0Qcd6KjKoJLKvikHiD20GV/lj33KQeDa
    sLxhwuTarf9yE31aJL4VxAdW5bNNxSktx9SDoDC9LD14Uu/LahLiA81DmmRrLwtgpR1a
    zGuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695756984;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=diagiRFnguO/Zss2xMlKyNxZ7dcpCQXf0eI9r+Ar6ZY=;
    b=MDBcST95sQzBsPjQSnW5UCeHKT2ZQ9fEBFryKTGgfJPOx1t9HR//5Iz1/tdQujLlop
    kDyVvJAysJZBlOlg4aBXBxUicnIA9p+ojWjgEPeWuDW/d6H5SZVb5fg2VTLy/uneq0xM
    Mixe5vtLGc7oQsDpUnL5qisNGLea+SP1WT9J7hol4LfG4P3FryloG4ZmahXBvS8MpBSn
    mW2TUyF+xMjRj36ooPHlYjMPON5w1UQnymAtTBBdLDDoB69WF/7/3n83y5LbwcTDFatk
    MvPMRNbBUdsVqr6NNBOsI4RbhbzHeEAaccn3+Ao50QvnJ4KqzpeAIRnNcK63ej5lHQRb
    MM4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695756984;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=diagiRFnguO/Zss2xMlKyNxZ7dcpCQXf0eI9r+Ar6ZY=;
    b=2m4BrPwQLs9NLQ7Xbepghqd3cZW+C8eNb18coMn+H9puzF2WnZMR82ZaPOj2wtDpQl
    6k7GW8EFbNQeUGKU/+Ag==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QJaNgNt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 21:36:23 +0200 (CEST)
Date:   Tue, 26 Sep 2023 21:36:22 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH 09/13] arm64: dts: qcom: msm8916-longcheer-l8150: Add
 sound and modem
Message-ID: <ZRMytq4KApnJNDje@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
 <20230926-msm8916-modem-v1-9-398eec74bac9@gerhold.net>
 <14262938-4150-429f-a730-df1b2fadd9ff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14262938-4150-429f-a730-df1b2fadd9ff@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:59:52PM +0200, Konrad Dybcio wrote:
> On 26.09.2023 18:51, Stephan Gerhold wrote:
> > From: Nikita Travkin <nikita@trvn.ru>
> > 
> > Enable sound and modem for the Longcheer L8150 (e.g. Wileyfox Swift).
> e.g. -> i.e., or is that thing sold under many labels?
> 
> [...]
> 
> >  	reserved-memory {
> > +		/delete-node/ mpss@86800000;
> >  		/delete-node/ wcnss;
> delete by label, please
> 

I would say the same as on PATCH 07/13 here:
https://lore.kernel.org/linux-arm-msm/ZRMye1HeiUno5N_p@gerhold.net/

Thanks,
Stephan
