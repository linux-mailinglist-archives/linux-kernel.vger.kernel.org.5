Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BF3800419
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377622AbjLAGnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAGnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:43:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF74D10A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:43:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE24C433C7;
        Fri,  1 Dec 2023 06:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701412994;
        bh=gy86aBRFM5ntewX0ZWm8ng5yRP0xd8Rja2LMdU2Bcig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bYFS8nnnwr5FxuEdaHlZzR89ekJRVbLOnMByvsOHLnOwVk723yvgGQd6QhdgRXpiD
         kI4n8oZHVts0pzoeyy18GDPzAb2tTBOf/16AnhGzyUTTlwrs9xYLwIwVgOMEO2lrmB
         QI8YxwB+bJT88Q1f2etWkLhwbZ+DUG/BSx8nhOQGWbsa9n/JWpNrd8X+2QPBGczd9l
         VfhIG0XBKro2uPMUCMpcYC/8yQEKs5qMxUDCSmB3LP1Mf0I57WDvxrM/Q+WOSgmPoU
         M3j5Ye/6u6ZfE/OX0oQujFzNCjEoSOAvGTLKOdT65yP0UX6i34CnMofHL28wIACnDc
         T8tVh2eHEDfEg==
Date:   Thu, 30 Nov 2023 22:43:12 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shahed Shaikh <shshaikh@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] qlcnic: replace deprecated strncpy with strscpy
Message-ID: <20231130224312.15317a12@kernel.org>
In-Reply-To: <170138162711.3649080.9337007847087027672.b4-ty@chromium.org>
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
        <170138162711.3649080.9337007847087027672.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 14:00:28 -0800 Kees Cook wrote:
> [1/1] qlcnic: replace deprecated strncpy with strscpy
>       https://git.kernel.org/kees/c/f8bef1ef8095

You asked for changes yourself here, please drop all the networking
patches you applied today :|
