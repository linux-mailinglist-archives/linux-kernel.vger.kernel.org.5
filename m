Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759A1763E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjGZSfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGZSfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:35:07 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5A926A8;
        Wed, 26 Jul 2023 11:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690396503; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QyOAP2eo59cwJDs6ShfwuykvNo0nk3ej712WKvJc1joiuh3WbOkXOCAqrbSQqB59TR
    3FPuG1gRSZgpNfpxg/IGuw+kIjdpENBzBU6uGcodkH53vbds1hLYKDSZQIbEGVE/kNRZ
    tRkNohR3mstsY9IDzB3hGwZXpC68CqY3vN/kMzAQvulmnqVYVZjv2vSWcOqih6Qs8bCW
    tqAVHDRmskVWpWLxgI4dr5FoxMJYJ1nt3yt4R8Lo+b8A7jPWnclPsJYfYDTA5O3gKtsN
    +j31FdQFFhdKVSKLznAwjKnD+yLt0AvKaS46aov/qxaNuqa/eX86hefnIE0f7aKj2HUF
    /v+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690396503;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=kFXFMS4BMfM6mg4NHfeRlpd9uswdZDJ9dYi+CYWBFts=;
    b=elmBU8C4lepOujV1sMO2CCUzp1UCWRfAUbXM+luLWa2bX3P0HFjwDcHH/ahIvj8o7d
    E+qYwlMyX+qW1z0JvhhPkvhkvoAQz7dUKUV5sDYoZiRVXwnm5JxSD7fM9j1Eq3cZi7Ol
    SPsK/xNvwmxUbV/fDhH3VZSWgw2FAgmkWX1lAwB8Gj0qoe83FPbJFjqmWiz5CD2cUhh/
    1np0iPT0O43+xbN6RyZPw7w4UkUfDfTF6n5a0KuIIvnlRZxieHjHYOMF1j+FOC4x7a85
    kE2NQczranv9euwevBmSM6JXzHE1dFd21h05lsnDiV4PRNz5xw40qVN68UGXWxeUv7bW
    P69w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690396503;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=kFXFMS4BMfM6mg4NHfeRlpd9uswdZDJ9dYi+CYWBFts=;
    b=GNwFEvfNmkBtREQ7fHqaXyYaU4bODl8MmjNOj8dBNRAES2q2W3/nujjyzVVkz20ru4
    OVXmD8Fz2YLztYWC8pyOZP3ZAl2Ia+mEscTS2oGwfdECh4maZQu3kjuw9GlDgA4Xw9VM
    azjdWZp6Ee4nQT9CH0DBWO79t0eR6N0JqgKwP7bsiBsJh8UZHKPBXXbInxndSlAStxjd
    iwfxcKtKO0I7sR9s8s5+qCq+1fOTqDnBuwrgH/KQNnJhCoSIdoopWG6j6btlmPXtFGYG
    2zewzcrnUUrhrG55tZV8dE3YnLVL/ELtU9rQAomMbvkDTb2ZDTKw+r7+SFYR1VCmKbMA
    gH1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690396503;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=kFXFMS4BMfM6mg4NHfeRlpd9uswdZDJ9dYi+CYWBFts=;
    b=8CfnZo4coMlBARC3w7wPitd/sME6CxTnKhmEanE0D3JyMEGAFHdUORQLTjS7aRkmSf
    mzUHL3ks9FN0CTa71ZDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z6QIZ38Le
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 Jul 2023 20:35:03 +0200 (CEST)
Date:   Wed, 26 Jul 2023 20:35:01 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: qcom: reset: Increase max reset delay
Message-ID: <ZMFmvp9UwCxpsLf7@gerhold.net>
References: <20230726-topic-qcom_reset-v1-0-92de6d3e4c7c@linaro.org>
 <20230726-topic-qcom_reset-v1-1-92de6d3e4c7c@linaro.org>
 <ZMFkO5aAT5I5kBac@gerhold.net>
 <9ea4f4ed-8be0-859f-4f5d-d3bd0a727cb9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ea4f4ed-8be0-859f-4f5d-d3bd0a727cb9@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:24:33PM +0200, Konrad Dybcio wrote:
> On 26.07.2023 20:21, Stephan Gerhold wrote:
> > On Wed, Jul 26, 2023 at 03:26:19PM +0200, Konrad Dybcio wrote:
> >> u8 limits us to 255 microseconds of delay. Promote the delay variable to
> >> u16 to hold bigger values.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > 
> > It would be clearer to change this together with an actual user that
> > needs > 255us. AFAICT atm MSM8909 is the only user of this and it has
> > just 15us.
> Some LPASS resets ask for 500, but I'm still working on that driver.
> 

Maybe send it together with that driver then? This feels close to the
typical "no API changes without also adding the user" rule.

Thanks,
Stephan
