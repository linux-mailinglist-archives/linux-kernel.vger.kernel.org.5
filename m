Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72B7800411
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjLAGkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLAGkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:40:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495991711
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:40:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2A7C433C7;
        Fri,  1 Dec 2023 06:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701412823;
        bh=nOID4CFf2d2gxuQ4yTAHQXQgTI6oj5aMcFGj7jjKdUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cPKCJevKfvslVRIJ5HQjWfQQhr2Oqu3+LYCMaZKh4UShFDVv2xmkohqiyj/5Pbcqt
         ilIjSWERb5R/rWtetR1vZghZ91XSU/j149xRjL90uxet37kcKfP5zwNmwfhfowLVKV
         Y/9FOxeVChwy2+4YjJHCTxauFz/8uu4hoh7q9rQcW9qoQZaZECFy7Fh5IyhxsuAUuQ
         9cFQJKMGsGoCWzEaQodACWsDJJXYbZkwa+MXh5iQ6M+WZo0hsRIimNOyfBN+gl2PxH
         kt4WOLx0EAXY78kT7SuilIWZLSDmOBt9MDCREtbExJw7KuLWAoKAlz91W2tjxe71/S
         01raUSnV7ss2w==
Date:   Thu, 30 Nov 2023 22:40:21 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for
 lan9303_get_strings()
Message-ID: <20231130224021.41d1d453@kernel.org>
In-Reply-To: <170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
        <170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
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

On Thu, 30 Nov 2023 13:59:58 -0800 Kees Cook wrote:
> Applied to for-next/hardening, thanks!
> 
> [1/1] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
>       https://git.kernel.org/kees/c/f1c7720549bf

Please drop this, it got changes requested on our end because
I figured Alexander's comment is worth addressing.
