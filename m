Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209AC75A87A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGTIAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGTIAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E416C2128;
        Thu, 20 Jul 2023 01:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 549046190E;
        Thu, 20 Jul 2023 08:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC17C433CA;
        Thu, 20 Jul 2023 08:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689840019;
        bh=KygzzZq0OVHc4+Ea/dW1//kUJYJAAPsAtJ8Y4FnaGrU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HUqok30sq9XASIb4jE10u9n3VvfrYB7YTy3liKnTC1yrqntkFNF/stAs61emw3qAr
         34BaVKmGb0po6XmQSPaJ7aIi/2AeZ49tBeayt6lvKeb8NXgg6UhNjWHPG8d4MChJkh
         zCVSGlJoX7hhXiBEEF/hKsKKYx/xS66c/fZ45HnN9RjhhWtJFLUJbD4D1fEJXIN7yh
         VTNVN5Ea8ZJGG1N+JJyVKFdCDDOQn7Ub66QZsczsYSL/+tpgRLUFpo+vqK/U3kSQU+
         JwxuRoQLoZ9AG4DrqNkDvJv/H2/XTeip0ri3y6GZt/tR8cOJBhU9LWJiIQLHmu7Z5K
         PqNt/U3WkeksQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com, quic_jjohnson@quicinc.com
Subject: Re: [PATCH net v3] wifi: ath6kl: Remove error checking for
 debugfs_create_dir()
References: <20230714014358.514-1-machel@vivo.com>
Date:   Thu, 20 Jul 2023 11:00:16 +0300
In-Reply-To: <20230714014358.514-1-machel@vivo.com> (Wang Ming's message of
        "Fri, 14 Jul 2023 09:43:15 +0800")
Message-ID: <87fs5j3tdb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Ming <machel@vivo.com> writes:

> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in ath6kl_debug_init_fs().
>
> Signed-off-by: Wang Ming <machel@vivo.com>

This should go to ath-next, not net.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
