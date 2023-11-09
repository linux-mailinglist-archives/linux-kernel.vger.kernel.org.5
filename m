Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA537E6B6C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjKINrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjKINrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:47:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DC6272C;
        Thu,  9 Nov 2023 05:47:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2A2C433C9;
        Thu,  9 Nov 2023 13:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699537630;
        bh=z4g5EW8efgIw8lyxSz+VhaqGLEYZgyBMh5nX9UJ9D5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rXnxVVo/03JiIe4Zfd/7TtmO+I8DtX6A62j+QKv7PwuNrWyGtwxed35dvFnWVqg27
         DdXznxNETaD8qgC+QMCrqjJVRPxnFyGbk1S2FIqMRs0v99vJd40qGC/sZfCAZhVxeD
         ZjEWkcIvnxByh6K7pP7/Gh5b/9wdSrvFT40g8WXzd9wQM+5w2tpfA3rHC4FMUmjP1j
         YLzXPHNNtSf91G49eeyWULb+X36EcDF/TLRbLOCpetzlngRCLYvs8V3bDKR+3WoK0K
         A36t2kY2BJpAs9PSnLKAr1C6No3WlvMogIPRekMLsAoMPj77PxMZQtcUopVkM8JV0c
         tUH/xoI3eM/YA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1r15O8-0006uh-24;
        Thu, 09 Nov 2023 14:48:04 +0100
Date:   Thu, 9 Nov 2023 14:48:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink_altmode: fix port sanity check
Message-ID: <ZUzjFFUc1dOE8C54@hovoldconsulting.com>
References: <20231109093100.19971-1-johan+linaro@kernel.org>
 <0edf26f9-46c8-4c9b-a68e-a92a78b5684e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0edf26f9-46c8-4c9b-a68e-a92a78b5684e@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 02:28:59PM +0100, Konrad Dybcio wrote:
> On 11/9/23 10:31, Johan Hovold wrote:
  
> > -	if (!altmode->ports[port].altmode) {
> > +	if (port >= ARRAY_SIZE(altmode->ports) || !altmode->ports[port].altmode) {

> I'd personally use PMIC_GLINK_MAX_PORTS directly but it's the same

That's what I'd generally do as well, but here I followed the style of
this driver (and using ARRAY_SIZE() is arguable more safe).

> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks for reviewing.

Johan
