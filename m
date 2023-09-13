Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB75079F15A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjIMSqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjIMSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E5E8A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694630703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ALiHg2DAm4CrjO+rrzTcSb1Bg2Fsn7RTODm9WaHRVnw=;
        b=h5+9z+DQ2MaQhIc/YJ4DP2eDFhGnrZmNA3x0RHMa9HkD5Qo8s6rMImSbeNQs1ytngrP7xC
        6gZPWK+/X6gXS1qex2S6flywDA6ccoybOWni2FosyIBF8KrlHxb0h2dv0QHk6Te5CKzoNb
        SBB/XALYbbnV2pnzqxmT6Rw8xInFJ8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-8olHctt7OlCbuBdBcA6eBw-1; Wed, 13 Sep 2023 14:45:02 -0400
X-MC-Unique: 8olHctt7OlCbuBdBcA6eBw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4030ae94fedso895735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694630700; x=1695235500;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALiHg2DAm4CrjO+rrzTcSb1Bg2Fsn7RTODm9WaHRVnw=;
        b=oMFB/lJRR3jRmI5WVKWptLITFMWg2FWtgqmJxmBHi0++2C+NTwKgrROKJSgZEe1BfZ
         Z41pLl+24jUhDoRkFBCsFw5B4r1sxM1C1GIhQtqgFqOaqYrN9zNeqmkb7cYztK2AAhhD
         Izui6Lrc0H2hQyGetZ9ls9NI49Rd8GqsmZqzOWEpUvwf+hhxZjqzHIlfeEd327ZXj0KJ
         0YdJeyPoHSZzXD7UXSvVT3a8jHO3zugwcMaVU6vsNN64m4uEMf3KgA5/jw5UXVLorM/n
         brcALkncAOX2rz3HhkZwP7vEqQiGTY9I9/86g6JIrSbC332PIfAAgoAFeyKqD45dXfsC
         jjJw==
X-Gm-Message-State: AOJu0Yyc0SpFs6JVvo6FrTxq9yiH2e9ivy/kCgNBcWljMBDfRnL8IHXQ
        shAJDR9kT6jRTF/KE2ch1sFA38hxlei1DLRodV8snj22YipBBVHn/Nydj6i2/NQWCpOL+kaA89z
        HFyFBlgkER9V8nUUWIOpfmppZkMLpzM1kTkM=
X-Received: by 2002:adf:f20c:0:b0:317:cdc4:762e with SMTP id p12-20020adff20c000000b00317cdc4762emr3180533wro.63.1694630700634;
        Wed, 13 Sep 2023 11:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsA+/DVhWEoHNeniSqVwIkWrWo8eU3dHqN5UdXQvqUCsBhUbeUYgaIBrxVIjn399uvHbE+ww==
X-Received: by 2002:adf:f20c:0:b0:317:cdc4:762e with SMTP id p12-20020adff20c000000b00317cdc4762emr3180521wro.63.1694630700232;
        Wed, 13 Sep 2023 11:45:00 -0700 (PDT)
Received: from rh (p200300c93f1ec600a890fb4d684902d4.dip0.t-ipconnect.de. [2003:c9:3f1e:c600:a890:fb4d:6849:2d4])
        by smtp.gmail.com with ESMTPSA id r17-20020adfce91000000b003198a9d758dsm16297341wrn.78.2023.09.13.11.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 11:44:59 -0700 (PDT)
Date:   Wed, 13 Sep 2023 20:44:59 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc:     linux-kernel@vger.kernel.org
Subject: aarch64 binaries using nolibc segfault before reaching the entry
 point
Message-ID: <5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the tpidr2 selftest on an arm box segfaults before reaching the entry point.
I have no clue what is to blame for this or how to debug it but for a
statically linked binary there shouldn't be much stuff going on besides the
elf loader?

I can reproduce this with a program using an empty main function. Also checked
for other nolibc users - same result for init.c from rcutorture.

tools/testing/selftests/arm64/fp/za-fork is working though - the only
difference I could spot here is that it is linked together with another object
file. I also looked at the elf headers but didn't find anything obvious (but
I'm a bit out of my comfort zone here..)

After playing around with linker options I found that using -static-pie
lets the binaries run successful.

[root@arm abi]# cat test.c
int main(void)
{
         return 1;
}
[root@arm abi]# gcc -Os -static -Wall -lgcc -nostdlib -ffreestanding  -include ../../../../include/nolibc/nolibc.h  test.c
[root@arm abi]# ./a.out 
Segmentation fault
[root@arm abi]# gcc -Os -static -Wall -lgcc -nostdlib -ffreestanding -static-pie -include ../../../../include/nolibc/nolibc.h  test.c
[root@arm abi]# ./a.out 
[root@arm abi]#

All on aarch64 running fedora37 + upstream kernel. Any hints on what could
be borken here or how to actually fix it?

Sebastian

