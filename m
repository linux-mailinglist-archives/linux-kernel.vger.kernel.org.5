Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F937D6B29
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjJYMSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjJYMSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:18:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD75129;
        Wed, 25 Oct 2023 05:18:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6FAC433C7;
        Wed, 25 Oct 2023 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698236313;
        bh=Ja5Kf9ILXH67ciGA8XKkZ45ZaownkYfTkf4M+tF4fwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8opZJxrHmoHIhEuCHc4hlUVv/7ok9DqWVfxi+ZvwP/JJpyt7xzpgh7FgJD6bxhwU
         pjgH+76BKUczmlRX9sTrCt15AEq68Foy3tLHUjqW3z0cIQjf9betdjorsPdA5bN5Kn
         ErNJJCxXoHewX+JaAs5ZADDs44IJu1s/eK19LoJSShKzeGItWp2wZYfv2PtLMGJlBH
         +JWxUUXDDeZx/nZd5gtkZAZh3PyKLEzgdDrZ1f46HPyQjBpRF7xa6kbhhofm+xBP8T
         Fh4NCqLRIJv7yUcH9CanzgPL7Gu7vOvUSVfMKlFiJLtg+fYMEjRipYHOPmeznE8ctG
         AfPG9wa4f20ug==
Date:   Wed, 25 Oct 2023 13:18:27 +0100
From:   Lee Jones <lee@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/5] mfd: qcom-spmi-pmic: fix revid
 implementation
Message-ID: <20231025121827.GN8909@google.com>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
 <169823622555.724579.17090745891924053957.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169823622555.724579.17090745891924053957.b4-ty@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023, Lee Jones wrote:

> On Tue, 03 Oct 2023 17:29:22 +0200, Johan Hovold wrote:
> > The Qualcomm SPMI PMIC revid implementation is broken in multiple ways
> > that can lead to resource leaks and crashes. This series reworks the
> > implementation so that can be used safely.
> > 
> > Included is also a rename of the SPMI device lookup helper which can
> > hopefully help prevent similar leaks from being reintroduced.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [4/5] spmi: document spmi_device_from_of() refcounting
>       commit: 7db72c01ae2359dbab29f4a60cda49757cf84516
> [5/5] spmi: rename spmi device lookup helper
>       (no commit info)

Not entirely sure why B4 is sending out these separately!

Still, both applied, thanks.

-- 
Lee Jones [李琼斯]
