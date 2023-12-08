Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A14A80AD83
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjLHUGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHUGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:06:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17CF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:06:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76438C433C7;
        Fri,  8 Dec 2023 20:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702065978;
        bh=AJRugcmqGU7FRRyaxRvctwC7Ym1TtKH9ucxVu6xYxSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TjZYQtmlieiMq0bzqSV7VeRFOrVA7N6YxttU/rDbwYla8jPLi37LdgIm9XpwLI87h
         yOqYUZrCR0EVO6ymqIfofzxnIu+Kzd4TzSIe/DY7T3YqYDuM49JcogqT0dQtArtXBo
         hQ8JJ4dYEGRx3kfwWOqYTykjFj6qk3+UjfHv5SRT567YvC0SQwMDOv5YAlcMcWuSdv
         VeMQzoi0UWG+aGEq7s175kl/LixERP49B6zPPg5MfDFSUKm+E9mGebd0q/W6KHIiQy
         Q58Mye3TU9mS00rJg1ygRDbvFYziatTUewDo6IAIdyAQx0y9qO6Sz7rAPdbDiljMpa
         bVjjH/wQvC+4g==
Date:   Fri, 8 Dec 2023 21:06:10 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] i2c: stm32f7: simplify status messages in case of
 errors
Message-ID: <20231208200610.hrpup7ghhjtehcsc@zenone.zhora.eu>
References: <20231208164719.3584028-1-alain.volmat@foss.st.com>
 <20231208164719.3584028-3-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208164719.3584028-3-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

On Fri, Dec 08, 2023 at 05:47:11PM +0100, Alain Volmat wrote:
> Avoid usage of __func__ when reporting an error message
> since dev_err/dev_dbg are already providing enough details
> to identify the source of the message.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
