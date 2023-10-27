Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE37D9F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346089AbjJ0R6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJ0R6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:58:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629AAF4;
        Fri, 27 Oct 2023 10:58:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698429524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRPqztr4GahwJZPU8U9I4cKSw0U+RhcnaQCZg1prDx8=;
        b=0g7sNYk4TvIEaTnpce7boYMvFCt3CAOhS/gNq28xxDCnU8nBOB9Vl45DrzzPNae1FTni6b
        tN7XwH9PhCovOCPzrwC4SiBMf36XbTZMNTS4UmGsEeXKvxX0oUZ292aT8eeviFYsdkB2Rd
        mWPd+pD9Y973E1/C3rAEqkyHDDbiNzMrNbSjuuhR5o6an/NNzWSYxIuG7wXwCFeTIg79Of
        f0ZjKj56eK2j0uCxq4ScuHI8VDHUX6g5E+w87qWFTfs1TUz+PB3Ou8/8wFqOg1jxmRCmGy
        CIBKc4+KfS2oKrt8BEWCU89YCjLcRtqfsbRUqWLF3clc4r93vsd/XyWTwrLS7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698429524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRPqztr4GahwJZPU8U9I4cKSw0U+RhcnaQCZg1prDx8=;
        b=+ZaxvsMCH8Ozd4ffiL6r/6del1CGhq5YeiK+IQM0PatSZD92WWpfAzD5TofLDfBJflDk3f
        aMANVu5HLf2wJ/CA==
To:     Claudiu <claudiu.beznea@tuxon.dev>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 3/7] irqchip/renesas-rzg2l: add macros to retrieve TITSR
 index and associated selector
In-Reply-To: <20231023102223.1309614-4-claudiu.beznea.uj@bp.renesas.com>
References: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
 <20231023102223.1309614-4-claudiu.beznea.uj@bp.renesas.com>
Date:   Fri, 27 Oct 2023 19:58:43 +0200
Message-ID: <87bkck2bho.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23 2023 at 13:22, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add macros to retrieve TITSR register index and associated selector.

This is not what the patch actually does. Also please explain the WHY
and not the WHAT.
