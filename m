Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0483B7D2887
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 04:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjJWC3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 22:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJWC3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 22:29:00 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD9FE6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 19:28:58 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ECC8D60A;
        Mon, 23 Oct 2023 02:28:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ECC8D60A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698028138; bh=0KOfgNJmYrOWne5jWp7m1xyXFQPilOG+H+n9z5Nrsz8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jWAAFjihV2uD8LYGMb/nqxFyji8vcfEDHDP0VJVrBcCocO9cBq8WftcZ9S/sjLl65
         1axvbJFTyxmahzM8QIre0mn2PPM92mZJtryDwSgFJg8so4SWuEwtjdoFyeauavP+BY
         ZVKZU20WGsPQNdho+Bhxcf2fI2KeXEtdSsCl5RA2oak1J3/956VabAjgZPebaoRz1w
         Wl3v2jmNS/rpRC1rHx3iVNMncDYeciB3gtnfeIkI4VyLWSOY3vfzX6P6WWsK83kf2p
         jVAYnsGeKoFnI3NSf1XQf4vORpkVqDF8B8hL+kGAvmY/wbIN+eO5V4epRAbJiWGPek
         4L2EbgqNU/V2A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        =?utf-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>
Cc:     ojeda@kernel.org, danny@kdrag0n.dev, masahiroy@kernel.org,
        jgg@nvidia.com, mic@digikod.net, linux-kernel@vger.kernel.org,
        joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
In-Reply-To: <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
References: <20230601075333.14021-1-ihuguet@redhat.com>
 <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
Date:   Sun, 22 Oct 2023 20:28:57 -0600
Message-ID: <874jiikr6e.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent MAILHOL <mailhol.vincent@wanadoo.fr> writes:

> On Thu. 1 June 2023 at 16:53, =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>=
 wrote:
>> EditorConfig is a specification to define the most basic code formatting
>> stuff, and it's supported by many editors and IDEs, either directly or
>> via plugins, including VSCode/VSCodium, Vim, emacs and more.
>>
>> It allows to define formatting style related to indentation, charset,
>> end of lines and trailing whitespaces. It also allows to apply different
>> formats for different files based on wildcards, so for example it is
>> possible to apply different configs to *.{c,h}, *.py and *.rs.
>>
>> In linux project, defining a .editorconfig might help to those people
>> that work on different projects with different indentation styles, so
>> they cannot define a global style. Now they will directly see the
>> correct indentation on every fresh clone of the project.
>>
>> See https://editorconfig.org
>>
>> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
>> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
>> Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
>> ---
>
> Is there any news for this patch? I would really love this to become main=
stream.

I have concerns about this patch that I have expressed in the past.

I'm not going to apply it... since it's a global change that affects all
kernel developers, I don't think I *should* apply it.  I would recommend
sending it directly to Linus; if you can get an ack from him, I'll apply
it then.

Thanks,

jon
