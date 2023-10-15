Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB3A7C99A6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJOPAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJOPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:00:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DC0C1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 08:00:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0577DC433C7;
        Sun, 15 Oct 2023 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697382008;
        bh=i1GxOtLnEEkuG6UtAHUPo6Syh/xF5t9Xh8yNbZzp1nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r13FFCdMoDsRZoAP3FchBMyje6QT4GpAgEDxnCM10TRk47MWPE0/XRFLgAAfv6FBB
         CHBE1odsSJTtZ0QTDv0I2e7ycYgZ9Bqd973o5gXuRAdK9hlweTGTcVfAJO5IGP/v6G
         5jU4mfqa5PWV6BGHMvlv/3bXwuV7l4KoFAIFy7WvZs8aknz/FK2yfb0ZSuZNl9VmJT
         V8REeXj0mn0iybqhEYtCrQHkeVSyr5D4ysNdoRdgVJonfmaAjfGxr12sw8DF9/XqkN
         YblNPv541aLT2Qg2VM0DExr++cI089lzsC6u+GMn7YrICTyV4u3eDWEvnWUn5i5e0m
         u1e0iJxIVuFSg==
Date:   Sun, 15 Oct 2023 17:00:03 +0200
From:   Simon Horman <horms@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: smsc: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <20231015150003.GB1386676@kernel.org>
References: <20231012-strncpy-drivers-net-phy-smsc-c-v1-1-00528f7524b3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-phy-smsc-c-v1-1-00528f7524b3@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:27:52PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this dedicated helper function.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("

I agree that this is functionally equivalent.

Reviewed-by: Simon Horman <horms@kernel.org>
