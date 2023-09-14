Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33BB79F96C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjINEKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjINEKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:10:52 -0400
Received: from out-230.mta1.migadu.com (out-230.mta1.migadu.com [95.215.58.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108DEE7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:10:47 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:09:20 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694664646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yrM9qkZn8IvCEMY+qCo428/XGoBHkCAW20Ms/r1EMvQ=;
        b=SvCBqS9+YdFjSk3JlB6a+4z2XZyW9YC14vqOWANyDdJ0K9q2KC3xQEvn2ZAP5IfVsW1Nkm
        Yx5gqo56tqHoeLQYgFwHGrfE1xqwg+wabeWzwhFe86ehYcOlvS5ykmYi3XCvfXKtpPU2f/
        pTUdVrjOavf7W2m8vYUhCAmQZXQYs8EmFom/79y0TsckuoMCrP0Dwoiy7ozJHC7RW6qp8I
        wqKP9i+PeYdDnPkpAeTHni0MuigpIayV2N333014PhE9yhKn02w3XoYUvLsHAK8exME6DL
        FkY80CJyWoF3zILIfe9K/lRwcan+fQFPYF84KaKUt3CGcnw6mXRPp3vk4WsFcg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   John Watts <contact@jookia.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-kernel@vger.kernel.org, Jagan Teki <jagan@edgeble.ai>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [RFC PATCH 5/8] drm/panel: nv3052c: Allow specifying registers
 per panel
Message-ID: <ZQKHcDZ-mxNaSe0j@titan>
References: <20230911090206.3121440-1-contact@jookia.org>
 <20230911090206.3121440-6-contact@jookia.org>
 <d46ee183-a010-e585-c47c-fa3229eafb33@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d46ee183-a010-e585-c47c-fa3229eafb33@quicinc.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 02:34:38PM -0700, Jessica Zhang wrote:
> Hi John,
> 
> Having a separate panel_regs_len field seems a bit unnecessary to me.
> 
> Looks like it's only being called in the panel prepare() and I don't seen
> any reason why we shouldn't just call the ARRAY_SIZE() macro there.

Can you call ARRAY_SIZE on an an array pointer?

> 
> Thanks,
> 
> Jessica Zhang

John.
