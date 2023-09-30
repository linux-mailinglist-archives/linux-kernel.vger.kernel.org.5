Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7F7B426A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjI3Q7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjI3Q7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:59:22 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2C5DA;
        Sat, 30 Sep 2023 09:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696093152; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dKfB3rzlSTaQ5lAnhYw5ZHc/GAKC0tzXbAa3YUlecJOVdi+dyOCi+ZLi3FzGNebZAr
    lI3EU01JzTm75CsgAVJF/bAj16kjAbzOHPGr0ZIC29n6k+6DiatXQW9xYboJqWETuUWX
    LNlf0ZBH30Ip9RL8CP1DRkIYgevpw8LBG5lYICpepHfMfr/VOdD2rqSAVgaFDpxZwV1X
    coRLWxKus6qmi4NB5In3smlMxEXENOP+5Df+ssVkJe62ItcKPLyPwtspHDCi87dJj3pM
    lDlBnf8pfBaOab2RO1KExe1uJsOEYRcxVUCBYU+UHIBdEfMVf8kGuVAnZmodoQbJ8QCp
    +ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696093152;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TU2Xrc/bzSKmZicBoMMbvWmVhTF3do+bM2vLEZ56zHI=;
    b=XlUdQCIZn+wCPXLfRkD5GGML/kgWlJh+9uj8w9kbWtnU124iNllfNTQ6pl9M7krPSX
    3vZ9YPPwnGVFg9h8Ghga5ILuLuGORKH2Hx+f0hbZQnQGhDtzl4qoxLv9ldgwvfM0XK1u
    WgyDfE3ZaU/rI8f56535Q/oa9EaiL5ETx9YY+vdfXIc/2yLPQWnLmoPBQhe67TfLPI3Q
    5RifrHEsMkAap/lH8e9vs/alPwVONTc1X3UMVjkGHTy3z/h3Fagx87c7rqRsIhsWYYo6
    7IU2ehtD6HKp5wrhPIfkNOgNh7FGA1OJZfo2FHdKUdhRNqGsr0b+OBPHSV9E2aBeU8ST
    Fl5A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696093152;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TU2Xrc/bzSKmZicBoMMbvWmVhTF3do+bM2vLEZ56zHI=;
    b=IxNrK7RvW0zN+V4yN/8HaDf2gNQRvktawhCuJYW7M3tBhO9CdkGZRMm/LQCfp7wgGj
    6XtQWcZWRQQpq/bzCIu5CFpL7soxovEc60WRZYpft23IMsK5vWUf4phWfn4qdRhJrbpo
    GXeMSVIqpsHU5Qp34UnJw8CcO2geyCNa16lN1neL3smi5tBYz9QIDpb0IBe7P/jgEizd
    /RiP02vR4XuwfAp0P79+SFuqBCB7f7nIRqC4FOEZh0ggVI9WtlI7n6jZaWiGqmVzwKJ6
    xPN26fJJCK5v9Cd93Ry5S/coXU4u8AGLWP4Fb6PSjoaL8O7sQbFrY3+CETWt7R2AfqaQ
    plZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696093152;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TU2Xrc/bzSKmZicBoMMbvWmVhTF3do+bM2vLEZ56zHI=;
    b=mi98OHSv1laQUGcpQjULy+EDwplTrI0le7dgliKxerfPaFLUlEFFYVQzmfvFgRbQKt
    sN1W2UFjixI6rt7WSeAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8paF1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8UGxBtdR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 30 Sep 2023 18:59:11 +0200 (CEST)
Date:   Sat, 30 Sep 2023 18:59:04 +0200
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
Message-ID: <ZRhT2PRwAoB39J_0@gerhold.net>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Yes, "e.g." is indeed correct here. AFAIK the MSM8916-based Android One
devices (aka "google-seed") are also based on the Longcheer L8150. They
are available under names like "Cherry Mobile One G1", "i-mobile IQ II",
and "General Mobile 4G". They are also covered by this device tree.

Thanks,
Stephan
