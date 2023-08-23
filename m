Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E62786140
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjHWULe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbjHWULZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:11:25 -0400
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:df01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE110D7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:11:16 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:778c:0:640:ea26:0])
        by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 07FF86110D;
        Wed, 23 Aug 2023 23:11:14 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b70f::1:a] (unknown [2a02:6b8:b081:b70f::1:a])
        by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id CBRZj10OjW20-NM6NavZi;
        Wed, 23 Aug 2023 23:11:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1692821473; bh=37jAFnqAKt8JGZVuqNDL1nlpxxgw+JdYaBJasqEpl5I=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=x5sw1vyAICz/MyJvyehgjr5XK//Q/mwQgsiUb9gPNhtc5gwMWfWRiOM/gg7U+RXZ5
         lhqAuUydqeHC8K8FUkbZQXVoINwYjdlVGB/y1B0L8WwTuQ+F+ejLpegKJEhMsyJgAj
         UtGckWDvDsEDA86IFhF6cetx13tfuaifp54JCB+k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <6bf09b4f-d9f8-f0e0-34be-f05e15c2fa0c@yandex-team.ru>
Date:   Thu, 24 Aug 2023 01:11:12 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 1/2] kernfs: sysfs: support custom llseek method for
 sysfs entries
Content-Language: ru, en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
References: <202308230126.O8xXYkdt-lkp@intel.com>
 <20230823125834.492298-1-valesini@yandex-team.ru>
 <2023082313-activator-faceless-422a@gregkh>
 <2023082310-satisfy-outburst-1068@gregkh>
From:   Valentin Sinitsyn <valesini@yandex-team.ru>
In-Reply-To: <2023082310-satisfy-outburst-1068@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>> Due to the high rate of errors and respins of this, I'm going to wait
>> until after 5.7-rc1 is out before adding it to my tree so that things
>> can calm down a bit...
Ack. Sorry for the fuss, I believe v5 should be final, unless someone 
steps in with essential review comments.

Thanks,
Valentine

> 
> {sigh}
> 
> I don't know what kernel version we are at anymore, it should be
> "6.6-rc1".
> 
> thanks,
> 
> greg k-h
