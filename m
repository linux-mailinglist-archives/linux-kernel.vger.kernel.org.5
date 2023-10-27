Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6432D7D8F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbjJ0HJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0HJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:09:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAC61BC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:08:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FB8C433C7;
        Fri, 27 Oct 2023 07:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698390538;
        bh=5WPvMZXHj6SnWHKzmjOCyWmBTsevR5RWBT42u2tYT6Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=djguQmPRxLNmjYP9HHUj67/uEd0zfx8KeWVkiz51AIIpYw2lVH8qW0B0MfbRpUIje
         pLMOnDUaSzl386rS4fNWyfCgOeKql4iaRefnSH/kI+FVAQpkkZCMg8hov4dFdILjul
         dR3cUtJP2hF2h42zhQlsXvQCJhrobipu1HPqu90ilKmuDpqKFMemvGiECLBlxdyaBC
         T6N1ZSbC2tYoRhhYmIbdtxYWULzyhqeqkzZzN46peCq7r9cGKFs3j2UaIgQ60dIlPg
         Gjn4IcKGoXoNZoHAyQJZfHbpDDcCtF60mGs4pQROGMlEwgaN1hFfZsBxI5KZa9cEJg
         2/5rGVP9O4Rfg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
        <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
        <20231020044645.GC11984@lst.de>
        <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
        <202310201127.DA7EDAFE4D@keescook> <20231026100148.GA26941@lst.de>
        <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
        <20231026095235.760f5546@gandalf.local.home>
        <874jid8one.fsf@meer.lwn.net>
Date:   Fri, 27 Oct 2023 10:08:53 +0300
In-Reply-To: <874jid8one.fsf@meer.lwn.net> (Jonathan Corbet's message of "Thu,
        26 Oct 2023 08:05:41 -0600")
Message-ID: <87bkckczju.fsf@kernel.org>
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

Jonathan Corbet <corbet@lwn.net> writes:

> Steven Rostedt <rostedt@goodmis.org> writes:
>
>> On Thu, 26 Oct 2023 07:39:44 -0400
>> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>>
>>> While it's nice in theory to have everything documented, it's not much
>>> use if no one can actually find the information ...
>>
>> Does kerneldoc provide an automated index?
>
> If you go to https://www.kernel.org/doc/html/latest/

BTW there's now a shorter URL for this whic is really nice:

https://docs.kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
