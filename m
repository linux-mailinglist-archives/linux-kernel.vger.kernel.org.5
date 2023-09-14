Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EC379F979
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjINEQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjINEQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:16:15 -0400
Received: from out-216.mta0.migadu.com (out-216.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11EE59
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:16:11 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:12:00 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694664969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KgCBja6vR6ucPDDS+ICdvobr8KN6Wt6fcPO6ka4rjrI=;
        b=FXxIkFkR/iQ/43B4BkObLiuYQ0cH2IRjIphI9PU/lB+GL/5f8S5co1GA+IdsKS3tNCYemt
        gnnvY/GwpeKQj4wcrGMJNVDTxpU9O/J/69ykG7yY3yD+5pQ+NKgkLcK5Sbjf6v3Wgld2+j
        97qr9tcsI/fiqwXBpoVtENXdJxJXDRt+3MKEADb0r1gXoHAC57hlAaErNTG/8+vqiyxsBQ
        yQJyv/wa+Q4xU1tbdlWXUfLmK4U4o+mZBPzolDqQuqEpFyI5WLbSjgjZHdYa9XTRI8HMsa
        FlCsemuEtjs1fZUBph80jPqa2Hmj0Q0e6DSXLXa+k7sYiMS++qZslT54G2sTFQ==
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
Subject: Re: [RFC PATCH 1/8] drm/panel: nv3052c: Document known register names
Message-ID: <ZQKIED7jCc1FuPP1@titan>
References: <20230911090206.3121440-1-contact@jookia.org>
 <20230911090206.3121440-2-contact@jookia.org>
 <977a8de9-26ec-1789-4c72-fd36f34480c3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977a8de9-26ec-1789-4c72-fd36f34480c3@quicinc.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 02:43:43PM -0700, Jessica Zhang wrote:
> Hi John,
> 
> Just curious, what do you mean by these registers being mostly unknown?
> 
> I do see them specified in the online specs -- some even seem to map to
> existing MIPI_DCS_* enums (ex. 0x01 to MIPI_DCS_SOFT_RESET, and 0x04 to
> MIPI_DCS_GET_DISPLAY_ID).
> 
> Thanks,
> 
> Jessica Zhang

Hi Jessica,

Unfortunately these registers are not MIPI ones, but on a separate page of
registers. So page 2 register 1 isn't MIPI_DCS_SOFT_RESET, that is page 0
register 1.

John.
