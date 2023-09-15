Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4177A205A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjIOOCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjIOOC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:02:27 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00651FC9;
        Fri, 15 Sep 2023 07:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694786540; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jJgBM0A/RCl5flBAzysOw0vbwSOLmeG7/SiP/vB0IQ64kobSSu2giYWmQqQDhNQR63
    KFPl1RZIYhxl0qgVpKSFnBvKgcNo6D7+6H0+G2iA2BydAuEHW4+rP/HpAEhm9BJdoha1
    LmLRKZH3/XTZpyWToaqAPZ+x9R4jo8AmRa6h5sRtfMy2pJOfP+mX3VAY+xz0vPtCcVXz
    pWlh0SKvU7Xbc+TsPWdeJZgLP5YLKJpJHEGm9xvLEsK/UiBXqCNzJH3C1kd6oJYVGS/W
    qviqiKXTY4vKjWKlF/Nfcj66Tw4Oz4N2iehCh94S4Tr6P9q1t4ZptS+qeOFzXPJtCfyc
    nVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694786540;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DqmiWQfnDvc2zy7SPcWT284YAzXhu8L0TVNtUbpB44s=;
    b=DTptKI8jsPoV3MzWr0dKzmzHXx3ToCeEMvcO6MB1X63LU01y72fSJGWPHKFoLAI1Cz
    RyAVsVWAb/7OLNRTfzw92DLxHz1L75hNEcUoTkSvfNuOgS6vbtuw212qdR8eeDcMuVcW
    cSSl2+se5+QR8px892xeM/lLFBN4xajJSIi2xh4BUnxvUyjqLQMwur+mb3K4+650+/jV
    IrB/kjqodpYRzIB3lep5iDLlQbmW3YG7IcgeDAvr1sDL4rqNKMabZADXi6qjdnet+RON
    7PE8LMRNGoLAsQMeKkfPlA8WbW4Q3gVnctTZGZIjqqF+9wCewkG5w4s9nU4mvaRsXDhJ
    zaBQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694786540;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DqmiWQfnDvc2zy7SPcWT284YAzXhu8L0TVNtUbpB44s=;
    b=DvK3nIJqNx+kq36iUt6kmJKP2AV0yT1NBbYe7M/9U3GfoPJVFp1FjteWmVn6Jsm7A0
    uQzYfuzmxlyu2AIgcAcXrdhXMt962MvWW7CVWNeNjdXCyukOlZFKm4KxHI1TNEr3aCPG
    RHZedutrm3C/FYccUIaFByVL7zV5xGDBT/OXOoyls/yeiw3aGI6tSMRlCaZFIuJGGxyA
    xGwkbAPUUz/W3oEnTwzjd1wDtKW+cpcvPXjonaSkR1HxdZU9nWKhWcENMcKTu7pS90ar
    f5T4s+3ycfG30PA2ZJOIEVgd9TVPgGKieCXQAW7lOqal0+GedmcameJ3Io67uMSetc8q
    Lkrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694786540;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DqmiWQfnDvc2zy7SPcWT284YAzXhu8L0TVNtUbpB44s=;
    b=+QP854OVM2iect3wvvvMIhiThRaGXf7n6rI71WYADU7dpL2Ho0PxRWrn+k+oz+YlJo
    SFVn79kmkcoFGG5+QQCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8FE2K80r
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 15 Sep 2023 16:02:20 +0200 (CEST)
Date:   Fri, 15 Sep 2023 16:02:18 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 7/9] arm64: dts: qcom: msm8916/39: Disable unneeded
 firmware reservations
Message-ID: <ZQRj6jHBuc6Zxkuh@gerhold.net>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
 <20230911-msm8916-rmem-v1-7-b7089ec3e3a1@gerhold.net>
 <70b10fcc-6851-4d48-b27d-3e701ba95ae0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70b10fcc-6851-4d48-b27d-3e701ba95ae0@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:51:03PM +0200, Konrad Dybcio wrote:
> On 11.09.2023 19:41, Stephan Gerhold wrote:
> > Now that we no longer have fixed addresses for the firmware memory
> > regions, disable them by default and only enable them together with
> > the actual user in the board DT.
> > 
> > This frees up unnecessary reserved memory for boards that do not use
> > some of the remoteprocs and allows moving selected device-specific
> > properties (such as firmware size) to the board-specific DT part in
> > the next step.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> Wouldn't delete-node on the outliers be more concise?
> 

No, because you also need to delete the reference to it on the
remoteproc node, i.e.

	/delete-node/ &wcnss_mem;

	&wcnss {
		/delete-property/ memory-region;
	};

But IMO this would be inconsistent anyway. You already have to opt-in to
get WCNSS at all (i.e.

	&wcnss {
		status = "okay";
	};

), so it would be weird to have the memory region opt-out IMO.

Thanks,
Stephan
