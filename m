Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2340752931
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjGMQyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjGMQyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:54:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183B02701
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:54:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b71ae5fa2fso14416561fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689267258; x=1691859258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KGEyliUCXJSU8koPebhUNQWCpCmY8dz3cK7dturAlTQ=;
        b=fJkh6ygSqYwsccICxbLbXKPisIPjspSAhikqfG3yWmExnzxLuWVC9vUPLJItxLXIKz
         rGJKKuHkNZnzB0gTzEFcofZPjEyvbu1xtTR0HkctXN4xGRy/Wy/DmfpHErleqYCbc2lx
         h1V3jm2kXbT9OoGf8Jsi0Nb3fgGdjUCSy6E2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267258; x=1691859258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGEyliUCXJSU8koPebhUNQWCpCmY8dz3cK7dturAlTQ=;
        b=cGc7kfE82mDnKqNrAELEoQd0PYh066F2gRZFwIBQSd2KeYrcbVs9hUDwgb59eZdgLv
         hxqb7psMNiu/ZtQ6h2G3rQv/9zRvUm/SguTLJLIL88ws54uqpTkkNyo3ezlIwdbCLUVL
         tZqcpfu2qG8wIlrYVfU3WvGxP0NcLwG4c1OWcR+96ag94+ue56YD3Li0vDziPh537IRW
         3GoIPOqjhqsdvLG0J/vxQvYGwXJ8IbbTg9wu4MKVlq3pjz+5ilhgTCysSwP9vzdVb/xe
         JkXPsu+01saofchponkMkVA33oTItUJDLlZcrksUV+CTYmlMV520uwHq79JW42JUnoRQ
         7W3Q==
X-Gm-Message-State: ABy/qLbSvHoV6YeLeRMeOI8XL2SE6pKL/txkKbfaFQiBa72cinZcYjdy
        BHjYnOudfaDFIO9yVXfNUnL/XXS35Xj0qtqfWgvIyZIj
X-Google-Smtp-Source: APBJJlFNcP8sOXDVA3bK4F1mjVWcbvMHl9d8tajtXlRBb7zstvdCbt3jxEY+r9iKikSb3OgsqRg0HA==
X-Received: by 2002:a2e:808e:0:b0:2b6:df6b:84c0 with SMTP id i14-20020a2e808e000000b002b6df6b84c0mr1767223ljg.25.1689267258365;
        Thu, 13 Jul 2023 09:54:18 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o9-20020a2e7309000000b002b6e9b1e4aesm1572938ljc.78.2023.07.13.09.54.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 09:54:18 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so1691960e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:54:17 -0700 (PDT)
X-Received: by 2002:a05:6512:b85:b0:4fb:9075:4fca with SMTP id
 b5-20020a0565120b8500b004fb90754fcamr1900310lfv.11.1689267257561; Thu, 13 Jul
 2023 09:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info> <20230711120609.GB27050@lst.de>
 <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com>
 <20230712164546.GA31434@lst.de> <CAHk-=whA9rmvNfo=8iKmtimayiA2Aus4XvPwcDrA53G2rfGP0w@mail.gmail.com>
 <20230712165721.GA31965@lst.de> <CAHk-=wgzetYEqj7phbJBE_ZshFq0=k3zWouJ8XyFyERgDX5sZg@mail.gmail.com>
 <20230713114412.GA23427@lst.de>
In-Reply-To: <20230713114412.GA23427@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Jul 2023 09:53:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgVArJmE3rB+sHCURUP=oK-mW5-QfVyiRwZV9OLpWwxGg@mail.gmail.com>
Message-ID: <CAHk-=wgVArJmE3rB+sHCURUP=oK-mW5-QfVyiRwZV9OLpWwxGg@mail.gmail.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        =?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 at 04:44, Christoph Hellwig <hch@lst.de> wrote:
>
> Please stop putting words in my mouth.  Maybe instead of shouting it
> would help to actually read the text?

I have read the text. You spout unbelievable garbage. Even in this email:

> You said we've never seen devices with reliably IDs, which simply isn't
> true.  And that doesn't mean I'm saying all devices have reliably IDs,
> which somehow you're not trying to make me say.

When I say "devices", I obviously mean in general.

You seem to argue against it.

OF COURSE a _single_ device that has shown to have a UUID is likely to
then repeat that UUID reliably. But that doesn't mean it's true in
general.

The fact is, any driver subsystem that deals with more than one device
manufacturer had better not rely on any serial number for uniqueness.

If some device layer does, and there is a device without serial
numbers, then the bug is squarely on the driver, not the device.
Because the driver author clearly didn't think things through.

THAT is what I mean by "devices do not EVER reliably have uuids".

I just checked. I have on my desk access to three machines with NVMe
drives. Of them

 (a) one didn't have any UUID at all, didn't report namespaces and the
"wwid" exposed in /proc is that

        return sysfs_emit(buf, "nvme.%04x-%*phN-%*phN-%08x\n",
subsys->vendor_id,
                serial_len, subsys->serial, model_len, subsys->model,
                head->ns_id);

     thing.

(b) the other two had a NULL uuid and nguid, but seem to have a eui64,
whatever the hell that is.

So just from my limited test, one in three didn't have any UUID at all.

Deal with it. Stop claiming it's somehow "reliable". Two out of three
out of a random selection is not "reliable".

And it has never been reliable, judging by those quirks. When we have
manufacturers like Samsung, Phison, ADATA, Lexar, Sandisk, Micron, and
Kingston mentioned in the quirk list, we probably have covered most of
the consumer SSD manufacturers.

It's a sad that NVMe - that started out as a "lean mean low-overhead
disk interface definition" results in this kind of mess.

           Linus
