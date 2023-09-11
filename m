Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEBD79B5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjIKVGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbjIKON4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:13:56 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA73FDE;
        Mon, 11 Sep 2023 07:13:51 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qfhfh-0003w3-7O; Mon, 11 Sep 2023 16:13:49 +0200
Message-ID: <cb775a52-f28b-43d3-8af5-9b2547e13316@leemhuis.info>
Date:   Mon, 11 Sep 2023 16:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Slow boot and shutdown/reboot problems with 6.5.0+
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Integrity <linux-integrity@vger.kernel.org>
References: <5011708f-b0ae-2853-0f87-a3b59845a2cc@gmail.com>
 <CA+FbhJO8b5V_So2mMPu1ApKXTxk0ieWvNMa=HBTYTWDXLEA-ew@mail.gmail.com>
 <9a8d2090-a58e-49a0-3b1d-00bb5b8f04f2@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <9a8d2090-a58e-49a0-3b1d-00bb5b8f04f2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694441631;3dd2e87a;
X-HE-SMSGID: 1qfhfh-0003w3-7O
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.23 16:00, Bagas Sanjaya wrote:
> On 07/09/2023 20:56, Marcus Seyfarth wrote:
>> As to bisecting: Unfortunately I cannot afford the time right now to bisect this further as the system is used in production and already did invest a lot of time without success into it. Hopefully someone else can find the root cause of the problem. My systemd version is: 254.1, and I also use dbus 1.14.10 and dbus-broker 33.r35.g2220a84 which was configured with -D linux-4-17=true.
>>
> 
> [also Cc: Thorsten]
> 
> To Thorsten: It looks like the reporter can neither bisect nor
> test the mainline since he only has production machine instead.
> What can I (and the reporter do) in this case?

Well, unless someone[1] can find the root cause (either by guessing,
looking at the code-flow, the kernel warning, bisection, and others
things like that) we are out of luck; the only thing left is then to
hope that someone else will run into this and find the cause or that it
is accidentally fixed. That's definitely not ideal, but that's how it is
sometimes.

Ciao, Thorsten

[1] either the reporter or someone that sees this conversation or the
ticket; but things are quite confusing from the outside perspective and
a lot of private conversation seem to happen, so I doubt anyone will
take a closer look; a bisection is likely the best way forward here
