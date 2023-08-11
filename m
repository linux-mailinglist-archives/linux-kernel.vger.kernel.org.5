Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9157779AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjHKW0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjHKW0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA6FCE;
        Fri, 11 Aug 2023 15:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D7AC651AA;
        Fri, 11 Aug 2023 22:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490CAC433C8;
        Fri, 11 Aug 2023 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691792795;
        bh=uoDHaxNPOW0Fa1jjS9dAgVpjupxR10NJvSv1QRGTocU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fk6lC2QIuJGe+JLCJzmT1erXDMWJtg/dMlaxrr7m5Kcn/v+gsjW+yK1z1pMEX16mM
         Qk/SMhsGc470EtoqejSb80Z98S8XfDHmwXQ3+o7wNwOh8ZvLH/ENKB5572C3zann+a
         6tEdIaxcJ2H/IjO+ugH95mU3d03opsavD9MQwN7burGIXIDdBDk11J9UBXVsO6J+K5
         uI66J9UqGEC8s3nbVoXaNsCOZig2DCq6lcZpN85ceDBHvKTRQOLIMPfGGzgcFNlQAd
         0uqaTnQS42e6X9+wSv7S/4zlwdLf63lF4UxeO5sDC7ueSWyfamlckm9YXZnz62dZpI
         U4YGanMdxW6cQ==
Date:   Fri, 11 Aug 2023 15:26:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, rdunlap@infradead.org, void@manifault.com,
        jani.nikula@intel.com, horms@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] docs: net: add netlink attrs best practices
Message-ID: <20230811152634.271608c5@kernel.org>
In-Reply-To: <20230811031549.2011622-1-linma@zju.edu.cn>
References: <20230811031549.2011622-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 11:15:49 +0800 Lin Ma wrote:
> Provide some suggestions that who deal with Netlink code could follow
> (of course using the word "best-practices" may sound somewhat
> exaggerate).

I truly appreciate the effort, but I'm worried this will only confuse
developers. This document does not reflect the reality of writing new
netlink families at all. It's more of a historic perspective.
