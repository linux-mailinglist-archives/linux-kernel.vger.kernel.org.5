Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5B7B6866
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbjJCL5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjJCL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:57:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A447A3;
        Tue,  3 Oct 2023 04:57:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32325534cfaso817001f8f.3;
        Tue, 03 Oct 2023 04:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696334256; x=1696939056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VANSwdMtKQG22oVUynGC+nLSUv43BbxBHTaM2yqQ5MY=;
        b=nH7HD3qA0sSuOAc77mAqVP+Ij9L1p3KHUQ+V6Gxl0aLpoQC8v2KlfNbipFsJs+0H56
         cuDl7QtozqwVvajK3QV/aSmp+c1j/uIzXpB0Uy2DbbkYUpBqSO9Z85Bhhs6L223pl0U9
         DVHLPPaDJN7g2+ksq7jzZ0t1kwoIcAiky6qHZPSXTPd+4zRJXOfDMq32zAyNLwIRUV9t
         mHvth+GX6X4QOsaFlQOAw86IpzeaZqdOQsJ40VGyhzPgPPKaffxknlamHc077ksug5l+
         7tTuScLwMzy1qGpvo9DccNRMCT7qDZtLjGfH9tPp9+HvslhDnlKCt36x+CPqqsOcyoRR
         GGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696334256; x=1696939056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VANSwdMtKQG22oVUynGC+nLSUv43BbxBHTaM2yqQ5MY=;
        b=bCTHVBn+VJ/IQ05z7JUIPLfBtxcEniihevBe2gX60Tzk1HiYjVcDZcGpkZeFwXRkhS
         ogBNkbuyt8fQGB1IP4LqhxVSWi+WlbkkVkwCpbHC4P7nS9Qvdg1r3qxAgwmyWlfXxD7Y
         ecqWp2QHcOvHgbm1bBA2wlQswMnAiLoWXeYvEQWZSYpuD+CK2KeJmPPEmHW0DQyia911
         4ffbuWaIJoVBB8blk7BgX5OT8sxrlkGibIjt1t1BDO81IXj/JrAelXLIkKWZLwJyqzpZ
         eTl5dQTlDjStA/KG6gPBQz2pbPsAPJzEvIpUhtrdHjNybX/4uZxo2x/Fpe9SkrVgU5NX
         4hSg==
X-Gm-Message-State: AOJu0YyyZtWPd/NgdHpk0qbZhXfYnV6/c1s6sDZyJqKxPvKptIHyz+rC
        7UHdo51cFBcXGbGq/rpFzZQ=
X-Google-Smtp-Source: AGHT+IHwU9MkpQUrxS9gP8cSDIFn9YMWzv+pZGgz/jIthHTNFSKYtbYBY0OX9S2z4qaS6LNmYqIYNA==
X-Received: by 2002:a5d:5b17:0:b0:31f:a4fa:130a with SMTP id bx23-20020a5d5b17000000b0031fa4fa130amr14501035wrb.14.1696334255710;
        Tue, 03 Oct 2023 04:57:35 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id o4-20020adfcf04000000b00326f0ca3566sm1401367wrj.50.2023.10.03.04.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 04:57:35 -0700 (PDT)
Message-ID: <62d3678a-a23d-4619-95de-145026629ba8@gmail.com>
Date:   Tue, 3 Oct 2023 13:57:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230525113034.46880-1-tony@atomide.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230525113034.46880-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/23 13:30, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered physical serial controller devices.
> 
> To manage serial controllers, let's set up a struct bus and struct device
> for the serial core controller as suggested by Greg and Jiri. The serial
> core controller devices are children of the physical serial port device.
> The serial core controller device is needed to support multiple different
> kind of ports connected to single physical serial port device.
> 
> Let's also set up a struct device for the serial core port. The serial
> core port instances are children of the serial core controller device.
> 
> With the serial core port device we can now flush pending TX on the
> runtime PM resume as suggested by Johan.

Hi,

Unfortunately, this patch (now commit 84a9582fd203 with v6.5) breaks suspend on
a bunch of Microsoft Surface devices (confirmed via git bisect).

The root cause is that when we enter system suspend with the serial port in
runtime suspend, all transfers will be paused until the serial port is
runtime-resumed, which will only happen after complete() is called, so
basically after we are done resuming the system. In short: This patch
essentially blocks all serial communication in system suspend transitions.

The affected devices have an EC (the Surface Aggregator Module) which needs
some communication when entering system suspend. In particular, we need to tell
it to stop sending us events, turn off the keyboard backlight, and transition
it to a lower power mode. With this patch, all of these operations now time
out, preventing us from entering suspend.

A bad workaround is to disable runtime PM, e.g. via

   echo on > /sys/bus/serial-base/devices/dw-apb-uart.4:0/dw-apb-uart.4:0.0/power/control

or the diff attached below, but obviously that's not a great solution and can
be broken quite easily from userspace in the same way (and without users really
actively doing so through tools like TLP).

Any ideas on how this can be fixed without reverting?

See also https://github.com/linux-surface/linux-surface/issues/1258.

Regards,
Max

---
  drivers/tty/serial/serial_port.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 862423237007..6ceacea5e790 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -55,6 +55,8 @@ static int serial_port_probe(struct device *dev)
  	pm_runtime_set_autosuspend_delay(dev, SERIAL_PORT_AUTOSUSPEND_DELAY_MS);
  	pm_runtime_use_autosuspend(dev);
  
+	pm_runtime_forbid(dev);
+
  	return 0;
  }
  
-- 
2.42.0


