Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375AD7B457E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 07:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjJAFxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 01:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAFxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 01:53:36 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57A4C6;
        Sat, 30 Sep 2023 22:53:34 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c49f781855so9137676a34.3;
        Sat, 30 Sep 2023 22:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696139614; x=1696744414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePzrbSK5zIWLB/POBpdNRqPyVo624yH+IKEEXcTja4A=;
        b=Lv/43Mx1D0upFMXufDSkJPQW/ttFoNb2F8L3yUKvQQK626qLnN9Qv4O//J4Tv2n3Ij
         5pfKUxcmRcknhm4t9Kfepdw2orrJXXAlh1dV8mkbgndXR1UxXqOYnzjs27/lR3sdeIes
         N7CeZYN76Skttut1xmtl7V1RAf7PAKMA4PD4k9MKSz2oluhsRjEkSTBtDYTp5LMOwMmV
         VR0J9jNJ20zvLOh5pkn+lQH4JeRvqnwqPzbzix+4/RBnrsjpBzaPY+AsrM2/euCNCBg0
         XpEdDNmTPSwAsH8OX4nA3wKiognEzAPL41qbFHxPTfp8Dn3NLud3ewsKD9wDcIfIu+Hb
         GKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696139614; x=1696744414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePzrbSK5zIWLB/POBpdNRqPyVo624yH+IKEEXcTja4A=;
        b=lhlE4uaQ5GF3Z8V3Uo9qLFHm+BWsw2a4jKuW5KfV/ch3i95tiJUoeksajZGGDxnybx
         51F3AH2x1CDzexTUn2iUwuFXJWEMMK8PnqhXT/7fsEoRFo1pX96j213Q+FSR/CQJe+rU
         Ds0s6UEcj+wmlyeN9UEUDU/69OJDvzeHFlLBo0GGqmaa7L+JVgCkmKoWogbcsE3bMLZY
         2qjcQxN5B3kSxVQVs42P76y7k+l84MOBY7BEQDX3czeAMjfgt6uG4pAEuj3gM/fpT3Oc
         UUQS0gNOxo0fBPnVrQY7ZXyC6NP+6RXtle3Ihw+q+Az6Cei+r5hGdFxPJcUeiqZs9l7U
         c/bg==
X-Gm-Message-State: AOJu0YwC3Mdem3nVRxly9JpGlBcOYfZAx/fTqRz2s2Lnb+4BMCB7mp4O
        Syg/+0w6UOTGLQ7cDiUESeM=
X-Google-Smtp-Source: AGHT+IFdgLbyqA1IdKObOtUzDGkBSktGTpC4TDWsdy0Y5ilnYn/s05Yx9ZCg7ChzNCeroywcu2oUXQ==
X-Received: by 2002:a05:6358:1ca:b0:14a:e8af:1227 with SMTP id e10-20020a05635801ca00b0014ae8af1227mr9156051rwa.22.1696139613846;
        Sat, 30 Sep 2023 22:53:33 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a018900b002772faee740sm4492143pjc.5.2023.09.30.22.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 22:53:33 -0700 (PDT)
Message-ID: <3d246a72-2755-484f-8274-0c61fc185592@gmail.com>
Date:   Sun, 1 Oct 2023 12:53:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rt8000usb driver issue (maybe interaction with other drivers)
To:     enc0der <enc0der@gmail.com>
Cc:     Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux RCU <rcu@vger.kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Simon Horman <horms@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Gaul <gaul@gaul.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
References: <CAEXpi5Rd6Y4umKOWRsCjX0kit=W5ZrVhn=MuRkyvJPwmjjDVnA@mail.gmail.com>
 <ZRj_ovMi-Xbb8i-D@debian.me>
 <CAEXpi5RiLbma5cb-ctEvvb7LGRn78VTOh5HDmreC2hYgtBEQog@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAEXpi5RiLbma5cb-ctEvvb7LGRn78VTOh5HDmreC2hYgtBEQog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2023 12:33, enc0der wrote:
> Hello Bagas,
> 
> The distro I am using is:
> Jetson Linux 35.4.1 which is is part of JetPack 5.1.2
> 
> Supported Linux Kernel version: 5.10 LTS
> aarch64
> sample root fs built from: Ubuntu 20.04
> 
> When I asked Nvidia directly, their response was "Most likely it could
> be wifi driver issue because it gives."
> 

So you have to report upstream here, right?

> These are the drivers being loaded:
> 
> rt2800usb              36864  0
> rt2x00usb              24576  1 rt2800usb
> rt2800lib             122880  1 rt2800usb
> rt2x00lib              77824  3 rt2800usb,rt2x00usb,rt2800lib
> mac80211              811008  3 rt2x00lib,rt2x00usb,rt2800lib
> cfg80211              724992  2 rt2x00lib,mac80211
> 

I don't see rt2800usb module in the mainline kernel. Is it out-of-tree?
(no wonder why it taints your kernel)

> I've not worked with driver code before, so I am out of my element
> here.  I saw in the git history for rt2800usb some changes went in
> since I was using the USB wifi adapter on an older system that has a
> linux version older than 2019 (when the OS was compiled and flashed on
> the machine).
> 

Where is the repo?

Last but not least, please don't top-post; reply inline with appropriate
context instead.

Confused...

-- 
An old man doll... just what I always wanted! - Clara

