Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEBD78230A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjHUFC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjHUFCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:02:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760FEA3;
        Sun, 20 Aug 2023 22:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C1F961F9E;
        Mon, 21 Aug 2023 05:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBBDC433C7;
        Mon, 21 Aug 2023 05:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692594142;
        bh=/n3hR5EYT3KBFmLwBg1A5O09p9o/K88PJFEoXgWvlvk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=uhqtSgTEGCMi0cDV7OxE56LMj9UAbkte1OuhFDuMc0g5++q8Uf3fHQQcKR2CofiGg
         u94JM9fWCOpqK2CTmVq3z0z1f/28d2Qb9m8m9UbD856x1lRHTjZA1OqguxMaMS2Vwx
         n3foqpmQFCxFdQEe/HdKrskG/o+IoeapGcEjCJ1gtUa9pYKS6FzFhdZ4odHfL/wRsa
         /LgljvaGKiJr+2Pdr6bzv+gfbAut43FIHFb4X2ZjF0CuplgBYUy3xT4E0aQl5K9OCt
         bv0bcTnoHvIv+SQPNm6p7qlNJPrZ7RKzIDQ8DWTD/dAHnMF/UirvZr5pGiF+R2cPvi
         pu8x9D06RDO3g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        =?utf-8?Q?Fran=C3=A7ois?= Armand <fanf42@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ath11k <ath11k@lists.infradead.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Fwd: Qualcomm NFA725A on T14s AMD Gen3: Bluetooth: hci0: Failed
 to send headers (or body or access otp area)
References: <a669d2d5-fee8-5841-eb5f-b7d047d3cdb2@gmail.com>
Date:   Mon, 21 Aug 2023 08:02:18 +0300
In-Reply-To: <a669d2d5-fee8-5841-eb5f-b7d047d3cdb2@gmail.com> (Bagas Sanjaya's
        message of "Fri, 18 Aug 2023 17:16:17 +0700")
Message-ID: <87il99j8dh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> I notice a bug report on Bugzilla [1]. Quoting from it:
>
>> Hello,
>> 
>> (Sorry by advance if it's not the correct place to discuss that, but
>> I tried other place like my distro kernel forum
>> (https://bbs.archlinux.org/viewtopic.php?id=286929), interactive
>> chat, etc and nobody was able to help).
>> 
>> [1] == Short summary ==
>> 
>> I have a lenovo T14S AMD Gen 3 with a *Qualcomm NFA725A* Wi-Fi card
>> (which is actually reported by lspci as QCNFA765) and bluetooth
>> never worked on it, failing to load the rampatch with "failed to
>> send header" or "failed to send body" or "Failed to access otp area
>> (-71)".
>> 
>> Other people reports bluetooth as working
>> (https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3)
>> and a work friend has a T16 AMD gen1 which seems to have exactly the
>> same chipset and work flowlessly. So perhaps it's an hardware issue,
>> but I don't know how to qualify it if so.
>> 
>> => How can this be further qualified/debuged/workarounded?
>> 
>> Any help, even RTFM pointing to corresponding manuals would be very
>> much appreciated.

This looks like a bluetooth bug so not related to ath11k (which is a
Wi-Fi driver).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
