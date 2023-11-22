Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92C7F451B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbjKVLqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbjKVLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:46:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988CAD7D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:46:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F7AC433C9;
        Wed, 22 Nov 2023 11:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700653581;
        bh=MyPYVBOb1JZQan55pmhKATWt/odIw2ODqt68yMlFupI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gMVxldUCSgXvsC5dn5yR/ULac2q4fOQ8SvLARrFz6fHI1Dt/iYdQXksQur2247kS4
         qDkyVU2+CCxCurHbVypQJh7EVysKJE8HCUiYYsqrdoZnCVhRU8bjruM6tGmqxrzY+l
         cAZVTroBV9wiJ/Cx+L5HOrbKnGt17hjtikKaUZ8PJkLvkac8cyrmv983PVMMxioCHl
         7M9iEzE8741fjaunh1USZthHf4uR85dUpW71knb2bhJXkriNHBVw0RxCzdwDj12ByI
         LfFXO4bIP1NPJHZblu4Brx/MW0t4uGym21fO1qtnZFhtMyO4P8arTIXxTJXt5od0ah
         MX5spd2BcrQuQ==
From:   Lee Jones <lee@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        =?utf-8?q?Johannes_Pen=C3=9Fel?= <johannes.penssel@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20231121162359.9332-1-tiwai@suse.de>
References: <20231121162359.9332-1-tiwai@suse.de>
Subject: Re: [PATCH] leds: class: Don't expose color sysfs entry
Message-Id: <170065357900.994845.3674008624629651267.b4-ty@kernel.org>
Date:   Wed, 22 Nov 2023 11:46:19 +0000
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

On Tue, 21 Nov 2023 17:23:59 +0100, Takashi Iwai wrote:
> The commit c7d80059b086 ("leds: class: Store the color index in struct
> led_classdev") introduced a new sysfs entry "color" that is commonly
> created for the led classdev.  Unfortunately, this conflicts with the
> "color" sysfs entry of already existing drivers such as Logitech HID
> or System76 ACPI drivers.  The driver probe fails due to the conflict,
> hence it leads to a severe regression with the missing keyboard, for
> example.
> 
> [...]

Applied, thanks!

[1/1] leds: class: Don't expose color sysfs entry
      commit: 8f2244c9af245ff72185c0473827125ee6b2d1a5

--
Lee Jones [李琼斯]

