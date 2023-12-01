Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B84800E36
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379352AbjLAPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379340AbjLAPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:14:24 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F97194;
        Fri,  1 Dec 2023 07:14:29 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 89C3D2C5;
        Fri,  1 Dec 2023 15:14:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 89C3D2C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1701443668; bh=WgqQVcNyNmSbLfTjiMUoVBz8fOQdTqP7Vk/w7Mq97Tg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gQ+7/zk53MU65Q9BhQu3PiDAnHWkABz5ecDkMlvhBbFkILB5tLGpdKe0F/2wFZfbY
         eqVlMjd5Sq7jRfIJ7Z/n6kz645qpoGi/8nHpNY/iHu5Obdy09Rd8UmX0Q51OV4MaBa
         j/B5A+w4ukQq4tY88nds+bRNqz+vIpmsMHSZruIGCEg/v1nTWG7c13Erbc9boSZqUi
         lCSqF/zRv5lahYRGnYaEByQIeGIGAL8mQ4nQYm/a90f+rFKOpc76ISBEKeTztCuN14
         XNXPUNTG9e8k0WZVcc366Pw3zvovx/XkmrqimTJ9x0YKsvPBY5Ax6oZUzabns6lrwU
         HVEDgX8RUJwsg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Don <joshdon@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linux CGroups <cgroups@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Attreyee M <tintinm2017@gmail.com>
Subject: Re: [PATCH] cgroup: Fix documentation for cpu.idle
In-Reply-To: <ZWlzwnO7PcOWQ2q_@archie.me>
References: <20231201005203.309873-1-joshdon@google.com>
 <ZWlzwnO7PcOWQ2q_@archie.me>
Date:   Fri, 01 Dec 2023 08:14:27 -0700
Message-ID: <87fs0meyzw.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Thu, Nov 30, 2023 at 04:52:03PM -0800, Josh Don wrote:
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 3f85254f3cef..9debf02bcb39 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> +  cpu.idle
>> +	A read-write single value file which exists on non-root cgroups.
>> +	The default is 0.
>> +
>> +	This is the cgroup analog of the per-task SCHED_IDLE sched policy.
> "... cgroup analogy to ..."
>> +	Setting this value to a 1 will make the scheduling policy of the

Bagas, please stop this (again).  The original wording is better than
your suggested "improvement".

jon
