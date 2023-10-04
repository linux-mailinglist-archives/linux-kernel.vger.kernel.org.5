Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641A17B7CCA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbjJDKDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjJDKC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:02:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742AE83
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:02:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0B5C433C7;
        Wed,  4 Oct 2023 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696413776;
        bh=i6Mni9W0l9dpI1XoYC4wjLOEG3ztUx3lg98F4Pkk/Q8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nHrgxTiR2U1OakAgiKgKo94aKU72TZgNkZ95tWP+OmPIeTmN/pvN/JNKQj5e93G4u
         sELhrOTtdxE9CNnMr7S6EZ0RTOnxxpVGkY/279gzhUt3VZIQWq4MnGsPPVwWYJMvaJ
         cWdP4ZMIkG3L018MzQTxwcNuls7TpUODQLK9wW85M1dw14etl6rjMr3UaonjYMGjQ6
         nnaUwngCYRkzKmyUNda8LCRgXsLV8wGsenDd6wChzmxtd1xVZyCfz3HJJgjfYNW/os
         bHSGz4vIjB20BYLIdgAZ0zzuR4028CKz+rHArNNvTjVUA5mq/G2WPwOb0RaCP9io4w
         AOqkiz/vr1a9w==
Message-ID: <3fbe67a4-225c-14c1-cb5a-3f667ad80b0e@kernel.org>
Date:   Wed, 4 Oct 2023 12:02:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3] tracing/timerlat: Hotplug support for the user-space
 interface
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a1bbd57692c1a59458c4ee99999b7f83a29bc3c5.1695999408.git.bristot@kernel.org>
 <20231003210309.4335307d@gandalf.local.home>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231003210309.4335307d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 03:03, Steven Rostedt wrote:
> On Fri, 29 Sep 2023 17:02:46 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> The osnoise/per_cpu/CPU$/timerlat_fd is create for each possible
>> CPU, but it might create confusion if the CPU is not online.
>>
>> Create the file only for online CPUs, also follow hotplug by
>> creating and deleting as CPUs come and go.
>>
>> Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")
> 
> Is this a fix that needs to go in now and Cc'd to stable? Or is this
> something that can wait till the next merge window?

We can wait for the next merge window... it is a non-trivial fix.

-- Daniel
> -- Steve

