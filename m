Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4678417A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbjHVNCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbjHVNCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:02:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B7ACE9;
        Tue, 22 Aug 2023 06:02:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6436664C83;
        Tue, 22 Aug 2023 13:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F5FC433BA;
        Tue, 22 Aug 2023 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692709321;
        bh=5wNvmmVUGipwdFV4DA5Qq+spVPdhC20+U8ualyHiEww=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=If6P8PLS1eHkLD5z6uQv3eMQ0eflflKqG0zQ/E7ehqhE9Ccgbgpuibkpy7IulplHp
         iGsGdyaSo36LwFFEYMc3u15d35wD0ajPs9MQOvgogLcHhYnNLRwnQC1dOF1OsLsq/a
         HacXXIROiENeIzBPt/QU12GeEi98/wOm53q+NinEQhu4n16dzIbeBYuBQz5gjvoOhv
         BRYYDrYSrCfOW8j2idMQKHbre+FQ+uwC/kVQvqBemCZVebvENM9bu86E9MOQ23HzFq
         j9eb1Ha5RWNbOYusxmQvzOs0FuWoAlhOI9N3oECwXjlOWNXwD1iIzw5qRxz8Oz7yhW
         mcIfc8FsMY70A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        =?utf-8?Q?Fran=C3=A7ois?= Armand <fanf42@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ath11k <ath11k@lists.infradead.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Fwd: Qualcomm NFA725A on T14s AMD Gen3: Bluetooth: hci0: Failed
 to send headers (or body or access otp area)
References: <a669d2d5-fee8-5841-eb5f-b7d047d3cdb2@gmail.com>
        <87il99j8dh.fsf@kernel.org>
        <89c53213-cb9b-7a8c-bc9c-92cabfdbba4d@gmail.com>
Date:   Tue, 22 Aug 2023 16:01:57 +0300
In-Reply-To: <89c53213-cb9b-7a8c-bc9c-92cabfdbba4d@gmail.com> (Bagas Sanjaya's
        message of "Tue, 22 Aug 2023 15:21:13 +0700")
Message-ID: <87fs4bi62i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 21/08/2023 12:02, Kalle Valo wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>> 
>>> Hi,
>>>
>>> I notice a bug report on Bugzilla [1]. Quoting from it:
>>>
>>>> Hello,
>>>>
>>>> (Sorry by advance if it's not the correct place to discuss that, but
>>>> I tried other place like my distro kernel forum
>>>> (https://bbs.archlinux.org/viewtopic.php?id=286929), interactive
>>>> chat, etc and nobody was able to help).
>>>>
>>>> [1] == Short summary ==
>>>>
>>>> I have a lenovo T14S AMD Gen 3 with a *Qualcomm NFA725A* Wi-Fi card
>>>> (which is actually reported by lspci as QCNFA765) and bluetooth
>>>> never worked on it, failing to load the rampatch with "failed to
>>>> send header" or "failed to send body" or "Failed to access otp area
>>>> (-71)".
>>>>
>>>> Other people reports bluetooth as working
>>>> (https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3)
>>>> and a work friend has a T16 AMD gen1 which seems to have exactly the
>>>> same chipset and work flowlessly. So perhaps it's an hardware issue,
>>>> but I don't know how to qualify it if so.
>>>>
>>>> => How can this be further qualified/debuged/workarounded?
>>>>
>>>> Any help, even RTFM pointing to corresponding manuals would be very
>>>> much appreciated.
>> 
>> This looks like a bluetooth bug so not related to ath11k (which is a
>> Wi-Fi driver).
>> 
>
> Oops, I really can't guess which driver is the culprit in this case unless
> the reporter also attaches lsmod output.

No worries, it's understandable that it's not always clear where the
problem is. And most likely the reporter also has ath11k driver loaded
as the same chip has both Wi-Fi and Bluetooth functionality.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
