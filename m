Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6753B7EDD19
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344956AbjKPIsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344930AbjKPIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:48:48 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0A5182;
        Thu, 16 Nov 2023 00:48:44 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc53d0030fso4320745ad.0;
        Thu, 16 Nov 2023 00:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700124523; x=1700729323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GATFXn7/IsnPuYULBYePL+KlFeFXebf1N/cHiHpyv74=;
        b=bs8d3ZcAqmndMrC3EH/a02p2Rrp2TYu7vjsu9CH50ygTMLQcK9qZxw9PCh4mjAfIgK
         9FD2Bbp2QwoF47mTk4D8ROl4ukWYAdggcWbRrY0/SKhvkfUuBcMsJ7e1fkMrl6hqxXA3
         9WVHHeUduU+IO+jgp89ZDcbn34uiKXQwEC9MmCKcJ3VHY5SBXDxCCRy4GhzTPA4gblTL
         CrThTsVFhdoNekWaUgoqiFqkK4FftbdRY6YuqjuoNgWm/XZwMkr7TrnkBRgtfwXKl0fv
         ClueT5Z0qQf4zXZlWOaFOSXGGlfi7QAX5/aVOf2xaO5yX2iP5HTwJa0JoOJkUlvClSl3
         jNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700124523; x=1700729323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GATFXn7/IsnPuYULBYePL+KlFeFXebf1N/cHiHpyv74=;
        b=NtaGKSzfsCyi8cQhZHEWzQ+gM8LGlVk+2bVdUa3T0wviTvoAs+pS4oKnghvwNV6qeA
         64novsimN2hUzjzl1hq31ZPab0v//8y6+MjHFjOV+K3JgAN4vJ5XKBAEo6+5ed4YJOsp
         aoJ9EUlZrIdY3zzC16bBCEps9+2lVlQA2P5p1bmjo+MXvGEyYY6LQww8BAXlV2IFVn9W
         7vLpCSHMhMgvBjpred240df92G6KM006cF1mZVPeSJZpJy2l5qPk2JplgeWoGmlt7/3s
         8p9rCRHQO8dTlwbMLqSC0EXlehE5HKSOvm0yBkFUeP9tHdURfqzmdC3O/L2lPcZyoztP
         /lgA==
X-Gm-Message-State: AOJu0YwB8xOlMaBYtbKHWPovlgNDY9zMBa26GvjDjHb4MvQjC5y8736F
        NzSKtsdB6zN23Ts0d1WIuL0=
X-Google-Smtp-Source: AGHT+IHOkVrSZOUMmMqKfCBoRAtxgDZc/xI4gCc55zJX4FYTAnbrekU+RY/s4EgsymNiwMpe7ynh1g==
X-Received: by 2002:a17:902:e551:b0:1cc:4d4e:bfb4 with SMTP id n17-20020a170902e55100b001cc4d4ebfb4mr1450943plf.12.1700124523376;
        Thu, 16 Nov 2023 00:48:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ik12-20020a170902ab0c00b001cc54202429sm8907783plb.288.2023.11.16.00.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 00:48:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 00:48:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "xingtong.wu" <xingtong_wu@163.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com,
        tobias.schaffner@siemens.com, gerd.haeussler.ext@siemens.com
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Fix logic error for PWM enable
Message-ID: <0547e422-4a2a-4082-9ff8-62afb4cb79b4@roeck-us.net>
References: <20231116022330.2696-1-xingtong_wu@163.com>
 <20231116022330.2696-3-xingtong_wu@163.com>
 <4616f6a2-f81d-47cb-9574-2319d04d3f34@roeck-us.net>
 <d4b2882d-93d0-4223-9e53-f35a57163b94@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b2882d-93d0-4223-9e53-f35a57163b94@163.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 04:36:39PM +0800, xingtong.wu wrote:
> 
> On 2023/11/16 16:07, Guenter Roeck wrote:
> > On Thu, Nov 16, 2023 at 10:23:29AM +0800, Xing Tong Wu wrote:
> >> From: Xing Tong Wu <xingtong.wu@siemens.com>
> >>
> >> The determination of the "pwm_enable" should be based solely on the mode,
> >> regardless of the pwm value.
> >> According to the specification, the default values for pwm and pwm_enable
> >> are 255 and 0 respectively. However, there is a bug in the code where the
> >> fan control is actually enabled, but the file "pwm_enable" incorrectly
> >> displays "off", indicating that fan control is disabled. This contradiction
> >> needs to be addressed and resolved.
> >> Solution: Update the logic so that "pwm_enable" is determined by mode + 1,
> >> remove the "off" value for "pwm_enable" since it is not specified in the
> >> documentation.
> > 
> > The chip specification is irrelevant. What is relevant is the hwmon ABI,
> > which says
> > 
> > What:           /sys/class/hwmon/hwmonX/pwmY_enable
> > Description:
> >                 Fan speed control method:
> > 
> >                 - 0: no fan speed control (i.e. fan at full speed)
> > 		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I think this description may lead to misunderstanding. There are certain
> fans that cannot be controlled and operate at full speed while system is
> running. However, there are also fans whose speed can be controlled, even
> if they are currently set to full speed. In this particular situation, it
> would be better to inform the user that the fan can still be controlled
> despite being at full speed.
> How do you think that?

We need to be consistent. Yes, it might be arguable that we should
not return 0 if fan control can not be disabled by the chip, but that would
effectively be a behavioral change. We don't know if there is some userspace
program which expects to be able to disable fan control completely (and,
when doing so, setting fan speed to its maximum). Given that, I don't think
it is feasible to change the behavior.

Guenter
