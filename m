Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449D47A2065
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjIOOEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjIOOD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:03:59 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FF11FCC;
        Fri, 15 Sep 2023 07:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694786632; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=omCZd6/9yhvLZBo73WZZU5HJ8bdu2OTIpUAZNrhVAJKLo5WEANSg2Bw2WLhzTxiwZo
    pABAYWtkLy/U0fQKeS4vbJct7UOKw9TXe1WwYI1jG3493Y5XBfNJ+LINZPQXbvOjV3fT
    Uyu7y2uyrno1QcWecxIk+7o6OVMZ6QS1o/dwOvePU59CxrPOh/GllrchgUeBMyDzkCGd
    7uyM8rfb4ok+n7x6WA2OM916S4vjcyEKw8lN7lMgpLRh2gJpzHnq0CIHjXSNVKI+ps8z
    m6oMKws1Guzhx/DkT15+2q0E7tS8+oPR/Id3RDTeh/Do9snm7xM3EmXfdbTruct/r5HN
    /XOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694786632;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=qXmRpKWGQUUyQvMEuBI6R1swvLoRgyJsRJNin4XNLRg=;
    b=lRwtwJ6KdfF9vujzuE4C+Isk9P0e1L9tV21oA/U4MIvALsA3ogoRR9A3OlW2LJINi7
    Hy5D5ZPLEzuqkTZhvoUvJBd6ThlyAZ4h/zoak2+08Nfr+GJ+bbTvaPtEP3ITuBds0Lzh
    LpQu9WNoZhyazTJTbu5c841OnFc9MsFLc6RAdrdjACqa542PXUe9hmxstkwYpKl7XQ8S
    hxnNPxR30cW1WuyGQTVlNC4R2jG5nVCTU5yzfAO9wkof+SV/lL3NWigKzdNU+WkWdTbs
    MGx7NZN+ZKJLeH5lquG+z2HqlxJVrYATXz/gt8KRpdafYGIl6emx+O50da9mr5nRSpE5
    L/mQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694786632;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=qXmRpKWGQUUyQvMEuBI6R1swvLoRgyJsRJNin4XNLRg=;
    b=sldxj1i+ZOXCi5SVVCCFOzbqDSCQTKSHfFGGOMVzhH8UC3i6gQBKgMZdCY+vErsNB7
    Sf5YLwv0wveDuUE5wcLlbLRVoe+1uHdIWpwQOw54A43WdKvJ5Q9euQiAkScC40BGxil4
    8EeBajUZ6dqR/U9xUO4i4/ajGrVlPjSBRb1wkVdDA1GibmrbSCcNP1isH3anYTovylhF
    /PQWtUuDrlqdM/oF5pCenD2efTe/qZlujwBFAwUGujlWGg92LMmdY94bCU66R0Cl5bf4
    THArfkscxtigODqUOZe9bTnaGzYwvZRvakJElh9VJabQcgs9fWNXQKJYSVaQIqrOgxKY
    3bvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694786632;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=qXmRpKWGQUUyQvMEuBI6R1swvLoRgyJsRJNin4XNLRg=;
    b=SLDRGKKuHdm+7z6Ip++P8CyHwpVfcmmWbjWJ08yHp9cTntEOUHLWruLnE1DTAozuYq
    XNOhRQqiLTi5R1Uas3AA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8piJ1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8FE3p81B
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 15 Sep 2023 16:03:51 +0200 (CEST)
Date:   Fri, 15 Sep 2023 16:03:50 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 8/9] arm64: dts: qcom: msm8916/39: Move mpss_mem size to
 boards
Message-ID: <ZQRkRugxT4n9xIhS@gerhold.net>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
 <20230911-msm8916-rmem-v1-8-b7089ec3e3a1@gerhold.net>
 <b66a72ef-653b-47cb-8c0a-df8418c3619c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b66a72ef-653b-47cb-8c0a-df8418c3619c@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:51:52PM +0200, Konrad Dybcio wrote:
> On 11.09.2023 19:41, Stephan Gerhold wrote:
> > The modem firmware size is typically highly device-specific.
> > The current size of the mpss_mem region in msm8916.dtsi (0x2b00000)
> > only works for some APQ8016 devices without full-featured modem,
> > such as the DragonBoard 410c.
> > 
> > The full modem firmware is typically about twice as large (~45 MiB
> > -> ~90 MiB) but also varies by a few MiB from device to device. Since
> > these devices are quite memory-constrained nowadays it's important to
> > minimize the unnecessary memory reservations.
> > 
> > Make it clear that each board needs to specify the necessary mpss_mem
> > size by replacing the DB410c-specific size in msm8916.dtsi with a
> > simple comment. &mpss_mem is disabled by default so it's fine to leave
> > some properties up to the boards if they want to enable it.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> Any reason not to squash it with one of the earlier patches then?
> 

I'm not strictly opposed but these are really two independent changes.
One drops the fixed memory regions and makes the allocation dynamic,
in the SoC dtsi. This one moves board-specific information out of the
SoC dtsi (to the boards).

Thanks,
Stephan
