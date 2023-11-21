Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0227F31FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjKUPKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjKUPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:10:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC31BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:10:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D743C433C8;
        Tue, 21 Nov 2023 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700579414;
        bh=hoD9B9KaMcEvoeSUYddyjpm2ZdhkXr+vFTrOHMCpHEw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QpMwRnzf/CUaKy/Zs1u5MsOJr9UiZ4YZjf6yB078nlcpbnvgjGWnZBVs6FF2Kq2xW
         Ka+Kn/ebwt9mbV2o63YB5z78cP4yuVULoS8W4VAW85UrJNxJPUYgrH0NrSWL/92k6N
         5teoA+r2UeqOb+OwPCze4+tLg3zrrGSgUfQfGbk0vy0jw0rbY8YXi6aaMcyRaj5UjB
         l+5gu9PYHyxW8ZEjp5unPrapmcdYF9RdXHomMRaFOIE+bRHBCbpacnv8szqis7BLi6
         gfxGuMiSjxgj81UlfKk9mNivd028LicpDhEwAQ4HdRwwQXiC0Y28GzqXLOivwzhBxz
         GT9IrKq3pwB8A==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Takashi Iwai <tiwai@suse.de>
Cc:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        =?utf-8?q?Johannes_Pen=C3=9Fel?= <johannes.penssel@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20231121142629.27083-1-tiwai@suse.de>
References: <20231121142629.27083-1-tiwai@suse.de>
Subject: Re: [PATCH] Revert "leds: class: Store the color index in struct
 led_classdev"
Message-Id: <170057941222.880794.5199112193553712244.b4-ty@kernel.org>
Date:   Tue, 21 Nov 2023 15:10:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 15:26:29 +0100, Takashi Iwai wrote:
> This reverts commit c7d80059b086c4986cd994a1973ec7a5d75f8eea.
> 
> The commit caused regressions to a few drivers (such as Logitech
> keyboard or System76 ACPI) that already had "color" leds sysfs entry;
> now they conflict with the commonly created sysfs of led class.
> 
> For addressing the regression, we revert the commit, so that the
> conflicting "color" sysfs entry is removed.
> 
> [...]

Applied, thanks!

[1/1] Revert "leds: class: Store the color index in struct led_classdev"
      commit: 17e1ad377bb1d39260e0594ee284d8e03f64fdfb

--
Lee Jones [李琼斯]

