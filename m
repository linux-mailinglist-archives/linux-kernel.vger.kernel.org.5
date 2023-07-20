Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E8F75A707
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGTG5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjGTG5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:57:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2510A;
        Wed, 19 Jul 2023 23:57:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA2B6187C;
        Thu, 20 Jul 2023 06:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7AAC433C8;
        Thu, 20 Jul 2023 06:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689836232;
        bh=fXs2fVY+vB+2/iBQGPg3xvGoYcgTskOcTkd1P5PzeBI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MEWYyVxgEPFJ81W2p5kB28IKWg+NqfX8JHDsa5apWHBZCRdxBd+ygz50SMQTu22p3
         +sOZmcdi03ZFJhJsaLJ0eeKckaiB7ks6P4x+WV4IJ7oKDAXeSuLARE/l5q3rt08wda
         j9AHnknjNeRSq9+UitjX8pG1uFdqg5CSWfXwrce9/5yCMutnxGsXRzixJVO35aXIFf
         m3010qmx3ervxRenrRA6j37vu/Kk5CHLL52Y7QyDe3v8LK7XDvP0bvk/evLIytRa1l
         iwWyFGbwgBAYS6nv3E3VD9GsgAlZX70kdAlzi9EKpqRK8ddxtJjU8k+/d20t3izr+m
         Vvc3mNMG2UYlQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com, quic_jjohnson@quicinc.com
Subject: Re: [PATCH net v2] wifi: ath9k: Remove error checking for
 debugfs_create_dir()
References: <20230714084926.10986-1-machel@vivo.com>
Date:   Thu, 20 Jul 2023 09:57:08 +0300
In-Reply-To: <20230714084926.10986-1-machel@vivo.com> (Wang Ming's message of
        "Fri, 14 Jul 2023 16:49:11 +0800")
Message-ID: <87o7k73waj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Ming <machel@vivo.com> writes:

> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in ath9k_htc_init_debug().
>
> Signed-off-by: Wang Ming <machel@vivo.com>

This is not urgent and should go to ath-next, not to the net tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
