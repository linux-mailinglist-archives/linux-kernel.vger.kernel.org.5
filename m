Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8528275A70E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGTG6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGTG6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:58:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0A8110;
        Wed, 19 Jul 2023 23:58:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0780618E3;
        Thu, 20 Jul 2023 06:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB64C433C8;
        Thu, 20 Jul 2023 06:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689836290;
        bh=7mK4Ss6OHN/futLgmH2TgGuEhX+eZoCr1St7KNuM1Ak=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rW7A+yfNq+AWVSYmbDooALBYl0/JFJ3+2+nqaxcFE8jj+p5JxoqT2khnsjgh/NzD9
         oy7n8TGTAq5sTOFXmX07dK0eNxRn5eQOFHRuIX4QOzcQGTjlkskvQ+/FBt7QnG5QNu
         WMScSjUy6Wcfj06CO0yzFT7+i9MFU0XPPwC6D3VyiSsLMPVsR6K/xaajGcg1YZ26RI
         cPxX6RLsQIRDFucf2itNBo3a2TiiU9Ov34Dg6dfQZq4EFVTa87sonvVs6bTkLeK4ca
         6cLwcC/AjZ2bdrlFAdycmJmm86n9iOti6KwaFBgYGY0gMo7KCw86a2U8AYyGr9S7Nt
         ry2p3who6IsSA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Wang Ming <machel@vivo.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net v1] ath6kl:Fix error checking for debugfs_create_dir()
References: <20230713040518.13734-1-machel@vivo.com>
        <a9dc336793322d3525280e4f30b2acbd0c88bbf8.camel@redhat.com>
Date:   Thu, 20 Jul 2023 09:58:06 +0300
In-Reply-To: <a9dc336793322d3525280e4f30b2acbd0c88bbf8.camel@redhat.com>
        (Paolo Abeni's message of "Thu, 13 Jul 2023 11:29:30 +0200")
Message-ID: <87jzuv3w8x.fsf@kernel.org>
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

Paolo Abeni <pabeni@redhat.com> writes:

> On Thu, 2023-07-13 at 12:05 +0800, Wang Ming wrote:
>> The debugfs_create_dir() function returns error pointers,
>> it never returns NULL. Most incorrect error checks were fixed,
>> but the one in ath6kl_debug_init_fs() was forgotten.
>> 
>> Fix the remaining error check.
>> 
>> Signed-off-by: Wang Ming <machel@vivo.com>
>> 
>> Fixes: 9b9a4f2acac2 ("ath6kl: store firmware logs in skbuffs")
>
> The SoB tag should be after the 'Fixes' one and you must avoid empty
> lines in between.
>
> (The same applies to your other patch)

And the same as with the ath9k patch: this should go to ath-next, not
net.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
