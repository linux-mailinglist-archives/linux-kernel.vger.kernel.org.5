Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86937D957B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjJ0Kr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjJ0KrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:47:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E884018A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1698403640;
        bh=scnewICwos28uY3w6B5+AVxL28jk/U3U4erXzZ/w740=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=R7an/BvXmk6zHAjf/zZOxIofIyozCb1FFKCl2wait4uupeZxCA6t6WNDOgPydtEgu
         fw35hyN4ijQkAjQN3zd8HMNak0z/OlLE1qjSkib/ZIHRHG1N52q1NLMb8fKVr1i6fa
         yW4yMlLU19dHKRnNRO86oqzyaT0Y3xOWP/6LbFmgLG4vUO+/P+9xrtNMuXvJz3/cYo
         EQVS4L821yQBt/F6cxmmLBUdwRPSN2k98FUtP4RKxQ7raeqA7fGVqedpEbAKroSubd
         w0Igv8+qlkcRuGotBM1woCbYmVIyefNCjGsyWZ8m+oHSxZOV2jS8Qv2awIvqsG9jQV
         9VdioeV2QEzKw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGzrR6ZLyz4wcj;
        Fri, 27 Oct 2023 21:47:19 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cxl: make cxl_class constant
In-Reply-To: <2023102533-anyway-bullish-75be@gregkh>
References: <2023102434-haiku-uphill-0c11@gregkh>
 <9573ec63-a8d6-4c69-a70b-9095838d521d@linux.ibm.com>
 <2023102533-anyway-bullish-75be@gregkh>
Date:   Fri, 27 Oct 2023 21:47:16 +1100
Message-ID: <8734xwuytn.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Wed, Oct 25, 2023 at 10:16:55AM +0200, Frederic Barrat wrote:
>> On 24/10/2023 13:48, Greg Kroah-Hartman wrote:
>> > Now that the driver core allows for struct class to be in read-only
>> > memory, we should make all 'class' structures declared at build time
>> > placing them into read-only memory, instead of having to be dynamically
>> > allocated at runtime.
>> > 
>> > Cc: Frederic Barrat <fbarrat@linux.ibm.com>
>> > Cc: Andrew Donnellan <ajd@linux.ibm.com>
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Cc: linuxppc-dev@lists.ozlabs.org
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > ---
>> 
>> Thanks!
>> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
>
> Thanks for the review of these, I'll take them through my char/misc tree
> now.

Ack.

cheers
