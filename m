Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473B07EC35B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbjKONMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbjKONMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:12:18 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E18121;
        Wed, 15 Nov 2023 05:12:15 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-778940531dbso411959785a.0;
        Wed, 15 Nov 2023 05:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700053935; x=1700658735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYJiido5hWzDKtuGReYk+NTentFWgMjd8DEBxS+St7Y=;
        b=YfCBoDa02I7uM0DcWWKqOBYX0ruVpHC2+AJwVkrgqMEwzpXMfvWwYqzfv5TKTBMIyA
         PexfmTmBdUqD3cSIELR8w7auq0HZbs+IDgboSzyDWSswPOvvS8+pa4jprspz3Ub1kKpl
         /n6bAuB29kmE4UT+o35Vsq3Ad/psZCEFfX229mLzxR4JBI98fpDLTb0Q8vESzBT56Rjx
         zpCsPknkYcIWj5FuL0iNTK9CTKPS1sl52UiXX0v2iqaElw/L5+/ZiqpD8TX7zU4XYw/0
         4UBc2sGi5voOgTQIsHy5FEER1Y7XMFEHECN8M4SHNJULfSSPwCMlxjzrcnAGnjcpeL0z
         OW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700053935; x=1700658735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYJiido5hWzDKtuGReYk+NTentFWgMjd8DEBxS+St7Y=;
        b=fr+pcY+0zkYamVWly5QNuhFrKHG3vfOdKVKBrzexyxFJDYMeER8bAMtHQosc/W3q/w
         pspGHsK82v8+UaWJ+b+LphGqmHsKA3dgUQnKiQroJp37iRGeTrNnEjeLQIjB6Jmk4hXB
         1lchXOZZAsTqNGLPVS8I3hge2alWOyOZzV9nDW2kXBekvunU95IEOPFn9vGASHEd1Jw+
         SaspZ5qffKxmDUEMXazpKbbyPPng/Bl0bYxN1XTj73OZEI1QeG/W4ivragK84zy3NX5q
         cWCnxEIIZlRl9B9Q9MfeBewcw4OgUmb6DfSy9SND7HLLmIQtCXRavTSuaEF66OwUzSmo
         SqHA==
X-Gm-Message-State: AOJu0Yz3i0Av8/YhFKhaL5PsWM9qFfk3ZrzkfbDm6sEOfYGd8BlA5ExM
        sdTELObpBJsY+gKy+eHGdHzFsFWP2WA=
X-Google-Smtp-Source: AGHT+IGhIxWgPMm8wqUw4hMJ5kHDs/Trl+Fudc3+UErv6dl9+e9FP4PNtTnJqgtywEwuz9/B7UU77w==
X-Received: by 2002:a05:620a:4552:b0:773:bf62:b274 with SMTP id u18-20020a05620a455200b00773bf62b274mr6163539qkp.61.1700053934734;
        Wed, 15 Nov 2023 05:12:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m11-20020a05620a290b00b007743382121esm3445056qkp.84.2023.11.15.05.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:12:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Nov 2023 05:12:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] hwmon: (aspeed-pwm-tacho) Fix
 -Wstringop-overflow warning in aspeed_create_fan_tach_channel()
Message-ID: <9ed5116f-cf36-49f6-833e-75eeab4570b4@roeck-us.net>
References: <ZVPQJIP26dIzRAr6@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVPQJIP26dIzRAr6@work>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 01:53:08PM -0600, Gustavo A. R. Silva wrote:
> Based on the documentation below, the maximum number of Fan tach
> channels is 16:
> 
> Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt:45:
>  45 - aspeed,fan-tach-ch : should specify the Fan tach input channel.
>  46                 integer value in the range 0 through 15, with 0 indicating
>  47                 Fan tach channel 0 and 15 indicating Fan tach channel 15.
>  48                 At least one Fan tach input channel is required.
> 
> However, the compiler doesn't know that, and legitimaly warns about a potential
> overwrite in array `u8 fan_tach_ch_source[16]` in `struct aspeed_pwm_tacho_data`,
> in case `index` takes a value outside the boundaries of the array:
> 

Still messes the point. This isn't about "the compiler doesn't know that",
it is a real bug which may result in out-of-bounds accesses.

Oh, never mind, I'll just apply it.

Guenter
