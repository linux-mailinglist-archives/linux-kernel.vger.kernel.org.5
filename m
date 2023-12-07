Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81078808D05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjLGQFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjLGQFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:05:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4758798
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:05:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2975C433C7;
        Thu,  7 Dec 2023 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701965123;
        bh=KcOzCFub8ssod3V/FhxLmPXK/68nf019P0mASYY0ERs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eCGzMDSoR/+wl69Y+vVbMpZ7DBo+NKpDAqzrEN82iivTCxSp/NfH/y9Iuiw0pt6Gj
         SKDNZVMS67K8q/tQ/wbvwovBDsdvNIEabgWP9MDXQ0jy+ZHIziPv/jITAXAJdRGK+o
         KqNRE/j6qRwaYW/4tEewd+VBR9mGoPag7R2CnPaEP54vAfqxFIvFe5wLoIkY0/QMVy
         x1myNu1zmGC7BkkHfGjvIk3tuY3H0+IWcPWRgwUNMQCNS+dOsliIvp3thvVKLqybaP
         b1Q/+bPSBAd+HL1BoudF66JRIY8eT/NCzys1dmgPNAy8IsGeCyTnqcIEoMSz9J9C3p
         IQWE36ors0yew==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, arnd@arndb.de, s-anna@ti.com,
        Kunwu Chan <chentao@kylinos.cn>
Cc:     kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20231204092443.2462115-1-chentao@kylinos.cn>
References: <20231204092443.2462115-1-chentao@kylinos.cn>
Subject: Re: (subset) [PATCH] mfd: syscon: Fix null pointer dereference in
 of_syscon_register
Message-Id: <170196512244.118077.2296590386926629676.b4-ty@kernel.org>
Date:   Thu, 07 Dec 2023 16:05:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023 17:24:43 +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> 

Applied, thanks!

[1/1] mfd: syscon: Fix null pointer dereference in of_syscon_register
      commit: 41673c66b3d0c09915698fec5c13b24336f18dd1

--
Lee Jones [李琼斯]

