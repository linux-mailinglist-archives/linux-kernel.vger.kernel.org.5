Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C5976C625
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjHBHM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjHBHMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:12:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F0F18D;
        Wed,  2 Aug 2023 00:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3086D6181B;
        Wed,  2 Aug 2023 07:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15656C433C7;
        Wed,  2 Aug 2023 07:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690960368;
        bh=vvVsV9NiWis9C3pGrpjACtwIsJq8v0LCCmHawlI6+mE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=kPZb+vv7wqR3f3UGrR57UIs8CmaRLyz2MTCYxu9YSEMfqXkKLiqU7yddh4LJhqVYM
         LmQex4Q+/Z2CKDFY1bRY4N0y4/X6Kmq3lvmxNRsKin9jkR8JveNJlOARFZnH1zzCVp
         ohFV9W7GK4cfiItg98ABD0mXUMIqpu6Vk40vJlhyWANbj6d28n1waVk1ugXRdTuYDc
         8K+buNV/63ERZhIBfFb8mCeV3D8umhYi3FReiXQqCiHxan+9dkoZBDbhdVb3tWrl/i
         E63AZVAPhhHSIHOEIMtuXyWptCgfOaw2J43QT1rIbGPhCZXE9MNCur1JVvnV4Ulb6i
         ZnT03Vu9papew==
Message-ID: <845391b2-12f6-86b6-9ce6-19e16edbfce1@kernel.org>
Date:   Wed, 2 Aug 2023 09:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] docs: rtla: replace dashes with spaces in titles
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230802035037.404230-1-costa.shul@redhat.com>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230802035037.404230-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 05:50, Costa Shulyupin wrote:
> because
> - Titles containing spaces offer better readability compared
>   to those with dashes
> - Commands and their described subcommands are separated by spaces
> - Ensure that the titles are identical to the commands with subcommands

I added the - because that is how we call the man-pages:

man rtla-osnoise-top
--------------- %< ----------------------
RTLA-OSNOISE-TOP(1)                                                                                                                                                    RTLA-OSNOISE-TOP(1)

NAME
       rtla-osnoise-top - Display a summary of the operating system noise

SYNOPSIS
       rtla osnoise top [OPTIONS]
--------------- %< ----------------------


and it is also inline with other kernel tools, like perf:

man perf-record
--------------- %< ----------------------
PERF-RECORD(1)                                                                          perf Manual                                                                         PERF-RECORD(1)

NAME
       perf-record - Run a command and record its profile into perf.data

SYNOPSIS
       perf record [-e <EVENT> | --event=EVENT] [-a] <command>
       perf record [-e <EVENT> | --event=EVENT] [-a] -- <command> [<options>]
--------------- %< ----------------------

also...

[bristot@x1 rtla]$ make
rst2man --verbose rtla-hwnoise.rst > rtla-hwnoise.1
rst2man --verbose rtla-osnoise-hist.rst > rtla-osnoise-hist.1
rtla-osnoise-hist.rst:1: (ERROR/3) Invalid section title or transition marker.

===================
===================
rst2man --verbose rtla-osnoise.rst > rtla-osnoise.1
rtla-osnoise.rst:1: (ERROR/3) Invalid section title or transition marker.

===============
===============
rtla-osnoise.rst:3: (SEVERE/4) Missing matching underline for section title overline.

------------------------------------------------------------------
rtla osnoise
Measure the operating system noise
Exiting due to level-4 (SEVERE) system message.
make: *** [Makefile:36: rtla-osnoise.1] Error 1
[bristot@x1 rtla]$


> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

