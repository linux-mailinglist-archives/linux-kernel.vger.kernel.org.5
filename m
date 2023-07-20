Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2816775B9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGTVhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGTVht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:37:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B0A270D;
        Thu, 20 Jul 2023 14:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E06961CAA;
        Thu, 20 Jul 2023 21:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18DAC433C7;
        Thu, 20 Jul 2023 21:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689889067;
        bh=GZUiHqFRIa9kRqFdnfZG76QIb9kkoyd03I0c7rzEtyg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FjhNfRFqD9OiPLhgTKdcW4hQ0kZIJhTHZ2NEg/quOHHTaoMtPNoe2XuiAdXjlbQJr
         9UAEe1eip8ms1WhUOp6y9/cOoIIlfQm5lbMp90k0a14oSSvvPDe+YhLgLBZEvlk+Mz
         UdZVfCsS/iDSTIRHRtnYltLW12WLvk3h59LAd8t7RcJ76cF1XbKDQLPHEs8LbuqS1l
         ocekAft9WQjJ2F/Y3o15wfGmjfDcHuc2ypSLEz+A60jg1fCcN0hkDnE+2QNBuZ9Fy0
         0ITe+vyojYkS11bfISx/Za/cuv4RwmNBY+lFESbUITd0OnKLYB0jurnSBxOGUT+Bs1
         oHqjgiW89wo7Q==
Date:   Thu, 20 Jul 2023 14:37:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     corbet@lwn.net, Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux@leemhuis.info, kvalo@kernel.org,
        benjamin.poirier@gmail.com
Subject: Re: [PATCH docs v3] docs: maintainer: document expectations of
 small time maintainers
Message-ID: <20230720143746.1adb159a@kernel.org>
In-Reply-To: <20230720-proxy-smile-f1b882906ded@spud>
References: <20230719183225.1827100-1-kuba@kernel.org>
        <20230720-proxy-smile-f1b882906ded@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 16:15:26 +0100 Conor Dooley wrote:
> ..I noticed that none of these sections address actually testing the
> code they're responsible for on a (semi-)regular basis. Sure, that comes
> as part of reviewing the patches for their code, but changes to other
> subsystems that a driver/feature maintainer probably would not have been
> CCed on may cause problems for the code they maintain.
> If we are adding a doc about best-practice for maintainers, I think we
> should be encouraging people to test regularly.

I think our testing story is too shaky to make that a requirement.
Differently put - I was never able to get good upstream testing running
when I worked for a vendor myself so I wouldn't know how to draw 
the lines.
