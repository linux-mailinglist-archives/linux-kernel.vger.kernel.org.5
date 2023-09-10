Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48773799FF7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 22:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjIJUuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 16:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIJUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 16:50:43 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6F188
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 13:50:39 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:3f:e471:aa00::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id ED3563FD;
        Sun, 10 Sep 2023 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1694379039;
        bh=EEb3c06IHZTog/VbVFDFJACWLdjEJ2ozf7pYV9f4gNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Do495KQBqdmgT/sayRufiWhCg6XxKDZom7IoV6eo/uEMiU9GDxVWgnQ9b/6CVJVMi
         m3jXmgqBXsj8iKCoBAx3VJPgqqiueBzkzBd7JNfEyd1RhNrtbudCFv5MEXnYJnFxuB
         96xP2e0zE8dlSVywPmRYn6Bh+J37GRPuteAu6gfY=
Date:   Sun, 10 Sep 2023 13:50:37 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: ABI: sysfs-driver-regulator-output
Message-ID: <1518370c-e0cd-4d78-af54-3e2cf4dd6e3c@hatter.bewilderbeest.net>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
 <20230831121412.2359239-3-Naresh.Solanki@9elements.com>
 <90b1af83-cb03-476f-9147-eb06247bf09c@hatter.bewilderbeest.net>
 <2023090330-bling-mammary-3177@gregkh>
 <6eb78818-7838-4616-bf44-05c215bfa8b3@hatter.bewilderbeest.net>
 <763bd845-d8d6-489c-bd31-305ed14bc40f@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <763bd845-d8d6-489c-bd31-305ed14bc40f@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 05:24:31AM PDT, Mark Brown wrote:
>On Sun, Sep 03, 2023 at 05:48:14PM -0700, Zev Weiss wrote:
>> On Sun, Sep 03, 2023 at 06:04:23AM PDT, Greg Kroah-Hartman wrote:
>
>> > But yes, reading a sysfs should almost never cause a side affect at all.
>
>> > But what do you mean by "clear events?"
>
>> I mean that when the sysfs file is read, the state variable whose value it
>> exposes is also cleared as a side-effect (so the read operation "consumes"
>> the value it returns) -- see the implementation in patch 2 of this series
>> (specifically the 'data->events = 0' assignment in events_show()):
>
>It's a clear on read interrupt.

Sure, analogous behavior in hardware is reasonably common, but that 
doesn't strike me as a very compelling reason to design the 
kernel<->userspace interface to mimic it -- providing nicer interfaces 
than the raw hardware is one of the main reasons for having an OS in the 
first place, after all.


Zev

