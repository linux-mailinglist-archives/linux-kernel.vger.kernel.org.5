Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FA58064CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376557AbjLFBoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjLFBod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:44:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C710CB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:44:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61646C433C7;
        Wed,  6 Dec 2023 01:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701827077;
        bh=wpQwyqxs6iklENoKxr6PKDAc6bKDhiqwRadosZHTN5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfLDAVsLIEBgeDUXFOjvvrq55JwCjrIfujLhulomKxEQCNbD/oMl1p0DjO89sVXUX
         V6aYgWjiZaVB1tTbw5bX05t5MCuoHyRQ7wDuQNPx53vfT/AFmlEF2AlUEpunKeQc+H
         R7ps10K18Ida97oTsdLv5LXqQ1PWNV77/4TKM56PRogBcVjduSM9qAa8rWUlqCpU/w
         WFxapxhfjTYtbQ3owN/nnT6D+7gZEkgZx1EZnwZPOz8TAyF1F8aSENVfdEyy1LjWvI
         lNjiS3inI3mmUEkfU0vpf9F45okUTrZaenKJftztDVG7+BkaKs6P1C7vCK2uHTPzke
         IBMtBiqNfV21A==
Date:   Wed, 6 Dec 2023 09:44:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        arnd@arndb.de, angus.chen@jaguarmicro.com,
        u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kunwu.chan@hotmail.com, Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v2] ARM: imx: Check return value of devm_kasprintf in
 imx_mmdc_perf_init
Message-ID: <20231206014429.GB236001@dragon>
References: <20231122064636.7268-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122064636.7268-1-chentao@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:46:36PM +0800, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Release the id allocated in 'mmdc_pmu_init' when 'devm_kasprintf'
> return NULL
> 
> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Fixes: e76bdfd7403a ("ARM: imx: Added perf functionality to mmdc driver")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Applied, thanks!
