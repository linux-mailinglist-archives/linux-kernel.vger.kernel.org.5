Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42197F5D91
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbjKWLQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344857AbjKWLQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:16:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC50B1AE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:17:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74721C433C8;
        Thu, 23 Nov 2023 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700738222;
        bh=+BWfhELumSEtfousUaAup9SYNDzK54Uyof1kF/79eoU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=UDiaiX7CjY/TlQUKcn10WKxAT+dmpvmEiNN96cIRA9R7Inlq99FKeX8v/ljRoDr4C
         u1DP8+4GTMbImP85+X7oK1v94u5r1VIb5nUVcXSK9rp8G3lnNHZ0vE/IisWFbA5mHw
         TSdBSK2zy+PgkENdQQtLaBAA6UZTcgj8dPGjFyOtJoMvY/ICGfBGuOhLfXrJ/fXaOV
         GWo+PoUkr2f7flAvRqKxzj73KA4Jlhy6Eh/NktCc0UG6Q6AlbDndXFtU3kMbQsP6OF
         KYZZTSc0FlSdTihUetn/YQL6Q08KEwRlrX+gdsSssNhSKEjzw8q3fDqehCF7XyM9/q
         rit5+BKWBwvaQ==
From:   Lee Jones <lee@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Chen Ni <nichen@iscas.ac.cn>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231106184052.1166579-1-andriy.shevchenko@linux.intel.com>
References: <20231106184052.1166579-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/2] mfd: intel-lpss: refactor PCI probe and common
 IRQ check
Message-Id: <170073822119.1252468.18122321322926530061.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 11:17:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 20:40:50 +0200, Andy Shevchenko wrote:
> The PCI code can be refactored to use respective PCI APIs instead of
> direct dereference of struct pci_dev members.
> 
> With that, we may unshadow the error code that is promoted in the irq
> field of info structure. PCI core shouldn't propagate 0 as a value
> there, and in case it happens it reveals a bug somewhere else.
> 
> [...]

Applied, thanks!

[1/2] mfd: intel-lpss: Use PCI APIs instead of derefereincing
      commit: e6951fb7878751aba4c147f1f206a2cbc05d1b9f
[2/2] mfd: intel-lpss: Amend IRQ check
      commit: ec791121b8ace33d2251b6c7a4d11a231ee51c05

--
Lee Jones [李琼斯]

