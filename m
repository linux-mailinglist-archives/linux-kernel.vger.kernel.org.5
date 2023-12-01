Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E3680090F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378357AbjLAKkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378337AbjLAKkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:40:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB2F1B4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:40:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4292C433C7;
        Fri,  1 Dec 2023 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701427241;
        bh=coe4HPytXXikBmxRXD89EWbUr+6HRrfFw+tus7gam/Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UzpYq/eFuk3rit5uhu9SRPzNMXFWDiwZqUtyB60JxgJQpR5S/zYGKl+nPDJb0GWyy
         Og+mGMgIsLREDCAbkKFbDDDlZ71xUVLWqzx9xvywQTxAcOvcdKPsi80ZO0dkn66qEg
         PBCI85xt8sWvTeOcn0IV1YIBjoR9aDPTs/6EzcBBXS5M3fOambqPqhl8pBNx9d2mKC
         cPYpVbhVwz06lrTYBwMXMNzo58R07Syta+VQygfvOXNFISk3ggl8r6JTSK42L6nWED
         mr+12vwyW2f/4/NYGMrEgMOXedYKEPxUQXSFN4dq7ddxYxMUgQ8kgq8qSm+rdCndU9
         R1Wh4AH/xStTw==
From:   Lee Jones <lee@kernel.org>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, Florian Eckert <fe@dev.tdt.de>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
In-Reply-To: <20231109085038.371977-1-fe@dev.tdt.de>
References: <20231109085038.371977-1-fe@dev.tdt.de>
Subject: Re: [Patch v8 0/6] ledtrig-tty: add additional tty state
 evaluation
Message-Id: <170142723852.3350831.6373465907279189004.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 10:40:38 +0000
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

On Thu, 09 Nov 2023 09:50:32 +0100, Florian Eckert wrote:
> Changes in v8:
> ==============
> - As requested by greg k-h [6], I have send the patch 2/7 of this series
>   about the memory leak also to stable.vger.kernel.org [7]. This has
>   already received a 'Reviewed-by' from Uwe [8].
> - As requested by Maarten, I have adopted his suggestion to invert the LED
>   blink, so that I do not have to save the 'state' in the tty data
>   struct [9].
> 
> [...]

Applied, thanks!

[1/6] tty: add new helper function tty_get_tiocm
      commit: 5d11a4709f552fa139c2439fead05daeb064a6f4
[2/6] leds: ledtrig-tty: free allocated ttyname buffer on deactivate
      (no commit info)
[3/6] leds: ledtrig-tty: change logging if get icount failed
      (no commit info)
[4/6] leds: ledtrig-tty: replace mutex with completion
      (no commit info)
[5/6] leds: ledtrig-tty: make rx tx activitate configurable
      (no commit info)
[6/6] leds: ledtrig-tty: add additional line state evaluation
      (no commit info)

--
Lee Jones [李琼斯]

