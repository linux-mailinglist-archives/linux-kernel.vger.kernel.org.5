Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506AF7683FD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 08:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjG3GGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 02:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3GGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 02:06:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A3C172C;
        Sat, 29 Jul 2023 23:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690697177; x=1691301977; i=svenjoac@gmx.de;
 bh=F5U0XWlMGWxKX4lJcQ4zQRqGGIsSKTzGOyOlXbi2bUk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:In-Reply-To:References:Date;
 b=C7n28bjHHQR62VwOqATdh0g6/yDqte4WhoKxzGUQ2znaVOwoUIJRXmOkHpATXFQfDykn3ad
 /jVwZXitr2HPX4ghCgIR4NDfasMKIcGnh8odMgGhcNQPVgRXIor2F6o0HDZKg1KHFCLoPObQr
 7jfQfwOzyX0gpxZRjdBuF4WCJaYQNQrKvAUmhOqzGgUve2m0E04PdEB+pbfoJBAYoFfuE+SYi
 qEF1gkj364lWokVH69zKQlrJwh7+bqpfJr4ALxH0aBwnD81T5jYm7xU0rRSGf8sIhGEwFbpCc
 iacQohzkOQlivgY6Oc5Nz/vi5DR/HIiNw+YQdhsbMOk2M5ETziDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.203.84.168]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MbzyP-1ps1GI2Zw7-00dVky; Sun, 30 Jul 2023 08:06:17 +0200
Received: by localhost.localdomain (Postfix, from userid 1000)
        id A31FF80088; Sun, 30 Jul 2023 08:06:16 +0200 (CEST)
From:   Sven Joachim <svenjoac@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/*/configs/*defconfig: Replace AUTOFS4_FS by AUTOFS_FS
In-Reply-To: <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 29 Jul 2023 14:07:41 -0700")
References: <20230727200041.21404-1-svenjoac@gmx.de>
        <CAHk-=wgK9-Tx4BxYMrc0pg==mcaz3cjWF6-CBwVpM_BZAmf4JQ@mail.gmail.com>
Date:   Sun, 30 Jul 2023 08:06:16 +0200
Message-ID: <87sf96kk6f.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:NyVFSpd/+qMSz0ViOLGTAse3o+sjmleMxjHv+3zytwfzlCDPQcE
 oqT/+0Q+Svqiz6iefo64DHnGPA6VPMeZvdDgsab9U50jlSi8wrmoE+g7lcy4b5NUgWmoeDj
 Z4gJv1fgyxNMY0h7a9YCDGxL5i7aBo6td2DeaYVKgeqlT4QK/J3GPUr6qsRECJ9xNvkfUvi
 wZjpB69oAgkBbAIYWUdkA==
UI-OutboundReport: notjunk:1;M01:P0:ptCZPK0zY1s=;O7Fd3TWE44KfrKdVccaBl6yeNMb
 rffZL7w4qSi/WOr/Q/oB3prm15Bzagt+POqMpUbgOzrZXVPhgT+NA7VJtfrpqvSCruRaSmX6K
 uq2ye8wk9SB87t9DBzlpWea/DcT2wgGhaLpPxe7kti03si/o5XsHeNRmQT2EPxKGPoEX1o95K
 QW3oApMfxBcDop2LFR/O8aoF+L2fHJVDkpNkMSZlvMuBi8QCljfl9XOzxju3pOM4FArKqggCI
 bONBexDpdeZ6vqyx3mpv4ZC2UXUhmWakzh3t5N04Enue4S628Ji3sbtJvk5gfmLtFUvANzS0T
 Any9V+TXKutvBp7eq9nOxNwPec+OK0SRGHwidt0TfemCXcFbOC4sXKRe35lzW0i5mbvPuUCTn
 bZfrmqsUO298+vZxEq3l1uQDpgMgOpjCojpHGCNEOdPm7VHp8xZ1/tcdh7mRBl+5eJQXqBclf
 YcW8RtZpmnrt4Lr9/MpkrpUac448PNloROsgtkV6i283Cz8NkaW/KWTxBFoBKJ4Ei6AUOZLO7
 srEj00v0YyI6OEwITWVyARBOfIjn/QBwH4yUUSSDPQJnwsuMDNJGgIF2xsxqopTydeCf0+/2D
 rhjWKTF5jAyOObqbhQwHYS7wbvdY39/yj42rhlP4SvLWK8ABtutCO0uzodikqRepborM8WzLh
 SpJBXcHej31lOA+XANph1BKRJsEmWX1SwjfRdPd+9jAub3IXQncQD9c0f3fYAr/ymVvsTY7z+
 mXfDuJRDD92NcZte59tlrdyz0i2T0bnHmFKjfPfJNqqAAjQdDeWySppdP9iTVFZBD2NPFxzh1
 rI5mRph5yCWYzBF2hyJrkwtMQVJ9fwHuRu9x7iseJcRf86lSFhDLvFI6RVTBZakzUPI35q2WC
 dcKKLeJdp/kxZPat45mYBuiK7Hy7XxVRla4Pa/T2GZXOQy+Z4yAQGbFGxQciN0mC7U5qeG4pi
 D1rGCJeXb5obzrsqXfJzJTSTbHU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-29 14:07 -0700, Linus Torvalds wrote:

> On Thu, 27 Jul 2023 at 13:01, Sven Joachim <svenjoac@gmx.de> wrote:
>>
>> Commit a2225d931f75 ("autofs: remove left-over autofs4 stubs")
>> promised the removal of the fs/autofs/Kconfig fragment for AUTOFS4_FS
>> within a couple of releases, but five years later this still has not
>> happened yet, and AUTOFS4_FS is still enabled in 63 defconfigs.
>
> Ok, I ran the script, and also decided that we might as well remove
> the AUTOFS4 legacy naming stub entry by now.
>
> It has been five years, and people will have either picked up the new
> name with 'make oldconfig', or they just don't use 'make oldconfig' at
> all.

I had not added the suggested the removal of AUTOFS4_FS from the Kconfig
in my patch, because some projects seem to have have copy-pasted from
the kernel's defconfig files, e.g. systemd[1].  Hopefully not a big deal
for actual users, but worth mentioning.

Cheers,
       Sven


1. https://github.com/systemd/systemd/pull/28561
